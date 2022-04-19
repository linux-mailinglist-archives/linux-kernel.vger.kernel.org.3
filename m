Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDC050769B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355769AbiDSRfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355802AbiDSRfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:35:21 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A35B393F9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:32:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id n43so4996993pfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=My4F6hOEJbo2T0rj7H9Ck+cHHJ/lQGHhnjl+ec5l6gU=;
        b=VyZaaztKCwGWZsA+sisdNZV6jQwH/KwBzqnOTmixzobnqn5kNoQbaBr2WTRMQfZbnj
         xQ6zAJOhsdQ7JVLaefJfGnXEshS8A+s/fnweDWBr3rJ4zkivJ3WctIWU4UGonNwieHnf
         X3AlddlqGi0mwfU44/NqIAyFHCKBC6wyVHZt1b0u1lCw7EbX9MQLkTNucUusnf7IId/5
         x86ca7+gKpJAWbhP0vrAlKw0YCUA6D8SK6nEPP7JlxJ3PxcXoO+4iyjU1UNnPdcBh5aw
         /EJz8M3dOBRMyZ0TFX9Gl3ypRt+BoSNvZESVos360kIe5kFtx3GEy3zgEhI4LGthoUNd
         bXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=My4F6hOEJbo2T0rj7H9Ck+cHHJ/lQGHhnjl+ec5l6gU=;
        b=j7fjoFKP7XF00i1LGJepoC10t42x/AZJHZqJbQ32P0E2XZf/HhJDBac7NdXXSGEy2d
         04++4pOzXFeLTmDE2oziLUeVs6u2oc/6E5tFzPbZvJ4csm5uTrc3Mn0pT+VjKo2BCKGC
         ofbQ4eAUjORX3Zmd0ctLlI/Va7t2isP+yPIQoqwj8xtXtG7cN6dst1oxkWmXrBvmLwB8
         hTj3bn3/qvATP7dE5atrIPbww+VS1iy5F87B/clqTuUrDrBvm4OwbWp3HYGCyNVYrkOc
         2mJ/L5EnngrE3pQ6+XvU6yo0A6GhFaJ0Cw0YJ0riPhXKXB5d6B2dcWeb6NChcBUSerbP
         6KrA==
X-Gm-Message-State: AOAM5301uVVCGLSTVNNFXilEnZbW5lKhJkNW42juDU1o8Ix889hBNqXN
        xMtkLa8HaajgtwBC0UTVZlJKMQ==
X-Google-Smtp-Source: ABdhPJyw/Zw5dX2U7VPx7JvsBghoWGkq770YcXAkj+dEYF0JoTpU3qNw17r9Mud9B3NNeS9HrjFyBg==
X-Received: by 2002:a05:6a00:1490:b0:4fb:1544:bc60 with SMTP id v16-20020a056a00149000b004fb1544bc60mr18808006pfu.73.1650389556767;
        Tue, 19 Apr 2022 10:32:36 -0700 (PDT)
Received: from DougS18 (s173-180-45-4.bc.hsia.telus.net. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id l13-20020a056a00140d00b004e13da93eaasm17595101pfu.62.2022.04.19.10.32.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Apr 2022 10:32:36 -0700 (PDT)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Thomas Gleixner'" <tglx@linutronix.de>
Cc:     <x86@kernel.org>, "'Rafael J. Wysocki'" <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, "'Eric Dumazet'" <edumazet@google.com>,
        "'Paul E. McKenney'" <paulmck@kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <20220415133356.179706384@linutronix.de>
In-Reply-To: <20220415133356.179706384@linutronix.de>
Subject: RE: [patch 00/10] x86/cpu: Consolidate APERF/MPERF code
Date:   Tue, 19 Apr 2022 10:32:35 -0700
Message-ID: <005001d85413$75e5dce0$61b196a0$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGAX/VhRXMrLxWmZ/QgyAMJbOz0ya2nXWjw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 2022.04.15 12:20 Thomas Gleixner wrote:

> APERF/MPERF is utilized in two ways:
>
>  1) Ad hoc readout of CPU frequency which requires IPIs
>
>  2) Frequency scale calculation for frequency invariant scheduling which
>     reads APERF/MPERF on every tick.
>
> These are completely independent code parts. Eric observed long latencies
> when reading /proc/cpuinfo which reads out CPU frequency via #1 and
> proposed to replace the per CPU single IPI with a broadcast IPI.
>
> While this makes the latency smaller, it is not necessary at all because #2
> samples APERF/MPERF periodically, except on idle or isolated NOHZ full CPUs
> which are excluded from IPI already.
>
> It could be argued that not all APERF/MPERF capable systems have the
> required BIOS information to enable frequency invariance support, but in
> practice most of them do. So the APERF/MPERF sampling can be made
> unconditional and just the frequency scale calculation for the scheduler
> excluded.
>
> The following series consolidates that.

I have used this patch set with the acpi-cpufreq, intel_cpufreq (passive),
and intel_pstate (active) CPU frequency scaling drivers and various
governors. Additionally, with HWP both enabled and disabled.

For intel_pstate (active), both HWP enabled or disabled, the behaviour
of scaling_cur_freq is inconsistent with prior to this patch set and other
scaling driver governor combinations.

Note there is no issue with " grep MHz /proc/cpuinfo" for any
combination.

Examples:

No-HWP:

active/powersave:
doug@s19:~/freq-scalers/trace$ grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:2300418
/sys/devices/system/cpu/cpu10/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu11/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq:2300006
/sys/devices/system/cpu/cpu8/cpufreq/scaling_cur_freq:2300005
/sys/devices/system/cpu/cpu9/cpufreq/scaling_cur_freq:0

active/performance:
doug@s19:~$ grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu10/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu11/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu8/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu9/cpufreq/scaling_cur_freq:0

HWP:

active/powersave:
doug@s19:~$ grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu10/cpufreq/scaling_cur_freq:799993
/sys/devices/system/cpu/cpu11/cpufreq/scaling_cur_freq:800069
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:800131
/sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu8/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu9/cpufreq/scaling_cur_freq:799844

active/performance:

doug@s19:~$ grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu10/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu11/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:4800186
/sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:4800016
/sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu8/cpufreq/scaling_cur_freq:0
/sys/devices/system/cpu/cpu9/cpufreq/scaling_cur_freq:0 

Other configurations:
intel_cpufreq /schedutil (no HWP), for example:

doug@s19:~$ grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu10/cpufreq/scaling_cur_freq:1067573
/sys/devices/system/cpu/cpu11/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:800011
/sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:800109
/sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu8/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu9/cpufreq/scaling_cur_freq:800000

Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz

> Thanks,
>
>	tglx
> ---
> arch/x86/include/asm/cpu.h       |    2 
> arch/x86/include/asm/topology.h  |   17 -
> arch/x86/kernel/acpi/cppc.c      |   28 --
> arch/x86/kernel/cpu/aperfmperf.c |  474 +++++++++++++++++++++++++++++++--------
> arch/x86/kernel/cpu/proc.c       |    2 
> arch/x86/kernel/smpboot.c        |  358 -----------------------------
> fs/proc/cpuinfo.c                |    6 
> include/linux/cpufreq.h          |    1 
> 8 files changed, 405 insertions(+), 483 deletions(-)


