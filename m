Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BEF48CC92
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350159AbiALT4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:56:35 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:34468 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357611AbiALTx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:53:29 -0500
Received: by mail-qt1-f171.google.com with SMTP id y10so4348895qtw.1;
        Wed, 12 Jan 2022 11:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJL3a71hY/nIwYviaKdD0vj8/3ycQ9lxEe2C9EyccVc=;
        b=Ylar9exRu551mNaY4W3Sd7U7Xnfjid77R5n4mEK6GFThYSaSpvcd6YcK1Hg4DhNhqG
         FBXbN3xrKet2j56S20N6TmRp5m+0Xq00ATCnbvsO5pwerIYvG/S/pfLdq5Jff4SCz3sF
         GIwRpEYYdU31LisB3NxeJJVHvLD7QOQ93v2u4GI+MLw9bytd0pUOJnN/aNLrnIyYmLCy
         jojCS0y2uLv49ZmXDbxBdH9F2Kas0xDfoRY9HoZyHwAw+3s09vxH7TDKWeULWGVMUPCm
         Y1zs2zzwa/yx+nnMXAWafpvuvCSpFGPdF78LsIP+mhohTxWLhtpC+d2uk/FBNPqtlu3X
         YWZA==
X-Gm-Message-State: AOAM533jjgF531SdJnb+YOElh71qX+OWLLWTl+9RB/Io5X2MHsYfs0FP
        mEp1VkwBoBKuMvHyzfYRVcL7YPr4SGttwxQmt38=
X-Google-Smtp-Source: ABdhPJx5zwgQ74maWpzMxiGzXPIhbW5qJVbcYv7mpeVaPuWtmbIFVDwd5M/M7e3UNzJ3LorIJTmXP4RiV5qtZHbcGAM=
X-Received: by 2002:ac8:5795:: with SMTP id v21mr1007664qta.472.1642017206293;
 Wed, 12 Jan 2022 11:53:26 -0800 (PST)
