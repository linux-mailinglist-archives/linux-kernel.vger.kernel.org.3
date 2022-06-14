Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687D754A783
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 05:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350958AbiFNDVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 23:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239630AbiFNDVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 23:21:11 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3942E69F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 20:21:10 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LMYbw2jZQzDrDr;
        Tue, 14 Jun 2022 11:20:44 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 11:21:08 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 11:21:08 +0800
Message-ID: <9a6e61da-0a5c-02bb-d769-98cf1f602de8@huawei.com>
Date:   Tue, 14 Jun 2022 11:21:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 0/6] arm64: Cleanup ioremap() and support
 ioremap_prot()
Content-Language: en-US
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <hch@infradead.org>, <arnd@arndb.de>,
        <anshuman.khandual@arm.com>
References: <20220607125027.44946-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220607125027.44946-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin, could you help to pick up it, thanks.

On 2022/6/7 20:50, Kefeng Wang wrote:
> 1. Enhance generic ioremap to make it more useful.
> 2. Let's arm64 use GENERIC_IOREMAP to cleanup code.
> 3. Support HAVE_IOREMAP_PROT on arm64, which enable generic_access_phys(),
>     it is useful when debug(eg, gdb) via access_process_vm device memory
>     infrastructure.
>
> v5:
> - break long lines(> 80 cols), per Christoph Hellwig
> - move is_vmalloc_addr() check from arm64 into generic ioremap, per
>    Christoph Hellwig
> - make arm64's ioremap_cache as an inline function, per Christoph
> - keep changes simple, make ioremap/iounmap_allowed return bool, per
>    Baoquan He
> - simplify use 'void *' instead of 'void __iomem *' in iounmap, then
>    drop __force annotation
>
> v4:
> - update based on v5.19-rc1
> - add generic arch_ioremap/arch_iounmap define, per Andrew Monrton
> - simply return an int for arch_ioremap and rename arch_ioremap/arch_iounmap
>    to a better name, ioremap_allowed/iounmap_allowed, per Arnd Bergmann
> - add __force annotation to slince sparse warning in vunmap()
>
> Note,
> 1) after the renaming, the arm's change(patch1) is not the necessary
>     dependence for the following changes, but as a cleanup, still post
>     it here, hope it go in via the arm64 tree with reset of the series
>     directly if no object.
> 2) the changes in this version only influence on patch4/5, so retain
>     the ack/review.
>
> v3:
> - add cleanup patch to kill ARM's unused arch_iounmap(the naming will be
>    used in GENERIC_IOREMAP) and add comments for arch_ioremap/arch_iounmap
>    hooks, per Anshuman Khandual
> - collect ack/review
>
> v2:
> - s/addr/phys_addr in ioremap_prot, suggested by Andrew Morton
> - rename arch_ioremap/iounmap_check to arch_ioremap/iounmap
>    and change return value, per Christoph Hellwig and Andrew Morton
> - and use 'ifndef arch_ioremap' instead of weak function, per Arnd Bergmann
> - collect ack/review
>
> Kefeng Wang (6):
>    ARM: mm: kill unused runtime hook arch_iounmap()
>    mm: ioremap: Use more sensibly name in ioremap_prot()
>    mm: ioremap: Setup phys_addr of struct vm_struct
>    mm: ioremap: Add ioremap/iounmap_allowed()
>    arm64: mm: Convert to GENERIC_IOREMAP
>    arm64: Add HAVE_IOREMAP_PROT support
>
>   .../features/vm/ioremap_prot/arch-support.txt |  2 +-
>   arch/arm/include/asm/io.h                     |  4 +-
>   arch/arm/mm/ioremap.c                         |  9 +-
>   arch/arm/mm/nommu.c                           |  9 +-
>   arch/arm64/Kconfig                            |  2 +
>   arch/arm64/include/asm/io.h                   | 24 +++--
>   arch/arm64/include/asm/pgtable.h              | 10 +++
>   arch/arm64/kernel/acpi.c                      |  2 +-
>   arch/arm64/mm/hugetlbpage.c                   | 10 ---
>   arch/arm64/mm/ioremap.c                       | 90 ++-----------------
>   include/asm-generic/io.h                      | 29 +++++-
>   mm/ioremap.c                                  | 26 ++++--
>   12 files changed, 90 insertions(+), 127 deletions(-)
>
