Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5EF5652DE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiGDK6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiGDK62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:58:28 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FE2B2F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:58:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VIKu7Cb_1656932300;
Received: from 30.225.28.131(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VIKu7Cb_1656932300)
          by smtp.aliyun-inc.com;
          Mon, 04 Jul 2022 18:58:21 +0800
Message-ID: <73f0c53b-fd17-c5e9-3773-1d71e564eb50@linux.alibaba.com>
Date:   Mon, 4 Jul 2022 18:58:20 +0800
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
From:   "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <20220704103523.GC31437@willie-the-truck>
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



在 2022/7/4 18:35, Will Deacon 写道:
> On Sat, Jul 02, 2022 at 11:57:53PM +0800, Guanghui Feng wrote:
>> The arm64 can build 2M/1G block/sectiion mapping. When using DMA/DMA32 zone
>> (enable crashkernel, disable rodata full, disable kfence), the mem_map will
>> use non block/section mapping(for crashkernel requires to shrink the region
>> in page granularity). But it will degrade performance when doing larging
>> continuous mem access in kernel(memcpy/memmove, etc).
> 
> Hmm. It seems a bit silly to me that we take special care to unmap the
> crashkernel from the linear map even when can_set_direct_map() is false, as
> we won't be protecting the main kernel at all!
> 
> Why don't we just leave the crashkernel mapped if !can_set_direct_map()
> and then this problem just goes away?
> 
> Will

This question had been asked lask week.


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
memory range to avoid overlap allocation.

[[[
So crash kernel memory boundaries are not known when mapping all bank 
memory ranges, which otherwise means not possible to exclude crash 
kernel range from creating block mappings so page-granularity mappings 
are created for the entire memory range.
]]]"

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
Init order: memblock init--->linear mem mapping(block/section mapping 
for linear mem mapping))--->zone dma limit--->reserve 
crashkernel--->[[[only]]] rebuild 4k pagesize mapping for crashkernel mem

With this method, there will use block/section mapping as far as possible.
