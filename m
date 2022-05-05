Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C6051B648
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 05:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240520AbiEEDI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 23:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240491AbiEEDI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 23:08:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B344C7B2
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 20:04:46 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ktz6h5kHlzfbNy;
        Thu,  5 May 2022 11:03:40 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 11:04:45 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 11:04:44 +0800
Message-ID: <42ca037f-e1ea-4b75-3819-fdccd17f6a29@huawei.com>
Date:   Thu, 5 May 2022 11:04:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 0/3] arm64: mm: Do not defer reserve_crashkernel()
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <vijayb@linux.microsoft.com>,
        <f.fainelli@gmail.com>
References: <20220411092455.1461-1-wangkefeng.wang@huawei.com>
 <YnFyYm93IVNlCQ4c@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YnFyYm93IVNlCQ4c@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/5/4 2:20, Catalin Marinas wrote:
> On Mon, Apr 11, 2022 at 05:24:52PM +0800, Kefeng Wang wrote:
>> Commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
>> platforms with no DMA memory zones"), this lets the kernel benifit
>> due to BLOCK_MAPPINGS, we could do more if ZONE_DMA and ZONE_DMA32
>> enabled.
>>
>> 1) Don't defer reserve_crashkernel() if only ZONE_DMA32
>> 2) Don't defer reserve_crashkernel() if ZONE_DMA with dma_force_32bit
>>     kernel parameter(newly added)
> I'm not really keen on a new kernel parameter for this. But even with
> such parameter, there is another series that allows crashkernel
> reservations above ZONE_DMA32, so that would also need
> NO_BLOCK_MAPPINGS, at least initially. I think there was a proposal to
> do the high reservation first and only defer the low one in ZONE_DMA but
> suggested we get the reservations sorted first and look at optimisations
> later.
OK, we could look it again after patch "support reserving crashkernel
above 4G on arm64 kdump".

The patch3 is a small cleanup, could you pick it up?

> If hardware is so bad with page mappings, I think we need to look at
> different ways to enable the block mappings, e.g. some safe break
> before make change of the mappings or maybe switching to another TTBR1
> during boot.
>
> Does FEAT_BBM level 2 allow us to change the block size without a break
> before make? I think that can still trigger a TLB conflict abort, maybe
> we can trap it and invalidate the TLBs (the conflict should be on the
> linear map not where the kernel image is mapped).

Block mapping is better than page mapping in some testcase(unixbench,
booting time, and mysql, maybe more). KFENCE will make the liner
mapping to page mapping too. If there is a new way to let's enable
the block mapping, that's great.
