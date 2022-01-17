Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847064909E8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbiAQOEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:04:32 -0500
Received: from foss.arm.com ([217.140.110.172]:58646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232569AbiAQOEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:04:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7320A1FB;
        Mon, 17 Jan 2022 06:04:31 -0800 (PST)
Received: from [10.57.36.133] (unknown [10.57.36.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A21E3F766;
        Mon, 17 Jan 2022 06:04:30 -0800 (PST)
Subject: Re: [RFC PATCH 2/2] perf: arm_spe: Enable CONTEXT packets in SPE
 traces if the profiler runs in CPU mode.
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com, james.clark@arm.com,
        leo.yan@linaro.org
References: <20220117124432.3119132-1-german.gomez@arm.com>
 <20220117124432.3119132-3-german.gomez@arm.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <949a8209-4efa-5c4f-8953-ddc53938706d@arm.com>
Date:   Mon, 17 Jan 2022 14:04:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220117124432.3119132-3-german.gomez@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/01/2022 12:44, German Gomez wrote:
> Enable CONTEXT packets in SPE traces if the profiler runs in CPU mode.
> This is no less permissive than the existing behavior for the following
> reason:
>
> If perf_event_paranoid <= 0, then non perfmon_capable() users can open
> a per-CPU event. With a per-CPU event, unpriviledged users are allowed
> to profile _all_ processes, even ones owned by root.
>
> Without this change, users could see kernel addresses, root processes,
> etc, but not gather the PIDs of those processes. The PID is probably the
> least sensitive of all the information.
>
> It would be more idiomatic to check the perf_event_paranoid level with
> perf_allow_cpu(), but this function is not exported so cannot be used
> from a module. Looking for cpu != -1 is the indirect way of checking
> the same thing as it could never get to arm_spe_pmu_event_init() without

Reconsidering this bit (comment below)

> perf_event_paranoid <= 0.
>
> Co-authored-by: James Clark <james.clark@arm.com>
> Signed-off-by: German Gomez <german.gomez@arm.com>
> ---
>  drivers/perf/arm_spe_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 8515bf85c..7d9a7fa4f 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -711,7 +711,7 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>  	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
>  		return -EOPNOTSUPP;
>  
> -	spe_pmu->pmscr_cx = perfmon_capable();
> +	spe_pmu->pmscr_cx = perfmon_capable() || (event->cpu != -1);

The perf_event_open(2) manpage states:

       pid == -1 and cpu >= 0
              This measures all processes/threads on the specified CPU.
              This requires CAP_PERFMON (since Linux 5.8) or
              CAP_SYS_ADMIN capability or a
              /proc/sys/kernel/perf_event_paranoid value of less than 1.

So perhaps it's more accurate to (still implicitly) check the paranoid level with "pid == -1 && event->cpu > 0" ?

If so, I think I have to dig deeper into perf_event. I don't immediately see the pid argument. Any hints?

Thanks,
German

>  	reg = arm_spe_event_to_pmscr(event);
>  	if (!perfmon_capable() &&
>  	    (reg & (BIT(SYS_PMSCR_EL1_PA_SHIFT) |
