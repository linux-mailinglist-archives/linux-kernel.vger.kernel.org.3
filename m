Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421B249F24B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 05:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345942AbiA1EOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 23:14:22 -0500
Received: from foss.arm.com ([217.140.110.172]:45856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236875AbiA1EOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 23:14:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4214113E;
        Thu, 27 Jan 2022 20:14:20 -0800 (PST)
Received: from [10.163.44.75] (unknown [10.163.44.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 331C03F7D7;
        Thu, 27 Jan 2022 20:14:15 -0800 (PST)
Subject: Re: [RFC V1 10/11] perf: Expand perf_branch_entry.type
To:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
 <1642998653-21377-11-git-send-email-anshuman.khandual@arm.com>
 <2d7297b3-9a22-626b-9840-a4eaab4b94e8@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <17dc4a62-14d6-c0f2-b428-c1525411b1e0@arm.com>
Date:   Fri, 28 Jan 2022 09:44:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2d7297b3-9a22-626b-9840-a4eaab4b94e8@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/22 10:28 PM, James Clark wrote:
> 
> On 24/01/2022 04:30, Anshuman Khandual wrote:
>> Current perf_branch_entry.type is a 4 bits field just enough to accommodate
>> 16 generic branch types. This is insufficient to accommodate platforms like
>> arm64 which has much more branch types. Lets just expands this field into a
>> 6 bits one, which can now hold 64 generic branch types. This also adds more
>> generic branch types and updates the BRBE driver as required.
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-perf-users@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  drivers/perf/arm_pmu_brbe.c           |  7 ++++++-
>>  include/uapi/linux/perf_event.h       | 10 ++++++++--
>>  tools/include/uapi/linux/perf_event.h | 10 ++++++++--
>>  tools/perf/util/branch.c              |  8 +++++++-
>>  4 files changed, 29 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/perf/arm_pmu_brbe.c b/drivers/perf/arm_pmu_brbe.c
>> index 8d27ad868359..7cd1208c6c58 100644
>> --- a/drivers/perf/arm_pmu_brbe.c
>> +++ b/drivers/perf/arm_pmu_brbe.c
>> @@ -253,12 +253,17 @@ static int brbe_fetch_perf_type(u64 brbinf)
>>  	case BRBINF_TYPE_DEBUG_EXIT:
>>  		return PERF_BR_DEBUG_EXIT;
>>  	case BRBINF_TYPE_SERROR:
>> +		return PERF_BR_SERROR;
>>  	case BRBINF_TYPE_INST_DEBUG:
>> +		return PERF_BR_DEBUG_INST;
>>  	case BRBINF_TYPE_DATA_DEBUG:
>> +		return PERF_BR_DEBUG_DATA;
>>  	case BRBINF_TYPE_ALGN_FAULT:
>> +		return PERF_BR_FAULT_ALGN;
>>  	case BRBINF_TYPE_INST_FAULT:
>> +		return PERF_BR_FAULT_INST;
>>  	case BRBINF_TYPE_DATA_FAULT:
>> -		return PERF_BR_UNKNOWN;
>> +		return PERF_BR_FAULT_DATA;
>>  	default:
>>  		pr_warn("unknown branch type captured\n");
>>  		return PERF_BR_UNKNOWN;
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index b91d0f575d0c..361fdc6b87a0 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -256,6 +256,12 @@ enum {
>>  	PERF_BR_FIQ		= 13,	/* fiq */
>>  	PERF_BR_DEBUG_HALT	= 14,	/* debug halt */
>>  	PERF_BR_DEBUG_EXIT	= 15,	/* debug exit */
>> +	PERF_BR_DEBUG_INST	= 16,	/* instruciton debug */
>> +	PERF_BR_DEBUG_DATA	= 17,	/* data debug */
>> +	PERF_BR_FAULT_ALGN	= 18,	/* alignment fault */
>> +	PERF_BR_FAULT_DATA	= 19,	/* data fault */
>> +	PERF_BR_FAULT_INST	= 20,	/* instruction fault */
>> +	PERF_BR_SERROR		= 21,	/* system error */
>>  	PERF_BR_MAX,
>>  };
>>  
>> @@ -1370,8 +1376,8 @@ struct perf_branch_entry {
>>  		in_tx:1,    /* in transaction */
>>  		abort:1,    /* transaction abort */
>>  		cycles:16,  /* cycle count to last branch */
>> -		type:4,     /* branch type */
>> -		reserved:40;
>> +		type:6,     /* branch type */
>> +		reserved:38;
>>  };
>>  
>>  union perf_sample_weight {
>> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
>> index 1882054e8684..9a82b8aaed93 100644
>> --- a/tools/include/uapi/linux/perf_event.h
>> +++ b/tools/include/uapi/linux/perf_event.h
>> @@ -256,6 +256,12 @@ enum {
>>  	PERF_BR_FIQ		= 13,	/* fiq */
>>  	PERF_BR_DEBUG_HALT	= 14,	/* debug halt */
>>  	PERF_BR_DEBUG_EXIT	= 15,	/* debug exit */
>> +	PERF_BR_DEBUG_INST	= 16,	/* instruciton debug */
>> +	PERF_BR_DEBUG_DATA	= 17,	/* data debug */
>> +	PERF_BR_FAULT_ALGN	= 18,	/* alignment fault */
>> +	PERF_BR_FAULT_DATA	= 19,	/* data fault */
>> +	PERF_BR_FAULT_INST	= 20,	/* instruction fault */
>> +	PERF_BR_SERROR		= 21,	/* system error */
>>  	PERF_BR_MAX,
>>  };
>>  
>> @@ -1370,8 +1376,8 @@ struct perf_branch_entry {
>>  		in_tx:1,    /* in transaction */
>>  		abort:1,    /* transaction abort */
>>  		cycles:16,  /* cycle count to last branch */
>> -		type:4,     /* branch type */
>> -		reserved:40;
>> +		type:6,     /* branch type */
>> +		reserved:38;
>>  };
> There's another copy of this struct in branch.h that is used to access the same data in
> perf which also needs updating:
> 
> 	struct branch_flags {
> 		union {
> 			u64 value;
> 			struct {
> 				u64 mispred:1;
> 				u64 predicted:1;
> 				u64 in_tx:1;
> 				u64 abort:1;
> 				u64 cycles:16;
> 				u64 type:4;
> 				u64 reserved:40;
> 			};
> 		};
> 	};

Sure, thanks for the catch. Will fix it.

> 
> It's never assigned directly but there is some casting stuff going on in
> evsel__parse_sample() and it eventually ends up being used to access branch
> records. Same applies to the privilege data change.
> 

Okay, will do the necessary changes in the privilege data patch.
