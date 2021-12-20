Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB99147AB18
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhLTONE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:13:04 -0500
Received: from mail-ua1-f48.google.com ([209.85.222.48]:33620 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhLTOND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:13:03 -0500
Received: by mail-ua1-f48.google.com with SMTP id a14so17997274uak.0;
        Mon, 20 Dec 2021 06:13:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qI2m0RuJx2HJ9/PBBEh4eurnObxLQchHY+T7nx9ViKc=;
        b=YtqSaOJWjKpdtqi1nbMl6JvU9MIBJjk4bb5oqYIaC+EJ9bZkZIVxi/hZGsoybu6hxr
         ufkh29dIa3R2s/MX1IuRroBwH6/SPoft1FYhem4BixzlTtDxVukf2milF7mkavySMP0G
         DjoRQDOqaNmCbTjyvoYzWZaCmPJfofRfeb9fan0OeCoNCfN0wZzXo7fJuDDoz19Ca83w
         AxgT9H1WnPYXSi4v+Qba8+Dgun+eALnOqWKOoADL6tzZPSqaNDQJCFGKVwKL3ATlRA0T
         nunFarF0R1yxksG5tN7bbZzsl5711R9AMih9F3NT9Xq88HieKUts8T32/BDD6fTcNdOh
         HYHg==
X-Gm-Message-State: AOAM531tfMK2//mrQ7xLtVTpZlnd6lJvYV8SQyxztRBq9poGSl41KKwP
        +2DzJxBXVBP7aFGH4e3FikAC36j2vCwtlQ==
X-Google-Smtp-Source: ABdhPJyRr92PJLwZzQ3nuH3AzmoyA4eQRjGR+og7zdX8nzSR1MOcetA1t5mTqROOImC583py0d4ruw==
X-Received: by 2002:a67:f1d8:: with SMTP id v24mr5215933vsm.8.1640009582261;
        Mon, 20 Dec 2021 06:13:02 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id k131sm2109132vka.30.2021.12.20.06.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 06:13:02 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id a14so17997157uak.0;
        Mon, 20 Dec 2021 06:13:01 -0800 (PST)
X-Received: by 2002:a9f:22ca:: with SMTP id 68mr4899782uan.78.1640009581604;
 Mon, 20 Dec 2021 06:13:01 -0800 (PST)
MIME-Version: 1.0
References: <20211219132442.4080-1-wsa+renesas@sang-engineering.com> <20211219132442.4080-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20211219132442.4080-2-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Dec 2021 15:12:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVh60ocfzkJKz8zR1hODr8SWp=sbyHrR3KGx2ntLmuFGQ@mail.gmail.com>
Message-ID: <CAMuHMdVh60ocfzkJKz8zR1hODr8SWp=sbyHrR3KGx2ntLmuFGQ@mail.gmail.com>
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

Hi Wolfram,

On Mon, Dec 20, 2021 at 10:07 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> This is a sloppy logic analyzer using GPIOs. It comes with a script to
> isolate a CPU for polling. While this is definitely not a production
> level analyzer, it can be a helpful first view when remote debugging.
> Read the documentation for details.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> --- /dev/null
> +++ b/tools/gpio/gpio-sloppy-logic-analyzer
> @@ -0,0 +1,221 @@
> +#!/bin/sh -eu
> +# Helper script for the Linux Kernel GPIO sloppy logic analyzer
> +#
> +# Copyright (C) Wolfram Sang <wsa@sang-engineering.com>
> +# Copyright (C) Renesas Electronics Corporation
> +#
> +# TODO: support SI units in command line parameters?
> +
> +samplefreq=1000000
> +numsamples=250000
> +cpusetdir='/dev/cpuset'
> +debugdir='/sys/kernel/debug'
> +ladirname='gpio-sloppy-logic-analyzer'
> +outputdir="$PWD"
> +neededcmds='taskset zip'
> +max_chans=8
> +duration=
> +initcpu=
> +lainstance=
> +lasysfsdir=
> +triggerdat=
> +trigger_bindat=
> +progname="${0##*/}"
> +print_help()
> +{
> +       cat << EOF
> +$progname - helper script for the Linux Kernel Sloppy GPIO Logic Analyzer
> +Available options:
> +       -c|--cpu <n>: which CPU to isolate for sampling. Only needed once. Default <1>.
> +                     Remember that a more powerful CPU gives you higher sampling speeds.
> +                     Also CPU0 is not recommended as it usually does extra bookkeeping.
> +       -d|--duration-us <n>: number of microseconds to sample. Overrides -n, no default value.
> +       -h|--help: print this help
> +       -i|--instance <str>: name of the logic analyzer in case you have multiple instances. Default
> +                            to first instance found
> +       -k|--kernel-debug-dir: path to the kernel debugfs mountpoint. Default: <$debugdir>
> +       -n|--num_samples <n>: number of samples to acquire. Default <$numsamples>
> +       -o|--output-dir <str>: directory to put the result files. Default: current dir
> +       -s|--sample_freq <n>: desired sampling frequency. Might be capped if too large. Default: 1MHz.
> +       -t|--trigger <str>: pattern to use as trigger. <str> consists of two-char pairs. First
> +                           char is channel number starting at "1". Second char is trigger level:
> +                           "L" - low; "H" - high; "R" - rising; "F" - falling
> +                           These pairs can be combined with "+", so "1H+2F" triggers when probe 1
> +                           is high while probe 2 has a falling edge. You can have multiple triggers
> +                           combined with ",". So, "1H+2F,1H+2R" is like the example before but it
> +                           waits for a rising edge on probe 2 while probe 1 is still high after the
> +                           first trigger has been met.
> +                           Trigger data will only be used for the next capture and then be erased.
> +Examples:
> +Samples $numsamples values at 1MHz with an already prepared CPU or automatically prepares CPU1 if needed,
> +use the first logic analyzer instance found:
> +       '$progname'
> +Samples 50us at 2MHz waiting for a falling edge on channel 2. CPU and instance as above:
> +       '$progname -d 50 -s 2000000 -t "2F"'
> +
> +Note that the process exits after checking all parameters but a sub-process still works in
> +the background. The result is only available once the sub-process finishes.
> +
> +Result is a .sr file to be consumed with PulseView from the free Sigrok project. It is
> +a zip file which also contains the binary sample data which may be consumed by others.
> +The filename is the logic analyzer instance name plus a since-epoch timestamp.
> +EOF
> +}
> +
> +fail()
> +{
> +       echo "$1"
> +       exit 1
> +}
> +
> +set_newmask()
> +{
> +       for f in $(find "$1" -iname "$2"); do echo "$newmask" > "$f" 2>/dev/null || true; done
> +}
> +
> +init_cpu()
> +{
> +       isol_cpu="$1"
> +       [ -d $cpusetdir ] || mkdir $cpusetdir
> +       mount | grep -q $cpusetdir || mount -t cpuset cpuset $cpusetdir

This needs CONFIG_CPUSETS=y, so you may want to document that.

> +       [ -d "$lacpusetdir" ] || mkdir "$lacpusetdir"
> +
> +       cur_cpu="$(cat "$lacpusetdir"/cpus)"

cat: /dev/cpuset/gpio-sloppy-logic-analyzer/cpus: No such file or directory

I do have a "cpuset.cpus" file.

> +       [ "$cur_cpu" = "$isol_cpu" ] && return
> +       [ -z "$cur_cpu" ] || fail "CPU$isol_cpu requested but CPU$cur_cpu already isolated"
> +
> +       echo "$isol_cpu" > "$lacpusetdir"/cpus || fail "Could not isolate CPU$isol_cpu. Does it exist?"
> +       echo 1 > "$lacpusetdir"/cpu_exclusive
> +       echo 0 > "$lacpusetdir"/mems

No complaint, although the real files have a "cpuset."-prefix again.

[...]

> +workcpu=$(cat "$lacpusetdir"/effective_cpus)

cat: /dev/cpuset/gpio-sloppy-logic-analyzer/effective_cpus: No such
file or directory

I do have a "cpuset.effective_cpus" file.

> +[ -n "$workcpu" ] || fail "No isolated CPU found"
> +cpumask=$(printf '%x' $((1 << workcpu)))
> +instance=${lasysfsdir##*/}
> +echo "Setting up '$instance': $numsamples samples at ${samplefreq}Hz with ${triggerdat:-no} trigger using CPU$workcpu"
> +do_capture "$cpumask" &

Anyone with a clue? Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
