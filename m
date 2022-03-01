Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98164C8A0D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbiCAK4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiCAK4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:56:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 548C06582F;
        Tue,  1 Mar 2022 02:55:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8396ED1;
        Tue,  1 Mar 2022 02:55:27 -0800 (PST)
Received: from [10.57.71.121] (unknown [10.57.71.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B2333F73D;
        Tue,  1 Mar 2022 02:55:24 -0800 (PST)
Subject: Re: [PATCH 2/2] perf arm-spe: Parse more SPE fields and store source
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Ali Saidi <alisaidi@amazon.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, james.clark@arm.com,
        john.garry@huawei.com, jolsa@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
References: <b1b3697d-4a0a-d041-5cbd-e08fec9e658c@arm.com>
 <20220128210245.4628-1-alisaidi@amazon.com>
 <7eca7a1d-a5a2-2aab-b3cf-5d83cb8ccf4f@arm.com>
 <20220212041927.GA763461@leoy-ThinkPad-X240s>
 <9266bfb6-341c-1d9c-e96f-c9f856a5ffb6@arm.com>
 <20220227132019.GA107053@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <923cb8b4-f854-e7bb-9bb3-e5b871f64d5d@arm.com>
Date:   Tue, 1 Mar 2022 10:54:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220227132019.GA107053@leoy-ThinkPad-X240s>
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

Hi Leo,

Thanks for taking the time, and sorry for the late reply

On 27/02/2022 13:20, Leo Yan wrote:
> On Mon, Feb 21, 2022 at 08:41:43PM +0000, German Gomez wrote:
>
> [...]
>
>> Some comments:
>>
>> # ARM_SPE_OP_ATOMIC
>>
>> This might be a hack, but can we not represent it as both LD&SR as the
>> atomic op would combine both?
>>
>> data_src.mem_op = PERF_MEM_OP_LOAD | PERF_MEM_OP_STORE;
> BTH, I don't understand well for this question, but let me explain a
> bit:
>
> We cannot use 'LOAD | STORE' to present the atomic operation.  Please
> see Armv8 ARM section D10.2.7 Operation Type packet, it would give out
> more details.  Atomic operation is an extra attribution for a load or
> store operations, it could be an atomic load or store, or
> load-acquire/store-release instructions, or
> load-exclusive/store-exclusive instructions.

I will check, thanks.

My thinking was that atomics perform some load-modify-store operation
hence why I suggested combining LOAD&STORE flags. But I admit didn't try
running the instructions myself so I didn't check the actual records.

> [...]
>
>> # ARM_SPE_OP_SVE_SG
>>
>> (I'm sorry if this is too far out of scope of the original patch. Let
>> me know if you would prefer to discuss it on a separate channel)
>>
>> On a separate note, I'm also looking at incorporating some of the SVE
>> bits in the perf samples.
>>
>> For this, do you think it makes sense to have two mem_* categories in
>> perf_mem_data_src:
>>
>> mem_vector (2 bits)
>> - simd
>> - other (SVE in arm64)
> I think we can define below vector types:
>
> PERF_MEM_VECTOR_SIMD
> PERF_MEM_VECTOR_SVE
>
> The tricky thing is "other"... Based on the description for "Operation
> Type packet payload (Other)" in the Armv8 Arm, I think we even need to
> add an extra operation type PERF_MEM_OP_OTHER and assign it to
> data_src.mem_op field.
>
>> mem_src (1 bit)
>> - sparse (scatter/gather loads/stores in SVE, as well as simd)
> How about the naming "mem_attr" for new field and define two
> attributions:
>
> PERF_MEM_ATTR_SPARSE  -> Gather/Scatter operation
> PERF_MEM_ATTR_PRED    -> Predicated operation
>
> Just remind, we cannot only approve within Arm related developers,
> it's good to seek more wider review from other Arch developers when
> you send new patch set.

Agree. On second thought, the mention of sve seems very arch-specific
for this...

Recently the idea of adding arch-specific flags to the branch entries
was mentioned in [1]. Perhaps we could suggest something similar for
this. Or leave simd/sve as a perf-tool-only feature for now.

[1] https://lore.kernel.org/all/Ygv4cmO%2Fzb3qO48q@robh.at.kernel.org/

>
> Thanks,
> Leo
