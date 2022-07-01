Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CE056339A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbiGAMnT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Jul 2022 08:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiGAMnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:43:16 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2993515815;
        Fri,  1 Jul 2022 05:43:12 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 91FA74637B4;
        Fri,  1 Jul 2022 14:43:10 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 7D29146379B;
        Fri,  1 Jul 2022 14:43:10 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Fri,  1 Jul 2022 14:43:10 +0200 (CEST)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 1 Jul 2022
 14:43:09 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.1118.009; Fri, 1 Jul 2022 14:43:09 +0200
From:   Christian Loehle <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: [PATCHv4] mmc: block: Add single read for 4k sector cards
Thread-Topic: [PATCHv4] mmc: block: Add single read for 4k sector cards
Thread-Index: AdiNR/jT23QFNORJQg2DejtQ3jiaLg==
Date:   Fri, 1 Jul 2022 12:43:09 +0000
Message-ID: <cf4f316274c5474586d0d99b17db4a4c@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.44]
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-26988.007
X-TMASE-Result: 10-0.824300-10.000000
X-TMASE-MatchedRID: /+von0vPuFHzXojwcywrzPCW/PNRRp/ZG24YVeuZGmPozDhGeQC9Er8F
        Hrw7frluf146W0iUu2tacZzTSiX0+bWfqrMzDJSXzYK5U+QI3O5Hyz3bB5kG52fIvzHS0qU71Ie
        ckOrbKExvzxvIxmtIpxi87IOQ/i43K6km+od/UDyF0P4btTlf9CiBpCFE00S+myiLZetSf8l9j2
        GwzTE3vSq2rl3dzGQ1hulHfs6y0cOnmJeDoRl3775HPFkfeQiVIAi6edlDKRQN183KN6gDuw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 533ae5f9-207b-4b6d-8b7f-787cd60d7933-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cards with 4k native sector size may only be read 4k-aligned,
accommodate for this in the single read recovery and use it.

Fixes: 81196976ed946 (mmc: block: Add blk-mq support)
Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/block.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f4a1281658db..912a398a9a76 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -176,7 +176,7 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 				      unsigned int part_type);
 static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			       struct mmc_card *card,
-			       int disable_multi,
+			       int recovery_mode,
 			       struct mmc_queue *mq);
 static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
 
@@ -1302,7 +1302,7 @@ static void mmc_blk_eval_resp_error(struct mmc_blk_request *brq)
 }
 
 static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
-			      int disable_multi, bool *do_rel_wr_p,
+			      int recovery_mode, bool *do_rel_wr_p,
 			      bool *do_data_tag_p)
 {
 	struct mmc_blk_data *md = mq->blkdata;
@@ -1368,12 +1368,12 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 			brq->data.blocks--;
 
 		/*
-		 * After a read error, we redo the request one sector
+		 * After a read error, we redo the request one (native) sector
 		 * at a time in order to accurately determine which
 		 * sectors can be read successfully.
 		 */
-		if (disable_multi)
-			brq->data.blocks = 1;
+		if (recovery_mode)
+			brq->data.blocks = queue_physical_block_size(mq->queue) >> 9;
 
 		/*
 		 * Some controllers have HW issues while operating
@@ -1590,7 +1590,7 @@ static int mmc_blk_cqe_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 
 static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			       struct mmc_card *card,
-			       int disable_multi,
+			       int recovery_mode,
 			       struct mmc_queue *mq)
 {
 	u32 readcmd, writecmd;
@@ -1599,7 +1599,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	struct mmc_blk_data *md = mq->blkdata;
 	bool do_rel_wr, do_data_tag;
 
-	mmc_blk_data_prep(mq, mqrq, disable_multi, &do_rel_wr, &do_data_tag);
+	mmc_blk_data_prep(mq, mqrq, recovery_mode, &do_rel_wr, &do_data_tag);
 
 	brq->mrq.cmd = &brq->cmd;
 
@@ -1690,7 +1690,7 @@ static int mmc_blk_fix_state(struct mmc_card *card, struct request *req)
 
 #define MMC_READ_SINGLE_RETRIES	2
 
-/* Single sector read during recovery */
+/* Single (native) sector read during recovery */
 static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
@@ -1698,6 +1698,7 @@ static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
 	struct mmc_card *card = mq->card;
 	struct mmc_host *host = card->host;
 	blk_status_t error = BLK_STS_OK;
+	size_t bytes_per_read = queue_physical_block_size(mq->queue);
 
 	do {
 		u32 status;
@@ -1732,13 +1733,13 @@ static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
 		else
 			error = BLK_STS_OK;
 
-	} while (blk_update_request(req, error, 512));
+	} while (blk_update_request(req, error, bytes_per_read));
 
 	return;
 
 error_exit:
 	mrq->data->bytes_xfered = 0;
-	blk_update_request(req, BLK_STS_IOERR, 512);
+	blk_update_request(req, BLK_STS_IOERR, bytes_per_read);
 	/* Let it try the remaining request again */
 	if (mqrq->retries > MMC_MAX_RETRIES - 1)
 		mqrq->retries = MMC_MAX_RETRIES - 1;
@@ -1879,10 +1880,9 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
 		return;
 	}
 
-	/* FIXME: Missing single sector read for large sector size */
-	if (!mmc_large_sector(card) && rq_data_dir(req) == READ &&
-	    brq->data.blocks > 1) {
-		/* Read one sector at a time */
+	if (rq_data_dir(req) == READ && brq->data.blocks >
+			queue_physical_block_size(mq->queue) >> 9) {
+		/* Read one (native) sector at a time */
 		mmc_blk_read_single(mq, req);
 		return;
 	}
-- 
2.36.1

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

