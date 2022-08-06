Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1490858B3F3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 07:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbiHFFka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 01:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiHFFkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 01:40:25 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C4F65C2;
        Fri,  5 Aug 2022 22:40:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M0BBR4s1lz4x1L;
        Sat,  6 Aug 2022 15:40:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1659764416;
        bh=yvU/ICCSlUwjAeapMvquNUrHdS+LFJEf/6r+t/RG2c8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=R9kH81QPtVyWDzuF0Ky3fvhiyrKv5woe42/F/kJhUQrxbSExVWbF/4zNwam4DwC7T
         ZZZ+AaDNtMPrjETJS6rMCwf8Z5Lu8pVekfrfDZZ9rm+0W6G+4MSwNCM5VwehfvqvPy
         mA2+TSLcjRlM0PW/FEB6SILsHQvI7p5dxrslQb9ORY1BPBr23Kj9owuDtkdrVY/QID
         PuHGKwgc4uvoVN3Lnp9T4yfdv6H2diaBwLfURgkKgo8qizNgLu5lUgsdrqfNpq9E+i
         niyO4icUpVE64MhGHDaX5z2+KB9SqoCb/vJBMfg0GcdoCgDVODjfCqMYjXzTpK5J1H
         AnfrEBXEVTVpA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     broonie@kernel.org, Yury Norov <yury.norov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bitmap tree with the random tree
In-Reply-To: <20220802235903.2660083-1-broonie@kernel.org>
References: <20220802235903.2660083-1-broonie@kernel.org>
Date:   Sat, 06 Aug 2022 15:40:15 +1000
Message-ID: <87h72q9bgg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thanks for doing linux-next in sfr's absence.

The merge resolution below is not quite right ...

broonie@kernel.org writes:
> Hi all,
>
> Today's linux-next merge of the bitmap tree got a conflict in:
>
> arch/powerpc/include/asm/archrandom.h
>
> between commit:
>
>   d349ab99eec7a ("random: handle archrandom with multiple longs")
>
> from the random tree and commit:
>
>   3e731203153de ("powerpc: drop dependency on <asm/machdep.h> in archrandom.h")
>
> from the bitmap tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> diff --cc arch/powerpc/include/asm/archrandom.h
> index 564859e6a807c,21def59ef1a68..0000000000000
> --- a/arch/powerpc/include/asm/archrandom.h
> +++ b/arch/powerpc/include/asm/archrandom.h
> @@@ -2,22 -2,41 +2,17 @@@
>   #ifndef _ASM_POWERPC_ARCHRANDOM_H
>   #define _ASM_POWERPC_ARCHRANDOM_H
>   
>  -#ifdef CONFIG_ARCH_RANDOM
>  +#include <asm/machdep.h>
  
This include must be dropped.

>  -bool __must_check arch_get_random_seed_long(unsigned long *v);
>  -
>  -static inline bool __must_check arch_get_random_long(unsigned long *v)
>  +static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
>   {
>  -	return false;
>  +	return 0;
>   }
>   
> - static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
>  -static inline bool __must_check arch_get_random_int(unsigned int *v)
> --{
> - 	if (max_longs && ppc_md.get_random_seed && ppc_md.get_random_seed(v))
> - 		return 1;
> - 	return 0;
>  -	return false;
>  -}
>  -
>  -
>  -static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
>  -{
>  -	unsigned long val;
>  -	bool rc;
>  -
>  -	rc = arch_get_random_seed_long(&val);
>  -	if (rc)
>  -		*v = val;
>  -
>  -	return rc;
> --}
>  -#endif /* CONFIG_ARCH_RANDOM */
> ++size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs);
>   
>   #ifdef CONFIG_PPC_POWERNV
>  -int powernv_hwrng_present(void);
>  -int powernv_get_random_long(unsigned long *v);
>  -int powernv_get_random_real_mode(unsigned long *v);
>  -#else
>  -static inline int powernv_hwrng_present(void) { return 0; }
>  -static inline int powernv_get_random_real_mode(unsigned long *v) { return 0; }
>  +int pnv_get_random_long(unsigned long *v);
>   #endif
>   
>   #endif /* _ASM_POWERPC_ARCHRANDOM_H */
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 3b1cf9ca4814b..951822145600e 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -172,12 +172,12 @@ void (*pm_power_off)(void);
>  EXPORT_SYMBOL_GPL(pm_power_off);
>  
>  #ifdef CONFIG_ARCH_RANDOM

This ifdef must be dropped entirely, it was removed in Jason's tree.

> -bool __must_check arch_get_random_seed_long(unsigned long *v)
> +size_T __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)

Typo, should be size_t.

>  {
> -	if (ppc_md.get_random_seed)
> -		return ppc_md.get_random_seed(v);
> +	if (max_longs && ppc_md.get_random_seed && ppc_md.get_random_seed(v))
> +		return 1;
>  
> -	return false;
> +	return 0;
>  }
>  EXPORT_SYMBOL(arch_get_random_seed_long);

The export needs to be updated to "arch_get_random_seed_longs".

I've attached the end state of archrandom.h and the hunk in
setup-common.c below for reference.

cheers

==== arch/powerpc/kernel/setup-common.c ====
...

size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
{
	if (max_longs && ppc_md.get_random_seed && ppc_md.get_random_seed(v))
		return 1;

	return 0;
}
EXPORT_SYMBOL(arch_get_random_seed_longs);

...

==== arch/powerpc/include/asm/archrandom.h ====
/* SPDX-License-Identifier: GPL-2.0 */
#ifndef _ASM_POWERPC_ARCHRANDOM_H
#define _ASM_POWERPC_ARCHRANDOM_H

static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
{
	return 0;
}

size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs);

#ifdef CONFIG_PPC_POWERNV
int pnv_get_random_long(unsigned long *v);
#endif

#endif /* _ASM_POWERPC_ARCHRANDOM_H */
