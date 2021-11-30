Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68264636E5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242277AbhK3Om0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbhK3OmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:42:25 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A6EC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 06:39:06 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so19760585wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 06:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2bmfZ8/yojigYMGWoM6Ilhlpc1qceboy4zfRftSi5oE=;
        b=LelNjI21+uPTpwJ76SNMdaV3DjtJsBx8dnjf0VwM+0LmcN1y5BCEDw7nCes7XUOh+z
         yTrad4N4KdCVh/LnluKSRW8e/vcF4dArQZv+RNbruDy1uHiBV4OJKaFUXgVND4uubtB0
         8eot2gMSqo2kjJct9du0xxt+A6Aj71b0sjIlQKrt32wHieUro8uqKCvHPqRUk9+qtSOq
         2Dljh1tnUsYvjb1Je36fa5D1T/ltcG2WfTi1otHsxmRkOB4p/SKc0fYI1+3fW/WOfwG7
         LuH2epm7K+gLsltmVwc5N1MUQYA81PLO5Owp+vVfaZQqhMJargSvH35WC3RRJGtrr2KU
         Iwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2bmfZ8/yojigYMGWoM6Ilhlpc1qceboy4zfRftSi5oE=;
        b=W4DxZaOTUhtHKBTEUQEfZp29zuAsV2rkTwpSdI+wr6iUW7GDb98JDOtkDqUCd5nlTS
         dwOUb02t9MH+a6l7vOgNnAI6tE01Jrr009rxm9rJR7pSk/WEGHUdfV+Kb9if9ZDnN+/j
         3x1lPyIbmigbqrfiLjfdVOVvK6GEENuU0vk+07etyo7GxqSUS5L+qIK1hAiwt3ivbQeP
         C23gW0WYHAVT4M53Ro9A3uO+v2Grrxv3WPuUf+lxbb3368FgJ1oAuQRDmVQJhPyYuuAl
         MSaVDVYDkq/0rxJGe7J4inXqBLbAJlmZAlfEy1pVw9bL52ZaD7PGp97I6vL6afTd5BFd
         pkAA==
X-Gm-Message-State: AOAM531Isd5BDE9TuXt9Rd33TeJ2rleY5/G5NsLsTMuOjyWsNWvUGwCv
        BaalABwIt12VSsQnOf9nkLr2rzpJbpEXlg==
X-Google-Smtp-Source: ABdhPJxZ5sFmuSWzUiRoOR58P5Y8QszFbL7xBmWKGG3s4ojQayuw4RebmZPdbWjTK045kEQSGPY6bQ==
X-Received: by 2002:a05:600c:4f87:: with SMTP id n7mr5508835wmq.63.1638283144644;
        Tue, 30 Nov 2021 06:39:04 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:7880:daae:2d50:bb5e? ([2a01:e34:ed2f:f020:7880:daae:2d50:bb5e])
        by smtp.googlemail.com with ESMTPSA id u13sm3008168wmq.14.2021.11.30.06.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 06:39:04 -0800 (PST)
Subject: Re: [PATCH 1/5] clocksource: Add MStar MSC313e timer support
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211126202144.72936-1-romain.perier@gmail.com>
 <20211126202144.72936-2-romain.perier@gmail.com>
 <6cf881ea-1761-b3b2-5d0d-9a83595c1246@linaro.org>
 <CABgxDo+W3vg_dDTphkOLxRPzKER891CxTJnPPVuryj9YQOg1EQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4703d6f2-a056-b76b-b313-2695430683be@linaro.org>
