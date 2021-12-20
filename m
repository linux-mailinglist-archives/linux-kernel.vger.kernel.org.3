Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D01647B429
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 21:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhLTUB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 15:01:59 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:42932 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhLTUB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 15:01:56 -0500
Received: by mail-ua1-f51.google.com with SMTP id t13so19680211uad.9;
        Mon, 20 Dec 2021 12:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2HdgFe/F0Xrd6v2TuIEuIzQpQGOwif0mlIowSrXHAWw=;
        b=LMo2H/exIFBAWT9culQl8w5eHr83SqXQ8uRusgV5g8msibBOPbMxB9Ea99aIrKi+en
         ntx7IrQb9n2T8HMlU+2QT0jRehPeq7Ish8EQuoSIbX5/9426KLMX2CDJbpiEqs5yUFpc
         DP/PGWeJ9GtT+jSGnPXE5O4g6znMHBjxWwo3RjlPWZzybjjvtQS+xyXVqszmGhvYTYKe
         vgvzgQb0t9Ufj1Awx+OHEZUFlKsrjCYowPQ2cZ8RNYvG/ZDTPOJRtol/JQUvUORux8Tp
         XgbBiXv5zb25eDS2qogxtL81SQ3hY83H6Al/z1Hpsru1PtUjyIrxsDixmrbzhGG82P3h
         Gy1g==
X-Gm-Message-State: AOAM5302GW3GryyEp0ynC3eWf5OGb0LPTrCBN7zxDhxDtTTUVA0FRy9C
        yudS/66c7srZ44zLl8v1fVqr1N2/yDuyaw==
X-Google-Smtp-Source: ABdhPJwBCARbRCpTr8OpZ9H37RtiX8Un5lNmA7qNg0gpJtbhaPxPyYhWwR/Gf67rFQEvdOs0E2Cq+g==
X-Received: by 2002:a67:fb81:: with SMTP id n1mr2497516vsr.65.1640030515758;
        Mon, 20 Dec 2021 12:01:55 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id x21sm3770370ual.11.2021.12.20.12.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 12:01:55 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id r15so19748002uao.3;
        Mon, 20 Dec 2021 12:01:55 -0800 (PST)
X-Received: by 2002:a67:2e09:: with SMTP id u9mr661275vsu.77.1640030515217;
 Mon, 20 Dec 2021 12:01:55 -0800 (PST)
MIME-Version: 1.0
References: <20211219132442.4080-1-wsa+renesas@sang-engineering.com>
 <20211219132442.4080-2-wsa+renesas@sang-engineering.com> <CAMuHMdVh60ocfzkJKz8zR1hODr8SWp=sbyHrR3KGx2ntLmuFGQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVh60ocfzkJKz8zR1hODr8SWp=sbyHrR3KGx2ntLmuFGQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Dec 2021 21:01:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVuxfndapH2eyBVGrqqyoeA9gwrCq1zbbjdxab2DvA-MQ@mail.gmail.com>
Message-ID: <CAMuHMdVuxfndapH2eyBVGrqqyoeA9gwrCq1zbbjdxab2DvA-MQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] gpio: add sloppy logic analyzer using polling
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 3:12 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
 On Mon, Dec 20, 2021 at 10:07 AM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > +       [ -d "$lacpusetdir" ] || mkdir "$lacpusetdir"
> > +
> > +       cur_cpu="$(cat "$lacpusetdir"/cpus)"
>
> cat: /dev/cpuset/gpio-sloppy-logic-analyzer/cpus: No such file or directory
>
> I do have a "cpuset.cpus" file.
>
> > +       [ "$cur_cpu" = "$isol_cpu" ] && return
> > +       [ -z "$cur_cpu" ] || fail "CPU$isol_cpu requested but CPU$cur_cpu already isolated"
> > +
> > +       echo "$isol_cpu" > "$lacpusetdir"/cpus || fail "Could not isolate CPU$isol_cpu. Does it exist?"
> > +       echo 1 > "$lacpusetdir"/cpu_exclusive
> > +       echo 0 > "$lacpusetdir"/mems
>
> No complaint, although the real files have a "cpuset."-prefix again.
>
> [...]
>
> > +workcpu=$(cat "$lacpusetdir"/effective_cpus)
>
> cat: /dev/cpuset/gpio-sloppy-logic-analyzer/effective_cpus: No such
> file or directory
>
> I do have a "cpuset.effective_cpus" file.
>
> > +[ -n "$workcpu" ] || fail "No isolated CPU found"
> > +cpumask=$(printf '%x' $((1 << workcpu)))
> > +instance=${lasysfsdir##*/}
> > +echo "Setting up '$instance': $numsamples samples at ${samplefreq}Hz with ${triggerdat:-no} trigger using CPU$workcpu"
> > +do_capture "$cpumask" &
>
> Anyone with a clue? Thanks!

Documentation/admin-guide/cgroup-v1/cpusets.rst also has the prefixes,
so I'm wondering if you have some "legacy compatibility" config option
enabled?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
