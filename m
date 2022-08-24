Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5C659F329
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 07:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiHXFtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 01:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiHXFtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:49:07 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2135F80F46;
        Tue, 23 Aug 2022 22:48:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VN5zTeJ_1661320133;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VN5zTeJ_1661320133)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 13:48:54 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     xiaoguang.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [RFC PATCH 4/9] ublk_drv: refactor __ublk_rq_task_work() and aborting machenism
Date:   Wed, 24 Aug 2022 13:47:39 +0800
Message-Id: <20220824054744.77812-5-ZiyangZhang@linux.alibaba.com>
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

If one rq is handled by io_uring_cmd_complete_in_task(), after a crash
this rq is actually handled by an io_uring fallback wq. We have to
end(abort) this rq since this fallback wq is a task other than the
crashed task. However, current code does not call io_uring_cmd_done()
at the same time but do it in ublk_cancel_queue(). With current design,
this does work because ublk_cancel_queue() is called AFTER del_gendisk(),
which waits for the rq ended(aborted) in fallback wq. This implies that
fallback wq on this rq is scheduled BEFORE calling io_uring_cmd_done()
on the corresponding ioucmd in ublk_cancel_queue().

However, while considering recovery feature, we cannot rely on
del_gendisk() or blk_mq_freeze_queue() to wait for completion of all
rqs because we may not want any aborted rq. Besides, io_uring does not
provide "flush fallback" machenism so we cannot trace this ioucmd.

The recovery machenism needs to complete all ioucmds of a dying ubq
to avoid leaking io_uring ctx. But as talked above, we are unsafe
to call io_uring_cmd_done() in the recovery task if fallback wq happens
to run simultaneously. This is a UAF case because io_uring ctx may be
freed. Actually a similar case happens in
(5804987b7272f437299011c76b7363b8df6f8515: ublk_drv: do not add a
re-issued request aborted previously to ioucmd's task_work).

Besides, in order to implement recovery machenism, in ublk_queue_rq()
and __ublk_rq_task_work(), we should not end(abort) current rq while
ubq_daemon is dying. Instead, we should wait for new ubq_daemon getting
ready and requeue it.

In summary, We refactor some code to avoid the UAF problem and prepare
for recovery machenism:

(1) Refactor monitor_work
Monitor_work is only used without recovery feature which aborts rqs and
stops the device. Now ublk_abort_queue() is the only function end(abort)
inflight rqs with a dying ubq_daemon. While for a not inflight(idle)
rq, its ioucmd is completed by io_uring_cmd_done() safely. We do not
rely on UBLK_IO_FLAG_ACTIVE anymore. monitor_work also sets 'force_abort'
for a dying ubq.

(2) Refactor ublk_queue_rq()
Check 'force_abort' before blk_mq_start_request(). If 'force_abort' is
true, end(abort) current rq immediately. 'force_abort' is set by
monitor_work for a dying ubq. Aborting rqs ASAP ensures that all rqs'
status do not change while we traverse rqs in monitor_work.

(3) Refactor __ublk_rq_task_work().
No matter we use task_work_add() or io_uring_cmd_complete_in_task(),
now __ublk_rq_task_work() only accepts one arg: ioucmd, which is set in
ublk_queue_rq() eariler. And no matter ubq_daemon is dying or not,
we always call io_uring_cmd_done(ioucmd). Note that ioucmd might not be
the same as io->cmd because a new ubq_daemon may set new ioucmds before
old fallback wq or exit_task_work runs. In this way the old ioucmd
can be safely freed eventually and io->cmd can be updated without race.

(4) Refactor ublk_cancel_dev()
ublk_cancel_dev() cannot complete ioucmds for a dying ubq because we
have done this in monitor_work.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 216 +++++++++++++++++++++------------------
 1 file changed, 115 insertions(+), 101 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8add6e3ae15f..1b1c0190bba4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -54,12 +54,10 @@
 /* All UBLK_PARAM_TYPE_* should be included here */
 #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
 
-struct ublk_rq_data {
-	struct callback_head work;
-};
-
 struct ublk_uring_cmd_pdu {
-	struct request *req;
+	int q_id;
+	int tag;
+	struct callback_head work;
 };
 
 /*
@@ -122,6 +120,7 @@ struct ublk_queue {
 	bool abort_work_pending;
 	unsigned short nr_io_ready;	/* how many ios setup */
 	struct ublk_device *dev;
+	bool force_abort;
 	struct ublk_io ios[0];
 };
 
@@ -610,24 +609,6 @@ static void ublk_complete_rq(struct request *req)
 		__blk_mq_end_request(req, BLK_STS_OK);
 }
 
