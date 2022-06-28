Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F56655DA0A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243230AbiF1B6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241298AbiF1B6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:58:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF4F201;
        Mon, 27 Jun 2022 18:58:06 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LX74Y4M2gzkWt6;
        Tue, 28 Jun 2022 09:56:45 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 09:58:04 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 09:58:02 +0800
Subject: Re: [PATCH v2 0/3] arm64: kdump: Function supplement and performance
 optimization
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Chen Zhou" <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
References: <20220621124249.1315-1-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <43d991e4-d0b0-1dd9-47ae-761746c20ab0@huawei.com>
Date:   Tue, 28 Jun 2022 09:58:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20220621124249.1315-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/21 20:42, Zhen Lei wrote:
> v1 --> v2:
> 1. Update the commit message of Patch 1, explicitly indicates that "crashkernel=X,high"
>    is specified but "crashkernel=Y,low" is not specified.
> 2. Drop Patch 4-5. Currently, focus on function integrity, performance optimization
>    will be considered in later versions.
> 3. Patch 3 is not mandatory, it's just a cleanup now, although it is a must for patch 4-5.
>    But to avoid subsequent duplication of effort, I'm glad it was accepted.

Hi Catalin:
  Do you have time to review Patch 1-2? Please ignore Patch 3, because now someone has
proposed the following new approach:

https://lore.kernel.org/linux-mm/1656241815-28494-1-git-send-email-guanghuifeng@linux.alibaba.com/T/

> 
> 
> v1:
> After the basic functions of "support reserving crashkernel above 4G on arm64
> kdump"(see https://lkml.org/lkml/2022/5/6/428) are implemented, we still have
> three features to be improved.
> 1. When crashkernel=X,high is specified but crashkernel=Y,low is not specified,
>    the default crash low memory size is provided.
> 2. For crashkernel=X without '@offset', if the low memory fails to be allocated,
>    fall back to reserve region from high memory(above DMA zones).
> 3. If crashkernel=X,high is used, page mapping is performed only for the crash
>    high memory, and block mapping is still used for other linear address spaces.
>    Compared to the previous version:
>    (1) For crashkernel=X[@offset], the memory above 4G is not changed to block
>        mapping, leave it to the next time.
>    (2) The implementation method is modified. Now the implementation is simpler
>        and clearer.
> 
> Zhen Lei (3):
>   arm64: kdump: Provide default size when crashkernel=Y,low is not
>     specified
>   arm64: kdump: Support crashkernel=X fall back to reserve region above
>     DMA zones
>   arm64: kdump: Remove some redundant checks in map_mem()
> 
>  .../admin-guide/kernel-parameters.txt         | 10 ++-----
>  arch/arm64/mm/init.c                          | 28 +++++++++++++++++--
>  arch/arm64/mm/mmu.c                           | 25 ++++++++---------
>  3 files changed, 39 insertions(+), 24 deletions(-)
> 

-- 
Regards,
  Zhen Lei
