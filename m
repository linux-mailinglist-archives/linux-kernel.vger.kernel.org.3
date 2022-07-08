Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F12256B963
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbiGHMNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 08:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238166AbiGHMNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:13:23 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA81B9CE36
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 05:13:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VIjYhF9_1657282395;
Received: from 30.225.28.127(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VIjYhF9_1657282395)
          by smtp.aliyun-inc.com;
          Fri, 08 Jul 2022 20:13:17 +0800
Message-ID: <4cc8284a-6162-8f9d-50b3-e594d46751f8@linux.alibaba.com>
Date:   Fri, 8 Jul 2022 20:13:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] arm64: mm: fix linear mapping mem access performance
 degradation
To:     Catalin Marinas <catalin.marinas@arm.com>
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
From:   "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <Yr8tzOJi5CGBl767@arm.com>
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

Thanks.

在 2022/7/2 1:24, Catalin Marinas 写道:
> On Thu, Jun 30, 2022 at 06:50:22PM +0800, Guanghui Feng wrote:
>> +static void init_pmd_remap(pud_t *pudp, unsigned long addr, unsigned long end,
>> +			   phys_addr_t phys, pgprot_t prot,
>> +			   phys_addr_t (*pgtable_alloc)(int), int flags)
>> +{
>> +	unsigned long next;
>> +	pmd_t *pmdp;
>> +	phys_addr_t map_offset;
>> +	pmdval_t pmdval;
>> +
>> +	pmdp = pmd_offset(pudp, addr);
>> +	do {
>> +		next = pmd_addr_end(addr, end);
>> +
>> +		if (!pmd_none(*pmdp) && pmd_sect(*pmdp)) {
>> +			phys_addr_t pte_phys = pgtable_alloc(PAGE_SHIFT);
>> +			pmd_clear(pmdp);
>> +			pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN;
>> +			if (flags & NO_EXEC_MAPPINGS)
>> +				pmdval |= PMD_TABLE_PXN;
>> +			__pmd_populate(pmdp, pte_phys, pmdval);
>> +			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> 
> This doesn't follow the architecture requirements for "break before
> make" when changing live page tables. While it may work, it risks
> triggering a TLB conflict abort. The correct sequence normally is:
> 
> 	pmd_clear();
> 	flush_tlb_kernel_range();
> 	__pmd_populate();
> 
> However, do we have any guarantees that the kernel doesn't access the
> pmd range being unmapped temporarily? The page table itself might live
> in one of these sections, so set_pmd() etc. can get a translation fault.
> 
Thanks.

The cpu can generate a TLB conflict abort if it detects that the address 
being looked up in the TLB hits multiple entries.

(1).I think when gathering small page to block/section mapping, there 
maybe tlb conflict if no complying with BBM.

Namely:
a.Map a 4KB page (address X)
   Touch that page, in order to get the translation cached in the TLB

b.Modify the translation tables
   replacing the mapping for address X with a 2MB mapping - DO NOT 
INVALIDATE the TLB

c.Touch "X + 4KB"
   This will/should miss in the TLB, causing a new walk returning the 
2MB mapping

d.Touch X
   Assuming they've not been evicted, you'll hit both on the 4KB and 2MB 
mapping - as both cover address X.

There is tlb conflict.
(link: 
https://community.arm.com/support-forums/f/dev-platforms-forum/13583/tlb-conflict-abort)



(2).But when spliting large block/section mapping to small granularity, 
there maybe no tlb conflict.

Namely:
a.rebuild the pte level mapping without any change to orgin pagetable
   (the relation between virtual address and physicall address keep same)

b.modify 1G mappting to use the new pte level mapping in the [[[mem]]] 
without tlb flush

c.When the cpu access the 1G mem(anywhere),
   If 1G tlb entry already cached in tlb, all the 1G mem will access 
success(without any tlb loaded, no confilict)

   If 1G tlb entry has been evicted, then the tlb will access pagetable 
in mem(despite the cpu "catch" the old(1G) or new(4k) mapped pagetale in 
the mem, all the 1G mem can access sucess)(load new tlb entry, no conflict)

d.Afterward, we flush the tlb and force cpu use the new pagetable.(no 
conflict)

It seems that there are no two tlb entries for a same virtual address in 
the tlb cache When spliting large block/section mapping.



(3).At the same time, I think we can use another way.
As the system linear maping is builded with init_pg_dir, we can also 
resue the init_pg_dir to split the block/setion mapping sometime.
As init_pg_dir contain all kernel text/data access and we can comply 
with the BBM requirement.

a.rebuild new pte level mapping without any change to the old 
mapping(the cpu can't walk access the new page mapping, it's isolated)

b.change to use init_pg_dir

c.clear the old 1G block mapping and flush tlb

d.modify the linear mapping to use new pte level page mapping with 
init_pg_dir(TLB BBM)

e.switch to swapper_pg_dir


Could you give me some advice?

Thanks.
