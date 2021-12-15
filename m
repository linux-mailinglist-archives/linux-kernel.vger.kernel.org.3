Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780CF47667F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhLOX0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhLOX0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:26:42 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DF8C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:26:42 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m6so34317610lfu.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcHo33xzIOtmp7c3bKuGJhHB6p8wPg6+OBcYmDbcbH4=;
        b=QDVg3hllEkz0TXTcOs6+PKXolvCwOMSwdIwUFsp5PnbihOUyEVG+nhcBq4jiOimcNy
         YbIX8Mft+DUIco6EyrzeGfR8HsQM+ilG8lNKHda8j4UGfHr2aXSaPI3SlrnxAN+Hr55U
         BD5aDZYU6+giXiGQdBFD6gt9Qo6SSc37QjwRC8CwuMxUDKK+ow0YQQVl58dfK+dUh82s
         t13RtS43Jq32VPxwZEz0dHDWW5PcpTY60gkVl535gR8uB33jDCzRHtgF3psCoNFFGAgp
         NJMIPRImBNoNE+hjXC6BCNsf6/Jc8jp2AR/gSRHAu9mJE9A6YuLnFqZo30gQ6w+jMzdw
         dpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcHo33xzIOtmp7c3bKuGJhHB6p8wPg6+OBcYmDbcbH4=;
        b=w+NN8TXY8hpo+7n6hCRX40w/CYwuCYaci/Jp9bCpZIyjexxLNqu/IpRikYqIEtBHxW
         He8m0Eu/BRCUule8cCMrC/0gep21oDF0TfPnFhC0yHy7U0LleYf0k7Byv7D1aPUcCXtx
         zH7Vvrpt+IPsQLXiu7W+VOEZTn1ST7X2Bbm6GjexKUSujKRWmTqacwoju0WO1aIoed12
         6tDAfZr1oH/7k4kcAwz+JTUiImTH6d5/smoIQGX6q6+TVzKLQ7iSgZNgg1WNd/L/rn7J
         AkTSHxdJ8ezCL220O0bTw3/iJi44in4XofqyIAXKZWPR7PX4jZw9ze0cvzFLa5ZCXVj7
         Sa1Q==
X-Gm-Message-State: AOAM532GO2YgLGiNv27F6UH6e5KnW083oK5Fnkv9RGLg5wptdPyC72q9
        qXTAv7OqEyqIg7rFZRvMgbTEuPk6YtVbrtWaces+Mg==
X-Google-Smtp-Source: ABdhPJzWbnHRB2ZFvLPt8OwCZ4t1rvOqOSO1x4ZnIXyVlMP8WRF3RQfhXXxbRkl78n67uWm+rMO2zc6dxCM0Yj4GEBI=
X-Received: by 2002:a05:6512:32ae:: with SMTP id q14mr2044133lfe.533.1639610800328;
 Wed, 15 Dec 2021 15:26:40 -0800 (PST)
MIME-Version: 1.0
References: <5af5d2a5-767c-d313-3be6-cb6f426f1980@sent.com>
 <b074f506-2568-4506-9557-4a9bc9cbea83@www.fastmail.com> <87wnkbuuuz.ffs@tglx>
 <4bb238e1-e8fa-44e6-9f5e-d047d1d4a892@www.fastmail.com> <8735mvthk6.ffs@tglx>
 <2ab24da8-e37d-426a-9500-b7541d21f8a3@www.fastmail.com> <CALAqxLXf6TmOn_jCOv68oop=4On+CN-p_KkN-70BDt9OjQhzUw@mail.gmail.com>
 <83deaa79-39eb-4fd7-ad80-9d233fd6fdbb@www.fastmail.com>
