Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3549451D332
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390082AbiEFIU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390058AbiEFIUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:20:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C3E689AA
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:16:58 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kvk146pqTzhYmL;
        Fri,  6 May 2022 16:16:24 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 16:16:56 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 16:16:56 +0800
Subject: Re: [PATCH v3] arm64: add the printing of tpidr_elx in __show_regs()
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220505095640.312-1-thunder.leizhen@huawei.com>
 <YnPLQJhu5B1Cxvoh@FVFF77S0Q05N.cambridge.arm.com>
 <c6c22386-af37-1acc-63e9-2bb85028aa8c@huawei.com>
 <307e4def-1e4a-1110-e644-d485b9959ab1@huawei.com>
Message-ID: <7c1207fa-56aa-1b33-31fd-3ec395b08f2b@huawei.com>
Date:   Fri, 6 May 2022 16:16:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <307e4def-1e4a-1110-e644-d485b9959ab1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/5 21:34, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/5/5 21:26, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2022/5/5 21:04, Mark Rutland wrote:
>>> On Thu, May 05, 2022 at 05:56:40PM +0800, Zhen Lei wrote:
>>>> Commit 7158627686f0 ("arm64: percpu: implement optimised pcpu access
>>>> using tpidr_el1") and commit 6d99b68933fb ("arm64: alternatives: use
>>>> tpidr_el2 on VHE hosts") use tpidr_elx to cache my_cpu_offset to optimize
>>>> pcpu access. However, when performing reverse execution based on the
>>>> registers and the memory contents in kdump, this information is sometimes
>>>> required if there is a pcpu access.
>>>>
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>> ---
>>>>  arch/arm64/kernel/process.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> v2 --> v3:
>>>> 1) Relace "switch (read_sysreg(CurrentEL))" statement with
>>>>    "if (is_kernel_in_hyp_mode())" statement.
>>>> 2) Change the register name to lowercase.
>>>>
>>>> v1 --> v2:
>>>> Directly print the tpidr_elx register of the current exception level.
>>>> Avoid coupling with the implementation of 'my_cpu_offset'.
>>>>
>>>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>>>> index 7fa97df55e3ad3f..7b6bccce9721c36 100644
>>>> --- a/arch/arm64/kernel/process.c
>>>> +++ b/arch/arm64/kernel/process.c
>>>> @@ -216,6 +216,11 @@ void __show_regs(struct pt_regs *regs)
>>>>  	show_regs_print_info(KERN_DEFAULT);
>>>>  	print_pstate(regs);
>>>>  
>>>> +	if (is_kernel_in_hyp_mode())
>>>> +		printk("tpidr_el2 : %016llx\n", read_sysreg(tpidr_el2));
>>>> +	else
>>>> +		printk("tpidr_el1 : %016llx\n", read_sysreg(tpidr_el1));
>>>
>>> If we care about the offset specifically, this would be simpler as:
>>>
>>> 	printk("cpu offset : 0x%016lx\n", __my_cpu_offset());
>>
>> The function name is __show_regs(), so not using register name may not be good.
>> In fact, some other architectures may also have this problem. If we use my_cpu_offset,
>> we may need to put it in a public.
> 
> The other idea is to back up each my_cpu_offset in an array. In this way, the offset can
> be queried through vmcore even if it is not printed.

Sorry, __per_cpu_offset[NR_CPUS] is always defined.

> 
>>
>>>
>>> ... which should do the right thing even if we repurpose the TPIDRs and move the offset elsewhere.
>>>
>>> As Will says, we should only log this for !user_mode(regs), so it could
>>> be placed in the block below, immediately before we print the kernel PC, i.e.
>>>
>>> 	if (!user_mode_regs) {
>>> 		printk("cpu offset : %016lx\n", __my_cpu_offset());
>>> 		printk("pc : %pS\n", (void *)regs->pc);
>>> 		printk("lr : %pS\n", (void *)ptrauth_strip_insn_pac(lr));
>>> 		...
>>> 	}
>>>
>>> ... or in a separate block which checks the same condition.
>>>
>>> Thanks,
>>> Mark.
>>>
>>>> +
>>>>  	if (!user_mode(regs)) {
>>>>  		printk("pc : %pS\n", (void *)regs->pc);
>>>>  		printk("lr : %pS\n", (void *)ptrauth_strip_insn_pac(lr));
>>>> -- 
>>>> 2.25.1
>>>>
>>> .
>>>
>>
> 

-- 
Regards,
  Zhen Lei
