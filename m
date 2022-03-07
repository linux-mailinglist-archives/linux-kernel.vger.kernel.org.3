Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B1D4CF13F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 06:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbiCGFlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 00:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiCGFlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 00:41:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6902C4D254
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 21:40:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24175B81011
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03129C340E9;
        Mon,  7 Mar 2022 05:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646631625;
        bh=5XOh3App5Q+WwZkOVqm8+eKSM/yHkkaClsQlSBsELvo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nrf2eQ40KAUU8Zr6LXfx/tgHqewwLG/5Mh5fAGBiGyEjlQ9vPdSg3lKkMRhHMvLNq
         sW5Y2jbEqXw5Fx4dKvXlY1ueSVOKMZZYXYKPn/U7OnV/r+GueDJvp+F26qvl5h1kUY
         rnzbg8cvwMGnm8AUm3+kV4bECKtpaPg1XWvvHEWNMzW57CnYOQFmdy7jiOCbwiXWhQ
         jXsP0Y6jGVON5pnendeZKP8n21knnVogXAotDb9XgE22Qfv5XNrmbf7H26cdQ7GIKA
         xI52cpiGcUwJ2LNRz6SIg0HYyWFSqGZ15BoD4OZGefDiWdWOpP3RAVrqdFIYZIL4US
         LLz3XFI8jMisA==
Message-ID: <6e41fed4-1eaf-607b-d43c-12f2be9c1af6@kernel.org>
Date:   Mon, 7 Mar 2022 15:40:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] m68k: coldfire/device.c: only build for MCF_EDMA when
 h/w macros are defined
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Angelo Dureghello <angelo@sysam.it>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, uclinux-dev@uclinux.org
References: <20220305064036.4879-1-rdunlap@infradead.org>
From:   Greg Ungerer <gerg@kernel.org>
In-Reply-To: <20220305064036.4879-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/3/22 16:40, Randy Dunlap wrote:
> When CONFIG_MCF_EDMA is set (due to COMPILE_TEST, not due to
> CONFIG_M5441x), coldfire/device.c has compile errors due to
> missing MCFEDMA_* symbols. In the .config file that was provided,
> CONFIG_M5206=y, not CONFIG_M5441x, so <asm/m5441xsim.h> is not
> included in coldfire/device.c.
> 
> Only build the MCF_EDMA code in coldfire/device.c if the MCFEDMA_*
> hardware macros are defined.
> 
> Fixes these build errors:
> 
> ../arch/m68k/coldfire/device.c:512:35: error: 'MCFEDMA_BASE' undeclared here (not in a function); did you mean 'MCFDMA_BASE1'?
>    512 |                 .start          = MCFEDMA_BASE,
> ../arch/m68k/coldfire/device.c:513:50: error: 'MCFEDMA_SIZE' undeclared here (not in a function)
>    513 |                 .end            = MCFEDMA_BASE + MCFEDMA_SIZE - 1,
> ../arch/m68k/coldfire/device.c:517:35: error: 'MCFEDMA_IRQ_INTR0' undeclared here (not in a function)
>    517 |                 .start          = MCFEDMA_IRQ_INTR0,
> ../arch/m68k/coldfire/device.c:523:35: error: 'MCFEDMA_IRQ_INTR16' undeclared here (not in a function)
>    523 |                 .start          = MCFEDMA_IRQ_INTR16,
> ../arch/m68k/coldfire/device.c:529:35: error: 'MCFEDMA_IRQ_INTR56' undeclared here (not in a function)
>    529 |                 .start          = MCFEDMA_IRQ_INTR56,
> ../arch/m68k/coldfire/device.c:535:35: error: 'MCFEDMA_IRQ_ERR' undeclared here (not in a function)
>    535 |                 .start          = MCFEDMA_IRQ_ERR,
> 
> Fixes: d7e9d01ac292 ("m68k: add ColdFire mcf5441x eDMA platform support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: lore.kernel.org/r/202203030252.P752DK46-lkp@intel.com
> Cc: Angelo Dureghello <angelo@sysam.it>
> Cc: Greg Ungerer <gerg@kernel.org>
> Cc: Greg Ungerer <gerg@linux-m68k.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: uclinux-dev@uclinux.org

Thanks for taking care of this.
Pushed into the m68knommu git tree.

Regards
Greg



> ---
> v2: only build when the hardware macros are defined (suggested by Geert)
> v3: complete the Subject.
> 
>   arch/m68k/coldfire/device.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- linux-next-20220303.orig/arch/m68k/coldfire/device.c
> +++ linux-next-20220303/arch/m68k/coldfire/device.c
> @@ -480,7 +480,7 @@ static struct platform_device mcf_i2c5 =
>   #endif /* MCFI2C_BASE5 */
>   #endif /* IS_ENABLED(CONFIG_I2C_IMX) */
>   
> -#if IS_ENABLED(CONFIG_MCF_EDMA)
> +#ifdef MCFEDMA_BASE
>   
>   static const struct dma_slave_map mcf_edma_map[] = {
>   	{ "dreq0", "rx-tx", MCF_EDMA_FILTER_PARAM(0) },
> @@ -552,7 +552,7 @@ static struct platform_device mcf_edma =
>   		.platform_data = &mcf_edma_data,
>   	}
>   };
> -#endif /* IS_ENABLED(CONFIG_MCF_EDMA) */
> +#endif /* MCFEDMA_BASE */
>   
>   #ifdef MCFSDHC_BASE
>   static struct mcf_esdhc_platform_data mcf_esdhc_data = {
> @@ -651,7 +651,7 @@ static struct platform_device *mcf_devic
>   	&mcf_i2c5,
>   #endif
>   #endif
> -#if IS_ENABLED(CONFIG_MCF_EDMA)
> +#ifdef MCFEDMA_BASE
>   	&mcf_edma,
>   #endif
>   #ifdef MCFSDHC_BASE
