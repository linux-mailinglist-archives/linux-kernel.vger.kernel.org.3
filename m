Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C568E54D8F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350614AbiFPDgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbiFPDgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:36:40 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05DFC42493;
        Wed, 15 Jun 2022 20:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=aAQ15
        C2T4MqklkCImE6KXD8zXPltOOPyY05PqikacZI=; b=O74FWCrgxdUj6ibqlh73k
        93IQfLIYUcO8s3GPWkFEekXoP9jZ/nLeFUxwHsfS5r6HxheP6mSmELkLzyyLlOPe
        3JlzAMKt81mrd3FJ6nCg44erU+qQ2wOv6Xn67dcZSlhQAnBb3qIPmCaf1LBXsDg4
        lpijd3/HJlMvdKFysYvU1o=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgDHRnM4papi4InkFg--.25946S2;
        Thu, 16 Jun 2022 11:36:26 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, windhl@126.com
Subject: [PATCH v2] clk: tegra: (clk-tegra30) Add missing of_node_put()
Date:   Thu, 16 Jun 2022 11:36:22 +0800
Message-Id: <20220616033622.3975621-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgDHRnM4papi4InkFg--.25946S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFW3GryrZw1kur4kGFWUCFg_yoW3Zrb_X3
        45XFy7Xw45KFs5CFs8uF43ZryIvFn5WrnYqFWIyw47G3W8Zr4UJr4qvrn7C3s7X39FqFW7
        GrWkGr4fCrZxAjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRGhF2DUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizhoiF18RPTWCrwAAsK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tegra30_clock_init, of_find_matching_node() will return a node
pointer with refcount incremented. We should use of_node_put() when
the node pointer is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

 v2: use real name for Sob
 v1: fix missing bug

 drivers/clk/tegra/clk-tegra30.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 04b496123820..168c07d5a5f2 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1320,6 +1320,7 @@ static void __init tegra30_clock_init(struct device_node *np)
 	}
 
 	pmc_base = of_iomap(node, 0);
+	of_node_put(node);
 	if (!pmc_base) {
 		pr_err("Can't map pmc registers\n");
 		BUG();
-- 
2.25.1

