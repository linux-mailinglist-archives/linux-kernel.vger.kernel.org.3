Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91D04E8BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 04:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbiC1CGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 22:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiC1CGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:06:46 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59943B7CA;
        Sun, 27 Mar 2022 19:05:06 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 28 Mar
 2022 10:05:05 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 28 Mar
 2022 10:05:04 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <brking@us.ibm.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] scsi: ipr: Directly return instead of using local ret variable
Date:   Mon, 28 Mar 2022 10:05:03 +0800
Message-ID: <1648433103-24308-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-125.meizu.com (172.16.1.125) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixes coccinelle warning:
./drivers/scsi/ipr.c:10095:13-15: Unneeded variable: "rc". Return
"IRQ_HANDLED" on line 10104

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/scsi/ipr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 104bee9..353cf47 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -10092,7 +10092,6 @@ static irqreturn_t ipr_test_intr(int irq, void *devp)
 {
 	struct ipr_ioa_cfg *ioa_cfg = (struct ipr_ioa_cfg *)devp;
 	unsigned long lock_flags = 0;
-	irqreturn_t rc = IRQ_HANDLED;
 
 	dev_info(&ioa_cfg->pdev->dev, "Received IRQ : %d\n", irq);
 	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
@@ -10101,7 +10100,7 @@ static irqreturn_t ipr_test_intr(int irq, void *devp)
 	wake_up(&ioa_cfg->msi_wait_q);
 
 	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
-	return rc;
+	return IRQ_HANDLED;
 }
 
 /**
-- 
2.7.4

