Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890F64F81EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241907AbiDGOk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344124AbiDGOkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:40:25 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08992163E3C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:38:23 -0700 (PDT)
Received: from kwepemi100004.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KZ3rL3S5qz1HBbG;
        Thu,  7 Apr 2022 22:37:38 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100004.china.huawei.com (7.221.188.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 22:38:06 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 22:38:05 +0800
Message-ID: <ac80045b-24f0-a163-ea96-be0d01c48d29@huawei.com>
Date:   Thu, 7 Apr 2022 22:38:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH -next V2 5/7] arm64: add get_user to machine check
 safe
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220406091311.3354723-1-tongtiangen@huawei.com>
 <20220406091311.3354723-6-tongtiangen@huawei.com>
 <Yk14AwR92MX0LKqZ@FVFF77S0Q05N>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <Yk14AwR92MX0LKqZ@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/4/6 19:22, Mark Rutland 写道:
> On Wed, Apr 06, 2022 at 09:13:09AM +0000, Tong Tiangen wrote:
>> Add scenarios get_user to machine check safe. The processing of
>> EX_TYPE_UACCESS_ERR_ZERO and EX_TYPE_UACCESS_ERR_ZERO_UCE_RECOVERY is same
>> and both return -EFAULT.
> 
> Which uaccess cases do we expect to *not* be recoverable?
> 
> Naively I would assume that if we're going to treat a memory error on a uaccess
> as fatal to userspace we should be able to do that for *any* uacesses.
> 
> The commit message should explain why we need the distinction between a
> recoverable uaccess and a non-recoverable uaccess.
> 
> Thanks,
> Mark.
> 

Currently, any memory error consumed in kernel mode will lead to panic
(do_sea()).

My idea is that not all memory errors consumed in kernel mode are fatal,
such as copy_ from_ user/get_ user is a memory error consumed when
reading user data in the process context. In this case, we can not let 
the kernel panic, just kill the process without affecting the operation
of the system.

However, not all uaccess can be recovered without affecting the normal
operation of the system. The key is not whether it is uaccess, but 
whether there are key data affecting the normal operation of the system 
in the read page.

Thanks,
Tong.


>>
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
>> ---
>>   arch/arm64/include/asm/asm-extable.h | 14 +++++++++++++-
>>   arch/arm64/include/asm/uaccess.h     |  2 +-
>>   arch/arm64/mm/extable.c              |  1 +
>>   3 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
>> index 74d1db74fd86..bfc2d224cbae 100644
>> --- a/arch/arm64/include/asm/asm-extable.h
>> +++ b/arch/arm64/include/asm/asm-extable.h
>> @@ -10,8 +10,11 @@
>>   
>>   /* _MC indicates that can fixup from machine check errors */
>>   #define EX_TYPE_FIXUP_MC		5
>> +#define EX_TYPE_UACCESS_ERR_ZERO_MC	6
>>   
>> -#define IS_EX_TYPE_MC(type) (type == EX_TYPE_FIXUP_MC)
>> +#define IS_EX_TYPE_MC(type)			\
>> +	(type == EX_TYPE_FIXUP_MC ||		\
>> +	 type == EX_TYPE_UACCESS_ERR_ZERO_MC)
>>   
>>   #ifdef __ASSEMBLY__
>>   
>> @@ -77,6 +80,15 @@
>>   #define EX_DATA_REG(reg, gpr)						\
>>   	"((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
>>   
>> +#define _ASM_EXTABLE_UACCESS_ERR_ZERO_MC(insn, fixup, err, zero)		\
>> +	__DEFINE_ASM_GPR_NUMS							\
>> +	__ASM_EXTABLE_RAW(#insn, #fixup,					\
>> +			  __stringify(EX_TYPE_UACCESS_ERR_ZERO_MC),		\
>> +			  "("							\
>> +			    EX_DATA_REG(ERR, err) " | "				\
>> +			    EX_DATA_REG(ZERO, zero)				\
>> +			  ")")
>> +
>>   #define _ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, zero)		\
>>   	__DEFINE_ASM_GPR_NUMS						\
>>   	__ASM_EXTABLE_RAW(#insn, #fixup, 				\
>> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
>> index e8dce0cc5eaa..24b662407fbd 100644
>> --- a/arch/arm64/include/asm/uaccess.h
>> +++ b/arch/arm64/include/asm/uaccess.h
>> @@ -236,7 +236,7 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
>>   	asm volatile(							\
>>   	"1:	" load "	" reg "1, [%2]\n"			\
>>   	"2:\n"								\
>> -	_ASM_EXTABLE_UACCESS_ERR_ZERO(1b, 2b, %w0, %w1)			\
>> +	_ASM_EXTABLE_UACCESS_ERR_ZERO_MC(1b, 2b, %w0, %w1)		\
>>   	: "+r" (err), "=&r" (x)						\
>>   	: "r" (addr))
>>   
>> diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
>> index f1134c88e849..7c05f8d2bce0 100644
>> --- a/arch/arm64/mm/extable.c
>> +++ b/arch/arm64/mm/extable.c
>> @@ -95,6 +95,7 @@ bool fixup_exception(struct pt_regs *regs, unsigned int esr)
>>   	case EX_TYPE_BPF:
>>   		return ex_handler_bpf(ex, regs);
>>   	case EX_TYPE_UACCESS_ERR_ZERO:
>> +	case EX_TYPE_UACCESS_ERR_ZERO_MC:
>>   		return ex_handler_uaccess_err_zero(ex, regs);
>>   	case EX_TYPE_LOAD_UNALIGNED_ZEROPAD:
>>   		return ex_handler_load_unaligned_zeropad(ex, regs);
>> -- 
>> 2.18.0.huawei.25
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> .
