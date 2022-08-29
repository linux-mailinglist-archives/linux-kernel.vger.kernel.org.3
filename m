Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F8F5A4549
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiH2IjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiH2IjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:39:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B73B580B0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661762339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v2j+m0CnopBPwN2zgwV8gVecs2Pw/BDj7Ovr/IY2PF4=;
        b=BIHlPdRU3fF6wURWeTcfhX2yGVNyANRdYLJ1B48k1uLNOIPbiaKx7xRALADenl7/1nXMyo
        STsgKm6CxXiVvYrF0+eMF8lcKLM2J4HM1Hlv4Ar33HgxUFBUkE+bIas5BDinQvIg1zTemI
        RB7N8IfB54aU7ACQIFK9AuR7dComXfw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-nSa8vmhRPeO5wxBgTdlBwQ-1; Mon, 29 Aug 2022 04:38:54 -0400
X-MC-Unique: nSa8vmhRPeO5wxBgTdlBwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 818BE85A589;
        Mon, 29 Aug 2022 08:38:54 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ED87A2026D4C;
        Mon, 29 Aug 2022 08:38:49 +0000 (UTC)
Date:   Mon, 29 Aug 2022 16:38:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, ming.lei@redhat.com
Subject: Re: [RFC PATCH 0/9] ublk_drv: add USER_RECOVERY support
Message-ID: <Ywx7FmyXDCCI5Ouv@T590>
References: <20220824054744.77812-1-ZiyangZhang@linux.alibaba.com>
 <Ywwfi7Dgi0JC2kQ/@T590>
 <2c5def30-7116-7a0d-860d-74e1d36a91c6@linux.alibaba.com>
 <YwxU/3SQk3a83EbX@T590>
 <27a28f9f-8433-d6d9-b0b2-b4e21832fdc3@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27a28f9f-8433-d6d9-b0b2-b4e21832fdc3@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 03:29:08PM +0800, Ziyang Zhang wrote:
