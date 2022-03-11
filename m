Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022024D5F50
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347804AbiCKKWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347571AbiCKKWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:22:15 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8351A39FF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:21:12 -0800 (PST)
Received: from kwepemi100014.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KFMKH00hqz1GCFW;
        Fri, 11 Mar 2022 18:16:18 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi100014.china.huawei.com (7.221.188.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 18:21:10 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 18:21:09 +0800
Subject: Re: [PATCH] x86/traps: Mark do_int3() NOKPROBE_SYMBOL
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     <peterz@infradead.org>, <tglx@linutronix.de>,
        <alexandre.chartre@oracle.com>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <laijs@linux.alibaba.com>, <chang.seok.bae@intel.com>,
        <fenghua.yu@intel.com>, <thomas.tai@oracle.com>,
        <linux-kernel@vger.kernel.org>
References: <20220310120915.63349-1-lihuafei1@huawei.com>
 <20220310230424.b1f3ad6987d5aafc8b339e98@kernel.org>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <7aa197c5-d69a-64e9-55c7-fef9cb9954e8@huawei.com>
Date:   Fri, 11 Mar 2022 18:21:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20220310230424.b1f3ad6987d5aafc8b339e98@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/3/10 22:04, Masami Hiramatsu wrote:
> On Thu, 10 Mar 2022 20:09:15 +0800
> Li Huafei <lihuafei1@huawei.com> wrote:
>
>> Since kprobe_int3_handler() is called in do_int3(), probing do_int3()
>> can cause a breakpoint recursion and crash the kernel. Therefore,
>> do_int3() should be marked as NOKPROBE_SYMBOL.
>>
>> Fixes: 21e28290b317 ("x86/traps: Split int3 handler up")
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Good catch!
> This should be backported to stable kernel.
>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: stable@vger.kernel.org

Thanks,

Huafei

>
>
> Thank you,
>
>> ---
>>   arch/x86/kernel/traps.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
>> index c9d566dcf89a..8143693a7ea6 100644
>> --- a/arch/x86/kernel/traps.c
>> +++ b/arch/x86/kernel/traps.c
>> @@ -659,6 +659,7 @@ static bool do_int3(struct pt_regs *regs)
>>   
>>   	return res == NOTIFY_STOP;
>>   }
>> +NOKPROBE_SYMBOL(do_int3);
>>   
>>   static void do_int3_user(struct pt_regs *regs)
>>   {
>> -- 
>> 2.17.1
>>
>
