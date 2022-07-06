Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A541A5688A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiGFMsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbiGFMsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:48:46 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D23913D02;
        Wed,  6 Jul 2022 05:48:44 -0700 (PDT)
Received: from [192.168.1.101] (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 31B7A3F4EA;
        Wed,  6 Jul 2022 14:48:43 +0200 (CEST)
Message-ID: <c68df556-60aa-59f9-34d4-c381357ddb8c@somainline.org>
Date:   Wed, 6 Jul 2022 14:48:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 02/13] ARM: dts: qcom: add gsbi6 missing definition for
 ipq8064
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
 <20220705133917.8405-3-ansuelsmth@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220705133917.8405-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.07.2022 15:39, Christian Marangi wrote:
> Add gsbi6 missing definition for ipq8064.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Tested-by: Jonathan McDowell <noodles@earth.li>
> ---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 40 +++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index f06a17bd915a..1b4b72723ead 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -665,6 +665,46 @@ spi@1a280000 {
>  			};
>  		};
>  
> +		gsbi6: gsbi@16500000 {
> +			status = "disabled"
Please make the compatible first, reg 2nd and move status to the bottom.

Konrad
> +			compatible = "qcom,gsbi-v1.0.0";
> +			cell-index = <6>;
> +			reg = <0x16500000 0x100>;
> +			clocks = <&gcc GSBI6_H_CLK>;
> +			clock-names = "iface";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			syscon-tcsr = <&tcsr>;
> +
> +			gsbi6_i2c: i2c@16580000 {
> +				compatible = "qcom,i2c-qup-v1.1.1";
> +				reg = <0x16580000 0x1000>;
> +				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
> +
> +				clocks = <&gcc GSBI6_QUP_CLK>, <&gcc GSBI6_H_CLK>;
> +				clock-names = "core", "iface";
> +				status = "disabled";
> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +
> +			gsbi6_spi: spi@16580000 {
> +				compatible = "qcom,spi-qup-v1.1.1";
> +				reg = <0x16580000 0x1000>;
> +				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
> +
> +				clocks = <&gcc GSBI6_QUP_CLK>, <&gcc GSBI6_H_CLK>;
> +				clock-names = "core", "iface";
> +				status = "disabled";
> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
>  		gsbi7: gsbi@16600000 {
>  			status = "disabled";
>  			compatible = "qcom,gsbi-v1.0.0";
