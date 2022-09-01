Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB5D5A9BA8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiIAP3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbiIAP3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:29:31 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7208A1D4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:29:23 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oTm7o-0005k8-P8; Thu, 01 Sep 2022 17:29:00 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: Re: [PATCH v2 2/4] RISC-V: Move riscv_init_cbom_blocksize() to cacheflush.c
Date:   Thu, 01 Sep 2022 17:29:00 +0200
Message-ID: <5909904.6fTUFtlzNn@diego>
In-Reply-To: <20220830044642.566769-3-apatel@ventanamicro.com>
References: <20220830044642.566769-1-apatel@ventanamicro.com> <20220830044642.566769-3-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Dienstag, 30. August 2022, 06:46:40 CEST schrieb Anup Patel:
> The riscv_cbom_block_size parsing from DT belongs to cacheflush.c which
> is home for all cache maintenance related stuff so let us move the
> riscv_init_cbom_blocksize() and riscv_cbom_block_size to cacheflush.c.
> 
> Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

Makes a lot of sense to keep stuff together.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>


Also, can we handle this as fix patch?

I.e. Currently the t-head code somewhat relies on the default value
set to L1_CACHE_BYTES. The cache-block-size is static there.

Palmers upcoming patch reworking the parsing [0], will remove that default,
so having the riscv_cbom_block_size defined in the cacheflush header
will allow an easy fix by setting that value from the t-head errata init
for those cores.


Heiko

[0] https://lore.kernel.org/r/20220812154010.18280-1-palmer@rivosinc.com

> ---
>  arch/riscv/include/asm/cacheflush.h |  2 ++
>  arch/riscv/mm/cacheflush.c          | 39 +++++++++++++++++++++++++++++
>  arch/riscv/mm/dma-noncoherent.c     | 38 ----------------------------
>  3 files changed, 41 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index a60acaecfeda..de55d6b8deeb 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -42,6 +42,8 @@ void flush_icache_mm(struct mm_struct *mm, bool local);
>  
>  #endif /* CONFIG_SMP */
>  
> +extern unsigned int riscv_cbom_block_size;
> +
>  #ifdef CONFIG_RISCV_ISA_ZICBOM
>  void riscv_init_cbom_blocksize(void);
>  #else
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 6cb7d96ad9c7..336c5deea870 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -3,6 +3,8 @@
>   * Copyright (C) 2017 SiFive
>   */
>  
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <asm/cacheflush.h>
>  
>  #ifdef CONFIG_SMP
> @@ -86,3 +88,40 @@ void flush_icache_pte(pte_t pte)
>  		flush_icache_all();
>  }
>  #endif /* CONFIG_MMU */
> +
> +unsigned int riscv_cbom_block_size = L1_CACHE_BYTES;
> +
> +#ifdef CONFIG_RISCV_ISA_ZICBOM
> +void riscv_init_cbom_blocksize(void)
> +{
> +	struct device_node *node;
> +	int ret;
> +	u32 val;
> +
> +	for_each_of_cpu_node(node) {
> +		unsigned long hartid;
> +		int cbom_hartid;
> +
> +		ret = riscv_of_processor_hartid(node, &hartid);
> +		if (ret)
> +			continue;
> +
> +		if (hartid < 0)
> +			continue;
> +
> +		/* set block-size for cbom extension if available */
> +		ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);
> +		if (ret)
> +			continue;
> +
> +		if (!riscv_cbom_block_size) {
> +			riscv_cbom_block_size = val;
> +			cbom_hartid = hartid;
> +		} else {
> +			if (riscv_cbom_block_size != val)
> +				pr_warn("cbom-block-size mismatched between harts %d and %lu\n",
> +					cbom_hartid, hartid);
> +		}
> +	}
> +}
> +#endif
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> index cd2225304c82..3f502a1a68b1 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -8,11 +8,8 @@
>  #include <linux/dma-direct.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/mm.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <asm/cacheflush.h>
>  
> -static unsigned int riscv_cbom_block_size = L1_CACHE_BYTES;
>  static bool noncoherent_supported;
>  
>  void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
> @@ -75,41 +72,6 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  	dev->dma_coherent = coherent;
>  }
>  
> -#ifdef CONFIG_RISCV_ISA_ZICBOM
> -void riscv_init_cbom_blocksize(void)
> -{
> -	struct device_node *node;
> -	int ret;
> -	u32 val;
> -
> -	for_each_of_cpu_node(node) {
> -		unsigned long hartid;
> -		int cbom_hartid;
> -
> -		ret = riscv_of_processor_hartid(node, &hartid);
> -		if (ret)
> -			continue;
> -
> -		if (hartid < 0)
> -			continue;
> -
> -		/* set block-size for cbom extension if available */
> -		ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);
> -		if (ret)
> -			continue;
> -
> -		if (!riscv_cbom_block_size) {
> -			riscv_cbom_block_size = val;
> -			cbom_hartid = hartid;
> -		} else {
> -			if (riscv_cbom_block_size != val)
> -				pr_warn("cbom-block-size mismatched between harts %d and %lu\n",
> -					cbom_hartid, hartid);
> -		}
> -	}
> -}
> -#endif
> -
>  void riscv_noncoherent_supported(void)
>  {
>  	noncoherent_supported = true;
> 




