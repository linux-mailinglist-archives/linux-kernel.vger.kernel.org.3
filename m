Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2428048436A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiADOcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:32:21 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:58107 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231733AbiADOcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:32:20 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V0xwPGf_1641306736;
Received: from 192.168.193.151(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V0xwPGf_1641306736)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Jan 2022 22:32:17 +0800
Subject: Re: [PATCH] [RFC] aarch64: scs: reload shadow call stack in user
 exception entry
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, samitolvanen@google.com,
        maz@kernel.org, joey.gouly@arm.com, pcc@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20211228010604.109572-1-ashimida@linux.alibaba.com>
 <YdQkM8IlonhEhU/R@FVFF77S0Q05N>
From:   Dan Li <ashimida@linux.alibaba.com>
Message-ID: <4d79d1e0-8320-4d9f-d847-ac83032c71df@linux.alibaba.com>
Date:   Tue, 4 Jan 2022 06:32:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YdQkM8IlonhEhU/R@FVFF77S0Q05N>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/22 2:40 AM, Mark Rutland wrote:
> Hi,
> 
> On Mon, Dec 27, 2021 at 05:06:04PM -0800, Dan Li wrote:
>> When el0 exception occurs, kernel_entry/exit will load/save tsk->scs_sp
>> to ensure scs working properly. AFAIK, the SCS offset should always be
>> 0 at this time.
>>
>> Is it reasonable to reload x18 to scs_base directly in kernel_entry
>> here, or am I missing something?
>>
>> Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
> 
> AFAICT the saving here is just that we avoid storing the SCS SP upon return to
> EL0, and I suspect that in practice that's not measureable.
> 
> So without numbers to show otherwise, I'd prefer to leave this as-is, though I
> agree that this patch should work.  If we do want to change this, I think we
> need a comment in the `kernel_exit` path to pair with the `scs_load` in
> `kernel_entry`.
> 
> Thanks,
> Mark.
>
Yes, there is only one instruction saved here, which should have a
minimal impact on performance.
The current code is also good for me :)

Thanks,
Dan.

>> ---
>>   arch/arm64/include/asm/scs.h | 7 +++++++
>>   arch/arm64/kernel/entry.S    | 3 +--
>>   2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
>> index 8297bccf0784..2bc0d0575e75 100644
>> --- a/arch/arm64/include/asm/scs.h
>> +++ b/arch/arm64/include/asm/scs.h
>> @@ -9,6 +9,10 @@
>>   #ifdef CONFIG_SHADOW_CALL_STACK
>>   	scs_sp	.req	x18
>>   
>> +	.macro scs_reload tsk
>> +	ldr	scs_sp, [\tsk, #TSK_TI_SCS_BASE]
>> +	.endm
>> +
>>   	.macro scs_load tsk
>>   	ldr	scs_sp, [\tsk, #TSK_TI_SCS_SP]
>>   	.endm
>> @@ -17,6 +21,9 @@
>>   	str	scs_sp, [\tsk, #TSK_TI_SCS_SP]
>>   	.endm
>>   #else
>> +	.macro scs_reload tsk
>> +	.endm
>> +
>>   	.macro scs_load tsk
>>   	.endm
>>   
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index bc6d5a970a13..57547a3e4f7c 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -265,7 +265,7 @@ alternative_if ARM64_HAS_ADDRESS_AUTH
>>   alternative_else_nop_endif
>>   1:
>>   
>> -	scs_load tsk
>> +	scs_reload tsk
>>   	.else
>>   	add	x21, sp, #PT_REGS_SIZE
>>   	get_current_task tsk
>> @@ -365,7 +365,6 @@ alternative_if ARM64_WORKAROUND_845719
>>   alternative_else_nop_endif
>>   #endif
>>   3:
>> -	scs_save tsk
>>   
>>   	/* Ignore asynchronous tag check faults in the uaccess routines */
>>   	ldr	x0, [tsk, THREAD_SCTLR_USER]
>> -- 
>> 2.17.1
>>
