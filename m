Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5735A20D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 08:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244993AbiHZGWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 02:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244977AbiHZGWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 02:22:39 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC2DD075D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:22:36 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MDV5x6bRWz19VbC;
        Fri, 26 Aug 2022 14:19:01 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 14:22:34 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 14:22:33 +0800
Subject: Re: [PATCH 2/2] ARM: Replace this_cpu_* with raw_cpu_* in
 panic_bad_stack()
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <patches@armlinux.org.uk>
References: <20220825063154.69-1-thunder.leizhen@huawei.com>
 <20220825063154.69-3-thunder.leizhen@huawei.com>
 <Ywd5+2UpWv4M5K6t@FVFF77S0Q05N>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <7a905d7a-9670-a672-07ca-4e2ed37a35ac@huawei.com>
Date:   Fri, 26 Aug 2022 14:22:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Ywd5+2UpWv4M5K6t@FVFF77S0Q05N>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/25 21:32, Mark Rutland wrote:
> On Thu, Aug 25, 2022 at 02:31:54PM +0800, Zhen Lei wrote:
>> The hardware automatically disable the IRQ interrupt before jumping to the
>> interrupt or exception vector. Therefore, the preempt_disable() operation
>> in this_cpu_read() after macro expansion is unnecessary. In fact, function
>> this_cpu_read() may trigger scheduling, see pseudocode below.
>>
>> Pseudocode of this_cpu_read(xx):
>> preempt_disable_notrace();
>> raw_cpu_read(xx);
>> if (unlikely(__preempt_count_dec_and_test()))
>> 	__preempt_schedule_notrace();
>>
>> Therefore, use raw_cpu_* instead of this_cpu_* to eliminate potential
>> hazards. At the very least, it reduces a few lines of assembly code.
> 
> I think if scheduling is a problem here, something should increment the
> preempt_count as is done on arm64, since any other operation in this function
> could end up causing preemption.

Yes, right. Sorry, I'm stuck in this_cpu_read()'s analysis.

> 
> Regardless, I also think it's sensible to use raw_cpu_*() here, but I don't
> think that actually fixes the problem the commit message describes.

OK, I will delete the description about risk. The risk I mentioned in the
commit message was mainly to show that using raw_cpu_read() would be better
than using this_cpu_read() in this case.

> 
> Thanks,
> Mark.
> 
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>> KernelVersion: v6.0-rc2
>>  arch/arm/kernel/traps.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
>> index 1518a1f443ff866..d5903d790cf3b7e 100644
>> --- a/arch/arm/kernel/traps.c
>> +++ b/arch/arm/kernel/traps.c
>> @@ -927,9 +927,9 @@ asmlinkage void handle_bad_stack(struct pt_regs *regs)
>>  {
>>  	unsigned long tsk_stk = (unsigned long)current->stack;
>>  #ifdef CONFIG_IRQSTACKS
>> -	unsigned long irq_stk = (unsigned long)this_cpu_read(irq_stack_ptr);
>> +	unsigned long irq_stk = (unsigned long)raw_cpu_read(irq_stack_ptr);
>>  #endif
>> -	unsigned long ovf_stk = (unsigned long)this_cpu_read(overflow_stack_ptr);
>> +	unsigned long ovf_stk = (unsigned long)raw_cpu_read(overflow_stack_ptr);
>>  
>>  	console_verbose();
>>  	pr_emerg("Insufficient stack space to handle exception!");
>> -- 
>> 2.25.1
>>
> .
> 

-- 
Regards,
  Zhen Lei
