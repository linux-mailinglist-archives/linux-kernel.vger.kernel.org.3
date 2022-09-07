Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593075AFBB5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiIGF1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 01:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiIGF1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 01:27:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49F3F9D669;
        Tue,  6 Sep 2022 22:27:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F02E1042;
        Tue,  6 Sep 2022 22:27:48 -0700 (PDT)
Received: from [10.162.40.15] (unknown [10.162.40.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 434763F534;
        Tue,  6 Sep 2022 22:28:05 -0700 (PDT)
Message-ID: <763825a2-67a1-6288-1b12-15768eef1d75@arm.com>
Date:   Wed, 7 Sep 2022 10:57:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 4/4] x86/perf: Assert all platform event flags are
 within PERF_EVENT_FLAG_ARCH
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
References: <20220905054239.324029-1-anshuman.khandual@arm.com>
 <20220905054239.324029-5-anshuman.khandual@arm.com>
 <Yxed5u9X2PKGAKGf@hirez.programming.kicks-ass.net>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Yxed5u9X2PKGAKGf@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/22 00:52, Peter Zijlstra wrote:
> On Mon, Sep 05, 2022 at 11:12:39AM +0530, Anshuman Khandual wrote:
> 
>>  arch/x86/events/perf_event.h | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
>> index ba3d24a6a4ec..12136a33e9b7 100644
>> --- a/arch/x86/events/perf_event.h
>> +++ b/arch/x86/events/perf_event.h
>> @@ -86,6 +86,26 @@ static inline bool constraint_match(struct event_constraint *c, u64 ecode)
>>  #define PERF_X86_EVENT_AMD_BRS		0x10000 /* AMD Branch Sampling */
>>  #define PERF_X86_EVENT_PEBS_LAT_HYBRID	0x20000 /* ld and st lat for hybrid */
>>  
>> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_LDLAT) == PERF_X86_EVENT_PEBS_LDLAT);
>> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_ST) == PERF_X86_EVENT_PEBS_ST);
>> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_ST_HSW) == PERF_X86_EVENT_PEBS_ST_HSW);
>> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_LD_HSW) == PERF_X86_EVENT_PEBS_LD_HSW);
>> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_NA_HSW) == PERF_X86_EVENT_PEBS_NA_HSW);
>> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_EXCL) == PERF_X86_EVENT_EXCL);
>> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_DYNAMIC) == PERF_X86_EVENT_DYNAMIC);
>> +
>> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_EXCL_ACCT) == PERF_X86_EVENT_EXCL_ACCT);
>> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_AUTO_RELOAD) == PERF_X86_EVENT_AUTO_RELOAD);
>> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_LARGE_PEBS) == PERF_X86_EVENT_LARGE_PEBS);
>> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_VIA_PT) == PERF_X86_EVENT_PEBS_VIA_PT);
>> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PAIR) == PERF_X86_EVENT_PAIR);
>> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_LBR_SELECT) == PERF_X86_EVENT_LBR_SELECT);
>> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_TOPDOWN) == PERF_X86_EVENT_TOPDOWN);
>> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_STLAT) == PERF_X86_EVENT_PEBS_STLAT);
>> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_AMD_BRS) == PERF_X86_EVENT_AMD_BRS);
>> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_LAT_HYBRID)
>> +				   == PERF_X86_EVENT_PEBS_LAT_HYBRID);
> 
> 
> That's not half tedious...
> 
> How about something like so?

Makes sense, will fold this back. Could I also include your "Signed-off-by:"
for this patch ?

- Anshuman