Date:   Tue, 30 Nov 2021 15:39:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABgxDo+W3vg_dDTphkOLxRPzKER891CxTJnPPVuryj9YQOg1EQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2021 15:12, Romain Perier wrote:
> Hi,
> 
> Le lun. 29 nov. 2021 à 18:02, Daniel Lezcano <daniel.lezcano@linaro.org
> <mailto:daniel.lezcano@linaro.org>> a écrit :
> 
>     On 26/11/2021 21:21, Romain Perier wrote:
>     > The MSC313e-compatible SoCs have 3 timer hardware blocks. All of these
>     > are free running 32-bit increasing counters and can generate
>     interrupts.
>     > This commit adds basic support for these timers, the first timer block
>     > being used as clocksource/sched_clock and delay, while the others will
>     > be used as clockevents.
> 
>     Please you elaborate a bit more the internals of this timer as it is a
>     initial submission
> 
> 
> Ok, will try to elaborate.
>  
> 
> 
> 
>     > Signed-off-by: Romain Perier <romain.perier@gmail.com
>     <mailto:romain.perier@gmail.com>>
>     > Co-developed-by: Daniel Palmer <daniel@0x0f.com
>     <mailto:daniel@0x0f.com>>
>     > Signed-off-by: Daniel Palmer <daniel@0x0f.com
>     <mailto:daniel@0x0f.com>>
>     > ---
>     >  MAINTAINERS                         |   1 +
>     >  drivers/clocksource/Kconfig         |  10 ++
>     >  drivers/clocksource/Makefile        |   1 +
>     >  drivers/clocksource/timer-msc313e.c | 228
>     ++++++++++++++++++++++++++++
>     >  4 files changed, 240 insertions(+)
>     >  create mode 100644 drivers/clocksource/timer-msc313e.c
>     >
>     > diff --git a/MAINTAINERS b/MAINTAINERS
>     > index 7a2345ce8521..f39a1617bf50 100644
>     > --- a/MAINTAINERS
>     > +++ b/MAINTAINERS
>     > @@ -2282,6 +2282,7 @@ F:     
>     Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
>     >  F:   arch/arm/boot/dts/mstar-*
>     >  F:   arch/arm/mach-mstar/
>     >  F:   drivers/clk/mstar/
>     > +F:   drivers/clocksource/timer-msc313e.c
>     >  F:   drivers/gpio/gpio-msc313.c
>     >  F:   drivers/rtc/rtc-msc313.c
>     >  F:   drivers/watchdog/msc313e_wdt.c
>     > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>     > index f65e31bab9ae..822e711da284 100644
>     > --- a/drivers/clocksource/Kconfig
>     > +++ b/drivers/clocksource/Kconfig
>     > @@ -671,6 +671,16 @@ config MILBEAUT_TIMER
>     >       help
>     >         Enables the support for Milbeaut timer driver.
>     > 
>     > +config MSC313E_TIMER
>     > +     bool "MSC313E timer driver"
> 
>     Silent option please and platform config option enables it.
> 
> 
> What do you mean ? no short description at all ?

We try to let the platform Kconfig option to select silently the timer
in order to prevent selecting it manually.

If the timer is mandatory on your platform it should be a silent option,
except for COMPILE_TEST

That leads to:

	bool "MSC313E timer driver" if COMPILE_TEST

and you should be able to compile it on x86, ...

If the timer is optional because there is another one on the platform,
it could be unselected manually. That is the configuration you've done here.

So if there is no other broadcast timer, this timer should selected for
the platform and the option should be silent (except in case of
COMPILE_TEST).

>     > +     depends on ARCH_MSTARV7 || COMPILE_TEST
>     > +     select TIMER_OF
>     > +     select CLKSRC_MMIO
>     > +     help
>     > +       Enables support for the MStar MSC313E timer driver.
>     > +       This provides access to multiple interrupt generating
>     > +       programmable 32-bit free running incrementing counters.
>     > +
>     >  config INGENIC_TIMER

[ ... ]

>     > +
>     > +struct msc313e_delay {
>     > +     void __iomem *base;
>     > +     struct delay_timer delay;
>     > +};
>     > +
>     > +static void __iomem *msc313e_clksrc;
>     > +static struct msc313e_delay msc313e_delay;
> 
>     I'm not sure that compiles on other platform than mstarv7
> 
> 
> It is armv7-based, and its size is known at build-time, no ?
> Everything builds with WERROR here.

I should have say "arch" instead of "platform".

The COMPILE_TEST option is set above, that means the driver can be
compiled on a x86 (for compilation test coverage, stubs already exists
except for delay AFAIR).

[ ... ]

>     > +     msc313e_delay.base = timer_of_base(&to);
>     > +     msc313e_delay.delay.read_current_timer =
>     msc313e_read_delay_timer_read;
>     > +     msc313e_delay.delay.freq = timer_of_rate(&to);
>     > +
>     > +     msc313e_clksrc = timer_of_base(&to);
>     > +     reg = readw(msc313e_clksrc + MSC313E_REG_CTRL);
>     > +     reg |= MSC313E_REG_CTRL_TIMER_EN;
>     > +     writew(reg, msc313e_clksrc + MSC313E_REG_CTRL);
>     > +
>     > +     register_current_timer_delay(&msc313e_delay.delay);
>     > +
>     > +     sched_clock_register(msc313e_timer_sched_clock_read, 32,
>     timer_of_rate(&to));
>     > +     return clocksource_mmio_init(timer_of_base(&to), TIMER_NAME,
>     timer_of_rate(&to), 300, 32,
>     > +                                  msc313e_timer_clksrc_read);
> 
>     format 80char max please, run checkpatch.pl <http://checkpatch.pl>
>     before submitting
> 
> 
> max_line_lenght is set to "100" in checkpatch.pl <http://checkpatch.pl>
> since a while now :) .
> I have passed it with "--strict" before sending the series, however, if
> you prefer 80 chars
> max just ask, I can limit to 80 chars.

Oh, indeed. Fair enough, limit to 80 chars is now deprecated and
suggested length is 100.

In this case, at your convenience.

Thanks
  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
