Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF814D9BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242174AbiCONIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348565AbiCONIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:08:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9615F50E13;
        Tue, 15 Mar 2022 06:06:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FD031474;
        Tue, 15 Mar 2022 06:06:49 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F2313F66F;
        Tue, 15 Mar 2022 06:06:46 -0700 (PDT)
Message-ID: <0df5c352-1f0d-55f8-5d7f-e28ba33d623b@arm.com>
Date:   Tue, 15 Mar 2022 13:06:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH V4 03/10] perf: Extend branch type classification
Content-Language: en-GB
To:     Peter Zijlstra <peterz@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220315053516.431515-1-anshuman.khandual@arm.com>
 <20220315053516.431515-4-anshuman.khandual@arm.com>
 <20220315112232.GF8939@worktop.programming.kicks-ass.net>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220315112232.GF8939@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-15 11:22, Peter Zijlstra wrote:
> On Tue, Mar 15, 2022 at 11:05:09AM +0530, Anshuman Khandual wrote:
>> branch_entry.type now has ran out of space to accommodate more branch types
>> classification. This will prevent perf branch stack implementation on arm64
>> (via BRBE) to capture all available branch types. Extending this bit field
>> i.e branch_entry.type [4 bits] is not an option as it will break user space
>> ABI both for little and big endian perf tools.
>>
>> Extend branch classification with a new field branch_entry.new_type via a
>> new branch type PERF_BR_EXTEND_ABI in branch_entry.type. Perf tools which
>> could decode PERF_BR_EXTEND_ABI, will then parse branch_entry.new_type as
>> well.
>>
>> branch_entry.new_type is a 4 bit field which can hold upto 16 branch types.
>> The first three branch types will hold various generic page faults followed
>> by five architecture specific branch types, which can be overridden by the
>> platform for specific use cases. These architecture specific branch types
>> gets overridden on arm64 platform for BRBE implementation.
> 
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index 26d8f0b5ac0d..d29280adc3c4 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -255,9 +255,22 @@ enum {
>>   	PERF_BR_IRQ		= 12,	/* irq */
>>   	PERF_BR_SERROR		= 13,	/* system error */
>>   	PERF_BR_NO_TX		= 14,	/* not in transaction */
>> +	PERF_BR_EXTEND_ABI	= 15,	/* extend ABI */
>>   	PERF_BR_MAX,
>>   };
> 
> 
>>   #define PERF_SAMPLE_BRANCH_PLM_ALL \
>>   	(PERF_SAMPLE_BRANCH_USER|\
>>   	 PERF_SAMPLE_BRANCH_KERNEL|\
>> @@ -1372,7 +1385,8 @@ struct perf_branch_entry {
>>   		abort:1,    /* transaction abort */
>>   		cycles:16,  /* cycle count to last branch */
>>   		type:4,     /* branch type */
>> -		reserved:40;
>> +		new_type:4, /* additional branch type */
>> +		reserved:36;
>>   };
> 
> Hurmpf... this will effectively give us 5 bits of space for the cost of
> 8, that seems... unfortunate.
> 
> Would something like:
> 
> 		type:4,
> 		ext_type:4,
> 		reserved:36;
> 
> and have all software do:
> 
> 	type = pbe->type | (pbe->ext_type << 4);
> 
> Then old software will only know about the old types. New software on
> old kernels will add 4 0's, which is harmless, while new software on new
> kernels will get 8 bytes of type.
> 
> Would that work?

Depends how bad the effects of aliasing in existing software would be, I 
guess - e.g. new kernel outputs type 0x23 which software then interprets 
as 0x3 since it doesn't know about the extended bits. I'm guessing 
that's more likely "confusing to the user" than "catastrophically 
fatal", but it might still matter.

If software had an explicit opt-in to receiving extended types when 
requesting branch sampling in the first place we could avoid that worry, 
but then we'd need some additional complexity to sanitise records 
depending on that option :/

Robin.
