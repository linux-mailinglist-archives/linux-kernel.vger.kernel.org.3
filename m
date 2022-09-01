Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D333C5A9991
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiIAN6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbiIAN6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:58:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419B22AE18
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:58:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 90530CE26FF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 13:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0190C433D6;
        Thu,  1 Sep 2022 13:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662040688;
        bh=tUS4V57CewiRmJevTsnByY/bYai5aJBKXJ6SZgngqQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ohA9/a79mKnH6u2DvwvlVpVVQPpvpXrtrZJ7yLJtZCribTifRkdm1jsZpww5B60sH
         VyIClldwEwM88r7VOjNxZAvQSEGOb13HCsZhAzDRxeSGAlayF8Xm/qkCIj4b4fv8RZ
         KuO5ilQH24zA8L0mrxxnWnOMZnve9drY6r64sXhAThRhvnZ9R5SbW7nJfrDEZhKPPH
         AfqLS0Rmv2yinyBhxl/Bu1kvcS/NyF3TWCJEei4pFvThUe5mKXgXOZCdxejb1MGnAS
         76ovpi3fr4iU4bkX51ENfJQ6WZ98P3dVA7cx/KDCuEtk1wfctqzVZo58DwcLxBAUa1
         Z2dl07gXvk7Kw==
Date:   Thu, 1 Sep 2022 15:58:02 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 4/4] seccomp: add the synchronous mode for seccomp_unotify
Message-ID: <20220901135802.oeefj2bmsy5gcsmy@wittgenstein>
References: <20220830014356.5364-1-avagin@gmail.com>
 <20220830014356.5364-5-avagin@gmail.com>
 <20220830104310.cpacj4dxqpgucwh3@wittgenstein>
 <CANaxB-x-TAJLNVKVwDm55wVrHo0YxewuU_+7ast+63Q18eT4gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANaxB-x-TAJLNVKVwDm55wVrHo0YxewuU_+7ast+63Q18eT4gQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 02:23:24PM -0700, Andrei Vagin wrote:
> On Tue, Aug 30, 2022 at 3:43 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Mon, Aug 29, 2022 at 06:43:56PM -0700, Andrei Vagin wrote:
> > > seccomp_unotify allows more privileged processes does actions on behalf
> > > of less privileged processes.
> > >
> > > In many cases, the workflow is fully synchronous. It means a target
> > > process triggers a system call and passes controls to a supervisor
> > > process that handles the system call and returns controls to the target
> > > process. In this context, "synchronous" means that only one process is
> > > running and another one is waiting.
> > >
> > > There is the WF_CURRENT_CPU flag that is used to advise the scheduler to
> > > move the wakee to the current CPU. For such synchronous workflows, it
> > > makes context switches a few times faster.
> > >
> > > Right now, each interaction takes 12µs. With this patch, it takes about
> > > 3µs.
> >
> > Seems like a nice idea though I leave it to the sched people to judge
> > whether this is sane or not. So the supervisor which gets woken will be
> > moved to the current cpu in this synchronous scenario.
> >
> > I have no strong opinions on this patch. There are two things I wonder
> > about. First, how meaningful is that speed up given that the supervisor
> > will most often do a lot of heavy-handed things anyway.
> 
> I would not use the "most often" phrase in this case;). It is true for LXC-like
> use cases when we need to handle rare syscalls. In this case, the performance
> of this interface doesn't play a big role. But my use case is very different. I
> have a prototype of the gVisor platform, where seccomp is used to trap
> guest system calls. In this case, the difference between 12µs and 3µs is
> tremendous.

Oh yeah, makes sense. I don't know enough about gVisor but I know we can
trust your word! :)

> 
> The idea of WF_CURRENT_CPU is not mine. I spied it from the umcg series.
> I took the second patch from that series without any changes.
> 
> >
> > Second, this flag is a very specific thing and I wonder how much
> > userspace will really use this and what's more use this correctly.
> >
> > Just to note that LXD - one of the biggest user of this feature - isn't
> > synchronous iiuc for example. Each container gets a separate seccomp
> > supervisor thread (well, go routine but whatever) which exposes a socket
> > that the container manager connects to and sends the seccomp
> > notifications it received from its payload according to an api we
> > established. And each notification is handled in a separate thread
> > (again, go routine but whatever).
> 
> It could be synchronous if seccomp events had been handled in [lxc monitor]. But
> right now, [lxc monitor] is just a proxy. In this case, you are right, lxc will

Yep.

> not get any benefits by setting this flag. But we can look at this from another
> side. If we add these changes, we will have another big user of the interface. I
> think the number of gVisor containers that are started each day is comparable
> with the number of LXC/LXD containers.

Sure, if there's users that would benefit from this then no reason to
not consider it. It's just a lot of low-level knobs we give userspace
here but I guess for the notifier it makes sense.

> 
> >
> > >
> > > This change introduce the SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP flag that
> > > it used to enable the sync mode.
> > >
> > > Signed-off-by: Andrei Vagin <avagin@gmail.com>
> > > ---
> > >  include/uapi/linux/seccomp.h |  4 ++++
> > >  kernel/seccomp.c             | 35 +++++++++++++++++++++++++++++++++--
> > >  2 files changed, 37 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> > > index 0fdc6ef02b94..dbfc9b37fcae 100644
> > > --- a/include/uapi/linux/seccomp.h
> > > +++ b/include/uapi/linux/seccomp.h
> > > @@ -115,6 +115,8 @@ struct seccomp_notif_resp {
> > >       __u32 flags;
> > >  };
> > >
> 
> <snip>
> 
> > >
> > >  #ifdef SECCOMP_ARCH_NATIVE
> > > @@ -1117,7 +1120,10 @@ static int seccomp_do_user_notification(int this_syscall,
> > >       INIT_LIST_HEAD(&n.addfd);
> > >
> > >       atomic_add(1, &match->notif->requests);
> > > -     wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
> > > +     if (match->notif->flags & SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP)
> > > +             wake_up_poll_on_current_cpu(&match->wqh, EPOLLIN | EPOLLRDNORM);
> > > +     else
> > > +             wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
> >
> > (We're accumulating a lot of conditional wake primitives in the notifier.)
> >
> 
> I am not sure that I understand what you mean here.

I just meant that we have 

if (wait_killable)
	err = wait_for_completion_killable(&n.ready);
else
	err = wait_for_completion_interruptible(&n.ready);

and now also

if (match->notif->flags & SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP)
        wake_up_poll_on_current_cpu(&match->wqh, EPOLLIN | EPOLLRDNORM);
else
        wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);

which is a bit unpleasant but nothing that would mean we can't do this.
