Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4883C46D61E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhLHOyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:54:24 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38426 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbhLHOyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:54:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3EC86CE21CE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 14:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD75C00446;
        Wed,  8 Dec 2021 14:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638975048;
        bh=SY6g2mKdOsoXiP94ii+YebPCM9jN5jV77Gtv02GPNwI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WSQu+uYtKyAhSYUARs168htZqaSrt2G2hi79Q0UQWiRzDjjUhPrXUnSw/ECGhW+fu
         qTMgkAlq3Ns5p2vwIAgJ0a7JMOb0l3my+NiJ4RlHnfaX/vIrpLYmsMY+ziN8AdIssS
         GtMV7Hw9K4yvq3KMYcgDTG7eEeAQxIOl1Dr8CaEmz0Ko83IrliPoqXXQp53kZK8owO
         wYHL6BHQwO16atjr5jXoNSwXLW2JUcG9CQkOwayqv1oS3R/aIRP/YdCQ+p+dT5+iRR
         P9pJgfrEsFUcI7X2h2v4QrauRSDGGzoOR5PxrmQ9WAaRfQOjeKkGNeGl4wOD/XE7Y+
         E1nt4CI83kAdw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 04A4A5C0308; Wed,  8 Dec 2021 06:50:48 -0800 (PST)
Date:   Wed, 8 Dec 2021 06:50:47 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "shenkai (D)" <shenkai8@huawei.com>,
        "Schander, Johanna 'Mimoja' Amelie" <mimoja@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        hewenliang4@huawei.com, hushiyuan@huawei.com,
        luolongjun@huawei.com, hejingxian <hejingxian@huawei.com>
Subject: Re: [PATCH] use x86 cpu park to speedup smp_init in kexec situation
Message-ID: <20211208145047.GR641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <87ft22dxop.fsf@nanos.tec.linutronix.de>
 <27357c74bdc3b52bdf59e6f48cd8690495116d64.camel@infradead.org>
 <877dnedt7l.fsf@nanos.tec.linutronix.de>
 <87zh09tcqz.fsf@nanos.tec.linutronix.de>
 <1d2a7bc911da2bbaa4c441d269287fbb5b1bc8d7.camel@infradead.org>
 <5039f6178715dc4725a8c7f071dfd9ef5d70ae43.camel@infradead.org>
 <d7939a95731de8b8eb9245c330f014772e40f145.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7939a95731de8b8eb9245c330f014772e40f145.camel@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 02:14:35PM +0000, David Woodhouse wrote:
> +Paul for the RCU question.
> 
> On Tue, 2021-02-16 at 15:10 +0000, David Woodhouse wrote:
> > On Tue, 2021-02-16 at 13:53 +0000, David Woodhouse wrote:
> > > I threw it into my tree at
> > > https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/parallel
> > >
> > > It seems to work fairly nicely. The parallel SIPI seems to win be about
> > > a third of the bringup time on my 28-thread Haswell box. This is at the
> > > penultimate commit of the above branch:
> > > 
> > > [    0.307590] smp: Bringing up secondary CPUs ...
> > > [    0.307826] x86: Booting SMP configuration:
> > > [    0.307830] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14
> > > [    0.376677] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
> > > [    0.377177]  #15 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27
> > > [    0.402323] Brought CPUs online in 246691584 cycles
> > > [    0.402323] smp: Brought up 1 node, 28 CPUs
> > > 
> > > ... and this is the tip of the branch:
> > > 
> > > [    0.308332] smp: Bringing up secondary CPUs ...<dwmw2_gone> 
> > > [    0.308569] x86: Booting SMP configuration:
> > > [    0.308572] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27
> > > [    0.321120] Brought 28 CPUs to x86/cpu:kick in 34828752 cycles
> > > [    0.366663] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
> > > [    0.368749] Brought CPUs online in 124913032 cycles
> > > [    0.368749] smp: Brought up 1 node, 28 CPUs
> > > [    0.368749] smpboot: Max logical packages: 1
> > > [    0.368749] smpboot: Total of 28 processors activated (145259.85 BogoMIPS)
> > > 
> > > There's more to be gained here if we can fix up the next stage. Right
> > > now if I set every CPU's bit in cpu_initialized_mask to allow them to
> > > proceed from wait_for_master_cpu() through to the end of cpu_init() and
> > > onwards through start_secondary(), they all end up hitting
> > > check_tsc_sync_target() in parallel and it goes horridly wrong.
> > 
> > Actually it breaks before that, in rcu_cpu_starting(). A spinlock
> > around that, an atomic_t to let the APs do their TSC sync one at a time
> > (both in the above tree now), and I have a 75% saving on CPU bringup
> > time for my 28-thread Haswell:
> 
> Coming back to this, I've updated it and thrown up a new branch at 
> https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/parallel-5.16
> 
> For those last two fixes I had started with a trivial naïve approach of
> just enforcing serialization.
> 
> I'm sure we can come up with a cleverer 1:N way of synchronizing the
> TSCs, instead of just serializing the existing 1:1 sync.
> 
> For rcu_cpu_starting() I see there's *already* a lock in the
> rcu_node... could we use that same lock to protect the manipulation of
> rnp->ofl_seq and allow rcu_cpu_starting() to be invoked by multiple APs
> in parallel? Paul?
> 
> On a related note, are you currently guaranteed that rcu_report_dead()
> cannot be called more than once in parallel? Might you want the same
> locking there?

Just to make sure I understand, the goal here is to bring multiple CPUs
online concurrently, correct?  If so, this will take some digging to
check up on the current implicit assumptions about CPU-hotplug operations
being serialized.  Some of which might even be documented.  ;-)

But first...  Is it just bringing CPUs online that is to happen
concurrently?  Or is it also necessary to take CPUs offline concurrently?

							Thanx, Paul
