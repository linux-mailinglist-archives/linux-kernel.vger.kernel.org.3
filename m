Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766FF4A5DD1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbiBAN6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 08:58:36 -0500
Received: from foss.arm.com ([217.140.110.172]:42024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238944AbiBAN6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:58:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD367113E;
        Tue,  1 Feb 2022 05:58:34 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.8.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 074A53F73B;
        Tue,  1 Feb 2022 05:58:32 -0800 (PST)
Date:   Tue, 1 Feb 2022 13:58:29 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Krzysztof Adamski <krzysztof.adamski@nokia.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: move efi_reboot to restart handler
Message-ID: <Yfk8hQB1eon7oeYU@FVFF77S0Q05N>
References: <YfP0osb45uJldtM9@localhost.localdomain>
 <YfQTZTUNaeGi+8tG@FVFF77S0Q05N>
 <YfRorCpk0seVGI+5@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfRorCpk0seVGI+5@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 11:05:32PM +0100, Krzysztof Adamski wrote:
> Hi Mark,
> 
> Thank you for your feedback. I don't know UEFI specification that much,
> it is quite complicated so maybe I am misunderstnading something. Let's
> clarify.
> 
> Dnia Fri, Jan 28, 2022 at 04:01:41PM +0000, Mark Rutland napisał(a):
> > On Fri, Jan 28, 2022 at 02:50:26PM +0100, Krzysztof Adamski wrote:
> > > On EFI enabled arm64 systems, efi_reboot was called before
> > > do_kernel_restart, completely omitting the reset_handlers functionality.
> > 
> > As I pointed out before, per the EFI spec we *need* to do this before any other
> > restart mechanism so that anything which EFI ties to the restart actually
> > occurs as expected -- e.g. UpdateCapsule(), as the comment says.
> > AFAICT, either:
> > 
> > * The other restart handlers have lower priority, in which case they'll be
> >  called after this anyway, and in such cases this patch is not necessary.
> 
> But efi_reboot calls ResetSystem(), which according to the spec:
> "Resets all processors and devices and reboots the system."
> 
> So nothing should be able to run *after* this call. Thus, none of the
> reset handlers will ever run on a system where efi_reboot() is used
> (with current, unmodified kernel code) so this case is invalid.

Yes; that was the point I was making: *in this case* it doesn't matter at all,
and therefore *in this case* the existing code is fine.

> > * At least one other restart handler has higher priority, and the EFI restart
> >  isn't actually used, and so any functionaltiy tied to the EFI restart will
> >  not work on that machine.
> 
> If we use the restart handlers only to reset the system, this is indeed
> true. But technically, restart handlers support the scenario where the
> handler does some action that does not do reset of the whole system and
> passes the control further down the chain, eventually reaching a handler
> that will reset the whole system.
> This can be done on non-uefi systems without problems but it doesn't
> work on UEFI bases arm64 systems and this is a problem for us.
> 
> In other words, I would like to be able to run a restart handler on EFI
> based ARM64 systems, just like I can on other systems, just for its
> "side effects", not to do the actual reboot. Current code disables this
> possibility on an ARM64 EFI system.

It sounds like two things are being conflated here:

1) A *notification* that a restart will subsequently occur.
2) A *request* to initiate a restart.

IIUC (1) is supposed to be handled by the existing reboot notifier mechanism
(see the reboot_notifier_list) which *is* invoked prior to the EFI reboot
today.

IMO, using restart handlers as notifiers is an abuse of the interface, and
that's the fundamental problem.

What am I missing?

> > > By registering efi_reboot as part of the chain with slightly elevated
> > > priority, we make it run before the default handler but still allow
> > > plugging in other handlers.
> > > Thanks to that, things like gpio_restart, restart handlers in
> > > watchdog_core, mmc or mtds are working on those platforms.
> > 
> > On which platforms is it necessary that these are used in preference to the EFI
> > restart? Can you please give a specific example?
> 
> > If there's a specific platform that needs this, then we should call that out
> > and explain why the EFI restart isn't actually required on that (or if it is,
> > and functionality is broken, why that's acceptable).
> 
> Again, I'm not saying EFI restart is not required. I would just like to
> have the flexibility I have on other architectures, and run some code
> just before restart. My understanding is that pwrseq_emmc.c driver does
> exactly that, for example, but there are also other possibilities:
>  - using gpio-restart to notify external components about reset of the
>    CPU
>  - starting an external watchdog that makes sure we are not stuck in the
>    reset procedure, etc.

As above, IIUC those notification cases are supposed to be handled with reboot
notifiers, which are already supported in generic code across all
architectures, and should run before the EFI restart.

If there's a case where they're not, that's either an oversight or an edge case
that needs more consideration.

> > Otherwise this patch is making this logic more complicated *and* making it
> > possible to have problems which we avoid by construction today, without any
> > actual benefit.
> 
> The benefit for me is this added flexibility and unification between
> architectures. On other systems, like ARM32 or non-EFI ARM64 I can
> insert a custom reset handler to do some actions just before restart and
> on EFI based ARM64, I can't.
>
> You could argue that restart handlers were not created for that but they
> suit this purpose ideally and it wouldn't make much sense (in my
> opinion) to add yet another notifier chain that would run before reset
> notifiers, for code that is not supposed to reset the whole system and
> this is exacly what I would have to do if efi_reboot() is forced to be
> called before all handlers.

As above, I think that's just using the wrong interface, and the reboot
notifier mechanism *already* exists, so I'm really confused here.

Have I misunderstood what you're trying to achieve?

Is there some problem with the reboot notifier mechanism that I am unaware of?
e.g. do we bypass them in some case where you think they're needed?

Are you simply unaware of reboot notifiers?

Thanks,
Mark.
