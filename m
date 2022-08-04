Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D225589555
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 02:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbiHDA3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 20:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238499AbiHDA26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 20:28:58 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891DB59277
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 17:28:56 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id d7so13485064pgc.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 17:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=tO+wsGhSIZsG6c5Z1F7KUZCWEiBIeM5DSp57+76HAlQ=;
        b=XZA0eFnsUfz5rWb15WLff/IXlvW/hjpuRAikCDaV56k9OIuNq8mTZsqY8zpKJExSXU
         GZ4hPwqBWwRQyOfjyd+pzpNaLvIPr/rNqlZ0gZBQOgmqyrpjNPe+QQ9NG1Not+QUGuw8
         XHjeRwTY2974E8cL6MkjWVXxHCeJwTFX3AuQD/G5s3m8Cnd5P6Jzubz2okXuWnnzOW12
         X2KkZrr7ka5cORr1zQAH4FsdxlzMTPoudqLzYyZ21ueabdqXL8KH/Px+4tYCQwlWqjR1
         F46+6RDZaIdhD38h5CRh1VrEHVclpJVqrxzNd/UJt/tbmg8muNuychEPOfV0trI5oP0l
         Gj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=tO+wsGhSIZsG6c5Z1F7KUZCWEiBIeM5DSp57+76HAlQ=;
        b=K2lQx/w6ypY/258qAtdKZAHvl8WzhZWkZuWgWy2ulJ2tPpp6azsDwHpHJ4Ia9/9aZv
         BHs0jW0qibYVAhxFnxmVZI21tsZXlw4MPINsMCCZUx+rk52VTuAWzx2TxTKxI7tX85lz
         lupJPZRvOLlS7enYZJaZzkDyWdLXUgii5nLVIAr5euMTEHzPBvtw4DjP7Ym1DjPoKdsY
         /9V1F5z77oFyqTRV0svD1RPgvuwTjTyH7C/La9V8vjFHZ03pR5I2zQ/05fagKks7DePf
         42cqame/3JmbZ72TbxB9jdOxkUeVWzxgG/KMp/31cdPeXUqg161bFPX+nj6LHtsyZ6VE
         6crw==
X-Gm-Message-State: AJIora+vRBh8wsnHVAOkpI7szFoVtV/be/Ca3w+j6k3fY3IQPkUg9IYW
        M6f6yvxHWhkHhUyngRrrnR200w==
X-Google-Smtp-Source: AGRyM1s0DV1sadB+/WiUHXwXBFAI4nR8qQ286Fi+9cysQML65r1WIlsN0IhL/DJe+frrhzM7J9NOdQ==
X-Received: by 2002:a63:1b13:0:b0:41a:6481:56e0 with SMTP id b19-20020a631b13000000b0041a648156e0mr22946113pgb.5.1659572935803;
        Wed, 03 Aug 2022 17:28:55 -0700 (PDT)
