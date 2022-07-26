Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A625580B8B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 08:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbiGZGWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 02:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238030AbiGZGWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 02:22:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3073B2C11D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 23:17:44 -0700 (PDT)
Date:   Tue, 26 Jul 2022 08:17:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658816256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=seywIrZuJiy/IICwF1J+gxCYNQtkqwoLOV/yyVDVEwE=;
        b=JGqSPOElTNJ3GTlZY9cWfNylDo5e3o0to5raPlO6oHdOU59nIR3yV3IalscZUBQNEuyv4L
        +KoUn6AY+pciyM1DdwjSDJ0IrJn6rt1vkr3QtP7tAi/FXNDeUxnxnis7iISQcj4VKQg0b6
        /l2KmxIiQUgEkEDPSwOrePQ3p1Qo7WMmlyI7AW5ztRl3BY16wyIFGFAbxzcSSVRKMdKwSu
        GcAnaexKQiqZkV8iwB/MJzgrpmWR7caak9oht6WhZiNq4uwd/HIc7JAV16w2bEN2xWWafm
        JxnJMni3vTtN+SeNjQiccmRDYMdKp+zvQfiwO+d+60+LchVtWe3GDpzksrBn+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658816256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=seywIrZuJiy/IICwF1J+gxCYNQtkqwoLOV/yyVDVEwE=;
        b=A5X7aFMT9UX+XPYRssDIJO3onESHlBEhL5pQRV9zOQSjNR3mV+GsSRlJTF4egEax8fOBly
        L9EKRrr+n8DxLtCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 2/2] sched: Consider task_struct::saved_state in
 wait_task_inactive().
Message-ID: <Yt+G/somh8qcKc/R@linutronix.de>
References: <20220720154435.232749-1-bigeasy@linutronix.de>
 <20220720154435.232749-3-bigeasy@linutronix.de>
 <xhsmhy1whdqy9.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xhsmhy1whdqy9.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-25 18:47:58 [+0100], Valentin Schneider wrote:
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3257,6 +3257,40 @@ int migrate_swap(struct task_struct *cur
> >  }
> >  #endif /* CONFIG_NUMA_BALANCING */
> >
> > +#ifdef CONFIG_PREEMPT_RT
>=20
> Would something like the below be useful?
>=20
> /*
>  * If p->saved_state is anything else than TASK_RUNNING, then p blocked o=
n an
>  * rtlock *before* voluntarily calling into schedule() after setting its =
state
>  * to X. For things like ptrace (X=3DTASK_TRACED), the task could have mo=
re work
>  * to do upon acquiring the lock before whoever called wait_task_inactive=
()
>  * should return. IOW, we have to wait for:
>  *
>  *   p.saved_state =3D TASK_RUNNING
>  *   p.__state     =3D X
>  *
>  * which implies the task isn't blocked on an RT lock and got to schedule=
() by
>  * itself.
>  *
>  * Also see comments in ttwu_state_match().
>  */

This sums up the code. I would s/schedule/schedule_rtlock/ since there
are two entrypoints.

=E2=80=A6
> > @@ -3346,7 +3382,7 @@ unsigned long wait_task_inactive(struct
> >                * running right now), it's preempted, and we should
> >                * yield - it could be a while.
> >                */
> > -		if (unlikely(queued)) {
> > +		if (unlikely(wait)) {
>=20
> We could be repeatedly doing this for as long as the task is blocked on t=
he
> rtlock, but IIUC that's the same story on !PREEMPT_RT if it's just a queu=
ed
> task preempted by a higher prio task, it may take a while for it to
> schedule() and dequeue...

Yes.

> >                       ktime_t to =3D NSEC_PER_SEC / HZ;
> >
> >                       set_current_state(TASK_UNINTERRUPTIBLE);

Sebastian
