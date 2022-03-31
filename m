Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BB24ED1AA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbiCaCZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiCaCZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:25:51 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D6D6663B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:24:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yaohongbo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V8ghHu-_1648693432;
Received: from localhost(mailfrom:yaohongbo@linux.alibaba.com fp:SMTPD_---0V8ghHu-_1648693432)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Mar 2022 10:24:00 +0800
From:   Yao Hongbo <yaohongbo@linux.alibaba.com>
To:     mst@redhat.com, gregkh@linuxfoundation.org
Cc:     yaohongbo@linux.alibaba.com, linux-kernel@vger.kernel.org,
        alikernel-developer@linux.alibaba.com
Subject: [PATCH RESEND] uio/uio_pci_generic: Introduce refcnt on open/release
Date:   Thu, 31 Mar 2022 10:23:52 +0800
Message-Id: <1648693432-129409-1-git-send-email-yaohongbo@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If two userspace programs both open the PCI UIO fd, when one
of the program exits uncleanly, the other will cause IO hang
due to bus-mastering disabled.

It's a common usage for spdk/dpdk to use UIO. So, introduce refcnt
to avoid such problems.

Fixes: 865a11f("uio/uio_pci_generic: Disable bus-mastering on release")
Reported-by: Xiu Yang <yangxiu.yx@alibaba-inc.com>
Signed-off-by: Yao Hongbo <yaohongbo@linux.alibaba.com>
---
 drivers/uio/uio_pci_generic.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/uio/uio_pci_generic.c b/drivers/uio/uio_pci_generic.c
index e03f9b5..8add2cf 100644
--- a/drivers/uio/uio_pci_generic.c
+++ b/drivers/uio/uio_pci_generic.c
@@ -31,6 +31,7 @@
 struct uio_pci_generic_dev {
 	struct uio_info info;
 	struct pci_dev *pdev;
+	atomic_t refcnt;
 };
 
 static inline struct uio_pci_generic_dev *
@@ -39,6 +40,14 @@ struct uio_pci_generic_dev {
 	return container_of(info, struct uio_pci_generic_dev, info);
 }
 
+static int open(struct uio_info *info, struct inode *inode)
+{
+	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
+
+	atomic_inc(&gdev->refcnt);
+	return 0;
+}
+
 static int release(struct uio_info *info, struct inode *inode)
 {
 	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
@@ -51,7 +60,9 @@ static int release(struct uio_info *info, struct inode *inode)
 	 * Note that there's a non-zero chance doing this will wedge the device
 	 * at least until reset.
 	 */
-	pci_clear_master(gdev->pdev);
+	if (atomic_dec_and_test(&gdev->refcnt))
+		pci_clear_master(gdev->pdev);
+
 	return 0;
 }
 
@@ -92,8 +103,11 @@ static int probe(struct pci_dev *pdev,
 
 	gdev->info.name = "uio_pci_generic";
 	gdev->info.version = DRIVER_VERSION;
+	gdev->info.open = open;
 	gdev->info.release = release;
 	gdev->pdev = pdev;
+	atomic_set(&gdev->refcnt, 0);
+
 	if (pdev->irq && (pdev->irq != IRQ_NOTCONNECTED)) {
 		gdev->info.irq = pdev->irq;
 		gdev->info.irq_flags = IRQF_SHARED;
-- 
1.8.3.1

