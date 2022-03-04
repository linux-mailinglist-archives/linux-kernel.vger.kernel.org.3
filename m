Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0524CD333
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239247AbiCDLQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235970AbiCDLQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:16:12 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AA21B0BC5;
        Fri,  4 Mar 2022 03:15:23 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 792F622175;
        Fri,  4 Mar 2022 12:15:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1646392521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lm7m072d8v8Dzfgsy93FLf7sDvnn63P9eUXC4Q6AMDU=;
        b=mYkOpi6cDhwSgu99agkQZmaGJHGRqn9esPKOl4dD52+um9BRg2dp+l+MOCXPqnkOHKhWPB
        12wlrfCqxuxxI+PmnkCsAcuzOgI37MduyVDQm0AwQ1AOjc6/blF6NKVREoNS4hAxKAgXO7
        A61aWNGDHZgx3XXbLAMgNVgyou3k3Vg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 04 Mar 2022 12:15:21 +0100
From:   Michael Walle <michael@walle.cc>
To:     Claudiu.Beznea@microchip.com
Cc:     Kavyasree.Kotagiri@microchip.com, Nicolas.Ferre@microchip.com,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, alexandre.belloni@bootlin.com
Subject: Re: [PATCH v1 6/6] ARM: dts: lan966x: add basic Kontron KSwitch D10
 support
In-Reply-To: <b4aca5f1-38c0-8197-6914-0a39b7755180@microchip.com>
References: <20220303160323.3316317-1-michael@walle.cc>
 <20220303160323.3316317-7-michael@walle.cc>
 <b4aca5f1-38c0-8197-6914-0a39b7755180@microchip.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <900be5239b96cd77493fbcfbe220989f@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-03-04 09:31, schrieb Claudiu.Beznea@microchip.com:
> On 03.03.2022 18:03, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Add basic support for the Kontron KSwitch D10 MMT 6G-2GS which
>> features 6 Gigabit copper ports and two SFP cages. For now the
>> following is working:
>>  - Kernel console
>>  - SFP cages I2C bus and mux
>>  - SPI
>>  - SGPIO
>>  - Watchdog
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  arch/arm/boot/dts/Makefile                    |   3 +-
>>  ...lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts | 159 
>> ++++++++++++++++++
>>  2 files changed, 161 insertions(+), 1 deletion(-)
>>  create mode 100644 
>> arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
>> 
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 085c43649d44..86dd0f9804ee 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -739,7 +739,8 @@ dtb-$(CONFIG_SOC_IMX7ULP) += \
>>         imx7ulp-com.dtb \
>>         imx7ulp-evk.dtb
>>  dtb-$(CONFIG_SOC_LAN966) += \
>> -       lan966x-pcb8291.dtb
>> +       lan966x-pcb8291.dtb \
>> +       lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
>>  dtb-$(CONFIG_SOC_LS1021A) += \
>>         ls1021a-moxa-uc-8410a.dtb \
>>         ls1021a-qds.dtb \
>> diff --git 
>> a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts 
>> b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
>> new file mode 100644
>> index 000000000000..958678dec7ad
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
>> @@ -0,0 +1,159 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Device Tree file for the Kontron KSwitch D10 MMT 6G-2GS
>> + */
>> +
>> +/dts-v1/;
>> +#include "lan966x.dtsi"
>> +
>> +/ {
>> +       model = "Kontron KSwitch D10 MMT 6G-2GS";
>> +       compatible = "kontron,kswitch-d10-mmt-6g-2gs", 
>> "kontron,s1921",
>> +                    "microchip,lan9668", "microchip,lan966";
>> +
>> +       aliases {
>> +               serial0 = &usart0;
>> +       };
>> +
>> +       chosen {
>> +               stdout-path = "serial0:115200n8";
>> +       };
>> +
>> +       gpio-restart {
>> +               compatible = "gpio-restart";
>> +               gpios = <&gpio 56 GPIO_ACTIVE_LOW>;
>> +               priority = <200>;
>> +       };
>> +
>> +       i2cmux {
>> +               compatible = "i2c-mux-gpio";
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               mux-gpios = <&sgpio_out 3 2 GPIO_ACTIVE_HIGH>,
>> +                           <&sgpio_out 3 3 GPIO_ACTIVE_HIGH>;
>> +               i2c-parent = <&i2c4>;
>> +
>> +               i2c4_0: i2c@1 {
>> +                       reg = <1>;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +               };
>> +
>> +               i2c4_1: i2c@2 {
>> +                       reg = <2>;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +               };
>> +       };
>> +
>> +       sfp0: sfp0 {
>> +               compatible = "sff,sfp";
>> +               i2c-bus = <&i2c4_0>;
>> +               los-gpios = <&sgpio_in 1 0 GPIO_ACTIVE_HIGH>;
>> +               mod-def0-gpios = <&sgpio_in 1 1 GPIO_ACTIVE_LOW>;
>> +               maximum-power-milliwatt = <2500>;
>> +               tx-disable-gpios = <&sgpio_out 3 0 GPIO_ACTIVE_LOW>;
>> +               tx-fault-gpios = <&sgpio_in 0 2 GPIO_ACTIVE_HIGH>;
>> +               rate-select0-gpios = <&sgpio_out 2 0 
>> GPIO_ACTIVE_HIGH>;
>> +               rate-select1-gpios = <&sgpio_out 2 1 
>> GPIO_ACTIVE_HIGH>;
>> +       };
>> +
>> +       sfp1: sfp1 {
>> +               compatible = "sff,sfp";
>> +               i2c-bus = <&i2c4_1>;
>> +               los-gpios = <&sgpio_in 1 2 GPIO_ACTIVE_HIGH>;
>> +               mod-def0-gpios = <&sgpio_in 1 3 GPIO_ACTIVE_LOW>;
>> +               maximum-power-milliwatt = <2500>;
>> +               tx-disable-gpios = <&sgpio_out 3 1 GPIO_ACTIVE_LOW>;
>> +               tx-fault-gpios = <&sgpio_in 0 3 GPIO_ACTIVE_HIGH>;
>> +               rate-select0-gpios = <&sgpio_out 2 2 
>> GPIO_ACTIVE_HIGH>;
>> +               rate-select1-gpios = <&sgpio_out 2 3 
>> GPIO_ACTIVE_HIGH>;
>> +       };
>> +};
>> +
>> +&flx0 {
>> +       atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
>> +       status = "okay";
>> +};
>> +
>> +&flx3 {
>> +       atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_SPI>;
>> +       status = "okay";
>> +};
>> +
>> +&flx4 {
>> +       atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
>> +       status = "okay";
>> +};
> 
> Although there is 1:1 mapping b/w ids of flexcoms and the embedded 
> blocks
> (flxX has usartX, i2cX, spiX) and there is nothing wrong with the 
> approach
> here I found a bit hard to follow if the correspondent embedded block
> (i2c, spi, usart) is enabled or not.

