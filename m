Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F61D520E68
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbiEJHet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239012AbiEJHK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:10:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6400189974
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 00:06:59 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ky8GZ3wPgzhYx0;
        Tue, 10 May 2022 15:06:30 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 15:06:57 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 15:06:57 +0800
Message-ID: <1331b212-59d8-5e9d-974c-e0f3a47d9879@huawei.com>
Date:   Tue, 10 May 2022 15:06:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 0/5] arm64: Cleanup ioremap() and support
 ioremap_prot()
Content-Language: en-US
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <hch@infradead.org>, <arnd@arndb.de>
References: <20220429103225.75121-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220429103225.75121-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello maintainers，kindly ping.

On 2022/4/29 18:32, Kefeng Wang wrote:
> 1. Enhance generic ioremap to make it more useful.
> 2. Let's arm64 use GENERIC_IOREMAP to cleanup code.
> 3. Support HAVE_IOREMAP_PROT on arm64, which enable generic_access_phys(),
>     it is useful when debug(eg, gdb) via access_process_vm device memory
>     infrastructure.
>
> v2:
> - s/addr/phys_addr in ioremap_prot, suggested by Andrew Morton
> - rename arch_ioremap/iounmap_check to arch_ioremap/iounmad
>    and change return value, per Christoph Hellwig and Andrew Morton
> - and use 'ifndef arch_ioremap' instead of weak function, per Arnd Bergmann
> - collect ack/review
>
> Kefeng Wang (5):
>    mm: ioremap: Use more sensibly name in ioremap_prot()
>    mm: ioremap: Setup phys_addr of struct vm_struct
>    mm: ioremap: Add arch_ioremap/iounmap()
>    arm64: mm: Convert to GENERIC_IOREMAP
>    arm64: Add HAVE_IOREMAP_PROT support
>
>   .../features/vm/ioremap_prot/arch-support.txt |  2 +-
>   arch/arm64/Kconfig                            |  2 +
>   arch/arm64/include/asm/io.h                   | 20 +++--
>   arch/arm64/include/asm/pgtable.h              | 10 +++
>   arch/arm64/kernel/acpi.c                      |  2 +-
>   arch/arm64/mm/hugetlbpage.c                   | 10 ---
>   arch/arm64/mm/ioremap.c                       | 85 +++----------------
>   include/asm-generic/io.h                      | 16 +++-
>   mm/ioremap.c                                  | 27 ++++--
>   9 files changed, 74 insertions(+), 100 deletions(-)
>
