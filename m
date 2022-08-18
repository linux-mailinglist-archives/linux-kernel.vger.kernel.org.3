Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF61597C63
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242784AbiHRDm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiHRDmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:42:24 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062EA915C0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:42:22 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M7Vwy6FcFz1N7Q5;
        Thu, 18 Aug 2022 11:38:58 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 11:42:20 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 18 Aug
 2022 11:42:20 +0800
Message-ID: <24556707-99b3-ec3c-c176-cb73e1d030d8@huawei.com>
Date:   Thu, 18 Aug 2022 11:42:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] x86/unwind/orc: unwind ftrace trampolines with correct
 orc
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>, <jpoimboe@kernel.org>,
        <peterz@infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>
References: <20220818015525.222053-1-chenzhongjin@huawei.com>
 <20220817222836.72aa77bd@gandalf.local.home>
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <20220817222836.72aa77bd@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for review!


On 2022/8/18 10:28, Steven Rostedt wrote:
> On Thu, 18 Aug 2022 09:55:25 +0800
> Chen Zhongjin <chenzhongjin@huawei.com> wrote:
>
>
>>   arch/x86/kernel/unwind_orc.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
>> index 38185aedf7d1..a938c5d0ed6f 100644
>> --- a/arch/x86/kernel/unwind_orc.c
>> +++ b/arch/x86/kernel/unwind_orc.c
>> @@ -93,22 +93,25 @@ static struct orc_entry *orc_find(unsigned long ip);
>>   static struct orc_entry *orc_ftrace_find(unsigned long ip)
>>   {
>>   	struct ftrace_ops *ops;
>> -	unsigned long caller;
>> +	unsigned long tramp_addr, offset;
>>   
>>   	ops = ftrace_ops_trampoline(ip);
>>   	if (!ops)
>>   		return NULL;
>>   
> Now if this is that unlikely recursion mentioned below then ops->trampoline
> will be NULL, and if we do that offset addition, it will be incorrect.
>
> Perhaps we should add here:
>
> 	if (!ops->trampoline)
> 		return NULL;

I think when this will return NULL and then stop at orc_find:`if (ip == 
0)` and return null_orc_entry.

And in ftrace_ops_trampoline: `if (op->trampoline && 
op->trampoline_size)` which promise !ops->trampoline when !ops.


IIUC the In unlikely recursion below means if orc_find(ftrace_call) 
can't find any orc it will enter orc_ftrace_find(ftrace_call).

If we dont check ip==caller then,

ftrace_ops_trampoline(ftrace_call) causes orc_find(ftrace_call) again 
(I'm not 100% sure it will)

and it will be trapped in recursion


When here is an offset we can still protect this scenario when 
orc_find(ftrace_caller + offset) and check ip == ftrace_caller + offset.

>
> Let's add some comments.

Makes sense.

If the above explanation logic is fine, I'll add this comment and send v2.

>
> 	/* Set tramp_addr to the start of the code copied by the trampoline */
>
>>   	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS)
>> -		caller = (unsigned long)ftrace_regs_call;
>> +		tramp_addr = (unsigned long)ftrace_regs_caller;
>>   	else
>> -		caller = (unsigned long)ftrace_call;
>> +		tramp_addr = (unsigned long)ftrace_caller;
>> +
> 	/* Now place tramp_addr to the location within the trampoline ip is at */
>
>> +	offset = ip - ops->trampoline;
>> +	tramp_addr += offset;
>>   
>>   	/* Prevent unlikely recursion */
>> -	if (ip == caller)
>> +	if (ip == tramp_addr)
>>   		return NULL;
>>   
>> -	return orc_find(caller);
>> +	return orc_find(tramp_addr);
>>   }
>>   #else
>>   static struct orc_entry *orc_ftrace_find(unsigned long ip)

Best,

Chen


