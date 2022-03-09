Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F894D3971
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbiCITEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237192AbiCITEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:04:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8017D127544;
        Wed,  9 Mar 2022 11:03:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02715B82365;
        Wed,  9 Mar 2022 19:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8BEC340E8;
        Wed,  9 Mar 2022 19:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646852593;
        bh=wOn8Hies7HCzLfAvnQCaSqDPNyXoIclo0vQqj6JYG3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uA1e9OONv2ENbAsD18d0StlyDCgqJKYPtI6aV2IVlfpPaF+EhE7QTYHxidyNAySdv
         8kzQifHpplvlI9H6kI+pLhBq3GcW2ySU+VbhsgERJ0KzV4Kdzck2IebYp0ZbfVE5mq
         B9kz+V7GPruzNc9dqc9Pt8eePI+/osQr/sDjFKKYhY5wg9BitFvlRoQ8p07FuRse/i
         02vL0NqgSEFoH1dcMGNPG3O01kuA3FJoRVub+IJah4+OVfPfH1B5YP7iZKWNVTxAuS
         ugJiI0yjRwJZQMXt4LW1DGS4M+kdcVGEjrutQZYktNsPLq/ITknB+hZIvg/KrDSRQf
         DbFbVn1z0QkEA==
Date:   Wed, 9 Mar 2022 13:11:43 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-mips@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MIPS: boot/compressed: Use array reference for image
 bounds
Message-ID: <20220309191143.GA2264083@embeddedor>
References: <20220309185032.229123-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309185032.229123-1-keescook@chromium.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:50:32AM -0800, Kees Cook wrote:
> As done with other image addresses in other architectures, use an
> explicit flexible array instead of "address of char", which can trip
> bounds checking done by the compiler. Found when building with
> -Warray-bounds:
> 
> In file included from ./include/linux/byteorder/little_endian.h:5,
>                  from ./arch/mips/include/uapi/asm/byteorder.h:15,
>                  from ./arch/mips/include/asm/bitops.h:21,
>                  from ./include/linux/bitops.h:33,
>                  from ./include/linux/kernel.h:22,
>                  from arch/mips/boot/compressed/decompress.c:13:
> arch/mips/boot/compressed/decompress.c: In function 'decompress_kernel':
> ./include/asm-generic/unaligned.h:14:8: warning: array subscript -1 is outside array bounds of 'unsigned char[1]' [-Warray-bounds]
>    14 |  __pptr->x;        \
>       |  ~~~~~~^~~
> ./include/uapi/linux/byteorder/little_endian.h:35:51: note: in definition of macro '__le32_to_cpu'
>    35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>       |                                                   ^
> ./include/asm-generic/unaligned.h:32:21: note: in expansion of macro '__get_unaligned_t'
>    32 |  return le32_to_cpu(__get_unaligned_t(__le32, p));
>       |                     ^~~~~~~~~~~~~~~~~
> arch/mips/boot/compressed/decompress.c:29:37: note: while referencing '__image_end'
>    29 | extern unsigned char __image_begin, __image_end;
>       |                                     ^~~~~~~~~~~
> 
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-mips@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  arch/mips/boot/compressed/decompress.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
> index aae1346a509a..5b38a802e101 100644
> --- a/arch/mips/boot/compressed/decompress.c
> +++ b/arch/mips/boot/compressed/decompress.c
> @@ -26,7 +26,7 @@ unsigned long free_mem_ptr;
>  unsigned long free_mem_end_ptr;
>  
>  /* The linker tells us where the image is. */
> -extern unsigned char __image_begin, __image_end;
> +extern unsigned char __image_begin[], __image_end[];
>  
>  /* debug interfaces  */
>  #ifdef CONFIG_DEBUG_ZBOOT
> @@ -91,9 +91,9 @@ void decompress_kernel(unsigned long boot_heap_start)
>  {
>  	unsigned long zimage_start, zimage_size;
>  
> -	zimage_start = (unsigned long)(&__image_begin);
> -	zimage_size = (unsigned long)(&__image_end) -
> -	    (unsigned long)(&__image_begin);
> +	zimage_start = (unsigned long)(__image_begin);
> +	zimage_size = (unsigned long)(__image_end) -
> +	    (unsigned long)(__image_begin);
>  
>  	puts("zimage at:     ");
>  	puthex(zimage_start);
> @@ -121,7 +121,7 @@ void decompress_kernel(unsigned long boot_heap_start)
>  		dtb_size = fdt_totalsize((void *)&__appended_dtb);
>  
>  		/* last four bytes is always image size in little endian */
> -		image_size = get_unaligned_le32((void *)&__image_end - 4);
> +		image_size = get_unaligned_le32((void *)__image_end - 4);
>  
>  		/* The device tree's address must be properly aligned  */
>  		image_size = ALIGN(image_size, STRUCT_ALIGNMENT);
> -- 
> 2.32.0
> 
