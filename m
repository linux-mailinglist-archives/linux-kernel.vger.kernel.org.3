Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9CE5A46B3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiH2KCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiH2KC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716C511803
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661767342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wkKI/e1ijmRvMdolNAM15YHl9n1m93N5zsRwzW/IjhE=;
        b=OpynaSou4qPUngFwCiW020OKWYkYOsPUa7zILo/MdJanQetz2Wewzx+XI9rhNVasOVR4bD
        HyaaGoB4ODYEMFR3eRQXLrn9wuL7OYrKcrnxfsGosGqYPEYyJLtWc2schBGDnGtlDM9Iyi
        UR7HoborbKTVIsSN9f+50KpKEo2gdiI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-gK4hssKFO-elgX9KUB9tkw-1; Mon, 29 Aug 2022 06:02:20 -0400
X-MC-Unique: gK4hssKFO-elgX9KUB9tkw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C6A8101AA6A;
        Mon, 29 Aug 2022 10:02:20 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB6CB4010FCC;
        Mon, 29 Aug 2022 10:02:10 +0000 (UTC)
Date:   Mon, 29 Aug 2022 18:02:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, ming.lei@redhat.com
Subject: Re: [RFC PATCH 4/9] ublk_drv: refactor __ublk_rq_task_work() and
 aborting machenism
Message-ID: <YwyOnybsIm2+muXE@T590>
References: <20220824054744.77812-1-ZiyangZhang@linux.alibaba.com>
 <20220824054744.77812-5-ZiyangZhang@linux.alibaba.com>
 <YwxRVEQlIw3oWmwE@T590>
 <35dd7300-12ea-62ba-393e-145eae318944@linux.alibaba.com>
 <Ywx0oUcqvE9JcpnT@T590>
 <58f89905-b1a5-273b-58a8-ceba8aa7c1a7@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58f89905-b1a5-273b-58a8-ceba8aa7c1a7@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 05:09:45PM +0800, Ziyang Zhang wrote:
> On 2022/8/29 16:11, Ming Lei wrote:
> > On Mon, Aug 29, 2022 at 02:13:12PM +0800, Ziyang Zhang wrote:
> >> On 2022/8/29 13:40, Ming Lei wrote:
> >>> On Wed, Aug 24, 2022 at 01:47:39PM +0800, ZiyangZhang wrote:
> >>>> If one rq is handled by io_uring_cmd_complete_in_task(), after a crash
> >>>> this rq is actually handled by an io_uring fallback wq. We have to
> >>>> end(abort) this rq since this fallback wq is a task other than the
> >>>> crashed task. However, current code does not call io_uring_cmd_done()
> >>>> at the same time but do it in ublk_cancel_queue(). With current design,
> >>>> this does work because ublk_cancel_queue() is called AFTER del_gendisk(),
> >>>> which waits for the rq ended(aborted) in fallback wq. This implies that
> >>>> fallback wq on this rq is scheduled BEFORE calling io_uring_cmd_done()
> >>>> on the corresponding ioucmd in ublk_cancel_queue().
> >>>
> >>> Right.
> 
> [1]
> 
> >>>
> >>>>
> >>>> However, while considering recovery feature, we cannot rely on
> >>>> del_gendisk() or blk_mq_freeze_queue() to wait for completion of all
> >>>> rqs because we may not want any aborted rq. Besides, io_uring does not
> >>>> provide "flush fallback" machenism so we cannot trace this ioucmd.
> >>>
> >>> Why not?
> >>>
> >>> If user recovery is enabled, del_gendisk() can be replaced with
> >>> blk_mq_quiesce_queue(), then let abort work function do:
> >>>
> >>> - cancel all in-flight requests by holding them into requeue list
> >>>   instead of finishing them as before, and this way is safe because
> >>>   abort worker does know the ubq daemon is dying
> >>> - cancel pending commands as before, because the situation is same
> >>>   with disk deleted or queue frozen
> >>
> >> The problem is: we cannot control when fallback wq is scheduled.
> >> So we are unsafe to call io_uring_cmd_done() in another process.
> > 
> > What is the other process?
> 
> Hi Ming.
> 
> Actually patch 1-5 are all preparations for patch 6-9. So I suggest
> you may read patch 6-9 at the same time if you are confused on why
> I say there is a 'problem'. In current ublk_drv we really do not need
> to consider it(As I have explained in [1] and you replied 'Right').
> 
> Answer your question now: in the patchset, it is START_RECOVERY process,
> which calls ublk_recover_rq(). Please see patch 8.

Why does START_RECOVERY process need to call io_uring_cmd_done()?

As I mentioned, clean the old ubq_daemon by ublk_cancel_queue()
just like before. Then the recovery handling can be simplified a lot.

> 
> > 
> > It can't be fallback wq since any ublk request is aborted at the beginning
> > of __ublk_rq_task_work().
> 
> With recovery feature enabled, we cannot abort the rq, but just let
> __ublk_rq_task_work() return. We will requeue the rq soon.

Yeah, the request is requeued, and the queue is quiesced during
aborting in ublk_cancel_queue().

