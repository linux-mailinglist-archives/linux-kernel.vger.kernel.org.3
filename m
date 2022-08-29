Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2B15A44AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiH2IL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiH2ILm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7A754CB0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661760686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SlGMrAFYDKp6bMlJjk3Ggz6Y5xDwakWpy92Wds1tTlc=;
        b=FQkPaqbBRb7bry2Gpmiim+HZUxeBEOlNar3JrsezuyP6hC8/DptL4GN/vGt//20IXYYJaV
        LhzhvXH7OWmOAPOBKCh8Yx6RceKyQ5VKK+RtSi29ktwlj0vIWNzg6eXbzvflNfmv+NKdcU
        tXs3a89HQoXuNC9JEQd8kOlc5CQTbfs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-7Na7a8EQPVOf7VkVPD7FYA-1; Mon, 29 Aug 2022 04:11:20 -0400
X-MC-Unique: 7Na7a8EQPVOf7VkVPD7FYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8C4229ABA22;
        Mon, 29 Aug 2022 08:11:19 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FC58C15BBA;
        Mon, 29 Aug 2022 08:11:15 +0000 (UTC)
Date:   Mon, 29 Aug 2022 16:11:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [RFC PATCH 4/9] ublk_drv: refactor __ublk_rq_task_work() and
 aborting machenism
Message-ID: <Ywx0oUcqvE9JcpnT@T590>
References: <20220824054744.77812-1-ZiyangZhang@linux.alibaba.com>
 <20220824054744.77812-5-ZiyangZhang@linux.alibaba.com>
 <YwxRVEQlIw3oWmwE@T590>
 <35dd7300-12ea-62ba-393e-145eae318944@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35dd7300-12ea-62ba-393e-145eae318944@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 02:13:12PM +0800, Ziyang Zhang wrote:
> On 2022/8/29 13:40, Ming Lei wrote:
> > On Wed, Aug 24, 2022 at 01:47:39PM +0800, ZiyangZhang wrote:
> >> If one rq is handled by io_uring_cmd_complete_in_task(), after a crash
> >> this rq is actually handled by an io_uring fallback wq. We have to
> >> end(abort) this rq since this fallback wq is a task other than the
> >> crashed task. However, current code does not call io_uring_cmd_done()
> >> at the same time but do it in ublk_cancel_queue(). With current design,
> >> this does work because ublk_cancel_queue() is called AFTER del_gendisk(),
> >> which waits for the rq ended(aborted) in fallback wq. This implies that
> >> fallback wq on this rq is scheduled BEFORE calling io_uring_cmd_done()
> >> on the corresponding ioucmd in ublk_cancel_queue().
> > 
> > Right.
> > 
> >>
> >> However, while considering recovery feature, we cannot rely on
> >> del_gendisk() or blk_mq_freeze_queue() to wait for completion of all
> >> rqs because we may not want any aborted rq. Besides, io_uring does not
> >> provide "flush fallback" machenism so we cannot trace this ioucmd.
> > 
> > Why not?
> > 
> > If user recovery is enabled, del_gendisk() can be replaced with
> > blk_mq_quiesce_queue(), then let abort work function do:
> > 
> > - cancel all in-flight requests by holding them into requeue list
> >   instead of finishing them as before, and this way is safe because
> >   abort worker does know the ubq daemon is dying
> > - cancel pending commands as before, because the situation is same
> >   with disk deleted or queue frozen
> 
> The problem is: we cannot control when fallback wq is scheduled.
> So we are unsafe to call io_uring_cmd_done() in another process.

What is the other process?

It can't be fallback wq since any ublk request is aborted at the beginning
of __ublk_rq_task_work().

It shouldn't be the process calling ublk_cancel_dev(), since it is
safe to call io_uring_cmd_done() if ubq->nr_io_ready > 0.

Or others?

> Otherwise, there is a UAF, just as
> (5804987b7272f437299011c76b7363b8df6f8515: ublk_drv: do not add a
> re-issued request aborted previously to ioucmd's task_work).

As I mentioned, del_gendisk() can be replaced with
blk_mq_quiesce_queue() in case of user recovery, then no any new
request can be queued after blk_mq_quiesce_queue() returns.

> 
> Yeah I know the answer is very simple: flush the fallback wq.
> But here are two more questions:

I don't see why we need to flush fallback wq, care to provide some
details?

> 
> (1) Should ublk_drv rely on the fallback wq machenism?
>     IMO, ublk_drv should not know detail of io_uring_cmd_complete_in_task()
>     because its implementation may change in the future.
>     BTW, I think current ublk_rq_task_work_cb() is not correct because
>     it does not always call io_uring_cmd_done() before returning.
>     nvme_uring_cmd_end_io() always calls io_uring_cmd_done() for each ioucmd
>     no matter the rq succeeds or fails.
> 
> (2) Suppose io_uring does export the symbol 'flush_fallback_work', should we call
>     it before starting a new process(recovery)?
>     What if fallback wq is not scheduled immediately if there are many processes
>     running and the system overhead is heavy. In this case the recovery process
>     may wait for too long. Really we should not depend on fallback wq and please
>     let the fallback wq complete the ioucmd itself.
> 
> > 
> > With this way, the current abort logic won't be changed much.
> > 
> > And user recovery should only be started _after_ ublk device is found
> > as aborted.
> 
> START_RECOVERY will check if all ubq_daemons(the process) are PF_EXITING.

That is different. If START_RECOVERY is only run on aborted device, the
recovery handler could be simplified.

> 
> > 
> >>
> >> The recovery machenism needs to complete all ioucmds of a dying ubq
> >> to avoid leaking io_uring ctx. But as talked above, we are unsafe
> >> to call io_uring_cmd_done() in the recovery task if fallback wq happens
> >> to run simultaneously. This is a UAF case because io_uring ctx may be
> >> freed. Actually a similar case happens in
> >> (5804987b7272f437299011c76b7363b8df6f8515: ublk_drv: do not add a
> >> re-issued request aborted previously to ioucmd's task_work).
> > 
> > If you take the above approach, I guess there isn't such problem because
> > abort can handle the case well as before.
> 
> Ming, we did think this approach(quiesce, requeue rq/complete ioucmd)
> at the very beginning. But we decided to drop it because we don not want
> rely on 'flush fallback wq' machenism, which
> makes ublk_drv rely on io_uring's internal implementation.

Then the focus is 'flush fallback wq', please see my above question.


Thanks,
Ming

