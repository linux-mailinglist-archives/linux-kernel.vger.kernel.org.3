Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1584E4A373B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 16:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355429AbiA3PXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 10:23:16 -0500
Received: from mail-yb1-f175.google.com ([209.85.219.175]:34537 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355421AbiA3PXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 10:23:14 -0500
Received: by mail-yb1-f175.google.com with SMTP id v186so33170232ybg.1;
        Sun, 30 Jan 2022 07:23:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DnaGa9i2/yIHISXAioqft9HOSE9O/Wi5g9EfNGqVIvQ=;
        b=xZ0bs5tB0Ls0Z4Pzf0qU51RUDw3Qkbm+PnVZdxVuAivKtwyHL8VJFfeL3AAVGaW1oo
         FLJ+NBo/VmZHnsGVKyentWpdQQMmaqU3gP6b87dLAd1cvWfBR3c149LDyGRF1XdTLlt0
         nUVj3908uHaESTfQJgUQ7U62IG4zBtgQZYV8f37CHzo4wjbBNKzrAgaQ8BmvMIq8ao2h
         djNExZMbvvi3lDQ9HhFnlpzGgHmCO8JNHs7rwQViTBAQzmFagJWNETQyxKRmzq6q/5EH
         S+2hkxl3wyxBJY27LGMbR3QugLCMjr9fyHim03rdRZxzTVbpMBRKvEjm/E4PfLJuZ14B
         bmGw==
X-Gm-Message-State: AOAM5311em6HY4dNB2WyFcMIclmqsGahFi5ghtcdB2MPjBqGvQIhgfKm
        scuBhtrwdiL/Q4oYDcRYX+/7EjK6ukRLX9g7yuE=
X-Google-Smtp-Source: ABdhPJxmxan+KUOGEZoo1TI2DjjpSddqkIhdH4H8VP41kvwb8gci9GcdbLTs0OtgdEyvUv7O73o6JRQ/9p8uxtjsRVc=
X-Received: by 2002:a25:2fca:: with SMTP id v193mr25873075ybv.475.1643556193485;
 Sun, 30 Jan 2022 07:23:13 -0800 (PST)
MIME-Version: 1.0
References: <20220127193454.12814-1-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20220127193454.12814-1-ricardo.neri-calderon@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 30 Jan 2022 16:23:02 +0100
Message-ID: <CAJZ5v0gcK10TiVbc8+j1pVN+T2p3EZHEK9Ga2=2ZxeGd=iVkhw@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Thermal: Introduce the Hardware Feedback Interface
 for thermal and performance management
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

On Thu, Jan 27, 2022 at 8:33 PM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> Hi,
>
> This is v5 of this patchset after having incorporated the feedback from
> reviewers. Please find v1, v2, v3, and v4 in [1], [2], [3], and [4],
> respectively.
>
> The Intel Hardware Feedback Interface (HFI) [5] provides information about
> the performance and energy efficiency of each CPU in the system. It uses a
> table that is shared between hardware and the operating system. The
> contents of the table may be updated as a result of changes in the
> operating conditions of the system (e.g., reaching a thermal limit) or the
> action of external factors (e.g., changes in the thermal design power).
>
> The information that HFI provides are specified as numeric, unit-less
> capabilities relative to other CPUs in the system. These capabilities have
> a range of [0-255] where higher numbers represent higher capabilities.
> Energy efficiency and performance are reported in separate capabilities.
> If either the performance or energy capabilities efficiency of a CPU are 0,
> the hardware recommends to not schedule any tasks on such CPU for
> performance, energy efficiency or thermal reasons, respectively.
>
> The kernel or user space may use the information from the HFI to modify
> task placement and/or adjust power limits. This patchset focuses on the
> user space. The thermal notification framework is extended to relay
> updates of CPU capacity. Thus, a userspace daemon can affinitize workloads
> to certain CPUs and/or offline CPUs whose capabilities are zero.
>
> The frequency of HFI updates is specific to each processor model. On some
> systems, there is just a single HFI update at boot. On other systems, there
> may be updates every tens of milliseconds. In order to not overwhelm
> userspace with too many updates, they are limited to one update every
> CONFIG_HZ jiffies.
>
> Thanks and BR,
> Ricardo
>
> [1]. https://lore.kernel.org/lkml/20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com/
> [2]. https://lore.kernel.org/lkml/20211220151438.1196-1-ricardo.neri-calderon@linux.intel.com/
> [3]. https://lore.kernel.org/lkml/20220106025059.25847-8-ricardo.neri-calderon@linux.intel.com/
> [4]. https://lore.kernel.org/lkml/20220108034743.31277-1-ricardo.neri-calderon@linux.intel.com/
> [5]. https://www.intel.com/sdm
>
> Changes since v4:
>  ++ Unchanged patches: 1, 2.
>  * Reworded description hfi_instance::hdr and hfi_instance::data.
>    (Patch 3; Srinivas)
>  * Call intel_hfi_online() before enabling the thermal vector at the
>    local APIC is enabled. This makes sure that a CPU has an associated
>    HFI instance when an HFI event happens. Reworded the commit message to
>    reflect this change. (Patch 4; Srinivas)
>  * Set hfi_instances to NULL if we fail to allocate memory for
>    hfi_instance::cpus. (Patch 4; Srinivas)
>  * Delayed initialization of local variables until after the check for a
>    non-NULL hfi_instances in intel_hfi_online(). (Patch 4; Srinivas)
>  * Optimized the error path in init_hfi_init() to not needlessly
>    free the memory of cpumasks that have not been allocated. (Patch 4;
>    Srinivas)
>  * Removed pointless checks for X86_FEATURE_HFI in
>    intel_hfi_[on|off]line(). It is sufficient to check for a non-NULL
>    hfi_instances or a CPU's hfi_instance. (Patch 4)
>  * Added a dedicated (i.e., not system_wq) workqueue to process HFI updates.
>    Reworded commit message accordingly. (Patch 5; Rafael)
>  * Repurposed comment on possibly receiving an HFI event with a NULL
>    hfi_cpu_info::instance. Patch 4 fixed this potential issue. Instead,
>    add a debug statement. (Patch 5; Srinivas)
>  * Wrapped check for NULL hfi_cpu_info::instance in the unlikely macro.
>    (Patch 5; Srinivas)
>  * Renamed struct cpu_capability as struct thermal_genl_cpu_caps.
>    (Patch 6; Rafael)
>  * Removed automatic variable ret from
>    thermal_genl_event_cpu_capability_change() and instead always return
>    -EMSGSIZE on error. (Patch 6; Rafael)
>  * Reworked parsing of HFI capabilities into chunks of
>    HFI_MAX_THERM_NOTIFY_COUNT CPUs at a time to reduce the time
>    we spend with interrupts disabled. (Patch7; Srinivas)
>  * Protected hfi_instance::cpus when iterating over them. (Patch 7;
>    Rafael)

All patches in the series look good to me now, so I will be queuing it
up for 5.18 unless there are any objections or concerns.

Thanks!
