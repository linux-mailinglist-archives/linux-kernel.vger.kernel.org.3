Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D01C55901F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 06:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiFXEmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 00:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiFXEmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 00:42:03 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18CA453A7B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 21:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=krvw6
        qwr/IZNtIPW1oz/T//NVChJsEDf0J7wBQxN9uo=; b=ebJGrZhdAsXasw8yharlD
        ly2oEcnlOkRpN6QqpmlUNt4Kw9GWFJiaNhWJQp5qP0+hs8YElWjP+cdA8i+qtGfV
        rNrPoz320+ZYcIUzM9P9U6DaK/7I1FXjaChZ5hvgLjnHaWmtcoSihOaPxDMBbw6H
        3ghSWbN3A6ZRvTA+lo/pRU=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp2 (Coremail) with SMTP id GtxpCgBH0_V+QLViGS0oLg--.244S4;
        Fri, 24 Jun 2022 12:41:39 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] =?UTF-8?q?=EF=BB=BFdax:=20Fix=20potential=20uaf=20in=20?= =?UTF-8?q?=5F=5Fdax=5Fpmem=5Fprobe()?=
Date:   Fri, 24 Jun 2022 12:41:32 +0800
Message-Id: <20220624044132.1806646-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgBH0_V+QLViGS0oLg--.244S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFykXrWktw4rKw18CFyxAFb_yoW8ZF18p3
        y5XFyUurWDAr1Uur43Aws3uFyrZa1ktw4rCr4xuw47u345Z34xA3y8Xa4jya47K3yxAr1U
        X3Wjqw1xu3y7uF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRha9hUUUUU=
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbi6wMqjFXl2OlyhAAAs5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__dax_pmem_probe() allocates a memory chunk from dax_region with
alloc_dax_region(). alloc_dax_region() increases the refcount for
dax_region and uses devm_add_action_or_reset() to make the parent
dev manage the dax_region. The dax_region will be used if the parent
dev is destroyed.

Then the function calls devm_create_dev_dax() to make child dev_dax
instances own the lifetime of the dax_region. devm_create_dev_dax()
calls devm_add_action_or_reset(dax_region->dev, unregister_dev_dax, dev);
to make the child dev_dax manage the dax_region and register the destroy
function "unregister_dev_dax".The devm_create_dev_dax() increases the
refcount for dax_region when the function is successfully executed. But
when some error occurs, devm_create_dev_dax() may return ERR_PTR before
increasing the refcount for dax_region. In these cases, the call for
dax_region_put() will decrease the ref count for dax_region and trigger
dax_region_free(), which will execute kfree(dax_region).

When the parent dev is destroyed, the registered destroy function
"unregister_dev_dax" will be triggered and calls dax_region_free(), which
will use the freed dax_region, leading to a use after free bug.

We should check the return value of devm_create_dev_dax(). If it returns
ERR_PTR, we should return this function with ERR_PTR.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/dax/pmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index f050ea78bb83..d5c8bd546ee9 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -66,6 +66,8 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
 		.size = range_len(&range),
 	};
 	dev_dax = devm_create_dev_dax(&data);
+	if (IS_ERR(dev_dax))
+		return ERR_PTR((dev_dax);
 
 	/* child dev_dax instances now own the lifetime of the dax_region */
 	dax_region_put(dax_region);
-- 
2.25.1

