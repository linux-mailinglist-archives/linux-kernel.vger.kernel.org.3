Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C254ED1C6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiCaCch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbiCaCc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:32:26 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502BA84ECF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:30:37 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id t2so20602980pfj.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=LcUCRAMM776VGgsxq5iJwu5PnPzGwErew1c1Sc7pEfI=;
        b=1uX4ntl8U9h2Z9plKz2bYcg5YXgHHtKB/MpCVxsGmPeeB0hTVAxhvMxJPHxy9Oufpl
         eApScllkcnZJTVPvcORlBD9/Dw+1t7TpUQtJhchnH3GdwSUyy2gIT/UMZxjOfUwrNlai
         mGTdQK0C/acKMzydtIf3kbHLFc7xlVgWfwsFshxLRpQ2GMRGRWIjq7au5GqmpqeCuD/t
         zJeVCLVQqRf+wOpvp9uPiNbxIdqi8+JX3QxRT2p81fXfHadYOxGHFMnMp6PhSCrxnqoH
         KvgtVACkxOOCoraF1ekiHyXcKrOuMMXCLlNlof/gTeDRwJeNcmclE4cBqs2gvbB4D5fO
         jEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=LcUCRAMM776VGgsxq5iJwu5PnPzGwErew1c1Sc7pEfI=;
        b=qfrtt8oPeEozg+lcUiSCuXd1yYjx2VzsZJ9DVnxCDBXSmbJ6LBlyET0ZnNZoH/7MYh
         3vog+IxWMWWg/Qfe/0SSsUmqK8XcCrJXSHyhtmglfb602VpHf5TjAFyWVmz1yCiIcg0o
         w1e2iB9T5MXlbJCjz/AYgk9kg7/SVKqhOol1rv2lZC3IXH2xAaixy9h/5jpTvenros7g
         zXTM0fqa17VlvEg06PW+2yBc0Tw0b4+midCvzz8W440skIBhRPKeLuaW5EeEP9Q0VOFt
         c72YYEKUPK7b66n9N7teZPNd+qYbkNOQhTGAZojAlCj04pamE3y6qfbDqnGX65cmay8G
         PNAQ==
X-Gm-Message-State: AOAM531sWwaCVric8lGR4ESOBz+hx+jzx0FSQxv0zYB620DwSs86UIFy
        XuZx7O3B0XbbOro1jf8S1lveyQ==
X-Google-Smtp-Source: ABdhPJzrz3/7AlSrP3PQ5CEbemJBcEhD9VssWPSN479XjXLr96ocr5DmZmcR1ZPAmUx8ZAbriFNKQw==
X-Received: by 2002:a62:5fc4:0:b0:4fa:7a4b:3853 with SMTP id t187-20020a625fc4000000b004fa7a4b3853mr36767910pfb.77.1648693836651;
        Wed, 30 Mar 2022 19:30:36 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id ng17-20020a17090b1a9100b001c9f79927bfsm3535434pjb.25.2022.03.30.19.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 19:30:36 -0700 (PDT)
Date:   Wed, 30 Mar 2022 19:30:36 -0700 (PDT)
X-Google-Original-Date: Wed, 30 Mar 2022 19:30:33 PDT (-0700)
Subject:     Re: [PATCH 2/2] riscv: implement cache-management errata for T-Head SoCs
In-Reply-To: <20220307224620.1933061-3-heiko@sntech.de>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, mick@ics.forth.gr, samuel@sholland.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu, heiko@sntech.de
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de
Message-ID: <mhng-3c71e6fc-cd1c-4796-8b50-6768485b8f4a@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Mar 2022 14:46:20 PST (-0800), heiko@sntech.de wrote:
> The T-Head C906 and C910 implement a scheme for handling
> cache operations different from the generic Zicbom extension.
>
> Add an errata for it next to the generic dma coherency ops.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/Kconfig.erratas           | 10 +++++++
>  arch/riscv/errata/thead/errata.c     |  5 ++++
>  arch/riscv/include/asm/errata_list.h | 45 ++++++++++++++++++++++++++--
>  3 files changed, 57 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> index de4002baa1d0..89a6dcb8ac2a 100644
> --- a/arch/riscv/Kconfig.erratas
> +++ b/arch/riscv/Kconfig.erratas
> @@ -50,4 +50,14 @@ config ERRATA_THEAD_PBMT
>
>  	  If you don't know what to do here, say "Y".
>
> +config ERRATA_THEAD_CMO
> +	bool "Apply T-Head cache management errata"
> +	depends on ERRATA_THEAD && RISCV_DMA_NONCOHERENT
> +	default y
> +	help
> +	  This will apply the cache management errata to handle the
> +	  non-standard handling on non-coherent operations on T-Head SoCs.
> +
> +	  If you don't know what to do here, say "Y".
> +
>  endmenu
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index fd8e0538a3f0..11c26c37425f 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -33,6 +33,11 @@ static const struct errata_info errata_list[ERRATA_THEAD_NUMBER] = {
>  		.stage = RISCV_ALTERNATIVES_EARLY_BOOT,
>  		.check_func = errata_mt_check_func
>  	},
> +	{
> +		.name = "cache-management",
> +		.stage = RISCV_ALTERNATIVES_BOOT,
> +		.check_func = errata_mt_check_func
> +	},
>  };
>
>  static u32 thead_errata_probe(unsigned int stage, unsigned long archid, unsigned long impid)
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 7a2dd61af24d..f7c6805daeab 100644
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
> @@ -104,8 +105,37 @@ asm volatile(ALTERNATIVE(								\
>  #define CBO_CLEAN_A0	".long 0x25200F"
>  #define CBO_FLUSH_A0	".long 0x05200F"
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
> +#define THEAD_INVAL_A0	".long 0x0265000b"
> +#define THEAD_CLEAN_A0	".long 0x0245000b"
> +#define THEAD_FLUSH_A0	".long 0x0275000b"
> +#define THEAD_SYNC_S	".long 0x0190000b"

IIRC this came up before, but these really need to get into the 
assembler as actual instructions.

> +
>  #define ALT_CMO_OP(_op, _start, _size)							\
> -asm volatile(ALTERNATIVE(								\
> +asm volatile(ALTERNATIVE_2(								\
> +	"nop\n\t"									\
>  	"nop\n\t"									\
>  	"nop\n\t"									\
>  	"nop\n\t"									\
> @@ -117,7 +147,16 @@ asm volatile(ALTERNATIVE(								\
>  	CBO_##_op##_A0 "\n\t"								\
>  	"addi a0, a0, %0\n\t"								\
>  	"2:\n\t"									\
> -	"bltu a0, %2, 3b\n\t", 0, CPUFEATURE_CMO, CONFIG_RISCV_DMA_NONCOHERENT)		\
> +	"bltu a0, %2, 3b\n\t"								\
> +	"nop", 0, CPUFEATURE_CMO, CONFIG_RISCV_DMA_NONCOHERENT,				\
> +	"mv a0, %1\n\t"									\
> +	"j 2f\n\t"									\
> +	"3:\n\t"									\
> +	THEAD_##_op##_A0 "\n\t"								\
> +	"addi a0, a0, %0\n\t"								\
> +	"2:\n\t"									\
> +	"bltu a0, %2, 3b\n\t"								\
> +	THEAD_SYNC_S, THEAD_VENDOR_ID, ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO)	\
>  	: : "I"(L1_CACHE_BYTES), "r"((_start) & ~(L1_CACHE_BYTES - 1)),			\
>  	    "r"(ALIGN((_start) + (_size), L1_CACHE_BYTES)))
