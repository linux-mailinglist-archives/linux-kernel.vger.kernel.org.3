Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0984C21A5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 03:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiBXCQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 21:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiBXCQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:16:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA6C71F76A5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 18:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645668974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ouhKFZWq4guS9Nb84H+5Q9CfdYqhj416J6D5cP6zMB8=;
        b=X8myRfDSKSVYi1v8pm+xxEfpMh80XnHvKpZvafz+83eJ76rR2M1LKdRnlCunZifSj+KR1y
        W/luilrCAk1uWirow2qiCAM/RjGZgLgDrjw0XPpn0A51KmHa56f/7xF9NqqYgxwshPGJrf
        Ol1Q48E3twW123Jo0rsYDsPCkoyFZNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-CPKAjdE4Pn2PnWSTSlnIsg-1; Wed, 23 Feb 2022 21:16:11 -0500
X-MC-Unique: CPKAjdE4Pn2PnWSTSlnIsg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89AD91091DA0;
        Thu, 24 Feb 2022 02:16:09 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F18E5DB80;
        Thu, 24 Feb 2022 02:15:59 +0000 (UTC)
Date:   Thu, 24 Feb 2022 10:15:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH RFC] blk-mq: fix potential uaf for 'queue_hw_ctx'
Message-ID: <YhbqWqtwNueSffuR@T590>
References: <20220223112601.2902761-1-yukuai3@huawei.com>
 <YhZFITXtiL8Xaord@T590>
 <df32802a-7dfb-3e80-359a-206c2be6ebe5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df32802a-7dfb-3e80-359a-206c2be6ebe5@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 09:29:09AM +0800, yukuai (C) wrote:
> 在 2022/02/23 22:30, Ming Lei 写道:
> > On Wed, Feb 23, 2022 at 07:26:01PM +0800, Yu Kuai wrote:
> > > blk_mq_realloc_hw_ctxs() will free the 'queue_hw_ctx'(e.g. undate
> > > submit_queues through configfs for null_blk), while it might still be
> > > used from other context(e.g. switch elevator to none):
> > > 
> > > t1					t2
> > > elevator_switch
> > >   blk_mq_unquiesce_queue
> > >    blk_mq_run_hw_queues
> > >     queue_for_each_hw_ctx
> > >      // assembly code for hctx = (q)->queue_hw_ctx[i]
> > >      mov    0x48(%rbp),%rdx -> read old queue_hw_ctx
> > > 
> > > 					__blk_mq_update_nr_hw_queues
> > > 					 blk_mq_realloc_hw_ctxs
> > > 					  hctxs = q->queue_hw_ctx
> > > 					  q->queue_hw_ctx = new_hctxs
> > > 					  kfree(hctxs)
> > >      movslq %ebx,%rax
> > >      mov    (%rdx,%rax,8),%rdi ->uaf
> > > 
> > 
> > Not only uaf on queue_hw_ctx, but also other similar issue on other
> > structures, and I think the correct and easy fix is to quiesce request
> > queue during updating nr_hw_queues, something like the following patch:
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index a05ce7725031..d8e7c3cce0dd 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -4467,8 +4467,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
> >   	if (set->nr_maps == 1 && nr_hw_queues == set->nr_hw_queues)
> >   		return;
> > -	list_for_each_entry(q, &set->tag_list, tag_set_list)
> > +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> >   		blk_mq_freeze_queue(q);
> > +		blk_mq_quiesce_queue(q);
> > +	}
> >   	/*
> >   	 * Switch IO scheduler to 'none', cleaning up the data associated
> >   	 * with the previous scheduler. We will switch back once we are done
> > @@ -4518,8 +4520,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
> >   	list_for_each_entry(q, &set->tag_list, tag_set_list)
> >   		blk_mq_elv_switch_back(&head, q);
> > -	list_for_each_entry(q, &set->tag_list, tag_set_list)
> > +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> > +		blk_mq_unquiesce_queue(q);
> >   		blk_mq_unfreeze_queue(q);
> > +	}
> >   }
> >   void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
> Hi, Ming
> 
> If blk_mq_quiesce_queue() is called from __blk_mq_update_nr_hw_queues()
> first, and then swithing elevator to none won't trigger the problem.
> However, what if blk_mq_unquiesce_queue() from switching elevator
> decrease quiesce_depth to 0 first, and then blk_mq_quiesce_queue() is
> called from __blk_mq_update_nr_hw_queues(), it seems to me such
> concurrent scenarios still exist.

No, the scenario won't exist, once blk_mq_quiesce_queue() returns, it is
guaranteed that:

- in-progress run queue is drained
- no new run queue can be started

Thanks,
Ming

