Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C995503C3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 11:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiFRJ1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 05:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiFRJ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 05:27:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BACA20BCA
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 02:27:50 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LQ9XH59BYzYrnK;
        Sat, 18 Jun 2022 17:26:39 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 18 Jun 2022 17:27:47 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 18 Jun 2022 17:27:46 +0800
Message-ID: <a26c74eb-76c2-570a-2f82-503c812dc0f0@huawei.com>
Date:   Sat, 18 Jun 2022 17:27:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v5 7/8] arm64: add uaccess to machine check safe
To:     Mark Rutland <mark.rutland@arm.com>
CC:     James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
References: <20220528065056.1034168-1-tongtiangen@huawei.com>
 <20220528065056.1034168-8-tongtiangen@huawei.com>
 <YqxELtYkqQNibHaX@FVFF77S0Q05N>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <YqxELtYkqQNibHaX@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/6/17 17:06, Mark Rutland 写道:
> On Sat, May 28, 2022 at 06:50:55AM +0000, Tong Tiangen wrote:
>> If user access fail due to hardware memory error, only the relevant
>> processes are affected, so killing the user process and isolate the
>> error page with hardware memory errors is a more reasonable choice
>> than kernel panic.
>>
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> 
>> ---
>>   arch/arm64/lib/copy_from_user.S | 8 ++++----
>>   arch/arm64/lib/copy_to_user.S   | 8 ++++----
> 
> All of these changes are to the *kernel* accesses performed as part of copy
> to/from user, and have nothing to do with userspace, so it does not make sense
> to mark these as UACCESS.

You have a point. so there is no need to modify copy_from/to_user.S in 
this patch set.

> 
> Do we *actually* need to recover from failues on these accesses? Looking at
> _copy_from_user(), the kernel will immediately follow this up with a memset()
> to the same address which will be fatal anyway, so this is only punting the
> failure for a few instructions.

If recovery success, The task will be killed and there will be no 
subsequent memset().

> 
> If we really need to recover from certain accesses to kernel memory we should
> add a new EX_TYPE_KACCESS_ERR_ZERO_MC or similar, but we need a strong
> rationale as to why that's useful. As things stand I do not beleive it makes
> sense for copy to/from user specifically.
> 
>>   arch/arm64/mm/extable.c         | 8 ++++----
>>   3 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
>> index 34e317907524..402dd48a4f93 100644
>> --- a/arch/arm64/lib/copy_from_user.S
>> +++ b/arch/arm64/lib/copy_from_user.S
>> @@ -25,7 +25,7 @@
>>   	.endm
>>   
>>   	.macro strb1 reg, ptr, val
>> -	strb \reg, [\ptr], \val
>> +	USER(9998f, strb \reg, [\ptr], \val)
>>   	.endm
>>   
>>   	.macro ldrh1 reg, ptr, val
>> @@ -33,7 +33,7 @@
>>   	.endm
>>   
>>   	.macro strh1 reg, ptr, val
>> -	strh \reg, [\ptr], \val
>> +	USER(9998f, strh \reg, [\ptr], \val)
>>   	.endm
>>   
>>   	.macro ldr1 reg, ptr, val
>> @@ -41,7 +41,7 @@
>>   	.endm
>>   
>>   	.macro str1 reg, ptr, val
>> -	str \reg, [\ptr], \val
>> +	USER(9998f, str \reg, [\ptr], \val)
>>   	.endm
>>   
>>   	.macro ldp1 reg1, reg2, ptr, val
>> @@ -49,7 +49,7 @@
>>   	.endm
>>   
>>   	.macro stp1 reg1, reg2, ptr, val
>> -	stp \reg1, \reg2, [\ptr], \val
>> +	USER(9998f, stp \reg1, \reg2, [\ptr], \val)
>>   	.endm
>>   
>>   end	.req	x5
>> diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
>> index 802231772608..4134bdb3a8b0 100644
>> --- a/arch/arm64/lib/copy_to_user.S
>> +++ b/arch/arm64/lib/copy_to_user.S
>> @@ -20,7 +20,7 @@
>>    *	x0 - bytes not copied
>>    */
>>   	.macro ldrb1 reg, ptr, val
>> -	ldrb  \reg, [\ptr], \val
>> +	USER(9998f, ldrb  \reg, [\ptr], \val)
>>   	.endm
>>   
>>   	.macro strb1 reg, ptr, val
>> @@ -28,7 +28,7 @@
>>   	.endm
>>   
>>   	.macro ldrh1 reg, ptr, val
>> -	ldrh  \reg, [\ptr], \val
>> +	USER(9998f, ldrh  \reg, [\ptr], \val)
>>   	.endm
>>   
>>   	.macro strh1 reg, ptr, val
>> @@ -36,7 +36,7 @@
>>   	.endm
>>   
>>   	.macro ldr1 reg, ptr, val
>> -	ldr \reg, [\ptr], \val
>> +	USER(9998f, ldr \reg, [\ptr], \val)
>>   	.endm
>>   
>>   	.macro str1 reg, ptr, val
>> @@ -44,7 +44,7 @@
>>   	.endm
>>   
>>   	.macro ldp1 reg1, reg2, ptr, val
>> -	ldp \reg1, \reg2, [\ptr], \val
>> +	USER(9998f, ldp \reg1, \reg2, [\ptr], \val)
>>   	.endm
>>   
>>   	.macro stp1 reg1, reg2, ptr, val
>> diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
>> index c301dcf6335f..8ca8d9639f9f 100644
>> --- a/arch/arm64/mm/extable.c
>> +++ b/arch/arm64/mm/extable.c
>> @@ -86,10 +86,10 @@ bool fixup_exception_mc(struct pt_regs *regs)
>>   	if (!ex)
>>   		return false;
>>   
>> -	/*
>> -	 * This is not complete, More Machine check safe extable type can
>> -	 * be processed here.
>> -	 */
>> +	switch (ex->type) {
>> +	case EX_TYPE_UACCESS_ERR_ZERO:
>> +		return ex_handler_uaccess_err_zero(ex, regs);
>> +	}
> 
> This addition specifically makes sense to me, so can you split this into a separate patch?

According to my understanding of the above, only the modification of 
extable.c is retained.

So what do you mean which part is made into a separate patch?

Thanks,
Tong.
> 
> Thanks,
> Mark.
> 
> .