> 
> > 
> > It shouldn't be the process calling ublk_cancel_dev(), since it is
> > safe to call io_uring_cmd_done() if ubq->nr_io_ready > 0.
> > 
> > Or others?
> It is START_RECOVERY process(or the 'abort_work' you proposed).
> It is whatever that calls io_uring_cmd_done() on the old ioucmd
> belonging to the dying ubq_daemon.
> 
> > 
> >> Otherwise, there is a UAF, just as
> >> (5804987b7272f437299011c76b7363b8df6f8515: ublk_drv: do not add a
> >> re-issued request aborted previously to ioucmd's task_work).
> > 
> > As I mentioned, del_gendisk() can be replaced with
> > blk_mq_quiesce_queue() in case of user recovery, then no any new
> > request can be queued after blk_mq_quiesce_queue() returns.
> 
> For this, +1.
> 
> > 
> >>
> >> Yeah I know the answer is very simple: flush the fallback wq.
> >> But here are two more questions:
> > 
> > I don't see why we need to flush fallback wq, care to provide some
> > details?
> 
> Anyway, here is a case:
> 
> (1) Assume there is only one tag, only one ubq.
> 
> (2) The ublk_io is ACTIVE, which means an ioucmd(cmd_1) is sent from ublksrv
>     and ublk_drv has not completed it yet(no io_uring_cmd_done() is called).
> 
> (3) New rq is coming, and ublk_queue_rq() is called.
> 
> (4) The ublksrv process crashes(PF_EXITING).
> 
> (5) io_uring_cmd_complete_in_task(cmd_1) is called in ublk_queue_rq(), and
>     cmd_1 is put into a fallback_list.
> 

What I suggested is to abort ubq daemon in ublk_abort_device() like before,
but without failing in-flight request, just quiesce queue and requeue all
in-flight request.

Specifically, you can wait until all in-flight requests are requeued,
and the similar handling has been used by NVMe for long time, then
fallback wq can be thought as being flushed here.

There are two kinds of in-flight requests:

1) UBLK_IO_FLAG_ACTIVE is set, that is what ublk_abort_queue() needs to
wait until req->state becomes IDLE, which can be done via the change at
the entry of __ublk_rq_task_work():

	if (unlikely(task_exiting)) {
          if (user_recovery)
		  	blk_mq_requeue_request(req, false);
		  else
		    blk_mq_end_request(req, BLK_STS_IOERR);
	}

2) UBLK_IO_FLAG_ACTIVE is cleared
  - no need to wait since io_uring_cmd_done() is called for this
	request


> (6) We want to re-attach a new process and assing a new ioucmd(cmd_2) to ublk_io.
> 
> (7) We try to complete the old cmd_1 now by io_uring_cmd_done(cmd_1)...
> 
> (8) Shortly after (7), io_uring exit work is scheduled and it finds that no
>     inflight iocumd exists, so it starts to release some resources
> 
> (9) Shortly after (8), in fallback wq, a null-deref on cmd_1 or ctx->refs may
>     happen, just like
>     (5804987b7272f437299011c76b7363b8df6f8515: ublk_drv: do not add a
>     re-issued request aborted previously to ioucmd's task_work).
> 
> If we flush fallback wq before (7), then everything is OKAY.
> 
> Why this happens? The root cause is that we do not ALWAYS complete io_uring cmd
> in ublk_rq_task_work_cb(). The commit: "ublk_drv: do not add a re-issued request
> aborted previously to ioucmd's task_work" does fix a problem. But I think we
> really need to refactor ublk_rq_task_work_cb() which focuses on old ioucmd.

The race is because you drop the existed abort mechanism for user
recovery. If existed abort is reused for recovery, no above race at all.

> 
> > 
> >>
> >> (1) Should ublk_drv rely on the fallback wq machenism?
> >>     IMO, ublk_drv should not know detail of io_uring_cmd_complete_in_task()
> >>     because its implementation may change in the future.
> >>     BTW, I think current ublk_rq_task_work_cb() is not correct because
> >>     it does not always call io_uring_cmd_done() before returning.
> >>     nvme_uring_cmd_end_io() always calls io_uring_cmd_done() for each ioucmd
> >>     no matter the rq succeeds or fails.
> >>
> >> (2) Suppose io_uring does export the symbol 'flush_fallback_work', should we call
> >>     it before starting a new process(recovery)?
> >>     What if fallback wq is not scheduled immediately if there are many processes
> >>     running and the system overhead is heavy. In this case the recovery process
> >>     may wait for too long. Really we should not depend on fallback wq and please
> >>     let the fallback wq complete the ioucmd itself.
> >>
> >>>
> >>> With this way, the current abort logic won't be changed much.
> >>>
> >>> And user recovery should only be started _after_ ublk device is found
> >>> as aborted.
> >>
> >> START_RECOVERY will check if all ubq_daemons(the process) are PF_EXITING.
> > 
> > That is different. If START_RECOVERY is only run on aborted device, the
> > recovery handler could be simplified.
> 
> But stop_dev could become complicated since with recovery enabled, stop_dev
> has to do different things. Please see patch 5. Really we do not have to
> do anything after the crash until user sends START_RECOVERY or STOP_DEV.

99% is same, the extra thing to just fail all in-queue requests by unquiesce queue
before stopping one to-be-recovered device really.


Thanks, 
Ming

