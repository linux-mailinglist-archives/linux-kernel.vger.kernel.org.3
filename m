Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448F74791C9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239294AbhLQQph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:45:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38948 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239286AbhLQQpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:45:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A3DC622FD;
        Fri, 17 Dec 2021 16:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875B4C36AE1;
        Fri, 17 Dec 2021 16:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639759535;
        bh=+Z8HaNORlefmFC0iorPRnnxWsiru7mFwmG4mt8j06g4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Uxtf76sJEP4I9ft93wAfQue9vIwowuCrbeQOafQU8q5x25anDEvL/i0tGoheL5fIG
         UrUvxGSD0HapyDwZ4QB4fN5FUdjRJljktSyF2/kBTSBcVNRWcseC9Vtw0evM/f6Pyy
         Kx0OZlk5IGVD0g9NdVSJ/9pZKBifhSDE0VEI9m5dzhW0EuJYIyN8CQ2QvywsjjYkaG
         1ON6eJPNElI0OVa6p7txk8YagpmccK7Cp104iB2f9i9TX17j2NsvjA8XIyqMzCZYWY
         7PxU2dUqKUOA/8r+hXqvGh3aB/xAjxfZlmmc+JQubmkDcrDxUxbFwePVAQvLZO7/9A
         gps/Rws4WD2ZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4AEEA5C0610; Fri, 17 Dec 2021 08:45:35 -0800 (PST)
Date:   Fri, 17 Dec 2021 08:45:35 -0800
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
Message-ID: <20211217164535.GU641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <d80e440375896f75d45e227d40af60ca7ba24ceb.camel@redhat.com>
 <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
 <70f112072d9496d21901946ea82832d3ed3a8cb2.camel@redhat.com>
 <Ybyg1r/Q6EfeuXGV@FVFF77S0Q05N>
 <9ab8107f-ff41-6a9e-57e1-a261bea93aca@redhat.com>
 <20211217160749.GS641268@paulmck-ThinkPad-P17-Gen-1>
 <f3d6095a-70aa-3da0-08a6-3caff2638809@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3d6095a-70aa-3da0-08a6-3caff2638809@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 05:34:04PM +0100, Paolo Bonzini wrote:
> On 12/17/21 17:07, Paul E. McKenney wrote:
> > > rcu_note_context_switch() is a point-in-time notification; it's not strictly
> > > necessary, but it may improve performance a bit by avoiding unnecessary IPIs
> > > from the RCU subsystem.
> > > 
> > > There's no benefit from doing it when you're back from the guest, because at
> > > that point the CPU is just running normal kernel code.
> > 
> > Do scheduling-clock interrupts from guest mode have the "user" parameter
> > set?  If so, that would keep RCU happy.
> 
> No, thread is in supervisor mode.  But after every interrupt (timer tick or
> anything), one of three things can happen:
> 
> * KVM will go around the execution loop and invoke rcu_note_context_switch()
> again
> 
> * or KVM will go back to user space

Here "user space" is a user process as opposed to a guest OS?

> * or the thread will be preempted
> 
> and either will keep RCU happy as far as I understand.

Regardless of the answer to my question above, yes, these will keep
RCU happy.  ;-)

						Thanx, Paul
