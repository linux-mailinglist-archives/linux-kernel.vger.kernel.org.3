Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764A0597032
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbiHQNv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbiHQNvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:51:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE5183046
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C25A6B81DDE
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687ADC433C1;
        Wed, 17 Aug 2022 13:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660744308;
        bh=jblszBzH0OruDrSbrQc1pm4URFZ45M/4s6zdl0Heq0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FO60IAcAjKHExVSp50LcwlM0lVrr+OID3Y4YGNjD4xc5EL/pR72ZCxhielqSmhjRS
         KLhUn9U5udDPGfK1pSqfMxGHeD7GRo5jIw2AG/7qvkGVm+CkSoKZaSAIKLCYMY5YN4
         cwMlrWWgyRuit+9sZPdcMpORq7VmHrQh+UcM6uAkKSEeDN8WGeb2gpvkqiC0x1YawF
         VwpaWsiPZ9GWSMD7ywAS3lKK2gK+mEf3gVNVXQMiqqjweJeEhNs9Csp/pbToio4YN2
         SiAL63zAo6NYrZm5W+iNFZyRxJPgmNR/LwvEsriFk3koB+njr08Pfu0OX88Ge99AH7
         E2YgZFNmT/1EA==
Date:   Wed, 17 Aug 2022 14:51:43 +0100
From:   Will Deacon <will@kernel.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: head: rely on CONFIG_RANDOM_TRUST_CPU
Message-ID: <20220817135143.GB12615@willie-the-truck>
References: <20220817094618.67063-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817094618.67063-1-andrea.righi@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 11:46:18AM +0200, Andrea Righi wrote:
> The CONFIG_ARCH_RANDOM .config option has been removed by
> commit 9592eef7c16e ("random: remove CONFIG_ARCH_RANDOM").
> 
> Depend on CONFIG_RANDOM_TRUST_CPU to determine whether we can rely on
> __arm64_rndr() to initialize the seed for kaslr.
> 
> Fixes: 9592eef7c16e ("random: remove CONFIG_ARCH_RANDOM")
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  arch/arm64/kernel/pi/kaslr_early.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/pi/kaslr_early.c b/arch/arm64/kernel/pi/kaslr_early.c
> index 6c3855e69395..a1e6f90cb6e2 100644
> --- a/arch/arm64/kernel/pi/kaslr_early.c
> +++ b/arch/arm64/kernel/pi/kaslr_early.c
> @@ -94,7 +94,7 @@ asmlinkage u64 kaslr_early_init(void *fdt)
>  
>  	seed = get_kaslr_seed(fdt);
>  	if (!seed) {
> -#ifdef CONFIG_ARCH_RANDOM
> +#ifdef CONFIG_RANDOM_TRUST_CPU
>  		 if (!__early_cpu_has_rndr() ||
>  		     !__arm64_rndr((unsigned long *)&seed))
>  #endif

There was another patch sent for this which just removed the guard
altogether:

https://lore.kernel.org/r/20220721100433.18286-1-lukas.bulwahn@gmail.com

I was planning to pick that one up as a fix for -rc2 as Ard was happy
with it and it matches what Broonie was after as well.

Will
