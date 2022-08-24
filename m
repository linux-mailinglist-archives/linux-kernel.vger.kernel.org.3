Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D867D59F32F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 07:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiHXFtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 01:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiHXFtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:49:11 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414B5861CD;
        Tue, 23 Aug 2022 22:49:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VN5zTfX_1661320136;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VN5zTfX_1661320136)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 13:48:56 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     xiaoguang.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [RFC PATCH 8/9] ublk_drv: add START_USER_RECOVERY and END_USER_RECOVERY support
Date:   Wed, 24 Aug 2022 13:47:43 +0800
Message-Id: <20220824054744.77812-9-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220824054744.77812-1-ZiyangZhang@linux.alibaba.com>
References: <20220824054744.77812-1-ZiyangZhang@linux.alibaba.com>
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

START_USER_RECOVERY and END_USER_RECOVERY are two new control commands
to support user recovery feature.

After a crash, user should send START_USER_RECOVERY, it will:
(1) check current ublk_device state and make sure all ubq_daemons are
    dying. We always expect crash of the ublksrv 'process', not exit of
	a single ubq_daemon 'thread'.
(2) quiesce the request queue so here is no incoming ublk_queue_rq().
(3) reinit all ubqs, including:
    (a) put the dying task(thread).
    (b) requeue/abort(depends on user's setting, some backends can
        tolerate double writes) rqs issued to ublksrv before crash.
    (c) requeue rqs dispatched after crash.
    (d) complete ioucmds on tags not used.
(4) convert state to UBLK_S_DEV_RECOVERING and reset ub->mm to NULL.

Then, user should start a new 'process' and send FETCH_REQ on each
ubq_daemon.

After a crash, user should send END_USER_RECOVERY, it will:
(1) wait for all new ubq_daemons getting ready.
(2) unquiesce the request queue and expect incoming ublk_queue_rq()
(2) convert state to UBLK_S_DEV_LIVE

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 197 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0ee871fa3f92..ccaf3761de74 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1796,6 +1796,197 @@ static int ublk_ctrl_set_params(struct io_uring_cmd *cmd)
 	return ret;
 }
 
