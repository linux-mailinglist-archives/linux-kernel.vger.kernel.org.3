Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E104D7AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 07:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbiCNGsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 02:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiCNGsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 02:48:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 139E2403CF;
        Sun, 13 Mar 2022 23:47:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF8BC1042;
        Sun, 13 Mar 2022 23:47:36 -0700 (PDT)
Received: from [10.163.33.185] (unknown [10.163.33.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B84F33F7D7;
        Sun, 13 Mar 2022 23:47:28 -0700 (PDT)
Message-ID: <0d04d7a0-9186-ce89-fe51-616c2af37a8d@arm.com>
Date:   Mon, 14 Mar 2022 12:17:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC V1 11/11] perf: Capture branch privilege information
Content-Language: en-US
To:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Rob Herring <rob.herring@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
 <1642998653-21377-12-git-send-email-anshuman.khandual@arm.com>
 <b85da904-50cb-b7e3-1429-6f5ef244567b@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <b85da904-50cb-b7e3-1429-6f5ef244567b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/22 22:57, James Clark wrote:
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
>> diff --git a/drivers/perf/arm_pmu_brbe.c b/drivers/perf/arm_pmu_brbe.c
>> index 7cd1208c6c58..d4cbea74c148 100644
>> --- a/drivers/perf/arm_pmu_brbe.c
>> +++ b/drivers/perf/arm_pmu_brbe.c
>> @@ -270,6 +270,25 @@ static int brbe_fetch_perf_type(u64 brbinf)
>>  	}
>>  }
>>  
>> +static int brbe_fetch_perf_priv(u64 brbinf)
>> +{
>> +	int brbe_el = brbe_fetch_el(brbinf);
>> +
>> +	switch (brbe_el) {
>> +	case BRBINF_EL_EL0:
>> +		return PERF_BR_USER;
>> +	case BRBINF_EL_EL1:
>> +		return PERF_BR_KERNEL;
>> +	case BRBINF_EL_EL2:
>> +		if (is_kernel_in_hyp_mode())
>> +			return PERF_BR_KERNEL;
>> +		return PERF_BR_HV;
>> +	default:
>> +		pr_warn("unknown branch privilege captured\n");
>> +		return -1;
>> +	}
>> +}
>> +
>>  static void capture_brbe_flags(struct pmu_hw_events *cpuc, struct perf_event *event,
>>  			       u64 brbinf, int idx)
>>  {
>> @@ -302,6 +321,15 @@ static void capture_brbe_flags(struct pmu_hw_events *cpuc, struct perf_event *ev
>>  			cpuc->brbe_entries[idx].in_tx = brbinf & BRBINF_TX;
>>  		}
>>  	}
>> +
>> +	if (branch_sample_priv(event)) {
>> +		/*
>> +		 * All these information (i.e branch privilege level) are not
>> +		 * available for source only branch records.
>> +		 */
>> +		if (type != BRBINF_VALID_SOURCE)
>> +			cpuc->brbe_entries[idx].priv = brbe_fetch_perf_priv(brbinf);
>> +	}
>>  }
>>  
>>  /*
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 916ce5102b33..8021b6a30d86 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -1688,4 +1688,9 @@ static inline bool branch_sample_hw_index(const struct perf_event *event)
>>  {
>>  	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX;
>>  }
>> +
>> +static inline bool branch_sample_priv(const struct perf_event *event)
>> +{
>> +	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_PRIV_SAVE;
>> +}
>>  #endif /* _LINUX_PERF_EVENT_H */
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index 361fdc6b87a0..4d77710f7a4e 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -204,6 +204,8 @@ enum perf_branch_sample_type_shift {
>>  
>>  	PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT	= 17, /* save low level index of raw branch records */
>>  
>> +	PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT	= 18, /* save privillege mode */
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
>>  	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
>>  };
>>  
>> @@ -265,6 +269,12 @@ enum {
>>  	PERF_BR_MAX,
>>  };
>>  
>> +enum {
>> +	PERF_BR_USER	= 0,
>> +	PERF_BR_KERNEL	= 1,
>> +	PERF_BR_HV	= 2,
>> +};
>> +
> Can we have 0 as "UNKNOWN". It's going to be difficult to parse files when privilege information
> isn't saved and get accurate results without that. For example if it's not set then presumably
> the field would be 0 (PERF_BR_USER), but that doesn't mean the samples are user in that case.
> 
> I know you might be able to go backwards and look at what arguments were passed to the kernel but
> it's not guaranteed that the kernel honored the request anyway. There are also other platforms
> to think about etc.
> 
> If you look at the branch type definitions above they start at 0 (PERF_BR_UNKNOWN) which I think
> works out quite nicely in the userspace code.

This is being taken care in the new BRBE related perf ABI changes series (V3).

https://lore.kernel.org/all/20220314055857.125421-1-anshuman.khandual@arm.com/
