Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3A84B86EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiBPLoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:44:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiBPLoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:44:04 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31BA238;
        Wed, 16 Feb 2022 03:43:50 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nKIim-00075Q-H5; Wed, 16 Feb 2022 12:43:44 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 4/6] RISC-V: Implement multi-letter ISA extension probing framework
Date:   Wed, 16 Feb 2022 12:43:43 +0100
Message-ID: <9295809.TOyiF8mCWT@diego>
In-Reply-To: <20220216002911.1219593-5-atishp@rivosinc.com>
References: <20220216002911.1219593-1-atishp@rivosinc.com> <20220216002911.1219593-5-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 16. Februar 2022, 01:29:09 CET schrieb Atish Patra:
> Multi-letter extensions can be probed using exising
> riscv_isa_extension_available API now. It doesn't support versioning
> right now as there is no use case for it.
> Individual extension specific implementation will be added during
> each extension support.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

With my in-flight svpbmt series:
Tested-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  arch/riscv/include/asm/hwcap.h | 18 ++++++++++++++++++
>  arch/riscv/kernel/cpufeature.c | 24 ++++++++++++++++++------
>  2 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 5ce50468aff1..170bd80da520 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -34,7 +34,25 @@ extern unsigned long elf_hwcap;
>  #define RISCV_ISA_EXT_s		('s' - 'a')
>  #define RISCV_ISA_EXT_u		('u' - 'a')
>  
> +/*
> + * Increse this to higher value as kernel support more ISA extensions.
> + */
>  #define RISCV_ISA_EXT_MAX	64
> +#define RISCV_ISA_EXT_NAME_LEN_MAX 32
> +
> +/* The base ID for multi-letter ISA extensions */
> +#define RISCV_ISA_EXT_BASE 26
> +
> +/*
> + * This enum represent the logical ID for each multi-letter RISC-V ISA extension.
> + * The logical ID should start from RISCV_ISA_EXT_BASE and must not exceed
> + * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
> + * extensions while all the multi-letter extensions should define the next
> + * available logical extension id.
> + */
> +enum riscv_isa_ext_id {
> +	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
> +};
>  
>  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index cd9eb34f8d11..59c70c104256 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -83,7 +83,7 @@ void __init riscv_fill_hwcap(void)
>  
>  	for_each_of_cpu_node(node) {
>  		unsigned long this_hwcap = 0;
> -		unsigned long this_isa = 0;
> +		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
>  
>  		if (riscv_of_processor_hartid(node) < 0)
>  			continue;
> @@ -100,6 +100,7 @@ void __init riscv_fill_hwcap(void)
>  		if (!strncmp(isa, "rv64", 4))
>  			isa += 4;
>  #endif
> +		bitmap_zero(this_isa, RISCV_ISA_EXT_MAX);
>  		for (; *isa; ++isa) {
>  			const char *ext = isa++;
>  			const char *ext_end = isa;
> @@ -167,12 +168,22 @@ void __init riscv_fill_hwcap(void)
>  			if (*isa != '_')
>  				--isa;
>  
> +#define SET_ISA_EXT_MAP(name, bit)						\
> +			do {							\
> +				if ((ext_end - ext == sizeof(name) - 1) &&	\
> +				     !memcmp(ext, name, sizeof(name) - 1)) {    \
> +					set_bit(bit, this_isa);			\
> +					pr_info("Found ISA extension %s", name);\
> +				}						\
> +			} while (false)						\
> +
>  			if (unlikely(ext_err))
>  				continue;
>  			if (!ext_long) {
>  				this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
> -				this_isa |= (1UL << (*ext - 'a'));
> +				set_bit(*ext - 'a', this_isa);
>  			}
> +#undef SET_ISA_EXT_MAP
>  		}
>  
>  		/*
> @@ -185,10 +196,11 @@ void __init riscv_fill_hwcap(void)
>  		else
>  			elf_hwcap = this_hwcap;
>  
> -		if (riscv_isa[0])
> -			riscv_isa[0] &= this_isa;
> +		if (bitmap_weight(riscv_isa, RISCV_ISA_EXT_MAX))
> +			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
>  		else
> -			riscv_isa[0] = this_isa;
> +			bitmap_copy(riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
> +
>  	}
>  
>  	/* We don't support systems with F but without D, so mask those out
> @@ -202,7 +214,7 @@ void __init riscv_fill_hwcap(void)
>  	for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
>  		if (riscv_isa[0] & BIT_MASK(i))
>  			print_str[j++] = (char)('a' + i);
> -	pr_info("riscv: ISA extensions %s\n", print_str);
> +	pr_info("riscv: base ISA extensions %s\n", print_str);
>  
>  	memset(print_str, 0, sizeof(print_str));
>  	for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
> 




