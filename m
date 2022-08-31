Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D1A5A8269
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiHaPzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiHaPyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:54:43 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98E1AB4FE;
        Wed, 31 Aug 2022 08:54:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VNrdoMu_1661961264;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VNrdoMu_1661961264)
          by smtp.aliyun-inc.com;
          Wed, 31 Aug 2022 23:54:37 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     xiaoguang.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [RFC PATCH V2 6/6] ublk_drv: add START_USER_RECOVERY and END_USER_RECOVERY support
Date:   Wed, 31 Aug 2022 23:51:36 +0800
Message-Id: <20220831155136.23434-7-ZiyangZhang@linux.alibaba.com>
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

START_USER_RECOVERY and END_USER_RECOVERY are two new control commands
to support user recovery feature.

After a crash, user should send START_USER_RECOVERY, it will:
(1) check if (a)current ublk_device is UBLK_S_DEV_RECOVERING which was
    set by monitor_work and (b)the file struct is released. We always
	expect crash of the ublksrv 'process', not exit of a single
	ubq_daemon 'pthread'.
(2) reinit all ubqs, including:
    (a) put the dying task(thread) and reset ->ubq_daemon to NULL.
    (b) reset all ublk_io.
(3) reset ub->mm to NULL.

Then, user should start a new 'process' and send FETCH_REQ on each
ubq_daemon.

Finally, user should send END_USER_RECOVERY, it will:
(1) wait for all new ubq_daemons getting ready.
(2) unquiesce the request queue and expect incoming ublk_queue_rq()
(3) convert state to UBLK_S_DEV_LIVE
(4) schedule monitor_work again

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 130 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0e185d1fa2c4..2d1f3e032606 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1964,6 +1964,130 @@ static int ublk_ctrl_set_params(struct io_uring_cmd *cmd)
 	return ret;
 }
 
+static void ublk_queue_start_recovery(struct ublk_device *ub, struct ublk_queue *ubq)
+{
+	int i;
+
+	/* All old ioucmds have to be completed/canceled by io_uring_cmd_done(). */
+	WARN_ON_ONCE(ubq->nr_io_ready);
+
+	/* old daemon is PF_EXITING, put it now */
+	put_task_struct(ubq->ubq_daemon);
+	/* have to set it to NULL, otherwise ub won't accept new FETCH_REQ */
+	ubq->ubq_daemon = NULL;
+
+	for (i = 0; i < ubq->q_depth; i++) {
+		struct ublk_io *io = &ubq->ios[i];
+
+		/* forget everything now and be ready for new FETCH_REQ */
+		io->flags = 0;
+		io->cmd = NULL;
+		io->addr = 0;
+	}
+}
+
+static int ublk_ctrl_start_recovery(struct io_uring_cmd *cmd)
+{
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	struct ublk_device *ub;
+	int ret = -EINVAL;
+	int i;
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
+	/*
+	 * START_RECOVERY is only allowd after:
+	 *
+	 * (1) UB_STATE_OPEN is not set, which means the dying process is exited
+	 *     and related io_uring ctx is freed so file struct of /dev/ublkcX is
+	 *     released.
+	 *
+	 * (2) UBLK_S_DEV_RECOVERING is set, which means the monitor_work:
+	 *     (a)has requeued all inflight rqs whose io_flags is ACTIVE
+	 *     (b)has requeued/aborted all inflight rqs whose io_flags is NOT ACTIVE
+	 *     (c)has completed/camceled all ioucmds owned by ther dying process
+	 */
+	if (test_bit(UB_STATE_OPEN, &ub->state) ||
+			ub->dev_info.state != UBLK_S_DEV_RECOVERING) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	pr_devel("%s: start recovery for dev id %d.\n", __func__, header->dev_id);
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
+		pr_devel("%s: prepare for recovering qid %d\n", __func__, ubq->q_id);
+		ublk_queue_start_recovery(ub, ubq);
+	}
+
+	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
+	ub->mm = NULL;
+	ub->nr_queues_ready = 0;
+	init_completion(&ub->completion);
+	ret = 0;
+
+ out_unlock:
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
+	pr_devel("%s: Waiting for new ubq_daemon is ready, dev id %d...\n",
+			__func__, header->dev_id);
+	/* wait until new ubq_daemon sending all FETCH_REQ */
+	wait_for_completion_interruptible(&ub->completion);
+	pr_devel("%s: All new ubq_daemon is ready, dev id %d\n",
+			__func__, header->dev_id);
+
+	mutex_lock(&ub->mutex);
+
+	if (!ublk_can_use_recovery(ub))
+		goto out_unlock;
+
+	/* monitor_work should set UBLK_S_DEV_RECOVERING */
+	if (ub->dev_info.state != UBLK_S_DEV_RECOVERING) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	ub->dev_info.ublksrv_pid = ublksrv_pid;
+	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
+			__func__, ublksrv_pid, header->dev_id);
+	blk_mq_unquiesce_queue(ub->ub_disk->queue);
+	pr_devel("%s: queue unquiesced, dev id %d.\n",
+			__func__, header->dev_id);
+
+	ub->dev_info.state = UBLK_S_DEV_LIVE;
+	schedule_delayed_work(&ub->monitor_work, UBLK_DAEMON_MONITOR_PERIOD);
+	/* We are good to redo requests now */
+	blk_mq_kick_requeue_list(ub->ub_disk->queue);
+	ret = 0;
+ out_unlock:
+	mutex_unlock(&ub->mutex);
+	ublk_put_device(ub);
+	return ret;
+}
+
 static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
@@ -2005,6 +2129,12 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
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

