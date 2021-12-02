Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B06E465E04
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 06:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355636AbhLBGBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 01:01:47 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:36596 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355624AbhLBGBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 01:01:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uz8WVnW_1638424699;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Uz8WVnW_1638424699)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Dec 2021 13:58:20 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] scsi: initio: Fix missing memory allocation modifier
Date:   Thu,  2 Dec 2021 13:58:14 +0800
Message-Id: <1638424694-55470-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function initio_probe_one() allocates a DMA buffer without the
GFP_KERNEL modifier, fix this by using (GFP_KERNEL | GFP_DMA) instead of
only GFP_DMA as the probe happens in non-interrupt context.

At the same time, change the if statement to the more typical kernel
style.

Eliminate the follow smatch warning:
drivers/scsi/initio.c:2850 initio_probe_one() error: no modifiers for
allocation.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/scsi/initio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/initio.c b/drivers/scsi/initio.c
index 9cdee38..5982274 100644
--- a/drivers/scsi/initio.c
+++ b/drivers/scsi/initio.c
@@ -2847,7 +2847,8 @@ static int initio_probe_one(struct pci_dev *pdev,
 
 	for (; num_scb >= MAX_TARGETS + 3; num_scb--) {
 		i = num_scb * sizeof(struct scsi_ctrl_blk);
-		if ((scb = kzalloc(i, GFP_DMA)) != NULL)
+		scb = kzalloc(i, (GFP_KERNEL | GFP_DMA));
+		if (scb)
 			break;
 	}
 
-- 
1.8.3.1

