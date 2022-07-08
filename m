Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B1D56B9AA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbiGHM22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 08:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiGHM20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:28:26 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E482E6B9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 05:28:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VIjXe4a_1657283299;
Received: from 30.225.28.127(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VIjXe4a_1657283299)
          by smtp.aliyun-inc.com;
          Fri, 08 Jul 2022 20:28:20 +0800
Message-ID: <f0dd1176-39f1-0a08-d0e2-627dd437aa5f@linux.alibaba.com>
Date:   Fri, 8 Jul 2022 20:28:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND v4] arm64: mm: fix linear mem mapping access
 performance degradation
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        baolin.wang@linux.alibaba.com, akpm@linux-foundation.org,
        david@redhat.com, jianyong.wu@arm.com, james.morse@arm.com,
        quic_qiancai@quicinc.com, christophe.leroy@csgroup.eu,
        jonathan@marek.ca, mark.rutland@arm.com,
        thunder.leizhen@huawei.com, anshuman.khandual@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        geert+renesas@glider.be, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com
References: <5d044fdd-a61a-d60f-d294-89e17de37712@linux.alibaba.com>
 <20220705121115.GB1012@willie-the-truck> <YsRSajyMxahXe7ZS@kernel.org>
 <YsRZ8V8mQ+HM31D6@arm.com> <YsRfgX7FFZLxQU50@kernel.org>
 <YsRvPTORdvIwzShL@arm.com> <YsSi9HAOOzbPYN+w@kernel.org>
 <YsVeKPzaO0SJdwFW@arm.com> <YsWULnvZZxoHtyRo@kernel.org>
 <9974bea5-4db9-0104-c9c9-d9b49c390f1b@linux.alibaba.com>
 <YsWtCLIG2qKETqmq@arm.com>
From:   "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <YsWtCLIG2qKETqmq@arm.com>
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

Thanks.

在 2022/7/6 23:40, Catalin Marinas 写道:
> On Wed, Jul 06, 2022 at 11:18:22PM +0800, guanghui.fgh wrote:
>> 在 2022/7/6 21:54, Mike Rapoport 写道:
>>> One thing I can think of is to only remap the crash kernel memory if it is
>>> a part of an allocation that exactly fits into one ore more PUDs.
>>>
>>> Say, in reserve_crashkernel() we try the memblock_phys_alloc() with
>>> PUD_SIZE as alignment and size rounded up to PUD_SIZE. If this allocation
>>> succeeds, we remap the entire area that now contains only memory allocated
>>> in reserve_crashkernel() and free the extra memory after remapping is done.
>>> If the large allocation fails, we fall back to the original size and
>>> alignment and don't allow unmapping crash kernel memory in
>>> arch_kexec_protect_crashkres().
>>
>> There is a new method.
>> I think we should use the patch v3(similar but need add some changes)
>>
>> 1.We can walk crashkernle block/section pagetable,
>> [[[(keep the origin block/section mapping valid]]]
>> rebuild the pte level page mapping for the crashkernel mem
>> rebuild left & right margin mem(which is in same block/section mapping but
>> out of crashkernel mem) with block/section mapping
>>
>> 2.'replace' the origin block/section mapping by new builded mapping
>> iterately
>>
>> With this method, all the mem mapping keep valid all the time.
> 
> As I already commented on one of your previous patches, this is not
> allowed by the architecture. If FEAT_BBM is implemented (ARMv8.4 I
> think), the worst that can happen is a TLB conflict abort and the
> handler should invalidate the TLBs and restart the faulting instruction,
> assuming the handler won't try to access the same conflicting virtual
> address. Prior to FEAT_BBM, that's not possible as the architecture does
> not describe a precise behaviour of conflicting TLB entries (you might
> as well get the TLB output of multiple entries being or'ed together).
> 

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