> 
> ---
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -64,27 +64,25 @@ static inline bool constraint_match(stru
>  	return ((ecode & c->cmask) - c->code) <= (u64)c->size;
>  }
>  
> +#define PERF_ARCH(name, val)	\
> +	PERF_X86_EVENT_##name = val,
> +
>  /*
>   * struct hw_perf_event.flags flags
>   */
> -#define PERF_X86_EVENT_PEBS_LDLAT	0x00001 /* ld+ldlat data address sampling */
> -#define PERF_X86_EVENT_PEBS_ST		0x00002 /* st data address sampling */
> -#define PERF_X86_EVENT_PEBS_ST_HSW	0x00004 /* haswell style datala, store */
> -#define PERF_X86_EVENT_PEBS_LD_HSW	0x00008 /* haswell style datala, load */
> -#define PERF_X86_EVENT_PEBS_NA_HSW	0x00010 /* haswell style datala, unknown */
> -#define PERF_X86_EVENT_EXCL		0x00020 /* HT exclusivity on counter */
> -#define PERF_X86_EVENT_DYNAMIC		0x00040 /* dynamic alloc'd constraint */
> -
> -#define PERF_X86_EVENT_EXCL_ACCT	0x00100 /* accounted EXCL event */
> -#define PERF_X86_EVENT_AUTO_RELOAD	0x00200 /* use PEBS auto-reload */
> -#define PERF_X86_EVENT_LARGE_PEBS	0x00400 /* use large PEBS */
> -#define PERF_X86_EVENT_PEBS_VIA_PT	0x00800 /* use PT buffer for PEBS */
> -#define PERF_X86_EVENT_PAIR		0x01000 /* Large Increment per Cycle */
> -#define PERF_X86_EVENT_LBR_SELECT	0x02000 /* Save/Restore MSR_LBR_SELECT */
> -#define PERF_X86_EVENT_TOPDOWN		0x04000 /* Count Topdown slots/metrics events */
> -#define PERF_X86_EVENT_PEBS_STLAT	0x08000 /* st+stlat data address sampling */
> -#define PERF_X86_EVENT_AMD_BRS		0x10000 /* AMD Branch Sampling */
> -#define PERF_X86_EVENT_PEBS_LAT_HYBRID	0x20000 /* ld and st lat for hybrid */
> +enum {
> +#include "perf_event_flags.h"
> +};
> +
> +#undef PERF_ARCH
> +
> +#define PERF_ARCH(name, val)						\
> +	static_assert((PERF_X86_EVENT_##name & PERF_EVENT_FLAG_ARCH) ==	\
> +		      PERF_X86_EVENT_##name);
> +
> +#include "perf_event_flags.h"
> +
> +#undef PERF_ARCH
>  
>  static inline bool is_topdown_count(struct perf_event *event)
>  {
> --- /dev/null
> +++ b/arch/x86/events/perf_event_flags.h
> @@ -0,0 +1,22 @@
> +
> +/*
> + * struct hw_perf_event.flags flags
> + */
> +PERF_ARCH(PEBS_LDLAT,		0x00001) /* ld+ldlat data address sampling */
> +PERF_ARCH(PEBS_ST,		0x00002) /* st data address sampling */
> +PERF_ARCH(PEBS_ST_HSW,		0x00004) /* haswell style datala, store */
> +PERF_ARCH(PEBS_LD_HSW,		0x00008) /* haswell style datala, load */
> +PERF_ARCH(PEBS_NA_HSW,		0x00010) /* haswell style datala, unknown */
> +PERF_ARCH(EXCL,			0x00020) /* HT exclusivity on counter */
> +PERF_ARCH(DYNAMIC,		0x00040) /* dynamic alloc'd constraint */
> +			/*	0x00080	*/
> +PERF_ARCH(EXCL_ACCT,		0x00100) /* accounted EXCL event */
> +PERF_ARCH(AUTO_RELOAD,		0x00200) /* use PEBS auto-reload */
> +PERF_ARCH(LARGE_PEBS,		0x00400) /* use large PEBS */
> +PERF_ARCH(PEBS_VIA_PT,		0x00800) /* use PT buffer for PEBS */
> +PERF_ARCH(PAIR,			0x01000) /* Large Increment per Cycle */
> +PERF_ARCH(LBR_SELECT,		0x02000) /* Save/Restore MSR_LBR_SELECT */
> +PERF_ARCH(TOPDOWN,		0x04000) /* Count Topdown slots/metrics events */
> +PERF_ARCH(PEBS_STLAT,		0x08000) /* st+stlat data address sampling */
> +PERF_ARCH(AMD_BRS,		0x10000) /* AMD Branch Sampling */
> +PERF_ARCH(PEBS_LAT_HYBRID,	0x20000) /* ld and st lat for hybrid */
