Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C6A49FDBE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349960AbiA1QMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:12:10 -0500
Received: from foss.arm.com ([217.140.110.172]:51886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349958AbiA1QMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:12:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB099113E;
        Fri, 28 Jan 2022 08:12:08 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.13.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60D523F793;
        Fri, 28 Jan 2022 08:12:06 -0800 (PST)
Date:   Fri, 28 Jan 2022 16:11:57 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
        linux-s390@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: ftrace hangs waiting for rcu
Message-ID: <YfQVzba5thVs+qap@FVFF77S0Q05N>
References: <20220127114249.03b1b52b@gandalf.local.home>
 <YfLjIOlGfFmbh1Zv@FVFF77S0Q05N>
 <yt9dy231yq90.fsf_-_@linux.ibm.com>
 <YfQCohKWJg9H+uID@FVFF77S0Q05N>
 <yt9dee4rn8q7.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dee4rn8q7.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 05:08:48PM +0100, Sven Schnelle wrote:
> Hi Mark,
> 
> Mark Rutland <mark.rutland@arm.com> writes:
> 
> > On arm64 I bisected this down to:
> >
> >   7a30871b6a27de1a ("rcu-tasks: Introduce ->percpu_enqueue_shift for dynamic queue selection")
> >
> > Which was going wrong because ilog2() rounds down, and so the shift was wrong
> > for any nr_cpus that was not a power-of-two. Paul had already fixed that in
> > rcu-next, and just sent a pull request to Linus:
> >
> >   https://lore.kernel.org/lkml/20220128143251.GA2398275@paulmck-ThinkPad-P17-Gen-1/
> >
> > With that applied, I no longer see these hangs.
> >
> > Does your s390 test machine have a non-power-of-two nr_cpus, and does that fix
> > the issue for you?
> 
> We noticed the PR from Paul and are currently testing the fix. So far
> it's looking good. The configuration where we have seen the hang is a
> bit unusual:
> 
> - 16 physical CPUs on the kvm host
> - 248 logical CPUs inside kvm

Aha! 248 is notably *NOT* a power of two, and in this case the shift would be
wrong (ilog2() would give 7, when we need a shift of 8).

So I suspect you're hitting the same issue as I was.

Thanks,
Mark.

> - debug kernel both on the host and kvm guest
> 
> So things are likely a bit slow in the kvm guest. Interesting is that
> the number of CPUs is even. But maybe RCU sees an odd number of CPUs
> and gets confused before all cpus are brought up. Have to read code/test
> to see whether that could be possible.
> 
> Thanks for investigating!
> Sven
