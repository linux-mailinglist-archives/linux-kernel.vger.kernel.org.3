Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F02481DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbhL3P4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:56:22 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:45745 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbhL3P4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:56:20 -0500
Received: by mail-qt1-f175.google.com with SMTP id p19so22004860qtw.12;
        Thu, 30 Dec 2021 07:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uyd2lmYIj+aDxIiI6zxbrO3VhujHcAJmwQIoF2owoAA=;
        b=yn5o9HDLUh0kEm09aHx2hCsDwR2g4KFr5n35sRuylQ18g3qgCHIrZTRoxi46yEELk3
         gYrSrIROKYFiBpJqE1rpvvnzc/algZHdBwlMxSud5PNKD1vDPWCGWXY9uwvRA/LwAlRW
         wQlTj14EVDmbpTVvC/B9Ix9cWUz8BnetFrXNexONvT0cHcjnXiiPalbaCvs7wGJ0LvVE
         hqYmhP82fWVmUgMK3X/clBGnUEVTW1pOorOmqGMNcC8JPcePwoqZsHqIJwMbSQPnJPU8
         F3a7nmMDRKVevZlIgxvcY2sypUUsmaI3/S5lrewJ2GBmoVBHHfXLquBC8RwM444oVn2N
         dV0Q==
X-Gm-Message-State: AOAM53261JYJQ6K0gk61uOiDWKNg+Va7KUXvG7UAbgNovfIyMcWXQ8JT
        iK2Ton2jWQgBBVcOSjhM71NyjAHsLRaKgDDaBU8=
X-Google-Smtp-Source: ABdhPJz3+9w28sbI5DJJd57BV0iux6VYMlM3ZP1Hd7W5M/VmCNwFkRHOdUA/ovA2i96bz33JeTcJe7o2W8vYTvwOeH0=
X-Received: by 2002:a05:622a:1113:: with SMTP id e19mr23739654qty.612.1640879779270;
 Thu, 30 Dec 2021 07:56:19 -0800 (PST)
MIME-Version: 1.0
References: <20211224010508.110159-1-ray.huang@amd.com>
In-Reply-To: <20211224010508.110159-1-ray.huang@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Dec 2021 16:56:08 +0100
Message-ID: <CAJZ5v0i3xufGJi5+8zH7aG3vgjQpGuU_YVG=cBMxi0aGY1aP3A@mail.gmail.com>
Subject: Re: [PATCH v7 00/14] cpufreq: Introduce a new AMD CPU frequency
 control mechanism
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 2:05 AM Huang Rui <ray.huang@amd.com> wrote:
>
> Hi all,
>
> Merry Christmas & Happy New Year!
>
> We would like to introduce a new AMD CPU frequency control mechanism as the
> AMD P-State driver for modern AMD Zen based CPU series in Linux Kernel.
> The new mechanism is based on Collaborative processor performance control
> (CPPC) which is finer grain frequency management than legacy ACPI hardware
> P-States. Current AMD CPU platforms are using the ACPI P-states driver to
> manage CPU frequency and clocks with switching only in 3 P-states. AMD
> P-State is to replace the ACPI P-states controls, allows a flexible,
> low-latency interface for the Linux kernel to directly communicate the
> performance hints to hardware.
>
> AMD P-State leverages the Linux kernel governors such as *schedutil*,
> *ondemand*, etc. to manage the performance hints which are provided by CPPC
> hardware functionality. The first version for AMD P-State is to support one
> of the Zen3 processors, and we will support more in future after we verify
> the hardware and SBIOS functionalities.
>
> There are two types of hardware implementations for AMD P-State: one is full
> MSR support and another is shared memory support. It can use
> X86_FEATURE_CPPC feature flag to distinguish the different types.
>
> Using the new AMD P-State method + kernel governors (*schedutil*,
> *ondemand*, ...) to manage the frequency update is the most appropriate
> bridge between AMD Zen based hardware processor and Linux kernel, the
> processor is able to adjust to the most efficiency frequency according to
> the kernel scheduler loading.
>

[cut]

> Actually, the AMD P-State driver doesn't change the physical maximum
> frequency capacity in the processor. But it's able to provide the finer
> grain performance control range instead of legacy 3 P-States. It has a
> better performance and power efficiency than before. We will continue
> optimize AMD P-State function on kernel governors to support different types
> of processors such as mobile latop, performance desktop, and etc.
>

[cut]

>
>
> Huang Rui (11):
>   x86/cpufeatures: Add AMD Collaborative Processor Performance Control
>     feature flag
>   x86/msr: Add AMD CPPC MSR definitions
>   cpufreq: amd-pstate: Introduce a new AMD P-State driver to support
>     future processors
>   cpufreq: amd-pstate: Add fast switch function for AMD P-State
>   cpufreq: amd-pstate: Introduce the support for the processors with
>     shared memory solution
>   cpufreq: amd-pstate: Add trace for AMD P-State module
>   cpufreq: amd-pstate: Add boost mode support for AMD P-State
>   cpufreq: amd-pstate: Add AMD P-State frequencies attributes
>   cpufreq: amd-pstate: Add AMD P-State performance attributes
>   Documentation: amd-pstate: Add AMD P-State driver introduction
>   MAINTAINERS: Add AMD P-State driver maintainer entry
>
> Jinzhou Su (1):
>   ACPI: CPPC: Add CPPC enable register function
>
> Mario Limonciello (1):
>   ACPI: CPPC: Check present CPUs for determining _CPC is valid
>
> Steven Noonan (1):
>   ACPI: CPPC: Implement support for SystemIO registers
>
>  Documentation/admin-guide/acpi/cppc_sysfs.rst |   2 +
>  Documentation/admin-guide/pm/amd-pstate.rst   | 383 +++++++++++
>  .../admin-guide/pm/working-state.rst          |   1 +
>  MAINTAINERS                                   |   7 +
>  arch/x86/include/asm/cpufeatures.h            |   1 +
>  arch/x86/include/asm/msr-index.h              |  17 +
>  drivers/acpi/cppc_acpi.c                      |  99 ++-
>  drivers/cpufreq/Kconfig.x86                   |  17 +
>  drivers/cpufreq/Makefile                      |   5 +
>  drivers/cpufreq/amd-pstate-trace.c            |   2 +
>  drivers/cpufreq/amd-pstate-trace.h            |  77 +++
>  drivers/cpufreq/amd-pstate.c                  | 643 ++++++++++++++++++
>  include/acpi/cppc_acpi.h                      |   5 +
>  13 files changed, 1255 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/admin-guide/pm/amd-pstate.rst
>  create mode 100644 drivers/cpufreq/amd-pstate-trace.c
>  create mode 100644 drivers/cpufreq/amd-pstate-trace.h
>  create mode 100644 drivers/cpufreq/amd-pstate.c
>
> --

I'm queuing up this series for 5.17 with the assumption that all of
the comments on patch 2 have been addressed and that Steve will not
hate patch 9.

Thanks!
