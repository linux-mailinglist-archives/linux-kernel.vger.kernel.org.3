Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69AE52E7B1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344241AbiETIfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347175AbiETIex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 603065D5E0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653035685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Aden0zBjHpHh6vfYkJ5RkS0c4wpPoEEgX60xnl8bYGo=;
        b=fYwW4j5IMxVp6NMUBwZkSJRALlSkcG+Jx/2Ys71bgix2pSVLJfBvk0auRlyibTxSmmTP63
        H4lHbl8U7Jssia4SZcyWY9D3V3SGLoVNlbYXzkBsMtMvSb096o34ws3crppYwgZij5hxhg
        XIOXseTHKiUU/QvnLoKvyMfV/UXl704=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-Acn1Ez1uOnSgRHFaeB9fkw-1; Fri, 20 May 2022 04:34:40 -0400
X-MC-Unique: Acn1Ez1uOnSgRHFaeB9fkw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A318811E75;
        Fri, 20 May 2022 08:34:39 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F51D40E8B05;
        Fri, 20 May 2022 08:34:34 +0000 (UTC)
Date:   Fri, 20 May 2022 16:34:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        ming.lei@redhat.com
Subject: Re: [PATCH -next v2] blk-mq: fix panic during blk_mq_run_work_fn()
Message-ID: <YodSlSm/sIC8G2iG@T590>
References: <20220520032542.3331610-1-yukuai3@huawei.com>
 <YocOsw6n3y11lNym@T590>
 <2b7a82e0-1e33-e2ff-74d7-d80f152fdc75@huawei.com>
 <afe9dec4-733d-88e9-850d-5c36e9201119@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afe9dec4-733d-88e9-850d-5c36e9201119@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 03:02:13PM +0800, yukuai (C) wrote:
> 在 2022/05/20 14:23, yukuai (C) 写道:
> > 在 2022/05/20 11:44, Ming Lei 写道:
> > > On Fri, May 20, 2022 at 11:25:42AM +0800, Yu Kuai wrote:
> > > > Our test report a following crash:
> > > > 
> > > > BUG: kernel NULL pointer dereference, address: 0000000000000018
> > > > PGD 0 P4D 0
> > > > Oops: 0000 [#1] SMP NOPTI
> > > > CPU: 6 PID: 265 Comm: kworker/6:1H Kdump: loaded Tainted: G
> > > > O      5.10.0-60.17.0.h43.eulerosv2r11.x86_64 #1
> > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > > > rel-1.12.1-0-ga5cab58-20220320_160524-szxrtosci10000 04/01/2014
> > > > Workqueue: kblockd blk_mq_run_work_fn
> > > > RIP: 0010:blk_mq_delay_run_hw_queues+0xb6/0xe0
> > > > RSP: 0018:ffffacc6803d3d88 EFLAGS: 00010246
> > > > RAX: 0000000000000006 RBX: ffff99e2c3d25008 RCX: 00000000ffffffff
> > > > RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffff99e2c911ae18
> > > > RBP: ffffacc6803d3dd8 R08: 0000000000000000 R09: ffff99e2c0901f6c
> > > > R10: 0000000000000018 R11: 0000000000000018 R12: ffff99e2c911ae18
> > > > R13: 0000000000000000 R14: 0000000000000003 R15: ffff99e2c911ae18
> > > > FS:  0000000000000000(0000) GS:ffff99e6bbf00000(0000)
> > > > knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 0000000000000018 CR3: 000000007460a006 CR4: 00000000003706e0
> > > > Call Trace:
> > > >   __blk_mq_do_dispatch_sched+0x2a7/0x2c0
> > > >   ? newidle_balance+0x23e/0x2f0
> > > >   __blk_mq_sched_dispatch_requests+0x13f/0x190
> > > >   blk_mq_sched_dispatch_requests+0x30/0x60
> > > >   __blk_mq_run_hw_queue+0x47/0xd0
> > > >   process_one_work+0x1b0/0x350
> > > >   worker_thread+0x49/0x300
> > > >   ? rescuer_thread+0x3a0/0x3a0
> > > >   kthread+0xfe/0x140
> > > >   ? kthread_park+0x90/0x90
> > > >   ret_from_fork+0x22/0x30
> > > > 
> > > > After digging from vmcore, I found that the queue is cleaned
> > > > up(blk_cleanup_queue() is done) and tag set is
> > > > freed(blk_mq_free_tag_set() is done).
> > > > 
> > > > There are two problems here:
> > > > 
> > > > 1) blk_mq_delay_run_hw_queues() will only be called from
> > > > __blk_mq_do_dispatch_sched() if e->type->ops.has_work() return true.
> > > > This seems impossible because blk_cleanup_queue() is done, and there
> > > > should be no io. Commit ddc25c86b466 ("block, bfq: make bfq_has_work()
> > > > more accurate") fix the problem in bfq. And currently ohter schedulers
> > > > don't have such problem.
> > > > 
> > > > 2) 'hctx->run_work' still exists after blk_cleanup_queue().
> > > > blk_mq_cancel_work_sync() is called from blk_cleanup_queue() to cancel
> > > > all the 'run_work'. However, there is no guarantee that new 'run_work'
> > > > won't be queued after that(and before blk_mq_exit_queue() is done).
> > > 
> > > It is blk_mq_run_hw_queue() caller's responsibility to grab
> > > ->q_usage_counter for avoiding queue cleaned up, so please fix the user
> > > side.
> > > 
> > Hi,
> > 
> > Thanks for your advice.
> > 
> > blk_mq_run_hw_queue() can be called async, in order to do that, what I
> > can think of is that grab 'q_usage_counte' before queuing 'run->work'
> > and release it after. Which is very similar to this patch...
> 
> Hi,
> 
> How do you think about following change:
> 

I think the issue is in blk_mq_map_queue_type() which may touch tagset.

So please try the following patch:


diff --git a/block/blk-mq.c b/block/blk-mq.c
index ed1869a305c4..5789e971ac83 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2174,8 +2174,7 @@ static bool blk_mq_has_sqsched(struct request_queue *q)
  */
 static struct blk_mq_hw_ctx *blk_mq_get_sq_hctx(struct request_queue *q)
 {
-	struct blk_mq_hw_ctx *hctx;
-
+	struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
 	/*
 	 * If the IO scheduler does not respect hardware queues when
 	 * dispatching, we just don't bother with multiple HW queues and
@@ -2183,8 +2182,8 @@ static struct blk_mq_hw_ctx *blk_mq_get_sq_hctx(struct request_queue *q)
 	 * just causes lock contention inside the scheduler and pointless cache
 	 * bouncing.
 	 */
-	hctx = blk_mq_map_queue_type(q, HCTX_TYPE_DEFAULT,
-				     raw_smp_processor_id());
+	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, 0, ctx);
+
 	if (!blk_mq_hctx_stopped(hctx))
 		return hctx;
 	return NULL;


Thanks,
Ming

