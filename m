Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDB8511224
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358659AbiD0HPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352012AbiD0HPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:15:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B90433BB;
        Wed, 27 Apr 2022 00:12:33 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kp90T16Bpz1JBm0;
        Wed, 27 Apr 2022 15:11:37 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 15:12:30 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 15:12:29 +0800
Subject: Re: [PATCH v22 4/9] arm64: kdump: Don't force page-level mappings for
 memory above 4G
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
 <20220414115720.1887-5-thunder.leizhen@huawei.com> <YmgBFPMbyyOH/52y@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <b635e4e8-a05d-36e5-9274-885452fd0a06@huawei.com>
Date:   Wed, 27 Apr 2022 15:12:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YmgBFPMbyyOH/52y@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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



On 2022/4/26 22:26, Catalin Marinas wrote:
> On Thu, Apr 14, 2022 at 07:57:15PM +0800, Zhen Lei wrote:
>> @@ -540,13 +540,31 @@ static void __init map_mem(pgd_t *pgdp)
>>  	for_each_mem_range(i, &start, &end) {
>>  		if (start >= end)
>>  			break;
>> +
>> +#ifdef CONFIG_KEXEC_CORE
>> +		if (eflags && (end >= SZ_4G)) {
>> +			/*
>> +			 * The memory block cross the 4G boundary.
>> +			 * Forcibly use page-level mappings for memory under 4G.
>> +			 */
>> +			if (start < SZ_4G) {
>> +				__map_memblock(pgdp, start, SZ_4G - 1,
>> +					       pgprot_tagged(PAGE_KERNEL), flags | eflags);
>> +				start  = SZ_4G;
>> +			}
>> +
>> +			/* Page-level mappings is not mandatory for memory above 4G */
>> +			eflags = 0;
>> +		}
>> +#endif
> 
> That's a bit tricky if a SoC has all RAM above 4G. IIRC AMD Seattle had
> this layout. See max_zone_phys() for how we deal with this, basically
> extending ZONE_DMA to the whole range if RAM starts above 4GB. In that
> case, crashkernel reservation would fall in the range above 4GB.
> 
> BTW, we changed the max_zone_phys() logic with commit 791ab8b2e3db
> ("arm64: Ignore any DMA offsets in the max_zone_phys() calculation").

Okay, thanks for your correction. I'll dig into it after I've done the original requirement.

> 

-- 
Regards,
  Zhen Lei
