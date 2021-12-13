Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D8F4727E8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbhLMKFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:05:49 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:35526 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240395AbhLMKBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:01:09 -0500
Received: by mail-ot1-f44.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso16885064otr.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 02:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XeBMiuDdEV6Ne7aU6TPbb3k+NoeyXfYTUvJrW81TPQE=;
        b=CiI19V6pHxGRsG/VGZ0leBQ+9b2JJlOP5pVKWqgi/bzz7cbzlTLiosDnhnQiqxY4ng
         JiPo2Awl5Tj3apo0xdGdg1RLkX9vnP+1aMv0P+ce3iwQorEHC5AxoX1AJBZFr+nU+N+Y
         S4X7ORcv1xCNDRJB7NVzVR9h3fL8UuZduGrzYVUObMd2SOAE+GaWB0BSeV0M5uWKu7rp
         wzXaAJze+owHXEjTNCPAPFO5qR4948CtRAYIQvdOVH1IvJzB5jKhI72NDDfipS3AvfIL
         Hffsg7Fc2hg/proqF29hc9PTLsphAnXUkSlNwS7iATuTmk18Wcm8aS0nTiDvLA5fA9cO
         O5qA==
X-Gm-Message-State: AOAM533dC5JjHO3Cu/6q3mYqDllEEe8hXor4CwOgjR28xMqmOdP+Goox
        vzl4L00LFUEIGOLCeeryKsQLhBX/M+oS/BRHHJY=
X-Google-Smtp-Source: ABdhPJw/xWBZHNyXQEkpfirFVAdJz/pnZ6bqZbBigO7Uzma7RKqwr/vlINyJ34STv6jBDdc3AC4qewM9tEiCM5PhuJc=
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr24537577otf.198.1639389668140;
 Mon, 13 Dec 2021 02:01:08 -0800 (PST)
MIME-Version: 1.0
References: <20211211163327.3093169-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20211211163327.3093169-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Dec 2021 11:00:56 +0100
Message-ID: <CAJZ5v0idd=Ey=pDyDgyBZz=SqrPvBkT1SvK30wbVy5myKAR1pg@mail.gmail.com>
Subject: Re: [PATCH] x86: intel_epb: Allow model specific normal EPB value
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 5:33 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> The current EPB "normal" is defined as 6 and set whenever power-up EPB
> value is 0. This setting resulted in the desired out of box power and
> performance for several CPU generations. But this value is not suitable
> for AlderLake mobile CPUs, as this resulted in higher uncore power.
> Since EPB is model specific, this is not unreasonable to have different
> behavior.
>
> Allow a capability where "normal" EPB can be redefined. For AlderLake
> mobile CPUs this desired normal value is 7.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/cpu/intel_epb.c | 45 +++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
> index f4dd73396f28..fbaf12e43f41 100644
> --- a/arch/x86/kernel/cpu/intel_epb.c
> +++ b/arch/x86/kernel/cpu/intel_epb.c
> @@ -16,6 +16,7 @@
>  #include <linux/syscore_ops.h>
>  #include <linux/pm.h>
>
> +#include <asm/cpu_device_id.h>
>  #include <asm/cpufeature.h>
>  #include <asm/msr.h>
>
> @@ -58,6 +59,22 @@ static DEFINE_PER_CPU(u8, saved_epb);
>  #define EPB_SAVED      0x10ULL
>  #define MAX_EPB                EPB_MASK
>
> +enum energy_perf_value_index {
> +       EPB_INDEX_PERFORMANCE,
> +       EPB_INDEX_BALANCE_PERFORMANCE,
> +       EPB_INDEX_NORMAL,
> +       EPB_INDEX_BALANCE_POWERSAVE,
> +       EPB_INDEX_POWERSAVE,
> +};
> +
> +static u8 energ_perf_values[] = {
> +       [EPB_INDEX_PERFORMANCE] = ENERGY_PERF_BIAS_PERFORMANCE,
> +       [EPB_INDEX_BALANCE_PERFORMANCE] = ENERGY_PERF_BIAS_BALANCE_PERFORMANCE,
> +       [EPB_INDEX_NORMAL] = ENERGY_PERF_BIAS_NORMAL,
> +       [EPB_INDEX_BALANCE_POWERSAVE] = ENERGY_PERF_BIAS_BALANCE_POWERSAVE,
> +       [EPB_INDEX_POWERSAVE] = ENERGY_PERF_BIAS_POWERSAVE,
> +};
> +
>  static int intel_epb_save(void)
>  {
>         u64 epb;
> @@ -90,7 +107,7 @@ static void intel_epb_restore(void)
>                  */
>                 val = epb & EPB_MASK;
>                 if (val == ENERGY_PERF_BIAS_PERFORMANCE) {
> -                       val = ENERGY_PERF_BIAS_NORMAL;
> +                       val = energ_perf_values[EPB_INDEX_NORMAL];
>                         pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
>                 }
>         }
> @@ -103,18 +120,11 @@ static struct syscore_ops intel_epb_syscore_ops = {
>  };
>
>  static const char * const energy_perf_strings[] = {
> -       "performance",
> -       "balance-performance",
> -       "normal",
> -       "balance-power",
> -       "power"
> -};
> -static const u8 energ_perf_values[] = {
> -       ENERGY_PERF_BIAS_PERFORMANCE,
> -       ENERGY_PERF_BIAS_BALANCE_PERFORMANCE,
> -       ENERGY_PERF_BIAS_NORMAL,
> -       ENERGY_PERF_BIAS_BALANCE_POWERSAVE,
> -       ENERGY_PERF_BIAS_POWERSAVE
> +       [EPB_INDEX_PERFORMANCE] = "performance",
> +       [EPB_INDEX_BALANCE_PERFORMANCE] = "balance-performance",
> +       [EPB_INDEX_NORMAL] = "normal",
> +       [EPB_INDEX_BALANCE_POWERSAVE] = "balance-power",
> +       [EPB_INDEX_POWERSAVE] = "power",
>  };
>
>  static ssize_t energy_perf_bias_show(struct device *dev,
> @@ -193,13 +203,22 @@ static int intel_epb_offline(unsigned int cpu)
>         return 0;
>  }
>
> +static const struct x86_cpu_id intel_epb_normal[] = {
> +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, 7),
> +       {}
> +};
> +
>  static __init int intel_epb_init(void)
>  {
> +       const struct x86_cpu_id *id = x86_match_cpu(intel_epb_normal);
>         int ret;
>
>         if (!boot_cpu_has(X86_FEATURE_EPB))
>                 return -ENODEV;
>
> +       if (id)
> +               energ_perf_values[EPB_INDEX_NORMAL] = id->driver_data;
> +
>         ret = cpuhp_setup_state(CPUHP_AP_X86_INTEL_EPB_ONLINE,
>                                 "x86/intel/epb:online", intel_epb_online,
>                                 intel_epb_offline);
> --
> 2.31.1
>
