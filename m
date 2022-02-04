Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327954A9EA5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377366AbiBDSIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:08:10 -0500
Received: from mail-yb1-f175.google.com ([209.85.219.175]:37841 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiBDSII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:08:08 -0500
Received: by mail-yb1-f175.google.com with SMTP id v190so4871265ybv.4;
        Fri, 04 Feb 2022 10:08:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzUcaIEImdF9ZfeiorQex0NTCKZ9P1s8gIbYQ0VJVoc=;
        b=NsZqPZL8uJuFdoMjcUUp4iJgY6/VrG5x9EE3Jkjvcuy8Hr/SCjQsudMRKQ7tfX/bvL
         eiX8D9u/QCN57l94RegmLWgz7JFWNtPuQ7DHyRl7y3hTQyod3YPTjyExBsFxUr2H4sXG
         pjqGUZl89ERsrmIpxu5Tan51y/TWLLYRjicW6W+57eLVMqPG8+l9uB0ZGgrpIYQSFyVq
         P63b4WpaxIfe0qXmyrWWsbf0n7mvdZSIasdwkGKTL93RmdTpDr9XAMEMi7fRS+OPoaN8
         8UG9GnGjkK1ApGgCqszVjBezMgbFZ/8q5QgMugon4Xv54IdyUgxYz2Id/uqN9ogU7CjJ
         IPnQ==
X-Gm-Message-State: AOAM532PW08/SXIk5T5YNv4EdTw/MR3Qu6lM5jK5XoNo49tGX6/M/1Fv
        3LtwBr+37Yk2exAiaibsn1/c4jhOz8wV64OfchQ=
X-Google-Smtp-Source: ABdhPJxAL91eBAqtrWjpV0BxhH1GVXsDA1TEJzQEsTef4kYwIT1aeMckqA8/Ilmt7L0QE7gNfF0p6VX5/dD3DWxtceU=
X-Received: by 2002:a25:7e81:: with SMTP id z123mr359595ybc.466.1643998088291;
 Fri, 04 Feb 2022 10:08:08 -0800 (PST)
MIME-Version: 1.0
References: <20220111155419.943980-1-Pierre.Gondois@arm.com>
In-Reply-To: <20220111155419.943980-1-Pierre.Gondois@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Feb 2022 19:07:57 +0100
Message-ID: <CAJZ5v0hqzsoANFVPJXqYM6ZL4Ad6rDh=+G0qKmnmKLtyvADwmg@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: CPPC: Fix performance/frequency conversion
To:     Pierre Gondois <Pierre.Gondois@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 4:54 PM Pierre Gondois <Pierre.Gondois@arm.com> wrote:
>
> CPUfreq governors request CPU frequencies using information
> on current CPU usage. The CPPC driver converts them to
> performance requests. Frequency targets are computed as:
>         target_freq = (util / cpu_capacity) * max_freq
> target_freq is then clamped between [policy->min, policy->max].
>
> The CPPC driver converts performance values to frequencies
> (and vice-versa) using cppc_cpufreq_perf_to_khz() and
> cppc_cpufreq_khz_to_perf(). These functions both use two different
> factors depending on the range of the input value. For
> cppc_cpufreq_khz_to_perf():
> - (NOMINAL_PERF / NOMINAL_FREQ) or
> - (LOWEST_PERF / LOWEST_FREQ)
> and for cppc_cpufreq_perf_to_khz():
> - (NOMINAL_FREQ / NOMINAL_PERF) or
> - ((NOMINAL_PERF - LOWEST_FREQ) / (NOMINAL_PERF - LOWEST_PERF))
>
> This means:
> 1- the functions are not inverse for some values:
>    (perf_to_khz(khz_to_perf(x)) != x)
> 2- cppc_cpufreq_perf_to_khz(LOWEST_PERF) can sometimes give
>    a different value from LOWEST_FREQ due to integer approximation
> 3- it is implied that performance and frequency are proportional
>    (NOMINAL_FREQ / NOMINAL_PERF) == (LOWEST_PERF / LOWEST_FREQ)
>
> This patch changes the conversion functions to an affine function.
> This fixes the 3 points above.
>
> Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
> Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 43 +++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index db17196266e4..5024d9af2e6e 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -303,52 +303,48 @@ static u64 cppc_get_dmi_max_khz(void)
>
>  /*
>   * If CPPC lowest_freq and nominal_freq registers are exposed then we can
> - * use them to convert perf to freq and vice versa
> - *
> - * If the perf/freq point lies between Nominal and Lowest, we can treat
> - * (Low perf, Low freq) and (Nom Perf, Nom freq) as 2D co-ordinates of a line
> - * and extrapolate the rest
> - * For perf/freq > Nominal, we use the ratio perf:freq at Nominal for conversion
> + * use them to convert perf to freq and vice versa. The conversion is
> + * extrapolated as an affine function passing by the 2 points:
> + *  - (Low perf, Low freq)
> + *  - (Nominal perf, Nominal perf)
>   */
>  static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu_data,
>                                              unsigned int perf)
>  {
>         struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> +       s64 retval, offset = 0;
>         static u64 max_khz;
>         u64 mul, div;
>
>         if (caps->lowest_freq && caps->nominal_freq) {
> -               if (perf >= caps->nominal_perf) {
> -                       mul = caps->nominal_freq;
> -                       div = caps->nominal_perf;
> -               } else {
> -                       mul = caps->nominal_freq - caps->lowest_freq;
> -                       div = caps->nominal_perf - caps->lowest_perf;
> -               }
> +               mul = caps->nominal_freq - caps->lowest_freq;
> +               div = caps->nominal_perf - caps->lowest_perf;
> +               offset = caps->nominal_freq - (u64)caps->nominal_perf * mul / div;

Since mult is a u64, the other operands need not be cast to u64
explicitly AFAICS.

Moreover, it might be better to use div64_u64() instead of the plain
integer division.

>         } else {
>                 if (!max_khz)
>                         max_khz = cppc_get_dmi_max_khz();
>                 mul = max_khz;
>                 div = caps->highest_perf;
>         }
> -       return (u64)perf * mul / div;
> +
> +       retval = offset + (u64)perf * mul / div;
> +       if (retval >= 0)
> +               return retval;
> +       return 0;
>  }
>
>  static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu_data,
>                                              unsigned int freq)
>  {
>         struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> +       s64 retval, offset = 0;
>         static u64 max_khz;
>         u64  mul, div;
>
>         if (caps->lowest_freq && caps->nominal_freq) {
> -               if (freq >= caps->nominal_freq) {
> -                       mul = caps->nominal_perf;
> -                       div = caps->nominal_freq;
> -               } else {
> -                       mul = caps->lowest_perf;
> -                       div = caps->lowest_freq;
> -               }
> +               mul = caps->nominal_perf - caps->lowest_perf;
> +               div = caps->nominal_freq - caps->lowest_freq;
> +               offset = caps->nominal_perf - (u64)caps->nominal_freq * mul / div;
>         } else {
>                 if (!max_khz)
>                         max_khz = cppc_get_dmi_max_khz();
> @@ -356,7 +352,10 @@ static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu_data,
>                 div = max_khz;
>         }
>
> -       return (u64)freq * mul / div;
> +       retval = offset + (u64)freq * mul / div;
> +       if (retval >= 0)
> +               return retval;
> +       return 0;
>  }
>
>  static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
> --
> 2.25.1
>
