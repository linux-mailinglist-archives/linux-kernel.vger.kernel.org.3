Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7934790FA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238852AbhLQQHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbhLQQHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:07:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251BDC061574;
        Fri, 17 Dec 2021 08:07:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6BE1622D6;
        Fri, 17 Dec 2021 16:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AF3C36AE7;
        Fri, 17 Dec 2021 16:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639757270;
        bh=CLb/vJNslUVn2r+sZTAnMRXCOXn59toIUCwh/IkwYQc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CauBV+W9fQqYJLQzdeFA0ISzNJpiTCqIKyxongSwUvHWWkmV6ZD9Fz7RP0oQ0HBqY
         cMixjLYJ6SzKCdfisxaElhQrLY9OTob7qk2q5CMOldEHODGQRb++uLrqE0Bsij7oBd
         Sny8bv8CbPIc1qIylGoq0z+KgoMCXO916kbjwDU5VgipqhhmbDonLjrNwKYZE6mMiC
         lrSvid8A7axsjUwi7wLgvumi7Q6GMMEUZBFoGZlR79akUsGpEWTFlDlE/IhWSFfO7g
         A47nTjy8S6M8YD1L3F8xNYUTLIkoH/EtFPc5eoqGUzNIr1k3C/wOEm8glNIEVob0i2
         U/5/faGEZFJqA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D3C9F5C0610; Fri, 17 Dec 2021 08:07:49 -0800 (PST)
Date:   Fri, 17 Dec 2021 08:07:49 -0800
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
Message-ID: <20211217160749.GS641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <d80e440375896f75d45e227d40af60ca7ba24ceb.camel@redhat.com>
 <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
 <70f112072d9496d21901946ea82832d3ed3a8cb2.camel@redhat.com>
 <Ybyg1r/Q6EfeuXGV@FVFF77S0Q05N>
 <9ab8107f-ff41-6a9e-57e1-a261bea93aca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ab8107f-ff41-6a9e-57e1-a261bea93aca@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 04:54:22PM +0100, Paolo Bonzini wrote:
> On 12/17/21 15:38, Mark Rutland wrote:
> > For example kvm_guest_enter_irqoff() calls guest_enter_irq_off() which calls
> > vtime_account_guest_enter(), but kvm_guest_exit_irqoff() doesn't call
> > guest_exit_irq_off() and the call to vtime_account_guest_exit() is open-coded
> > elsewhere. Also, guest_enter_irq_off() conditionally calls
> > rcu_virt_note_context_switch(), but I can't immediately spot anything on the
> > exit side that corresponded with that, which looks suspicious.
> 
> rcu_note_context_switch() is a point-in-time notification; it's not strictly
> necessary, but it may improve performance a bit by avoiding unnecessary IPIs
> from the RCU subsystem.
> 
> There's no benefit from doing it when you're back from the guest, because at
> that point the CPU is just running normal kernel code.

Do scheduling-clock interrupts from guest mode have the "user" parameter
set?  If so, that would keep RCU happy.

							Thanx, Paul
