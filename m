Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814A14B41EF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 07:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbiBNGWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 01:22:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240761AbiBNGWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:22:42 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3EA50458;
        Sun, 13 Feb 2022 22:22:34 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JxvD54fBNzZfWL;
        Mon, 14 Feb 2022 14:18:13 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 14:22:32 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 14:22:31 +0800
Subject: Re: [PATCH v20 2/5] arm64: kdump: introduce some macros for crash
 kernel reservation
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
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
 <20220124084708.683-3-thunder.leizhen@huawei.com>
 <YgY89RxkAl12n/dd@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <69da7ed5-4ef4-3655-8965-4181c7d7bf0b@huawei.com>
Date:   Mon, 14 Feb 2022 14:22:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YgY89RxkAl12n/dd@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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



On 2022/2/11 18:39, Baoquan He wrote:
> On 01/24/22 at 04:47pm, Zhen Lei wrote:
>> From: Chen Zhou <chenzhou10@huawei.com>
>>
>> Introduce macro CRASH_ALIGN for alignment, macro CRASH_ADDR_LOW_MAX
>> for upper bound of low crash memory, macro CRASH_ADDR_HIGH_MAX for
>> upper bound of high crash memory, use macros instead.
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
>> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
>> ---
>>  arch/arm64/mm/init.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 90f276d46b93bc6..6c653a2c7cff052 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -65,6 +65,12 @@ EXPORT_SYMBOL(memstart_addr);
>>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>>  
>>  #ifdef CONFIG_KEXEC_CORE
>> +/* Current arm64 boot protocol requires 2MB alignment */
>> +#define CRASH_ALIGN		SZ_2M
>> +
>> +#define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit
>> +#define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
> 
> MEMBLOCK_ALLOC_ACCESSIBLE is obvoiously a alloc flag for memblock
> allocator, I don't think it's appropriate to make HIGH_MAX get its value.

Right, thanks.

> You can make it as memblock.current_limit, or do not define it, but using
> MEMBLOCK_ALLOC_ACCESSIBLE direclty in memblock_phys_alloc_range() with
> a code comment. 

This patch is not required at present. These macros are added to eliminate
differences to share code with x86.

> 
> 
>> +
>>  /*
>>   * reserve_crashkernel() - reserves memory for crash kernel
>>   *
>> @@ -75,7 +81,7 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>>  static void __init reserve_crashkernel(void)
>>  {
>>  	unsigned long long crash_base, crash_size;
>> -	unsigned long long crash_max = arm64_dma_phys_limit;
>> +	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>>  	int ret;
>>  
>>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>> @@ -90,8 +96,7 @@ static void __init reserve_crashkernel(void)
>>  	if (crash_base)
>>  		crash_max = crash_base + crash_size;
>>  
>> -	/* Current arm64 boot protocol requires 2MB alignment */
>> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
>> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>>  					       crash_base, crash_max);
>>  	if (!crash_base) {
>>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>> -- 
>> 2.25.1
>>
> 
> .
> 

-- 
Regards,
  Zhen Lei
