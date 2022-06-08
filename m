Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2916D54390F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343509AbiFHQbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343541AbiFHQbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:31:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAEE24792B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:29:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A332461900
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 16:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76102C3411D;
        Wed,  8 Jun 2022 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654705775;
        bh=Rl+DUn/Nzlxn4nlbJanjmwhDoU4icyUwT8ssx2EkXCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y0iV9olUahbUYftDKWhbviAUNLNB6RMv87CvNijiYZZQUVVXNYYJT3gP7/0+lEjZB
         hElkhcZJCfcUII6GJh8rEoRFr7BqZ0Z+F7dpPS33V/tD8SJsf2HJTZHCGGl+84O2vK
         juvkd8yiWoboAfKsckJzf8gQMubWwBbkv5+98hJFU/cq/sgOBq5d39GRTkks/dABRL
         /BMsME2Va5LAjG9J7Eu2+pbcdIG8aDJ1CAt2TkHtyHEKwziYeQiJ2nDitm+Dy9flHM
         23zN5b/0zb0x/bqQWaRx9J4+s3jWcwSkl4Y2S+WnWz9jC87ceClq0BBEg6XGh4WnDA
         nMnoxx4bx3bWA==
Date:   Thu, 9 Jun 2022 00:20:52 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russel King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH] riscv: initialize jump labels before early_init_dt_scan()
Message-ID: <YqDMZOTtmOcMlGM7@xhacker>
References: <20220607195752.1146431-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220607195752.1146431-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 09:57:52PM +0200, Jason A. Donenfeld wrote:
> Stephen reported that a static key warning splat appears during early
> boot on arm64 systems that credit randomness from device trees that
> contain an "rng-seed" property, because the dtb is parsed is called
> before jump_label_init() during setup_arch(), which was fixed by
> 73e2d827a501 ("arm64: Initialize jump labels before
> setup_machine_fdt()").
> 
> The same basic issue applies to RISC-V as well. So this commit moves the

> call to jump_label_init() just before early_init_dt_scan().
> jump_label_init() actually requires sbi_init() to be called first for

Moving the sbi_init() earlier has been sent out but the patch is missing
in 5.19-rc1

https://lore.kernel.org/linux-riscv/20220521143456.2759-1-jszhang@kernel.org/T/#m00c3cb5e4e360ca8d7aa10c79c10437b7307c16c



> proper functioning, so it also moves that to the right place.
> 
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Reported-by: Phil Elwell <phil@raspberrypi.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Russel King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Fixes: f5bda35fba61 ("random: use static branch for crng_ready()")
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/riscv/kernel/setup.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index f0f36a4a0e9b..c44c81b1cfb3 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -263,13 +263,15 @@ static void __init parse_dtb(void)
>  
>  void __init setup_arch(char **cmdline_p)
>  {
> +	early_ioremap_setup();
> +	sbi_init();
> +	jump_label_init();
> +
>  	parse_dtb();
>  	setup_initial_init_mm(_stext, _etext, _edata, _end);
>  
>  	*cmdline_p = boot_command_line;
>  
> -	early_ioremap_setup();
> -	jump_label_init();
>  	parse_early_param();
>  
>  	efi_init();
> @@ -285,7 +287,6 @@ void __init setup_arch(char **cmdline_p)
>  	misc_mem_init();
>  
>  	init_resources();
> -	sbi_init();
>  
>  #ifdef CONFIG_KASAN
>  	kasan_init();
> -- 
> 2.35.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
