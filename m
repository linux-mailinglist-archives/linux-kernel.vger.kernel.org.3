Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A49452CC91
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiESHKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbiESHJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:09:29 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB55267D09
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:09:27 -0700 (PDT)
Received: from kwepemi100016.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L3gtC0p3lz1JC6B;
        Thu, 19 May 2022 15:08:03 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100016.china.huawei.com (7.221.188.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 15:09:25 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 15:09:23 +0800
Message-ID: <b12c9088-f86c-60a2-6cf8-54823867e8fd@huawei.com>
Date:   Thu, 19 May 2022 15:09:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v4 6/7] arm64: add {get, put}_user to machine check
 safe
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
References: <20220420030418.3189040-1-tongtiangen@huawei.com>
 <20220420030418.3189040-7-tongtiangen@huawei.com> <Yn57sGpZPo90EXkE@lakrids>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <Yn57sGpZPo90EXkE@lakrids>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/13 23:39, Mark Rutland 写道:
> On Wed, Apr 20, 2022 at 03:04:17AM +0000, Tong Tiangen wrote:
>> Add {get, put}_user() to machine check safe.
>>
>> If get/put fail due to hardware memory error, only the relevant processes
>> are affected, so killing the user process and isolate the user page with
>> hardware memory errors is a more reasonable choice than kernel panic.
>>
>> Add new extable type EX_TYPE_UACCESS_MC_ERR_ZERO which can be used for
>> uaccess that can be recovered from hardware memory errors. The difference
>> from EX_TYPE_UACCESS_MC is that this type also sets additional two target
>> register which save error code and value needs to be set zero.
> 
> Why does this need to be in any way distinct from the existing
> EX_TYPE_UACCESS_ERR_ZERO ?
> 
> Other than the case where we currently (ab)use that for
> copy_{to,from}_kernel_nofault(), where do we *not* want to use
> EX_TYPE_UACCESS_ERR_ZERO and *not* recover from a memory error?
> 
> Thanks,
> Mark.

There are some cases (futex/__user_cache_maint()/__user_swpX_asm()) 
using EX_TYPE_UACCESS_ERR_ZERO, for these cases, whether to restore is 
not yet determined, let's discuss in patch 3/7.

Thanks,
Tong.

> 
>>
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
>> ---
>>   arch/arm64/include/asm/asm-extable.h | 14 ++++++++++++++
>>   arch/arm64/include/asm/uaccess.h     |  4 ++--
>>   arch/arm64/mm/extable.c              |  4 ++++
>>   3 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
>> index 75b2c00e9523..80410899a9ad 100644
>> --- a/arch/arm64/include/asm/asm-extable.h
>> +++ b/arch/arm64/include/asm/asm-extable.h
>> @@ -13,6 +13,7 @@
>>   
>>   /* _MC indicates that can fixup from machine check errors */
>>   #define EX_TYPE_UACCESS_MC		5
>> +#define EX_TYPE_UACCESS_MC_ERR_ZERO	6
>>   
>>   #ifdef __ASSEMBLY__
>>   
>> @@ -78,6 +79,15 @@
>>   #define EX_DATA_REG(reg, gpr)						\
>>   	"((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
>>   
>> +#define _ASM_EXTABLE_UACCESS_MC_ERR_ZERO(insn, fixup, err, zero)		\
>> +	__DEFINE_ASM_GPR_NUMS							\
>> +	__ASM_EXTABLE_RAW(#insn, #fixup,					\
>> +			  __stringify(EX_TYPE_UACCESS_MC_ERR_ZERO),		\
>> +			  "("							\
>> +			    EX_DATA_REG(ERR, err) " | "				\
>> +			    EX_DATA_REG(ZERO, zero)				\
>> +			  ")")
>> +
>>   #define _ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, zero)		\
>>   	__DEFINE_ASM_GPR_NUMS						\
>>   	__ASM_EXTABLE_RAW(#insn, #fixup, 				\
>> @@ -90,6 +100,10 @@
>>   #define _ASM_EXTABLE_UACCESS_ERR(insn, fixup, err)			\
>>   	_ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, wzr)
>>   
>> +
>> +#define _ASM_EXTABLE_UACCESS_MC_ERR(insn, fixup, err)			\
>> +	_ASM_EXTABLE_UACCESS_MC_ERR_ZERO(insn, fixup, err, wzr)
>> +
>>   #define EX_DATA_REG_DATA_SHIFT	0
>>   #define EX_DATA_REG_DATA	GENMASK(4, 0)
>>   #define EX_DATA_REG_ADDR_SHIFT	5
>> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
>> index e8dce0cc5eaa..e41b47df48b0 100644
>> --- a/arch/arm64/include/asm/uaccess.h
>> +++ b/arch/arm64/include/asm/uaccess.h
>> @@ -236,7 +236,7 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
>>   	asm volatile(							\
>>   	"1:	" load "	" reg "1, [%2]\n"			\
>>   	"2:\n"								\
>> -	_ASM_EXTABLE_UACCESS_ERR_ZERO(1b, 2b, %w0, %w1)			\
>> +	_ASM_EXTABLE_UACCESS_MC_ERR_ZERO(1b, 2b, %w0, %w1)		\
>>   	: "+r" (err), "=&r" (x)						\
>>   	: "r" (addr))
>>   
>> @@ -325,7 +325,7 @@ do {									\
>>   	asm volatile(							\
>>   	"1:	" store "	" reg "1, [%2]\n"			\
>>   	"2:\n"								\
>> -	_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w0)				\
>> +	_ASM_EXTABLE_UACCESS_MC_ERR(1b, 2b, %w0)			\
>>   	: "+r" (err)							\
>>   	: "r" (x), "r" (addr))
>>   
>> diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
>> index 525876c3ebf4..1023ccdb2f89 100644
>> --- a/arch/arm64/mm/extable.c
>> +++ b/arch/arm64/mm/extable.c
>> @@ -88,6 +88,7 @@ bool fixup_exception(struct pt_regs *regs)
>>   	case EX_TYPE_BPF:
>>   		return ex_handler_bpf(ex, regs);
>>   	case EX_TYPE_UACCESS_ERR_ZERO:
>> +	case EX_TYPE_UACCESS_MC_ERR_ZERO:
>>   		return ex_handler_uaccess_err_zero(ex, regs);
>>   	case EX_TYPE_LOAD_UNALIGNED_ZEROPAD:
>>   		return ex_handler_load_unaligned_zeropad(ex, regs);
>> @@ -107,6 +108,9 @@ bool fixup_exception_mc(struct pt_regs *regs)
>>   	switch (ex->type) {
>>   	case EX_TYPE_UACCESS_MC:
>>   		return ex_handler_uaccess_type(ex, regs, FIXUP_TYPE_MC);
>> +	case EX_TYPE_UACCESS_MC_ERR_ZERO:
>> +		return ex_handler_uaccess_err_zero(ex, regs);
>> +
>>   	}
>>   
>>   	return false;
>> -- 
>> 2.25.1
>>
> .
