Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAF94BEBFF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiBUUnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:43:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiBUUm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:42:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4330E237DC;
        Mon, 21 Feb 2022 12:42:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E74821063;
        Mon, 21 Feb 2022 12:42:34 -0800 (PST)
Received: from [10.1.39.143] (e127744.cambridge.arm.com [10.1.39.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 864133F66F;
        Mon, 21 Feb 2022 12:42:31 -0800 (PST)
Subject: Re: [PATCH 2/2] perf arm-spe: Parse more SPE fields and store source
To:     Leo Yan <leo.yan@linaro.org>, Ali Saidi <alisaidi@amazon.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        andrew.kilroy@arm.com, benh@kernel.crashing.org,
        james.clark@arm.com, john.garry@huawei.com, jolsa@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
References: <b1b3697d-4a0a-d041-5cbd-e08fec9e658c@arm.com>
 <20220128210245.4628-1-alisaidi@amazon.com>
 <7eca7a1d-a5a2-2aab-b3cf-5d83cb8ccf4f@arm.com>
 <20220212041927.GA763461@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <9266bfb6-341c-1d9c-e96f-c9f856a5ffb6@arm.com>
Date:   Mon, 21 Feb 2022 20:41:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220212041927.GA763461@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo, Ali,

On 12/02/2022 04:19, Leo Yan wrote:
> Hi German, Ali,
>
> On Fri, Feb 11, 2022 at 04:31:40PM +0000, German Gomez wrote:
>> Hi Ali,
>>
>> [...]
> Let's step back a bit and divide the decoding flow into two parts:
> backend and frontend.

Sorry for derailing the conversation.

(I made some additional comments on the generation of samples below)

> enum arm_spe_op_type {
>         /* First level operation type */
> 	ARM_SPE_OP_OTHER        = 1 << 0,
> 	ARM_SPE_OP_LDST		= 1 << 1,
> 	ARM_SPE_OP_BRANCH_ERET  = 1 << 2,
>
>         /* Second level operation type for OTHER */
>         ARM_SPE_OP_SVE_OTHER    = 1 << 16,
>         ARM_SPE_OP_SVE_FP       = 1 << 17,
>         ARM_SPE_OP_SVE_PRED     = 1 << 18,
>
>         /* Second level operation type for LDST */
>         ARM_SPE_OP_LD           = 1 << 16,
>         ARM_SPE_OP_ST           = 1 << 17,
>         ARM_SPE_OP_ATOMIC       = 1 << 18,
>         ARM_SPE_OP_EXCL         = 1 << 19,
>         ARM_SPE_OP_AR           = 1 << 20,
>         ARM_SPE_OP_SIMD_FP      = 1 << 21,
>         ARM_SPE_OP_GP_REG       = 1 << 22,
>         ARM_SPE_OP_UNSPEC_REG   = 1 << 23,
>         ARM_SPE_OP_NV_SYSREG    = 1 << 24,
>         ARM_SPE_OP_SVE_PRED     = 1 << 25,
>         ARM_SPE_OP_SVE_SG       = 1 << 26,
>
>         /* Second level operation type for BRANCH_ERET */
>         ARM_SPE_OP_BR_COND      = 1 << 16,
>         ARM_SPE_OP_BR_INDIRECT  = 1 << 17,
> };
>
> IIUC, Ali suggested to directly reuse packet format to express
> operation type and don't need to redefine the operation types like
> above structure arm_spe_op_type.  I personally bias to convert the raw
> packet format to more readable format, a benefit is this would give
> us more readable code.

I personally like this method as well

>
> For the frontend, we need to convert Arm SPE record to samples.
> We can explore two fields: sample::flags and sample::data_src, for
> load/store related operations, I perfer we can fill more complete
> info in field sample::data_src and extend the definitions for
> perf_mem_data_src; for branch operations, we can fill sample::flags.
>
> So I am just wandering if we can set the field
> sample::data_src::mem_lock for atomic operations, like:
>
>     data_src.mem_op   = PERF_MEM_OP_LOAD;
>     data_src.mem_lock = PERF_MEM_LOCK_ATOMIC;
>
> The field "mem_lock" is only two bits, we can consider to extend the
> structure with an extra filed "mem_lock_ext" if it cannot meet our
> requirement.

Indeed it makes more sense to use data_src as much as possible. Thanks
for pointing that out.

Some comments:

# ARM_SPE_OP_ATOMIC

  This might be a hack, but can we not represent it as both LD&SR as the
  atomic op would combine both?

  data_src.mem_op = PERF_MEM_OP_LOAD | PERF_MEM_OP_STORE;

# ARM_SPE_OP_EXCL (instructions ldxr/stxr)

  x86 doesn't seem to have similar instructions with similar semantics
  (please correct me if I'm wrong). For this arch, PERF_MEM_LOCK_LOCK
  probably suffices.

  PPC seems to have similar instructions to arm64 (lwarx/stwcx). I don't
  know if they also have instructions with same semantics as x86.

  I think it makes sense to have a PERF_MEM_LOCK_EXCL. If not, reusing
  PERF_MEM_LOCK_LOCK is the quicker alternative.

# ARM_SPE_OP_SVE_SG

  (I'm sorry if this is too far out of scope of the original patch. Let
  me know if you would prefer to discuss it on a separate channel)

  On a separate note, I'm also looking at incorporating some of the SVE
  bits in the perf samples.
 
  For this, do you think it makes sense to have two mem_* categories in
  perf_mem_data_src:

  mem_vector (2 bits)
    - simd
    - other (SVE in arm64)

  mem_src (1 bit)
    - sparse (scatter/gather loads/stores in SVE, as well as simd)

---
Thanks,
German

>>>>> +	ARM_SPE_BR		= 1 << 5,
>>>>> +	ARM_SPE_BR_COND		= 1 << 6,
>>>>> +	ARM_SPE_BR_IND		= 1 << 7,
>> Seems like we can store BR_COND in the existing "branch-miss" event
>> (--itrace=b) with:
>>
>> sample->flags = PERF_IP_FLAG_BRANCH;
>> sample->flags |= PERF_IP_FLAG_CONDITIONAL;
>> and/or
>> sample->flags |= PERF_IP_FLAG_INDIRECT;
>>
>> PERF_IP_FLAG_INDIRECT doesn't exist yet but we can probably add it.
> Yes, for branch samples, this makes sense for me.
>
> Thanks,
> Leo