-/*
- * Since __ublk_rq_task_work always fails requests immediately during
- * exiting, __ublk_fail_req() is only called from abort context during
- * exiting. So lock is unnecessary.
- *
- * Also aborting may not be started yet, keep in mind that one failed
- * request may be issued by block layer again.
- */
-static void __ublk_fail_req(struct ublk_io *io, struct request *req)
-{
-	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
-
-	if (!(io->flags & UBLK_IO_FLAG_ABORTED)) {
-		io->flags |= UBLK_IO_FLAG_ABORTED;
-		blk_mq_end_request(req, BLK_STS_IOERR);
-	}
-}
-
 static void ubq_complete_io_cmd(struct ublk_io *io, int res)
 {
 	/* mark this cmd owned by ublksrv */
@@ -645,18 +626,14 @@ static void ubq_complete_io_cmd(struct ublk_io *io, int res)
 
 #define UBLK_REQUEUE_DELAY_MS	3
 
-static inline void __ublk_rq_task_work(struct request *req)
+static inline void __ublk_rq_task_work(struct io_uring_cmd *cmd)
 {
-	struct ublk_queue *ubq = req->mq_hctx->driver_data;
-	struct ublk_device *ub = ubq->dev;
-	int tag = req->tag;
-	struct ublk_io *io = &ubq->ios[tag];
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+	struct ublk_device *ub = cmd->file->private_data;
+	struct ublk_queue *ubq = ublk_get_queue(ub, pdu->q_id);
+	struct ublk_io *io;
+	struct request *req;
 	unsigned int mapped_bytes;
-
-	pr_devel("%s: complete: op %d, qid %d tag %d io_flags %x addr %llx\n",
-			__func__, io->cmd->cmd_op, ubq->q_id, req->tag, io->flags,
-			ublk_get_iod(ubq, req->tag)->addr);
-
 	/*
 	 * Task is exiting if either:
 	 *
@@ -667,11 +644,22 @@ static inline void __ublk_rq_task_work(struct request *req)
 	 * (2) current->flags & PF_EXITING.
 	 */
 	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {
-		blk_mq_end_request(req, BLK_STS_IOERR);
-		mod_delayed_work(system_wq, &ub->monitor_work, 0);
+		pr_devel("%s: (%s) done old cmd: qid %d tag %d\n",
+				__func__,
+				current != ubq->ubq_daemon ? "fallback wq" : "exit_task_work",
+				pdu->q_id, pdu->tag);
+		io_uring_cmd_done(cmd, UBLK_IO_RES_ABORT, 0);
 		return;
 	}
 
+	io = &ubq->ios[pdu->tag];
+	req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], pdu->tag);
+	WARN_ON_ONCE(!req);
+
+	pr_devel("%s: complete: op %d, qid %d tag %d io_flags %x addr %llx\n",
+			__func__, cmd->cmd_op, ubq->q_id, req->tag, io->flags,
+			ublk_get_iod(ubq, req->tag)->addr);
+
 	if (ublk_need_get_data(ubq) &&
 			(req_op(req) == REQ_OP_WRITE ||
 			req_op(req) == REQ_OP_FLUSH)) {
@@ -728,18 +716,16 @@ static inline void __ublk_rq_task_work(struct request *req)
 
 static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd)
 {
-	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
-
-	__ublk_rq_task_work(pdu->req);
+	__ublk_rq_task_work(cmd);
 }
 
 static void ublk_rq_task_work_fn(struct callback_head *work)
 {
-	struct ublk_rq_data *data = container_of(work,
-			struct ublk_rq_data, work);
-	struct request *req = blk_mq_rq_from_pdu(data);
+	struct ublk_uring_cmd_pdu *pdu = container_of(work,
+			struct ublk_uring_cmd_pdu, work);
+	struct io_uring_cmd *cmd = ublk_uring_cmd_from_pdu(pdu);
 
-	__ublk_rq_task_work(req);
+	__ublk_rq_task_work(cmd);
 }
 
 static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
@@ -747,6 +733,8 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 {
 	struct ublk_queue *ubq = hctx->driver_data;
 	struct request *rq = bd->rq;
+	struct ublk_io *io = &ubq->ios[rq->tag];
+	struct ublk_uring_cmd_pdu *pdu;
 	blk_status_t res;
 
 	/* fill iod to slot in io cmd buffer */
@@ -754,43 +742,43 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(res != BLK_STS_OK))
 		return BLK_STS_IOERR;
 
