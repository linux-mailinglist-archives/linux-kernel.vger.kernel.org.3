Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259E6520E63
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241627AbiEJHex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbiEJH0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:26:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55363A5D7;
        Tue, 10 May 2022 00:22:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E0D2B81A0A;
        Tue, 10 May 2022 07:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F7AC385A6;
        Tue, 10 May 2022 07:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652167343;
        bh=7K3MJOtEcuHFbzjGMBK9G/czvkGrWXEYQvzkmmVBkhQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kZWStkvFA8dnpda13YuPiWGK0wi+F3QMo+0rLC4WwxoXWbBokY9OOoBlHQk5hoX6H
         9Ev58O9/bLrAXY12Cp+Zy0Fqxwhr2JFzkFkd5C4K2WzSiLpUWI5R7c+l9FTvQ1V3BN
         W74dn3lvc5yAgBieYb9QwIO9r0d4vlpc/L/qbIs0KkAVctuDVdMQGa1unzI3GJHOAU
         hOJfC70rggZj7Q+1r3OGZaEVGpb+4eUjFQoTmZzwymFGdocaVeuXngtRtXylCyBLkq
         AQfI43pXdyN4PA1DaXOCo/EBp9j7xa0gMelyDi7lLpS6lbBwHob9TKQ1gDQxT7wt/g
         z79lkfNH5V6BA==
Message-ID: <20fd1a74-c0f5-d8e9-4903-b74c185d5aa3@kernel.org>
Date:   Tue, 10 May 2022 10:22:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] memory: OMAP_GPMC should depend on ARCH_OMAP2PLUS ||
 ARCH_K3
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <2b7d411b4a7913335082c858cb0d63b9e4bf7c5b.1652103920.git.geert+renesas@glider.be>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <2b7d411b4a7913335082c858cb0d63b9e4bf7c5b.1652103920.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 09/05/2022 16:48, Geert Uytterhoeven wrote:
> The Texas Instruments OMAP General Purpose Memory Controller (GPMC) is
> only present on TI OMAP2/3/4/5, AM33xx, AM43x, DRA7xx, TI81xx, and K3
> SoCs.  Hence add a dependency on ARCH_OMAP2PLUS || ARCH_K3, to prevent
> asking the user about this driver when configuring a kernel without
> OMAP2+ or K3 SoC family support.
> 
> Fixes: be34f45f0d4aa91c ("memory: omap-gpmc: Make OMAP_GPMC config visible and selectable")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/memory/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index b7800b37af78a996..f00757912e2e4c1e 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -105,6 +105,7 @@ config TI_EMIF
>  config OMAP_GPMC
>  	tristate "Texas Instruments OMAP SoC GPMC driver"
>  	depends on OF_ADDRESS
> +	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
>  	select GPIOLIB
>  	help
>  	  This driver is for the General Purpose Memory Controller (GPMC)

Is there any possibility that CONFIG_IRQ_DOMAIN is not set while both
OF_ADDRESS and COMPILE_TEST are set?

That particular case will lead to build failures.

e.g.
https://krzk.eu/#/builders/63/builds/162

cheers,
-roger
