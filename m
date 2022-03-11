Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C64E4D5946
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 04:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345623AbiCKDxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiCKDxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:53:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D92D2E029;
        Thu, 10 Mar 2022 19:52:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C2FD14BF;
        Thu, 10 Mar 2022 19:52:33 -0800 (PST)
Received: from [10.163.34.78] (unknown [10.163.34.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB5193F7D8;
        Thu, 10 Mar 2022 19:52:27 -0800 (PST)
Message-ID: <b030f111-59f7-68d0-ca51-e3b81c722a9a@arm.com>
Date:   Fri, 11 Mar 2022 09:22:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 7/8] perf/tools: Extend branch type classification
Content-Language: en-US
To:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org
Cc:     suzuki.poulose@arm.com, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220309033642.144769-1-anshuman.khandual@arm.com>
 <20220309033642.144769-8-anshuman.khandual@arm.com>
 <b88268b2-97c3-4f61-44e9-fa6105d91be9@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <b88268b2-97c3-4f61-44e9-fa6105d91be9@arm.com>
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



On 3/10/22 15:46, James Clark wrote:
> 
> 
> On 09/03/2022 03:36, Anshuman Khandual wrote:
>> This updates the perf tool with generic branch type classification with new
>> ABI extender place holder i.e PERF_BR_EXTEND_ABI, the new 4 bit branch type
>> field i.e perf_branch_entry.new_type, new generic page fault related branch
>> types and some arch specific branch types as added earlier in the kernel.
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-perf-users@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  tools/include/uapi/linux/perf_event.h | 16 +++++++++++++++-
>>  tools/perf/util/branch.c              |  3 ++-
>>  2 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
>> index 26d8f0b5ac0d..d29280adc3c4 100644
>> --- a/tools/include/uapi/linux/perf_event.h
>> +++ b/tools/include/uapi/linux/perf_event.h
>> @@ -255,9 +255,22 @@ enum {
>>  	PERF_BR_IRQ		= 12,	/* irq */
>>  	PERF_BR_SERROR		= 13,	/* system error */
>>  	PERF_BR_NO_TX		= 14,	/* not in transaction */
>> +	PERF_BR_EXTEND_ABI	= 15,	/* extend ABI */
>>  	PERF_BR_MAX,
>>  };
>>  
>> +enum {
>> +	PERF_BR_NEW_FAULT_ALGN		= 0,    /* Alignment fault */
>> +	PERF_BR_NEW_FAULT_DATA		= 1,    /* Data fault */
>> +	PERF_BR_NEW_FAULT_INST		= 2,    /* Inst fault */
>> +	PERF_BR_NEW_ARCH_1		= 3,    /* Architecture specific */
>> +	PERF_BR_NEW_ARCH_2		= 4,    /* Architecture specific */
>> +	PERF_BR_NEW_ARCH_3		= 5,    /* Architecture specific */
>> +	PERF_BR_NEW_ARCH_4		= 6,    /* Architecture specific */
>> +	PERF_BR_NEW_ARCH_5		= 7,    /* Architecture specific */
>> +	PERF_BR_NEW_MAX,
>> +};
>> +
>>  #define PERF_SAMPLE_BRANCH_PLM_ALL \
>>  	(PERF_SAMPLE_BRANCH_USER|\
>>  	 PERF_SAMPLE_BRANCH_KERNEL|\
>> @@ -1372,7 +1385,8 @@ struct perf_branch_entry {
>>  		abort:1,    /* transaction abort */
>>  		cycles:16,  /* cycle count to last branch */
>>  		type:4,     /* branch type */
>> -		reserved:40;
>> +		new_type:4, /* additional branch type */
>> +		reserved:36;
>>  };
>>  
>>  union perf_sample_weight {
>> diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
>> index abc673347bee..4bd52de0527c 100644
>> --- a/tools/perf/util/branch.c
>> +++ b/tools/perf/util/branch.c
>> @@ -53,7 +53,8 @@ const char *branch_type_name(int type)
>>  		"ERET",
>>  		"IRQ",
>>  		"SERROR",
>> -		"NO_TX"
>> +		"NO_TX",
>> +		"EXTEND_ABI"
> 
> 
> Shouldn't we hide this implementation detail from users? They just want to know
> the branch type, they don't want to see the extend_abi stuff.

Right, there are two ways of looking into this. Because knowing about
this PERF_BR_EXTEND_ABI improves transparency regarding what is really
going on but on the other side, it might just overwhelm the user with
unnecessary information.

> 
> It should be possible to fix all the perf internals so that it's transparent and
> any code using or printing the branch type has some accessor that works out what
> the final type is rather than having to re-implement that logic everywhere.

Exactly, but that is something pending right now.

> 
> So I don't think adding the string "EXTEND_ABI" would be needed because it would
> never be shown.

Got it.

> 
> If we just want to discuss the new extend ABI kernel side changes then I think this
> patch can be dropped and we can do the full perf tool side implementation
> in a more complete way later.

I agree that the user space tools implementation is not complete as
mentioned in the cover letter. But both kernel and user space tools
changes should be in the same series for completeness, and to avoid
scenarios where PERF_BR_EXTEND_ABI extender followed by this new
field perf_branch_entry.new_type are supported in kernel but not
in the tools.

Once there is common agreement on the ABI extension, will implement
the perf tools side to completion.
