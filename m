Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6602F57DB33
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbiGVHY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiGVHYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:24:54 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B502871F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:24:52 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oEn1h-0005HS-AH; Fri, 22 Jul 2022 09:24:45 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, guoren@kernel.org,
        mick@ics.forth.gr, alexandre.ghiti@canonical.com,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, huanyi.xj@alibaba-inc.com,
        heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH 4/5] riscv: Add modules to virtual kernel memory layout dump
Date:   Fri, 22 Jul 2022 09:24:44 +0200
Message-ID: <7405851.EvYhyI6sBW@diego>
In-Reply-To: <20220717101323.370245-5-xianting.tian@linux.alibaba.com>
References: <20220717101323.370245-1-xianting.tian@linux.alibaba.com> <20220717101323.370245-5-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 17. Juli 2022, 12:13:22 CEST schrieb Xianting Tian:
> Modules always live before the kernel, MODULES_END is fixed but
> MODULES_VADDR isn't fixed, it depends on the kernel size.
> Let's add it to virtual kernel memory layout dump.
> 
> As MODULES is only defined for CONFIG_64BIT, so we dump it when
> CONFIG_64BIT=y.
> 
> eg,
> MODULES_VADDR - MODULES_END
> 0xffffffff01133000 - 0xffffffff80000000
> 
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>

I'm still not sure if it would be better to define MODULES_* constants
even on 32bit (with their VMALLOC_START etc values) and prevent
needing the CONFIG_64BIT ifdef, but that's for others to decide :-)

The below also looks good, so
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  arch/riscv/mm/init.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index d466ec670e1f..2c4a64e97aec 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -135,6 +135,10 @@ static void __init print_vm_layout(void)
>  		(unsigned long)VMEMMAP_END);
>  	print_ml("vmalloc", (unsigned long)VMALLOC_START,
>  		(unsigned long)VMALLOC_END);
> +#ifdef CONFIG_64BIT
> +	print_ml("modules", (unsigned long)MODULES_VADDR,
> +		(unsigned long)MODULES_END);
> +#endif
>  	print_ml("lowmem", (unsigned long)PAGE_OFFSET,
>  		(unsigned long)high_memory);
>  	if (IS_ENABLED(CONFIG_64BIT)) {
> 




