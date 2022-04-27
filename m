Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D832511706
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiD0MpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbiD0Mo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:44:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BC27093C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:41:45 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KpJGM1lSgzGpRr;
        Wed, 27 Apr 2022 20:39:07 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 20:41:44 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 20:41:43 +0800
Message-ID: <11e852cb-911b-7f02-9471-2e05b3801770@huawei.com>
Date:   Wed, 27 Apr 2022 20:41:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 0/3] arm64: mm: Do not defer reserve_crashkernel()
Content-Language: en-US
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <vijayb@linux.microsoft.com>, <f.fainelli@gmail.com>
References: <20220411092455.1461-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220411092455.1461-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin and Will, any comments, thanks.

On 2022/4/11 17:24, Kefeng Wang wrote:
> Commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
> platforms with no DMA memory zones"), this lets the kernel benifit
> due to BLOCK_MAPPINGS, we could do more if ZONE_DMA and ZONE_DMA32
> enabled.
>
> 1) Don't defer reserve_crashkernel() if only ZONE_DMA32
> 2) Don't defer reserve_crashkernel() if ZONE_DMA with dma_force_32bit
>     kernel parameter(newly added)
>
> Here is another case to show the benefit of the block mapping.
>
> Unixbench benchmark result shows between the block mapping and page mapping.
> ----------------+------------------+-------------------
>          	| block mapping    |   page mapping
> ----------------+------------------+-------------------
> Process Creation|  5,030.7         |    4,711.8
> (in unixbench)  |                  |
> ----------------+------------------+-------------------
>
> note: RODATA_FULL_DEFAULT_ENABLED is not enabled
>
> v3:
> - renaming crashkernel_could_early_reserve() to crashkernel_early_reserve()
> - drop dma32_phys_limit, directly use max_zone_phys(32)
> - fix no previous prototype issue
> - add RB of Vijay to patch2/3
> v2 resend:
> - fix build error reported-by lkp
> v2:
> - update patch1 according to Vijay and Florian, and RB of Vijay
> - add new patch2
>
> Kefeng Wang (3):
>    arm64: mm: Do not defer reserve_crashkernel() if only ZONE_DMA32
>    arm64: mm: Don't defer reserve_crashkernel() with dma_force_32bit
>    arm64: mm: Cleanup useless parameters in zone_sizes_init()
>
>   arch/arm64/include/asm/kexec.h |  1 +
>   arch/arm64/mm/init.c           | 60 ++++++++++++++++++++++++----------
>   arch/arm64/mm/mmu.c            |  6 ++--
>   3 files changed, 46 insertions(+), 21 deletions(-)
>
