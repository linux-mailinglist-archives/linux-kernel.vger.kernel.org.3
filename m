Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906AF52EDA4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350053AbiETN5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbiETN5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:57:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5643C5E16A
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653055022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Xg9YIIDr5qXxyMPcswvH5k6lOW6r7RcBc7OT6l2sRU=;
        b=ZIDF+271NKp51ltLRPXmKAsdmtlcl0idqZ8259FsEd0kDLjxAm2NkPrNRydzLiTR48i7iz
        AI8tvqQOyU89+9BNeJOor2dfjFb/vqYDJAHWd4YD93sE6iNlFFqWKpD5ehsUHT/9NcHbvt
        8B5g0fA9EQy3IJVCYQoRrBFjsSeAq00=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-WE6RxvVbNny_ovl1L2prrg-1; Fri, 20 May 2022 09:56:46 -0400
X-MC-Unique: WE6RxvVbNny_ovl1L2prrg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0B78101AA42;
        Fri, 20 May 2022 13:56:45 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F0097C2A;
        Fri, 20 May 2022 13:56:40 +0000 (UTC)
Date:   Fri, 20 May 2022 21:56:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        ming.lei@redhat.com
Subject: Re: [PATCH -next v2] blk-mq: fix panic during blk_mq_run_work_fn()
Message-ID: <YoeeEw4SFvWtXNRk@T590>
References: <20220520032542.3331610-1-yukuai3@huawei.com>
 <YocOsw6n3y11lNym@T590>
 <2b7a82e0-1e33-e2ff-74d7-d80f152fdc75@huawei.com>
 <afe9dec4-733d-88e9-850d-5c36e9201119@huawei.com>
 <YodSlSm/sIC8G2iG@T590>
 <dbe2deec-b007-470f-eb5a-35fae63ad134@huawei.com>
 <YodlGOo7vrUa7DZK@T590>
 <0e7967de-0c32-790d-fa08-b0bc9ef5923d@huawei.com>
 <Yod93DOdYosa+SvS@T590>
 <8e6a806b-f42e-319b-e6c8-de1f07befce2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e6a806b-f42e-319b-e6c8-de1f07befce2@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 08:01:31PM +0800, yukuai (C) wrote:
> 在 2022/05/20 19:39, Ming Lei 写道:
> 
> > 
> > In short:
> > 
> > 1) run queue can be in-progress during cleanup queue, or returns from
> > cleanup queue; we drain it in both blk_cleanup_queue() and
> > disk_release_mq(), see commit 2a19b28f7929 ("blk-mq: cancel blk-mq dispatch
> > work in both blk_cleanup_queue and disk_release()")
> I understand that, however, there is no garantee new 'hctx->run_work'
> won't be queued after 'drain it', for this crash, I think this is how

No, run queue activity will be shutdown after both disk_release_mq()
and blk_cleanup_queue() are done.

disk_release_mq() is called after all FS IOs are done, so there isn't
any run queue from FS IO code path, either sync or async.

In blk_cleanup_queue(), we only focus on passthrough request, and
passthrough request is always explicitly allocated & freed by
its caller, so once queue is frozen, all sync dispatch activity
for passthrough request has been done, then it is enough to just cancel
dispatch work for avoiding any dispatch activity.

That is why both request queue and hctx can be released safely
after the two are done.

> it triggered:
> 
> assum that there is no io, while some bfq_queue is still busy:
> 
> blk_cleanup_queue
>  blk_freeze_queue
>  blk_mq_cancel_work_sync
>  cancel_delayed_work_sync(hctx1)
> 				blk_mq_run_work_fn -> hctx2
> 				 __blk_mq_run_hw_queue
> 				  blk_mq_sched_dispatch_requests
> 				   __blk_mq_do_dispatch_sched
> 				    blk_mq_delay_run_hw_queues
> 				     blk_mq_delay_run_hw_queue
> 				      -> add hctx1->run_work again
>  cancel_delayed_work_sync(hctx2)

Yes, even blk_mq_delay_run_hw_queues() can be called after all
hctx->run_work are canceled since __blk_mq_run_hw_queue() could be
running in sync io code path, not via ->run_work.

And my patch will fix the issue, won't it?


Thanks,
Ming

