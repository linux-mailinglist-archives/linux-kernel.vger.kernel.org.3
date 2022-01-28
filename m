Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAD149FFBF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243902AbiA1Rr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:47:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38700 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiA1Rr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:47:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75455B82698;
        Fri, 28 Jan 2022 17:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33536C340E0;
        Fri, 28 Jan 2022 17:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643392044;
        bh=fe3LLriNJbj/gKNtEmQukHQOiIHZ1YakMJRXf8yzpGU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=U9S5LM8k53fjc3ZoZgpVwLV8Pf9bUQUxbCPPKavJMi2sSyQduduuLOaFGx91GbRB9
         be3gnTmHJ2FXzWOrLAx429VFTuX68rLjLBR/EfFVaC1i0e42dgUKg/xOhcxpzCDwaf
         vJ+sNv4A3bMV7lm00hcrDgcZ/1mp2gytQfOC9w6gJ85Bj6n6FEXYdrSwf4JzxyqFQr
         Q7+eTj8ztIMf2v0ldiriCOtwTDU4us8978zfulKRPRSL9wpeOfg9WsSDR2Grcn7jE5
         He+RNcz/kHK7FwMuZZGl/nNAn5dVROelm/cjze+obZ826JwYjaMB3VrUm3t7Lj1kjt
         zj1nXlCJm5nsA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E7E835C098D; Fri, 28 Jan 2022 09:47:23 -0800 (PST)
Date:   Fri, 28 Jan 2022 09:47:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yinan Liu <yinan@linux.alibaba.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, hca@linux.ibm.com,
        linux-s390@vger.kernel.org, andriin@fb.com
Subject: Re: ftrace hangs waiting for rcu
Message-ID: <20220128174723.GA2410054@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220127114249.03b1b52b@gandalf.local.home>
 <YfLjIOlGfFmbh1Zv@FVFF77S0Q05N>
 <yt9dy231yq90.fsf_-_@linux.ibm.com>
 <YfQCohKWJg9H+uID@FVFF77S0Q05N>
 <yt9dee4rn8q7.fsf@linux.ibm.com>
 <YfQVzba5thVs+qap@FVFF77S0Q05N>
 <20220128161547.GL4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128161547.GL4285@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 08:15:47AM -0800, Paul E. McKenney wrote:
> On Fri, Jan 28, 2022 at 04:11:57PM +0000, Mark Rutland wrote:
> > On Fri, Jan 28, 2022 at 05:08:48PM +0100, Sven Schnelle wrote:
> > > Hi Mark,
> > > 
> > > Mark Rutland <mark.rutland@arm.com> writes:
> > > 
> > > > On arm64 I bisected this down to:
> > > >
> > > >   7a30871b6a27de1a ("rcu-tasks: Introduce ->percpu_enqueue_shift for dynamic queue selection")
> > > >
> > > > Which was going wrong because ilog2() rounds down, and so the shift was wrong
> > > > for any nr_cpus that was not a power-of-two. Paul had already fixed that in
> > > > rcu-next, and just sent a pull request to Linus:
> > > >
> > > >   https://lore.kernel.org/lkml/20220128143251.GA2398275@paulmck-ThinkPad-P17-Gen-1/
> > > >
> > > > With that applied, I no longer see these hangs.
> > > >
> > > > Does your s390 test machine have a non-power-of-two nr_cpus, and does that fix
> > > > the issue for you?
> > > 
> > > We noticed the PR from Paul and are currently testing the fix. So far
> > > it's looking good. The configuration where we have seen the hang is a
> > > bit unusual:
> > > 
> > > - 16 physical CPUs on the kvm host
> > > - 248 logical CPUs inside kvm
> > 
> > Aha! 248 is notably *NOT* a power of two, and in this case the shift would be
> > wrong (ilog2() would give 7, when we need a shift of 8).
> > 
> > So I suspect you're hitting the same issue as I was.
> 
> And apparently no one runs -next on systems having a non-power-of-two
> number of CPUs.  ;-)

And the fix is now in mainline.

							Thanx, Paul

> > Thanks,
> > Mark.
> > 
> > > - debug kernel both on the host and kvm guest
> > > 
> > > So things are likely a bit slow in the kvm guest. Interesting is that
> > > the number of CPUs is even. But maybe RCU sees an odd number of CPUs
> > > and gets confused before all cpus are brought up. Have to read code/test
> > > to see whether that could be possible.
> > > 
> > > Thanks for investigating!
> > > Sven
