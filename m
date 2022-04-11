Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05174FB5F6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343804AbiDKIah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343797AbiDKIad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:30:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACAD3E5E2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:28:19 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KcMPY62ZDzFpkk;
        Mon, 11 Apr 2022 16:25:53 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 16:28:15 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 16:28:15 +0800
Message-ID: <73e5583d-2f32-8837-e32a-93f127f0a40b@huawei.com>
Date:   Mon, 11 Apr 2022 16:28:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 resend 2/3] arm64: mm: Don't defer
 reserve_crashkernel() with dma_force_32bit
Content-Language: en-US
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <f.fainelli@gmail.com>
References: <20220331074055.125824-1-wangkefeng.wang@huawei.com>
 <20220331074055.125824-3-wangkefeng.wang@huawei.com>
 <d5d123db-f326-de86-6978-2f328242a35a@linux.microsoft.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <d5d123db-f326-de86-6978-2f328242a35a@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/2 6:09, Vijay Balakrishna wrote:
>
>
> On 3/31/2022 12:40 AM, Kefeng Wang wrote:
>> ARM64 enable ZONE_DMA by default, and with ZONE_DMA crash kernel
>> memory reservation is delayed until DMA zone memory range size
>> initilazation performed in zone_sizes_init(), but for most platforms
>> use 32bit dma_zone_bits, so add dma_force_32bit kernel parameter
>> if ZONE_DMA enabled, and initialize arm64_dma_phys_limit to
>> dma32_phys_limit in arm64_memblock_init() if dma_force_32bit
>> is setup, this could let the crash kernel reservation earlier,
>> and allows linear creation with block mapping.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>
> I don't see any problem with the approach.  Hope you or someone can 
> test to make sure no surprises on RPi4 with the proposed change.  I do 
> understand on RPi4 --
>
> - both ZONE_DMA and ZONE_DMA32 are enabled
> - one wouldn't use dma_force_32bit kernel parameter
> - crashkernel_could_early_reserve() would return false to preserve 
> late reserve of crash kernel memory
>
I don't have RPi4, I tested following cases on qemu

1) only with ZONE_DMA

     1.1) only with ZONE_DMA and with dma_force_32bit

2) only with ZONE_DMA32

3) with ZONE_DMA and ZONE_DMA32

    3.1) with ZONE_DMA and ZONE_DMA32 and with dma_force_32bit

> nit --
> - consider renaming crashkernel_could_early_reserve() => 
> crashkernel_early_reserve()
>
Sure.
> Reviewed-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
>
Thanks.
