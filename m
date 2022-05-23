Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445795312E5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbiEWOSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbiEWOSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:18:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 465215A088;
        Mon, 23 May 2022 07:18:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAC7D1063;
        Mon, 23 May 2022 07:18:14 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.9.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0904A3F70D;
        Mon, 23 May 2022 07:18:12 -0700 (PDT)
Date:   Mon, 23 May 2022 15:16:35 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     elver@google.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH v4 2/2] arm64: kcsan: Support detecting more missing
 memory barriers
Message-ID: <YouXQ+XX8CrgM5QX@FVFF77S0Q05N>
References: <20220523113126.171714-1-wangkefeng.wang@huawei.com>
 <20220523113126.171714-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523113126.171714-3-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 07:31:26PM +0800, Kefeng Wang wrote:
> As "kcsan: Support detecting a subset of missing memory barriers"[1]
> introduced KCSAN_STRICT/KCSAN_WEAK_MEMORY which make kcsan detects
> more missing memory barrier, but arm64 don't have KCSAN instrumentation
> for barriers, so the new selftest test_barrier() and test cases for
> memory barrier instrumentation in kcsan_test module will fail, even
> panic on selftest.
> 
> Let's prefix all barriers with __ on arm64, as asm-generic/barriers.h
> defined the final instrumented version of these barriers, which will
> fix the above issues.
> 
> Note, barrier instrumentation that can be disabled via __no_kcsan with
> appropriate compiler-support (and not just with objtool help), see
> commit bd3d5bd1a0ad ("kcsan: Support WEAK_MEMORY with Clang where no
> objtool support exists"), it adds disable_sanitizer_instrumentation to
> __no_kcsan attribute which will remove all sanitizer instrumentation fully
> (with Clang 14.0). Meanwhile, GCC does the same thing with no_sanitize.
> 
> [1] https://lore.kernel.org/linux-mm/20211130114433.2580590-1-elver@google.com/
> 
> Acked-by: Marco Elver <elver@google.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Having built this with GCC 12.1.0 and LLVM 14.0.0, I think this patch itself
doesn't introduce any new problems, and logically makes sense. With that in
mind:

  Acked-by: Mark Rutland <mark.rutland@arm.com>

As an aside, having scanned the resulting vmlinux with objdump, there are
plenty of latent issues where we get KCSAN instrumentation where we don't want
it (e.g. early/late in arm64's entry-common.o). The bulk of those are due to
missing `nonistr` or `__always_inline`, which we'll need to fix up.

Thanks,
Mark.

> ---
>  arch/arm64/include/asm/barrier.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index 9f3e2c3d2ca0..2cfc4245d2e2 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -50,13 +50,13 @@
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
> -- 
> 2.35.3
> 
