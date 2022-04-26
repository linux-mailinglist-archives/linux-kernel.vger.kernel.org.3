Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADBB50FD6C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350192AbiDZMqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350193AbiDZMqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:46:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 979A717B381
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 05:43:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40CBD23A;
        Tue, 26 Apr 2022 05:43:02 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BD4B3F774;
        Tue, 26 Apr 2022 05:43:01 -0700 (PDT)
Date:   Tue, 26 Apr 2022 13:42:31 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     elver@google.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kcsan: Fix kcsan test_barrier fail and panic
Message-ID: <Ymfot/Le95Enuxqb@lakrids>
References: <20220426081700.1376542-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426081700.1376542-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 26, 2022 at 08:17:00AM +0000, Kefeng Wang wrote:
> As "kcsan: Support detecting a subset of missing memory barriers"
> introduced KCSAN_STRICT which make kcsan detects more missing memory
> barrier, but arm64 don't have KCSAN instrumentation for barriers, so
> the new selftest test_barrier() will fail, then panic.
> 
> Let's prefix all barriers with __ on arm64, as asm-generic/barriers.h
> defined the final instrumented version of these barriers, which will
> fix the above issues.
> 
> Fixes: dd03762ab608 ("arm64: Enable KCSAN")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

I don't think the Fixes tag is necessary given this is a new feature
which depends upon EXPERT, and I'm worried it encourages backporting
this into a kernel where it would be broken, so I'd prefer we drop that
tag.

IIUC when we originially looked at this the instrumentation wasn't safe
and would violate noinstr requirements. Looking at linux/kcsan-checks.h,
the comments block for __KCSAN_BARRIER_TO_SIGNAL_FENCE() say that it
will respect __nokcsan, so it looks like that might be safe now.

It looks like that's the case as of commit:
  
  bd3d5bd1a0ad3864 ("kcsan: Support WEAK_MEMORY with Clang where no objtool support exists")

... which requires clang 14.0.0+.

That looks to have gone in concurrently with dd03762ab608, but is
clearly a prerequisite, so as above I'd strongly prefer we drop the
Fixes tag.

It would be good if we could note that explicitly in the commit message.

Have you eyeballed the generated assembly to verify that this works as
expected for __nokcsan ?

Thanks,
Mark.

> ---
>  arch/arm64/include/asm/barrier.h | 12 ++++++------
>  include/asm-generic/barrier.h    |  4 ++++
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index 62217be36217..9760a8d4ed0a 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -46,13 +46,13 @@
>  #define pmr_sync()	do {} while (0)
>  #endif
>  
> -#define mb()		dsb(sy)
> -#define rmb()		dsb(ld)
> -#define wmb()		dsb(st)
> +#define __mb()		dsb(sy)
> +#define __rmb()		dsb(ld)
> +#define __wmb()		dsb(st)
>  
> -#define dma_mb()	dmb(osh)
> -#define dma_rmb()	dmb(oshld)
> -#define dma_wmb()	dmb(oshst)
> +#define __dma_mb()	dmb(osh)
> +#define __dma_rmb()	dmb(oshld)
> +#define __dma_wmb()	dmb(oshst)
>  
>  #define io_stop_wc()	dgh()
>  
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index fd7e8fbaeef1..18863c50e9ce 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -38,6 +38,10 @@
>  #define wmb()	do { kcsan_wmb(); __wmb(); } while (0)
>  #endif
>  
> +#ifdef __dma_mb
> +#define dma_mb()	do { kcsan_mb(); __dma_mb(); } while (0)
> +#endif
> +
>  #ifdef __dma_rmb
>  #define dma_rmb()	do { kcsan_rmb(); __dma_rmb(); } while (0)
>  #endif
> -- 
> 2.27.0
> 
