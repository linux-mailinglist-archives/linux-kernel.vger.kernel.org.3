Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D23C57D8C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiGVC6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiGVC6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:58:01 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCDA9972D4;
        Thu, 21 Jul 2022 19:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ArhNY
        5OqFwWsU46FFDOGPRYRyP4YqAKWuS/CNKRF9M0=; b=mZCb6tNB2tNgmBVuV9dwD
        sgbtYp1XeVS/wJVJzEs1Sn10+Y/d8NX6gV+3NOoJ/LrWsnpFRprajhUzMUSYl9tl
        jQQjocZjG42WTCfZYxj0smm1Bu7T6RAnqyID/cnAJS4djyI9DOKZheW44lqnGZ3K
        l9STlVHFZ3/9RLlNSCCjPQ=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp5 (Coremail) with SMTP id HdxpCgDHJNwHEtpiy097Pg--.16585S2;
        Fri, 22 Jul 2022 10:57:13 +0800 (CST)
From:   williamsukatube@163.com
To:     James.Bottomley@HansenPartnership.com, deller@gmx.de,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH] parisc: check the return value of ioremap() in lba_driver_probe()
Date:   Fri, 22 Jul 2022 10:57:09 +0800
Message-Id: <20220722025709.2924616-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgDHJNwHEtpiy097Pg--.16585S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWxJr1UuFyrCw47GF1xXwb_yoWDXFb_ua
        y8uFWSv3yruF1xtr47W3WxZFWjyF1kuF95Wa1Utas3Gr47WF1UKrs5ury5u348urn7Ga9r
        GrZ5XF1jvF42yjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5Wc_DUUUUU==
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/1tbiNxJGg1WBo2A1XQABse
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dean <williamsukatube@gmail.com>

The function ioremap() in lba_driver_probe() can fail, so
its return value should be checked.

Fixes: 4bdc0d676a643 ("remove ioremap_nocache and devm_ioremap_nocache")
Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: William Dean <williamsukatube@gmail.com>
---
 drivers/parisc/lba_pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index 732b516c7bf8..afc6e66ddc31 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -1476,9 +1476,13 @@ lba_driver_probe(struct parisc_device *dev)
 	u32 func_class;
 	void *tmp_obj;
 	char *version;
-	void __iomem *addr = ioremap(dev->hpa.start, 4096);
+	void __iomem *addr;
 	int max;
 
+	addr = ioremap(dev->hpa.start, 4096);
+	if (addr == NULL)
+		return -ENOMEM;
+
 	/* Read HW Rev First */
 	func_class = READ_REG32(addr + LBA_FCLASS);
 
-- 
2.25.1

