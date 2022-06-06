Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E334153E028
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 05:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiFFDh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 23:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiFFDhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 23:37:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDECCDEB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 20:37:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 184AE60ECA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35278C385A9;
        Mon,  6 Jun 2022 03:37:13 +0000 (UTC)
Message-ID: <6f553593-2dc5-a631-628b-51ecbdd0290a@linux-m68k.org>
Date:   Mon, 6 Jun 2022 13:37:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] m68k: coldfire/device.c: protect FLEXCAN blocks
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, uclinux-dev@uclinux.org,
        Angelo Dureghello <angelo@kernel-space.org>
References: <20220531021712.6050-1-rdunlap@infradead.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20220531021712.6050-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 31/5/22 12:17, Randy Dunlap wrote:
> When CAN_FLEXCAN=y and M5441x is not set/enabled, there are build
> errors in coldfire/device.c:
> 
> ../arch/m68k/coldfire/device.c:595:26: error: 'MCFFLEXCAN_BASE0' undeclared here (not in a function); did you mean 'MCFDMA_BASE0'?
>    595 |                 .start = MCFFLEXCAN_BASE0,
> ../arch/m68k/coldfire/device.c:596:43: error: 'MCFFLEXCAN_SIZE' undeclared here (not in a function)
>    596 |                 .end = MCFFLEXCAN_BASE0 + MCFFLEXCAN_SIZE,
> ../arch/m68k/coldfire/device.c:600:26: error: 'MCF_IRQ_IFL0' undeclared here (not in a function); did you mean 'MCF_IRQ_I2C0'?
>    600 |                 .start = MCF_IRQ_IFL0,
> ../arch/m68k/coldfire/device.c:605:26: error: 'MCF_IRQ_BOFF0' undeclared here (not in a function); did you mean 'MCF_IRQ_I2C0'?
>    605 |                 .start = MCF_IRQ_BOFF0,
> ../arch/m68k/coldfire/device.c:610:26: error: 'MCF_IRQ_ERR0' undeclared here (not in a function); did you mean 'MCF_IRQ_I2C0'?
>    610 |                 .start = MCF_IRQ_ERR0,
> 
> Protect the FLEXCAN code blocks by checking if MCFFLEXCAN_SIZE
> is defined.
> 
> Fixes: 35a9f9363a89 ("m68k: m5441x: add flexcan support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Greg Ungerer <gerg@linux-m68k.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: uclinux-dev@uclinux.org
> Cc: Angelo Dureghello <angelo@kernel-space.org>

Thanks. Added to the m68knommu git tree, for-next branch.

Regards
Greg


> ---
>   arch/m68k/coldfire/device.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- a/arch/m68k/coldfire/device.c
> +++ b/arch/m68k/coldfire/device.c
> @@ -581,7 +581,7 @@ static struct platform_device mcf_esdhc
>   };
>   #endif /* MCFSDHC_BASE */
>   
> -#if IS_ENABLED(CONFIG_CAN_FLEXCAN)
> +#ifdef MCFFLEXCAN_SIZE
>   
>   #include <linux/can/platform/flexcan.h>
>   
> @@ -620,7 +620,7 @@ static struct platform_device mcf_flexca
>   	.resource = mcf5441x_flexcan0_resource,
>   	.dev.platform_data = &mcf5441x_flexcan_info,
>   };
> -#endif /* IS_ENABLED(CONFIG_CAN_FLEXCAN) */
> +#endif /* MCFFLEXCAN_SIZE */
>   
>   static struct platform_device *mcf_devices[] __initdata = {
>   	&mcf_uart,
> @@ -657,7 +657,7 @@ static struct platform_device *mcf_devic
>   #ifdef MCFSDHC_BASE
>   	&mcf_esdhc,
>   #endif
> -#if IS_ENABLED(CONFIG_CAN_FLEXCAN)
> +#ifdef MCFFLEXCAN_SIZE
>   	&mcf_flexcan0,
>   #endif
>   };
