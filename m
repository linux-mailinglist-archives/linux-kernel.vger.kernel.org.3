Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114B856BB67
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 16:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238288AbiGHOAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiGHOAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:00:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF2F317586
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 07:00:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 070901063;
        Fri,  8 Jul 2022 07:00:38 -0700 (PDT)
Received: from [10.57.86.102] (unknown [10.57.86.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A2523F66F;
        Fri,  8 Jul 2022 07:00:34 -0700 (PDT)
Message-ID: <3316f487-a826-1777-0c4b-7cfa89612af9@arm.com>
Date:   Fri, 8 Jul 2022 15:00:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] arm64: mm: fix linear mapping mem access performance
 degradation
Content-Language: en-GB
To:     "guanghui.fgh" <guanghuifeng@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     baolin.wang@linux.alibaba.com, will@kernel.org,
        akpm@linux-foundation.org, david@redhat.com, jianyong.wu@arm.com,
        james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@kernel.org,
        geert+renesas@glider.be, ardb@kernel.org, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com
References: <1656586222-98555-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <Yr8tzOJi5CGBl767@arm.com>
 <4cc8284a-6162-8f9d-50b3-e594d46751f8@linux.alibaba.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <4cc8284a-6162-8f9d-50b3-e594d46751f8@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-08 13:13, guanghui.fgh wrote:
> Thanks.
> 
> 在 2022/7/2 1:24, Catalin Marinas 写道:
>> On Thu, Jun 30, 2022 at 06:50:22PM +0800, Guanghui Feng wrote:
>>> +static void init_pmd_remap(pud_t *pudp, unsigned long addr, unsigned 
>>> long end,
>>> +               phys_addr_t phys, pgprot_t prot,
>>> +               phys_addr_t (*pgtable_alloc)(int), int flags)
>>> +{
>>> +    unsigned long next;
>>> +    pmd_t *pmdp;
>>> +    phys_addr_t map_offset;
>>> +    pmdval_t pmdval;
>>> +
>>> +    pmdp = pmd_offset(pudp, addr);
>>> +    do {
>>> +        next = pmd_addr_end(addr, end);
>>> +
>>> +        if (!pmd_none(*pmdp) && pmd_sect(*pmdp)) {
>>> +            phys_addr_t pte_phys = pgtable_alloc(PAGE_SHIFT);
>>> +            pmd_clear(pmdp);
>>> +            pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN;
>>> +            if (flags & NO_EXEC_MAPPINGS)
>>> +                pmdval |= PMD_TABLE_PXN;
>>> +            __pmd_populate(pmdp, pte_phys, pmdval);
>>> +            flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>>
>> This doesn't follow the architecture requirements for "break before
>> make" when changing live page tables. While it may work, it risks
>> triggering a TLB conflict abort. The correct sequence normally is:
>>
>>     pmd_clear();
>>     flush_tlb_kernel_range();
>>     __pmd_populate();
>>
>> However, do we have any guarantees that the kernel doesn't access the
>> pmd range being unmapped temporarily? The page table itself might live
>> in one of these sections, so set_pmd() etc. can get a translation fault.
>>
> Thanks.
> 
> The cpu can generate a TLB conflict abort if it detects that the address 
> being looked up in the TLB hits multiple entries.
> 
> (1).I think when gathering small page to block/section mapping, there 
> maybe tlb conflict if no complying with BBM.
> 
> Namely:
> a.Map a 4KB page (address X)
>    Touch that page, in order to get the translation cached in the TLB
> 
> b.Modify the translation tables
>    replacing the mapping for address X with a 2MB mapping - DO NOT 
> INVALIDATE the TLB
> 
> c.Touch "X + 4KB"
>    This will/should miss in the TLB, causing a new walk returning the 
> 2MB mapping
> 
> d.Touch X
>    Assuming they've not been evicted, you'll hit both on the 4KB and 2MB 
> mapping - as both cover address X.
> 
> There is tlb conflict.
> (link: 
> https://community.arm.com/support-forums/f/dev-platforms-forum/13583/tlb-conflict-abort) 
> 
> 
> 
> 
> (2).But when spliting large block/section mapping to small granularity, 
> there maybe no tlb conflict.
> 
> Namely:
> a.rebuild the pte level mapping without any change to orgin pagetable
>    (the relation between virtual address and physicall address keep same)
> 
> b.modify 1G mappting to use the new pte level mapping in the [[[mem]]] 
> without tlb flush
> 
> c.When the cpu access the 1G mem(anywhere),
>    If 1G tlb entry already cached in tlb, all the 1G mem will access 
> success(without any tlb loaded, no confilict)

No. The CPU could still have prefetched the new table entry for any 
reason as soon as it became visible, then raise an abort when it 
realises it already has a leaf entry cached for that address range. Or 
worse, *not* raise an abort but instead use "An amalgamation of the old 
and new data or control values" for the resulting translation (see 
K1.2.3 "CONSTRAINED UNPREDICTABLE behaviors due to caching of control or 
data values" in the Armv8 ARM) and quietly corrupt memory elsewhere.

Robin.

> 
>    If 1G tlb entry has been evicted, then the tlb will access pagetable 
> in mem(despite the cpu "catch" the old(1G) or new(4k) mapped pagetale in 
> the mem, all the 1G mem can access sucess)(load new tlb entry, no conflict)
> 
> d.Afterward, we flush the tlb and force cpu use the new pagetable.(no 
> conflict)
> 
> It seems that there are no two tlb entries for a same virtual address in 
> the tlb cache When spliting large block/section mapping.
> 
> 
> 
> (3).At the same time, I think we can use another way.
> As the system linear maping is builded with init_pg_dir, we can also 
> resue the init_pg_dir to split the block/setion mapping sometime.
> As init_pg_dir contain all kernel text/data access and we can comply 
> with the BBM requirement.
> 
> a.rebuild new pte level mapping without any change to the old 
> mapping(the cpu can't walk access the new page mapping, it's isolated)
> 
> b.change to use init_pg_dir
> 
> c.clear the old 1G block mapping and flush tlb
> 
> d.modify the linear mapping to use new pte level page mapping with 
> init_pg_dir(TLB BBM)
> 
> e.switch to swapper_pg_dir
> 
> 
> Could you give me some advice?
> 
> Thanks.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
