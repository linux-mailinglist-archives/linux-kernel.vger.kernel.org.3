Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE0B54A9E5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352832AbiFNHBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239438AbiFNHBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:01:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2533B02F;
        Tue, 14 Jun 2022 00:01:07 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LMfQN33wgzRhtf;
        Tue, 14 Jun 2022 14:57:48 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 15:01:03 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 14 Jun
 2022 15:01:02 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <djeffery@redhat.com>,
        <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next] blk-mq: fix boot time regression for scsi drives with multiple hctx
Date:   Tue, 14 Jun 2022 15:14:10 +0800
Message-ID: <20220614071410.3571204-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found that boot time is increased for about 8s after upgrading kernel
from v4.19 to v5.10(megaraid-sas is used in the environment).

Following is where the extra time is spent:

scsi_probe_and_add_lun
 __scsi_remove_device
  blk_cleanup_queue
   blk_mq_exit_queue
    blk_mq_exit_hw_queues
     blk_mq_exit_hctx
      blk_mq_clear_flush_rq_mapping -> function latency is 0.1ms
       cmpxchg

There are three reasons:
1) megaraid-sas is using multiple hctxs in v5.10, thus blk_mq_exit_hctx()
will be called much more times in v5.10 compared to v4.19.
2) scsi will scan for each target thus __scsi_remove_device() will be
called for many times.
3) blk_mq_clear_flush_rq_mapping() is introduced after v4.19, it will
call cmpxchg() for each request, and function latency is abount 0.1ms.

Since that blk_mq_clear_flush_rq_mapping() will only be called while the
queue is freezed already, which means there is no inflight request,
it's safe to set NULL for 'tags->rqs[]' directly instead of using
cmpxchg(). Tests show that with this change, function latency of
blk_mq_clear_flush_rq_mapping() is about 1us, and boot time is not
increased.

Fixes: 364b61818f65 ("blk-mq: clearing flush request reference in tags->rqs[]")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c | 2 +-
 block/blk-mq.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 2dcd738c6952..d002eefcdaf5 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -253,7 +253,7 @@ static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
 	unsigned long flags;
 
 	spin_lock_irqsave(&tags->lock, flags);
-	rq = tags->rqs[bitnr];
+	rq = READ_ONCE(tags->rqs[bitnr]);
 	if (!rq || rq->tag != bitnr || !req_ref_inc_not_zero(rq))
 		rq = NULL;
 	spin_unlock_irqrestore(&tags->lock, flags);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e9bf950983c7..21ace698d3be 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3421,7 +3421,7 @@ static void blk_mq_clear_flush_rq_mapping(struct blk_mq_tags *tags,
 	WARN_ON_ONCE(req_ref_read(flush_rq) != 0);
 
 	for (i = 0; i < queue_depth; i++)
-		cmpxchg(&tags->rqs[i], flush_rq, NULL);
+		WRITE_ONCE(tags->rqs[i], NULL);
 
 	/*
 	 * Wait until all pending iteration is done.
-- 
2.31.1

