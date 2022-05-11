Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64DF522FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbiEKJwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbiEKJvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:51:15 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9191031350;
        Wed, 11 May 2022 02:50:54 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KyqmF1nTWzCsdt;
        Wed, 11 May 2022 17:46:05 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 17:50:52 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 17:50:51 +0800
Subject: Re: [PATCH] arm64: kdump: Do not allocate crash low memory if not
 needed
To:     Baoquan He <bhe@redhat.com>
CC:     Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        "Dave Kleikamp" <dave.kleikamp@oracle.com>
References: <20220511032033.426-1-thunder.leizhen@huawei.com>
 <Ynt8qwG9WoiW4L+o@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <8922e61e-ab7c-6e48-ad8c-57b75156a0f2@huawei.com>
Date:   Wed, 11 May 2022 17:50:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Ynt8qwG9WoiW4L+o@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/11 17:06, Baoquan He wrote:
> On 05/11/22 at 11:20am, Zhen Lei wrote:
>> When "crashkernel=X,high" is specified, the specified "crashkernel=Y,low"
>> memory is not required in the following corner cases:
>> 1. If both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32 are disabled, it means
>>    that the devices can access any memory.
>> 2. If the system memory is small, the crash high memory may be allocated
>>    from the DMA zones. If that happens, there's no need to allocate
>>    another crash low memory because there's already one.
>>
>> Add condition '(crash_base >= CRASH_ADDR_LOW_MAX)' to determine whether
>> the 'high' memory is allocated above DMA zones. Note: when both
>> CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32 are disabled, the entire physical
>> memory is DMA accessible, CRASH_ADDR_LOW_MAX equals 'PHYS_MASK + 1'.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt | 5 +++--
>>  arch/arm64/mm/init.c                            | 3 ++-
>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index f6ff55840751a78..1b543c3109f4851 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -823,7 +823,7 @@
>>  			low memory is needed to make sure DMA buffers for 32-bit
>>  			devices won't run out. Kernel would try to allocate
>>  			at least 256M below 4G automatically.
>> -			This one let user to specify own low range under 4G
>> +			This one lets the user specify own low range under 4G
>                         ~ This one let users specify own low range ...
> 
> Other than this nitpick, LGTM

This is Catalin's response a few days ago:
Slightly more correct is "This one lets the user specify..."

I didn't googled "This one lets", but I googled "It lets". I think he wrote it right.

Both "the user" and "users" seem to be right.


> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 
>>  			for second kernel instead.
>>  			0: to disable low allocation.
>>  			It will be ignored when crashkernel=X,high is not used
>> @@ -832,7 +832,8 @@
>>  			[KNL, ARM64] range in low memory.
>>  			This one lets the user specify a low range in the
>>  			DMA zone for the crash dump kernel.
>> -			It will be ignored when crashkernel=X,high is not used.
>> +			It will be ignored when crashkernel=X,high is not used
>> +			or memory reserved is located in the DMA zones.
>>  
>>  	cryptomgr.notests
>>  			[KNL] Disable crypto self-tests
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 18ba66c90991ea0..ac510fb6a2c0189 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -170,7 +170,8 @@ static void __init reserve_crashkernel(void)
>>  		return;
>>  	}
>>  
>> -	if (crash_low_size && reserve_crashkernel_low(crash_low_size)) {
>> +	if ((crash_base >= CRASH_ADDR_LOW_MAX) &&
>> +	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
>>  		memblock_phys_free(crash_base, crash_size);
>>  		return;
>>  	}
>> -- 
>> 2.25.1
>>
> 
> .
> 

-- 
Regards,
  Zhen Lei
