Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BA6552AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 08:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243751AbiFUGYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 02:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbiFUGYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:24:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DF718380;
        Mon, 20 Jun 2022 23:24:13 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LRxK01kWszkWZJ;
        Tue, 21 Jun 2022 14:23:00 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 14:24:09 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 14:24:03 +0800
Message-ID: <3f66323d-f371-b931-65fb-edfae0f01c88@huawei.com>
Date:   Tue, 21 Jun 2022 14:24:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 5/5] arm64: kdump: Don't defer the reservation of crash
 high memory
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, Zhen Lei <thunder.leizhen@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        "John Donnelly" <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        liushixin <liushixin2@huawei.com>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-6-thunder.leizhen@huawei.com>
 <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/6/21 13:33, Baoquan He wrote:
> Hi,
>
> On 06/13/22 at 04:09pm, Zhen Lei wrote:
>> If the crashkernel has both high memory above DMA zones and low memory
>> in DMA zones, kexec always loads the content such as Image and dtb to the
>> high memory instead of the low memory. This means that only high memory
>> requires write protection based on page-level mapping. The allocation of
>> high memory does not depend on the DMA boundary. So we can reserve the
>> high memory first even if the crashkernel reservation is deferred.
>>
>> This means that the block mapping can still be performed on other kernel
>> linear address spaces, the TLB miss rate can be reduced and the system
>> performance will be improved.
> Ugh, this looks a little ugly, honestly.
>
> If that's for sure arm64 can't split large page mapping of linear
> region, this patch is one way to optimize linear mapping. Given kdump
> setting is necessary on arm64 server, the booting speed is truly
> impacted heavily.

Is there some conclusion or discussion that arm64 can't split large page 
mapping?

Could the crashkernel reservation (and Kfence pool) be splited dynamically?

I found Mark replay "arm64: remove page granularity limitation from 
KFENCE"[1],

   "We also avoid live changes from block<->table mappings, since the
   archtitecture gives us very weak guarantees there and generally requires
   a Break-Before-Make sequence (though IIRC this was tightened up
   somewhat, so maybe going one way is supposed to work). Unless it's
   really necessary, I'd rather not split these block mappings while
   they're live."

Hi Mark and Catalin,  could you give some comment,  many thanks.

[1] 
https://lore.kernel.org/lkml/20210920101938.GA13863@C02TD0UTHF1T.local/T/#m1a7f974593f5545cbcfc0d21560df4e7926b1381


>
> However, I would suggest letting it as is with below reasons:
>
> 1) The code will complicate the crashkernel reservatoin code which
> is already difficult to understand.
> 2) It can only optimize the two cases, first is CONFIG_ZONE_DMA|DMA32
>    disabled, the other is crashkernel=,high is specified. While both
>    two cases are corner case, most of systems have CONFIG_ZONE_DMA|DMA32
>    enabled, and most of systems have crashkernel=xM which is enough.
>    Having them optimized won't bring benefit to most of systems.
> 3) Besides, the crashkernel=,high can be handled earlier because
>    arm64 alwasys have memblock.bottom_up == false currently, thus we
>    don't need worry arbout the lower limit of crashkernel,high
>    reservation for now. If memblock.bottom_up is set true in the future,
>    this patch doesn't work any more.
>
>
> ...
>          crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>                                                 crash_base, crash_max);
>
> So, in my opinion, we can leave the current NON_BLOCK|SECT mapping as
> is caused by crashkernel reserving, since no regression is brought.
> And meantime, turning to check if there's any way to make the contiguous
> linear mapping and later splitting work. The patch 4, 5 in this patchset
> doesn't make much sense to me, frankly speaking.
>
> Thanks
> Baoquan
