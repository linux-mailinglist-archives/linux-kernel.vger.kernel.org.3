Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB2C52FC0D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiEULe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348363AbiEULdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:33:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742462B26F;
        Sat, 21 May 2022 04:33:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 053FAB81DAC;
        Sat, 21 May 2022 11:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258BBC385B8;
        Sat, 21 May 2022 11:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653132800;
        bh=wm9pcMgVu3P9v6Y+m3D8sP6eIQtacSxLPWXGB9NFpp8=;
        h=From:To:Cc:Subject:Date:From;
        b=CzhjF1B4xqpFKPKPxoXUgMzfeNrtddFy65rt4d/zzd9aifRb3hCUFe+Nl61Gb3p45
         ZAZsVyGbEJj6g/xOflpWZzquwOiUf1obrMqDFb3tMP4Pl3haACPZXM5vJrb+0fa9TP
         Ako/SI9aGAvM5KVkF8dfNJSteWKHhZxlCdFG71lyiMtp9l6mGDjcEhS0MI6LWymd+m
         3YAe7+97Zv4ccESyDHfVBzdbZJGaiX5Mr1wlopld5OEuc9xK333O3oXGfD0j/yLTKK
         6t+9nv0INskWQVbDtL7YM7n84fI0kMxBNHW9lZcWWiPzR750urqZYO0eA62JqYDH22
         dXTiBYghMP/Pw==
From:   Chao Yu <chao@kernel.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        chao@kernel.org
Subject: [RFC PATCH] scsi: support packing multi-segment in UNMAP command
Date:   Sat, 21 May 2022 19:32:59 +0800
Message-Id: <20220521113259.3953757-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As SPEC describes that it can support unmapping one or more LBA range
in single UNMAP command, however, previously we only pack one LBA
range in UNMAP command by default no matter device gives the block
limits that says it can support in-batch UNMAP.

This patch tries to set max_discard_segments config according to block
limits of device, and supports in-batch UNMAP.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 drivers/scsi/sd.c | 30 +++++++++++++++++++-----------
 drivers/scsi/sd.h |  1 +
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index dc6e55761fd1..be070457c78d 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -790,6 +790,7 @@ static void sd_config_discard(struct scsi_disk *sdkp, unsigned int mode)
 	q->limits.discard_granularity =
 		max(sdkp->physical_block_size,
 		    sdkp->unmap_granularity * logical_block_size);
+	blk_queue_max_discard_segments(q, sdkp->max_block_desc_count);
 	sdkp->provisioning_mode = mode;
 
 	switch (mode) {
@@ -837,10 +838,10 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 {
 	struct scsi_device *sdp = cmd->device;
 	struct request *rq = scsi_cmd_to_rq(cmd);
+	struct bio *bio;
 	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
-	u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
-	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
-	unsigned int data_len = 24;
+	unsigned short segments = blk_rq_nr_discard_segments(rq);
+	unsigned int data_len = 8 + 16 * segments, i = 0;
 	char *buf;
 
 	rq->special_vec.bv_page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
@@ -853,13 +854,20 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 
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
+		put_unaligned_be64(lba, &buf[8 + 16 * i]);
+		put_unaligned_be32(nr_blocks, &buf[8 + 16 * i + 8]);
+		i++;
+	}
 
 	cmd->allowed = sdkp->max_retries;
 	cmd->transfersize = data_len;
@@ -2859,7 +2867,7 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 	sdkp->opt_xfer_blocks = get_unaligned_be32(&buffer[12]);
 
 	if (buffer[3] == 0x3c) {
-		unsigned int lba_count, desc_count;
+		unsigned int lba_count;
 
 		sdkp->max_ws_blocks = (u32)get_unaligned_be64(&buffer[36]);
 
@@ -2867,9 +2875,9 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 			goto out;
 
 		lba_count = get_unaligned_be32(&buffer[20]);
-		desc_count = get_unaligned_be32(&buffer[24]);
+		sdkp->max_block_desc_count = get_unaligned_be32(&buffer[24]);
 
-		if (lba_count && desc_count)
+		if (lba_count && sdkp->max_block_desc_count)
 			sdkp->max_unmap_blocks = lba_count;
 
 		sdkp->unmap_granularity = get_unaligned_be32(&buffer[28]);
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 0a33a4b68ffb..e396bcaf76ca 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -99,6 +99,7 @@ struct scsi_disk {
 	u32		opt_xfer_blocks;
 	u32		max_ws_blocks;
 	u32		max_unmap_blocks;
+	u32		max_block_desc_count;
 	u32		unmap_granularity;
 	u32		unmap_alignment;
 	u32		index;
-- 
2.25.1