MIME-Version: 1.0
References: <20220108034743.31277-1-ricardo.neri-calderon@linux.intel.com> <20220108034743.31277-8-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20220108034743.31277-8-ricardo.neri-calderon@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Jan 2022 20:53:15 +0100
Message-ID: <CAJZ5v0h5-xsYCfs=c+wE4tWrcmvkdbgrc+fnwytSghwuAWnu0A@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] thermal: intel: hfi: Notify user space for HFI events
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 8, 2022 at 4:46 AM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>
> When the hardware issues an HFI event, relay a notification to user space.
> This allows user space to respond by reading performance and efficiency of
> each CPU and take appropriate action.
>
> For example, when performance and efficiency of a CPU is 0, user space can
> either offline the CPU or inject idle. Also, if user space notices a
> downward trend in performance, it may proactively adjust power limits to
> avoid future situations in which performance drops to 0.
>
> To avoid excessive notifications, the rate is limited by one HZ per event.
> To limit the netlink message size, parameters for only 16 CPUs at max are
> sent in one message. If there are more than 16 CPUs, issue as many messages
> as needed to notify the status of all CPUs.
>
> In the HFI specification, both performance and efficiency capabilities are
> set in the [0, 255] range. The existing implementations of HFI hardware
> do not scale the maximum values to 255. Since userspace cares about
> capability values that are either 0 or show a downward/upward trend, this
> fact does not matter much. Relative changes in capabilities are enough. To
> comply with the thermal netlink ABI, scale both performance and efficiency
> capabilities to the [0, 1023] interval.
>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> Changes since v3:
>   * None
>
> Changes since v2:
>   * None
>
> Changes since v1:
>   * Made get_one_hfi_cap() return void. Removed unnecessary checks.
>     (Rafael)
>   * Replaced raw_spin_[un]lock_irq[restore|save]() with raw_spin_
>     [un]lock_irq() in get_one_hfi_cap(). This function is only called from
>     a workqueue and there is no need to save and restore irq flags.
>   * Scaled performance and energy efficiency values to a [0, 1023] interval
>     when reporting values to user space via thermal netlink notifications.
>     (Lucasz).
>   * Reworded commit message to comment on the scaling of HFI capabilities
>     to comply with the proposed thermal netlink ABI.
> ---
>  drivers/thermal/intel/Kconfig     |  1 +
>  drivers/thermal/intel/intel_hfi.c | 57 ++++++++++++++++++++++++++++++-
>  2 files changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
> index e9d2925227d4..6cf3fe36a4ae 100644
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -104,6 +104,7 @@ config INTEL_HFI_THERMAL
>         bool "Intel Hardware Feedback Interface"
>         depends on CPU_SUP_INTEL
>         depends on X86_THERMAL_VECTOR
> +       select THERMAL_NETLINK
>         help
>           Select this option to enable the Hardware Feedback Interface. If
>           selected, hardware provides guidance to the operating system on
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index 1a08c58f26f6..9fd66f176948 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -40,6 +40,7 @@
>
>  #include <asm/msr.h>
>
> +#include "../thermal_core.h"
>  #include "intel_hfi.h"
>
>  #define THERM_STATUS_CLEAR_PKG_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | \
> @@ -162,6 +163,60 @@ static struct hfi_features hfi_features;
>  static DEFINE_MUTEX(hfi_instance_lock);
>
>  #define HFI_UPDATE_INTERVAL    HZ
> +#define HFI_MAX_THERM_NOTIFY_COUNT     16
> +
> +static void get_one_hfi_cap(struct hfi_instance *hfi_instance, s16 index,
> +                           struct hfi_cpu_data *hfi_caps)
> +{
> +       struct hfi_cpu_data *caps;
> +
> +       /* Find the capabilities of @cpu */
> +       raw_spin_lock_irq(&hfi_instance->table_lock);
> +       caps = hfi_instance->data + index * hfi_features.cpu_stride;
> +       memcpy(hfi_caps, caps, sizeof(*hfi_caps));
> +       raw_spin_unlock_irq(&hfi_instance->table_lock);
> +}
> +
> +/*
> + * Call update_capabilities() when there are changes in the HFI table.
> + */
> +static void update_capabilities(struct hfi_instance *hfi_instance)
> +{
> +       struct cpu_capability cpu_caps[HFI_MAX_THERM_NOTIFY_COUNT];
> +       int i = 0, cpu;
> +

Wouldn't it be better to hold hfi_instance_lock for the duration of this loop?

Surely, CPU offline or online during it can be confusing.

> +       for_each_cpu(cpu, hfi_instance->cpus) {
> +               struct hfi_cpu_data caps;
> +               s16 index;
> +
> +               /*
> +                * We know index is valid because this CPU is present
> +                * in this instance.
> +                */
> +               index = per_cpu(hfi_cpu_info, cpu).index;
> +
> +               get_one_hfi_cap(hfi_instance, index, &caps);
> +
> +               cpu_caps[i].cpu = cpu;
> +
> +               /*
> +                * Scale performance and energy efficiency to
> +                * the [0, 1023] interval that thermal netlink uses.
> +                */
> +               cpu_caps[i].performance = caps.perf_cap << 2;
> +               cpu_caps[i].efficiency = caps.ee_cap << 2;
> +               ++i;
> +
> +               if (i >= HFI_MAX_THERM_NOTIFY_COUNT) {
> +                       thermal_genl_cpu_capability_event(HFI_MAX_THERM_NOTIFY_COUNT,
> +                                                         cpu_caps);
> +                       i = 0;
> +               }
> +       }
> +
> +       if (i)
> +               thermal_genl_cpu_capability_event(i, cpu_caps);
> +}
>
>  static void hfi_update_work_fn(struct work_struct *work)
>  {
> @@ -172,7 +227,7 @@ static void hfi_update_work_fn(struct work_struct *work)
>         if (!hfi_instance)
>                 return;
>
> -       /* TODO: Consume update here. */
> +       update_capabilities(hfi_instance);
>  }
>
>  void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
> --
> 2.17.1
>
