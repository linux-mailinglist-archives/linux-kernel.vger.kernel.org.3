Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343A8477B63
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbhLPSUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:20:49 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:44737 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbhLPSUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:20:46 -0500
Received: by mail-ot1-f45.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso29923201otj.11;
        Thu, 16 Dec 2021 10:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0W0umxS6PYbwtVe7gn0NSIxV2N1egkWm+aNqEgCS2Ok=;
        b=4CD6kaOuArLGyMb/z5/RXCLrZcy9LGePorlM6CTThyqekSFVk7gGF7QJk+R9C1w6rJ
         Qtb7brjN0xD/Z+tGFk1Jwq+btvFir9m9pV6ijyS8GdvRUpmMCRokexzAyngTJxuk1ENw
         zRDeK0endiQCWfYyJCEMyGnq2qacTjlpruV1m4RyMqlUUuc6XJ2ISUGV1fAHlBvwOpmp
         JFmX11VGrAqw7xgWFYVcIACp1Vbvr159Nre6RS1JJw4hzIisxUcjSIu6KwG452uRca9t
         OLTYul3ZSU2qfi1fl/Hz+lAouE9p7HIlbhUTLWQSdtqqbwZUe7dHH8DzwsDk9KOjwjim
         7j1g==
X-Gm-Message-State: AOAM5313mBrD3SQ5skfA/ckSWlHW0Vc1KvSvCYo413S/uolu2FjSJF7j
        3zTha3RNs0QktuIk/bpAZ6wvGaGr3HYslNByIGO/pZ/M
X-Google-Smtp-Source: ABdhPJx72etW0DULJhhjowXUWCEwgBOHyaVorFvQsKCqeGU/KtM9EJMtuOG9vrLBnw3fr+emP3RPVVOeS8yKETYZ55c=
X-Received: by 2002:a05:6830:1e57:: with SMTP id e23mr13356321otj.16.1639678845471;
 Thu, 16 Dec 2021 10:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20211130123641.1449041-1-ray.huang@amd.com>
In-Reply-To: <20211130123641.1449041-1-ray.huang@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Dec 2021 19:20:34 +0100
Message-ID: <CAJZ5v0j7TyVOZ+X2WAjoqT3c0Y6bowe=7miXjo6zj8YWEaHLrQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/22] cpufreq: introduce a new AMD CPU frequency
 control mechanism
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 1:37 PM Huang Rui <ray.huang@amd.com> wrote:
>
> Hi all,
>
> We would like to introduce a new AMD CPU frequency control mechanism as the
> "amd-pstate" driver for modern AMD Zen based CPU series in Linux Kernel.
> The new mechanism is based on Collaborative processor performance control
> (CPPC) which is finer grain frequency management than legacy ACPI hardware
> P-States. Current AMD CPU platforms are using the ACPI P-states driver to
> manage CPU frequency and clocks with switching only in 3 P-states. AMD
> P-States is to replace the ACPI P-states controls, allows a flexible,
> low-latency interface for the Linux kernel to directly communicate the
> performance hints to hardware.
>
> "amd-pstate" leverages the Linux kernel governors such as *schedutil*,
> *ondemand*, etc. to manage the performance hints which are provided by CPPC
> hardware functionality. The first version for amd-pstate is to support one
> of the Zen3 processors, and we will support more in future after we verify
> the hardware and SBIOS functionalities.
>
> There are two types of hardware implementations for amd-pstate: one is full
> MSR support and another is shared memory support. It can use
> X86_FEATURE_CPPC feature flag to distinguish the different types.
>
> Using the new AMD P-States method + kernel governors (*schedutil*,
> *ondemand*, ...) to manage the frequency update is the most appropriate
> bridge between AMD Zen based hardware processor and Linux kernel, the
> processor is able to adjust to the most efficiency frequency according to
> the kernel scheduler loading.
>
> Please check the detailed CPU feature and MSR register description in
> Processor Programming Reference (PPR) for AMD Family 19h Model 51h,
> Revision A1 Processors:
>
> https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip
>
> Performance Per Watt (PPW) Calculation:
>
> We use the RAPL interface with "perf" tool to get the energy data of the
> package power.
>
> The data comparisons between amd-pstate and acpi-freq module are tested on
> AMD Cezanne processor (mobile CPU):
>
> 1) TBench CPU benchmark:
>
> +----------------------------------------------------------------------------------------------+
> |                                                                                              |
> |                               TBench4 (Performance Per Watt)                                 |
> |                                                                             Higher is better |
> +-------------------+------------------------+------------------------+------------------------+
> |                   |  Performance Per Watt  |  Performance Per Watt  |  Performance Per Watt  |
> |   Kernel Module   |       (Schedutil)      |       (Ondemand)       |       (Performance)    |
> |                   |       Unit: MB / J     |       Unit: MB / J     |       Unit: MB / J     |
> +-------------------+------------------------+------------------------+------------------------+
> |                   |                        |                        |                        |
> |    acpi-cpufreq   |         48.56          |        48.89           |        47.81           |
> |                   |                        |                        |                        |
> +-------------------+------------------------+------------------------+------------------------+
> |                   |                        |                        |                        |
> |     amd-pstate    |         48.38          |        47.38           |        48.77           |
> |                   |                        |                        |                        |
> +-------------------+------------------------+------------------------+------------------------+
>
> Note: The previous data was based on TBench2, as align with Suse, we use
> TBench4 to re-test it. The PPW is very closed to acpi-cpufreq. And we are
> still re-runing other tests.
>
> Steam Game Demo on Ryzen 5900X (12 core 24 threads):
>
> The picture to compare acpi-cpufreq vs amd-pstate:
> https://drive.google.com/file/d/1PvSduykJn9U5MMOhzFWycnbmGmznalM3/view?usp=sharing
>
> Two videos:
> https://drive.google.com/file/d/1nQQEteL-v_zQxnOJpyW8JqvRW2FFDN2Z/view?usp=sharing
> https://drive.google.com/file/d/1heuPgFG71SQHvGb6wfedrQciBfE2rhnu/view?usp=sharing
>
> Actually, the amd-pstate driver doesn't change the physical maximum
> frequency capacity in the processor. But it's able to provide the finer
> grain performance control range instead of legacy 3 P-States. It has a
> better performance and power efficiency than before. We will continue
> optimize amd-pstate function on kernel governors to support different types
> of processors such as mobile latop, performance desktop, and etc.
>
> See patch series in below git repo:
> V1: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v1
> V2: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v2
> V3: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v3
> V4: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v4
> V5: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v5
>
> For details introduction, please see the patch 22.

After going through all of the series I'm still unsure what the
freq_qos requests added in patch [06/22] are for.

The cpupower patches need ACKs from Shuah for me to take them.

The tracing patch needs an ACK from Steve Rostedt.

Thanks!
