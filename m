Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AFC59F32D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 07:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiHXFtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 01:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbiHXFtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:49:04 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39408001A;
        Tue, 23 Aug 2022 22:48:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VN5zTdx_1661320132;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VN5zTdx_1661320132)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 13:48:53 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     xiaoguang.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [RFC PATCH 2/9] ublk_drv: refactor ublk_cancel_queue()
Date:   Wed, 24 Aug 2022 13:47:37 +0800
Message-Id: <20220824054744.77812-3-ZiyangZhang@linux.alibaba.com>
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

Assume only a few FETCH_REQ ioucmds are sent to ublk_drv, then the
ubq_daemon exits, We have to call io_uring_cmd_done() for all ioucmds
received so that io_uring ctx will not leak.

ublk_cancel_queue() may be called before START_DEV or after STOP_DEV,
we decrease ubq->nr_io_ready and clear UBLK_IO_FLAG_ACTIVE so that we
won't call io_uring_cmd_done() twice for one ioucmd to avoid UAF. Also
clearing UBLK_IO_FLAG_ACTIVE makes the code more reasonable.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c39b67d7133d..e08f636b0b9d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -967,18 +967,23 @@ static void ublk_cancel_queue(struct ublk_queue *ubq)
 {
 	int i;
 
-	if (!ublk_queue_ready(ubq))
+	if (!ubq->nr_io_ready)
 		return;
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
 
-		if (io->flags & UBLK_IO_FLAG_ACTIVE)
+		if (io->flags & UBLK_IO_FLAG_ACTIVE) {
+			pr_devel("%s: done old cmd: qid %d tag %d\n",
+					__func__, ubq->q_id, i);
 			io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, 0);
+			io->flags &= ~UBLK_IO_FLAG_ACTIVE;
+			ubq->nr_io_ready--;
+		}
 	}
 
 	/* all io commands are canceled */
-	ubq->nr_io_ready = 0;
+	WARN_ON_ONCE(ubq->nr_io_ready);
 }
 
 /* Cancel all pending commands, must be called after del_gendisk() returns */
-- 
2.27.0

