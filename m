Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBCE51321D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344393AbiD1LLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiD1LLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:11:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81661BE32
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 04:07:54 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KptBD5mJczhYfc;
        Thu, 28 Apr 2022 19:07:32 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 19:07:52 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 19:07:52 +0800
Subject: Re: [PATCH v2] arm64: add the printing of tpidr_elx in __show_regs()
To:     Will Deacon <will@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "James Morse" <james.morse@arm.com>
References: <20220316062408.1113-1-thunder.leizhen@huawei.com>
 <20220428102156.GA14123@willie-the-truck>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <4c956c17-6e13-37a1-7da3-b2c8243c2c01@huawei.com>
Date:   Thu, 28 Apr 2022 19:07:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20220428102156.GA14123@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/28 18:21, Will Deacon wrote:
> On Wed, Mar 16, 2022 at 02:24:08PM +0800, Zhen Lei wrote:
>> Commit 7158627686f0 ("arm64: percpu: implement optimised pcpu access
>> using tpidr_el1") and commit 6d99b68933fb ("arm64: alternatives: use
>> tpidr_el2 on VHE hosts") use tpidr_elx to cache my_cpu_offset to optimize
>> pcpu access. However, when performing reverse execution based on the
>> registers and the memory contents in kdump, this information is sometimes
>> required if there is a pcpu access.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  arch/arm64/kernel/process.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> v1 --> v2:
>> Directly print the tpidr_elx register of the current exception level.
>> Avoid coupling with the implementation of 'my_cpu_offset'.
>>
>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>> index 5369e649fa79ff8..738932e6fa4e947 100644
>> --- a/arch/arm64/kernel/process.c
>> +++ b/arch/arm64/kernel/process.c
>> @@ -216,6 +216,17 @@ void __show_regs(struct pt_regs *regs)
>>  	show_regs_print_info(KERN_DEFAULT);
>>  	print_pstate(regs);
>>  
>> +	switch (read_sysreg(CurrentEL)) {
> 
> This should use is_kernel_in_hyp_mode() to detect if we're running at El2.
> 
>> +	case CurrentEL_EL1:
>> +		printk("tpidr_el1 : %016llx\n", read_sysreg(TPIDR_EL1));
>> +		break;
>> +	case CurrentEL_EL2:
>> +		printk("tpidr_el2 : %016llx\n", read_sysreg(TPIDR_EL2));
>> +		break;
>> +	default:
>> +		break;
>> +	}
> 
> I think this path can be triggered directly from usermode, so we really
> shouldn't be printing raw kernel virtual addresses here.

I run echo c > /proc/sysrq-trigger and didn't trigger this path, but maybe
there's another way. Analysis from the other side, except for the instruction
address, all generic registers r0-r31 is output as raw. There's also an
opportunity to contain the instruction address.

So how about:
+       if (oops_in_progress)
+               printk("tpidr : %016lx\n", __my_cpu_offset);

> 
> Will
> .
> 

-- 
Regards,
  Zhen Lei
