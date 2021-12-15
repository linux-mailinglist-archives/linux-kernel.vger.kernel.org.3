Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750B4476682
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhLOX21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:28:27 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:36235 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhLOX20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:28:26 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 781AA100002;
        Wed, 15 Dec 2021 23:28:24 +0000 (UTC)
Date:   Thu, 16 Dec 2021 00:28:24 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Joel Daniels <jdaniels@sent.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, x86@kernel.org
Subject: Re: Time keeping while suspended in the presence of persistent clock
 drift
Message-ID: <Ybp6GHIwpx84wSHL@piout.net>
References: <5af5d2a5-767c-d313-3be6-cb6f426f1980@sent.com>
 <b074f506-2568-4506-9557-4a9bc9cbea83@www.fastmail.com>
 <87wnkbuuuz.ffs@tglx>
 <4bb238e1-e8fa-44e6-9f5e-d047d1d4a892@www.fastmail.com>
 <8735mvthk6.ffs@tglx>
 <2ab24da8-e37d-426a-9500-b7541d21f8a3@www.fastmail.com>
 <CALAqxLXf6TmOn_jCOv68oop=4On+CN-p_KkN-70BDt9OjQhzUw@mail.gmail.com>
 <83deaa79-39eb-4fd7-ad80-9d233fd6fdbb@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83deaa79-39eb-4fd7-ad80-9d233fd6fdbb@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2021 15:42:05-0700, Joel Daniels wrote:
> Measuring RTC drift is hard. The standard PC RTC has only one second
> resolution so you have to wait for the "edge" of a tick and measure
> drift over an extended period of time.

Having a one second resolution and measuring drift is orthogonal. The
proper way to read the time from an RTC is not to read its time but to
program an alarm or an update interrupt.

> If you have some NTP daemon
> slewing your system clock while you try to measure RTC drift then
> you will get garbage.

Yeah, the issue is that CLOCK_MONOTONIC is affected by adjtime.

> If your motherboard gets hot enough then your
> RTC will run at a different rate while the machine is on than while
> it is off.

Indeed, you get about 1ppm per degree Celsius on a typical quartz. the
farther away you get from 25°C, the worse it gets.
You also lose about 5ppm per year due to aging.

> 
> I know of three programs that measure RTC drift today:
> 
>   # hwclock: you must use it to set the RTC twice, the second time
>     with the "--update-drift" argument. The manual suggests waiting
>     one day between calls. The drift and offset information is
>     stored in /etc/adjtime. On boot "hwclock --hctosys" will use this
>     to set the system clock correctly.
> 
>   # adjtimex (program not syscall) when run with the "--compare"
>     option. It uses a least squares estimate from multiple samples
>     which by default are each 10 seconds apart.
> 
>   # chrony with the "rtcfile" directive. It tracks the RTC over time
>     to measure its offset and drift similarly to how it tracks the
>     system clock drift. Tracking information is saved into
>       /var/lib/chrony/rtc
>     and can be used (via "chronyd -s") to set the system clock
>     correctly on next boot.
> 
> Any method of measuring the drift is going to need to persist the
> drift coefficient to disk so that it can set the system clock
> correctly on boot. I think it would be best for the kernel to use this
> same coefficient.
> 

I usually use chrony to measure the drift and then get the RTC to
correct its own drift when it is supported by the hardware. The value is
then stored directly on the RTC and nothing more is needed.

Anything that is not using NTP will actually measure the drift
difference between the clocksource and the RTC and I've seen systems
where the RTC was drifting less than the clocksource so you may be
overcompensating in the wrong direction.

Note that on any system using systemd, the kernel hctosys will be used
to the the system time at boot so you may be already more than a second
away from the actual time.

> > Alternatively I'd go very simple and just put the correction factor in
> > a boot argument.
> 
> This works for my use case though it won't be useful to a general
> distro. Would you have one argument being used regardless of where the
> sleep injection was coming from or would you try to tie it to the
> persistent clock and/or a specific RTC?

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