In-Reply-To: <83deaa79-39eb-4fd7-ad80-9d233fd6fdbb@www.fastmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 15 Dec 2021 15:26:28 -0800
Message-ID: <CALAqxLX795pURb_aJTEAdq80LGiY=br88A+R3TN3HQh+HtS85Q@mail.gmail.com>
Subject: Re: Time keeping while suspended in the presence of persistent clock drift
To:     Joel Daniels <jdaniels@sent.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 2:44 PM Joel Daniels <jdaniels@sent.com> wrote:
> >>    [A] On machines with a persistent clock how is userspace supposed
> >>        to be sure what drift to measure? Can it assume that the drift
> >>        of the persistent clock used for sleep time injection is the
> >>        same as the drift of /dev/rtc? This seems dangerous.
> >
> > Yea, there can be multiple RTCs as well.
> >
> >>    [B] Sleep time injection can come from the "persistent clock" or,
> >>        if there is no persistent clock, from an RTC driver. I'd like
> >>        to correct for drift from the perisistant clock but not touch
> >>        the RTC driver sleep time injection mechanism. Is this
> >>        acceptable or do people feel that any drift correction should
> >>        work with both mechanisms in order to ensure a polished
> >>        interface?
> >
> > This dual interface comes from the desire to support both the more
> > atomic/earlier correction we can do w/ the persistent_clock interface
> > while holding the timekeeping lock, while also supporting RTC devices
> > that may sleep when being read, or may have dependencies that aren't
> > ready that early in resume.
> >
> > Admittedly having two separate abstractions here is a bit of a pain,
> > and fixing just one side doesn't make it better.
>
> Thanks; that makes sense to me. I suppose I ought to have a separate
> sleep-time-injection drift correction parameter per RTC? That way the
> kernel wouldn't do something silly if somebody hotplugs one RTC while
> removing another. The persistent clock is almost always exposed as an
> RTC as well, so either I could try to be very clever and make the
> persistent clock share the drift correction parameter of its
> corresponding RTC or I could just maintain a separate correction for
> the persistent clock.
>
> >>    [C] Some users may want to correct for drift during suspend-to-RAM
> >>        but during suspend-to-disk they might boot into some other
> >>        operating system which itself sets the CMOS RTC. Hopefully,
> >>        this could be solved from userspace by changing the drift
> >>        correction parameter to 0 just before a suspend-to-disk
> >>        operation.
> >
> > Oof. This feels particularly complex and fragile to try to address.
>
> Yes, I think we should ignore this issue and treat all suspend/resume
> cycles identically. People who regularly dual-boot can just not use
> the new feature.
>
> > Personally, I'm not sure this warrants adding new userland interfaces
> > for. I'd probably lean towards having the RTC framework internally
> > measure and correct for drift, rather than adding an extra knob in
> > userland.
>
> Measuring RTC drift is hard. The standard PC RTC has only one second
> resolution so you have to wait for the "edge" of a tick and measure
> drift over an extended period of time. If you have some NTP daemon
> slewing your system clock while you try to measure RTC drift then
> you will get garbage. If your motherboard gets hot enough then your
> RTC will run at a different rate while the machine is on than while
> it is off.
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

My initial thought was for the rtc class layer to do the estimation
internally against the system time (assuming it was NTP corrected) to
try establish a close enough correction factor as the system was up
and running, but you're right that would be reset on every reboot, and
with second granular RTCs accurate error calculations will take awhile
(though polling for the second-edge might work well enough, but would
be cpu heavy for a background task).

Maybe that's a good enough argument for having an ADJ ioctl added to
the rtc chardev?

But it also seems to suggest that if chronyd already has all this
logic in userland, maybe having it calculate and call settimeofday()
on resume from userland instead of pushing half of that logic into the
kernel?

> > Alternatively I'd go very simple and just put the correction factor in
> > a boot argument.
>
> This works for my use case though it won't be useful to a general
> distro. Would you have one argument being used regardless of where the
> sleep injection was coming from or would you try to tie it to the
> persistent clock and/or a specific RTC?

I agree it is an important thing to consider how to generalize this
for common use (which is why I prefer the approach that works
*without* any distro integration).

But it's also important to consider if the added complexity is
*really* needed in the general case.

thanks
-john
