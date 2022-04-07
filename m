Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53B54F8196
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343943AbiDGOaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiDGOaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:30:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24911903F2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:28:07 -0700 (PDT)
Received: from kwepemi100006.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KZ3cl5TFKzdZcX;
        Thu,  7 Apr 2022 22:27:35 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100006.china.huawei.com (7.221.188.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 22:28:04 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 22:28:02 +0800
Message-ID: <9788a324-05b2-80d7-d062-4bb10cc4d0ee@huawei.com>
Date:   Thu, 7 Apr 2022 22:28:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH -next V2 4/7] arm64: add copy_from_user to machine
 check safe
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
 <20220406091311.3354723-5-tongtiangen@huawei.com>
 <Yk13VJwih44VsCGk@FVFF77S0Q05N>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <Yk13VJwih44VsCGk@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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



在 2022/4/6 19:19, Mark Rutland 写道:
> On Wed, Apr 06, 2022 at 09:13:08AM +0000, Tong Tiangen wrote:
>> Add scenarios copy_from_user to machine check safe.
>>
>> The data copied is user data and is machine check safe, so just kill
>> the user process and isolate the error page, not necessary panic.
>>
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
>> ---
>>   arch/arm64/include/asm/asm-uaccess.h | 16 ++++++++++++++++
>>   arch/arm64/lib/copy_from_user.S      | 11 ++++++-----
>>   2 files changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
>> index 0557af834e03..f31c8978e1af 100644
>> --- a/arch/arm64/include/asm/asm-uaccess.h
>> +++ b/arch/arm64/include/asm/asm-uaccess.h
>> @@ -92,4 +92,20 @@ alternative_else_nop_endif
>>   
>>   		_asm_extable	8888b,\l;
>>   	.endm
>> +
>> +	.macro user_ldp_mc l, reg1, reg2, addr, post_inc
>> +8888:		ldtr	\reg1, [\addr];
>> +8889:		ldtr	\reg2, [\addr, #8];
>> +		add	\addr, \addr, \post_inc;
>> +
>> +		_asm_extable_mc	8888b, \l;
>> +		_asm_extable_mc	8889b, \l;
>> +	.endm
>> +
>> +	.macro user_ldst_mc l, inst, reg, addr, post_inc
>> +8888:		\inst		\reg, [\addr];
>> +		add		\addr, \addr, \post_inc;
>> +
>> +		_asm_extable_mc	8888b, \l;
>> +	.endm
>>   #endif
>> diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
>> index 34e317907524..d9d7c5291871 100644
>> --- a/arch/arm64/lib/copy_from_user.S
>> +++ b/arch/arm64/lib/copy_from_user.S
>> @@ -21,7 +21,7 @@
>>    */
>>   
>>   	.macro ldrb1 reg, ptr, val
>> -	user_ldst 9998f, ldtrb, \reg, \ptr, \val
>> +	user_ldst_mc 9998f, ldtrb, \reg, \ptr, \val
>>   	.endm
>>   
>>   	.macro strb1 reg, ptr, val
>> @@ -29,7 +29,7 @@
>>   	.endm
>>   
>>   	.macro ldrh1 reg, ptr, val
>> -	user_ldst 9997f, ldtrh, \reg, \ptr, \val
>> +	user_ldst_mc 9997f, ldtrh, \reg, \ptr, \val
>>   	.endm
>>   
>>   	.macro strh1 reg, ptr, val
>> @@ -37,7 +37,7 @@
>>   	.endm
>>   
>>   	.macro ldr1 reg, ptr, val
>> -	user_ldst 9997f, ldtr, \reg, \ptr, \val
>> +	user_ldst_mc 9997f, ldtr, \reg, \ptr, \val
>>   	.endm
>>   
>>   	.macro str1 reg, ptr, val
>> @@ -45,7 +45,7 @@
>>   	.endm
>>   
>>   	.macro ldp1 reg1, reg2, ptr, val
>> -	user_ldp 9997f, \reg1, \reg2, \ptr, \val
>> +	user_ldp_mc 9997f, \reg1, \reg2, \ptr, \val
>>   	.endm
>>   
>>   	.macro stp1 reg1, reg2, ptr, val
>> @@ -62,7 +62,8 @@ SYM_FUNC_START(__arch_copy_from_user)
>>   	ret
>>   
>>   	// Exception fixups
>> -9997:	cmp	dst, dstin
>> +9997:	cbz	x0, 9998f			// Check machine check exception
>> +	cmp	dst, dstin
>>   	b.ne	9998f
> 
> If you look at the copy template, you'd see that `dstin` *is* x0.
> 
> Consier if we took a non-SEA fault. The the fixup handler will overwrite x0,
> it's likely `dst` != `dstin`, and we'll branch to the byte-by-byte copy. Or if
> we're doing something odd and mmap_min_addr is 0, we can do the wrong thing the
> other way around and *not* branch to the byte-by-byte copy when we should.
> 
> So this is at best confusing, but likely broken too.
> 
> Thanks,
> Mark.

OK, missing that, will be fixed in next verison.

Thanks,
Tong.

> 
>>   	// Before being absolutely sure we couldn't copy anything, try harder
>>   USER(9998f, ldtrb tmp1w, [srcin])
>> -- 
>> 2.18.0.huawei.25
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> .
