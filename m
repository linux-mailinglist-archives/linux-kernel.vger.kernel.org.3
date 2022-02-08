Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A314AD7ED
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbiBHLwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiBHLwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:52:17 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69AA8C03FECA;
        Tue,  8 Feb 2022 03:52:15 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B60908106;
        Tue,  8 Feb 2022 11:51:49 +0000 (UTC)
Date:   Tue, 8 Feb 2022 13:52:13 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, jan.kiszka@siemens.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am65: disable optional
 peripherals by default
Message-ID: <YgJZbdOlazrde7O/@atomide.com>
References: <20220203140240.973690-1-matthias.schiffer@ew.tq-group.com>
 <20220204143108.653qk2ihnlhsr5aa@prior>
 <YgDCLaBHA3DDQAUd@atomide.com>
 <5944ba0ce568eaf507917799b1dfd89a3d0ca492.camel@ew.tq-group.com>
 <YgEBml9HvFzSl289@atomide.com>
 <9923df6525212389b86cb635624bcfb5c27a8bc5.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9923df6525212389b86cb635624bcfb5c27a8bc5.camel@ew.tq-group.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthias Schiffer <matthias.schiffer@ew.tq-group.com> [220208 10:53]:
> On Mon, 2022-02-07 at 13:25 +0200, Tony Lindgren wrote:
> > * Matthias Schiffer <matthias.schiffer@ew.tq-group.com> [220207
> > 08:45]:
> > > Generally I think that it's a bootloader's responsiblity to disable
> > > unneeded devices - the kernel may not even have a driver for some
> > > peripherals, leading to the same behaviour as a "disabled" status.
> > > For
> > > this reason I believe that it should always be okay to set unneeded
> > > devices to "disabled", and it should be considered a safe default.
> > 
> > Not possible, think kexec for example :) How would the previous
> > kernel
> > even know what to disable if Linux has no idea about the devices?
> 
> Well, optimally, bootloader and all kernels would agree on the devices
> that are actually available, but I get your point.
> 
> > 
> > If there are issues you're seeing, it's likely a bug in some of the
> > device drivers for not checking for the necessary resources like
> > pinctrl for i2c lines.
> 
> I don't think it's common for individual drivers to care about pinctrl
> unless switching between different pin settings is required at runtime.
> Many drivers can be used on different hardware, some of which may
> require pinmuxing, while others don't.

Yeah that's true, some configurations only do pin muxing in the
bootloader. So pins are not a good criteria for devicetree status enabled
for when the device is operational.

Probably a better criteria for devicetree "operational" status is the
device can be clocked and configured or idled. Some devices like GPUs
can render to memory with no external pin configuration for example.

Following Linux running on a PC analogy.. If ACPI has some device that
causes driver warnings on Linux boot, do we patch the ACPI table and
pretend the device does not exist? Or do we patch the device driver to
deal with the random buggy bootloader state for the device? :)

> Also, what is the expected behavior of a driver that is probed for an
> unusable device? Wouldn't this require some as-of-yet nonexisting
> status between "okay" and "disabled" that conveys something like "probe
> this device, initialize (and disable) PM, but don't register anything",
> so no unusable devices become visible to userspace (and possibly other
> kernel drivers)?

I did some experimental patches several years ago to add devicetree
status for incomplete, but eventually came to the conclusion that it
was not really needed. Feel free to revisit that if you have the
spare cycles :)

Having the drivers check for the resources like clocks and then just
idle the device after probe solved the issues I was seeing for warnings
and kexec. In some cases the device may need to be reset or at least
properly reconfigured in the probe as the state can be unknown from the
bootloader. That's about all there is to it. Sure you could save some
memory with less instances for some devices, so maybe the status =
"incomplete" could be used to do the trick for that.

> > > I'm not sure what the consensus on these issues is. I'm more
> > > familiar
> > > with NXP's i.MX and Layerscape SoCs, where it's common to have all
> > > muxable peripherals set to "disabled" in the base DTSI, and a quick
> > > grep through a few dts directories gives me the impression that
> > > this is
> > > the case for most other vendors as well.
> > 
> > This approach only works for SoCs that don't need the kernel to idle
> > devices for runtime PM.
> 
> I'm pretty sure that most modern SoCs I looked at have runtime PM, and
> it is simply expected that unusable devices are never enabled in the
> first place, so there is no need for the kernel to know about them.

Yeah well that assumption is the difference in getting runtime PM to
work in a sane way across multiple SoCs and devices :)

Devices tagged with status = "disabled" are completely ignored by the
kernel. Interconnect and bus related code may not know the details on
how to reset and idle the child devices. Relying on firmware to do the
reset and idle of unused devices may be too generic, can be buggy, and
probably depends on the firmware revision.

Regards,

Tony
