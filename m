Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAA15ADCD1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 03:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiIFBM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 21:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIFBMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 21:12:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E025F218
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 18:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662426743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ApCnciwJ1mb5up7ml58pgOir0AUmZsOdBdtbsuYeq8=;
        b=L7r0thaS3JKl3xvpMr7fkk7i6SDyjnvhZtZfiW6poLhTlVyCQKptddELfEbxB9hZ9GZrNe
        os0+A6TaykLLxw2F5oixGR3oO+J23vh1ktcmYmwA15prZO5LLHvWnThiCoHzraoyXxwMTC
        9Qw8ryJKOVYwruBqmKuhtIW3VtvAUEI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-yHYLvRvMOrKbakOxPbp9rg-1; Mon, 05 Sep 2022 21:12:19 -0400
X-MC-Unique: yHYLvRvMOrKbakOxPbp9rg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 427B28037AA;
        Tue,  6 Sep 2022 01:12:19 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DF9C40D296C;
        Tue,  6 Sep 2022 01:12:12 +0000 (UTC)
Date:   Tue, 6 Sep 2022 09:12:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, ming.lei@redhat.com
Subject: Re: [RFC PATCH V2 5/6] ublk_drv: consider recovery feature in
 aborting mechanism
Message-ID: <YxaeZ1Ap4IxaKSlL@T590>
References: <20220831155136.23434-1-ZiyangZhang@linux.alibaba.com>
 <20220831155136.23434-6-ZiyangZhang@linux.alibaba.com>
 <CAFj5m9J2vrqh0U11iVtxdDUPcxDWRPA0K+14e9Si61QGySRq8w@mail.gmail.com>
 <8984c9be-6ef0-95c7-ec02-e1213f3d45a1@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8984c9be-6ef0-95c7-ec02-e1213f3d45a1@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 07:23:49PM +0800, Ziyang Zhang wrote:
> On 2022/9/3 21:30, Ming Lei wrote:
> > On Wed, Aug 31, 2022 at 11:54 PM ZiyangZhang
> > <ZiyangZhang@linux.alibaba.com> wrote:
> >>
> >> We change the default behavior of aborting machenism. Now monitor_work
> >> will not be manually scheduled by ublk_queue_rq() or task_work after a
> >> ubq_daemon or process is dying(PF_EXITING). The monitor work should
> >> find a dying ubq_daemon or a crash process by itself. Then, it can
> > 
> > Looks you don't consider one dying ubq_daemon as one crash candidate.
> > Most io implementation is done in the ubq pthread, so it should be
> > covered by the crash recovery.
> > 
> >> start the aborting machenism. We do such modification is because we want
> >> to strictly separate the STOP_DEV procedure and monitor_work. More
> >> specifically, we ensure that monitor_work must not be scheduled after
> >> we start deleting gendisk and ending(aborting) all inflight rqs. In this
> >> way we are easy to consider recovery feature and unify it into existing
> >> aborting mechanism. Really we do not want too many "if can_use_recovery"
> >> checks.
> > 
> > Frankly speaking, not sure we need to invent new wheel for the
> > 'aborting' mechanism.
> > 
> > In theory, you needn't change the current monitor work and cancel
> > dev/queue. What you need is how to handle the dying ubq daemon:
> > 
> > 1) without user recovery, delete disk if any ubq daemon is died.
> > 
> > 2) with user recovery:
> >     - quiesce request queue and wait until all inflight requests are
> > requeued(become IDLE);
> >     - call io_uring_cmd_done for any active io slot
> >     - send one kobj_uevent(KOBJ_CHANGE) to notify userspace for handling
> >       the potential crash; if it is confirmed as crash by userspace,
> >       userspace will send command to handle it.
> >     (this way will simplify userspace too, since we can add one utility
> >     and provide it via udev script for handling rec
> > 
> > Checking one flag lockless is usually not safe, also not sure why we
> > need such flag here, and the original check is supposed to work.
> > 
> > overy)
> > 
> >>
> >> With recovery feature disabled and after a ubq_daemon crash:
> >> (1) monitor_work notices the crash and schedules stop_work
> > 
> > driver can't figure out if it is crash, and it can just see if the
> > ubq deamon is died or not. And crash detection logic should be done
> > in userspace, IMO.
> > 
> >> (2) stop_work calls ublk_stop_dev()
> >> (3) In ublk_stop_dev():
> >>     (a) It sets 'force_abort', which prevents new rqs in ublk_queue_rq();
> > 
> > Please don't add new flag in fast path lockless, and the original check
> > is supposed to be reused for recovery feature.
> > 
> >>             If ublk_queue_rq() does not see it, rqs can still be ended(aborted)
> >>                 in fallback wq.
> >>         (b) Then it cancels monitor_work;
> >>         (c) Then it schedules abort_work which ends(aborts) all inflight rqs.
> >>         (d) At the same time del_gendisk() is called.
> >>         (e) Finally, we complete all ioucmds.
> >>
> >> Note: we do not change the existing behavior with reocvery disabled. Note
> >> that STOP_DEV ctrl-cmd can be processed without reagrd to monitor_work.
> >>
> >> With recovery feature enabled and after a process crash:
> >> (1) monitor_work notices the crash and all ubq_daemon are dying.
> >>     We do not consider a "single" ubq_daemon(pthread) crash. Please send
> >>         STOP_DEV ctrl-cmd which calling ublk_stop_dev() for this case.
> > 
> > Can you consider why you don't consider it as one crash? IMO, most of
> > userspace block logic is run in ubq_daemon, so it is reasonable to
> > consider it.
> > 
> > ublk_reinit_dev() is supposed to be run in standalone context, just like
> > ublk_stop_dev(), we need monitor_work to provide forward progress,
> > so don't run wait in monitor work.
> > 
> > And please don't change this model for making forward progress.
> > 
> > 
> 
> Hi, Ming.
> 
> I will take your advice and provide V4 soon. Here is the new design:
> 
> (0) No modification in fast patch. We just requeue rqs with a dying ubq_daemon
>     and schedule monitor_work immediately.
>     
>     BTW: I think here we should call 'blk_mq_delay_kick_requeue_list()' after
>     requeuing a rq. Otherwise del_gendisk() in ublk_stop_dev() hangs.

