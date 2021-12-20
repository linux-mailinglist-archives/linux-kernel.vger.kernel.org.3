Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082A047B0EF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbhLTQKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbhLTQKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:10:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3D2C061574;
        Mon, 20 Dec 2021 08:10:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E25F4B80F4B;
        Mon, 20 Dec 2021 16:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5B2C36AE2;
        Mon, 20 Dec 2021 16:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640016617;
        bh=7PXWoZ2KL+Ig9fI0vXCHFwz904irEuyU5Cq7Elp6Brs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=snS/I7FVuziSrqgP6ZfsuWLXBqwO3TFWdwCd4KlUP6kHrZWdPjZAlak431ccSc7f1
         0xnqlXiaU+m0GPCfzw/4KCwQ459s/JxMMzdjDxIrMFLS5KEMefBAOKnyoZPgGN+57V
         yZDDQP23LRiRQ/o/aZyzqYRdFaGRSf5VdUan7u8zkjnPHO8Cm1f0I1QKtnbzSOGUxu
         NC67Go7+vGw+kXMpWvVJ8/SuItVhWPC3+ozfgBw1dgP2EPBocMzWN2YmpUspl4aOBt
         z35OcWYjFQT47Rm0ZytD8ly2w/1ym3LoU/4GGMFkBYnX4YLXv22meHX9G/bmZIunHh
         LV4S87CL0Kfvg==
Date:   Mon, 20 Dec 2021 17:10:14 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>, maz <maz@kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu <rcu@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        kvmarm@lists.cs.columbia.edu,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Possible nohz-full/RCU issue in arm64 KVM
Message-ID: <20211220161014.GC918551@lothringen>
References: <d80e440375896f75d45e227d40af60ca7ba24ceb.camel@redhat.com>
 <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 01:21:39PM +0000, Mark Rutland wrote:
> On Fri, Dec 17, 2021 at 12:51:57PM +0100, Nicolas Saenz Julienne wrote:
> > Hi All,
> 
> Hi,
> 
> > arm64's guest entry code does the following:
> > 
> > int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> > {
> > 	[...]
> > 
> > 	guest_enter_irqoff();
> > 
> > 	ret = kvm_call_hyp_ret(__kvm_vcpu_run, vcpu);
> > 
> > 	[...]
> > 
> > 	local_irq_enable();
> > 
> > 	/*
> > 	 * We do local_irq_enable() before calling guest_exit() so
> > 	 * that if a timer interrupt hits while running the guest we
> > 	 * account that tick as being spent in the guest.  We enable
> > 	 * preemption after calling guest_exit() so that if we get
> > 	 * preempted we make sure ticks after that is not counted as
> > 	 * guest time.
> > 	 */
> > 	guest_exit();
> > 	[...]
> > }
> > 
> > 
> > On a nohz-full CPU, guest_{enter,exit}() delimit an RCU extended quiescent
> > state (EQS). Any interrupt happening between local_irq_enable() and
> > guest_exit() should disable that EQS. Now, AFAICT all el0 interrupt handlers
> > do the right thing if trggered in this context, but el1's won't. Is it
> > possible to hit an el1 handler (for example __el1_irq()) there?
> 
> I think you're right that the EL1 handlers can trigger here and won't exit the
> EQS.
> 
> I'm not immediately sure what we *should* do here. What does x86 do for an IRQ
> taken from a guest mode? I couldn't spot any handling of that case, but I'm not
> familiar enough with the x86 exception model to know if I'm looking in the
> right place.

This is one of the purposes of rcu_irq_enter(). el1 handlers don't call irq_enter()?

Thanks.
