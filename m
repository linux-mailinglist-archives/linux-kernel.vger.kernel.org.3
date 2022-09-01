Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3B75A9BD3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiIAPjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbiIAPi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:38:59 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3050E7B2A6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:38:57 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oTmHO-0005mr-3g; Thu, 01 Sep 2022 17:38:54 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: Re: [PATCH v2 3/4] RISC-V: Implement arch specific PMEM APIs
Date:   Thu, 01 Sep 2022 17:38:53 +0200
Message-ID: <13199249.VsHLxoZxqI@diego>
In-Reply-To: <20220830044642.566769-4-apatel@ventanamicro.com>
References: <20220830044642.566769-1-apatel@ventanamicro.com> <20220830044642.566769-4-apatel@ventanamicro.com>
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

Hi Anup,

Am Dienstag, 30. August 2022, 06:46:41 CEST schrieb Anup Patel:
> The NVDIMM PMEM driver expects arch specific APIs for cache maintenance
> and if arch does not provide these APIs then NVDIMM PMEM driver will
> always use MEMREMAP_WT to map persistent memory which in-turn maps as
> UC memory type defined by the RISC-V Svpbmt specification.
> 
> Now that the Svpbmt and Zicbom support is available in RISC-V kernel,
> we implement PMEM APIs using ALT_CMO_OP() macros so that the NVDIMM
> PMEM driver can use MEMREMAP_WB to map persistent memory.

Zicbom is detected at runtime, though that kconfig setting changes the
behaviour for the memremap-type at compile-time. So what happens on
systems not using zicbom (or another cmo-variant) ?


Heiko

> Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/Kconfig     |  1 +
>  arch/riscv/mm/Makefile |  1 +
>  arch/riscv/mm/pmem.c   | 21 +++++++++++++++++++++
>  3 files changed, 23 insertions(+)
>  create mode 100644 arch/riscv/mm/pmem.c
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0ebd8da388d8..37d6370d29c3 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -25,6 +25,7 @@ config RISCV
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_HAS_KCOV
>  	select ARCH_HAS_MMIOWB
> +	select ARCH_HAS_PMEM_API
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_SET_DIRECT_MAP if MMU
>  	select ARCH_HAS_SET_MEMORY if MMU
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index d76aabf4b94d..3b368e547f83 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -31,3 +31,4 @@ endif
>  
>  obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
>  obj-$(CONFIG_RISCV_DMA_NONCOHERENT) += dma-noncoherent.o
> +obj-$(CONFIG_ARCH_HAS_PMEM_API) += pmem.o
> diff --git a/arch/riscv/mm/pmem.c b/arch/riscv/mm/pmem.c
> new file mode 100644
> index 000000000000..089df92ae876
> --- /dev/null
> +++ b/arch/riscv/mm/pmem.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Ventana Micro Systems Inc.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/libnvdimm.h>
> +
> +#include <asm/cacheflush.h>
> +
> +void arch_wb_cache_pmem(void *addr, size_t size)
> +{
> +	ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size);
> +}
> +EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
> +
> +void arch_invalidate_pmem(void *addr, size_t size)
> +{
> +	ALT_CMO_OP(inval, addr, size, riscv_cbom_block_size);
> +}
> +EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
> 




