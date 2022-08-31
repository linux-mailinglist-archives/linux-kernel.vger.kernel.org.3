Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D028F5A8267
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiHaPyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiHaPyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:54:32 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E996CBD1D9;
        Wed, 31 Aug 2022 08:54:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VNrdoMN_1661961261;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VNrdoMN_1661961261)
          by smtp.aliyun-inc.com;
          Wed, 31 Aug 2022 23:54:24 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     xiaoguang.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [RFC PATCH V2 5/6] ublk_drv: consider recovery feature in aborting mechanism
Date:   Wed, 31 Aug 2022 23:51:35 +0800
Message-Id: <20220831155136.23434-6-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220831155136.23434-1-ZiyangZhang@linux.alibaba.com>
References: <20220831155136.23434-1-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We change the default behavior of aborting machenism. Now monitor_work
will not be manually scheduled by ublk_queue_rq() or task_work after a
ubq_daemon or process is dying(PF_EXITING). The monitor work should
find a dying ubq_daemon or a crash process by itself. Then, it can
start the aborting machenism. We do such modification is because we want
to strictly separate the STOP_DEV procedure and monitor_work. More
specifically, we ensure that monitor_work must not be scheduled after
we start deleting gendisk and ending(aborting) all inflight rqs. In this
way we are easy to consider recovery feature and unify it into existing
aborting mechanism. Really we do not want too many "if can_use_recovery"
checks.

With recovery feature disabled and after a ubq_daemon crash:
(1) monitor_work notices the crash and schedules stop_work
(2) stop_work calls ublk_stop_dev()
(3) In ublk_stop_dev():
    (a) It sets 'force_abort', which prevents new rqs in ublk_queue_rq();
	    If ublk_queue_rq() does not see it, rqs can still be ended(aborted)
		in fallback wq.
	(b) Then it cancels monitor_work;
	(c) Then it schedules abort_work which ends(aborts) all inflight rqs.
	(d) At the same time del_gendisk() is called.
	(e) Finally, we complete all ioucmds.

Note: we do not change the existing behavior with reocvery disabled. Note
that STOP_DEV ctrl-cmd can be processed without reagrd to monitor_work.

With recovery feature enabled and after a process crash:
(1) monitor_work notices the crash and all ubq_daemon are dying.
    We do not consider a "single" ubq_daemon(pthread) crash. Please send
	STOP_DEV ctrl-cmd which calling ublk_stop_dev() for this case.
(2) The monitor_work quiesces request queue.
(3) The monotor_work checks if there is any inflight rq with
    UBLK_IO_FLAG_ACTIVE unset. If so, we give up and schedule monitor_work
	later to retry. This is because we have to wait these rqs requeued(IDLE)
	and we are safe to complete their ioucmds later. Otherwise we may cause
	UAF on ioucmd in fallback wq.
(4) If check in (3) passes, we should requeue/abort inflight rqs issued
    to the crash ubq_daemon before. If UBLK_F_USER_RECOVERY_REISSUE is set,
	rq is requeued. Otherwise it is aborted.
(5) All ioucmds are completed by calling io_uring_cmd_done().
(6) monitor_work set ub's state to UBLK_S_DEV_RECOVERING. It does not
    scheduled itself anymore. Now we are ready for START_USER_RECOVERY. 

Note: If (3) fails, monitor_work schedules itself and retires (3). We allow
user to manually start STOP_DEV procedure without reagrd to monitor_work.
STOP_DEV can cancel monitor_work, unquiesce request queue and drain all
requeued rqs. More importantly, STOP_DEV can safely complete all ioucmds
since monitor_work has been canceled at that moment.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 222 +++++++++++++++++++++++++++++++++++----
 1 file changed, 202 insertions(+), 20 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 296b9d80f003..0e185d1fa2c4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -156,7 +156,7 @@ struct ublk_device {
 
 	struct completion	completion;
 	unsigned int		nr_queues_ready;
-	atomic_t		nr_aborted_queues;
+	bool	force_abort;
 
 	/*
 	 * Our ubq->daemon may be killed without any notification, so
@@ -164,6 +164,7 @@ struct ublk_device {
 	 */
 	struct delayed_work	monitor_work;
 	struct work_struct	stop_work;
+	struct work_struct	abort_work;
 };
 
 /* header of ublk_params */
