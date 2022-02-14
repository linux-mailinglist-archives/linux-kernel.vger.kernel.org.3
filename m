Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273134B4F93
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352150AbiBNMCq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 07:02:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiBNMCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:02:44 -0500
X-Greylist: delayed 97 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 04:02:36 PST
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C31D41;
        Mon, 14 Feb 2022 04:02:36 -0800 (PST)
Date:   Mon, 14 Feb 2022 12:02:26 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/2] pwm: jz4740: Add support for X1000 SoC
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     robh+dt@kernel.org, linux-mips@vger.kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <2SMA7R.9OBQWV0ONR102@crapouillou.net>
In-Reply-To: <20220209231141.20184-2-aidanmacdonald.0x0@gmail.com>
References: <20220209231141.20184-1-aidanmacdonald.0x0@gmail.com>
        <20220209231141.20184-2-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

Le mer., févr. 9 2022 at 23:11:42 +0000, Aidan MacDonald 
<aidanmacdonald.0x0@gmail.com> a écrit :
> The X1000 has the same TCU / PWM hardware as other Ingenic SoCs,
> but it has only 5 channels.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  arch/mips/boot/dts/ingenic/x1000.dtsi | 13 +++++++++++++
>  drivers/pwm/pwm-jz4740.c              |  5 +++++

Please put the driver and device tree changes into separate patches.

Cheers,
-Paul

>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi 
> b/arch/mips/boot/dts/ingenic/x1000.dtsi
> index 8bd27edef216..0dcf37527c8e 100644
> --- a/arch/mips/boot/dts/ingenic/x1000.dtsi
> +++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
> @@ -127,6 +127,19 @@ wdt: watchdog@0 {
>  			clocks = <&tcu TCU_CLK_WDT>;
>  			clock-names = "wdt";
>  		};
> +
> +		pwm: pwm@40 {
> +			compatible = "ingenic,x1000-pwm";
> +			reg = <0x40 0x80>;
> +
> +			#pwm-cells = <3>;
> +
> +			clocks = <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER1>,
> +				 <&tcu TCU_CLK_TIMER2>, <&tcu TCU_CLK_TIMER3>,
> +				 <&tcu TCU_CLK_TIMER4>;
> +			clock-names = "timer0", "timer1", "timer2",
> +				      "timer3", "timer4";
> +		};
>  	};
> 
>  	rtc: rtc@10003000 {
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index 23dc1fb770e2..a5fdf97c0d2e 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -256,10 +256,15 @@ static const struct soc_info __maybe_unused 
> jz4725b_soc_info = {
>  	.num_pwms = 6,
>  };
> 
> +static const struct soc_info __maybe_unused x1000_soc_info = {
> +	.num_pwms = 5,
> +};
> +
>  #ifdef CONFIG_OF
>  static const struct of_device_id jz4740_pwm_dt_ids[] = {
>  	{ .compatible = "ingenic,jz4740-pwm", .data = &jz4740_soc_info },
>  	{ .compatible = "ingenic,jz4725b-pwm", .data = &jz4725b_soc_info },
> +	{ .compatible = "ingenic,x1000-pwm", .data = &x1000_soc_info },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, jz4740_pwm_dt_ids);
> --
> 2.34.1
> 