-	blk_mq_start_request(bd->rq);
-
-	if (unlikely(ubq_daemon_is_dying(ubq))) {
- fail:
-		mod_delayed_work(system_wq, &ubq->dev->monitor_work, 0);
+	/*
+	 * We set force_abort because we want to abort this rq ASAP.
+	 *
+	 * NOTE: At this moment, rq is NOT inflight. So after the ubq is marked
+	 * as force_abort, no new rq can be inflight and we are safe to check
+	 * all rqs' status in monitor_work and choose whether:
+	 *
+	 * (1) if inflight, end(abort) this rq;
+	 * (2) if not inflight, io_uring_cmd_done() the ioucmd.
+	 */
+	if (ubq->force_abort) {
+		pr_devel("%s: force abort: qid %d tag %d io_flag %d\n",
+				__func__, ubq->q_id, rq->tag, io->flags);
 		return BLK_STS_IOERR;
 	}
 
+	blk_mq_start_request(bd->rq);
+	pr_devel("%s: start req: q_id %d tag %d io_flags %d\n",
+			__func__, ubq->q_id, rq->tag, io->flags);
+	pdu = ublk_get_uring_cmd_pdu(io->cmd);
+	pdu->q_id = ubq->q_id;
+	pdu->tag = rq->tag;
+
 	if (ublk_can_use_task_work(ubq)) {
-		struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
 		enum task_work_notify_mode notify_mode = bd->last ?
 			TWA_SIGNAL_NO_IPI : TWA_NONE;
 
-		if (task_work_add(ubq->ubq_daemon, &data->work, notify_mode))
-			goto fail;
-	} else {
-		struct ublk_io *io = &ubq->ios[rq->tag];
-		struct io_uring_cmd *cmd = io->cmd;
-		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+		init_task_work(&pdu->work, ublk_rq_task_work_fn);
 
-		/*
-		 * If the check pass, we know that this is a re-issued request aborted
-		 * previously in monitor_work because the ubq_daemon(cmd's task) is
-		 * PF_EXITING. We cannot call io_uring_cmd_complete_in_task() anymore
-		 * because this ioucmd's io_uring context may be freed now if no inflight
-		 * ioucmd exists. Otherwise we may cause null-deref in ctx->fallback_work.
-		 *
-		 * Note: monitor_work sets UBLK_IO_FLAG_ABORTED and ends this request(releasing
-		 * the tag). Then the request is re-started(allocating the tag) and we are here.
-		 * Since releasing/allocating a tag implies smp_mb(), finding UBLK_IO_FLAG_ABORTED
-		 * guarantees that here is a re-issued request aborted previously.
-		 */
-		if ((io->flags & UBLK_IO_FLAG_ABORTED))
-			goto fail;
+		/* If task_work_add() fails, we know that ubq_daemon(cmd's task) is PF_EXITING. */
+		if (task_work_add(ubq->ubq_daemon, &pdu->work, notify_mode))
+			pr_devel("%s: done old cmd: qid %d tag %d\n",
+					__func__, ubq->q_id, rq->tag);
+			io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, 0);
 
-		pdu->req = rq;
-		io_uring_cmd_complete_in_task(cmd, ublk_rq_task_work_cb);
+	} else {
+		io_uring_cmd_complete_in_task(io->cmd, ublk_rq_task_work_cb);
 	}
 
 	return BLK_STS_OK;
@@ -814,20 +802,10 @@ static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
 	return 0;
 }
 
-static int ublk_init_rq(struct blk_mq_tag_set *set, struct request *req,
-		unsigned int hctx_idx, unsigned int numa_node)
-{
-	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
-
-	init_task_work(&data->work, ublk_rq_task_work_fn);
-	return 0;
-}
-
 static const struct blk_mq_ops ublk_mq_ops = {
 	.queue_rq       = ublk_queue_rq,
 	.commit_rqs     = ublk_commit_rqs,
 	.init_hctx	= ublk_init_hctx,
-	.init_request   = ublk_init_rq,
 };
 
 static int ublk_ch_open(struct inode *inode, struct file *filp)
@@ -906,31 +884,46 @@ static void ublk_commit_completion(struct ublk_device *ub,
 		ublk_complete_rq(req);
 }
 
