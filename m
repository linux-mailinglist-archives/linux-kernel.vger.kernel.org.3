Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6063481F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 19:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbhL3Sng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 13:43:36 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:41651 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbhL3Sne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 13:43:34 -0500
Received: by mail-qt1-f177.google.com with SMTP id v22so22421181qtx.8;
        Thu, 30 Dec 2021 10:43:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZgJKNR+mlHxxn85M9qhfcIgprdRDVkipREIlRLErdq0=;
        b=sC+g7+nukGhssMSyodWz8FL6BT4JjVzE/B9YlRgL/2WbC612lObNNN1SxPF31u2YGn
         Ga0+Bi3DCh20AmquXaK+p6lOIiycgKEqIEPD6AczOLl9GGpkz6QXwkRzV1H+eStM+SEC
         DQ8ZxrO+DO7vlCQXnXUPkRidSkcAtikKfUA5xVkkEqWHpum9TG/IbOY6y7jdXPUoW/oO
         PYe3yvAU9B3jGd53K1fwtig8x3gzwo0oxtbjbkCkjHbJED+Q8yX/AxzbPTnhBxN26JEl
         pT9lLDA1pqT/qBCmnMqcRIGgcK++4Opsh0SgGiUv36nxpaF46+nkZHbQjju+VU84VNus
         TL8w==
X-Gm-Message-State: AOAM531ASuocE0y7g55CFia8894J9RZZ3YTIrhUAfPlo3r669Xkweiqr
        JMoGsHcXO0B5UtE+Ki/AZjgUMci20zTLbapeKUo=
X-Google-Smtp-Source: ABdhPJwOzWG3w+ovnmBiOFolF9Lyj0D7tOKBjwwglyV6mcpKTC4/mxWM/EGJzA8gUqKU5LrXBy8YjomjER0Kio0hioo=
X-Received: by 2002:ac8:46cc:: with SMTP id h12mr27864091qto.417.1640889813400;
 Thu, 30 Dec 2021 10:43:33 -0800 (PST)
MIME-Version: 1.0
References: <20211220151438.1196-1-ricardo.neri-calderon@linux.intel.com> <20211220151438.1196-4-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20211220151438.1196-4-ricardo.neri-calderon@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Dec 2021 19:43:22 +0100
Message-ID: <CAJZ5v0hQUMBw-0t0QzvCfOvzp0WEhE64xiU1JX2jkzdG5BJrMg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] thermal: intel: hfi: Minimally initialize the
 Hardware Feedback Interface
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

On Mon, Dec 20, 2021 at 4:23 PM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> The Intel Hardware Feedback Interface provides guidance to the operating
> system about the performance and energy efficiency capabilities of each
> CPU in the system. Capabilities are numbers between 0 and 255 where a
> higher number represents a higher capability. For each CPU, energy
> efficiency and performance are reported as separate capabilities.
>
> Hardware computes these capabilities based on the operating conditions of
> the system such as power and thermal limits. These capabilities are shared
> with the operating system in a table resident in memory. Each package in
> the system has its own HFI instance. Every logical CPU in the package is
> represented in the table. More than one logical CPUs may be represented in
> a single table entry. When the hardware updates the table, it generates a
> package-level thermal interrupt.
>
> The size and format of the HFI table depend on the supported features and
> can only be determined at runtime. To minimally initialize the HFI, parse
> its features and allocate one instance per package of a data structure with
> the necessary parameters to read and navigate a local copy (i.e., owned by
> the driver) of individual HFI tables.
>
> A subsequent changeset will provide per-CPU initialization and interrupt
> handling.
>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Co-developed by: Aubrey Li <aubrey.li@linux.intel.com>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v1:
>   * Renamed X86_FEATURE_INTEL_HFI as X86_FEATURE_HFI. (Boris)
>   * Reworked parsing of HFI features using bitfields instead of bitmasks.
>     (PeterZ).
>   * Removed hfi_instance::parsed as hfi_parse_features() is called only
>     once via intel_hfi_init() via thermal_throttle_init_device().
>     (Rafael)
>   * Converted pr_err() to pr_debug(). (Srinivas, Rafael)
>   * Removed unnecessary dependency on CONFIG_SCHED_MC.
>   * Renamed hfi_instance::ts_counter as hfi_instance::timestamp.
>   * Renamed hfi_instance::table_base as hfi_instance::local_table and
>     relocated its definition to this patch.
>   * Wrapped hfi_instance::timestamp and hfi_instance:local_table in an
>     anonymous union, since both point at the same location.
> ---
>  drivers/thermal/intel/Kconfig       |  12 ++
>  drivers/thermal/intel/Makefile      |   1 +
>  drivers/thermal/intel/intel_hfi.c   | 175 ++++++++++++++++++++++++++++
>  drivers/thermal/intel/intel_hfi.h   |  11 ++
>  drivers/thermal/intel/therm_throt.c |   3 +
>  5 files changed, 202 insertions(+)
>  create mode 100644 drivers/thermal/intel/intel_hfi.c
>  create mode 100644 drivers/thermal/intel/intel_hfi.h
>
> diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
> index c83ea5d04a1d..1a21ff60fdc7 100644
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -99,3 +99,15 @@ config INTEL_MENLOW
>           Intel Menlow platform.
>
>           If unsure, say N.
> +
> +config INTEL_HFI

This looks like it may be too general, because HFI is not a thermal-only thing.

Maybe cal it INTEL_HFI_THERMAL?
