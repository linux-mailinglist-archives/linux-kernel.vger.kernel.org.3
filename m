Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7230C59F328
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 07:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiHXFtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 01:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiHXFtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:49:04 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16D1876BB;
        Tue, 23 Aug 2022 22:48:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VN5zTfC_1661320135;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VN5zTfC_1661320135)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 13:48:55 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     xiaoguang.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [RFC PATCH 7/9] ublk_drv: define macros for recovery feature and check them
Date:   Wed, 24 Aug 2022 13:47:42 +0800
Message-Id: <20220824054744.77812-8-ZiyangZhang@linux.alibaba.com>
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

Define some macros for recovery feature. Especially define a new state:
UBLK_S_DEV_RECOVERING which implies the ublk_device is recovering.

UBLK_F_USER_RECOVERY implies that:
(1) ublk_drv enables recovery feature. It won't schedule monitor_work to
    automatically abort rqs and release the device. Instead, it waits
	for user's START_USER_RECOVERY ctrl-cmd.
(2) while re-initing a ubq, ublk_drv ends(aborts) rqs issued to
    userspace(ublksrv) before crash.
    
(3) while re-initing a ubq, ublk_drv requeues rqs dispatched after crash.

UBLK_F_USER_RECOVERY_REISSUE implies that:
(1) everything UBLK_F_USER_RECOVERY implies except
(2) ublk_drv requeues rqs issued to userspace(ublksrv) before crash.

UBLK_F_USER_RECOVERY_REISSUE is designed for backends which:
(1) tolerate double-writes because we may issue the same rq twice.
(2) cannot let frontend users get I/O error, such as a RDONLY system.

For now, we do not allow STOP_DEV while we are in UBLK_S_DEV_RECOVERING.
This means that user must assign a new ubq_daemon for each ubq after
sending START_USER_RECOVERY ctrl-cmd.

Also modify checks on state in START_DEV and SET_PARAMS because now we
have three states.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c      | 47 ++++++++++++++++++++++++++++++-----
 include/uapi/linux/ublk_cmd.h |  7 ++++++
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4bbd97ccaedf..0ee871fa3f92 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -49,7 +49,9 @@
 /* All UBLK_F_* have to be included into UBLK_F_ALL */
 #define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY \
 		| UBLK_F_URING_CMD_COMP_IN_TASK \
-		| UBLK_F_NEED_GET_DATA)
+		| UBLK_F_NEED_GET_DATA \
+		| UBLK_F_USER_RECOVERY \
+		| UBLK_F_USER_RECOVERY_REISSUE)
 
 /* All UBLK_PARAM_TYPE_* should be included here */
 #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
@@ -322,6 +324,33 @@ static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
 			PAGE_SIZE);
 }
 
+/*
+ * TODO: UBLK_F_USER_RECOVERY should be a flag for device, not for queue,
+ * since "some queues are aborted while others are recovered" is really weird.
+ */
+static inline bool ublk_can_use_recovery(struct ublk_device *ub)
+{
+	struct ublk_queue *ubq = ublk_get_queue(ub, 0);
+
+	if (ubq->flags & UBLK_F_USER_RECOVERY)
+		return true;
+	return false;
+}
+
+/*
+ * TODO: UBLK_F_USER_RECOVERY_REISSUE should be a flag for device, not for queue,
+ * since "some queues are aborted while others are recovered" is really weird.
+ */
+static inline bool ublk_can_use_recovery_reissue(struct ublk_device *ub)
+{
+	struct ublk_queue *ubq = ublk_get_queue(ub, 0);
+
+	if ((ubq->flags & UBLK_F_USER_RECOVERY) &&
+			(ubq->flags & UBLK_F_USER_RECOVERY_REISSUE))
+		return true;
+	return false;
+}
+
 static void ublk_free_disk(struct gendisk *disk)
 {
 	struct ublk_device *ub = disk->private_data;
@@ -1029,10 +1058,15 @@ static void ublk_stop_dev(struct ublk_device *ub)
 {
 	mutex_lock(&ub->mutex);
 	/* No gendisk is live. ubq may be ready or not */
-	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
+	if (ub->dev_info.state == UBLK_S_DEV_DEAD) {
 		goto out_cancel_dev;
-
-	mod_delayed_work(system_wq, &ub->monitor_work, 0);
+	/* TODO: support stop_dev just after start_recovery */
+	} else if (ub->dev_info.state == UBLK_S_DEV_RECOVERING) {
+		goto out_unlock;
+	/* schedule monitor_work to abort any dying queue */
+	} else {
+		mod_delayed_work(system_wq, &ub->monitor_work, 0);
+	}
 	pr_devel("%s: Wait for all requests ended...\n", __func__);
 	blk_mq_freeze_queue(ub->ub_disk->queue);
 	ub->dev_info.state = UBLK_S_DEV_DEAD;
@@ -1044,6 +1078,7 @@ static void ublk_stop_dev(struct ublk_device *ub)
 	ub->ub_disk = NULL;
  out_cancel_dev:
 	ublk_cancel_dev(ub);
+ out_unlock:
 	mutex_unlock(&ub->mutex);
 }
 
@@ -1403,7 +1438,7 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 	schedule_delayed_work(&ub->monitor_work, UBLK_DAEMON_MONITOR_PERIOD);
 
 	mutex_lock(&ub->mutex);
-	if (ub->dev_info.state == UBLK_S_DEV_LIVE ||
+	if (ub->dev_info.state != UBLK_S_DEV_DEAD ||
 	    test_bit(UB_STATE_USED, &ub->state)) {
 		ret = -EEXIST;
 		goto out_unlock;
@@ -1746,7 +1781,7 @@ static int ublk_ctrl_set_params(struct io_uring_cmd *cmd)
 
 	/* parameters can only be changed when device isn't live */
 	mutex_lock(&ub->mutex);
-	if (ub->dev_info.state == UBLK_S_DEV_LIVE) {
+	if (ub->dev_info.state != UBLK_S_DEV_DEAD) {
 		ret = -EACCES;
 	} else if (copy_from_user(&ub->params, argp, ph.len)) {
 		ret = -EFAULT;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 677edaab2b66..7f7e6f44cec5 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -17,6 +17,8 @@
 #define	UBLK_CMD_STOP_DEV	0x07
 #define	UBLK_CMD_SET_PARAMS	0x08
 #define	UBLK_CMD_GET_PARAMS	0x09
+#define	UBLK_CMD_START_USER_RECOVERY	0x10
+#define UBLK_CMD_END_USER_RECOVERY	0x11
 
 /*
  * IO commands, issued by ublk server, and handled by ublk driver.
@@ -74,9 +76,14 @@
  */
 #define UBLK_F_NEED_GET_DATA (1UL << 2)
 
+#define UBLK_F_USER_RECOVERY	(1UL << 3)
+
+#define UBLK_F_USER_RECOVERY_REISSUE	(1UL << 4)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
+#define UBLK_S_DEV_RECOVERING	2
 
 /* shipped via sqe->cmd of io_uring command */
 struct ublksrv_ctrl_cmd {
-- 
2.27.0

