Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAB953F703
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbiFGHQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbiFGHQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:16:39 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D7A56758
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:16:36 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LHM7C62txz1KCkF;
        Tue,  7 Jun 2022 15:14:47 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 15:16:35 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 15:16:34 +0800
Subject: Re: [PATCH] ARM: Mark the FDT_FIXED sections as shareable
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>
References: <20220606124858.384-1-thunder.leizhen@huawei.com>
 <CAMj1kXGCbCnV6FGTq2pBosqBTVv3B8WpNnOuiV0eSgvBMO-+8A@mail.gmail.com>
 <CAMj1kXEoL32qV_xKb9ueBoJFboif2hEC_2+m-4bD5BdDnaES9w@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <e36e3bae-45fc-c3ab-6abe-0f1ac0a71f47@huawei.com>
Date:   Tue, 7 Jun 2022 15:16:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXEoL32qV_xKb9ueBoJFboif2hEC_2+m-4bD5BdDnaES9w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/7 1:12, Ard Biesheuvel wrote:
> On Mon, 6 Jun 2022 at 17:52, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> Hello Zhen Lei,
>>
>> On Mon, 6 Jun 2022 at 14:49, Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>>
>>> commit 7a1be318f579 ("ARM: 9012/1: move device tree mapping out of linear
>>> region") use FDT_FIXED_BASE to map the whole FDT_FIXED_SIZE memory area
>>> which contains fdt. But it only reserves the exact physical memory that
>>> fdt occupied. Unfortunately, this mapping is non-shareable. An illegal or
>>> speculative read access can bring the RAM content from non-fdt zone into
>>> cache, PIPT makes it to be hit by subsequently read access through
>>> shareable mapping(such as linear mapping), and the cache consistency
>>> between cores is lost due to non-shareable property.
>>>
>>> |<---------FDT_FIXED_SIZE------>|
>>> |                               |
>>>  -------------------------------
>>> | <non-fdt> | <fdt> | <non-fdt> |
>>>  -------------------------------
>>>
>>> 1. CoreA read <non-fdt> through MT_ROM mapping, the old data is loaded
>>>    into the cache.
>>> 2. CoreB write <non-fdt> to update data through linear mapping. CoreA
>>>    received the notification to invalid the corresponding cachelines, but
>>>    the property non-shareable makes it to be ignored.
>>> 3. CoreA read <non-fdt> through linear mapping, cache hit, the old data
>>>    is read.
>>>
>>
>> Thanks for the excellent write-up, and for what must have been a lot
>> of work to narrow down and diagnose!

Yes, it took a lot of time, a lot of boards.

>>
>>> To eliminate this risk, mark the MT_ROM sections as shareable.
>>>
>>> The other user of MT_ROM is XIP_KERNEL. XIP allows the kernel to run from
>>> flash to save RAM space. Not sure if anyone is still using XIP in order to
>>> save a little memory and not care about performance degradation. Add a new
>>> memory type MT_ROM_XIP to be compatible with it.
>>>
>>> BTW: Another solution is to memblock_reserve() all the sections that fdt
>>> spans, but this will waste 2-4MiB memory.
>>>
>>
>> I agree that we should not add shareable attributes to the memory type
>> used by XIP kernels for code regions: NOR flash is not usually
>> integrated in a way that allows it to participate in the coherency
>> protocol, so that will likely break things.
>>
>> I think, though, that it would be better to leave MT_ROM alone, and
>> introduce a new type MT_MEMORY_RO instead, which is wired up in the
>> right way (see below), so that we get NX attributes, and can use it to
>> create non-section mappings as well.

Right, NX should also be set. I will try MT_MEMORY_RO.

>>
>> Then, as a followup which does not need to go into -stable, we can
>> reduce the size of the mapping: there is really no need for the
>> permanent mapping to be section granular - this is only for the early
>> asm code that is not able to create 2 levels of page tables.
>>
> 
> Actually, on second thought, I think reducing the size of the FDT
> mapping is also needed for correctness, as the non-fdt regions could
> potentially be covered by a no-map memory reservation, or get mapped
> non-cacheable for things like non-coherent DMA.

I'll keep the section mapping first, because the fix for adding the
shareable attribute is explicit.

> .
> 

-- 
Regards,
  Zhen Lei