+/*
+ * reinit a ubq with a dying ubq_daemon for recovery. It must be called after ub is quiesced.
+ */
+static bool ublk_recover_rq(struct request *rq, void *data)
+{
+	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
+	struct ublk_device *ub = ubq->dev;
+	struct ublk_io *io = &ubq->ios[rq->tag];
+
+	/* The request has been sent to ublksrv, and it is inflight. */
+	if (!(io->flags & UBLK_IO_FLAG_ACTIVE)) {
+		pr_devel("%s: req has sent to ublksrv, %s it: qid %d tag %d io_flags %x\n",
+				__func__,
+				ublk_can_use_recovery_reissue(ub) ? "requeue" : "abort",
+				ubq->q_id, rq->tag, io->flags);
+		/* requeue rq but never call ublk_queue_rq() until the queue is unquiesced.*/
+		if (ublk_can_use_recovery_reissue(ub)) {
+			blk_mq_requeue_request(rq, false);
+			blk_mq_delay_kick_requeue_list(rq->q,
+					UBLK_REQUEUE_DELAY_MS);
+		/* abort this req */
+		} else {
+			/*
+			 * Laterly, rq may be issued again but ublk_queue_rq()
+			 * cannot be called until we unquiesce the queue.
+			 */
+			blk_mq_end_request(rq, BLK_STS_IOERR);
+		}
+		/*
+		 * The request has not been sent to ublksrv, but it is inflight. So:
+		 *
+		 * (1) corresponding ublk_queue_rq() call happens after ubq_daemon is dying.
+		 *
+		 * (2) exit_task_work() runs task_work after ubq_daemon is dying; or
+		 *
+		 * (3) io_uring fallback_work is running in workqueue after ubq_daemon is dying.
+		 *
+		 * Therefore, we simply requeue the request.
+		 *
+		 * Note:
+		 * (1) We do not io_uring_cmd_done() the old ioucmd here because (2) or (3)
+		 *     described above can do this.
+		 *
+		 * (2) We are safe to requeue rq since (2) or (3) only touches ioucmd(passed as
+		 *     an argument) first. Then they may detect that ubq_daemon is dying, return
+		 *     in advance and never touch rq(struct request), so no race on rq.
+		 *
+		 * (3) We requeue rq but ublk_queue_rq() is not called until the queue is
+		 *     unquiesced.
+		 */
+	} else {
+		pr_devel("%s: requeue req: qid %d tag %d io_flags %x\n",
+				__func__, ubq->q_id, rq->tag, io->flags);
+		blk_mq_requeue_request(rq, false);
+		blk_mq_delay_kick_requeue_list(rq->q,
+				UBLK_REQUEUE_DELAY_MS);
+	}
+
+	/* forget everything now and be ready for new FETCH_REQ */
+	io->flags = 0;
+	io->cmd = NULL;
+	io->addr = 0;
+	ubq->nr_io_ready--;
+	return true;
+}
+
+static int ublk_ctrl_start_recovery(struct io_uring_cmd *cmd)
+{
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	struct ublk_device *ub;
+	int ret = -EINVAL;
+	int i, j;
+
+	ub = ublk_get_device_from_id(header->dev_id);
+	if (!ub)
+		return ret;
+
+	mutex_lock(&ub->mutex);
+
+	if (!ublk_can_use_recovery(ub))
+		goto out_unlock;
+
+	if (ub->dev_info.state != UBLK_S_DEV_LIVE) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	/* Recovery feature is for 'process' crash, so all ubq_daemon should be PF_EXITING */
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		if (!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)))
+			goto out_unlock;
+	}
+
+	blk_mq_quiesce_queue(ub->ub_disk->queue);
+	pr_devel("%s: queue quiesced.\n", __func__);
+	ub->dev_info.state = UBLK_S_DEV_RECOVERING;
+	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
+	ub->mm = NULL;
+	init_completion(&ub->completion);
+
+	blk_mq_tagset_busy_iter(&ub->tag_set, ublk_recover_rq, NULL);
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
+
+		pr_devel("%s: dying ubq_daemon: qid %d\n", __func__, ubq->q_id);
+
+		/* old daemon is PF_EXITING, put it now */
+		put_task_struct(ubq->ubq_daemon);
+		/* otherwise ublk_ch_uring_cmd() won't accept new FETCH_REQ */
+		ubq->ubq_daemon = NULL;
+
+		for (j = 0; j < ubq->q_depth; j++) {
+			struct ublk_io *io = &ubq->ios[j];
+
+			/* This is an inflight rq, pass */
+			if (!io->cmd)
+				continue;
+			/*
+			 * No request has been issued(allocated) on this tag. We are safe to
+			 * io_uring_cmd_done() the old ioucmd because no one else can do this.
+			 *
+			 * Note that ublk_cancel_queue() calling io_uring_cmd_done() must
+			 * only be called with NOT dying ubq_daemon.
+			 */
+			pr_devel("%s: done old cmd: qid %d tag %d\n",
+					__func__, ubq->q_id, j);
+			io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, 0);
+
+			/* forget everything now and be ready for new FETCH_REQ */
+			io->flags = 0;
+			io->cmd = NULL;
+			io->addr = 0;
+			ubq->nr_io_ready--;
+		}
+
+		WARN_ON_ONCE(ubq->nr_io_ready);
+		ub->nr_queues_ready--;
+	}
+
+	WARN_ON_ONCE(ub->nr_queues_ready);
+	ret = 0;
+
+out_unlock:
+	mutex_unlock(&ub->mutex);
+	ublk_put_device(ub);
+	return ret;
+}
+
+static int ublk_ctrl_end_recovery(struct io_uring_cmd *cmd)
+{
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	int ublksrv_pid = (int)header->data[0];
+	struct ublk_device *ub;
+	int ret = -EINVAL;
+
+	ub = ublk_get_device_from_id(header->dev_id);
+	if (!ub)
+		return ret;
+
+	pr_devel("%s: Waiting for new ubq_daemon is ready...\n", __func__);
+	/* wait until new ubq_daemon sending all FETCH_REQ */
+	wait_for_completion_interruptible(&ub->completion);
+	pr_devel("%s: All new ubq_daemon is ready.\n", __func__);
+
+	mutex_lock(&ub->mutex);
+
+	if (!ublk_can_use_recovery(ub))
+		goto out_unlock;
+
+	if (ub->dev_info.state != UBLK_S_DEV_RECOVERING) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	ub->dev_info.ublksrv_pid = ublksrv_pid;
+	pr_devel("%s: new ublksrv_pid %d\n", __func__,
+			ub->dev_info.ublksrv_pid);
+	blk_mq_unquiesce_queue(ub->ub_disk->queue);
+	pr_devel("%s: queue unquiesced.\n", __func__);
+	ub->dev_info.state = UBLK_S_DEV_LIVE;
+	ret = 0;
+out_unlock:
+	mutex_unlock(&ub->mutex);
+	ublk_put_device(ub);
+	return ret;
+}
+
 static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
@@ -1837,6 +2028,12 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	case UBLK_CMD_SET_PARAMS:
 		ret = ublk_ctrl_set_params(cmd);
 		break;
+	case UBLK_CMD_START_USER_RECOVERY:
+		ret = ublk_ctrl_start_recovery(cmd);
+		break;
+	case UBLK_CMD_END_USER_RECOVERY:
+		ret = ublk_ctrl_end_recovery(cmd);
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

