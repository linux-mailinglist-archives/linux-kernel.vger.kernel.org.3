Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7A34D9C4B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348726AbiCONd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343569AbiCONd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:33:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343F652E04;
        Tue, 15 Mar 2022 06:32:14 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KHvRm5zvzzfZ0w;
        Tue, 15 Mar 2022 21:30:44 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 21:32:12 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 21:32:11 +0800
Subject: Re: [PATCH v21 1/5] kdump: return -ENOENT if required cmdline option
 does not exist
To:     Baoquan He <bhe@redhat.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        "John Donnelly" <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
References: <20220227030717.1464-1-thunder.leizhen@huawei.com>
 <20220227030717.1464-2-thunder.leizhen@huawei.com>
 <YjB/QILintgvo1AL@MiWiFi-R3L-srv> <YjCE0Scp2YiEJXBM@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <d237a2ae-300c-2c51-d97c-417bdfaa5fda@huawei.com>
Date:   Tue, 15 Mar 2022 21:32:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YjCE0Scp2YiEJXBM@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
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



On 2022/3/15 20:21, Baoquan He wrote:
> On 03/15/22 at 07:57pm, Baoquan He wrote:
>> On 02/27/22 at 11:07am, Zhen Lei wrote:
>>> The crashkernel=Y,low is an optional command-line option. When it doesn't
>>> exist, kernel will try to allocate minimum required memory below 4G
>>> automatically. Give it a unique error code to distinguish it from other
>>> error scenarios.
>>>
>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>> ---
>>>  kernel/crash_core.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>> index 256cf6db573cd09..4d57c03714f4e13 100644
>>> --- a/kernel/crash_core.c
>>> +++ b/kernel/crash_core.c
>>> @@ -243,9 +243,8 @@ static int __init __parse_crashkernel(char *cmdline,
>>>  	*crash_base = 0;
>>>  
>>>  	ck_cmdline = get_last_crashkernel(cmdline, name, suffix);
>>> -
>>>  	if (!ck_cmdline)
>>> -		return -EINVAL;
>>> +		return -ENOENT;
>>
>> Firstly, I am not sure if '-ENOENT' is a right value to return. From the
>> code comment of ENOENT, it's used for file or dir?
>> #define ENOENT           2      /* No such file or directory */

This error code does not return to user mode, so there is no problem.
There are a lot of places in the kernel that are used this way. For example:

int stop_one_cpu(unsigned int cpu, cpu_stop_fn_t fn, void *arg)
{
	if (!cpu_stop_queue_work(cpu, &work))
		return -ENOENT;

>>
>> Secondly, we ever discussed the case including
>>  - no crashkernel=,low is provided;
>>  - messy code is provied, e.g crashkernel=aaaaaabbbb,low
> 
> Checking the 3rd pach, this is handled. Take back my below words,
> continue reviewing.

Yes.

> 
>>
>> The 2nd one is not handled in this patchset. How about taking the
>> handling into another round of patches. This patchset just adds
>> crashkernel=,high purely.
>>
>>>  
>>>  	ck_cmdline += strlen(name);
>>>  
>>> -- 
>>> 2.25.1
>>>
>>
> 
> .
> 

-- 
Regards,
  Zhen Lei
