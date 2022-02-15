Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185A94B70B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239812AbiBOP12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:27:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239782AbiBOP1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:27:22 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4F2A27BF;
        Tue, 15 Feb 2022 07:27:11 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1826B200003;
        Tue, 15 Feb 2022 15:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644938826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5LJhd1IbwzyroPVu4UEQmQz5Ff3pKyv/BsY2bYsaH3I=;
        b=Z9NZ3Kdb+Pd+PCL+BHoMeoa+LzEM9XcY9wbHH1lxXtMGLOHNgBpMZy2dQ2zZNMtYExIpoL
        mW6Ma/o3+d+YO+MIBUZGiTrNyEX8swZYEJUJhVeJJF7K9yjDXdDLAxoC22L3u04cPa1qxF
        82/KiPuYNZl1fDBrxHWSzIAoXReoBvDOuOcRkHT5SaTn8V590wykA8Jg4V2LToDoOnzB5s
        Jh1vjPhAHu1AgDDjdMGO1fOiIgyLFfUlRXNeSScgWVWPMW3do9ZLA9rg6eHCxRYW+K2lNR
        QOfTL5N8I8daxu4kIXPwF5BttrFSt3OKohmc9VGbspIAwbicTKvy6QhFBKME/A==
Date:   Tue, 15 Feb 2022 16:27:05 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: convert at91sam9 bindings to
 json-schema
Message-ID: <YgvGSVs4v8IK/nwr@piout.net>
References: <20220215144649.14378-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215144649.14378-1-sergiu.moga@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 15/02/2022 16:46:49+0200, Sergiu Moga wrote:
> Convert RTC binding for Atmel/Microchip SoCs to Device Tree Schema
> format.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  .../bindings/rtc/atmel,at91sam9-rtc.txt       | 25 --------
>  .../bindings/rtc/atmel,at91sam9-rtc.yaml      | 61 +++++++++++++++++++
>  2 files changed, 61 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
> deleted file mode 100644
> index 3f0e2a5950eb..000000000000
> --- a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -Atmel AT91SAM9260 Real Time Timer
> -
> -Required properties:
> -- compatible: should be one of the following:
> -	- "atmel,at91sam9260-rtt"
> -	- "microchip,sam9x60-rtt", "atmel,at91sam9260-rtt"
> -- reg: should encode the memory region of the RTT controller
> -- interrupts: rtt alarm/event interrupt
> -- clocks: should contain the 32 KHz slow clk that will drive the RTT block.
> -- atmel,rtt-rtc-time-reg: should encode the GPBR register used to store
> -	the time base when the RTT is used as an RTC.
> -	The first cell should point to the GPBR node and the second one
> -	encode the offset within the GPBR block (or in other words, the
> -	GPBR register used to store the time base).
> -
> -
> -Example:
> -
> -rtt@fffffd20 {
> -	compatible = "atmel,at91sam9260-rtt";
> -	reg = <0xfffffd20 0x10>;
> -	interrupts = <1 4 7>;
> -	clocks = <&clk32k>;
> -	atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
> -};
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
> new file mode 100644
> index 000000000000..c78a8c1c9314
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/atmel,at91sam9-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel AT91 RTT Device Tree Bindings
> +
> +allOf:
> +  - $ref: "rtc.yaml#"
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - const: atmel,at91sam9260-rtt
> +      - items:
> +        - const: microchip,sam9x60-rtt
> +        - const: atmel,at91sam9260-rtt
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  atmel,rtt-rtc-time-reg:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      Should encode the GPBR register used to store the time base when the
> +      RTT is used as an RTC. The first cell should point to the GPBR node
> +      and the second one encodes the offset within the GPBR block (or in
> +      other words, the GPBR register used to store the time base).
> +    items:
> +      maxItems: 1
> +

This is missing start-year which is supported by the driver

> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - atmel,rtt-rtc-time-reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    rtt@fffffd20 {
> +        compatible = "atmel,at91sam9260-rtt";
> +        reg = <0xfffffd20 0x10>;
> +        interrupts = <1 4 7>;
> +        clocks = <&clk32k>;
> +        atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
> +    };
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
