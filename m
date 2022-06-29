Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A89555F59F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 07:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiF2FSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 01:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiF2FSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 01:18:49 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6393123F;
        Tue, 28 Jun 2022 22:18:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VHm9GRb_1656479900;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VHm9GRb_1656479900)
          by smtp.aliyun-inc.com;
          Wed, 29 Jun 2022 13:18:43 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: set BLK_MQ_S_STOPPED first to avoid unexpected queue work
Date:   Wed, 29 Jun 2022 13:18:20 +0800
Message-Id: <1656479900-58719-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

In "__blk_mq_delay_run_hw_queue", BLK_MQ_S_STOPPED is checked first,
and then queue work, but in "blk_mq_stop_hw_queue", execute cancel
work first and then set BLK_MQ_S_STOPPED, so there is a risk of
queue work after setting BLK_MQ_S_STOPPED, which can be solved by
adjusting the order.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 93d9d60..865915e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2258,9 +2258,9 @@ bool blk_mq_queue_stopped(struct request_queue *q)
  */
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
 {
-	cancel_delayed_work(&hctx->run_work);
-
 	set_bit(BLK_MQ_S_STOPPED, &hctx->state);
+
+	cancel_delayed_work(&hctx->run_work);
 }
 EXPORT_SYMBOL(blk_mq_stop_hw_queue);
 
-- 
1.8.3.1