> On 2022/8/29 13:56, Ming Lei wrote:
> > On Mon, Aug 29, 2022 at 12:00:49PM +0800, Ziyang Zhang wrote:
> >> On 2022/8/29 10:08, Ming Lei wrote:
> >>> On Wed, Aug 24, 2022 at 01:47:35PM +0800, ZiyangZhang wrote:
> >>>> ublk_drv is a driver simply passes all blk-mq rqs to ublksrv[1] in
> >>>> userspace. For each ublk queue, there is one ubq_daemon(pthread).
> >>>> All ubq_daemons share the same process which opens /dev/ublkcX.
> >>>> The ubq_daemon code infinitely loops on io_uring_enter() to
> >>>> send/receive io_uring cmds which pass information of blk-mq
> >>>> rqs.
> >>>>
> >>>> Now, if one ubq_daemon(pthread) or the process crashes, ublk_drv
> >>>> must abort the dying ubq, stop the device and release everything.
> >>>> This is not a good choice in practice because users do not expect
> >>>> aborted requests, I/O errors and a released device. They may want
> >>>> a recovery machenism so that no requests are aborted and no I/O
> >>>> error occurs. Anyway, users just want everything works as uaual.
> >>>
> >>> I understand the requirement is that both /dev/ublkbN and /dev/ublkcN
> >>> won't be deleted & re-added from user viewpoint after user recovery,
> >>> so the device context won't be lost.
> >>
> >> Yes, after the 'process' is killed or crashed(such as segmentation fault)
> >> both /dev/ublkb0 and /dev/ublkc0 is not deleted.
> >>
> >>>
> >>>>
> >>>> This RFC patchset implements USER_RECOVERY support. If the process
> >>>> crashes, we allow ublksrv to provide new process and ubq_daemons.
> >>>> We do not support single ubq_daemon(pthread) recovery because a
> >>>> pthread rarely crashes.
> >>>>
> >>>> Recovery feature is quite useful for products do not expect to
> >>>> return any I/O error to frontend users.
> >>>
> >>> That looks one very ideal requirement. To be honest, no any block driver
> >>> can guarantee that 100%, so it is just one soft requirement?
> >>>
> >>> Cause memory allocation may fail, network may be disconnected,
> >>> re-creating pthread or process may fail too, ...
> >>
> >> Yes, I know there are many other problem which may cause a failure.
> >>
> >> The recovery mechanism only guarantees that rqs sent to ublksrv
> >> before crash are not aborted. Instead, ublk_drv re-issues the request
> >> itself and fio does not konw about it. Of course the backend must
> >> tolerate a double-write/read.
> > 
> > My comment is for 'do not expect to return any I/O error to frontend users',
> > and I still think it is just one soft requirement, and no one can
> > guarantee there isn't any error for frontend users really.
> 
> Yes, I get your point now. Indeed it is just one soft requirement.
> 
> > 
> >>
> >>>
> >>>> In detail, we support
> >>>> this scenario:
> >>>> (1) The /dev/ublkc0 is opened by process 0;
> >>>> (2) Fio is running on /dev/ublkb0 exposed by ublk_drv and all
> >>>>     rqs are handled by process 0.
> >>>> (3) Process 0 suddenly crashes(e.g. segfault);
> >>>> (4) Fio is still running and submit IOs(but these IOs cannot
> >>>>     complete now)
> >>>> (5) User recovers with process 1 and attach it to /dev/ublkc0
> >>>> (6) All rqs are handled by process 1 now and IOs can be
> >>>>     completed now.
> >>>>
> >>>> Note: The backend must tolerate double-write because we re-issue
> >>>> a rq sent to the old(dying) process before. We allow users to
> >>>> choose whether re-issue these rqs or not, please see patch 7 for
> >>>> more detail.
> >>>>
> >>>> We provide a sample script here to simulate the above steps:
> >>>>
> >>>> ***************************script***************************
> >>>> LOOPS=10
> >>>>
> >>>> __ublk_get_pid() {
> >>>> 	pid=`./ublk list -n 0 | grep "pid" | awk '{print $7}'`
> >>>> 	echo $pid
> >>>> }
> >>>>
> >>>> ublk_recover_kill()
> >>>> {
> >>>> 	for CNT in `seq $LOOPS`; do
> >>>> 		dmesg -C
> >>>>                 pid=`__ublk_get_pid`
> >>>>                 echo -e "*** kill $pid now ***"
> >>>> 		kill -9 $pid
> >>>> 		sleep 2
> >>>>                 echo -e "*** recover now ***"
> >>>>                 ./ublk recover -n 0
> >>>
> >>> The current behavior is that /dev/ublkb* is removed after device is
> >>> aborted because ubq daemon is killed.
> >>>
> >>> What if 'ublk recover' command isn't sent? So the current behavior
> >>> without recovery is changed? Or just changed with this feature enabled?
> >>
> >> No, I do not change the default behavior. You can verify this by running
> >> generic/002 and generic/003. These tests passes with either recovery enabled
> >> or disabled.
> >>
> >>
> >> (1) With recovery disabled, the monitor_work scheduled periodically or
> >>     STOP_DEV ctrl-cmd issued manually can cleanup everything and remove the
> >>     gendisk.
> >>
> >> (2)With recovery enabled, the monitor_work is not scheduled anymore, see
> >>    patch 9. So after a crash，all resources are still in kernel.
> >>    Then, there are two options for a user:
> >>     (a) You don't want to recover it, so just send STOP_DEV ctrl-cmd. This will
> >>         schedule monitor_work once and cleanup everything. Please see patch 5.
> > 
> > But what if people sends nothing and starts to reboot, then hang forever without
> > monitor_work involved.
> 
> Emm... you are right. But here is a conflict: I must reserve resources for a
> potential recovery mission, but I may hang if the user directly reboots...
> 
> What about add a systemd service?

That is definitely one solution, but maybe not the best one.

Another approach I thought of is:

1) after monitor work aborts the device, send one KOBJ_CHANGE event of
/dev/ublkcN to userspace, and userspace should check if the situation
needs to be recovered, no matter yes or not, it should tell ublk driver
via one control command

2) meantime monitor work starts a timer to monitor if the expected
command is received during one reasonable period. If not, the device
will be stopped. Otherwise the driver decides to recover or not.

> 
> > 
> >>     (b) You want to recover it, so just send START_RECOVERY ctrl-cmd. Then you
> >>         HAVE TO start a new process and send END_RECOVERY.
> >>
> >> Note: Actually I am thinking what if a user has sent START_RECOVERY but he fails
> >> to start a new process. I have a rough idea: just abort all rqs after we unqiuesce
> >> the request queue. But that is not included in this RFC patchset because I
> >> want to make it simpler. Maybe we can consider it later?
> > 
> > It is pretty easy to fail all in-queue requests when user recovery
> > can't move on.
> 
> Actually I wrote some code not included in the patchset:
> 
> (0) Now the request_queue is quiesced since we are after START_RECOVERY.
> 
> (1) mark all ubqs as 'force_abort', which makes ublk_queue_rq() fail
>     all IOs before calling blk_mq_atart_request() after unqiescing
>     request_queue.
> 
> (2) end(abort) all rqs inflight. Note that set of inflight does not change
>     since we are quiesced.
> 
> (3) unqiesce request_queue. Note that set of inflight rqs does not change
>     since we marked all ubqs as 'force_abort'. We have to unqiesce or del_gendisk()
>     will hang forever(not sure I am correct).
> 
> (4) del_gendisk()
> 
> (5) complete ALL ioucmds by calling io_uring_cmd_done()

