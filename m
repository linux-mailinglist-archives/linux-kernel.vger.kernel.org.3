Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0021F5809E6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 05:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbiGZDXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 23:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiGZDXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 23:23:14 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FA02A437;
        Mon, 25 Jul 2022 20:23:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LsMfC25lFzlCHt;
        Tue, 26 Jul 2022 11:22:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgAXemkdXt9iTd_KBA--.33716S4;
        Tue, 26 Jul 2022 11:23:11 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     axboe@kernel.dk, ming.lei@redhat.com, osandov@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v2] blk-mq: fix io hung due to missing commit_rqs
Date:   Tue, 26 Jul 2022 11:35:19 +0800
Message-Id: <20220726033519.4002586-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgAXemkdXt9iTd_KBA--.33716S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGry3AF1xWw43XFy3Jw13Arb_yoW5ArWUpF
        43Ca12yr4Fqr4jvFyxuay7C3W0vw4DCrW7GrySkw4aqFZ8K3yIqrs3JF17WFyIkrs5AwsI
        gF45WryYq3W8ZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Currently, in virtio_scsi, if 'bd->last' is not set to true while
dispatching request, such io will stay in driver's queue, and driver
will wait for block layer to dispatch more rqs. However, if block
layer failed to dispatch more rq, it should trigger commit_rqs to
inform driver.

There is a problem in blk_mq_try_issue_list_directly() that commit_rqs
won't be called:

// assume that queue_depth is set to 1, list contains two rq
blk_mq_try_issue_list_directly
 blk_mq_request_issue_directly
 // dispatch first rq
 // last is false
  __blk_mq_try_issue_directly
   blk_mq_get_dispatch_budget
   // succeed to get first budget
   __blk_mq_issue_directly
    scsi_queue_rq
     cmd->flags |= SCMD_LAST
      virtscsi_queuecommand
       kick = (sc->flags & SCMD_LAST) != 0
       // kick is false, first rq won't issue to disk
 queued++

 blk_mq_request_issue_directly
 // dispatch second rq
  __blk_mq_try_issue_directly
   blk_mq_get_dispatch_budget
   // failed to get second budget
 ret == BLK_STS_RESOURCE
  blk_mq_request_bypass_insert
 // errors is still 0

 if (!list_empty(list) || errors && ...)
  // won't pass, commit_rqs won't be called

In this situation, first rq relied on second rq to dispatch, while
second rq relied on first rq to complete, thus they will both hung.
And same problem exists in blk_mq_dispatch_rq_list()

Fix the problem by also treat 'BLK_STS_*RESOURCE' as 'errors' since
it means that request is not queued successfully.

Fixes: d666ba98f849 ("blk-mq: add mq_ops->commit_rqs()")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
Changes in v2:
 - suggested by Ming, handle blk_mq_dispatch_rq_list() as well.
 - change title and modify commit message.

 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 70177ee74295..ee1e065fe63f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1909,6 +1909,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 			fallthrough;
 		case BLK_STS_DEV_RESOURCE:
 			blk_mq_handle_dev_resource(rq, list);
+			errors++;
 			goto out;
 		case BLK_STS_ZONE_RESOURCE:
 			/*
@@ -1918,6 +1919,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 			 */
 			blk_mq_handle_zone_resource(rq, &zone_list);
 			needs_resource = true;
+			errors++;
 			break;
 		default:
 			errors++;
@@ -2680,6 +2682,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		list_del_init(&rq->queuelist);
 		ret = blk_mq_request_issue_directly(rq, list_empty(list));
 		if (ret != BLK_STS_OK) {
+			errors++;
 			if (ret == BLK_STS_RESOURCE ||
 					ret == BLK_STS_DEV_RESOURCE) {
 				blk_mq_request_bypass_insert(rq, false,
@@ -2687,7 +2690,6 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 				break;
 			}
 			blk_mq_end_request(rq, ret);
-			errors++;
 		} else
 			queued++;
 	}
-- 
2.31.1

