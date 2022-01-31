Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A2A4A3FE8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348432AbiAaKQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:16:10 -0500
Received: from muru.com ([72.249.23.125]:44646 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232024AbiAaKQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:16:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5F72B8027;
        Mon, 31 Jan 2022 10:15:59 +0000 (UTC)
Date:   Mon, 31 Jan 2022 12:16:06 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>, Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 2/2] clocksource/drivers/timer-ti-dm: Handle dra7 timer
 wrap errata i940
Message-ID: <Yfe25rpSY8OFPxzr@atomide.com>
References: <20210323074326.28302-1-tony@atomide.com>
 <20210323074326.28302-3-tony@atomide.com>
 <YfWsG0p6to3IJuvE@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfWsG0p6to3IJuvE@x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Drew Fustini <dfustini@baylibre.com> [220129 21:05]:
> On Tue, Mar 23, 2021 at 09:43:26AM +0200, Tony Lindgren wrote:
> > There is a timer wrap issue on dra7 for the ARM architected timer.
> > In a typical clock configuration the timer fails to wrap after 388 days.
> > 
> > To work around the issue, we need to use timer-ti-dm percpu timers instead.
> > 
> > Let's configure dmtimer3 and 4 as percpu timers by default, and warn about
> > the issue if the dtb is not configured properly.
> 
> Hi Tony,
> 
> This causes a conflict for IPU2 which is using timer 3 and 4.
> 
> From arch/arm/boot/dts/dra7-ipu-dsp-common.dtsi:
> 
>   &ipu2 {
>           mboxes = <&mailbox6 &mbox_ipu2_ipc3x>;
>           ti,timers = <&timer3>;
>           ti,watchdog-timers = <&timer4>, <&timer9>;
>   };

OK, sorry I missed that part.

> I noticed an error ("could not get timer platform device") when booting
> mainline on a BeagleBoard X15 (AM578):
> 
>   omap-rproc 55020000.ipu: assigned reserved memory node ipu2-memory@95800000
>   remoteproc remoteproc1: 55020000.ipu is available
>   remoteproc remoteproc1: powering up 55020000.ipu
>   remoteproc remoteproc1: Booting fw image dra7-ipu2-fw.xem4, size 3747220
>   omap-rproc 55020000.ipu: could not get timer platform device
>   omap-rproc 55020000.ipu: omap_rproc_enable_timers failed: -19
>   remoteproc remoteproc1: can't start rproc 55020000.ipu: -19
> 
> I switched this errata fix to use timer 15 and 16 instead which resolves
> the error.  Do you think that is an acceptable solution?

I think the only difference is that timers 15 and 16 are in l4_per3 instead
of l4_per1. I doubt that matters as they are pretty much always clocked in
this case. If you want to check you can run cyclictest :)

> If so, I will post the patch to the list.

OK thanks,

Tony
