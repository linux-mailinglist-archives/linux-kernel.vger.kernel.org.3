Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAC2566ECD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiGEMzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbiGEMyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:54:21 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B234A27FE7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:28:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VISH683_1657024024;
Received: from 30.225.28.170(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VISH683_1657024024)
          by smtp.aliyun-inc.com;
          Tue, 05 Jul 2022 20:27:05 +0800
Message-ID: <db979439-8a51-d6d7-cd09-b5b7c1f93f48@linux.alibaba.com>
Date:   Tue, 5 Jul 2022 20:27:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] arm64: mm: fix linear mem mapping access performance
 degradation
To:     Will Deacon <will@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, baolin.wang@linux.alibaba.com,
        catalin.marinas@arm.com, akpm@linux-foundation.org,
        david@redhat.com, jianyong.wu@arm.com, james.morse@arm.com,
        quic_qiancai@quicinc.com, christophe.leroy@csgroup.eu,
        jonathan@marek.ca, mark.rutland@arm.com,
        thunder.leizhen@huawei.com, anshuman.khandual@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rppt@kernel.org, geert+renesas@glider.be, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com
References: <20220704111402.GA31553@willie-the-truck>
 <4accaeda-572f-f72d-5067-2d0999e4d00a@linux.alibaba.com>
 <20220704131516.GC31684@willie-the-truck>
 <2ae1cae0-ee26-aa59-7ed9-231d67194dce@linux.alibaba.com>
 <20220704142313.GE31684@willie-the-truck>
 <6977c692-78ca-5a67-773e-0389c85f2650@linux.alibaba.com>
 <20220704163815.GA32177@willie-the-truck>
 <CAMj1kXEvY5QXOUrXZ7rBp9As=65uTTFRSSq+FPt-n4M2P-_VtQ@mail.gmail.com>
 <20220705095231.GB552@willie-the-truck>
 <5d044fdd-a61a-d60f-d294-89e17de37712@linux.alibaba.com>
 <20220705121115.GB1012@willie-the-truck>
From:   "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <20220705121115.GB1012@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/7/5 20:11, Will Deacon 写道:
> On Tue, Jul 05, 2022 at 08:07:07PM +0800, guanghui.fgh wrote:
>>
>>
>> 在 2022/7/5 17:52, Will Deacon 写道:
>>> On Mon, Jul 04, 2022 at 07:09:23PM +0200, Ard Biesheuvel wrote:
>>>> On Mon, 4 Jul 2022 at 18:38, Will Deacon <will@kernel.org> wrote:
>>>>>
>>>>> On Mon, Jul 04, 2022 at 10:34:07PM +0800, guanghui.fgh wrote:
>>>>>> Thanks.
>>>>>>
>>>>>> 在 2022/7/4 22:23, Will Deacon 写道:
>>>>>>> On Mon, Jul 04, 2022 at 10:11:27PM +0800, guanghui.fgh wrote:
>>>> ...
>>>>>>>> Namely, it's need to use non block/section mapping for crashkernel mem
>>>>>>>> before shringking.
>>>>>>>
>>>>>>> Well, yes, but we can change arch_kexec_[un]protect_crashkres() not to do
>>>>>>> that if we're leaving the thing mapped, no?
>>>>>>>
>>>>>> I think we should use arch_kexec_[un]protect_crashkres for crashkernel mem.
>>>>>>
>>>>>> Because when invalid crashkernel mem pagetable, there is no chance to rd/wr
>>>>>> the crashkernel mem by mistake.
>>>>>>
>>>>>> If we don't use arch_kexec_[un]protect_crashkres to invalid crashkernel mem
>>>>>> pagetable, there maybe some write operations to these mem by mistake which
>>>>>> may cause crashkernel boot error and vmcore saving error.
>>>>>
>>>>> I don't really buy this line of reasoning. The entire main kernel is
>>>>> writable, so why do we care about protecting the crashkernel so much? The
>>>>> _code_ to launch the crash kernel is writable! If you care about preventing
>>>>> writes to memory which should not be writable, then you should use
>>>>> rodata=full.
>>>>>
>>>>
>>>> This is not entirely true - the core kernel text and rodata are
>>>> remapped r/o in the linear map, whereas all module code and rodata are
>>>> left writable when rodata != full.
>>>
>>> Yes, sorry, you're quite right. The kernel text is only writable if
>>> rodata=off.
>>>
>>> But I still think it makes sense to protect the crashkernel only if
>>> rodata=full (which is the default on arm64) as this allows us to rely
>>> on page mappings and I think fits well with what we do for modules.
>>>
>>>> But the conclusion is the same, imo: if you can't be bothered to
>>>> protect a good chunk of the code and rodata that the kernel relies on,
>>>> why should the crashkernel be treated any differently?
>>>
>>> Thanks.
>>>
>>> Will
>> Thanks.
>>
>> 1.The rodata full is harm to the performance and has been disabled in-house.
>>
>> 2.When using crashkernel with rodata non full, the kernel also will use non
>> block/section mapping which cause high d-TLB miss and degrade performance
>> greatly.
>> This patch fix it to use block/section mapping as far as possible.
>>
>> bool can_set_direct_map(void)
>> {
>> 	return rodata_full || debug_pagealloc_enabled();
>> }
>>
>> map_mem:
>> if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
>> 	flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>
>> 3.When rodata full is disabled, crashkernel also need protect(keep
>> arch_kexec_[un]protect_crashkres using).
>> I think crashkernel should't depend on radata full(Maybe other architecture
>> don't support radata full now).
> 
> I think this is going round in circles :/
> 
> As a first step, can we please leave the crashkernel mapped unless
> rodata=full? It should be a much simpler patch to write, review and maintain
> and it gives you the performance you want when crashkernel is being used.
> 
> Will

Thanks.

There is a circle.

1.When the rodata is non full, there will be some error when calling 
arch_kexec_[un]protect_crashkres(BUG_ON(pud_huge(*pud))) now.
It's also need non-block/section mapping for crashkernel mem.

2.In other words, maybe we should change 
arch_kexec_[un]protect_crashkres to support block/section mapping which 
can leave crashkernel block/section mapping.

But when we shrink the crashkernel mem, we also need to split some 
block/section mapping(part mem for crashkernel, the left for the normal 
kernel).
As a result, maybe we build crashkernel mem with non-block/section 
mapping is appropriate(as this patch doing).