No.

IMO you can add one helper for either ending or adding request in
requeue list, then code is still clean.

And when you call del_gendisk() in case of being in recovery state,
blk_mq_unquiesce_queue() will handle/abort them and make del_gendisk()
move on.

> 
> (1) Add quiesce_work, which is scheduled by monitor_work after a ubq_daemon
>     is dying with recovery enabled.
> 
> (2) quiesce_work runs ublk_quiesce_dev(). It accquires the ub lock, and
>     quiescses the request queue(only once). On each dying ubq, call
>     ublk_quiesce_queue(). It waits until all inflight rqs(ACTIVE) are
>     requeued(IDLE). Finally it completes all ioucmds.
>     Note: So We need to add a per ubq flag 'quiesced', which means
>     we have done this 'quiesce && clean' stuff on the ubq.

ubq->nr_io_ready should be reused for checking if the queue is quiesced.
It is actually same with current usage.

> 
> (3) After the request queue is quiesced, change ub's state to STATE_QUIESCED.
>     This state can be checked by GET_DEV_INFO ctrl-cmd, just like STATE_LIVE. So
>     user can detect a crash by sending GET_DEV_INFO and getting STATE_QUIESCED
>     back.
>     
>     BTW, I'm unsure that sending one kobj_uevent(KOBJ_CHANGE) really helps. Users
>     have may ways to detect a dying process/pthread. For example, they can 'ps'
>     ublksrv_pid or check ub's state by GET_DEV_INFO ctrl-cmd. Anyway, this work
>     can be done in the future. We can introduce a better way to detect a crash.
>     For this patchset, let's focus on how to deal with a dying ubq_daemon.
>     Do you agree?

kobj_uevent(KOBJ_CHANGE) is useful, which can avoid userspace's polling on
device. That provides one accurate chance for userspace utility to confirm
if it is one really crash.

And checking if ubq daemon/process is crashed is really userspace's
responsibility, but sending the uevent after ubq daemon/process is dying
is helpful for userspace to run the check, at least polling can be
avoided, or done in time.

If you don't want to add it from beginning, that is fine, and we can do it
after your patchset is merged.

> 
> (4) Do not change ublk_stop_dev(). BTW, ublk_stop_dev() and ublk_quiescd_dev()
>     exclude each other by accqiring ub lock.
> 
> (5) ublk_stop_dev() has to consider a quiesced ubq. It should unquiesce request
>     queue(only once) if it is quiesced. There is nothing else ublk_stop_dev()
>     has to do. Inflight rqs requeued before will be aborted naturally by
>     del_gendisk().
> 
> (6) ublk_quiesce_dev() cannot be run after gendisk is removed(STATE_DEAD).
> 
> (7) No need to run ublk_quiesce_queue() on a 'quiesced' ubq by checking the flag.
>     Note: I think this check is safe here.
> 
> (8) START_USER_RECOVERY needs to consider both a dying process and pthread(ubq_daemon).
> 
>     For a dying process, it has to reset ub->dev_info.ublksrv_pid and ub->mm. This can
>     by done by passing a qid = -1 in ctrl-cmd. We should make sure all ubq_daemons
>     are dying in this case.
>     
>     otherwise it is a dying pthread. Only this ubq is reinit. Users may send many
>     START_USER_RECOVERY with different qid to recover many ubqs.

The simplest handling might be to exit all ublk queues first, and re-create one
new process to recover all since the request queue is required to be
quiesced first, and all ublk queue is actually quiesced too. So from user
viewpoint, there is nothing visible comparing with just recovering
single ubq daemon/pthread.


Thanks,
Ming

