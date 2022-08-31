Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553265A8263
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiHaPyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiHaPyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:54:11 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C24BCC24;
        Wed, 31 Aug 2022 08:54:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VNrdoBn_1661961229;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VNrdoBn_1661961229)
          by smtp.aliyun-inc.com;
          Wed, 31 Aug 2022 23:54:02 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     xiaoguang.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [RFC PATCH V2 3/6] ublk_drv: define macros for recovery feature and check them
Date:   Wed, 31 Aug 2022 23:51:33 +0800
Message-Id: <20220831155136.23434-4-ZiyangZhang@linux.alibaba.com>
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

Define some macros for recovery feature. Especially define a new state:
UBLK_S_DEV_RECOVERING which implies the ublk_device is recovering.

UBLK_F_USER_RECOVERY implies that:
(1) ublk_drv enables recovery feature. It won't let monitor_work to
    automatically abort rqs and release the device. Instead, it waits
	for user's START_USER_RECOVERY ctrl-cmd.

(2) In monitor_work after a crash, ublk_drv ends(aborts) rqs issued to
    userspace(ublksrv) before crash.

(3) In task work and ublk_queue_rq() after a crash, ublk_drv requeues
    rqs dispatched after crash.

UBLK_F_USER_RECOVERY_REISSUE implies that:
(1) everything UBLK_F_USER_RECOVERY implies except
(2) ublk_drv requeues rqs issued to userspace(ublksrv) before crash.

UBLK_F_USER_RECOVERY_REISSUE is designed for backends which:
(1) tolerate double-writes because we may issue the same rq twice.
(2) cannot let frontend users get I/O error, such as a RDONLY system.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c      | 31 ++++++++++++++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h |  7 +++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0c6db0978ed0..0c3d32e8d686 100644
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
@@ -323,6 +325,33 @@ static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
 			PAGE_SIZE);
 }
 
+/*
+ * TODO: UBLK_F_USER_RECOVERY should be a flag for device, not for queue,
+ * since "some queues are aborted while others are recoverd" is really weird.
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
+ * since "some queues are aborted while others are recoverd" is really weird.
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

