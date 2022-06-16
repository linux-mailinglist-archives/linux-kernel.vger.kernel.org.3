Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D8154D71F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356248AbiFPBg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243323AbiFPBg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:36:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675CC21E08;
        Wed, 15 Jun 2022 18:36:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C3BF9CE23E4;
        Thu, 16 Jun 2022 01:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87FEC3411A;
        Thu, 16 Jun 2022 01:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655343384;
        bh=0eEyDqWuRe8MsiL/MntwKceuSKqyojnXbxruqir2b/I=;
        h=From:To:Cc:Subject:Date:From;
        b=TnLbX+y6CHfl+yJv6Ir9GrZUWeEv+nMNSdzT9JCUY1z+iyiE59fZEv1AlC7/o40UK
         Q6u790wtsqsdIzuTilO+obMEIHTwucdmzt/fwzKipisnTUNQUsoGNhMfC6tHm96OyU
         fls883PLaT7HFaHBbmd2mYgzAnnZh8/7lEzSgJ6lzrhiDD9By8R5DmDNe1yMqM8a4f
         P9uQHBvWrf1U1VR5M+esQqoC5+fmNQ6Lwephyf4jDoSuemdLt/6pXDA1bGAUWN+tGE
         yF+0yqNPMQfldx2OJJcQfe2SI97MqyzlG9xVdjkfrvK15C+L+KQuH2ARqa5ihyrHPq
         ja+ki3y2YMZDg==
From:   Chao Yu <chao@kernel.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        chao@kernel.org, hch@infradead.org, bvanassche@acm.org
Subject: [PATCH v4] scsi: support packing multi-segment in UNMAP command
Date:   Thu, 16 Jun 2022 09:36:17 +0800
Message-Id: <20220616013617.2284341-1-chao@kernel.org>
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
support unmapping one or more LBA range in single UNMAP command.

However, previously we only pack one LBA range in UNMAP command
by default no matter device gives the block limits that says it
can support unmapping multiple LBA ranges with a single UNMAP
command.

This patch sets max_discard_segments config according to block
limits of device, and supports unmapping multiple LBA ranges with
a single UNMAP command.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v4:
- clean up commit message.
- fix to avoid truncating .max_unmap_block_desc_count during type cast.
- add comments and clean up codes.

 drivers/scsi/sd.c | 35 ++++++++++++++++++++++++-----------
 drivers/scsi/sd.h |  1 +
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 895b56c8f25e..114f61c3ccd3 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -790,6 +790,8 @@ static void sd_config_discard(struct scsi_disk *sdkp, unsigned int mode)
 	q->limits.discard_granularity =
 		max(sdkp->physical_block_size,
 		    sdkp->unmap_granularity * logical_block_size);
+	blk_queue_max_discard_segments(q, min_t(u32, U16_MAX,
+				sdkp->max_unmap_block_desc_count));
 	sdkp->provisioning_mode = mode;
 
 	switch (mode) {
@@ -836,9 +838,10 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 	struct scsi_device *sdp = cmd->device;
 	struct request *rq = scsi_cmd_to_rq(cmd);
 	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
-	u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
-	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
-	unsigned int data_len = 24;
+	unsigned short segments = blk_rq_nr_discard_segments(rq);
+	unsigned int data_len = 8 + 16 * segments;
+	unsigned int descriptor_offset = 8;
+	struct bio *bio;
 	char *buf;
 
 	rq->special_vec.bv_page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
@@ -851,13 +854,20 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 
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
+		put_unaligned_be64(lba, &buf[descriptor_offset]);
+		put_unaligned_be32(nr_blocks, &buf[descriptor_offset + 8]);
+		descriptor_offset += 16;
+	}
 
 	cmd->allowed = sdkp->max_retries;
 	cmd->transfersize = data_len;
@@ -2862,7 +2872,7 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 	sdkp->opt_xfer_blocks = get_unaligned_be32(&vpd->data[12]);
 
 	if (vpd->len >= 64) {
-		unsigned int lba_count, desc_count;
+		unsigned int lba_count;
 
 		sdkp->max_ws_blocks = (u32)get_unaligned_be64(&vpd->data[36]);
 
@@ -2870,9 +2880,12 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 			goto out;
 
 		lba_count = get_unaligned_be32(&vpd->data[20]);
-		desc_count = get_unaligned_be32(&vpd->data[24]);
 
-		if (lba_count && desc_count)
+		/* Extract the MAXIMUM UNMAP BLOCK DESCRIPTOR COUNT. */
+		sdkp->max_unmap_block_desc_count =
+					get_unaligned_be32(&vpd->data[24]);
+
+		if (lba_count && sdkp->max_unmap_block_desc_count)
 			sdkp->max_unmap_blocks = lba_count;
 
 		sdkp->unmap_granularity = get_unaligned_be32(&vpd->data[28]);
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 5eea762f84d1..e7c51d23395b 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -119,6 +119,7 @@ struct scsi_disk {
 	u32		opt_xfer_blocks;
 	u32		max_ws_blocks;
 	u32		max_unmap_blocks;
+	u32		max_unmap_block_desc_count;
 	u32		unmap_granularity;
 	u32		unmap_alignment;
 	u32		index;
-- 
2.25.1

