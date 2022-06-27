Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A9B55D060
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiF0KrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiF0Kq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:46:58 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0ED642B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:46:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VHZ5z42_1656326810;
Received: from 30.225.28.167(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VHZ5z42_1656326810)
          by smtp.aliyun-inc.com;
          Mon, 27 Jun 2022 18:46:52 +0800
Message-ID: <ae5c6c07-1d49-ffd2-6f62-69df4308d0bb@linux.alibaba.com>
Date:   Mon, 27 Jun 2022 18:46:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] arm64: mm: fix linear mapping mem access performace
 degradation
To:     Mike Rapoport <rppt@kernel.org>
Cc:     baolin.wang@linux.alibaba.com, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        jianyong.wu@arm.com, james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, geert+renesas@glider.be,
        ardb@kernel.org, linux-mm@kvack.org
References: <1656241815-28494-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <YrlPfjv2Wf/C77DI@kernel.org>
 <4d18d303-aeed-0beb-a8a4-32893f2d438d@linux.alibaba.com>
 <Yrl9FcVv1wZ5MnRp@kernel.org>
From:   "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <Yrl9FcVv1wZ5MnRp@kernel.org>
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



在 2022/6/27 17:49, Mike Rapoport 写道:
> Please don't post HTML.
> 
> On Mon, Jun 27, 2022 at 05:24:10PM +0800, guanghui.fgh wrote:
>> Thanks.
>>
>> 在 2022/6/27 14:34, Mike Rapoport 写道:
>>
>>      On Sun, Jun 26, 2022 at 07:10:15PM +0800, Guanghui Feng wrote:
>>
>>          The arm64 can build 2M/1G block/sectiion mapping. When using DMA/DMA32 zone
>>          (enable crashkernel, disable rodata full, disable kfence), the mem_map will
>>          use non block/section mapping(for crashkernel requires to shrink the region
>>          in page granularity). But it will degrade performance when doing larging
>>          continuous mem access in kernel(memcpy/memmove, etc).
>>
>>          There are many changes and discussions:
>>          commit 031495635b46
>>          commit 1a8e1cef7603
>>          commit 8424ecdde7df
>>          commit 0a30c53573b0
>>          commit 2687275a5843
>>
>>      Please include oneline summary of the commit. (See section "Describe your
>>      changes" in Documentation/process/submitting-patches.rst)
>>
>> OK, I will add oneline summary in the git commit messages.
>>
>>          This patch changes mem_map to use block/section mapping with crashkernel.
>>          Firstly, do block/section mapping(normally 2M or 1G) for all avail mem at
>>          mem_map, reserve crashkernel memory. And then walking pagetable to split
>>          block/section mapping to non block/section mapping(normally 4K) [[[only]]]
>>          for crashkernel mem.
>>
>>      This already happens when ZONE_DMA/ZONE_DMA32 are disabled. Please explain
>>      why is it Ok to change the way the memory is mapped with
>>      ZONE_DMA/ZONE_DMA32 enabled.
>>
>> In short:
>>
>> 1.building all avail mem with block/section mapping（normally 1G/2M） without
>> inspecting crashkernel
>> 2. Reserve crashkernel mem as same as previous doing
>> 3. only change the crashkernle mem mapping to normal mapping(normally 4k).
>> With this method, there are block/section mapping as more as possible.
> 
> This does not answer the question why changing the way the memory is mapped
> when there is ZONE_DMA/DMA32 and crashkernel won't cause a regression.
> 
1.Quoted messages from arch/arm64/mm/init.c

"Memory reservation for crash kernel either done early or deferred
depending on DMA memory zones configs (ZONE_DMA) --

In absence of ZONE_DMA configs arm64_dma_phys_limit initialized
here instead of max_zone_phys().  This lets early reservation of
crash kernel memory which has a dependency on arm64_dma_phys_limit.
Reserving memory early for crash kernel allows linear creation of block
mappings (greater than page-granularity) for all the memory bank rangs.
In this scheme a comparatively quicker boot is observed.

If ZONE_DMA configs are defined, crash kernel memory reservation
is delayed until DMA zone memory range size initialization performed in
zone_sizes_init().  The defer is necessary to steer clear of DMA zone
memory range to avoid overlap allocation.  So crash kernel memory 
boundaries are not known when mapping all bank memory ranges, which 
otherwise means not possible to exclude crash kernel range from creating 
block mappings so page-granularity mappings are created for the entire 
memory range."

Namely, the init order: memblock init--->linear mem mapping(4k mapping 
for crashkernel, requirinig page-granularity changing))--->zone dma 
limit--->reserve crashkernel.
So when enable ZONE DMA and using crashkernel, the mem mapping using 4k 
mapping.

2.As mentioned above, when linear mem use 4k mapping simply, there is 
high dtlb miss(degrade performance).
This patch use block/section mapping as far as possible with performance 
improvement.

3.This patch reserve crashkernel as same as the history(ZONE DMA & 
crashkernel reserving order), and only change the linear mem mapping to 
block/section mapping.
