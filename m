Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68E15B295D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiIHWbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiIHWa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:30:57 -0400
X-Greylist: delayed 913 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Sep 2022 15:30:54 PDT
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [216.12.86.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F45B284E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 15:30:53 -0700 (PDT)
Date:   Thu, 8 Sep 2022 18:15:39 -0400
From:   Rich Felker <dalias@libc.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sh: machvec: Use char[] for section boundaries
Message-ID: <20220908221538.GD8773@brightrain.aerifal.cx>
References: <20220907234345.96798-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907234345.96798-1-keescook@chromium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 04:43:45PM -0700, Kees Cook wrote:
> As done for other sections, define the extern as a character array,
> which relaxes many of the compiler-time object size checks, which would
> otherwise assume it's a single long. Solves the following build error:
> 
> arch/sh/kernel/machvec.c: error: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Werror=array-bounds]:  => 105:33

LGMT. This is the approach I recommend for this general type of
mechanism. So,

Acked-by: Rich Felker <dalias@libc.org>

Since I haven't been on top of collating patches for upstreaming, I'd
be happy if anyone else wants to take this in their tree before I get
back to it.

Rich


> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/lkml/alpine.DEB.2.22.394.2209050944290.964530@ramsan.of.borg/
> Fixes: 9655ad03af2d ("sh: Fixup machvec support.")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/sh/include/asm/sections.h |  2 +-
>  arch/sh/kernel/machvec.c       | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/sh/include/asm/sections.h b/arch/sh/include/asm/sections.h
> index 8edb824049b9..0cb0ca149ac3 100644
> --- a/arch/sh/include/asm/sections.h
> +++ b/arch/sh/include/asm/sections.h
> @@ -4,7 +4,7 @@
>  
>  #include <asm-generic/sections.h>
>  
> -extern long __machvec_start, __machvec_end;
> +extern char __machvec_start[], __machvec_end[];
>  extern char __uncached_start, __uncached_end;
>  extern char __start_eh_frame[], __stop_eh_frame[];
>  
> diff --git a/arch/sh/kernel/machvec.c b/arch/sh/kernel/machvec.c
> index d606679a211e..57efaf5b82ae 100644
> --- a/arch/sh/kernel/machvec.c
> +++ b/arch/sh/kernel/machvec.c
> @@ -20,8 +20,8 @@
>  #define MV_NAME_SIZE 32
>  
>  #define for_each_mv(mv) \
> -	for ((mv) = (struct sh_machine_vector *)&__machvec_start; \
> -	     (mv) && (unsigned long)(mv) < (unsigned long)&__machvec_end; \
> +	for ((mv) = (struct sh_machine_vector *)__machvec_start; \
> +	     (mv) && (unsigned long)(mv) < (unsigned long)__machvec_end; \
>  	     (mv)++)
>  
>  static struct sh_machine_vector * __init get_mv_byname(const char *name)
> @@ -87,8 +87,8 @@ void __init sh_mv_setup(void)
>  	if (!machvec_selected) {
>  		unsigned long machvec_size;
>  
> -		machvec_size = ((unsigned long)&__machvec_end -
> -				(unsigned long)&__machvec_start);
> +		machvec_size = ((unsigned long)__machvec_end -
> +				(unsigned long)__machvec_start);
>  
>  		/*
>  		 * Sanity check for machvec section alignment. Ensure
> @@ -102,7 +102,7 @@ void __init sh_mv_setup(void)
>  		 * vector (usually the only one) from .machvec.init.
>  		 */
>  		if (machvec_size >= sizeof(struct sh_machine_vector))
> -			sh_mv = *(struct sh_machine_vector *)&__machvec_start;
> +			sh_mv = *(struct sh_machine_vector *)__machvec_start;
>  	}
>  
>  	pr_notice("Booting machvec: %s\n", get_system_type());
> -- 
> 2.34.1
