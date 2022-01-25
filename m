Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D8949B3D8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382643AbiAYMTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:19:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34050 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381836AbiAYMP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:15:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8843C60E9A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39FDC340E0;
        Tue, 25 Jan 2022 12:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643112957;
        bh=mAalbFUhg2H+qPw2Vc2gO83s4pxQ5Vy4efnC7pLZGR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QwwQgU8avm+TrG4TnU9Qk/i93XlpmimHmamC7WJ3/hN2Ty7sQvTJzli0Y0+5CoFDR
         YrEsyYiZbVI78qxbTCES3YvWQKPGLc87fIJfq/rnINAYPNfpkhAiBZZM0V7+CaFte6
         javZTiP7yecDelmXUqTt5JwHD2D7GoLG64YtzHsZfZYqrlMFd+rEeomfSt4i8ZCVFG
         luh0FGhKPqCpl77sA3bFE+Otlv1rI0xt8jFGNTs0phibdio4iFzEQD4mazuUd61UXA
         +EZlxFu4P6mkLxW/wVlXwQhy42gaLaFoVDbZBSlOzLvHk3PC9ob5Sk5IOhTiuhfKFM
         gZ3GZnkiXdwKQ==
Date:   Tue, 25 Jan 2022 13:15:45 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Balbir Singh <sblbir@amazon.com>
Subject: Re: [resend RFC 2/3] sched/prctl: add PR_SCHED_CORE_SHARE command
Message-ID: <20220125121545.rul2vqgrc7io4vio@wittgenstein>
References: <20220124105247.2118990-1-brauner@kernel.org>
 <20220124105247.2118990-3-brauner@kernel.org>
 <CABk29NtFnswO3iaQobbijV1-FwCJd06prm2UMq7S8Tt736hYMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABk29NtFnswO3iaQobbijV1-FwCJd06prm2UMq7S8Tt736hYMA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 04:31:05PM -0800, Josh Don wrote:
> Hey Christian,
> 
> This seems like a reasonable extension of the interface to me.
> 
> > @@ -200,6 +212,20 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
> >                 __sched_core_set(current, cookie);
> >                 goto out;
> >
> > +       case PR_SCHED_CORE_SHARE:
> > +               rcu_read_lock();
> > +               p = task_by_pid(pid_share);
> > +               if (!p)
> > +                       err = -ESRCH;
> > +               else if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
> > +                       err = -EPERM;
> > +               if (!err)
> > +                       cookie = sched_core_clone_cookie(p);
> > +               rcu_read_unlock();
> > +               if (err)
> > +                       goto out;
> > +               break;
> > +
> 
> Did you consider folding this into SCHED_CORE_SHARE_TO? SHARE_TO isn't
> using the last arg right now; it could use it as an override for the
> task we copy the cookie from instead of always choosing 'current'.
> Since the code currently rejects any SCHED_CORE prctl calls with a
> non-zero last arg for commands other than SCHED_CORE_GET, this would
> be a safe change for userspace.

Yeah, that sounds good to me too. I can certainly rework the patch to do
that!