@@ -643,9 +644,13 @@ static void ublk_complete_rq(struct request *req)
  */
 static void __ublk_fail_req(struct ublk_io *io, struct request *req)
 {
+	struct ublk_queue *ubq = req->mq_hctx->driver_data;
+
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
 
 	if (!(io->flags & UBLK_IO_FLAG_ABORTED)) {
+		pr_devel("%s: abort rq: qid %d tag %d io_flags %x\n",
+				__func__, ubq->q_id, req->tag, io->flags);
 		io->flags |= UBLK_IO_FLAG_ABORTED;
 		blk_mq_end_request(req, BLK_STS_IOERR);
 	}
@@ -664,6 +669,8 @@ static void ubq_complete_io_cmd(struct ublk_io *io, int res)
 
 	/* tell ublksrv one io request is coming */
 	io_uring_cmd_done(io->cmd, res, 0);
+	pr_devel("%s: complete ioucmd: res %d io_flags %x\n",
+			__func__, res, io->flags);
 }
 
 #define UBLK_REQUEUE_DELAY_MS	3
@@ -675,11 +682,6 @@ static inline void __ublk_rq_task_work(struct request *req)
 	int tag = req->tag;
 	struct ublk_io *io = &ubq->ios[tag];
 	unsigned int mapped_bytes;
-
-	pr_devel("%s: complete: op %d, qid %d tag %d io_flags %x addr %llx\n",
-			__func__, io->cmd->cmd_op, ubq->q_id, req->tag, io->flags,
-			ublk_get_iod(ubq, req->tag)->addr);
-
 	/*
 	 * Task is exiting if either:
 	 *
@@ -700,10 +702,13 @@ static inline void __ublk_rq_task_work(struct request *req)
 		} else {
 			blk_mq_end_request(req, BLK_STS_IOERR);
 		}
-		mod_delayed_work(system_wq, &ub->monitor_work, 0);
 		return;
 	}
 
+	pr_devel("%s: complete: op %d, qid %d tag %d io_flags %x addr %llx\n",
+			__func__, io->cmd->cmd_op, ubq->q_id, req->tag, io->flags,
+			ublk_get_iod(ubq, req->tag)->addr);
+
 	if (ublk_need_get_data(ubq) &&
 			(req_op(req) == REQ_OP_WRITE ||
 			req_op(req) == REQ_OP_FLUSH)) {
@@ -782,6 +787,11 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct ublk_io *io = &ubq->ios[rq->tag];
 	blk_status_t res;
 
+	if (unlikely(ubq->dev->force_abort)) {
+		pr_devel("%s: abort q_id %d tag %d io_flags %x.\n",
+				__func__, ubq->q_id, rq->tag, io->flags);
+		return BLK_STS_IOERR;
+	}
 	/* fill iod to slot in io cmd buffer */
 	res = ublk_setup_iod(ubq, rq);
 	if (unlikely(res != BLK_STS_OK))
@@ -789,13 +799,15 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(bd->rq);
 
+	pr_devel("%s: start rq: q_id %d tag %d io_flags %x.\n",
+			__func__, ubq->q_id, rq->tag, io->flags);
+
 	if (unlikely(ubq_daemon_is_dying(ubq))) {
  fail:
 		pr_devel("%s: %s q_id %d tag %d io_flags %x.\n", __func__,
 				(ublk_can_use_recovery(ubq->dev)) ? "requeue" : "abort",
 				ubq->q_id, rq->tag, io->flags);
 
-		mod_delayed_work(system_wq, &ubq->dev->monitor_work, 0);
 		if (ublk_can_use_recovery(ubq->dev)) {
 			/* We cannot process this rq so just requeue it. */
 			blk_mq_requeue_request(rq, false);
@@ -880,6 +892,7 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
 	if (test_and_set_bit(UB_STATE_OPEN, &ub->state))
 		return -EBUSY;
 	filp->private_data = ub;
+	pr_devel("%s: open /dev/ublkc%d\n", __func__, ub->dev_info.dev_id);
 	return 0;
 }
 
@@ -888,6 +901,7 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
 	struct ublk_device *ub = filp->private_data;
 
 	clear_bit(UB_STATE_OPEN, &ub->state);
+	pr_devel("%s: release /dev/ublkc%d\n", __func__, ub->dev_info.dev_id);
 	return 0;
 }
 
@@ -971,37 +985,180 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 			 * will do it
 			 */
 			rq = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], i);
-			if (rq)
+			if (rq && blk_mq_request_started(rq))
 				__ublk_fail_req(io, rq);
 		}
 	}
 	ublk_put_device(ub);
 }
 
