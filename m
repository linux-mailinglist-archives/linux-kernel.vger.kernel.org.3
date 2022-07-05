Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FE4566FC8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiGENtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiGENsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:48:40 -0400
Received: from out199-16.us.a.mail.aliyun.com (out199-16.us.a.mail.aliyun.com [47.90.199.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C7B21832
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:17:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VISKJA4_1657027069;
Received: from 30.225.28.170(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VISKJA4_1657027069)
          by smtp.aliyun-inc.com;
          Tue, 05 Jul 2022 21:17:50 +0800
Message-ID: <51f7c840-f892-fa98-632b-4c06b76fb32a@linux.alibaba.com>
Date:   Tue, 5 Jul 2022 21:17:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] arm64: mm: fix linear mem mapping access performance
 degradation
To:     Mike Rapoport <rppt@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, baolin.wang@linux.alibaba.com,
        catalin.marinas@arm.com, akpm@linux-foundation.org,
        david@redhat.com, jianyong.wu@arm.com, james.morse@arm.com,
        quic_qiancai@quicinc.com, christophe.leroy@csgroup.eu,
        jonathan@marek.ca, mark.rutland@arm.com,
        thunder.leizhen@huawei.com, anshuman.khandual@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        geert+renesas@glider.be, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com
References: <4accaeda-572f-f72d-5067-2d0999e4d00a@linux.alibaba.com>
 <20220704131516.GC31684@willie-the-truck>
 <2ae1cae0-ee26-aa59-7ed9-231d67194dce@linux.alibaba.com>
 <20220704142313.GE31684@willie-the-truck>
 <6977c692-78ca-5a67-773e-0389c85f2650@linux.alibaba.com>
 <20220704163815.GA32177@willie-the-truck>
 <CAMj1kXEvY5QXOUrXZ7rBp9As=65uTTFRSSq+FPt-n4M2P-_VtQ@mail.gmail.com>
 <20220705095231.GB552@willie-the-truck>
 <5d044fdd-a61a-d60f-d294-89e17de37712@linux.alibaba.com>
 <20220705121115.GB1012@willie-the-truck> <YsQ07kvZX5sO2ov2@kernel.org>
From:   "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <YsQ07kvZX5sO2ov2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/7/5 20:56, Mike Rapoport 写道:
> On Tue, Jul 05, 2022 at 01:11:16PM +0100, Will Deacon wrote:
>> On Tue, Jul 05, 2022 at 08:07:07PM +0800, guanghui.fgh wrote:
>>>
>>> 1.The rodata full is harm to the performance and has been disabled in-house.
>>>
>>> 2.When using crashkernel with rodata non full, the kernel also will use non
>>> block/section mapping which cause high d-TLB miss and degrade performance
>>> greatly.
>>> This patch fix it to use block/section mapping as far as possible.
>>>
>>> bool can_set_direct_map(void)
>>> {
>>> 	return rodata_full || debug_pagealloc_enabled();
>>> }
>>>
>>> map_mem:
>>> if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
>>> 	flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>>
>>> 3.When rodata full is disabled, crashkernel also need protect(keep
>>> arch_kexec_[un]protect_crashkres using).
>>> I think crashkernel should't depend on radata full(Maybe other architecture
>>> don't support radata full now).
>>
>> I think this is going round in circles :/
>>
>> As a first step, can we please leave the crashkernel mapped unless
>> rodata=full? It should be a much simpler patch to write, review and maintain
>> and it gives you the performance you want when crashkernel is being used.
> 
> Since we are talking about large systems, what do you think about letting
> them set CRASH_ALIGN to PUD_SIZE, then
> 
> 	unmap(crashkernel);
> 	__create_pgd_mapping(crashkernel, NO_BLOCK_MAPPINGS);
> 
> should be enough to make crash kernel mapped with base pages.
>   
>> Will
> 
Thanks.

1.When kernel boots with crashkernel, the crashkernel parameters format is:
0M-2G:0M,2G-256G:256M,256G-1024G:320M,1024G-:384M which is self-adaption 
to multiple system.

2.As mentioned above, the crashkernel mem size maybe less than 
PUD_SIZE(Not multiple time to PUD_SIZE).
So, maybe we also need use some non block/section mappings.