I know and I had the same feeling, but I don't want to have the
subnodes (matched by name) in these nodes.  I.e. I want to avoid
something like:

&flx4 {
        atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
        status = "okay";

        i2c@600 {
               pinctrl-0 = <&fc4_b_pins>;
               pinctrl-names = "default";
               status = "okay";
        };
};

If someone renames the subnode in the dtsi, it might easily be
overlooked in the board files. Having the handle will raise an
error.

And because the node references should be sorted alphabetically
it will be cluttered around in the file. You could rename the
references to flx4_i2c though. But I don't know it its worth
the efforts. Let me know what you think.

-michael

> 
>> +
>> +&gpio {
>> +       usart0_pins: usart0-pins {
>> +               /* RXD, TXD */
>> +               pins = "GPIO_25", "GPIO_26";
>> +               function = "fc0_b";
>> +       };
>> +
>> +       sgpio_a_pins: sgpio-a-pins {
>> +               /* SCK, D0, D1, LD */
>> +               pins = "GPIO_32", "GPIO_33", "GPIO_34";
>> +               function = "sgpio_a";
>> +       };
>> +
>> +       sgpio_b_pins: sgpio-b-pins {
>> +               /* SCK, D0, D1, LD */
>> +               pins = "GPIO_64";
>> +               function = "sgpio_b";
>> +       };
>> +
>> +       fc3_b_pins: fc3-b-spi-pins {
>> +               /* SCK, MISO, MOSI */
>> +               pins = "GPIO_51", "GPIO_52", "GPIO_53";
>> +               function = "fc3_b";
>> +       };
>> +
>> +       fc4_b_pins: fc4-b-i2c-pins {
>> +               /* RXD, TXD */
>> +               pins = "GPIO_57", "GPIO_58";
>> +               function = "fc4_b";
>> +       };
>> +};
>> +
>> +&i2c4 {
>> +       pinctrl-0 = <&fc4_b_pins>;
>> +       pinctrl-names = "default";
>> +       status = "okay";
>> +};
>> +
>> +&usart0 {
>> +       pinctrl-0 = <&usart0_pins>;
>> +       pinctrl-names = "default";
>> +       status = "okay";
>> +};
>> +
>> +&sgpio {
>> +       pinctrl-0 = <&sgpio_a_pins>, <&sgpio_b_pins>;
>> +       pinctrl-names = "default";
>> +       bus-frequency = <8000000>;
>> +       /* arbitrary range because all GPIOs are in software mode */
>> +       microchip,sgpio-port-ranges = <0 11>;
>> +       status = "okay";
>> +};
>> +
>> +&sgpio_in {
>> +       ngpios = <128>;
>> +};
>> +
>> +&sgpio_out {
>> +       ngpios = <128>;
>> +};
>> +
>> +&spi3 {
>> +       pinctrl-0 = <&fc3_b_pins>;
>> +       pinctrl-names = "default";
>> +       cs-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
>> +       status = "okay";
>> +};
>> +
>> +&watchdog {
>> +       status = "okay";
>> +};
>> --
>> 2.30.2
>> 
