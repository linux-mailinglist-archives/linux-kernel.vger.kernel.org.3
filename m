Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245EC4F611C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbiDFONu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbiDFOMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:12:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 981896381A2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:10:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A1AC23A;
        Wed,  6 Apr 2022 03:04:53 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.10.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C67DC3F718;
        Wed,  6 Apr 2022 03:04:50 -0700 (PDT)
Date:   Wed, 6 Apr 2022 11:04:41 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, james.morse@arm.com
Subject: Re: [RFC PATCH -next V2 0/7]arm64: add machine check safe support
Message-ID: <Yk1luUxEIP3Dxt5c@FVFF77S0Q05N>
References: <20220406091311.3354723-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406091311.3354723-1-tongtiangen@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In future, for the arm64 uaccess stuff, could you please CC me, and for the
arm64 RAS bits (e.g. the SEA handling), could you please CC James Morse?

On Wed, Apr 06, 2022 at 09:13:04AM +0000, Tong Tiangen wrote:
> This patchset is based on[1].

That link below appears to be a single patch. Sending that separately makes
this harder to review, so in future could you please send this as a combined
series?

> With the increase of memory capacity and density, the probability of
> memory error increases. The increasing size and density of server RAM
> in the data center and cloud have shown increased uncorrectable memory
> errors.
> 
> Currently, the kernel has a mechanism to recover from hardware memory
> errors. This patchset provides an new recovery mechanism.
> 
> For ARM64, the hardware error handling is do_sea() which divided into
> two cases:
> 1. The user state consumed the memory errors, the solution is kill th
>      user process and isolate the error page.
> 2. The kernel state consumed the memory errors, the solution is panic.
> 
> For kernelspace, Undifferentiated panic maybe not the optimal choice,
> it can be handled better.
> 
> This patchset deals with four sscenarios of hardware memory error consumed
> in kernelspace:
> 1. copy_from_user.
> 2. get_user.

What about atomics to user memory? e.g. futexes, or the armv8_deprecated
emulations?

It seems the assumption is that writing to user memory (e.g. copy_to_user() and
put_user()) don't matter? Could you please mention why? e.g. do we never take
an exception for writes to memory with errors?

> 3. cow(copy on write).
> 4. pagecache reading.

There are a bunch of other places where we'll access user memory via the linear
map, so I assume this is just a best-effort "try not to die" rather than "never
die" ?

Are there other places we might need/want to expand this to in future?

Thanks,
Mark.

> These four scenarios have similarities. Although the error is consumed in
> the kernel state, but the consumed data belongs to the user state.
> 
> The processing scheme is based on CONFIG_ARCH_HAS_COPY_MC and uses the
> process killing plus isolate error page to replace kernel panic.
> 
> [1]https://lore.kernel.org/lkml/20220323033705.3966643-1-tongtiangen@huawei.com/
> 
> Since V2:
>  1.Consistent with PPC/x86, Using CONFIG_ARCH_HAS_COPY_MC instead of
>    ARM64_UCE_KERNEL_RECOVERY.
>  2.Add two new scenarios, cow and pagecache reading.
>  3.Fix two small bug(the first two patch).
> 
> Tong Tiangen (7):
>   x86: fix copy_mc_to_user compile error
>   arm64: fix page_address return value in copy_highpage
>   arm64: add support for machine check error safe
>   arm64: add copy_from_user to machine check safe
>   arm64: add get_user to machine check safe
>   arm64: add cow to machine check safe
>   arm64: add pagecache reading to machine check safe
> 
>  arch/arm64/Kconfig                   |  1 +
>  arch/arm64/include/asm/asm-extable.h | 25 +++++++
>  arch/arm64/include/asm/asm-uaccess.h | 16 +++++
>  arch/arm64/include/asm/esr.h         |  5 ++
>  arch/arm64/include/asm/extable.h     |  2 +-
>  arch/arm64/include/asm/page.h        | 10 +++
>  arch/arm64/include/asm/uaccess.h     | 17 ++++-
>  arch/arm64/kernel/probes/kprobes.c   |  2 +-
>  arch/arm64/lib/Makefile              |  2 +
>  arch/arm64/lib/copy_from_user.S      | 11 ++--
>  arch/arm64/lib/copy_page_mc.S        | 98 ++++++++++++++++++++++++++++
>  arch/arm64/lib/copy_to_user_mc.S     | 78 ++++++++++++++++++++++
>  arch/arm64/mm/copypage.c             | 36 ++++++++--
>  arch/arm64/mm/extable.c              | 21 +++++-
>  arch/arm64/mm/fault.c                | 30 ++++++++-
>  arch/x86/include/asm/uaccess.h       |  1 +
>  include/linux/highmem.h              |  8 +++
>  include/linux/uaccess.h              |  8 +++
>  include/linux/uio.h                  |  9 ++-
>  lib/iov_iter.c                       | 85 +++++++++++++++++++-----
>  mm/memory.c                          |  2 +-
>  21 files changed, 432 insertions(+), 35 deletions(-)
>  create mode 100644 arch/arm64/lib/copy_page_mc.S
>  create mode 100644 arch/arm64/lib/copy_to_user_mc.S
> 
> -- 
> 2.18.0.huawei.25
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
