Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4B5529591
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349386AbiEPXw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 19:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350531AbiEPXwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 19:52:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B431346B03
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 16:52:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53DFAB816AF
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988DAC385AA;
        Mon, 16 May 2022 23:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652745128;
        bh=d7+oC+7Tgf7T+0H3v3NwtYLr3AwLyKa8NrYvJT4rWmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tVbUm52EGpssBkOelaAFZoleN6c4uBCJW9WpI9QLShUwgXHPyYg308qqR2IzfrdrP
         Kj2SyiuurSZdKZmp5kGdFFqHRgkHC9pdgqszmI/qt3ZqnJQJ/12XFQ8beg/F9P6qsn
         d5nwrZpthFSSSEbfN9PeFEoVVpX0LF4iVIl+V63p001GoaTBzf6DA0zXlkLwM8W4kj
         MvagpXonIQuIKWDK6mVSjS4yXkFqO8aTwzUJ55mEz90iExyW775cog7TPnkwk/k4Y/
         KNpt1obXWMHkZy7EufZWkxgjvyAH/SkwnJfc8ckY1KcwQVYBb0TmlcNCGTRFdquyL0
         X18xHcXL9MVzg==
Date:   Mon, 16 May 2022 16:52:06 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Terrell <terrelln@fb.com>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH kernel v2] zstd: Fixing mixed module-builtin objects
Message-ID: <YoLjpivvU7dRVTuL@dev-arch.thelio-3990X>
References: <20220429053329.2278740-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429053329.2278740-1-aik@ozlabs.ru>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Did you have any thoughts on this patch? It is necessary for enabling
LTO with PowerPC:

https://lore.kernel.org/20220429064547.2334280-1-aik@ozlabs.ru/

If you don't have anything to send to Linus for the next cycle, perhaps
this patch could be carried by the PowerPC folks with your ack?

Cheers,
Nathan

