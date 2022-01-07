Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51539487B06
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 18:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348480AbiAGRJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 12:09:00 -0500
Received: from mail-vk1-f172.google.com ([209.85.221.172]:39533 "EHLO
        mail-vk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiAGRI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:08:58 -0500
Received: by mail-vk1-f172.google.com with SMTP id m200so4077885vka.6;
        Fri, 07 Jan 2022 09:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=uz+6BXh4Z52ZUQtzR9JKwYOpZReL+4Yw1Gm06dlXLiA=;
        b=sf7Y5gJRuD8tZtIDep5ThICTvK0q9kwV4PZWLrnkn3P4RmvM8Rlkvfb5sl7ltdBwxg
         4Y+s9bC4FAUD7v7T6oXwLa+QDY3kTUP3UoJGUjXFR7c2P3QBa9RwDE2edkmuJMZg/Jzt
         1qsHqs8h+tKDM8AVNwdJY47/m9IW6Vpb1fVD9rTE7P8CmvLR3Zo+/pqg7+0NG/8RXSRY
         UlpYqVDgWIFthvdozeZD8hWiIcE4W/rUgwn5+gznWTpYdKT7CjS/CxQbzU/5oyEcGpKG
         78hFdaj6c1YbM3+pGWx9QgODQdGxR9pYD8Fmbhao+RU5q18iWisZdcoK7Qwu+jHxLXoz
         jqtA==
X-Gm-Message-State: AOAM531uQHN60g9YbNGMEUFlQrD1u0NUHsbL/4K1ghMRa2qqRQ+i98az
        itxdbv8J+UQA3NZKGvKrXkBBRO/Y3YcXRA==
X-Google-Smtp-Source: ABdhPJzHw1xhFn7uoHIHdVcNm8AygsUXJGzzExNqdDe/Dmz4mhKr/+c0Zg2TPVrA6DunCoqtr7QNVA==
X-Received: by 2002:a05:6122:1799:: with SMTP id o25mr24089375vkf.3.1641575336998;
        Fri, 07 Jan 2022 09:08:56 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id h2sm3865441vsj.5.2022.01.07.09.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 09:08:56 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id o1so11355295uap.4;
        Fri, 07 Jan 2022 09:08:56 -0800 (PST)
X-Received: by 2002:a05:6102:2155:: with SMTP id h21mr21200168vsg.68.1641575336492;
 Fri, 07 Jan 2022 09:08:56 -0800 (PST)
MIME-Version: 1.0
References: <20211219132442.4080-1-wsa+renesas@sang-engineering.com>
 <20211219132442.4080-2-wsa+renesas@sang-engineering.com> <CAMuHMdVh60ocfzkJKz8zR1hODr8SWp=sbyHrR3KGx2ntLmuFGQ@mail.gmail.com>
 <YcL7p5nzZs8vnojl@shikoro> <CAMuHMdXn-cmK1HewukjOnjC1JEgfFfH7FW23YvPTKHcNCiet2w@mail.gmail.com>
 <YcMg8NzjlNDLksNT@ninjato>
In-Reply-To: <YcMg8NzjlNDLksNT@ninjato>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Jan 2022 18:08:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW+=5UM+Jcbu9pTi-tKCfJh42pRk0YrA9ZSbvziNsbAFg@mail.gmail.com>
Message-ID: <CAMuHMdW+=5UM+Jcbu9pTi-tKCfJh42pRk0YrA9ZSbvziNsbAFg@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] gpio: add sloppy logic analyzer using polling
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Wed, Dec 22, 2021 at 1:58 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > Yes, the search engines helped[1]. I run a minimal system, so when I
> > > mount cpusets, it will actually mount cgroups with a default mount
> > > option of "noprefix". But you likely run a rootfs with cgroups already,
> > > so it gets mounted directly without "noprefix". Then, when the logic
> > > analyzer tries to mount again, the implied default "noprefix" is
> > > discarded.
> >
> > Yeah, systemd on Debian has it mounted.
>
> So, the proper solution is to use/mount 'cgroups2' instead of 'cpuset'.
> But this needs more thinking and testing and, thus, another revision.
> Dunno if I can make it this year, so I am probably going to miss the
> next merge window after all :(
>
> Geert, if you still want to test the PFC patch I sent, then this patch
> for the script should get you going:

Thank you, much better!

With this I get:

    1# gpio-sloppy-logic-analyzer -s 1500000 -t 1H+2F -d 15000
    Auto-Isolating CPU1
    Setting up 'i2c2-analyzer': 22500 samples at 1500000Hz with 1H+2F
trigger using CPU1
    1# echo: write error: Numerical result out of range
    Capture error! Check kernel log

kernel log has:

    gpio-sloppy-logic-analyzer i2c2-analyzer: couldn't read GPIOs: -34

with debug code:

    priv->delay_ns = 666
    priv->acq_delay = 2342

Whoops, R-Car M2-W GPIO is too slow (clocked at 10 MHz, compared to 66
MHz on R-Car H3 ES2.0)?

Retry with slower speed, until it works:

    1# gpio-sloppy-logic-analyzer -s 300000 -t 1H+2F -d 15000
    Setting up 'i2c2-analyzer': 4500 samples at 300000Hz with 1H+2F
trigger using CPU1
    2# i2cdetect -y 2
    1# cp: cannot stat
'/sys/kernel/debug/gpio-sloppy-logic-analyzer/i2c2-analyzer/sample_data':
No such file or directory

And the sample_data file is indeed missing.

After reboot, everything works fine, and I can no longer reproduce the
missing file issue above, even when repeating the same steps.
The resulting data file can be viewed with pulseview, and I can see SCL
and SDA activity. Nice!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
