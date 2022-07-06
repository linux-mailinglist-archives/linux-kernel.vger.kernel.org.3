Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5C65688A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiGFMsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiGFMsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:48:11 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E1A1EC57
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:48:10 -0700 (PDT)
Received: from [192.168.1.101] (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id DC17A3F1E7;
        Wed,  6 Jul 2022 14:48:08 +0200 (CEST)
Message-ID: <3a9ee5ba-d89e-0e13-2053-8daf46306b71@somainline.org>
Date:   Wed, 6 Jul 2022 14:48:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/13] ARM: dts: qcom: add multiple missing pin definition
 for ipq8064
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan McDowell <noodles@earth.li>
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-2-ansuelsmth@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220705133917.8405-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.07.2022 15:39, Christian Marangi wrote:
> Add missing definition for mdio0 pins used for gpio-bitbang driver,i2c4
> pins and rgmii2 pins for ipq8064.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Tested-by: Jonathan McDowell <noodles@earth.li>
> ---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 34 +++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index 4b475d98343c..f06a17bd915a 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -382,6 +382,15 @@ mux {
>  				};
>  			};
>  
Hi,
> +			i2c4_pins: i2c4_pinmux {
No underscores in node names (use them only in labels), please.

Also, please rename this to something like i2c4-default, for
example to make it clear which power state it represents (I 
suppose i2c4-sleep is going to appear sometime in the as well).


> +				mux {

Please drop the unnecessary mux{} level.

Konrad
> +					pins = "gpio12", "gpio13";
> +					function = "gsbi4";
> +					drive-strength = <12>;
> +					bias-disable;
> +				};
> +			};
> +
>  			spi_pins: spi_pins {
>  				mux {
>  					pins = "gpio18", "gpio19", "gpio21";
> @@ -424,6 +433,8 @@ mux {
>  
>  				pullups {
>  					pins = "gpio39";
> +					function = "nand";
> +					drive-strength = <10>;
>  					bias-pull-up;
>  				};
>  
> @@ -431,9 +442,32 @@ hold {
>  					pins = "gpio40", "gpio41", "gpio42",
>  					       "gpio43", "gpio44", "gpio45",
>  					       "gpio46", "gpio47";
> +					function = "nand";
> +					drive-strength = <10>;
>  					bias-bus-hold;
>  				};
>  			};
> +
> +			mdio0_pins: mdio0_pins {
> +				mux {
> +					pins = "gpio0", "gpio1";
> +					function = "mdio";
> +					drive-strength = <8>;
> +					bias-disable;
> +				};
> +			};
> +
> +			rgmii2_pins: rgmii2_pins {
> +				mux {
> +					pins = "gpio27", "gpio28", "gpio29",
> +					       "gpio30", "gpio31", "gpio32",
> +					       "gpio51", "gpio52", "gpio59",
> +					       "gpio60", "gpio61", "gpio62";
> +					function = "rgmii2";
> +					drive-strength = <8>;
> +					bias-disable;
> +				};
> +			};
>  		};
>  
>  		intc: interrupt-controller@2000000 {
