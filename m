Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08576525345
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356873AbiELRKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349317AbiELRK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:10:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522C2269EE3;
        Thu, 12 May 2022 10:10:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 12AA91F38C;
        Thu, 12 May 2022 17:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652375426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/9XAcRo+E2h3CTio5LOn32n4GFy+zXlhWLwgRN3/9n8=;
        b=juGeGmWI5D/vC/Yy/fmA8IV+naKTrFWfTQxB7lDgG1rqPrZV2erbm76n3Po3TwcPYWVk4Q
        F/KfzgtkQzT5/v2OrVJ1MQHTJDVf966rNOuSNMt91kWppLpcDyrQl3lWWR627330+0cbbF
        em6T9V4IefCmIxUh+GGL9mKN6CkD/4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652375426;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/9XAcRo+E2h3CTio5LOn32n4GFy+zXlhWLwgRN3/9n8=;
        b=aqqg2OameJ2jGwEdBptM+puRW+2mj5eziSKcu1DbMb5SnbDNg+8lihAebI3AR6LI+7pGSs
        WIgDYz8xRBexHUCw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DB9FA2C141;
        Thu, 12 May 2022 17:10:25 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 31752A062A; Thu, 12 May 2022 19:10:25 +0200 (CEST)
Date:   Thu, 12 May 2022 19:10:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 2/2] block, bfq: make bfq_has_work() more accurate
Message-ID: <20220512171025.blstxod6aphulctm@quack3.lan>
References: <20220510131629.1964415-1-yukuai3@huawei.com>
 <20220510131629.1964415-3-yukuai3@huawei.com>
 <20220511140832.w6eqphw5uepre5ws@quack3.lan>
 <67425a7b-f9e1-d7a9-9ec8-158f9f8ce13e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67425a7b-f9e1-d7a9-9ec8-158f9f8ce13e@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12-05-22 09:30:16, yukuai (C) wrote:
> On 2022/05/11 22:08, Jan Kara wrote:
> > On Tue 10-05-22 21:16:29, Yu Kuai wrote:
> > > bfq_has_work() is using busy_queues currently, which is not accurate
> > > because bfq_queue is busy doesn't represent that it has requests. Since
> > > bfqd aready has a counter 'queued' to record how many requests are in
> > > bfq, use it instead of busy_queues.
> > > 
> > > Noted that bfq_has_work() can be called with 'bfqd->lock' held, thus the
> > > lock can't be held in bfq_has_work() to protect 'bfqd->queued'.
> > > 
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > 
> > So did you find this causing any real problem? Because bfq queue is
> > accounted among busy queues once bfq_add_bfqq_busy() is called. And that
> > happens once a new request is inserted into the queue so it should be very
> > similar to bfqd->queued.
> > 
> > 								Honza
> 
> Hi,
> 
> The related problem is described here:
> 
> https://lore.kernel.org/all/20220510112302.1215092-1-yukuai3@huawei.com/
> 
> The root cause of the panic is a linux-block problem, however, it can
> be bypassed if bfq_has_work() is accurate. On the other hand,
> unnecessary run_work will be triggered if bfqq stays busy:
> 
> __blk_mq_run_hw_queue
>  __blk_mq_sched_dispatch_requests
>   __blk_mq_do_dispatch_sched
>    if (!bfq_has_work())
>     break;
>    blk_mq_delay_run_hw_queues -> run again after 3ms

Ah, I see. So it is the other way around than I thought. Due to idling
bfq_tot_busy_queues() can be greater than 0 even if there are no requests
to dispatch. Indeed. OK, the patch makes sense. But please use WRITE_ONCE
for the updates of bfqd->queued. Otherwise the READ_ONCE does not really
make sense (it can still result in some bogus value due to compiler
optimizations on the write side).

								Honza

> > > ---
> > >   block/bfq-iosched.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> > > index 61750696e87f..1d2f8110c26b 100644
> > > --- a/block/bfq-iosched.c
> > > +++ b/block/bfq-iosched.c
> > > @@ -5063,11 +5063,11 @@ static bool bfq_has_work(struct blk_mq_hw_ctx *hctx)
> > >   	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
> > >   	/*
> > > -	 * Avoiding lock: a race on bfqd->busy_queues should cause at
> > > +	 * Avoiding lock: a race on bfqd->queued should cause at
> > >   	 * most a call to dispatch for nothing
> > >   	 */
> > >   	return !list_empty_careful(&bfqd->dispatch) ||
> > > -		bfq_tot_busy_queues(bfqd) > 0;
> > > +		READ_ONCE(bfqd->queued);
> > >   }
> > >   static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
> > > -- 
> > > 2.31.1
> > > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
