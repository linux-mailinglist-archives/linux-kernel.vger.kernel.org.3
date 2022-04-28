Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F303512974
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 04:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiD1CZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 22:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiD1CZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:25:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C407523D;
        Wed, 27 Apr 2022 19:22:41 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KpfXD1JHdzhYTS;
        Thu, 28 Apr 2022 10:22:20 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 10:22:39 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 10:22:38 +0800
Subject: Re: [PATCH v22 5/9] arm64: kdump: Reimplement crashkernel=X
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>, Will Deacon <will@kernel.org>,
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
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
 <20220414115720.1887-6-thunder.leizhen@huawei.com> <YmgzxsrrMlCDYsWp@arm.com>
 <ee8daaa9-3258-e7e8-e5c4-c51dc9841580@huawei.com> <Ymk34NsIFqUgfk3b@arm.com>
 <ae7211ad-e2ac-f5b1-5aa0-701802132e73@huawei.com> <YmlphvZVMsGfFksp@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <42f4db6c-d3f9-e1c4-6a61-dc2bf4f89adf@huawei.com>
Date:   Thu, 28 Apr 2022 10:22:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YmlphvZVMsGfFksp@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/28 0:04, Catalin Marinas wrote:
> On Wed, Apr 27, 2022 at 09:49:20PM +0800, Leizhen (ThunderTown) wrote:
>> On 2022/4/27 20:32, Catalin Marinas wrote:
>>> I think one could always pass a default command line like:
>>>
>>> 	crashkernel=1G,high crashkernel=128M,low
>>>
>>> without much knowledge of the SoC memory layout.
>>
>> Yes, that's what the end result is. The user specify crashkernel=128M,low
>> and the implementation ensure the 128M low memory is allocated from DMA zone.
>> We use arm64_dma_phys_limit as the upper limit for crash low memory.
>>
>> +#define CRASH_ADDR_LOW_MAX             arm64_dma_phys_limit
>> +       unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>> +       crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>>                                                crash_base, crash_max);
>>
>>> Another option is to only introduce crashkernel=Y,low and, when that is
>>> passed, crashkernel=Y can go above arm64_dma_phys_limit. We won't need a
>>> 'high' option at all:
>>>
>>> 	crashkernel=1G				- all within ZONE_DMA
>>> 	crashkernel=1G crashkernel=128M,low	- 128M in ZONE_DMA
>>> 						  1G above ZONE_DMA
>>>
>>> If ZONE_DMA is not present or it extends to the whole RAM, we can ignore
>>> the 'low' option.
>>
>> I think although the code is hard to make generic, the interface is better to
>> be relatively uniform. A user might have to maintain both x86 and arm64, and
>> so on. It's not a good thing that the difference is too big.
> 
> There will be some difference as the 4G limit doesn't always hold for
> arm64 (though it's true in most cases). Anyway, we can probably simplify
> things a bit while following the documented behaviour:
> 
> 	crashkernel=Y		- current behaviour within ZONE_DMA
> 	crashkernel=Y,high	- allocate from above ZONE_DMA
> 	crashkernel=Y,low	- allocate within ZONE_DMA
> 
> There is no fallback from crashkernel=Y.

Yes, I followed your guidelines yesterday to modify the code. Now the code flow
is much clearer.

> 
> The question is whether we still want a default low allocation if
> crashkernel=Y,low is missing but 'high' is present. If we add this, I
> think we'd be consistent with kernel-parameters.txt for the 'low'
> description. A default 'low' is probably not that bad but I'm tempted to
> always mandate both 'high' and 'low'.

Yes, I agree with you. Because the situation is complicated, the default value
is hard to be accurate. It's better to let the user configure it according to
the actual situation, they're also programmers.

Whether mandate both 'high' and 'low', or allow only 'high' like x86(but the default
value becomes zero). I prefer the latter. The size of 'low' maybe zero, for example,
SMMU is enabled on the second kernel. If only high memory is required, only that
high memory needs to be configured, seems more reasonable.

> 

-- 
Regards,
  Zhen Lei
