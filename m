Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE894C44BD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiBYMmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiBYMmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:42:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E93B634F;
        Fri, 25 Feb 2022 04:41:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48FBF12FC;
        Fri, 25 Feb 2022 04:41:34 -0800 (PST)
Received: from [10.57.71.82] (unknown [10.57.71.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90DCD3F5A1;
        Fri, 25 Feb 2022 04:41:30 -0800 (PST)
Subject: Re: [PATCH 2/2] perf arm-spe: Parse more SPE fields and store source
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        andrew.kilroy@arm.com, benh@kernel.crashing.org,
        james.clark@arm.com, john.garry@huawei.com, jolsa@redhat.com,
        leo.yan@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mathieu.poirier@linaro.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, will@kernel.org
References: <9266bfb6-341c-1d9c-e96f-c9f856a5ffb6@arm.com>
 <20220222192943.20137-1-alisaidi@amazon.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <46ba455e-277d-6618-f710-e92a2243898d@arm.com>
Date:   Fri, 25 Feb 2022 12:40:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220222192943.20137-1-alisaidi@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/02/2022 19:29, Ali Saidi wrote:
> Hi German & Yan,
>
> Sorry about the delay in responding.
>
>> Hi German, Ali,
>>
> [...]
>>>>>  };
>>>>>>  
>>>>>>  enum arm_spe_op_type {
>>>>>>  	ARM_SPE_LD		= 1 << 0,
>>>>>>  	ARM_SPE_ST		= 1 << 1,
>>>>>> +	ARM_SPE_LDST_EXCL	= 1 << 2,
>>>>>> +	ARM_SPE_LDST_ATOMIC	= 1 << 3,
>>>>>> +	ARM_SPE_LDST_ACQREL	= 1 << 4,
>>> Wondering if we can store this in perf_sample->flags. The values are
>>> defined in "util/event.h" (PERF_IP_*). Maybe we can extend it to allow
>>> doing "sample->flags = PERF_LDST_FLAG_LD | PERF_LDST_FLAG_ATOMIC" and
>>> such.
>>>
>>> @Leo do you think that could work?
>> Let's step back a bit and divide the decoding flow into two parts:
>> backend and frontend.
>>
>> For the backend part, we decode the SPE hardware trace data and
>> generate the SPE record in the file
>> util/arm-spe-decoder/arm-spe-decoder.c.  As we want to support
>> complete operation types, we can extend arm_spe_op_type as below:
>>
>> enum arm_spe_op_type {
>>        /* First level operation type */
>> 	ARM_SPE_OP_OTHER        = 1 << 0,
>> 	ARM_SPE_OP_LDST		= 1 << 1,
> [...]
>
> I'm OK with this approach, but perhaps instead the op type should
> just be the raw traces op-type and op-type-payload? Macros to decode
> this information are already present and extensively used in the text
> decoding of the packet. While it's a little bit harder than just picking
> a bit, the op_type is only used in a single place today outside of
> the existing textual script decoding and what would be this decoding.
> Do we forsee many more uses that would justify having to maintain

I wanted to include some of the sve/simd bits in the perf samples.

For that I would be using a few of these flags.

> the immediate format vs finding a way to unify arm_spe_pkt_desc_op_type
> to support both the text decoding and this?
>
> [...]
>> So I am just wandering if we can set the field
>> sample::data_src::mem_lock for atomic operations, like:
>>
>>    data_src.mem_op   = PERF_MEM_OP_LOAD;
>>    data_src.mem_lock = PERF_MEM_LOCK_ATOMIC;
>>
>> The field "mem_lock" is only two bits, we can consider to extend the
>> structure with an extra filed "mem_lock_ext" if it cannot meet our
>> requirement.
> These are for the LOCK instruction on x86. I don't know that we want to
> overload the meaning here. Minimally there is value in differentiating
> exclusives vs atomics.
>
>>>>>> +	ARM_SPE_BR		= 1 << 5,
>>>>>> +	ARM_SPE_BR_COND		= 1 << 6,
>>>>>> +	ARM_SPE_BR_IND		= 1 << 7,
>>> Seems like we can store BR_COND in the existing "branch-miss" event
>>> (--itrace=b) with:
>>>
>>> sample->flags = PERF_IP_FLAG_BRANCH;
>>> sample->flags |= PERF_IP_FLAG_CONDITIONAL;
>>> and/or
>>> sample->flags |= PERF_IP_FLAG_INDIRECT;
>>>
>>> PERF_IP_FLAG_INDIRECT doesn't exist yet but we can probably add it.
>> Yes, for branch samples, this makes sense for me.
> makes sense to me too.
>
> Ali
>
