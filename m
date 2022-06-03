Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3011053C976
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 13:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244082AbiFCLef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 07:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244074AbiFCLed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:34:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282C91D302
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 04:34:32 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nx5ZS-00059D-8m; Fri, 03 Jun 2022 13:34:26 +0200
Message-ID: <213e966d-ac69-b5be-52ad-4ab9f616565e@pengutronix.de>
Date:   Fri, 3 Jun 2022 13:34:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM: dts: stm32: correct vcc-supply for eeprom on
 stm32mp15xx-osd32
To:     =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20220603094422.2112746-1-l.goehrs@pengutronix.de>
 <20220603094422.2112746-2-l.goehrs@pengutronix.de>
Content-Language: en-US
In-Reply-To: <20220603094422.2112746-2-l.goehrs@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.06.22 11:44, Leonard Göhrs wrote:
> According to the OSD32MP1 Power System overview[1] the EEPROM is connected to
> the VDD line and not to some single-purpose fixed regulator.
> Set the EEPROM supply according to the diagram to eliminate this parent-less
> regulator.
> 
> [1]: https://octavosystems.com/app_notes/osd32mp1-power-system-overview/#connections
> 
> Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>

Acked-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Thanks,
Ahmad

> ---
>  arch/arm/boot/dts/stm32mp15xx-osd32.dtsi | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi b/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
> index e997c4953fd1..935b7084b5a2 100644
> --- a/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15xx-osd32.dtsi
> @@ -50,12 +50,6 @@ retram: retram@38000000 {
>  			no-map;
>  		};
>  	};
> -
> -	reg_sip_eeprom: regulator_eeprom {
> -		compatible = "regulator-fixed";
> -		regulator-name = "sip_eeprom";
> -		regulator-always-on;
> -	};
>  };
>  
>  &i2c4 {
> @@ -204,7 +198,7 @@ pmic_watchdog: watchdog {
>  
>  	sip_eeprom: eeprom@50 {
>  		compatible = "atmel,24c32";
> -		vcc-supply = <&reg_sip_eeprom>;
> +		vcc-supply = <&vdd>;
>  		reg = <0x50>;
>  	};
>  };


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
