Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC555ACE96
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiIEJKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiIEJKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:10:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F91A13F79;
        Mon,  5 Sep 2022 02:10:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65D10ED1;
        Mon,  5 Sep 2022 02:10:13 -0700 (PDT)
Received: from [10.57.16.151] (unknown [10.57.16.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A3B33F534;
        Mon,  5 Sep 2022 02:10:05 -0700 (PDT)
Message-ID: <3ad268df-f6fd-a899-ce0e-131b5fdfeae8@arm.com>
Date:   Mon, 5 Sep 2022 10:10:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 3/4] arm64/perf: Assert all platform event flags are
 within PERF_EVENT_FLAG_ARCH
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org
References: <20220905054239.324029-1-anshuman.khandual@arm.com>
 <20220905054239.324029-4-anshuman.khandual@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220905054239.324029-4-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/09/2022 06:42, Anshuman Khandual wrote:
> Ensure all platform specific event flags are within PERF_EVENT_FLAG_ARCH.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/perf/arm_spe_pmu.c   | 4 +++-
>  include/linux/perf/arm_pmu.h | 9 +++++----
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index b65a7d9640e1..db8a0a841062 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -44,7 +44,9 @@
>   * This allows us to perform the check, i.e, perfmon_capable(),
>   * in the context of the event owner, once, during the event_init().
>   */
> -#define SPE_PMU_HW_FLAGS_CX			BIT(0)
> +#define SPE_PMU_HW_FLAGS_CX			0x00001
> +
> +static_assert((PERF_EVENT_FLAG_ARCH & SPE_PMU_HW_FLAGS_CX) == SPE_PMU_HW_FLAGS_CX);
>  
>  static void set_spe_event_has_cx(struct perf_event *event)
>  {
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 0407a38b470a..0356cb6a215d 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -24,10 +24,11 @@
>  /*
>   * ARM PMU hw_event flags
>   */
> -/* Event uses a 64bit counter */
> -#define ARMPMU_EVT_64BIT		1
> -/* Event uses a 47bit counter */
> -#define ARMPMU_EVT_47BIT		2
> +#define ARMPMU_EVT_64BIT		0x00001 /* Event uses a 64bit counter */
> +#define ARMPMU_EVT_47BIT		0x00002 /* Event uses a 47bit counter */
> +

Minor nit:

I don't think changing the definitions to hex adds anything except more
noise in the git blame.

Either way, for the whole set:

Reviewed-by: James Clark <james.clark@arm.com>

> +static_assert((PERF_EVENT_FLAG_ARCH & ARMPMU_EVT_64BIT) == ARMPMU_EVT_64BIT);
> +static_assert((PERF_EVENT_FLAG_ARCH & ARMPMU_EVT_47BIT) == ARMPMU_EVT_47BIT);
>  
>  #define HW_OP_UNSUPPORTED		0xFFFF
>  #define C(_x)				PERF_COUNT_HW_CACHE_##_x
