Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECBC476695
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhLOXgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:36:11 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:39869 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhLOXgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:36:10 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 25EA11BF206;
        Wed, 15 Dec 2021 23:36:09 +0000 (UTC)
Date:   Thu, 16 Dec 2021 00:36:08 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Joel Daniels <jdaniels@sent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, x86@kernel.org
Subject: Re: Time keeping while suspended in the presence of persistent clock
 drift
Message-ID: <Ybp76D62Le2aEc5R@piout.net>
References: <5af5d2a5-767c-d313-3be6-cb6f426f1980@sent.com>
 <b074f506-2568-4506-9557-4a9bc9cbea83@www.fastmail.com>
 <87wnkbuuuz.ffs@tglx>
 <4bb238e1-e8fa-44e6-9f5e-d047d1d4a892@www.fastmail.com>
 <8735mvthk6.ffs@tglx>
 <2ab24da8-e37d-426a-9500-b7541d21f8a3@www.fastmail.com>
 <CALAqxLXf6TmOn_jCOv68oop=4On+CN-p_KkN-70BDt9OjQhzUw@mail.gmail.com>
 <83deaa79-39eb-4fd7-ad80-9d233fd6fdbb@www.fastmail.com>
 <CALAqxLX795pURb_aJTEAdq80LGiY=br88A+R3TN3HQh+HtS85Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLX795pURb_aJTEAdq80LGiY=br88A+R3TN3HQh+HtS85Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2021 15:26:28-0800, John Stultz wrote:
> > Any method of measuring the drift is going to need to persist the
> > drift coefficient to disk so that it can set the system clock
> > correctly on boot. I think it would be best for the kernel to use this
> > same coefficient.
> 
> My initial thought was for the rtc class layer to do the estimation
> internally against the system time (assuming it was NTP corrected) to
> try establish a close enough correction factor as the system was up
> and running, but you're right that would be reset on every reboot, and
> with second granular RTCs accurate error calculations will take awhile
> (though polling for the second-edge might work well enough, but would
> be cpu heavy for a background task).
> 
> Maybe that's a good enough argument for having an ADJ ioctl added to
> the rtc chardev?
> 

Then why not got for the correction software emulation? that would avoid
duplicating interfaces and we'd avoid to use it on RTCs with hardware
support.

> But it also seems to suggest that if chronyd already has all this
> logic in userland, maybe having it calculate and call settimeofday()
> on resume from userland instead of pushing half of that logic into the
> kernel?

My suggestion would leave the correction calculation to userspace which
is definitively where it should stay.

> 
> > > Alternatively I'd go very simple and just put the correction factor in
> > > a boot argument.
> >
> > This works for my use case though it won't be useful to a general
> > distro. Would you have one argument being used regardless of where the
> > sleep injection was coming from or would you try to tie it to the
> > persistent clock and/or a specific RTC?
> 
> I agree it is an important thing to consider how to generalize this
> for common use (which is why I prefer the approach that works
> *without* any distro integration).
> 
> But it's also important to consider if the added complexity is
> *really* needed in the general case.
> 
> thanks
> -john

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
