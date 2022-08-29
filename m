Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0A55A4E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiH2Nhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiH2Nhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:37:46 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57EDF90805;
        Mon, 29 Aug 2022 06:37:43 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oSexS-0006mi-00; Mon, 29 Aug 2022 15:37:42 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 1F5CDC0931; Mon, 29 Aug 2022 15:14:40 +0200 (CEST)
Date:   Mon, 29 Aug 2022 15:14:40 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Ling <gnaygnil@gmail.com>
Subject: Re: [PATCH] MIPS: loongson32: ls1c: Fix hang during startup
Message-ID: <20220829131440.GA12409@alpha.franken.de>
References: <20220823111725.3134377-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823111725.3134377-1-keguang.zhang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 07:17:25PM +0800, Keguang Zhang wrote:
> From: Yang Ling <gnaygnil@gmail.com>
> 
> The RTCCTRL reg of LS1C is obselete.
> Writing this reg will cause system hang.
> 
> Fixes: 60219c563c9b6 ("MIPS: Add RTC support for Loongson1C board")
> Signed-off-by: Yang Ling <gnaygnil@gmail.com>
> Tested-by: Keguang Zhang <keguang.zhang@gmail.com>
> Acked-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  arch/mips/loongson32/ls1c/board.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/loongson32/ls1c/board.c b/arch/mips/loongson32/ls1c/board.c
> index e9de6da0ce51..9dcfe9de55b0 100644
> --- a/arch/mips/loongson32/ls1c/board.c
> +++ b/arch/mips/loongson32/ls1c/board.c
> @@ -15,7 +15,6 @@ static struct platform_device *ls1c_platform_devices[] __initdata = {
>  static int __init ls1c_platform_init(void)
>  {
>  	ls1x_serial_set_uartclk(&ls1x_uart_pdev);
> -	ls1x_rtc_set_extclk(&ls1x_rtc_pdev);
>  
>  	return platform_add_devices(ls1c_platform_devices,
>  				   ARRAY_SIZE(ls1c_platform_devices));
> 
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> -- 
> 2.34.1

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