Received: from localhost ([50.221.140.186])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090322d200b0016892555955sm2594114plg.179.2022.08.03.17.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 17:28:55 -0700 (PDT)
Date:   Wed, 03 Aug 2022 17:28:55 -0700 (PDT)
X-Google-Original-Date: Wed, 03 Aug 2022 17:28:53 PDT (-0700)
Subject:     Re: [PATCH v7 4/4] riscv: implement cache-management errata for T-Head SoCs
In-Reply-To: <20220706231536.2041855-5-heiko@sntech.de>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, Christoph Hellwig <hch@lst.de>,
        samuel@sholland.org, atishp@atishpatra.org, anup@brainfault.org,
        mick@ics.forth.gr, robh+dt@kernel.org, krzk+dt@kernel.org,
        devicetree@vger.kernel.org, drew@beagleboard.org,
        rdunlap@infradead.org, heiko@sntech.de
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de
Message-ID: <mhng-d90c67dc-ace1-4413-9010-f9f26c60d3da@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jul 2022 16:15:36 PDT (-0700), heiko@sntech.de wrote:
> The T-Head C906 and C910 implement a scheme for handling
> cache operations different from the generic Zicbom extension.
>
> Add an errata for it next to the generic dma coherency ops.
>
> Reviewed-by: Samuel Holland <samuel@sholland.org>
> Tested-by: Samuel Holland <samuel@sholland.org>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/Kconfig.erratas           | 11 +++++++
>  arch/riscv/errata/thead/errata.c     | 20 ++++++++++++
>  arch/riscv/include/asm/errata_list.h | 48 +++++++++++++++++++++++++---
>  3 files changed, 74 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> index 457ac72c9b36..3223e533fd87 100644
> --- a/arch/riscv/Kconfig.erratas
> +++ b/arch/riscv/Kconfig.erratas
> @@ -55,4 +55,15 @@ config ERRATA_THEAD_PBMT
>
>  	  If you don't know what to do here, say "Y".
>
> +config ERRATA_THEAD_CMO
> +	bool "Apply T-Head cache management errata"
> +	depends on ERRATA_THEAD
> +	select RISCV_DMA_NONCOHERENT
> +	default y
> +	help
> +	  This will apply the cache management errata to handle the
> +	  non-standard handling on non-coherent operations on T-Head SoCs.
> +
> +	  If you don't know what to do here, say "Y".
> +
>  endmenu
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index b37b6fedd53b..202c83f677b2 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -27,6 +27,23 @@ static bool errata_probe_pbmt(unsigned int stage,
>  	return false;
>  }
>
> +static bool errata_probe_cmo(unsigned int stage,
> +			     unsigned long arch_id, unsigned long impid)
> +{
> +#ifdef CONFIG_ERRATA_THEAD_CMO
> +	if (arch_id != 0 || impid != 0)
> +		return false;
> +
> +	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> +		return false;
> +
> +	riscv_noncoherent_supported();
> +	return true;
> +#else
> +	return false;
> +#endif
> +}
> +
>  static u32 thead_errata_probe(unsigned int stage,
>  			      unsigned long archid, unsigned long impid)
>  {
> @@ -35,6 +52,9 @@ static u32 thead_errata_probe(unsigned int stage,
>  	if (errata_probe_pbmt(stage, archid, impid))
>  		cpu_req_errata |= (1U << ERRATA_THEAD_PBMT);
>
> +	if (errata_probe_cmo(stage, archid, impid))
> +		cpu_req_errata |= (1U << ERRATA_THEAD_CMO);
> +
>  	return cpu_req_errata;
>  }
>
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 79d89aeeaa6c..19a771085781 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -16,7 +16,8 @@
>
>  #ifdef CONFIG_ERRATA_THEAD
>  #define	ERRATA_THEAD_PBMT 0
> -#define	ERRATA_THEAD_NUMBER 1
> +#define	ERRATA_THEAD_CMO 1
> +#define	ERRATA_THEAD_NUMBER 2
>  #endif
>
>  #define	CPUFEATURE_SVPBMT 0
> @@ -88,17 +89,54 @@ asm volatile(ALTERNATIVE(						\
>  #define ALT_THEAD_PMA(_val)
>  #endif
>
> +/*
> + * dcache.ipa rs1 (invalidate, physical address)
> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *   0000001    01010      rs1       000      00000  0001011
> + * dache.iva rs1 (invalida, virtual address)
> + *   0000001    00110      rs1       000      00000  0001011
> + *
> + * dcache.cpa rs1 (clean, physical address)
> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *   0000001    01001      rs1       000      00000  0001011
> + * dcache.cva rs1 (clean, virtual address)
> + *   0000001    00100      rs1       000      00000  0001011
> + *
> + * dcache.cipa rs1 (clean then invalidate, physical address)
> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *   0000001    01011      rs1       000      00000  0001011
> + * dcache.civa rs1 (... virtual address)
> + *   0000001    00111      rs1       000      00000  0001011
> + *
> + * sync.s (make sure all cache operations finished)
> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *   0000000    11001     00000      000      00000  0001011
> + */
> +#define THEAD_inval_A0	".long 0x0265000b"
> +#define THEAD_clean_A0	".long 0x0245000b"
> +#define THEAD_flush_A0	".long 0x0275000b"
> +#define THEAD_SYNC_S	".long 0x0190000b"

I'm not sure what to do with these: I really don't want to have a bunch 
of raw binary instruction encodings floating around, but it looks like 
the T-Head folks want to re-write their ISA manual before merging the 
GAS support for it which means we'd be stuck going another release cycle 
(and presumably another year of LTS) before getting the hardware 
supported.  It really seems like we're just going in circles here trying 
to get everything lined up, and it's getting silly blocking real 
hardware from working because of a little bit of ugliness.

I know I said I really don't want the executable .long stuff for this, 
and IIRC that's a pretty common sentiment.  I'm not sure if I'm just fed 
up with all the craziness, but I'm kind of inclined to just merge this 
as-is -- at least that way we can get the hardware working.  In the long 
run I think we're going to end up with some much uglier errata, so I 
doubt we'll be all that worried about this one later.

That said, I'll give folks some time to chime in as IIRC this has been 
pointed out a handful of times.

> +
>  #define ALT_CMO_OP(_op, _start, _size, _cachesize)			\
> -asm volatile(ALTERNATIVE(						\
> -	__nops(5),							\
> +asm volatile(ALTERNATIVE_2(						\
> +	__nops(6),							\
>  	"mv a0, %1\n\t"							\
>  	"j 2f\n\t"							\
>  	"3:\n\t"							\
>  	"cbo." __stringify(_op) " (a0)\n\t"				\
>  	"add a0, a0, %0\n\t"						\
>  	"2:\n\t"							\
> -	"bltu a0, %2, 3b\n\t", 0,					\
> -		CPUFEATURE_ZICBOM, CONFIG_RISCV_ISA_ZICBOM)		\
> +	"bltu a0, %2, 3b\n\t"						\
> +	"nop", 0, CPUFEATURE_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,		\
> +	"mv a0, %1\n\t"							\
> +	"j 2f\n\t"							\
> +	"3:\n\t"							\
> +	THEAD_##_op##_A0 "\n\t"						\
> +	"add a0, a0, %0\n\t"						\
> +	"2:\n\t"							\
> +	"bltu a0, %2, 3b\n\t"						\
> +	THEAD_SYNC_S, THEAD_VENDOR_ID,					\
> +			ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO)	\
>  	: : "r"(_cachesize),						\
>  	    "r"((unsigned long)(_start) & ~((_cachesize) - 1UL)),	\
>  	    "r"((unsigned long)(_start) + (_size))			\
