Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7638256A8E8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbiGGRCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbiGGRCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:02:50 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAC95A461
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 10:02:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VIefA1B_1657213358;
Received: from 30.39.247.202(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VIefA1B_1657213358)
          by smtp.aliyun-inc.com;
          Fri, 08 Jul 2022 01:02:40 +0800
Message-ID: <fba6017f-cadc-cf6f-8afb-832e42dd28e5@linux.alibaba.com>
Date:   Fri, 8 Jul 2022 01:02:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] arm64: mm: fix linear mem mapping access performance
 degradation
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
I think there is another way to handle it.

1.We can rebuild the crashkernel mem mapping firstly,
but [[[don't change the origin linear mapping]]].

2.Afterward, we can reuse the idmap_pg_dir and switch to it.
We use idmap_pg_dir to change the linear mapping which complyes with the 
TLB BBM.

