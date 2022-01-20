Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48E5494D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiATLkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:40:52 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58330 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiATLkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:40:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5BE35CE205C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 11:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD26AC340E7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 11:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642678843;
        bh=6LnIdV6RHDt7o1vEGoXG3R/w1FEA0NaGl+qjDdBHh6A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nyCfojrhHas7JIC/VhRk8yNQls+07YqG83l+vY87JiuDfY+2xgjf2/IZyjzmQ3mq9
         rZwHMVDmt1oXH65iswpk74VRHRpBR04plymjoOxh2bYN1rPxVN93oV797VTf0h13Nf
         Z5rYloMvl4/Mwc0OGBAaggrm+er7G0k5GXugAYN5yo6J4lFoZkRHr4gsQ7slXfm9o1
         W20hWwyWv1pwBl5b51eMHZPOKOELdIdag8Dq6+kFP+ypug/iVpp3JVqYG6v4mrMrXG
         tdYAb35NrlAkXKRlgAJWAmFxxvdls2h4omxsN00m3HwnrcMeyaaG8+/4keRVHGd82p
         fR/eKidaJlzDQ==
Received: by mail-lf1-f46.google.com with SMTP id d3so20430301lfv.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:40:43 -0800 (PST)
X-Gm-Message-State: AOAM531x2Otk2x1+guE1oTnldVlvuOBVsG+r056DUUneY6uU76xJykNl
        Y8g16TC4GsocvknIXwvP7d2GfIOJkYsGHnIqRP8vvg==
X-Google-Smtp-Source: ABdhPJyqvGdAQDASGi3+qeicpoixSod0DA9RvTNoKMV7lu0kBXWGFZ2SPaJSvDutVU0pqtnFC+GVeFiuVBMM+3BFhjY=
X-Received: by 2002:a2e:8799:: with SMTP id n25mr5195536lji.255.1642678841839;
 Thu, 20 Jan 2022 03:40:41 -0800 (PST)
MIME-Version: 1.0
References: <20220114031730.25621-1-benl@squareup.com>
In-Reply-To: <20220114031730.25621-1-benl@squareup.com>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Thu, 20 Jan 2022 17:10:30 +0530
X-Gmail-Original-Message-ID: <CAHLCerNYXxrW=K6hQ38mXd+3V-u=5_NFXKBoaOx+yUaYW5Zu7A@mail.gmail.com>
Message-ID: <CAHLCerNYXxrW=K6hQ38mXd+3V-u=5_NFXKBoaOx+yUaYW5Zu7A@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: thermal: tsens: respect thermal_device_mode
 in threshold irq reporting
To:     Benjamin Li <benl@squareup.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 8:47 AM Benjamin Li <benl@squareup.com> wrote:
>
> 'echo disabled > .../thermal_zoneX/mode' will disable the thermal core's
> polling mechanism to check for threshold trips. This is used sometimes to
> run performance test cases.
>
> However, tsens supports an interrupt mechanism to receive notification of
> trips, implemented in commit 634e11d5b450 ("drivers: thermal: tsens: Add
> interrupt support").
>
> Currently the thermal zone mode that's set by userspace is not checked
> before propagating threshold trip events from IRQs. Let's fix this to
> restore the abilty to disable thermal throttling at runtime.
>
> ====================
>
> Tested on MSM8939 running 5.16.0. This platform has 8 cores; the first
> four thermal zones control cpu0-3 and the last zone is for the other four
> CPUs together.
>
>   for f in /sys/class/thermal/thermal_zone*; do
>     echo "disabled" > $f/mode
>     echo $f | paste - $f/type $f/mode
>   done
>
> /sys/class/thermal/thermal_zone0        cpu0-thermal    disabled
> /sys/class/thermal/thermal_zone1        cpu1-thermal    disabled
> /sys/class/thermal/thermal_zone2        cpu2-thermal    disabled
> /sys/class/thermal/thermal_zone3        cpu3-thermal    disabled
> /sys/class/thermal/thermal_zone4        cpu4567-thermal disabled
>
> With mitigation thresholds at 75 degC and load running, we can now cruise
> past temp=75000 without CPU throttling kicking in.
>
>   watch -n 1 "grep '' /sys/class/thermal/*/temp
>       /sys/class/thermal/*/cur_state
>       /sys/bus/cpu/devices/cpu*/cpufreq/cpuinfo_cur_freq"
>
> /sys/class/thermal/thermal_zone0/temp:82000
> /sys/class/thermal/thermal_zone1/temp:84000
> /sys/class/thermal/thermal_zone2/temp:87000
> /sys/class/thermal/thermal_zone3/temp:84000
> /sys/class/thermal/thermal_zone4/temp:84000
> /sys/class/thermal/cooling_device0/cur_state:0
> /sys/class/thermal/cooling_device1/cur_state:0
> /sys/bus/cpu/devices/cpu0/cpufreq/cpuinfo_cur_freq:1113600
> /sys/bus/cpu/devices/cpu1/cpufreq/cpuinfo_cur_freq:1113600
> /sys/bus/cpu/devices/cpu2/cpufreq/cpuinfo_cur_freq:1113600
> /sys/bus/cpu/devices/cpu3/cpufreq/cpuinfo_cur_freq:1113600
> /sys/bus/cpu/devices/cpu4/cpufreq/cpuinfo_cur_freq:800000
> /sys/bus/cpu/devices/cpu5/cpufreq/cpuinfo_cur_freq:800000
> /sys/bus/cpu/devices/cpu6/cpufreq/cpuinfo_cur_freq:800000
> /sys/bus/cpu/devices/cpu7/cpufreq/cpuinfo_cur_freq:800000
>
> Reported-by: Zac Crosby <zac@squareup.com>
> Signed-off-by: Benjamin Li <benl@squareup.com>
> ---
> Changes in v2:
> - Reordered sentences in first part of commit message to make sense.
>
>  drivers/thermal/qcom/tsens.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 99a8d9f3e03c..0b6299512e7c 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -509,13 +509,16 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
>                 spin_unlock_irqrestore(&priv->ul_lock, flags);
>
>                 if (trigger) {
> -                       dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
> -                               hw_id, __func__, temp);
> -                       thermal_zone_device_update(s->tzd,
> -                                                  THERMAL_EVENT_UNSPECIFIED);
> +                       if (s->tzd->mode == THERMAL_DEVICE_ENABLED) {
> +                               dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
> +                                       hw_id, __func__, temp);
> +                               thermal_zone_device_update(s->tzd, THERMAL_EVENT_UNSPECIFIED);
> +                       } else {
> +                               dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC) skipped as zone disabled\n",

Hmm. I don't like the fact that these messages won't be visible to
users in dmesg unless they're debugging. This change puts the SoC in a
potentially unsafe state. Perhaps we should print a ratelimited
message in the logs that we're operating outside safety limits?

> +                                       hw_id, __func__, temp);
> +                       }
>                 } else {
> -                       dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
> -                               hw_id, __func__, temp);
> +                       dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n", hw_id, __func__, temp);

Get rid of this hunk, it is unrelated to the above change.

>                 }
>
>                 if (tsens_version(priv) < VER_0_1) {
> --
> 2.17.1
>
