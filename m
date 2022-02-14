Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D424B5DF1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 23:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiBNWx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 17:53:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiBNWx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 17:53:28 -0500
Received: from hs01.dk-develop.de (hs01.dk-develop.de [IPv6:2a02:c207:3002:6234::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C1A1738DA;
        Mon, 14 Feb 2022 14:53:18 -0800 (PST)
Date:   Mon, 14 Feb 2022 23:53:15 +0100
From:   Danilo Krummrich <danilokrummrich@dk-develop.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH 1/2] dt-bindings: ps2-gpio: convert binding to json-schema
Message-ID: <YgrdWymrC6fRgQZ/@pollux>
References: <20220211233137.99624-1-danilokrummrich@dk-develop.de>
 <20220211233137.99624-2-danilokrummrich@dk-develop.de>
 <cf4e21e8-1ba8-a137-6063-00e1cee8e035@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf4e21e8-1ba8-a137-6063-00e1cee8e035@canonical.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 10:49:27PM +0100, Krzysztof Kozlowski wrote:
> On 12/02/2022 00:31, Danilo Krummrich wrote:
> > Convert the ps2-gpio dt-binding documentation to DT schema format using
> > the json-schema.
> > 
> > Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
> > ---
> >  .../devicetree/bindings/serio/ps2-gpio.txt    | 23 --------
> >  .../devicetree/bindings/serio/ps2-gpio.yaml   | 52 +++++++++++++++++++
> >  2 files changed, 52 insertions(+), 23 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.txt
> >  create mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/serio/ps2-gpio.txt b/Documentation/devicetree/bindings/serio/ps2-gpio.txt
> > deleted file mode 100644
> > index 7b7bc9cdf986..000000000000
> > --- a/Documentation/devicetree/bindings/serio/ps2-gpio.txt
> > +++ /dev/null
> > @@ -1,23 +0,0 @@
> > -Device-Tree binding for ps/2 gpio device
> > -
> > -Required properties:
> > -	- compatible = "ps2-gpio"
> > -	- data-gpios: the data pin
> > -	- clk-gpios: the clock pin
> > -	- interrupts: Should trigger on the falling edge of the clock line.
> > -
> > -Optional properties:
> > -	- write-enable: Indicates whether write function is provided
> > -	to serio device. Possibly providing the write fn will not work, because
> > -	of the tough timing requirements.
> > -
> > -Example nodes:
> > -
> > -ps2@0 {
> > -	compatible = "ps2-gpio";
> > -	interrupt-parent = <&gpio>;
> > -	interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
> > -	data-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
> > -	clk-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
> > -	write-enable;
> > -};
> > diff --git a/Documentation/devicetree/bindings/serio/ps2-gpio.yaml b/Documentation/devicetree/bindings/serio/ps2-gpio.yaml
> > new file mode 100644
> > index 000000000000..ec6fa7b40851
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serio/ps2-gpio.yaml
> > @@ -0,0 +1,52 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/serio/ps2-gpio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Bindings for GPIO based PS/2
> > +
> > +maintainers:
> > +  - Danilo Krummrich <danilokrummrich@dk-develop.de>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> 
> Hi,
> 
> I think you do not expect more compatibles, so skip "items".
> 
> > +      - const: ps2-gpio
> > +
> > +  data-gpios:
> > +    description:
> > +      the gpio used for the data signal
> > +    maxItems: 1
> > +
> > +  clk-gpios:
> > +    description:
> > +      the gpio used for the clock signal
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description:
> > +      The given interrupt should trigger on the falling edge of the clock line.
> > +    maxItems: 1
> > +
> > +  write-enable:
> 
> This does not look like a standard property. You need "type: boolean".
> 
> > +    description:
> > +      Indicates whether write function is provided to serio device. Possibly
> > +      providing the write function will not work, because of the tough timing
> > +      requirements.
> > +
> > +required:
> 
> Also: compatible
> 
> > +  - data-gpios
> > +  - clk-gpios
> > +  - interrupts
> > +
> > +examples:
> > +  - |
> > +    ps2@0 {
> 
> Does it compile cleanly? You used an unit-address but there is no reg.
Yes, it does. I will fix those up and send a v2.
> 
> > +        compatible = "ps2-gpio";
> > +        interrupt-parent = <&gpio>;
> > +        interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
> > +        data-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
> > +        clk-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
> > +        write-enable;
> > +    };
> 
> 
> Best regards,
> Krzysztof

- Danilo