The above should be done easily.

> 
> But this is really a ugly implementation since I do not consider:
> 
> (1) After START_RECOVERY, what if the new process crashes 'before' all FETCH_REQ
>     cmds are sent(some ubqs are ready while others are not).
> 
> (2) After START_RECOVERY, what if the new process crashes 'after' all FETCH_REQ
>     cmds are sent but 'before' END_RECOVERY.

Let's start simply. If everything doesn't work as expected, terminate
recovery and stop the disk.

> 
> 
> Ming, I suggest that this could be added in a future patch because I want to make
> this one simple and easy to understand :)
> 
> If you do not agree, I can add this in next version though I really think we should
> be more careful.
> 
> 
> > 
> >>
> >>>
> >>> BTW, I do not mean the change isn't reasonable, but suggest to document
> >>> the user visible change, so it can get reviewed from either user
> >>> viewpoint and technical point.
> >>>
> >>>> 		sleep 4
> >>>> 	done
> >>>> }
> >>>>
> >>>> ublk_test()
> >>>> {
> >>>>         dmesg -C
> >>>>         echo -e "*** add ublk device ***"
> >>>>         ./ublk add -t null -d 4 -i 1
> >>>>         sleep 2
> >>>>         echo -e "*** start fio ***"
> >>>>         fio --bs=4k \
> >>>>             --filename=/dev/ublkb0 \
> >>>>             --runtime=100s \
> >>>>             --rw=read &
> >>>>         sleep 4
> >>>>         ublk_recover_kill
> >>>>         wait
> >>>>         echo -e "*** delete ublk device ***"
> >>>>         ./ublk del -n 0
> >>>> }
> >>>>
> >>>> for CNT in `seq 4`; do
> >>>>         modprobe -rv ublk_drv
> >>>>         modprobe ublk_drv
> >>>>         echo -e "************ round $CNT ************"
> >>>>         ublk_test
> >>>>         sleep 5
> >>>> done
> >>>> ***************************script***************************
> >>>>
> >>>> You may run it with our modified ublksrv[3] which supports
> >>>> recovey feature. No I/O error occurs and you can verify it
> >>>> by typing
> >>>>     $ perf-tools/bin/tpoint block:block_rq_error
> >>>>
> >>>> The basic idea of USER_RECOVERY is quite straightfoward:
> >>>>
> >>>> (1) release/free everything belongs to the dying process.
> >>>>
> >>>>     Note: Since ublk_drv does save information about user process,
> >>>>     this work is important because we don't expect any resource
> >>>>     lekage. Particularly, ioucmds from the dying ubq_daemons
> >>>>     need to be completed(freed). Current ublk_drv code cannot satisfy
> >>>>     our need while considering USER_RECOVERY. So we refactor some code
> >>>>     shown in patch 1-5 to gracefully free all ioucmds.
> >>>>
> >>>> (2) init ublk queues including requeuing/aborting rqs.
> >>>>
> >>>> (3) allow new ubq_daemons issue FETCH_REQ.
> >>>>
> >>>> Here is steps to reocver:
> >>>>
> >>>> (1) For a user, after a process crash(how he detect a crash is not related
> >>>>     to this patchset), he sends START_USER_RECOVERY ctrl-cmd to
> >>>
> >>> I'd suggest to describe crash detector a bit at least, as one whole use case,
> >>> crash detector should be the input of the use case of user recovery, which is
> >>> usually one part of use case when modeling software requirement/design.
> >>
> >> This patchset tries to answer only one question: After a process crash, how to
> >> re-attach the device by another process. So I do not consider other questions
> >> too much, such as:
> >> (1) How to detect a crash?
> >> (2) Is IO hang a crash? Should we kill the process?
> >> (3) What if a blk-mq rq timeout? Does the process dies? Should we kill the process?
> > 
> > But you have to define what is 'crash', otherwise how can you define
> > what to be recovered?
> > 
> > So far please just define the crash as the whole daemon being dead
> > abnormally(without sending stop command) if you don't have better idea.
> 
> Yes, I argee that a ublk_drv crash means the whole daemon(process) being dead
> abnormally(without sending stop command).
> 
> I only consider the 'process' crash, not a single 'pthread'(ubq_daemon) crash.
> The process crashes if:
> 
> (1) The user kill it(the detector can do this, the backend can do this, or the
>     ublksrv_tgt can do this...)

Yeah, sometimes 'kill -9' is very useful for me to handle IO hang, then no
reboot is needed.

But it is just for debug or development of ublksrv, and that can be
thought of early shape of container-ware block device, and other kind of
block devices can't have such privilege, :-)

> 
> (2) It exits because of exception(segfault, divisor error, oom...)

True, that is why I raise the question because the problem to be
solved needs to be defined first.


Thanks, 
Ming

