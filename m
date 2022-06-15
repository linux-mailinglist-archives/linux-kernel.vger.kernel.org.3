Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F52554CD16
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349437AbiFOPeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348953AbiFOPeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:34:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F166F240AC;
        Wed, 15 Jun 2022 08:34:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 897066177F;
        Wed, 15 Jun 2022 15:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DDDC3411E;
        Wed, 15 Jun 2022 15:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655307248;
        bh=z9LrTbvvJ5Eymb0jlmwcsw1/gttmexAT5SOlw8klJDw=;
        h=From:To:Cc:Subject:Date:From;
        b=demf7YwIokMBz2NXpw3lFImGtf9FPJzSCkzAcSCXdo9Z/7iQXDqTj130sUHFvTU4Q
         c51lA0GBaIamuWSSKuAECiRfIDrEv0+PRYZfOXdFteAf+HAGN8qypyhJSt3gq/bXai
         dsKWZN5Nn8QbOwT8pJ05xPIsJggeyP3jM386Hom+mBXuuY4y4ESlIORfbIarsEji1m
         3GLQjLKMqFaDe0eBtE/HCkO0t3GFyy/D2SjSEWswv+2izGkJIz2jTMjs2A4SQ77313
         UXK81SYPRWVEDFTJQb6oZx4qeMSV89YtZY741hRlbhQ2CvyyFoO+HjKNlw+aTCgUz1
         sEJPeDoTJm7OA==
From:   Chao Yu <chao@kernel.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        chao@kernel.org
Subject: [PATCH v3] scsi: support packing multi-segment in UNMAP command
Date:   Wed, 15 Jun 2022 23:34:02 +0800
Message-Id: <20220615153402.2233825-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As SCSI SBC4 specification section 5.30.2 describes that it can
support unmapping one or more LBA range in single UNMAP command,
however, previously we only pack one LBA range in UNMAP command
by default no matter device gives the block limits that says it
can support in-batch UNMAP.

This patch tries to set max_discard_segments config according to
block limits of device, and supports in-batch UNMAP.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- update commit message.
- clean up codes.
 drivers/scsi/sd.c | 31 ++++++++++++++++++++-----------
 drivers/scsi/sd.h |  1 +
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 895b56c8f25e..ab543f027640 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -790,6 +790,7 @@ static void sd_config_discard(struct scsi_disk *sdkp, unsigned int mode)
 	q->limits.discard_granularity =
 		max(sdkp->physical_block_size,
 		    sdkp->unmap_granularity * logical_block_size);
+	blk_queue_max_discard_segments(q, sdkp->max_block_desc_count);
 	sdkp->provisioning_mode = mode;
 
 	switch (mode) {
@@ -836,9 +837,10 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 	struct scsi_device *sdp = cmd->device;
 	struct request *rq = scsi_cmd_to_rq(cmd);
 	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
-	u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
-	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
-	unsigned int data_len = 24;
+	unsigned short segments = blk_rq_nr_discard_segments(rq);
+	unsigned int data_len = 8 + 16 * segments;
+	unsigned int data_offset = 8;
+	struct bio *bio;
 	char *buf;
 
 	rq->special_vec.bv_page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
@@ -851,13 +853,20 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 
 	cmd->cmd_len = 10;
 	cmd->cmnd[0] = UNMAP;
-	cmd->cmnd[8] = 24;
+	cmd->cmnd[8] = data_len;
 
 	buf = bvec_virt(&rq->special_vec);
-	put_unaligned_be16(6 + 16, &buf[0]);
-	put_unaligned_be16(16, &buf[2]);
-	put_unaligned_be64(lba, &buf[8]);
-	put_unaligned_be32(nr_blocks, &buf[16]);
+	put_unaligned_be16(6 + 16 * segments, &buf[0]);
+	put_unaligned_be16(16 * segments, &buf[2]);
+
+	__rq_for_each_bio(bio, rq) {
+		u64 lba = sectors_to_logical(sdp, bio->bi_iter.bi_sector);
+		u32 nr_blocks = sectors_to_logical(sdp, bio_sectors(bio));
+
+		put_unaligned_be64(lba, &buf[data_offset]);
+		put_unaligned_be32(nr_blocks, &buf[data_offset + 8]);
+		data_offset += 16;
+	}
 
 	cmd->allowed = sdkp->max_retries;
 	cmd->transfersize = data_len;
@@ -2862,7 +2871,7 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 	sdkp->opt_xfer_blocks = get_unaligned_be32(&vpd->data[12]);
 
 	if (vpd->len >= 64) {
-		unsigned int lba_count, desc_count;
+		unsigned int lba_count;
 
 		sdkp->max_ws_blocks = (u32)get_unaligned_be64(&vpd->data[36]);
 
@@ -2870,9 +2879,9 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 			goto out;
 
 		lba_count = get_unaligned_be32(&vpd->data[20]);
-		desc_count = get_unaligned_be32(&vpd->data[24]);
+		sdkp->max_block_desc_count = get_unaligned_be32(&vpd->data[24]);
 
-		if (lba_count && desc_count)
+		if (lba_count && sdkp->max_block_desc_count)
 			sdkp->max_unmap_blocks = lba_count;
 
 		sdkp->unmap_granularity = get_unaligned_be32(&vpd->data[28]);
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 5eea762f84d1..bda9db5e2322 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -119,6 +119,7 @@ struct scsi_disk {
 	u32		opt_xfer_blocks;
 	u32		max_ws_blocks;
 	u32		max_unmap_blocks;
+	u32		max_block_desc_count;
 	u32		unmap_granularity;
 	u32		unmap_alignment;
 	u32		index;
-- 
2.25.1