-/*
- * When ->ubq_daemon is exiting, either new request is ended immediately,
- * or any queued io command is drained, so it is safe to abort queue
- * lockless
+/* do cleanup work for a dying(PF_EXITING) ubq_daemon:
+ * (1) end(abort) all 'inflight' rqs here.
+ * (2) complete ioucmd of all not 'inflight' rqs here.
+ *
+ * Note: we have set ubq->force_abort before. So ublk_queue_rq() must fail
+ * a rq immediately before it calls blk_mq_start_request() which will
+ * set a rq's status as 'inflight'. Therefore, set of 'inflight'
+ * rqs must not change for a dying ubq.
+ *
+ * Note: If we fail one rq in ublk_queue_rq(), we cannot fail it here again.
+ * This is because checking 'force_abort' happens before blk_mq_start_request()
+ * so its status is always 'idle' and never changes to 'inflight'.
+ *
+ * Also aborting may not be started yet, keep in mind that one failed
+ * request may be issued by block layer again.
  */
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 {
 	int i;
 
+	WARN_ON_ONCE(!ubq->force_abort);
+
 	if (!ublk_get_device(ub))
 		return;
 
 	for (i = 0; i < ubq->q_depth; i++) {
-		struct ublk_io *io = &ubq->ios[i];
-
-		if (!(io->flags & UBLK_IO_FLAG_ACTIVE)) {
-			struct request *rq;
+		struct request *rq = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], i);
 
+		if (rq && blk_mq_request_started(rq)) {
 			/*
-			 * Either we fail the request or ublk_rq_task_work_fn
+			 * Either we fail the request or ublk_queue_rq
 			 * will do it
 			 */
-			rq = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], i);
-			if (rq)
-				__ublk_fail_req(io, rq);
+			pr_devel("%s: abort request: qid %d tag %d\n",
+					__func__, ubq->q_id, i);
+			blk_mq_end_request(rq, BLK_STS_IOERR);
+		} else {
+			pr_devel("%s: done old cmd: qid %d tag %d\n",
+			__func__, ubq->q_id, i);
+			io_uring_cmd_done(ubq->ios[i].cmd, UBLK_IO_RES_ABORT, 0);
 		}
 	}
 	ublk_put_device(ub);
@@ -945,7 +938,18 @@ static void ublk_daemon_monitor_work(struct work_struct *work)
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
 		struct ublk_queue *ubq = ublk_get_queue(ub, i);
 
-		if (ubq_daemon_is_dying(ubq)) {
+		/* check force_abort so we do not abort a queue two times! */
+		if (ubq->ubq_daemon && ubq_daemon_is_dying(ubq) && !ubq->force_abort) {
+			struct request_queue *q = ub->ub_disk->queue;
+
+			ubq->force_abort = true;
+
+			/* ensure that all ublk_queue_rq() calls see force_abort */
+			if (blk_queue_has_srcu(q))
+				synchronize_srcu(q->srcu);
+			else
+				synchronize_rcu();
+
 			schedule_work(&ub->stop_work);
 
 			/* abort queue is for making forward progress */
@@ -997,8 +1001,18 @@ static void ublk_cancel_dev(struct ublk_device *ub)
 {
 	int i;
 
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		/*
+		 * for ubq with a dying daemon, we have io_uring_cmd_done() all cmd in
+		 * ublk_abort_queue(). Do not io_uring_cmd_done() cmd two times!
+		 */
+		if (ubq->ubq_daemon && ubq_daemon_is_dying(ubq))
+			continue;
+
 		ublk_cancel_queue(ublk_get_queue(ub, i));
+	}
 }
 
 static void ublk_stop_dev(struct ublk_device *ub)
@@ -1037,17 +1051,17 @@ static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
 		int tag, struct io_uring_cmd *cmd)
 {
 	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
-	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[q_id], tag);
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+
+	pdu->q_id = q_id;
+	pdu->tag = tag;
 
 	if (ublk_can_use_task_work(ubq)) {
-		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 
+		init_task_work(&pdu->work, ublk_rq_task_work_fn);
 		/* should not fail since we call it just in ubq->ubq_daemon */
-		task_work_add(ubq->ubq_daemon, &data->work, TWA_SIGNAL_NO_IPI);
+		task_work_add(ubq->ubq_daemon, &pdu->work, TWA_SIGNAL_NO_IPI);
 	} else {
-		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
-
-		pdu->req = req;
 		io_uring_cmd_complete_in_task(cmd, ublk_rq_task_work_cb);
 	}
 }
@@ -1320,7 +1334,7 @@ static int ublk_add_tag_set(struct ublk_device *ub)
 	ub->tag_set.nr_hw_queues = ub->dev_info.nr_hw_queues;
 	ub->tag_set.queue_depth = ub->dev_info.queue_depth;
 	ub->tag_set.numa_node = NUMA_NO_NODE;
-	ub->tag_set.cmd_size = sizeof(struct ublk_rq_data);
+	ub->tag_set.cmd_size = 0;
 	ub->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	ub->tag_set.driver_data = ub;
 	return blk_mq_alloc_tag_set(&ub->tag_set);
-- 
2.27.0

