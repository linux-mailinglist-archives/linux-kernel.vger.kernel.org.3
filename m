Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8155E4851C1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 12:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbiAEL0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239665AbiAEL0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:26:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019D2C061761;
        Wed,  5 Jan 2022 03:26:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3DE5B81A5F;
        Wed,  5 Jan 2022 11:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE60C36AEB;
        Wed,  5 Jan 2022 11:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641381962;
        bh=p7ARozmpHvdBcT5Sr9I/4lpUUJk42PlcQIdWxwnken8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f085ntndt8wl1xZbURfzaE4LBumsXRrBAOzVzTWwKQUPQIzjxy1HKaK9h+S2ume8G
         D7qitRy09jLdWFQ6oaz0VVniaWFsa3ynQ2176GyOoePj2cYVMoLGIm9JRka0bUgn5f
         9wmuAr0/HkdiWrzcz03ztA02HKm1i42tNYb6qnJHUcIVJIMLE/y8KHgGrxUW248RTV
         uPJUzeWm7ghp7fKTc7oPDnqBer3UVc5uDolxzyaOKEeDfpM/V1lAhOW3ZUdQ9L8btR
         96Jcmc1htW1mypF5aS4jnDOfVfWE5v7bvtaLygOcX+xY963g+uxEneJbI/B+ZZsjfL
         UOdhbMn+SSVzA==
Date:   Wed, 5 Jan 2022 11:25:55 +0000
From:   Will Deacon <will@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-perf-users@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v13 3/5] arm64: perf: Add userspace counter access
 disable switch
Message-ID: <20220105112555.GA3113@willie-the-truck>
References: <20211208201124.310740-1-robh@kernel.org>
 <20211208201124.310740-4-robh@kernel.org>
 <CAMuHMdVcDxR9sGzc5pcnORiotonERBgc6dsXZXMd6wTvLGA9iw@mail.gmail.com>
 <20220104135658.GC1827@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104135658.GC1827@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 01:56:59PM +0000, Will Deacon wrote:
> On Tue, Dec 28, 2021 at 12:07:02PM +0100, Geert Uytterhoeven wrote:
> > On Wed, Dec 8, 2021 at 9:19 PM Rob Herring <robh@kernel.org> wrote:
> > > Like x86, some users may want to disable userspace PMU counter
> > > altogether. Add a sysctl 'perf_user_access' file to control userspace
> > > counter access. The default is '0' which is disabled. Writing '1'
> > > enables access.
> > >
> > > Note that x86 supports globally enabling user access by writing '2' to
> > > /sys/bus/event_source/devices/cpu/rdpmc. As there's not existing
> > > userspace support to worry about, this shouldn't be necessary for Arm.
> > > It could be added later if the need arises.
> > 
> > Thanks for your patch, which is now commit e2012600810c9ded ("arm64:
> > perf: Add userspace counter access disable switch") in arm64/for-next/core.
> > 
> > This is causing two issues on Renesas Salvator-XS with R-Car H3.
> > One during kernel boot:
> > 
> >      hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7
> > counters available
> >     +sysctl duplicate entry: /kernel//perf_user_access
> >     +CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> > 5.16.0-rc3-arm64-renesas-00003-ge2012600810c #1420
> >     +Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
> >     +Call trace:
> >     + dump_backtrace+0x0/0x190
> >     + show_stack+0x14/0x20
> >     + dump_stack_lvl+0x88/0xb0
> >     + dump_stack+0x14/0x2c
> >     + __register_sysctl_table+0x384/0x818
> >     + register_sysctl+0x20/0x28
> >     + armv8_pmu_init.constprop.0+0x118/0x150
> >     + armv8_a57_pmu_init+0x1c/0x28
> >     + arm_pmu_device_probe+0x1b4/0x558
> >     + armv8_pmu_device_probe+0x18/0x20
> >     + platform_probe+0x64/0xd0
> >     + really_probe+0xb4/0x2f8
> >     + __driver_probe_device+0x74/0xd8
> >     + driver_probe_device+0x3c/0xe0
> >     + __driver_attach+0x80/0x110
> >     + bus_for_each_dev+0x6c/0xc0
> >     + driver_attach+0x20/0x28
> >     + bus_add_driver+0x138/0x1e0
> >     + driver_register+0x60/0x110
> >     + __platform_driver_register+0x24/0x30
> >     + armv8_pmu_driver_init+0x18/0x20
> >     + do_one_initcall+0x15c/0x31c
> >     + kernel_init_freeable+0x2f0/0x354
> >     + kernel_init+0x20/0x120
> >     + ret_from_fork+0x10/0x20
> >      hw perfevents: enabled with armv8_cortex_a57 PMU driver, 7
> > counters available
> > 
> > Presumably the same entry is added twice, once for the A53 PMU,
> > and a second time for the A57 PMU?
> 
> Looks like it, and perhaps that's also what is confusing systemd?
> Rob -- how come you didn't see this during your testing?
> 
> Anywho, please can you try the untested diff below?

I just remembered I have a big/little SoC on my desk after borrowing a
NanoPi (RK3399) from Marc Z, so I took this diff for a spin there and
both the kernel and systemd seem happy.

Will
