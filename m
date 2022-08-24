Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E75059F332
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 07:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbiHXFvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 01:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbiHXFuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:50:37 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08600915FA;
        Tue, 23 Aug 2022 22:50:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VN5zTec_1661320134;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VN5zTec_1661320134)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 13:48:54 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     xiaoguang.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [RFC PATCH 5/9] ublk_drv: refactor ublk_stop_dev()
Date:   Wed, 24 Aug 2022 13:47:40 +0800
Message-Id: <20220824054744.77812-6-ZiyangZhang@linux.alibaba.com>
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

Since we rely on rq's status to end(abort) it in monitor_work, calling
del_gendisk() too early can result in UAF. So add blk_mq_freeze_queue()
to end all inflight rqs. del_gendisk() can be then safely called with a
frozen queue.

Note: blk_mq_freeze_queue() hangs until:
(1) all rqs are aborted and ioucmds are copmleted(freed) on a dying ubq
    by monitor_work scheduled.
(2) all rqs are ended on other ubqs.

We cancel monitor_work before del_gendisk() because monitor_work also
touches rq's status. Monitor_work is guaranteed to be canceled because
we mark ub's state as UBLK_S_DEV_DEAD.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1b1c0190bba4..df8751ea3711 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1018,18 +1018,23 @@ static void ublk_cancel_dev(struct ublk_device *ub)
 static void ublk_stop_dev(struct ublk_device *ub)
 {
 	mutex_lock(&ub->mutex);
-	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
-		goto unlock;
+	/* No gendisk is live. ubq may be ready or not */
+	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
+		goto out_cancel_dev;
 
-	del_gendisk(ub->ub_disk);
+	mod_delayed_work(system_wq, &ub->monitor_work, 0);
+	pr_devel("%s: Wait for all requests ended...\n", __func__);
+	blk_mq_freeze_queue(ub->ub_disk->queue);
 	ub->dev_info.state = UBLK_S_DEV_DEAD;
+	cancel_delayed_work_sync(&ub->monitor_work);
+	pr_devel("%s: All requests are ended.\n", __func__);
+	del_gendisk(ub->ub_disk);
 	ub->dev_info.ublksrv_pid = -1;
 	put_disk(ub->ub_disk);
 	ub->ub_disk = NULL;
- unlock:
+ out_cancel_dev:
 	ublk_cancel_dev(ub);
 	mutex_unlock(&ub->mutex);
-	cancel_delayed_work_sync(&ub->monitor_work);
 }
 
 /* device can only be started after all IOs are ready */
-- 
2.27.0

