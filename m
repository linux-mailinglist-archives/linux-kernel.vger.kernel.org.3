Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8CA4E1B45
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 12:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244541AbiCTLJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 07:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbiCTLJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 07:09:42 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196AF4A930;
        Sun, 20 Mar 2022 04:08:18 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 03F5D22239;
        Sun, 20 Mar 2022 12:08:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647774495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n0pfP6YKouY5Uefqu8cIS2X4j5IhOaOxj4s6Fptz1KE=;
        b=ikmlrbf48d3sLQYHflGABZMVqJCgRbDhBAdPcDvKME+tgtk1GnxESGtTKAnLfaXGJlSCzG
        0K2jqhwUFqsxQLchMNmEm01v36xWFb3yodyhVuG3zRldZfafzxRgvPY68iwKZUvJ1VV/ar
        UzNoaYogXCZwFyUqx3K9HUC5k+4RHT0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 20 Mar 2022 12:08:14 +0100
From:   Michael Walle <michael@walle.cc>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        UNGLinuxDriver@microchip.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v3 6/6] dt-bindings: pinctrl: convert ocelot-pinctrl to
 YAML format
In-Reply-To: <89f9b797-e4b8-139a-d9e6-ebe71779b943@kernel.org>
References: <20220319204628.1759635-1-michael@walle.cc>
 <20220319204628.1759635-7-michael@walle.cc>
 <89f9b797-e4b8-139a-d9e6-ebe71779b943@kernel.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <3949a4c3271473b73851b0970bdb58b8@walle.cc>
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

Am 2022-03-20 11:54, schrieb Krzysztof Kozlowski:
> On 19/03/2022 21:46, Michael Walle wrote:
>> Convert the ocelot-pinctrl device tree binding to the new YAML format.
>> 
>> Additionally to the original binding documentation, add interrupt
>> properties which are optional and already used on several SoCs like
>> SparX-5, Luton, Ocelot and LAN966x but were not documented before.
>> 
>> Also, on the sparx5 and the lan966x SoCs there are two items for the
>> reg property.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  .../bindings/pinctrl/mscc,ocelot-pinctrl.txt  |  42 -------
>>  .../bindings/pinctrl/mscc,ocelot-pinctrl.yaml | 108 
>> ++++++++++++++++++
>>  2 files changed, 108 insertions(+), 42 deletions(-)
>>  delete mode 100644 
>> Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
>>  create mode 100644 
>> Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt 
>> b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
>> deleted file mode 100644
>> index 5d84fd299ccf..000000000000
>> --- 
>> a/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
>> +++ /dev/null
>> @@ -1,42 +0,0 @@
>> -Microsemi Ocelot pin controller Device Tree Bindings
>> -----------------------------------------------------
>> -
>> -Required properties:
>> - - compatible		: Should be "mscc,ocelot-pinctrl",
>> -			  "mscc,jaguar2-pinctrl", "microchip,sparx5-pinctrl",
>> -			  "mscc,luton-pinctrl", "mscc,serval-pinctrl",
>> -			  "microchip,lan966x-pinctrl" or "mscc,servalt-pinctrl"
>> - - reg			: Address and length of the register set for the device
>> - - gpio-controller	: Indicates this device is a GPIO controller
>> - - #gpio-cells		: Must be 2.
>> -			  The first cell is the pin number and the
>> -			  second cell specifies GPIO flags, as defined in
>> -			  <dt-bindings/gpio/gpio.h>.
>> - - gpio-ranges		: Range of pins managed by the GPIO controller.
>> -
>> -
>> -The ocelot-pinctrl driver uses the generic pin multiplexing and 
>> generic pin
>> -configuration documented in pinctrl-bindings.txt.
>> -
>> -The following generic properties are supported:
>> - - function
>> - - pins
>> -
>> -Example:
>> -	gpio: pinctrl@71070034 {
>> -		compatible = "mscc,ocelot-pinctrl";
>> -		reg = <0x71070034 0x28>;
>> -		gpio-controller;
>> -		#gpio-cells = <2>;
>> -		gpio-ranges = <&gpio 0 0 22>;
>> -
>> -		uart_pins: uart-pins {
>> -				pins = "GPIO_6", "GPIO_7";
>> -				function = "uart";
>> -		};
>> -
>> -		uart2_pins: uart2-pins {
>> -				pins = "GPIO_12", "GPIO_13";
>> -				function = "uart2";
>> -		};
>> -	};
>> diff --git 
>> a/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml 
>> b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
>> new file mode 100644
>> index 000000000000..7149a6655623
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
>> @@ -0,0 +1,108 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pinctrl/mscc,ocelot-pinctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Microsemi Ocelot pin controller
>> +
>> +maintainers:
>> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
>> +  - Lars Povlsen <lars.povlsen@microchip.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - microchip,lan966x-pinctrl
>> +      - microchip,sparx5-pinctrl
>> +      - mscc,jaguar2-pinctrl
>> +      - mscc,luton-pinctrl
>> +      - mscc,ocelot-pinctrl
>> +      - mscc,serval-pinctrl
>> +      - mscc,servalt-pinctrl
>> +
>> +  reg:
>> +    items:
>> +      - description: Base address
>> +      - description: Extended pin configuration registers
>> +    minItems: 1
>> +
>> +  gpio-controller: true
>> +
>> +  '#gpio-cells':
>> +    const: 2
>> +
>> +  gpio-ranges: true
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  interrupt-controller: true
>> +
>> +  "#interrupt-cells":
>> +    const: 2
> 
> Thanks for the changes in other files, but I think you did not respond
> to my comments here. Can you address them?

Sorry, I might missunderstood you. They are currently used on all except
on serval and servalt SoCs like described in the updated commit message.
I thought it was clear from the commit message, so I didn't answer your
questions in v2. Or is there something else?

-michael
