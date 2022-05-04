Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2279451A012
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350089AbiEDM72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350103AbiEDM65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:58:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FE23192A3;
        Wed,  4 May 2022 05:55:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 301B31042;
        Wed,  4 May 2022 05:55:21 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E705A3FA49;
        Wed,  4 May 2022 05:55:19 -0700 (PDT)
Date:   Wed, 4 May 2022 13:55:16 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     IotaHydrae <writeforever@foxmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: sunxi: fix f1c100s pinctrl function.
Message-ID: <20220504135516.36072ece@donnerap.cambridge.arm.com>
In-Reply-To: <tencent_70C1308DDA794C81CAEF389049055BACEC09@qq.com>
References: <tencent_70C1308DDA794C81CAEF389049055BACEC09@qq.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 May 2022 19:59:04 +0800
IotaHydrae <writeforever@foxmail.com> wrote:

Hi,

thanks for the patch!

I think the subject should start with: "pinctrl: sunxi:", also please
mention the UART in there.

> 1. change suniv f1c100s pinctrl,PD14 multiplexing function lvds1 to uart2
> 
> When the pin PD13 and PD14 is setting up to uart2 function in dts,
> there's an error occurred:
> 1c20800.pinctrl: unsupported function uart2 on pin PD14
> 
> Because 'uart2' is not any one multiplexing option of PD14,
> and pinctrl don't know how to configure it.
> 
> So change the pin PD14 lvds1 function to uart2.
> 
> Signed-off-by: IotaHydrae <writeforever@foxmail.com>

Compared against the manual, looks correct:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

P.S. I used to opportunity to check all other functions as well, apart
from one error in the comments they were correct. Will send a patch.

> ---
>  drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c b/drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
> index 2801ca706273..68a5b627fb9b 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
> @@ -204,7 +204,7 @@ static const struct sunxi_desc_pin suniv_f1c100s_pins[] = {
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
>  		  SUNXI_FUNCTION(0x2, "lcd"),		/* D20 */
> -		  SUNXI_FUNCTION(0x3, "lvds1"),		/* RX */
> +		  SUNXI_FUNCTION(0x3, "uart2"),		/* RX */
>  		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 14)),
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 15),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),

