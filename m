Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398144754BC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbhLOI41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:56:27 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32923 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbhLOI40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:56:26 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JDTcQ1xhbzXdTj;
        Wed, 15 Dec 2021 16:56:06 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 16:56:23 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 16:56:22 +0800
Subject: Re: [PATCH v17 04/10] x86: kdump: move xen_pv_domain() check and
 insert_resource() to setup_arch()
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Chen Zhou" <dingguo.cz@antgroup.com>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-5-thunder.leizhen@huawei.com>
 <d328aede-1282-b4d5-f17a-aa9c3e9f6563@huawei.com>
Message-ID: <03bd43f3-14a1-dbd1-9fff-118c0885653c@huawei.com>
Date:   Wed, 15 Dec 2021 16:56:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d328aede-1282-b4d5-f17a-aa9c3e9f6563@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/14 19:40, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/12/10 14:55, Zhen Lei wrote:
>> From: Chen Zhou <chenzhou10@huawei.com>
>>
>> We will make the functions reserve_crashkernel() as generic, the
>> xen_pv_domain() check in reserve_crashkernel() is relevant only to
>> x86, the same as insert_resource() in reserve_crashkernel[_low]().
>> So move xen_pv_domain() check and insert_resource() to setup_arch()
>> to keep them in x86.
>>
>> Suggested-by: Mike Rapoport <rppt@kernel.org>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
>> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>  arch/x86/kernel/setup.c | 19 +++++++++++--------
>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index bb2a0973b98059e..7ae00716a208f82 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -456,7 +456,6 @@ static int __init reserve_crashkernel_low(void)
>>  
>>  	crashk_low_res.start = low_base;
>>  	crashk_low_res.end   = low_base + low_size - 1;
>> -	insert_resource(&iomem_resource, &crashk_low_res);
>>  #endif
>>  	return 0;
>>  }
>> @@ -480,11 +479,6 @@ static void __init reserve_crashkernel(void)
>>  		high = true;
>>  	}
>>  
>> -	if (xen_pv_domain()) {
>> -		pr_info("Ignoring crashkernel for a Xen PV domain\n");
>> -		return;
>> -	}
>> -
>>  	/* 0 means: find the address automatically */
>>  	if (!crash_base) {
>>  		/*
>> @@ -531,7 +525,6 @@ static void __init reserve_crashkernel(void)
>>  
>>  	crashk_res.start = crash_base;
>>  	crashk_res.end   = crash_base + crash_size - 1;
>> -	insert_resource(&iomem_resource, &crashk_res);
>>  }
>>  #else
>>  static void __init reserve_crashkernel(void)
>> @@ -1143,7 +1136,17 @@ void __init setup_arch(char **cmdline_p)
>>  	 * Reserve memory for crash kernel after SRAT is parsed so that it
>>  	 * won't consume hotpluggable memory.
>>  	 */
>> -	reserve_crashkernel();
> 
> Hi Baoquan:
>   How about move "#ifdef CONFIG_KEXEC_CORE" here, so that we can remove the
> empty reserve_crashkernel(). In fact, xen_pv_domain() is invoked only
> when CONFIG_KEXEC_CORE is enabled before.

Hi Baoquan:
  Did you miss this email? If no reply, I will keep it no change.

> 
>> +	if (xen_pv_domain())
>> +		pr_info("Ignoring crashkernel for a Xen PV domain\n");
>> +	else {
>> +		reserve_crashkernel();
>> +#ifdef CONFIG_KEXEC_CORE
>> +		if (crashk_res.end > crashk_res.start)
>> +			insert_resource(&iomem_resource, &crashk_res);
>> +		if (crashk_low_res.end > crashk_low_res.start)
>> +			insert_resource(&iomem_resource, &crashk_low_res);
>> +#endif
>> +	}
>>  
>>  	memblock_find_dma_reserve();
>>  
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> .
> 
