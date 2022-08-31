Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E32F5A8265
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiHaPyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiHaPy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:54:27 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5F1B6D30;
        Wed, 31 Aug 2022 08:54:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VNrdoG0_1661961242;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VNrdoG0_1661961242)
          by smtp.aliyun-inc.com;
          Wed, 31 Aug 2022 23:54:21 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     xiaoguang.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [RFC PATCH V2 4/6] ublk_drv: requeue rqs with recovery feature enabled
Date:   Wed, 31 Aug 2022 23:51:34 +0800
Message-Id: <20220831155136.23434-5-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220831155136.23434-1-ZiyangZhang@linux.alibaba.com>
References: <20220831155136.23434-1-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With recovery feature enabled, in ublk_queue_rq or task work
(in exit_task_work or fallback wq), we requeue rqs instead of
ending(aborting) them.

No matter recovery feature is enabled or disabled, schedule monitor work
immediately after detecting a crash so it can find out the crash and
do aborting/recovery mechanism.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0c3d32e8d686..296b9d80f003 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -690,7 +690,16 @@ static inline void __ublk_rq_task_work(struct request *req)
 	 * (2) current->flags & PF_EXITING.
 	 */
 	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {
-		blk_mq_end_request(req, BLK_STS_IOERR);
+		pr_devel("%s: %s q_id %d tag %d io_flags %x.\n", __func__,
+				(ublk_can_use_recovery(ub)) ? "requeue" : "abort",
+				ubq->q_id, req->tag, io->flags);
+
+		if (ublk_can_use_recovery(ub)) {
+			/* We cannot process this req so just requeue it. */
+			blk_mq_requeue_request(req, false);
+		} else {
+			blk_mq_end_request(req, BLK_STS_IOERR);
+		}
 		mod_delayed_work(system_wq, &ub->monitor_work, 0);
 		return;
 	}
@@ -770,6 +779,7 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 {
 	struct ublk_queue *ubq = hctx->driver_data;
 	struct request *rq = bd->rq;
+	struct ublk_io *io = &ubq->ios[rq->tag];
 	blk_status_t res;
 
 	/* fill iod to slot in io cmd buffer */
@@ -781,8 +791,18 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	if (unlikely(ubq_daemon_is_dying(ubq))) {
  fail:
+		pr_devel("%s: %s q_id %d tag %d io_flags %x.\n", __func__,
+				(ublk_can_use_recovery(ubq->dev)) ? "requeue" : "abort",
+				ubq->q_id, rq->tag, io->flags);
+
 		mod_delayed_work(system_wq, &ubq->dev->monitor_work, 0);
-		return BLK_STS_IOERR;
+		if (ublk_can_use_recovery(ubq->dev)) {
+			/* We cannot process this rq so just requeue it. */
+			blk_mq_requeue_request(rq, false);
+			return BLK_STS_OK;
+		} else {
+			return BLK_STS_IOERR;
+		}
 	}
 
 	if (ublk_can_use_task_work(ubq)) {
@@ -793,7 +813,6 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 		if (task_work_add(ubq->ubq_daemon, &data->work, notify_mode))
 			goto fail;
 	} else {
-		struct ublk_io *io = &ubq->ios[rq->tag];
 		struct io_uring_cmd *cmd = io->cmd;
 		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 
-- 
2.27.0

