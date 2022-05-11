Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CEC522C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242124AbiEKGcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242108AbiEKGcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:32:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8853ED19;
        Tue, 10 May 2022 23:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F198617AA;
        Wed, 11 May 2022 06:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78774C385DB;
        Wed, 11 May 2022 06:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652250722;
        bh=R/xIMoC2sDOdXzRp4z3fCiF/cRNt3/pLSC+250ZSbdo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AtAgiq8s4WkfPFvmodrvV4U4hTO8tfnwUxbkYz3J3WNBSl7MCPJtYHTgvhOAh4ToL
         TEBxG0FaLR7TsktpJ3WpVavp2fNVN0oxKpAQzOP2KJeJB2T7ef7fMGIkWlcHcKvGqX
         s9iK1Aii1/uL4Ne+bH96ORXpI9v3wss3oD+s8ihE4a5Flwqmju+o/zgv3bA+LaD4yg
         W1hd/ydb2bIGq1w9jY4fkBQ072pRirW23ARBWyJVJbk2opHo+2xQSwUXM9r+N/NG3t
         ct5jugxxh86FM2T1vEvu1PCz/TkBUu+/1uaWnoG4G1ABihvqykiMrM2MrywxRDXB/H
         +vyY8cK5JqpBQ==
Message-ID: <8a1acf21-94f9-fe68-0cda-6be27aa89668@kernel.org>
Date:   Wed, 11 May 2022 09:31:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] memory: OMAP_GPMC should depend on ARCH_OMAP2PLUS ||
 ARCH_KEYSTONE || ARCH_K3
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f6780f572f882ed6ab5934321942cf2b412bf8d1.1652174849.git.geert+renesas@glider.be>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <f6780f572f882ed6ab5934321942cf2b412bf8d1.1652174849.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/2022 12:29, Geert Uytterhoeven wrote:
> The Texas Instruments OMAP General Purpose Memory Controller (GPMC) is
> only present on TI OMAP2/3/4/5, Keystone, AM33xx, AM43x, DRA7xx, TI81xx,
> and K3 SoCs.  Hence add a dependency on ARCH_OMAP2PLUS || ARCH_KEYSTONE
> || ARCH_K3, to prevent asking the user about this driver when
> configuring a kernel without OMAP2+, Keystone, or K3 SoC family support.
> 
> Fixes: be34f45f0d4aa91c ("memory: omap-gpmc: Make OMAP_GPMC config visible and selectable")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Roger Quadros <rogerq@kernel.org>


> ---
> v2:
>   - Add ARCH_KEYSTONE, as requested by Roger Quadros.
> ---
>  drivers/memory/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index b7800b37af78a996..ac1a411648d8656f 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -105,6 +105,7 @@ config TI_EMIF
>  config OMAP_GPMC
>  	tristate "Texas Instruments OMAP SoC GPMC driver"
>  	depends on OF_ADDRESS
> +	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>  	select GPIOLIB
>  	help
>  	  This driver is for the General Purpose Memory Controller (GPMC)
