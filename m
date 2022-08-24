Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EC659F32A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 07:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiHXFtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 01:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiHXFtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:49:05 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA79986FD3;
        Tue, 23 Aug 2022 22:48:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VN5zTew_1661320134;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VN5zTew_1661320134)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 13:48:55 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     xiaoguang.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [RFC PATCH 6/9] ublk_drv: add pr_devel() to prepare for recovery feature
Date:   Wed, 24 Aug 2022 13:47:41 +0800
Message-Id: <20220824054744.77812-7-ZiyangZhang@linux.alibaba.com>
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

Recovery feature needs to correctly complete all old ioucmds. So print
some message for one ioucmd to track its status.

After io_uring ctx is freed, the /dev/ublkcX file can be released. Print
while opening/releasing the file struct to make sure there is no
resource leakage.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index df8751ea3711..4bbd97ccaedf 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -572,6 +572,9 @@ static void ublk_complete_rq(struct request *req)
 	struct ublk_io *io = &ubq->ios[req->tag];
 	unsigned int unmapped_bytes;
 
+	pr_devel("%s complete req: qid %d tag %d io_flags %d\n",
+			__func__, ubq->q_id, req->tag, io->flags);
+
 	/* failed read IO if nothing is read */
 	if (!io->res && req_op(req) == REQ_OP_READ)
 		io->res = -EIO;
@@ -620,6 +623,9 @@ static void ubq_complete_io_cmd(struct ublk_io *io, int res)
 	 */
 	io->flags &= ~UBLK_IO_FLAG_ACTIVE;
 
+	pr_devel("%s: complete: op %d, res %d io_flags %x\n",
+			__func__, io->cmd->cmd_op, res, io->flags);
+
 	/* tell ublksrv one io request is coming */
 	io_uring_cmd_done(io->cmd, res, 0);
 }
@@ -816,6 +822,7 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
 	if (test_and_set_bit(UB_STATE_OPEN, &ub->state))
 		return -EBUSY;
 	filp->private_data = ub;
+	pr_devel("%s: /dev/ublkc%d opened.\n", __func__, ub->dev_info.dev_id);
 	return 0;
 }
 
@@ -824,6 +831,7 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
 	struct ublk_device *ub = filp->private_data;
 
 	clear_bit(UB_STATE_OPEN, &ub->state);
+	pr_devel("%s: /dev/ublkc%d released.\n", __func__, ub->dev_info.dev_id);
 	return 0;
 }
 
@@ -942,6 +950,8 @@ static void ublk_daemon_monitor_work(struct work_struct *work)
 		if (ubq->ubq_daemon && ubq_daemon_is_dying(ubq) && !ubq->force_abort) {
 			struct request_queue *q = ub->ub_disk->queue;
 
+			pr_devel("%s: find dying ubq_daemon: qid %d\n",
+					__func__, ubq->q_id);
 			ubq->force_abort = true;
 
 			/* ensure that all ublk_queue_rq() calls see force_abort */
@@ -1043,12 +1053,16 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	mutex_lock(&ub->mutex);
 	ubq->nr_io_ready++;
 	if (ublk_queue_ready(ubq)) {
+		pr_devel("%s: ubq %d ready\n", __func__, ubq->q_id);
 		ubq->ubq_daemon = current;
 		get_task_struct(ubq->ubq_daemon);
 		ub->nr_queues_ready++;
 	}
-	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
+	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues) {
+		pr_devel("%s: all queues(%d) ready\n",
+				__func__, ub->dev_info.nr_hw_queues);
 		complete_all(&ub->completion);
+	}
 	mutex_unlock(&ub->mutex);
 }
 
-- 
2.27.0

