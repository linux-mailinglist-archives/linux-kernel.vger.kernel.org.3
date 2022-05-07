Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5915951E316
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 03:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445204AbiEGBhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 21:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389512AbiEGBhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 21:37:52 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAAB5DBDD;
        Fri,  6 May 2022 18:34:06 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kw9164hhcz1JBsV;
        Sat,  7 May 2022 09:32:58 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 7 May 2022 09:34:05 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 7 May 2022 09:34:03 +0800
Subject: Re: [PATCH v24 3/6] arm64: kdump: Reimplement crashkernel=X
To:     Baoquan He <bhe@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>, Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Chen Zhou" <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
 <20220506114402.365-4-thunder.leizhen@huawei.com>
 <20220506231032.GA122876@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <d9b21f31-6fd2-a898-9a70-c63ff4f36212@huawei.com>
Date:   Sat, 7 May 2022 09:34:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20220506231032.GA122876@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/7 7:10, Baoquan He wrote:
> On 05/06/22 at 07:43pm, Zhen Lei wrote:
> ......  
>> @@ -118,8 +162,7 @@ static void __init reserve_crashkernel(void)
>>  	if (crash_base)
>>  		crash_max = crash_base + crash_size;
>>  
>> -	/* Current arm64 boot protocol requires 2MB alignment */
>> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
>> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>>  					       crash_base, crash_max);
>>  	if (!crash_base) {
>>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>> @@ -127,6 +170,11 @@ static void __init reserve_crashkernel(void)
>>  		return;
>>  	}
>>  
> 
> There's corner case missed, e.g
> 1) ,high and ,low are specified, CONFIG_ZONE_DMA|DMA32 is not enabled;
> 2) ,high and ,low are specified, the whole system memory is under 4G.
> 
> Below judgement can filter them away:
>         
> 	if (crash_base > arm64_dma_phys_limit && crash_low_size &&
> 	    reserve_crashkernel_low(crash_low_size)) {
> 
> What's your opinion? Leave it and add document to notice user, or fix it
> with code change?

I think maybe we can leave it unchanged. If the user configures two memory ranges,
we'd better apply for two. Otherwise, he'll be confused when he inquires. Currently,
crash_low_size is non-zero only when 'crashkernel=Y,low' is explicitly configured.

> 
> I would suggest merging this series, Lei can add this corner case
> handling on top. Since this is a newly added support, we don't have
> to make it one step. Doing step by step can make reviewing easier.
> 
>> +	if (crash_low_size && reserve_crashkernel_low(crash_low_size)) {
>> +		memblock_phys_free(crash_base, crash_size);
>> +		return;
>> +	}
>> +
>>  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>>  		crash_base, crash_base + crash_size, crash_size >> 20);
>>  
>> @@ -135,6 +183,9 @@ static void __init reserve_crashkernel(void)
>>  	 * map. Inform kmemleak so that it won't try to access it.
>>  	 */
>>  	kmemleak_ignore_phys(crash_base);
>> +	if (crashk_low_res.end)
>> +		kmemleak_ignore_phys(crashk_low_res.start);
>> +
>>  	crashk_res.start = crash_base;
>>  	crashk_res.end = crash_base + crash_size - 1;
>>  	insert_resource(&iomem_resource, &crashk_res);
>> -- 
>> 2.25.1
>>
> 
> .
> 

-- 
Regards,
  Zhen Lei