-static void ublk_daemon_monitor_work(struct work_struct *work)
+
+
+static void ublk_abort_work_fn(struct work_struct *work)
 {
 	struct ublk_device *ub =
-		container_of(work, struct ublk_device, monitor_work.work);
+		container_of(work, struct ublk_device, abort_work);
+
+	int i;
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		if (ubq_daemon_is_dying(ubq))
+			ublk_abort_queue(ub, ubq);
+	}
+
+	if (ub->force_abort)
+		schedule_work(&ub->abort_work);
+}
+
+static void ublk_reinit_queue(struct ublk_device *ub,
+		struct ublk_queue *ubq)
+{
+	int i;
+
+	for (i = 0; i < ubq->q_depth; i++) {
+		struct ublk_io *io = &ubq->ios[i];
+
+		if (!(io->flags & UBLK_IO_FLAG_ACTIVE)) {
+			struct request *rq = blk_mq_tag_to_rq(
+					ub->tag_set.tags[ubq->q_id], i);
+
+			WARN_ON_ONCE(!rq);
+			pr_devel("%s: %s rq: qid %d tag %d io_flags %x\n",
+					__func__,
+					ublk_can_use_recovery_reissue(ub) ? "requeue" : "abort",
+					ubq->q_id, i, io->flags);
+			if (ublk_can_use_recovery_reissue(ub))
+				blk_mq_requeue_request(rq, false);
+			else
+				__ublk_fail_req(io, rq);
+
+		} else {
+			io_uring_cmd_done(io->cmd,
+					UBLK_IO_RES_ABORT, 0);
+			io->flags &= ~UBLK_IO_FLAG_ACTIVE;
+			pr_devel("%s: send UBLK_IO_RES_ABORT: qid %d tag %d io_flags %x\n",
+				__func__, ubq->q_id, i, io->flags);
+		}
+		ubq->nr_io_ready--;
+	}
+	WARN_ON_ONCE(ubq->nr_io_ready);
+}
+
+static bool ublk_check_inflight_rq(struct request *rq, void *data)
+{
+	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
+	struct ublk_io *io = &ubq->ios[rq->tag];
+	bool *busy = data;
+
+	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
+		*busy = true;
+		return false;
+	}
+	return true;
+}
+
+static void ublk_reinit_dev(struct ublk_device *ub)
+{
+	int i;
+	bool busy = false;
+
+	if (!ublk_get_device(ub))
+		return;
+
+	/* If we have quiesced q, all ubq_daemons are dying */
+	if (blk_queue_quiesced(ub->ub_disk->queue))
+		goto check_inflight;
+
+	/* Recovery feature is for 'process' crash. */
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		if (!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)))
+			goto out;
+	}
+
+	pr_devel("%s: all ubq_daemons(nr: %d) are dying.\n",
+			__func__, ub->dev_info.nr_hw_queues);
+
+	/* Now all ubq_daemons are PF_EXITING, let's quiesce q. */
+	blk_mq_quiesce_queue(ub->ub_disk->queue);
+	pr_devel("%s: queue quiesced.\n", __func__);
+ check_inflight:
+	/* All rqs have to be requeued(and stay in queue now) */
+	blk_mq_tagset_busy_iter(&ub->tag_set, ublk_check_inflight_rq, &busy);
+	if (busy) {
+		pr_devel("%s: still some inflight rqs, retry later...\n",
+				__func__);
+		goto out;
+	}
+
+	pr_devel("%s: all inflight rqs are requeued.\n", __func__);
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		ublk_reinit_queue(ub, ubq);
+	}
+	/* So monitor_work won't be scheduled anymore */
+	ub->dev_info.state = UBLK_S_DEV_RECOVERING;
+	pr_devel("%s: convert state to UBLK_S_DEV_RECOVERING\n",
+			__func__);
+ out:
+	ublk_put_device(ub);
+}
+
+static void ublk_kill_dev(struct ublk_device *ub)
+{
 	int i;
 
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
 		struct ublk_queue *ubq = ublk_get_queue(ub, i);
 
 		if (ubq_daemon_is_dying(ubq)) {
+			pr_devel("%s: ubq(%d) is dying, schedule stop_work now\n",
+					__func__, i);
 			schedule_work(&ub->stop_work);
-
-			/* abort queue is for making forward progress */
-			ublk_abort_queue(ub, ubq);
 		}
 	}
