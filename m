Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F225B0F1D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiIGV16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiIGV1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:27:55 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9577B8F13;
        Wed,  7 Sep 2022 14:27:52 -0700 (PDT)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 2EB531F9DF;
        Wed,  7 Sep 2022 23:27:49 +0200 (CEST)
Date:   Wed, 7 Sep 2022 23:27:47 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: Add PM6125 PMIC
Message-ID: <20220907212747.i2y6qi75avhavyr4@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20220805135729.1037079-1-marijn.suijten@somainline.org>
 <20220805135729.1037079-4-marijn.suijten@somainline.org>
 <4cef00b4-c184-ae78-3709-5ed520ca3375@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cef00b4-c184-ae78-3709-5ed520ca3375@linaro.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-08 12:17:06, Krzysztof Kozlowski wrote:
> On 05/08/2022 16:57, Marijn Suijten wrote:
> > This PMIC is commonly used on boards with an SM6125 SoC and looks very
> > similar in layout to the PM6150.
> > 
> > Downstream declares more nodes to be available, but these have been
> > omitted from this patch: the pwm/lpg block is unused on my reference
> > device making it impossible to test/validate, and the spmi-clkdiv does
> > not have a single device-tree binding using this driver yet, hence
> > inclusion is better postponed until ie. audio which uses these clocks is
> > brought up.
> > 
> 
> Thank you for your patch. There is something to discuss/improve.

I can respin the series with the suggested changes (and the iio patch
removed as that has now been applied), but note that all other PMIC dtsi
files as of -next today still carry the "wrong" adc-tm or gpios node
names.  Are there plans to patch those up too (if not already in a
series that I missed)?

- Marijn

> > +
> > +			xo-therm@4c {
> > +				reg = <ADC5_XO_THERM_100K_PU>;
> > +				qcom,pre-scaling = <1 1>;
> > +				qcom,hw-settle-time = <200>;
> > +				qcom,ratiometric;
> > +			};
> > +		};
> > +
> > +		pm6125_adc_tm: adc-tm@3500 {
> 
> Generic node names, so either this is adc or thermal-sensor. Looks like
> thermal-sensor.
> 
> > +			compatible = "qcom,spmi-adc-tm5";
> > +			reg = <0x3500>;
> > +			interrupts = <0x0 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			#thermal-sensor-cells = <1>;
> > +			status = "disabled";
> > +		};
> > +
> > +		pm6125_rtc: rtc@6000 {
> > +			compatible = "qcom,pm8941-rtc";
> > +			reg = <0x6000>, <0x6100>;
> > +			reg-names = "rtc", "alarm";
> > +			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
> > +			status = "disabled";
> > +		};
> > +
> > +		pm6125_gpio: gpios@c000 {
> 
> s/gpios/gpio/
> 
> > +			compatible = "qcom,pm6125-gpio", "qcom,spmi-gpio";
> > +			reg = <0xc000>;
> > +			gpio-controller;
> > +			gpio-ranges = <&pm6125_gpio 0 0 9>;
> > +			#gpio-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +		};
> > +	};
> > +
> > +	pmic@1 {
> > +		compatible = "qcom,pm6125", "qcom,spmi-pmic";
> > +		reg = <0x1 SPMI_USID>;
> > +	};
> > +};
> 
> 
> Best regards,
> Krzysztof
