Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B671D550272
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 05:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383784AbiFRD0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 23:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbiFRD0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 23:26:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5B237032
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 20:26:35 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LQ1Sw4DW3zBrnv;
        Sat, 18 Jun 2022 11:23:12 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 18 Jun 2022 11:26:33 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 18 Jun 2022 11:26:31 +0800
Message-ID: <4371a7c9-8766-9fee-2558-e6f43f06ad19@huawei.com>
Date:   Sat, 18 Jun 2022 11:26:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v5 2/8] arm64: extable: make uaaccess helper use
 extable type EX_TYPE_UACCESS_ERR_ZERO
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
 <20220528065056.1034168-3-tongtiangen@huawei.com>
 <Yqw6TP3MhEqnQ+2o@FVFF77S0Q05N>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <Yqw6TP3MhEqnQ+2o@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/6/17 16:24, Mark Rutland 写道:
> On Sat, May 28, 2022 at 06:50:50AM +0000, Tong Tiangen wrote:
>> Currnetly, the extable type used by __arch_copy_from/to_user() is
>> EX_TYPE_FIXUP. In fact, It is more clearly to use meaningful
>> EX_TYPE_UACCESS_*.
>>
>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
>> ---
>>   arch/arm64/include/asm/asm-extable.h |  8 ++++++++
>>   arch/arm64/include/asm/asm-uaccess.h | 12 ++++++------
>>   2 files changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
>> index 56ebe183e78b..9c94ac1f082c 100644
>> --- a/arch/arm64/include/asm/asm-extable.h
>> +++ b/arch/arm64/include/asm/asm-extable.h
>> @@ -28,6 +28,14 @@
>>   	__ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_FIXUP, 0)
>>   	.endm
>>   
>> +/*
>> + * Create an exception table entry for uaccess `insn`, which will branch to `fixup`
>> + * when an unhandled fault is taken.
>> + * ex->data = ~0 means both reg_err and reg_zero is set to wzr(x31).
>> + */
>> +	.macro          _asm_extable_uaccess, insn, fixup
>> +	__ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_UACCESS_ERR_ZERO, ~0)
>> +	.endm
> 
> I'm not too keen on using `~0` here, since that also sets other bits in the
> data field, and its somewhat opaque.
> 
> How painful is it to generate the data fields as with the C version of this
> macro, so that we can pass in wzr explciitly for the two sub-fields?
> 
> Other than that, this looks good to me.
> 
> Thanks,
> Mark.

ok, will fix next version.

Thanks,
Tong.

> 
>>   /*
>>    * Create an exception table entry for `insn` if `fixup` is provided. Otherwise
>>    * do nothing.
>> diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
>> index 0557af834e03..75b211c98dea 100644
>> --- a/arch/arm64/include/asm/asm-uaccess.h
>> +++ b/arch/arm64/include/asm/asm-uaccess.h
>> @@ -61,7 +61,7 @@ alternative_else_nop_endif
>>   
>>   #define USER(l, x...)				\
>>   9999:	x;					\
>> -	_asm_extable	9999b, l
>> +	_asm_extable_uaccess	9999b, l
>>   
>>   /*
>>    * Generate the assembly for LDTR/STTR with exception table entries.
>> @@ -73,8 +73,8 @@ alternative_else_nop_endif
>>   8889:		ldtr	\reg2, [\addr, #8];
>>   		add	\addr, \addr, \post_inc;
>>   
>> -		_asm_extable	8888b,\l;
>> -		_asm_extable	8889b,\l;
>> +		_asm_extable_uaccess	8888b, \l;
>> +		_asm_extable_uaccess	8889b, \l;
>>   	.endm
>>   
>>   	.macro user_stp l, reg1, reg2, addr, post_inc
>> @@ -82,14 +82,14 @@ alternative_else_nop_endif
>>   8889:		sttr	\reg2, [\addr, #8];
>>   		add	\addr, \addr, \post_inc;
>>   
>> -		_asm_extable	8888b,\l;
>> -		_asm_extable	8889b,\l;
>> +		_asm_extable_uaccess	8888b,\l;
>> +		_asm_extable_uaccess	8889b,\l;
>>   	.endm
>>   
>>   	.macro user_ldst l, inst, reg, addr, post_inc
>>   8888:		\inst		\reg, [\addr];
>>   		add		\addr, \addr, \post_inc;
>>   
>> -		_asm_extable	8888b,\l;
>> +		_asm_extable_uaccess	8888b, \l;
>>   	.endm
>>   #endif
>> -- 
>> 2.25.1
>>
> .
