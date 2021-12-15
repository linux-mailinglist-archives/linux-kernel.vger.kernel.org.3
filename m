Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E95247649B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhLOVcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:32:48 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34617 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhLOVcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:32:47 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A3CE26000D;
        Wed, 15 Dec 2021 21:32:44 +0000 (UTC)
Date:   Wed, 15 Dec 2021 22:32:44 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Joel Daniels <jdaniels@sent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, x86@kernel.org
Subject: Re: Time keeping while suspended in the presence of persistent clock
 drift
Message-ID: <Ybpe/ND+MQq6tqoR@piout.net>
References: <5af5d2a5-767c-d313-3be6-cb6f426f1980@sent.com>
 <b074f506-2568-4506-9557-4a9bc9cbea83@www.fastmail.com>
 <87wnkbuuuz.ffs@tglx>
 <4bb238e1-e8fa-44e6-9f5e-d047d1d4a892@www.fastmail.com>
 <8735mvthk6.ffs@tglx>
 <2ab24da8-e37d-426a-9500-b7541d21f8a3@www.fastmail.com>
 <CALAqxLXf6TmOn_jCOv68oop=4On+CN-p_KkN-70BDt9OjQhzUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLXf6TmOn_jCOv68oop=4On+CN-p_KkN-70BDt9OjQhzUw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2021 13:06:30-0800, John Stultz wrote:
> I'm not really active in this space much anymore, but a few of my
> (possibly wrongheaded) thoughts:
> 
> >    [A] On machines with a persistent clock how is userspace supposed
> >        to be sure what drift to measure? Can it assume that the drift
> >        of the persistent clock used for sleep time injection is the
> >        same as the drift of /dev/rtc? This seems dangerous.
> 
> Yea, there can be multiple RTCs as well.
> 
> >    [B] Sleep time injection can come from the "persistent clock" or,
> >        if there is no persistent clock, from an RTC driver. I'd like
> >        to correct for drift from the perisistant clock but not touch
> >        the RTC driver sleep time injection mechanism. Is this
> >        acceptable or do people feel that any drift correction should
> >        work with both mechanisms in order to ensure a polished
> >        interface?
> 
> This dual interface comes from the desire to support both the more
> atomic/earlier correction we can do w/ the persistent_clock interface
> while holding the timekeeping lock, while also supporting RTC devices
> that may sleep when being read, or may have dependencies that aren't
> ready that early in resume.
> 
> Admittedly having two separate abstractions here is a bit of a pain,
> and fixing just one side doesn't make it better.
> 
> >    [C] Some users may want to correct for drift during suspend-to-RAM
> >        but during suspend-to-disk they might boot into some other
> >        operating system which itself sets the CMOS RTC. Hopefully,
> >        this could be solved from userspace by changing the drift
> >        correction parameter to 0 just before a suspend-to-disk
> >        operation.
> 
> Oof. This feels particularly complex and fragile to try to address.
> 
> > I suspect that there are other things about which I should also be
> > worried if only I were less ignorant. That is why I am asking here.
> 
> Personally, I'm not sure this warrants adding new userland interfaces
> for. I'd probably lean towards having the RTC framework internally
> measure and correct for drift, rather than adding an extra knob in
> userland.
> 

I'd rather lean towards the timekeeping code doing that. The RTC
subsystem doesn't know which RTC has to be used.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
