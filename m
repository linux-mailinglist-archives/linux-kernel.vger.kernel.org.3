Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA06E4D5DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240095AbiCKIqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiCKIqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:46:01 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B118B1BA902;
        Fri, 11 Mar 2022 00:44:58 -0800 (PST)
Received: from [192.168.1.111] (91-156-85-209.elisa-laajakaista.fi [91.156.85.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 58E5D488;
        Fri, 11 Mar 2022 09:44:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1646988296;
        bh=KgOKt2nWZu2AcU+7tnzzHwEa8LX7GDuJltucb9VdrQY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kda77LiVqWEGyPlTPFHynCYpX00jg8J58P6Cq24u4kK8kbz+78K81RNp01KgX9TP+
         UyzfHke337r48ynzKle2oU/ugM+jo4awVYMp6ATZ+9tj0w5GaUdpl0ANtCgMzwXhRv
         zs6Q2dFUwe2Yb/176LLov8WxhfGpP6+Ccmt2Ljx0=
Message-ID: <00538a2f-fcbf-321a-1ce0-645913836e73@ideasonboard.com>
Date:   Fri, 11 Mar 2022 10:44:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-j721e-common-proc-board: add DP to
 j7 evm
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, nm@ti.com
Cc:     vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com
References: <20220222163230.1566-1-r-ravikumar@ti.com>
 <20220222163230.1566-3-r-ravikumar@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20220222163230.1566-3-r-ravikumar@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2022 18:32, Rahul T R wrote:
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> Add the endpoint nodes to describe connection from
> DSS => MHDP => DisplayPort connector.
> Also add the required pinmux nodes for hotplug.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
>   .../dts/ti/k3-j721e-common-proc-board.dts     | 66 +++++++++++++++++--
>   1 file changed, 62 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> index 2d7596911b27..fe20c193f299 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> @@ -148,6 +148,28 @@
>   		pinctrl-0 = <&main_mcan2_gpio_pins_default>;
>   		standby-gpios = <&main_gpio0 127 GPIO_ACTIVE_HIGH>;
>   	};
> +
> +	dp_pwr_3v3: fixedregulator-dp-prw {
> +		compatible = "regulator-fixed";
> +		regulator-name = "dp-pwr";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&exp4 0 0>;	/* P0 - DP0_PWR_SW_EN */
> +		enable-active-high;
> +	};
> +
> +	dp0: connector {
> +		compatible = "dp-connector";
> +		label = "DP0";
> +		type = "full-size";
> +		dp-pwr-supply = <&dp_pwr_3v3>;
> +
> +		port {
> +			dp_connector_in: endpoint {
> +				remote-endpoint = <&dp0_out>;
> +			};
> +		};
> +	};
>   };
>   
>   &main_pmx0 {
> @@ -190,6 +212,12 @@
>   		>;
>   	};
>   
> +	dp0_pins_default: dp0-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x1c4, PIN_INPUT, 5) /* SPI0_CS1.DP0_HPD */
> +		>;
> +	};
> +
>   	main_i2c1_exp4_pins_default: main-i2c1-exp4-pins-default {
>   		pinctrl-single,pins = <
>   			J721E_IOPAD(0x230, PIN_INPUT, 7) /* (U2) ECAP0_IN_APWM_OUT.GPIO1_11 */
> @@ -660,6 +688,40 @@
>   				 <&k3_clks 152 18>;	/* PLL23_HSDIV0 */
>   };
>   
> +&dss_ports {
> +	port@0 {
> +		reg = <0>;
> +
> +		dpi0_out: endpoint {
> +			remote-endpoint = <&dp0_in>;
> +		};
> +	};
> +};
> +
> +&mhdp {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&dp0_pins_default>;
> +};
> +
> +&dp0_ports {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	port@0 {
> +		reg = <0>;
> +		dp0_in: endpoint {
> +			remote-endpoint = <&dpi0_out>;
> +		};
> +	};
> +
> +	port@4 {
> +		reg = <4>;
> +		dp0_out: endpoint {
> +			remote-endpoint = <&dp_connector_in>;
> +		};
> +	};
> +};
> +
>   &mcasp0 {
>   	status = "disabled";
>   };
> @@ -845,10 +907,6 @@
>   	status = "disabled";
>   };
>   
> -&dss {
> -	status = "disabled";
> -};
> -
>   &icssg0_mdio {
>   	status = "disabled";
>   };

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi
