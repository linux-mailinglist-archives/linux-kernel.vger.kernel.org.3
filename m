Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AA55310BD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiEWLil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbiEWLig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:38:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB2F743AC2;
        Mon, 23 May 2022 04:38:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A09DD11FB;
        Mon, 23 May 2022 04:38:35 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.9.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 297CE3F73D;
        Mon, 23 May 2022 04:38:34 -0700 (PDT)
Date:   Mon, 23 May 2022 12:38:28 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     elver@google.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH v4 1/2] asm-generic: Add memory barrier dma_mb()
Message-ID: <YotyNJeTxQMk/eat@FVFF77S0Q05N>
References: <20220523113126.171714-1-wangkefeng.wang@huawei.com>
 <20220523113126.171714-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523113126.171714-2-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 07:31:25PM +0800, Kefeng Wang wrote:
> The memory barrier dma_mb() is introduced by commit a76a37777f2c
> ("iommu/arm-smmu-v3: Ensure queue is read after updating prod pointer"),
> which is used to ensure that prior (both reads and writes) accesses
> to memory by a CPU are ordered w.r.t. a subsequent MMIO write.
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de> # for asm-generic
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

FWIW, this looks sane to me so:

  Acked-by: Mark Rutland <mark.rutland@arm.com>

I'll leave the final say to Will, as I assume this'll go via the arm64 tree and
he'll be the one picking this.

Mark.

> ---
>  Documentation/memory-barriers.txt | 11 ++++++-----
>  include/asm-generic/barrier.h     |  8 ++++++++
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index b12df9137e1c..832b5d36e279 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1894,6 +1894,7 @@ There are some more advanced barrier functions:
>  
>   (*) dma_wmb();
>   (*) dma_rmb();
> + (*) dma_mb();
>  
>       These are for use with consistent memory to guarantee the ordering
>       of writes or reads of shared memory accessible to both the CPU and a
> @@ -1925,11 +1926,11 @@ There are some more advanced barrier functions:
>       The dma_rmb() allows us guarantee the device has released ownership
>       before we read the data from the descriptor, and the dma_wmb() allows
>       us to guarantee the data is written to the descriptor before the device
> -     can see it now has ownership.  Note that, when using writel(), a prior
> -     wmb() is not needed to guarantee that the cache coherent memory writes
> -     have completed before writing to the MMIO region.  The cheaper
> -     writel_relaxed() does not provide this guarantee and must not be used
> -     here.
> +     can see it now has ownership.  The dma_mb() implies both a dma_rmb() and
> +     a dma_wmb().  Note that, when using writel(), a prior wmb() is not needed
> +     to guarantee that the cache coherent memory writes have completed before
> +     writing to the MMIO region.  The cheaper writel_relaxed() does not provide
> +     this guarantee and must not be used here.
>  
>       See the subsection "Kernel I/O barrier effects" for more information on
>       relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index fd7e8fbaeef1..961f4d88f9ef 100644
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
> @@ -65,6 +69,10 @@
>  #define wmb()	mb()
>  #endif
>  
> +#ifndef dma_mb
> +#define dma_mb()	mb()
> +#endif
> +
>  #ifndef dma_rmb
>  #define dma_rmb()	rmb()
>  #endif
> -- 
> 2.35.3
> 