On Fri, Apr 29, 2022 at 03:33:29PM +1000, Alexey Kardashevskiy wrote:
> With CONFIG_ZSTD_COMPRESS=m and CONFIG_ZSTD_DECOMPRESS=y we end up in
> a situation when files from lib/zstd/common/ are compiled once to be
> linked later for ZSTD_DECOMPRESS (build-in) and ZSTD_COMPRESS (module)
> even though CFLAGS are different for builtins and modules.
> So far somehow this was not a problem but enabling LLVM LTO exposes
> the problem as:
> 
> ld.lld: error: linking module flags 'Code Model': IDs have conflicting values in 'lib/built-in.a(zstd_common.o at 5868)' and 'ld-temp.o'
> 
> This particular conflict is caused by KBUILD_CFLAGS=-mcmodel=medium vs.
> KBUILD_CFLAGS_MODULE=-mcmodel=large , modules use the large model on
> POWERPC as explained at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/Makefile?h=v5.18-rc4#n127
> but the current use of common files is wrong anyway.
> 
> This works around the issue by introducing a zstd_common module with
> shared code.
> 
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * add a new module instead of inlining common bits
> 
> ---
>  lib/zstd/Makefile                | 18 ++++++++----------
>  lib/zstd/common/entropy_common.c |  4 +++-
>  lib/zstd/common/zstd_common.c    |  7 +++++++
>  lib/Kconfig                      |  8 ++++++--
>  4 files changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
> index fc45339fc3a3..440bd0007ae2 100644
> --- a/lib/zstd/Makefile
> +++ b/lib/zstd/Makefile
> @@ -10,14 +10,10 @@
>  # ################################################################
>  obj-$(CONFIG_ZSTD_COMPRESS) += zstd_compress.o
>  obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd_decompress.o
> +obj-$(CONFIG_ZSTD_COMMON) += zstd_common.o
>  
>  zstd_compress-y := \
>  		zstd_compress_module.o \
> -		common/debug.o \
> -		common/entropy_common.o \
> -		common/error_private.o \
> -		common/fse_decompress.o \
> -		common/zstd_common.o \
>  		compress/fse_compress.o \
>  		compress/hist.o \
>  		compress/huf_compress.o \
> @@ -33,12 +29,14 @@ zstd_compress-y := \
>  
>  zstd_decompress-y := \
>  		zstd_decompress_module.o \
> -		common/debug.o \
> -		common/entropy_common.o \
> -		common/error_private.o \
> -		common/fse_decompress.o \
> -		common/zstd_common.o \
>  		decompress/huf_decompress.o \
>  		decompress/zstd_ddict.o \
>  		decompress/zstd_decompress.o \
>  		decompress/zstd_decompress_block.o \
> +
> +zstd_common-y := \
> +		common/debug.o \
> +		common/entropy_common.o \
> +		common/error_private.o \
> +		common/fse_decompress.o \
> +		common/zstd_common.o \
> diff --git a/lib/zstd/common/entropy_common.c b/lib/zstd/common/entropy_common.c
> index 53b47a2b52ff..f84612627471 100644
> --- a/lib/zstd/common/entropy_common.c
> +++ b/lib/zstd/common/entropy_common.c
> @@ -15,6 +15,7 @@
>  /* *************************************
>  *  Dependencies
>  ***************************************/
> +#include <linux/module.h>
>  #include "mem.h"
>  #include "error_private.h"       /* ERR_*, ERROR */
>  #define FSE_STATIC_LINKING_ONLY  /* FSE_MIN_TABLELOG */
> @@ -239,7 +240,7 @@ size_t FSE_readNCount(
>  {
>      return FSE_readNCount_bmi2(normalizedCounter, maxSVPtr, tableLogPtr, headerBuffer, hbSize, /* bmi2 */ 0);
>  }
> -
> +EXPORT_SYMBOL_GPL(FSE_readNCount);
>  
>  /*! HUF_readStats() :
>      Read compact Huffman tree, saved by HUF_writeCTable().
> @@ -255,6 +256,7 @@ size_t HUF_readStats(BYTE* huffWeight, size_t hwSize, U32* rankStats,
>      U32 wksp[HUF_READ_STATS_WORKSPACE_SIZE_U32];
>      return HUF_readStats_wksp(huffWeight, hwSize, rankStats, nbSymbolsPtr, tableLogPtr, src, srcSize, wksp, sizeof(wksp), /* bmi2 */ 0);
>  }
> +EXPORT_SYMBOL_GPL(HUF_readStats);
>  
>  FORCE_INLINE_TEMPLATE size_t
>  HUF_readStats_body(BYTE* huffWeight, size_t hwSize, U32* rankStats,
> diff --git a/lib/zstd/common/zstd_common.c b/lib/zstd/common/zstd_common.c
> index 3d7e35b309b5..06f62b2026d5 100644
> --- a/lib/zstd/common/zstd_common.c
> +++ b/lib/zstd/common/zstd_common.c
> @@ -13,6 +13,7 @@
>  /*-*************************************
>  *  Dependencies
>  ***************************************/
> +#include <linux/module.h>
>  #define ZSTD_DEPS_NEED_MALLOC
>  #include "zstd_deps.h"   /* ZSTD_malloc, ZSTD_calloc, ZSTD_free, ZSTD_memset */
>  #include "error_private.h"
> @@ -59,6 +60,7 @@ void* ZSTD_customMalloc(size_t size, ZSTD_customMem customMem)
>          return customMem.customAlloc(customMem.opaque, size);
>      return ZSTD_malloc(size);
>  }
> +EXPORT_SYMBOL_GPL(ZSTD_customMalloc);
>  
>  void* ZSTD_customCalloc(size_t size, ZSTD_customMem customMem)
>  {
> @@ -71,6 +73,7 @@ void* ZSTD_customCalloc(size_t size, ZSTD_customMem customMem)
>      }
>      return ZSTD_calloc(1, size);
>  }
> +EXPORT_SYMBOL_GPL(ZSTD_customCalloc);
>  
>  void ZSTD_customFree(void* ptr, ZSTD_customMem customMem)
>  {
> @@ -81,3 +84,7 @@ void ZSTD_customFree(void* ptr, ZSTD_customMem customMem)
>              ZSTD_free(ptr);
>      }
>  }
> +EXPORT_SYMBOL_GPL(ZSTD_customFree);
> +
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_DESCRIPTION("Zstd Common");
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 087e06b4cdfd..33f3a7054cdd 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -333,12 +333,16 @@ config LZ4HC_COMPRESS
>  config LZ4_DECOMPRESS
>  	tristate
>  
> +config ZSTD_COMMON
> +	select XXHASH
> +	tristate
> +
>  config ZSTD_COMPRESS
> -	select XXHASH
> +	select ZSTD_COMMON
>  	tristate
>  
>  config ZSTD_DECOMPRESS
> -	select XXHASH
> +	select ZSTD_COMMON
>  	tristate
>  
>  source "lib/xz/Kconfig"
> -- 
> 2.30.2
> 
> 
