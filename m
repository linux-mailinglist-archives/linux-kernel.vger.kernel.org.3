Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEA24A6FA6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343768AbiBBLLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:11:13 -0500
Received: from foss.arm.com ([217.140.110.172]:51752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343744AbiBBLLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:11:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD1891FB;
        Wed,  2 Feb 2022 03:11:12 -0800 (PST)
Received: from [10.163.43.221] (unknown [10.163.43.221])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B850F3F40C;
        Wed,  2 Feb 2022 03:11:08 -0800 (PST)
Subject: Re: [RFC V1 11/11] perf: Capture branch privilege information
To:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
 <1642998653-21377-12-git-send-email-anshuman.khandual@arm.com>
 <82d586d3-358b-724b-0eac-7fb5c6e03efb@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <0c87db6e-2cd1-6d0f-8f72-cf3203376be0@arm.com>
Date:   Wed, 2 Feb 2022 16:41:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <82d586d3-358b-724b-0eac-7fb5c6e03efb@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/22 9:09 PM, James Clark wrote:
> 
> 
> On 24/01/2022 04:30, Anshuman Khandual wrote:
>> Platforms like arm64 could capture privilege level information for all the
>> branch records. Hence this adds a new element in the struct branch_entry to
>> record the privilege level information, which could be requested through a
>> new event.attr.branch_sample_type flag PERF_SAMPLE_BRANCH_PRIV_SAVE. While
>> here, update the BRBE driver as required.
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-perf-users@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  drivers/perf/arm_pmu_brbe.c              | 28 ++++++++++++++++++++++++
>>  include/linux/perf_event.h               |  5 +++++
>>  include/uapi/linux/perf_event.h          | 13 ++++++++++-
>>  tools/include/uapi/linux/perf_event.h    | 13 ++++++++++-
>>  tools/perf/Documentation/perf-record.txt |  1 +
>>  tools/perf/util/parse-branch-options.c   |  1 +
>>  6 files changed, 59 insertions(+), 2 deletions(-)
>>
> [...]
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index 361fdc6b87a0..4d77710f7a4e 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -204,6 +204,8 @@ enum perf_branch_sample_type_shift {
>>  
>>  	PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT	= 17, /* save low level index of raw branch records */
>>  
>> +	PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT	= 18, /* save privillege mode */
> 
> privillege -> privilege

Fixed.

> 
>> +
>>  	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
>>  };
>>  
>> @@ -233,6 +235,8 @@ enum perf_branch_sample_type {
>>  
>>  	PERF_SAMPLE_BRANCH_HW_INDEX	= 1U << PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT,
>>  
>> +	PERF_SAMPLE_BRANCH_PRIV_SAVE	= 1U << PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT,
>> +
> 
> Can you also add the new entry to the perf verbose printer otherwise it looks like
> it's not being set on branch_sample_type
> (as in when using ./perf record -j any_call,u,priv -vvv):

Sure, will do.

> 
> 	static void __p_branch_sample_type(char *buf, size_t size, u64 value)
> 	{
> 	#define bit_name(n) { PERF_SAMPLE_BRANCH_##n, #n }
> 		struct bit_names bits[] = {
> 			bit_name(USER), bit_name(KERNEL), bit_name(HV), bit_name(ANY),
> 			bit_name(ANY_CALL), bit_name(ANY_RETURN), bit_name(IND_CALL),
> 			bit_name(ABORT_TX), bit_name(IN_TX), bit_name(NO_TX),
> 			bit_name(COND), bit_name(CALL_STACK), bit_name(IND_JUMP),
> 			bit_name(CALL), bit_name(NO_FLAGS), bit_name(NO_CYCLES),
> 			bit_name(HW_INDEX),
> 			{ .name = NULL, }
> 		};
> 	#undef bit_name
> 		__p_bits(buf, size, value, bits);
> 	}
> 
> PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT is also missing so it probably makes sense to add it
> at the same time as that was expanded for BRBE.

Posted a patch for PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT here but will update
for the new 'priv' request via this series.

https://lore.kernel.org/all/1643799443-15109-1-git-send-email-anshuman.khandual@arm.com/
