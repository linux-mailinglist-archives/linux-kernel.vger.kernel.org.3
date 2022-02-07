Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3104AC5A2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344680AbiBGQaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241606AbiBGQ2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:28:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92C7EC0401DB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:28:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CEB511D4;
        Mon,  7 Feb 2022 08:28:22 -0800 (PST)
Received: from bogus (unknown [10.57.41.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EA743F718;
        Mon,  7 Feb 2022 08:28:20 -0800 (PST)
Date:   Mon, 7 Feb 2022 16:27:34 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Broadcom STB PM PSCI extensions
Message-ID: <20220207162734.nt55nflwqstkej3p@bogus>
References: <20220122035421.4086618-1-f.fainelli@gmail.com>
 <20220203111435.e3eblv47ljkwkvwf@bogus>
 <34938793-cecc-2ad8-a4eb-81bb278ce9b5@gmail.com>
 <20220203185221.aw7kayj6qklmh5is@bogus>
 <06f84f27-973d-1dae-e2c3-3fda4e368331@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06f84f27-973d-1dae-e2c3-3fda4e368331@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 11:33:26AM -0800, Florian Fainelli wrote:
>
>
> On 2/3/2022 10:52 AM, Sudeep Holla wrote:
> > Correction: it is known as "freeze" rather than "idle" in terms of values
> > as per /sys/power/state. Sorry for referring it as "idle" and creating any
> > confusion.
> >
> > On Thu, Feb 03, 2022 at 09:36:28AM -0800, Florian Fainelli wrote:
> > >
> > >
> > > On 2/3/2022 3:14 AM, Sudeep Holla wrote:
> > > > On Fri, Jan 21, 2022 at 07:54:17PM -0800, Florian Fainelli wrote:
> > > > > Hi all,
> > > > >
> > > > > This patch series contains the Broadcom STB PSCI extensions which adds
> > > > > some additional functions on top of the existing standard PSCI interface
> > > > > which is the reason for having the driver implement a custom
> > > > > suspend_ops.
> > > > >
> > > > > These platforms have traditionally supported a mode that is akin to
> > > > > ACPI's S2 with the CPU in WFI and all of the chip being clock gated
> > > > > which is entered with "echo standby > /sys/power/state". Additional a
> > > > > true suspend to DRAM as defined in ACPI by S3 is implemented with "echo
> > > > > mem > /sys/power/state".
> > > >
> > > > How different is the above "standby" state compare to the standard "idle"
> > > > (a.k.a suspend-to-idle which is different from system-to-ram/S3) ?
> > >
> > > There are a few differences:
> > >
> > > - s2idle does not power gate the secondary CPUs
> > >
> >
> > Not sure what you mean by that ? S2I takes CPUs to deepest idle state.
> > If you want shallower states, one possible option is the disable deeper
> > states from the userspace.
>
> What I mean is that we do not get to call PSCI CPU_OFF here so the CPUs are
> idle, but not power gated. Those CPUs do not have any other idle state other
> than WFI because the HW designers sort of forgot or rather did not know that
> wiring up the ARM GIC power controller back to the power gating logic of the
> CPU was a good idea.
>

Nice 😄

> >
> > > - s2idle requires the use of in-band interrupts for wake-up
> > >
> >
> > I am not sure if that is true. S2I behaves very similar to S2R except it
> > has low wake latency as all secondaries CPUs are not hotplugged out.
>
> OK, the fact that secondary CPUs are not hot-plugged could be remedied by
> doing this ahead of entering s2idle by user-space so this is not a valid
> argument from me anymore.
>

Fair enough.

> >
> > > The reasons for implementing "standby" are largely two fold:
> > >
> > > - we need to achieve decent power savings (typically below 0.5W for the
> > > whole system while allowing Wake-on-WLAN, GPIO, RTC, infrared, etc.)
> > >
> >
> > I fail to understand how that is a problem from S2I. It is probably worth
> > checking if there are any unnecessary IRQF_NO_SUSPEND users. Check section
> > IRQF_NO_SUSPEND and enable_irq_wake() in [1]. I don't see any issues other
> > wise in terms of unnecessary/spurious wakeup by in-band(to be precise
> > no-wake up) interrupts.
>
> I don't think your hyperlink referenced by [1] was provided, but my quick
> testing with:
>

Yikes, I meant to refer Documentation/power/suspend-and-interrupts.rst

> echo s2idle > /sys/power/mem_sleep
> echo mem > /sys/power/state
>
> appears to work to some extent when I use peripherals that can generate
> in-band interrupts.
>
> It looks like we have s2idle_ops that allows a platform to override some of
> the operations before/after entering s2idle, however the actual s2idle idle
> loop is still within the kernel, so we will not call into the ARM Trusted
> Firmware and engage the power management state machine.
>

Correct.

> This means that there will not be any of the clock gating that only the
> hardware state machine is capable of performing, the DRAM controller as a
> result will not enter self refresh power down, and in addition the side band
> wake-up interrupts will not be activate because the interrupt controller
> that aggregates them only outputs to the ARM GIC when the state machine has
> been engaged.
>

One possible solution IIUC the issue is to add this as additional CPU Idle
state disabled most of the time. Enable them from user-space just prior to
calling freeze/s2idle, so that PSCI CPU_SUSPEND is called with right param
to indicate this is deepest idle state(in your case just WFI) + DRAM self
refresh/retention mode. Also TF-A can take care to enable the side band
interrupts before entering the state.

Do you see any issue with this approach ? I am trying to find ways to avoid
deviating from standard PSCI.

> Essentially, what we need for our systems is a controlled system entry with
> semantics similar if not identical to that of S2R but with a shallower state
> that does not cut the power to 90% of the SoC (unlike S2R) such that we have
> a quicker suspend and resume latency. Years ago when we only had MIPS-based
> and 32-bit ARM SoCs, we did come up with using "standby" (see
> drivers/soc/bcm/brcmstb/pm/*) and we naturally mapped that when we switched
> over to ARMv8 capable devices.
>

Understood and I do remember that.

--
Regards,
Sudeep
