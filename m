Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594E34FF926
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbiDMOnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiDMOnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:43:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690824EF70
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:41:28 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kdlbr0qV3zgYYx;
        Wed, 13 Apr 2022 22:39:36 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 22:41:25 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 22:41:24 +0800
Message-ID: <b86dfefe-316f-f650-bc2f-a740d7825bed@huawei.com>
Date:   Wed, 13 Apr 2022 22:41:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH -next V3 3/6] arm64: add support for machine check
 error safe
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Xie XiuQi <xiexiuqi@huawei.com>
References: <20220412072552.2526871-1-tongtiangen@huawei.com>
 <20220412072552.2526871-4-tongtiangen@huawei.com>
 <af6bd17a-d2ec-3d1a-8360-b51fe38ecdd9@huawei.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <af6bd17a-d2ec-3d1a-8360-b51fe38ecdd9@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/4/12 21:08, Kefeng Wang 写道:
[...]
>> +
>> +bool fixup_exception_mc(struct pt_regs *regs)
>> +{
>> +    const struct exception_table_entry *ex;
>> +
>> +    ex = search_exception_tables(instruction_pointer(regs));
>> +    if (!ex)
>> +        return false;
>> +
>> +    switch (ex->type) {
>> +    case EX_TYPE_UACCESS_MC:
>> +        return ex_handler_fixup(ex, regs);
>> +    }
>> +
>> +    return false;
>> +}
> 
> The definition of EX_TYPE_UACCESS_MC is in patch4, please fix it, and if 
> arm64 exception table

ok, will do next version.

> 
> is sorted by exception type, we could drop fixup_exception_mc(), right?

In sort_relative_table_with_data(), it seems sorted by insn and data.

> 
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 77341b160aca..56b13cf8bf1d 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -695,6 +695,30 @@ static int do_bad(unsigned long far, unsigned int 
>> esr, struct pt_regs *regs)
>>       return 1; /* "fault" */
>>   }
>> +static bool arm64_process_kernel_sea(unsigned long addr, unsigned int 
>> esr,
>> +                     struct pt_regs *regs, int sig, int code)
>> +{
>> +    if (!IS_ENABLED(CONFIG_ARCH_HAS_COPY_MC))
>> +        return false;
>> +
>> +    if (user_mode(regs) || !current->mm)
>> +        return false;
>> +
>> +    if (apei_claim_sea(regs) < 0)
>> +        return false;
>> +
>> +    current->thread.fault_address = 0;
>> +    current->thread.fault_code = esr;
>> +
> Use set_thread_esr(0, esr) and move it after fixup_exception_mc();
>> +    if (!fixup_exception_mc(regs))
>> +        return false;
>> +
>> +    arm64_force_sig_fault(sig, code, addr,
>> +        "Uncorrected hardware memory error in kernel-access\n");
>> +
>> +    return true;
>> +}
>> +
>>   static int do_sea(unsigned long far, unsigned int esr, struct 
>> pt_regs *regs)
>>   {
>>       const struct fault_info *inf;
>> @@ -720,6 +744,10 @@ static int do_sea(unsigned long far, unsigned int 
>> esr, struct pt_regs *regs)
>>            */
>>           siaddr  = untagged_addr(far);
>>       }
>> +
>> +    if (arm64_process_kernel_sea(siaddr, esr, regs, inf->sig, 
>> inf->code))
>> +        return 0;
>> +
> 
> Rename arm64_process_kernel_sea() to arm64_do_kernel_sea() 
> 
> if (!arm64_do_kernel_sea())
> 
>      arm64_notify_die();
> 

Agreed, will do next version.

>>       arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, 
>> esr);
>>       return 0;
>> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
>> index 546179418ffa..dd952aeecdc1 100644
>> --- a/include/linux/uaccess.h
>> +++ b/include/linux/uaccess.h
>> @@ -174,6 +174,14 @@ copy_mc_to_kernel(void *dst, const void *src, 
>> size_t cnt)
>>   }
>>   #endif
>> +#ifndef copy_mc_to_user
>> +static inline unsigned long __must_check
>> +copy_mc_to_user(void *dst, const void *src, size_t cnt)
>> +{
> Add check_object_size(cnt, src, true);  which could make 
> HARDENED_USERCOPY works.

Agreed, will do next version.

Thanks KeFeng,
Tong.

>> +    return raw_copy_to_user(dst, src, cnt);
>> +}
>> +#endif
>> +
>>   static __always_inline void pagefault_disabled_inc(void)
>>   {
>>       current->pagefault_disabled++;
> .
