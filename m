Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A0C4A8BF0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353582AbiBCSxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:53:10 -0500
Received: from foss.arm.com ([217.140.110.172]:36530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233247AbiBCSxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:53:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7B24147A;
        Thu,  3 Feb 2022 10:53:09 -0800 (PST)
Received: from bogus (unknown [10.57.41.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A0423F774;
        Thu,  3 Feb 2022 10:53:08 -0800 (PST)
Date:   Thu, 3 Feb 2022 18:52:21 +0000
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
Message-ID: <20220203185221.aw7kayj6qklmh5is@bogus>
References: <20220122035421.4086618-1-f.fainelli@gmail.com>
 <20220203111435.e3eblv47ljkwkvwf@bogus>
 <34938793-cecc-2ad8-a4eb-81bb278ce9b5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34938793-cecc-2ad8-a4eb-81bb278ce9b5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correction: it is known as "freeze" rather than "idle" in terms of values
as per /sys/power/state. Sorry for referring it as "idle" and creating any
confusion.

On Thu, Feb 03, 2022 at 09:36:28AM -0800, Florian Fainelli wrote:
> 
> 
> On 2/3/2022 3:14 AM, Sudeep Holla wrote:
> > On Fri, Jan 21, 2022 at 07:54:17PM -0800, Florian Fainelli wrote:
> > > Hi all,
> > > 
> > > This patch series contains the Broadcom STB PSCI extensions which adds
> > > some additional functions on top of the existing standard PSCI interface
> > > which is the reason for having the driver implement a custom
> > > suspend_ops.
> > > 
> > > These platforms have traditionally supported a mode that is akin to
> > > ACPI's S2 with the CPU in WFI and all of the chip being clock gated
> > > which is entered with "echo standby > /sys/power/state". Additional a
> > > true suspend to DRAM as defined in ACPI by S3 is implemented with "echo
> > > mem > /sys/power/state".
> > 
> > How different is the above "standby" state compare to the standard "idle"
> > (a.k.a suspend-to-idle which is different from system-to-ram/S3) ?
> 
> There are a few differences:
> 
> - s2idle does not power gate the secondary CPUs
>

Not sure what you mean by that ? S2I takes CPUs to deepest idle state.
If you want shallower states, one possible option is the disable deeper
states from the userspace.

> - s2idle requires the use of in-band interrupts for wake-up
>

I am not sure if that is true. S2I behaves very similar to S2R except it
has low wake latency as all secondaries CPUs are not hotplugged out.

> The reasons for implementing "standby" are largely two fold:
>
> - we need to achieve decent power savings (typically below 0.5W for the
> whole system while allowing Wake-on-WLAN, GPIO, RTC, infrared, etc.)
>

I fail to understand how that is a problem from S2I. It is probably worth
checking if there are any unnecessary IRQF_NO_SUSPEND users. Check section
IRQF_NO_SUSPEND and enable_irq_wake() in [1]. I don't see any issues other
wise in terms of unnecessary/spurious wakeup by in-band(to be precise
no-wake up) interrupts.

> - we have a security subsystem that requires the CPUs to be either power
> gated or idle in order the hardware state machine that lets the system enter
> such a state and allows the out of band interrupts from being wake-up
> sources
>

It should work unless I have completely misunderstood how S2I works.

> > Suspend to idle takes all the CPUs to lowest possible power state instead
> > of cpu-hotplug in S2R. Also I assume some userspace has to identify when
> > to enter "standby" vs "mem" right ? I am trying to see how addition of
> > "idle" changes that(if it does). Sorry for too many questions.
> > 
> 
> Right that user-space in our case is either custom (like RDK, or completely
> custom), or is Android. For Android it looks like we are carrying a patch
> that makes "mem" de-generate into "standby" but this is largely because we
> had historically problems with "mem" that are being addressed (completely
> orthogonal).
>

Thanks for the info.

> I did not consider it as a viable option at the time, but if we were to
> implement "standby" in drivers/firmware/psci/psci.c would that be somewhat
> acceptable?
>

We have been pointing anyone needing standby so far to S2I and so far no one
has shouted that it doesn't suffice. Let me know what is missing.

-- 
Regards,
Sudeep

[1] Documentation/power/suspend-and-interrupts.rst
