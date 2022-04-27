Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60A351142A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiD0JNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbiD0JNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:13:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E923724766B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 02:09:57 -0700 (PDT)
Received: from kwepemi100023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KpCbz5DxlzgYkt;
        Wed, 27 Apr 2022 17:09:03 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100023.china.huawei.com (7.221.188.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 17:09:21 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 17:09:20 +0800
Message-ID: <6b18fed1-f802-b15c-95d9-718a48edbbfc@huawei.com>
Date:   Wed, 27 Apr 2022 17:09:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v4 0/7]arm64: add machine check safe support
To:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
References: <20220420030418.3189040-1-tongtiangen@huawei.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20220420030418.3189040-1-tongtiangen@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, James, Robin, kindly ping...

Thanks.

在 2022/4/20 11:04, Tong Tiangen 写道:
> With the increase of memory capacity and density, the probability of
> memory error increases. The increasing size and density of server RAM
> in the data center and cloud have shown increased uncorrectable memory
> errors.
> 
> Currently, the kernel has a mechanism to recover from hardware memory
> errors. This patchset provides an new recovery mechanism.
> 
> For arm64, the hardware memory error handling is do_sea() which divided
> into two cases:
>   1. The user state consumed the memory errors, the solution is kill the
>      user process and isolate the error page.
>   2. The kernel state consumed the memory errors, the solution is panic.
> 
> For case 2, Undifferentiated panic maybe not the optimal choice, it can be
> handled better, in some scenes, we can avoid panic, such as uaccess, if the
> uaccess fails due to memory error, only the user process will be affected,
> kill the user process and isolate the user page with hardware memory errors
> is a better choice.
> 
> This patchset can be divided into three parts:
>   1. Patch 0/1/4    - make some minor fixes to the associated code.
>   2. Patch 3      - arm64 add support for machine check safe framework.
>   3. Pathc 5/6/7  - arm64 add uaccess and cow to machine check safe.
> 
> Since V4:
>   1. According to Robin's suggestion, direct modify user_ldst and
>   user_ldp in asm-uaccess.h and modify mte.S.
>   2. Add new macro USER_MC in asm-uaccess.h, used in copy_from_user.S
>   and copy_to_user.S.
>   3. According to Robin's suggestion, using micro in copy_page_mc.S to
>   simplify code.
>   4. According to KeFeng's suggestion, modify powerpc code in patch1.
>   5. According to KeFeng's suggestion, modify mm/extable.c and some code
>   optimization.
> 
> Since V3:
>   1. According to Mark's suggestion, all uaccess can be recovered due to
>      memory error.
>   2. Scenario pagecache reading is also supported as part of uaccess
>      (copy_to_user()) and duplication code problem is also solved.
>      Thanks for Robin's suggestion.
>   3. According Mark's suggestion, update commit message of patch 2/5.
>   4. According Borisllav's suggestion, update commit message of patch 1/5.
> 
> Since V2:
>   1.Consistent with PPC/x86, Using CONFIG_ARCH_HAS_COPY_MC instead of
>     ARM64_UCE_KERNEL_RECOVERY.
>   2.Add two new scenes, cow and pagecache reading.
>   3.Fix two small bug(the first two patch).
> 
> V1 in here:
> https://lore.kernel.org/lkml/20220323033705.3966643-1-tongtiangen@huawei.com/
> 
> Robin Murphy (1):
>    arm64: mte: Clean up user tag accessors
> 
> Tong Tiangen (6):
>    x86, powerpc: fix function define in copy_mc_to_user
>    arm64: fix types in copy_highpage()
>    arm64: add support for machine check error safe
>    arm64: add copy_{to, from}_user to machine check safe
>    arm64: add {get, put}_user to machine check safe
>    arm64: add cow to machine check safe
> 
>   arch/arm64/Kconfig                   |  1 +
>   arch/arm64/include/asm/asm-extable.h | 33 +++++++++++
>   arch/arm64/include/asm/asm-uaccess.h | 15 +++--
>   arch/arm64/include/asm/extable.h     |  1 +
>   arch/arm64/include/asm/page.h        | 10 ++++
>   arch/arm64/include/asm/uaccess.h     |  4 +-
>   arch/arm64/lib/Makefile              |  2 +
>   arch/arm64/lib/copy_from_user.S      | 18 +++---
>   arch/arm64/lib/copy_page_mc.S        | 86 ++++++++++++++++++++++++++++
>   arch/arm64/lib/copy_to_user.S        | 18 +++---
>   arch/arm64/lib/mte.S                 |  4 +-
>   arch/arm64/mm/copypage.c             | 36 ++++++++++--
>   arch/arm64/mm/extable.c              | 33 +++++++++++
>   arch/arm64/mm/fault.c                | 27 ++++++++-
>   arch/powerpc/include/asm/uaccess.h   |  1 +
>   arch/x86/include/asm/uaccess.h       |  1 +
>   include/linux/highmem.h              |  8 +++
>   include/linux/uaccess.h              |  9 +++
>   mm/memory.c                          |  2 +-
>   19 files changed, 278 insertions(+), 31 deletions(-)
>   create mode 100644 arch/arm64/lib/copy_page_mc.S
> 
