Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AE357BD82
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbiGTSOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238448AbiGTSOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:14:01 -0400
Received: from smtp.smtpout.orange.fr (smtp-12.smtpout.orange.fr [80.12.242.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248F465D4A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:13:59 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id EECpoJI9YvbzbEECpo9R0Y; Wed, 20 Jul 2022 20:13:57 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 20 Jul 2022 20:13:57 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        storagedev@microchip.com, linux-scsi@vger.kernel.org
Subject: [PATCH 1/2] scsi: hpsa: Use the bitmap API to allocate bitmaps
Date:   Wed, 20 Jul 2022 20:13:54 +0200
Message-Id: <5f975ef43f8b7306e4ac4e2e8ce4bcd53f6092bb.1658340441.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/hpsa.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index a47bcce3c9c7..0612ca681200 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -8030,7 +8030,7 @@ static int hpsa_init_reset_devices(struct pci_dev *pdev, u32 board_id)
 
 static void hpsa_free_cmd_pool(struct ctlr_info *h)
 {
-	kfree(h->cmd_pool_bits);
+	bitmap_free(h->cmd_pool_bits);
 	h->cmd_pool_bits = NULL;
 	if (h->cmd_pool) {
 		dma_free_coherent(&h->pdev->dev,
@@ -8052,9 +8052,7 @@ static void hpsa_free_cmd_pool(struct ctlr_info *h)
 
 static int hpsa_alloc_cmd_pool(struct ctlr_info *h)
 {
-	h->cmd_pool_bits = kcalloc(DIV_ROUND_UP(h->nr_cmds, BITS_PER_LONG),
-				   sizeof(unsigned long),
-				   GFP_KERNEL);
+	h->cmd_pool_bits = bitmap_zalloc(h->nr_cmds, GFP_KERNEL);
 	h->cmd_pool = dma_alloc_coherent(&h->pdev->dev,
 		    h->nr_cmds * sizeof(*h->cmd_pool),
 		    &h->cmd_pool_dhandle, GFP_KERNEL);
-- 
2.34.1

