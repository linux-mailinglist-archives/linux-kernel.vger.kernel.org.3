Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC0E479309
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbhLQRra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbhLQRra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:47:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A302CC061574;
        Fri, 17 Dec 2021 09:47:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EAA86CE2610;
        Fri, 17 Dec 2021 17:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1637DC36AE8;
        Fri, 17 Dec 2021 17:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639763246;
        bh=wGI+t0gS/hdl+/rz+vVaZZWkZGtQrHWcAbdHNmxiEVw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qfeFqtNSoGdqKHEWsC1tOxLxD+nqSLNiEA7cVVH/qW1sLgxx/GqTADt/k6kekO2vn
         JvwkmrEPf4UQFnx4d5DPI9igP5hDgepKos+O1+8041yZRIPfr8od/MTJDJYS1Y/1r1
         nqzR6L7w97ibIzzL8vJIVTz0z7nfwr53oFoGkFm9moA6AsvPJYbUqwsOUYKv/QEWN1
         wYvMeu5o04gOKboPV5El3dTNl1c6fNYkAZPUjcHP0nU2GT+eBUXb2c1KtFMwqiYVOb
         KSZbDouSbIpovqGusvbPBFJCNl9KzDsAXifpCHuQQ24at3BqtZM6mWjFpoyc7PthCb
         U5KN3B1GEhdyg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C078B5C0610; Fri, 17 Dec 2021 09:47:25 -0800 (PST)
Date:   Fri, 17 Dec 2021 09:47:25 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        maz <maz@kernel.org>, frederic <frederic@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: Possible nohz-full/RCU issue in arm64 KVM
Message-ID: <20211217174725.GX641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
 <70f112072d9496d21901946ea82832d3ed3a8cb2.camel@redhat.com>
 <Ybyg1r/Q6EfeuXGV@FVFF77S0Q05N>
 <9ab8107f-ff41-6a9e-57e1-a261bea93aca@redhat.com>
 <20211217160749.GS641268@paulmck-ThinkPad-P17-Gen-1>
 <f3d6095a-70aa-3da0-08a6-3caff2638809@redhat.com>
 <20211217164535.GU641268@paulmck-ThinkPad-P17-Gen-1>
 <4c369ca2-2ad0-4a02-90e9-2d82df6c289d@redhat.com>
 <20211217171218.GV641268@paulmck-ThinkPad-P17-Gen-1>
 <24268298-c51f-afcd-72e2-22c39eb002b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24268298-c51f-afcd-72e2-22c39eb002b5@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 06:23:32PM +0100, Paolo Bonzini wrote:
> On 12/17/21 18:12, Paul E. McKenney wrote:
> > On Fri, Dec 17, 2021 at 06:02:23PM +0100, Paolo Bonzini wrote:
> > > On 12/17/21 17:45, Paul E. McKenney wrote:
> > > > On Fri, Dec 17, 2021 at 05:34:04PM +0100, Paolo Bonzini wrote:
> > > > > On 12/17/21 17:07, Paul E. McKenney wrote:
> > > > > > > rcu_note_context_switch() is a point-in-time notification; it's not strictly
> > > > > > > necessary, but it may improve performance a bit by avoiding unnecessary IPIs
> > > > > > > from the RCU subsystem.
> > > > > > > 
> > > > > > > There's no benefit from doing it when you're back from the guest, because at
> > > > > > > that point the CPU is just running normal kernel code.
> > > > > > 
> > > > > > Do scheduling-clock interrupts from guest mode have the "user" parameter
> > > > > > set?  If so, that would keep RCU happy.
> > > > > 
> > > > > No, thread is in supervisor mode.  But after every interrupt (timer tick or
> > > > > anything), one of three things can happen:
> > > > > 
> > > > > * KVM will go around the execution loop and invoke rcu_note_context_switch()
> > > > > again
> > > > > 
> > > > > * or KVM will go back to user space
> > > > 
> > > > Here "user space" is a user process as opposed to a guest OS?
> > > 
> > > Yes, that code runs from ioctl(KVM_RUN) and the ioctl will return to the
> > > calling process.
> > 
> > Intriguing.  A user process within the guest OS or a user process outside
> > of any guest OS, that is, within the host?
> 
> A user process on the host.  The guest vCPU is nothing special: it's just a
> user thread that occasionally lets the guest run by invoking the KVM_RUN
> ioctl.  Hopefully, KVM_RUN will be where that user thread will spend most of
> the time so the guest runs at full steam.  KVM_RUN is the place where you
> have the code that Nicolas and Mark were discussing.
> 
> From the point of view of the kernel however the thread is always in kernel
> mode when it runs the guest, because any interrupt will be recognized while
> still in the ioctl.
> 
> (I'll add that from the point of view of the scheduler, there's no
> difference between a CPU-bound guest and a "normal" CPU-bound process on the
> host, e.g. wasting time with "for(;;)" or calculating digits of PI is the
> same no matter if you're doing it in the guest or in the host. Likewise for
> I/O-bound guests; e.g. doing "hlt" or "wfi" constantly in the guest looks
> exactly the same to the scheduler as a process that spends its time in the
> poll() system call).

Thank you for the explanation!

							Thanx, Paul
