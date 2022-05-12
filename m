Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389AB524CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353777AbiELMbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353763AbiELMbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:31:42 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB904924D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:31:35 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1np7yH-00020p-2C; Thu, 12 May 2022 14:31:09 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     mick@ics.forth.gr, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        rppt@kernel.org, david@redhat.com, wangborong@cdjrlc.com,
        twd2.me@gmail.com, seanjc@google.com, alex@ghiti.fr,
        petr.pavlu@suse.com, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        jianghuaming.jhm@alibaba-inc.com, guoren@kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH v2] RISC-V: Mark IORESOURCE_EXCLUSIVE for reserved mem instead of IORESOURCE_BUSY
Date:   Thu, 12 May 2022 14:31:07 +0200
Message-ID: <2583718.X9hSmTKtgW@diego>
In-Reply-To: <20220512060910.601832-1-xianting.tian@linux.alibaba.com>
References: <20220512060910.601832-1-xianting.tian@linux.alibaba.com>
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

Am Donnerstag, 12. Mai 2022, 08:09:10 CEST schrieb Xianting Tian:
> Commit 00ab027a3b82 ("RISC-V: Add kernel image sections to the resource tree")
> marked IORESOURCE_BUSY for reserved memory, which casued resource map

typo "caused" resource map

> failed in subsequent operations of related driver, so remove the
> IORESOURCE_BUSY flag. In order to prohibit userland mapping reserved
> memory, mark IORESOURCE_EXCLUSIVE for it.

Looking at the comment for IORESOURCE_EXCLUSIVE
(/* Userland may not map this resource */)

this also looks like the way better match for "no-map" :-) .

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Also on qemu + d1-nezha board
Tested-by: Heiko Stuebner <heiko@sntech.de>


Heiko

> The code to reproduce the issue,
> dts:
>         mem0: memory@a0000000 {
>                 reg = <0x0 0xa0000000 0 0x1000000>;
>                 no-map;
>         };
> 
>         &test {
>                 status = "okay";
>                 memory-region = <&mem0>;
>         };
> 
> code:
>         np = of_parse_phandle(pdev->dev.of_node, "memory-region", 0);
>         ret = of_address_to_resource(np, 0, &r);
>         base = devm_ioremap_resource(&pdev->dev, &r);
>         // base = -EBUSY
> 
> Fixes: 00ab027a3b82 ("RISC-V: Add kernel image sections to the resource tree")
> Reported-by: Huaming Jiang <jianghuaming.jhm@alibaba-inc.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Nick Kossifidis <mick@ics.forth.gr>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  arch/riscv/kernel/setup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 834eb652a7b9..e0a00739bd13 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -189,7 +189,7 @@ static void __init init_resources(void)
>  		res = &mem_res[res_idx--];
>  
>  		res->name = "Reserved";
> -		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +		res->flags = IORESOURCE_MEM | IORESOURCE_EXCLUSIVE;
>  		res->start = __pfn_to_phys(memblock_region_reserved_base_pfn(region));
>  		res->end = __pfn_to_phys(memblock_region_reserved_end_pfn(region)) - 1;
>  
> @@ -214,7 +214,7 @@ static void __init init_resources(void)
>  
>  		if (unlikely(memblock_is_nomap(region))) {
>  			res->name = "Reserved";
> -			res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +			res->flags = IORESOURCE_MEM | IORESOURCE_EXCLUSIVE;
>  		} else {
>  			res->name = "System RAM";
>  			res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> 




