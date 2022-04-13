Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728C64FEFE6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiDMGia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiDMGi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:38:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADA24EDCF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:36:06 -0700 (PDT)
Received: from kwepemi100017.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KdXq727WyzFpq1;
        Wed, 13 Apr 2022 14:33:39 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100017.china.huawei.com (7.221.188.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 14:36:03 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 14:36:02 +0800
Message-ID: <eb3ab2e5-781f-9e46-60c1-8af157b0f9a5@huawei.com>
Date:   Wed, 13 Apr 2022 14:36:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH -next V3 4/6] arm64: add copy_{to, from}_user to
 machine check safe
To:     Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>
References: <20220412072552.2526871-1-tongtiangen@huawei.com>
 <20220412072552.2526871-5-tongtiangen@huawei.com>
 <38c6d4b5-a3db-5c3e-02e7-39875edb3476@arm.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <38c6d4b5-a3db-5c3e-02e7-39875edb3476@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/4/13 1:08, Robin Murphy 写道:
> On 12/04/2022 8:25 am, Tong Tiangen wrote:
> [...]
>> diff --git a/arch/arm64/include/asm/asm-uaccess.h 
>> b/arch/arm64/include/asm/asm-uaccess.h
>> index 0557af834e03..bb17f0829042 100644
>> --- a/arch/arm64/include/asm/asm-uaccess.h
>> +++ b/arch/arm64/include/asm/asm-uaccess.h
>> @@ -92,4 +92,20 @@ alternative_else_nop_endif
>>           _asm_extable    8888b,\l;
>>       .endm
>> +
>> +    .macro user_ldp_mc l, reg1, reg2, addr, post_inc
>> +8888:        ldtr    \reg1, [\addr];
>> +8889:        ldtr    \reg2, [\addr, #8];
>> +        add    \addr, \addr, \post_inc;
>> +
>> +        _asm_extable_uaccess_mc    8888b, \l;
>> +        _asm_extable_uaccess_mc    8889b, \l;
>> +    .endm
> 
> You're replacing the only user of this, so please just 
> s/_asm_extable/_asm_extable_uaccess_mc/ in the existing macro and save 
> the rest of the churn.

Agreed, *user_ldp* -- This name has clearly explained the scences where 
this macro is used. It is more appropriate to modify it directly.

> 
> Furthermore, how come you're not similarly updating user_stp, given that 
> you *are* updating the other stores in copy_to_user?
> 
>> +
>> +    .macro user_ldst_mc l, inst, reg, addr, post_inc
>> +8888:        \inst        \reg, [\addr];
>> +        add        \addr, \addr, \post_inc;
>> +
>> +        _asm_extable_uaccess_mc    8888b, \l;
>> +    .endm
> 
> Similarly, I think we can just update user_ldst itself. The two 
> instances that you're not replacing here are bogus anyway, and deserve 
> to be fixed with the patch below first.

OK, great thanks. will do next version.

> 
> [...]
>> @@ -62,7 +63,11 @@ SYM_FUNC_START(__arch_copy_from_user)
>>       ret
>>       // Exception fixups
>> -9997:    cmp    dst, dstin
>> +9997:    mrs esr, esr_el1            // Check exception first
>> +    and esr, esr, #ESR_ELx_FSC
>> +    cmp esr, #ESR_ELx_FSC_EXTABT
> 
> Should we be checking EC to make sure it's a data abort - and thus FSC 
> is valid - in the first place? I'm a little fuzzy on all the possible 
> paths into fixup_exception(), and it's not entirely obvious whether this 
> is actually safe or not.
> 
> Thanks,
> Robin.

I think checking EC here is more rigorous in code logic and it's doesn't 
appear to be harmful.

It is really not appropriate to check the ESR at this stage (it has been 
checked where the exception processing starts). At present, I haven't 
thought of a better way. If anyone has a better way, please reply to me :)

Thanks Robin.
Tong.

> 
> ----->8-----
> Subject: [PATCH] arm64: mte: Clean up user tag accessors
> 
> Invoking user_ldst to explicitly add a post-increment of 0 is silly.
> Just use a normal USER() annotation and save the redundant instruction.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   arch/arm64/lib/mte.S | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
> index 8590af3c98c0..eeb9e45bcce8 100644
> --- a/arch/arm64/lib/mte.S
> +++ b/arch/arm64/lib/mte.S
> @@ -93,7 +93,7 @@ SYM_FUNC_START(mte_copy_tags_from_user)
>       mov    x3, x1
>       cbz    x2, 2f
>   1:
> -    user_ldst 2f, ldtrb, w4, x1, 0
> +USER(2f, ldtrb    w4, [x1])
>       lsl    x4, x4, #MTE_TAG_SHIFT
>       stg    x4, [x0], #MTE_GRANULE_SIZE
>       add    x1, x1, #1
> @@ -120,7 +120,7 @@ SYM_FUNC_START(mte_copy_tags_to_user)
>   1:
>       ldg    x4, [x1]
>       ubfx    x4, x4, #MTE_TAG_SHIFT, #MTE_TAG_SIZE
> -    user_ldst 2f, sttrb, w4, x0, 0
> +USER(2f, sttrb    w4, [x0])
>       add    x0, x0, #1
>       add    x1, x1, #MTE_GRANULE_SIZE
>       subs    x2, x2, #1
