Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663AD49878F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbiAXSCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:02:55 -0500
Received: from foss.arm.com ([217.140.110.172]:42958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235628AbiAXSCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:02:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 231BAD6E;
        Mon, 24 Jan 2022 10:02:54 -0800 (PST)
Received: from [10.57.39.131] (unknown [10.57.39.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EFFA3F766;
        Mon, 24 Jan 2022 10:02:52 -0800 (PST)
Subject: Re: [RFC V1 08/11] arm64/perf: Enable branch stack sampling
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
 <1642998653-21377-9-git-send-email-anshuman.khandual@arm.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <741d159d-fce4-377e-8817-f8a6462f3a71@arm.com>
Date:   Mon, 24 Jan 2022 18:02:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1642998653-21377-9-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/01/2022 04:30, Anshuman Khandual wrote:
> Now that all the required pieces are already in place, just enable the perf
> branch stack sampling support on arm64 platform, by removing the gate which
> blocks it in armpmu_event_init().
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/perf/arm_pmu.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 0800c8858ed8..2117bf5d3232 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -537,9 +537,28 @@ static int armpmu_event_init(struct perf_event *event)
>  		!cpumask_test_cpu(event->cpu, &armpmu->supported_cpus))
>  		return -ENOENT;
>  
> -	/* does not support taken branch sampling */
> -	if (has_branch_stack(event))
> -		return -EOPNOTSUPP;
> +	if (has_branch_stack(event)) {
> +		/*
> +		 * BRBE support is absent. Select CONFIG_ARM_BRBE_PMU
> +		 * in the config, before branch stack sampling events
> +		 * can be requested.
> +		 */
> +		if (!IS_ENABLED(CONFIG_ARM_BRBE_PMU)) {
> +			pr_warn_once("BRBE is disabled, select CONFIG_ARM_BRBE_PMU\n");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		/*
> +		 * Branch stack sampling event can not be supported in
> +		 * case either the required driver itself is absent or
> +		 * BRBE buffer, is not supported. Besides checking for
> +		 * the callback prevents a crash in case it's absent.
> +		 */
> +		if (!armpmu->brbe_supported || !armpmu->brbe_supported(event)) {
> +			pr_warn_once("BRBE is not supported\n");
> +			return -EOPNOTSUPP;

brbe_supported() returns false for one permission case, rather than a "not supported" case
so EOPNOTSUPP is the wrong thing to return here for this case otherwise it makes perf
print confusing error messages. 

The brbe_supported() function needs to be split into two, one that handles support and one
that handles permissions and different errors need to be reported. Here is the permission
bit from that function:

  +	if (event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_KERNEL) {
  +		if (!perfmon_capable()) {
  +			pr_warn_once("does not have permission for kernel branch filter\n");
  +			return false;
  +		}
  +	}

> +		}
> +	}
>  
>  	if (armpmu->map_event(event) == -ENOENT)
>  		return -ENOENT;
> 
