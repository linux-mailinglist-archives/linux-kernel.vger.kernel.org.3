Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F171446698F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 19:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376531AbhLBSFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 13:05:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39380 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376514AbhLBSFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 13:05:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5652B62781;
        Thu,  2 Dec 2021 18:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BF7C00446;
        Thu,  2 Dec 2021 18:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638468104;
        bh=rUJ1eh03NM7a4uieufJQmw/DNhjhDKnTz4ClhbW3e8c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=r+HD++bj+UMTcnYVQ1gdqWg/oqocjlfpAUqA2gE1reYf8HYTz4/D4v1IF0Saj5v7c
         IJeiNp6gjKxW6MVtxJisWIHQPsqD5NFOcDcZkoC3uAen5BCsSeHyPVrnovKekvcipA
         nyQqRvvBsqhQBwj54InzKBB1MjSZ4k0Ja9B8r6u/y1lnYGKXwetVh4+kPck/OaAn/9
         /rPSrwL8HFDqHYkp9LOB7uG6QODVUhafXMeqdrEVSpX+Khj12QcwVNTpWjqeTbXqx3
         +UELdbz4KSpYhxLFFSGEoP4lmYlaiXKUL506mr4dP12kDmNVY5JV6zt1RK02Mfotzm
         KxqaaLI5IXvdw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4E93F5C04D3; Thu,  2 Dec 2021 10:01:44 -0800 (PST)
Date:   Thu, 2 Dec 2021 10:01:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH rcu 0/18] RCU no-CBs CPU updates for v5.17
Message-ID: <20211202180144.GN641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
 <20211202020347.GB430494@lapt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202020347.GB430494@lapt>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 06:03:47PM -0800, Yury Norov wrote:
> On Wed, Dec 01, 2021 at 04:28:48PM -0800, Paul E. McKenney wrote:
> > Hello!
> 
> ...
> 
> > 17.	Allow empty "rcu_nocbs" kernel parameter, courtesy of Frederic
> > 	Weisbecker.
> 
> ...
> 
> > Note that #17 might be updated given some ongoing work by Yury Norov
> > to support "none" for bitmaps, including the cpumask taken by the
> > rcu_nocbs kernel-boot parameter.
> 
> Hi Paul,
> 
> This is the only work that is needed to support 'none':
> 
> https://lkml.org/lkml/2021/11/24/2642
> 
> >From the last discussion, it's not clear is this 'none' needed or not.
> If needed, I'll submit the patch.

The question is whether rcu_nocbs= semantics like this are reasonable.
In other words, will systems administrators be OK with the idea of
differentiation between "rcu_nocbs=none" on the one hand and not
specifying rcu_nocbs at all on the other.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

	rcu_nocbs=	[KNL]
			The argument is a cpu list, as described above.

			In kernels built with CONFIG_RCU_NOCB_CPU=y,
			enable the no-callback CPU mode, which prevents
			such CPUs' callbacks from being invoked in
			softirq context.  Invocation of such CPUs' RCU
			callbacks will instead be offloaded to "rcuox/N"
			kthreads created for that purpose, where "x" is
			"p" for RCU-preempt, "s" for RCU-sched, and "g"
			for the kthreads that mediate grace periods; and
			"N" is the CPU number. This reduces OS jitter on
			the offloaded CPUs, which can be useful for HPC
			and real-time workloads.  It can also improve
			energy efficiency, especially for asymmetric
			multiprocessors.

			The cpulist specifies which are to be set to
			no-callback mode from boot.  In particular,
			"rcu_nocbs=none" specifies that no CPUs are in
			no-callback mode at boot, but that any of them
			can be offloaded at runtime.  In contrast, in
			kernels that boot with no rcu_nocbs kernel boot
			parameter, CPUs are not only in no-callback mode
			at boot, but they remain that way throughout.
