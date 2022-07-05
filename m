Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6340566160
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 04:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiGECoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 22:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiGECow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:44:52 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520D95598
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 19:44:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VIPhkH4_1656989083;
Received: from 30.225.28.170(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VIPhkH4_1656989083)
          by smtp.aliyun-inc.com;
          Tue, 05 Jul 2022 10:44:45 +0800
Message-ID: <f1f7f447-1b7b-9c42-f735-906d96b6077b@linux.alibaba.com>
Date:   Tue, 5 Jul 2022 10:44:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] arm64: mm: fix linear mem mapping access performance
 degradation
To:     Will Deacon <will@kernel.org>
Cc:     baolin.wang@linux.alibaba.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, david@redhat.com, jianyong.wu@arm.com,
        james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@kernel.org,
        geert+renesas@glider.be, ardb@kernel.org, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com
References: <1656777473-73887-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <20220704103523.GC31437@willie-the-truck>
 <73f0c53b-fd17-c5e9-3773-1d71e564eb50@linux.alibaba.com>
 <20220704111402.GA31553@willie-the-truck>
 <4accaeda-572f-f72d-5067-2d0999e4d00a@linux.alibaba.com>
 <20220704131516.GC31684@willie-the-truck>
 <2ae1cae0-ee26-aa59-7ed9-231d67194dce@linux.alibaba.com>
 <20220704142313.GE31684@willie-the-truck>
 <6977c692-78ca-5a67-773e-0389c85f2650@linux.alibaba.com>
 <20220704163815.GA32177@willie-the-truck>
From:   "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <20220704163815.GA32177@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/7/5 0:38, Will Deacon 写道:
> On Mon, Jul 04, 2022 at 10:34:07PM +0800, guanghui.fgh wrote:
>> Thanks.
>>
>> 在 2022/7/4 22:23, Will Deacon 写道:
>>> On Mon, Jul 04, 2022 at 10:11:27PM +0800, guanghui.fgh wrote:
>>>> 在 2022/7/4 21:15, Will Deacon 写道:
>>>>> On Mon, Jul 04, 2022 at 08:05:59PM +0800, guanghui.fgh wrote:
>>>>>>>> 1.Quoted messages from arch/arm64/mm/init.c
>>>>>>>>
>>>>>>>> "Memory reservation for crash kernel either done early or deferred
>>>>>>>> depending on DMA memory zones configs (ZONE_DMA) --
>>>>>>>>
>>>>>>>> In absence of ZONE_DMA configs arm64_dma_phys_limit initialized
>>>>>>>> here instead of max_zone_phys().  This lets early reservation of
>>>>>>>> crash kernel memory which has a dependency on arm64_dma_phys_limit.
>>>>>>>> Reserving memory early for crash kernel allows linear creation of block
>>>>>>>> mappings (greater than page-granularity) for all the memory bank rangs.
>>>>>>>> In this scheme a comparatively quicker boot is observed.
>>>>>>>>
>>>>>>>> If ZONE_DMA configs are defined, crash kernel memory reservation
>>>>>>>> is delayed until DMA zone memory range size initialization performed in
>>>>>>>> zone_sizes_init().  The defer is necessary to steer clear of DMA zone
>>>>>>>> memory range to avoid overlap allocation.
>>>>>>>>
>>>>>>>> [[[
>>>>>>>> So crash kernel memory boundaries are not known when mapping all bank memory
>>>>>>>> ranges, which otherwise means not possible to exclude crash kernel range
>>>>>>>> from creating block mappings so page-granularity mappings are created for
>>>>>>>> the entire memory range.
>>>>>>>> ]]]"
>>>>>>>>
>>>>>>>> Namely, the init order: memblock init--->linear mem mapping(4k mapping for
>>>>>>>> crashkernel, requirinig page-granularity changing))--->zone dma
>>>>>>>> limit--->reserve crashkernel.
>>>>>>>> So when enable ZONE DMA and using crashkernel, the mem mapping using 4k
>>>>>>>> mapping.
>>>>>>>
>>>>>>> Yes, I understand that is how things work today but I'm saying that we may
>>>>>>> as well leave the crashkernel mapped (at block granularity) if
>>>>>>> !can_set_direct_map() and then I think your patch becomes a lot simpler.
>>>>>>
>>>>>> But Page-granularity mapppings are necessary for crash kernel memory range
>>>>>> for shrinking its size via /sys/kernel/kexec_crash_size interfac(Quoted from
>>>>>> arch/arm64/mm/init.c).
>>>>>> So this patch split block/section mapping to 4k page-granularity mapping for
>>>>>> crashkernel mem.
>>>>>
>>>>> Why? I don't see why the mapping granularity is relevant at all if we
>>>>> always leave the whole thing mapped.
>>>>>
>>>> There is another reason.
>>>>
>>>> When loading crashkernel finish, the do_kexec_load will use
>>>> arch_kexec_protect_crashkres to invalid all the pagetable for crashkernel
>>>> mem(protect crashkernel mem from access).
>>>>
>>>> arch_kexec_protect_crashkres--->set_memory_valid--->...--->apply_to_pmd_range
>>>>
>>>> In the apply_to_pmd_range, there is a judement： BUG_ON(pud_huge(*pud)). And
>>>> if the crashkernel use block/section mapping, there will be some error.
>>>>
>>>> Namely, it's need to use non block/section mapping for crashkernel mem
>>>> before shringking.
>>>
>>> Well, yes, but we can change arch_kexec_[un]protect_crashkres() not to do
>>> that if we're leaving the thing mapped, no?
>>>
>> I think we should use arch_kexec_[un]protect_crashkres for crashkernel mem.
>>
>> Because when invalid crashkernel mem pagetable, there is no chance to rd/wr
>> the crashkernel mem by mistake.
>>
>> If we don't use arch_kexec_[un]protect_crashkres to invalid crashkernel mem
>> pagetable, there maybe some write operations to these mem by mistake which
>> may cause crashkernel boot error and vmcore saving error.
> 
> I don't really buy this line of reasoning. The entire main kernel is
> writable, so why do we care about protecting the crashkernel so much? The
> _code_ to launch the crash kernel is writable! If you care about preventing
> writes to memory which should not be writable, then you should use
> rodata=full.
> 
> Will
Thanks.

1.I think the normal kernel mem can be writeable or readonly

2.But the normal kernel should't access(read/write) crashkernel mem 
after the crashkernel is loaded to the mem.(despite the normal kernel 
write/read access protect)
So invalid pagetable for crashkernel mem is needed.

With this method, it can guarantee the usability of the crashkernel when 
occuring emergency and generating vmcore.
