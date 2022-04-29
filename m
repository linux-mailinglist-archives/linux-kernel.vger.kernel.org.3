Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D456514F37
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378315AbiD2PZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241558AbiD2PZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:25:28 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABB5689A4;
        Fri, 29 Apr 2022 08:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1651245727;
  x=1682781727;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xenmPUOXW+RZJN9qBuvo/3MkIoPU8IrRSy9rcS8hUiY=;
  b=UeM6p+50yGpDPgGq8Xz9wtdT2t35h45DaXetIDo5DRLpncv3FHq3tOuC
   CKrcDvKDOJztYFB4LgvmE7cqwmxEwsLXzR6Jc/ogGiElGounW7+BPPjX/
   Ehz3EZiveGlf+R31BRHnaXwWtWVfJTFEpKJ2fV0ykUqDrkrpM2BiF6Cli
   VTnsHMHzPYUccOOr075dPHfxLywFL1vSU2wVbtqrkiYoSRNwT1Hk1Xog0
   V5XPBFqbWXBXs3xijrDaeKX9E6KyRwqK5AJE/87AOa3/LrXUHB1jqXJVf
   BjYVGK+V5QtvN519jgUR0iGFxPV8Pk86e2WW24Ocrrwc5d5Bg7cHy54bP
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <kernel@axis.com>, <linux-block@vger.kernel.org>, <tytso@mit.edu>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: core: support zeroout using TRIM
Date:   Fri, 29 Apr 2022 17:21:18 +0200
Message-ID: <20220429152118.3617303-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device supports TRIM and indicates that it erases to zeros, we
can use it to support hardware offloading of REQ_OP_WRITE_ZEROES.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
    https://lore.kernel.org/lkml/20160303182146.GG9772@thunk.org/ seems to agree
    that BLKZEROOUT can use TRIM on eMMC.
    
    BLKDISCARD uses DISCARD when available so it can't be used to send TRIM.
    
    If TRIM should not be used for BLKZEROOUT for some reason I guess the only way
    is to use MMC_IOC_MULTI_CMD like in this commit in mmc-utils but that's a
    rather low-level interface:
    
     https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git/commit/?id=43282e80e174cc73b09b81a4d17cb3a7b4dc5cfc

 drivers/mmc/core/block.c | 26 ++++++++++++++++++++++----
 drivers/mmc/core/queue.c |  2 ++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 506dc900f5c7..0398b205a285 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -126,6 +126,7 @@ struct mmc_blk_data {
 #define MMC_BLK_DISCARD		BIT(2)
 #define MMC_BLK_SECDISCARD	BIT(3)
 #define MMC_BLK_CQE_RECOVERY	BIT(4)
+#define MMC_BLK_TRIM		BIT(5)
 
 	/*
 	 * Only set in main mmc_blk_data associated
@@ -1090,12 +1091,13 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 	blk_mq_end_request(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
 }
 
-static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
+static void mmc_blk_issue_erase_rq(struct mmc_queue *mq, struct request *req,
+				   int type, unsigned int erase_arg)
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
 	unsigned int from, nr;
-	int err = 0, type = MMC_BLK_DISCARD;
+	int err = 0;
 	blk_status_t status = BLK_STS_OK;
 
 	if (!mmc_can_erase(card)) {
@@ -1111,13 +1113,13 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 		if (card->quirks & MMC_QUIRK_INAND_CMD38) {
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 INAND_CMD38_ARG_EXT_CSD,
-					 card->erase_arg == MMC_TRIM_ARG ?
+					 erase_arg == MMC_TRIM_ARG ?
 					 INAND_CMD38_ARG_TRIM :
 					 INAND_CMD38_ARG_ERASE,
 					 card->ext_csd.generic_cmd6_time);
 		}
 		if (!err)
-			err = mmc_erase(card, from, nr, card->erase_arg);
+			err = mmc_erase(card, from, nr, erase_arg);
 	} while (err == -EIO && !mmc_blk_reset(md, card->host, type));
 	if (err)
 		status = BLK_STS_IOERR;
@@ -1127,6 +1129,19 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 	blk_mq_end_request(req, status);
 }
 
+static void mmc_blk_issue_trim_rq(struct mmc_queue *mq, struct request *req)
+{
+	mmc_blk_issue_erase_rq(mq, req, MMC_BLK_TRIM, MMC_TRIM_ARG);
+}
+
+static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_blk_data *md = mq->blkdata;
+	struct mmc_card *card = md->queue.card;
+
+	mmc_blk_issue_erase_rq(mq, req, MMC_BLK_DISCARD, card->erase_arg);
+}
+
 static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 				       struct request *req)
 {
@@ -2327,6 +2342,9 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
 		case REQ_OP_SECURE_ERASE:
 			mmc_blk_issue_secdiscard_rq(mq, req);
 			break;
+		case REQ_OP_WRITE_ZEROES:
+			mmc_blk_issue_trim_rq(mq, req);
+			break;
 		case REQ_OP_FLUSH:
 			mmc_blk_issue_flush(mq, req);
 			break;
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index c69b2d9df6f1..bbe2ea829ea7 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -191,6 +191,8 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 		q->limits.discard_granularity = SECTOR_SIZE;
 	if (mmc_can_secure_erase_trim(card))
 		blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
+	if (mmc_can_trim(card) && card->erased_byte == 0)
+		blk_queue_max_write_zeroes_sectors(q, max_discard);
 }
 
 static unsigned short mmc_get_max_segments(struct mmc_host *host)
-- 
2.34.1