+}
+
+static void ublk_daemon_monitor_work(struct work_struct *work)
+{
+	struct ublk_device *ub =
+		container_of(work, struct ublk_device, monitor_work.work);
+
+	pr_devel("%s: mode(%s) running...\n",
+			__func__,
+			ublk_can_use_recovery(ub) ? "recovery" : "kill");
+	/*
+	 * We can't schedule monitor work if:
+	 * (1) The state is DEAD.
+	 *     The gendisk is not alive, so either all rqs are ended
+	 *     or request queue is not created.
+	 *
+	 * (2) The state is RECOVERYING.
+	 *     The process crashed, all rqs were requeued and request queue
+	 *     was quiesced.
+	 */
+	WARN_ON_ONCE(ub->dev_info.state != UBLK_S_DEV_LIVE);
 
+	if (ublk_can_use_recovery(ub))
+		ublk_reinit_dev(ub);
+	else
+		ublk_kill_dev(ub);
 	/*
-	 * We can't schedule monitor work after ublk_remove() is started.
+	 * No need ub->mutex, monitor work are canceled after ub is marked
+	 * as force_abort which is observed reliably.
+	 *
+	 * Note:
+	 * All incoming rqs are aborted in ublk_queue_rq ASAP. Then
+	 * we will hang on del_gendisk() and wait for all inflight rqs'
+	 * completion.
 	 *
-	 * No need ub->mutex, monitor work are canceled after state is marked
-	 * as DEAD, so DEAD state is observed reliably.
 	 */
-	if (ub->dev_info.state != UBLK_S_DEV_DEAD)
+	if (ub->dev_info.state == UBLK_S_DEV_LIVE && !ub->force_abort)
 		schedule_delayed_work(&ub->monitor_work,
 				UBLK_DAEMON_MONITOR_PERIOD);
 }
@@ -1058,10 +1215,35 @@ static void ublk_cancel_dev(struct ublk_device *ub)
 static void ublk_stop_dev(struct ublk_device *ub)
 {
 	mutex_lock(&ub->mutex);
-	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
+	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
 		goto unlock;
 
+	/*
+	 * All incoming rqs are aborted in ublk_queue_rq ASAP. Then
+	 * we will hang on del_gendisk() and wait for all inflight rqs'
+	 * completion.
+	 */
+	ub->force_abort = true;
+	/* wait until monitor_work is not scheduled */
+	cancel_delayed_work_sync(&ub->monitor_work);
+	pr_devel("%s: monitor work is canceled.\n", __func__);
+	/* unquiesce q and let all inflight rqs' be aborted */
+	if (blk_queue_quiesced(ub->ub_disk->queue)) {
+		blk_mq_unquiesce_queue(ub->ub_disk->queue);
+		pr_devel("%s: queue unquiesced.\n", __func__);
+	}
+	/* requeued requests will be aborted ASAP because of 'force_abort' */
+	blk_mq_kick_requeue_list(ub->ub_disk->queue);
+	/* forward progress */
+	schedule_work(&ub->abort_work);
+	pr_devel("%s: abort work is scheduled, start delete gendisk...\n",
+			__func__);
+	pr_devel("%s: gendisk is deleted.\n", __func__);
 	del_gendisk(ub->ub_disk);
+	pr_devel("%s: gendisk is deleted.\n", __func__);
+	ub->force_abort = false;
+	cancel_work_sync(&ub->abort_work);
+	pr_devel("%s: abort work is canceled.\n", __func__);
 	ub->dev_info.state = UBLK_S_DEV_DEAD;
 	ub->dev_info.ublksrv_pid = -1;
 	put_disk(ub->ub_disk);
@@ -1069,7 +1251,6 @@ static void ublk_stop_dev(struct ublk_device *ub)
  unlock:
 	ublk_cancel_dev(ub);
 	mutex_unlock(&ub->mutex);
-	cancel_delayed_work_sync(&ub->monitor_work);
 }
 
 /* device can only be started after all IOs are ready */
@@ -1560,6 +1741,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		goto out_unlock;
 	mutex_init(&ub->mutex);
 	spin_lock_init(&ub->mm_lock);
+	INIT_WORK(&ub->abort_work, ublk_abort_work_fn);
 	INIT_WORK(&ub->stop_work, ublk_stop_work_fn);
 	INIT_DELAYED_WORK(&ub->monitor_work, ublk_daemon_monitor_work);
 
-- 
2.27.0

