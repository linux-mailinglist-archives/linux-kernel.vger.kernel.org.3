Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4969A4764BE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhLOVmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:42:53 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:40487 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhLOVmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:42:52 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id D3C6340002;
        Wed, 15 Dec 2021 21:42:50 +0000 (UTC)
Date:   Wed, 15 Dec 2021 22:42:50 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Joel Daniels <jdaniels@sent.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, x86@kernel.org
Subject: Re: Time keeping while suspended in the presence of persistent clock
 drift
Message-ID: <YbphWpMl7W0Qzs+d@piout.net>
References: <5af5d2a5-767c-d313-3be6-cb6f426f1980@sent.com>
 <b074f506-2568-4506-9557-4a9bc9cbea83@www.fastmail.com>
 <87wnkbuuuz.ffs@tglx>
 <4bb238e1-e8fa-44e6-9f5e-d047d1d4a892@www.fastmail.com>
 <8735mvthk6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735mvthk6.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2021 14:57:45+0100, Thomas Gleixner wrote:
> Joel,
> 
> On Mon, Dec 13 2021 at 06:39, Joel Daniels wrote:
> > On Sat, 11 Dec 2021 14:36 +0100, Thomas Gleixner wrote:
> >> Can you please verify that the problem persists with NTP enabled and
> >> synchronized?
> >
> > Yes, I just verified that the problem still exists while
> > synchronized to NTP.
> ...
> >     $ chronyc tracking && echo && chronyc sources
> >     [...]
> >     Ref time (UTC)  : Mon Dec 13 13:30:52 2021
> >     System time     : 5.597892284 seconds fast of NTP time
> 
> thanks for making sure that this is really a RTC issue on that machine.
> 
> > The "if" branch does not apply as I have no clock sources flagged as
> > CLOCK_SOURCE_SUSPEND_NONSTOP but the "else if" branch does apply.
> 
> Which CPU is in that box?
> 
> > The kernel seems to believe that the time spent sleeping is exactly
> > the difference of two calls to read_persistent_clock64 with no option
> > to adjust for persistent clock drift.
> 
> The kernel does not believe. It relies on the accuracy of the CMOS clock
> which is usually pretty good.
> 
> > I would like to provide a way for user space to inform the kernel
> > that the persistent clock drifts so it can make a corresponding
> > adjustment when resuming from a long suspend period.
> >
> > In my use case it would be enough for me to set this parameter on
> > boot. In use cases with continuous network access, NTP daemons
> > could be enhanced to periodically update this parameter with the
> > daemon's best estimate of the persistent clock drift.
> 
> That needs some thought. The RTC people (cc'ed now) might have opionions
> on that.
> 

The RTC subsystem already has two interfaces to correct the drift of an
RTC. However, this is currently limited to RTC that have hardware
support for this feature. I guess we could had software emulation of the
feature to be able to correct for any RTCs  but this will raise many
design questions, like how often the correction has to happen, what to
do with RTC that have a counter that doesn't reset when setting their
time, etc...

I guess this would be able to solve your particular issue has you will
need a mechanism to handle when you overshoot the regular correction
timer.

However, everything falls down once the machine is turned off, making
the whole effort moot...


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
