Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1424BD67D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 07:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345257AbiBUGjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 01:39:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344581AbiBUGjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 01:39:02 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAA7205C3;
        Sun, 20 Feb 2022 22:38:38 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K2CK22CRMzcfdn;
        Mon, 21 Feb 2022 14:37:26 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 14:38:36 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 14:38:35 +0800
Subject: Re: [PATCH v20 5/5] kdump: update Documentation about crashkernel
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
 <20220124084708.683-6-thunder.leizhen@huawei.com>
 <YhMLoUvxteZVVwqQ@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <8ada665b-1917-2f01-477f-baaa562f5502@huawei.com>
Date:   Mon, 21 Feb 2022 14:38:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YhMLoUvxteZVVwqQ@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/2/21 11:48, Baoquan He wrote:
> On 01/24/22 at 04:47pm, Zhen Lei wrote:
>> From: Chen Zhou <chenzhou10@huawei.com>
>>
>> For arm64, the behavior of crashkernel=X has been changed, which
>> tries low allocation in DMA zone and fall back to high allocation
>> if it fails.
>>
>> We can also use "crashkernel=X,high" to select a high region above
>> DMA zone, which also tries to allocate at least 256M low memory in
>> DMA zone automatically and "crashkernel=Y,low" can be used to allocate
>> specified size low memory.
>>
>> So update the Documentation.
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  Documentation/admin-guide/kdump/kdump.rst       | 11 +++++++++--
>>  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++--
>>  2 files changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
>> index cb30ca3df27c9b2..d4c287044be0c70 100644
>> --- a/Documentation/admin-guide/kdump/kdump.rst
>> +++ b/Documentation/admin-guide/kdump/kdump.rst
>> @@ -361,8 +361,15 @@ Boot into System Kernel
>>     kernel will automatically locate the crash kernel image within the
>>     first 512MB of RAM if X is not given.
>>  
>> -   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
>> -   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
>> +   On arm64, use "crashkernel=X" to try low allocation in DMA zone and
>> +   fall back to high allocation if it fails.
>> +   We can also use "crashkernel=X,high" to select a high region above
>> +   DMA zone, which also tries to allocate at least 256M low memory in
>> +   DMA zone automatically.
>> +   "crashkernel=Y,low" can be used to allocate specified size low memory.
>> +   Use "crashkernel=Y@X" if you really have to reserve memory from
>> +   specified start address X. Note that the start address of the kernel,
>> +   X if explicitly specified, must be aligned to 2MiB (0x200000).
> 
> Hmm, we may not need the details related to crashkernel,high|low in this
> section. This just gives examples of basic configation for each ARCH.
> The detailed configuration of all crashkernel setting can be found in
> "crashkernel syntax" section, I don't think arm64 is so special to need
> a specific one.
> 
>>  
>>  Load the Dump-capture Kernel
>>  ============================
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index f5a27f067db9ed9..65780c2ca830be0 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -792,6 +792,9 @@
>>  			[KNL, X86-64] Select a region under 4G first, and
>>  			fall back to reserve region above 4G when '@offset'
>>  			hasn't been specified.
>> +			[KNL, ARM64] Try low allocation in DMA zone and fall back
>> +			to high allocation if it fails when '@offset' hasn't been
>> +			specified.
>>  			See Documentation/admin-guide/kdump/kdump.rst for further details.
> 
> How about add ARM64 like below to avoid redundant words?
>   			[KNL, X86-64, ARM64] Select a region under 4G first, and
>   			fall back to reserve region above 4G when '@offset'
>   			hasn't been specified.

I agree very much, and I think that's the right thing to do. Thanks.

I wanted to do the same before, just wasn't sure if the format was correct. I just
looked at the other descriptions in kernel-parameters.txt and found that there are
many precedents.

"movablecore=    [KNL,X86,IA-64,PPC]"

> 
>>  
>>  	crashkernel=range1:size1[,range2:size2,...][@offset]
>> @@ -808,6 +811,8 @@
>>  			Otherwise memory region will be allocated below 4G, if
>>  			available.
>>  			It will be ignored if crashkernel=X is specified.
>> +			[KNL, ARM64] range in high memory.
>> +			Allow kernel to allocate physical memory region from top.
> 
> Ditto, please don't add redundent words if it's similar to x86_64
> handling.
> 
>>  	crashkernel=size[KMG],low
>>  			[KNL, X86-64] range under 4G. When crashkernel=X,high
>>  			is passed, kernel could allocate physical memory region
>> @@ -816,13 +821,15 @@
>>  			requires at least 64M+32K low memory, also enough extra
>>  			low memory is needed to make sure DMA buffers for 32-bit
>>  			devices won't run out. Kernel would try to allocate at
>> -			at least 256M below 4G automatically.
>> +			least 256M below 4G automatically.
>>  			This one let user to specify own low range under 4G
>>  			for second kernel instead.
>>  			0: to disable low allocation.
>>  			It will be ignored when crashkernel=X,high is not used
>>  			or memory reserved is below 4G.
>> -
>> +			[KNL, ARM64] range in low memory.
>> +			This one let user to specify a low range in DMA zone for
>> +			crash dump kernel.
> 
> Ditto.
> 
>>  	cryptomgr.notests
>>  			[KNL] Disable crypto self-tests
>>  
>> -- 
>> 2.25.1
>>
> 
> .
> 

-- 
Regards,
  Zhen Lei
