Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCAA5A2EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345004AbiHZSol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345143AbiHZSoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:44:21 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62767EF9EA;
        Fri, 26 Aug 2022 11:41:18 -0700 (PDT)
Received: from [192.168.1.101] (afbd60.neoplus.adsl.tpnet.pl [95.49.29.60])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 6FA513F760;
        Fri, 26 Aug 2022 20:40:48 +0200 (CEST)
Message-ID: <9c2a2d4a-8b68-d1b3-92fa-ec2b1c7bb28e@somainline.org>
Date:   Fri, 26 Aug 2022 20:40:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 4/7] arm64: dts: qcom: sc8280xp-thinkpad-x13s: Specify
 which LDO modes are allowed
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220825164205.4060647-1-dianders@chromium.org>
 <20220825094155.4.I897770a7ac41f8dc3e37dfed12102bacdbf9da56@changeid>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220825094155.4.I897770a7ac41f8dc3e37dfed12102bacdbf9da56@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.08.2022 18:42, Douglas Anderson wrote:
> This board uses RPMH, specifies "regulator-allow-set-load" for LDOs,
> but doesn't specify any modes with "regulator-allowed-modes".
> 
> Prior to commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> get_optimum_mode(), not set_load()") the above meant that we were able
> to set either LPM or HPM mode. After that commit (and fixes [1]) we'll
> be stuck at the initial mode. Discussion of this has resulted in the
> decision that the old dts files were wrong and should be fixed to
> fully restore old functionality.
> 
> Let's re-enable the old functionality by fixing the dts.
> 
> [1] https://lore.kernel.org/r/20220824142229.RFT.v2.2.I6f77860e5cd98bf5c67208fa9edda4a08847c304@changeid
> 
> Fixes: 32c231385ed4 ("arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad

> 
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 16c6e4d920bb..0c2534b4ec24 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -80,6 +80,9 @@ vreg_l3b: ldo3 {
>  			regulator-max-microvolt = <1200000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  			regulator-boot-on;
>  		};
>  
> @@ -89,6 +92,9 @@ vreg_l4b: ldo4 {
>  			regulator-max-microvolt = <912000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l6b: ldo6 {
> @@ -97,6 +103,9 @@ vreg_l6b: ldo6 {
>  			regulator-max-microvolt = <880000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  			regulator-boot-on;
>  			regulator-always-on;	// FIXME: VDD_A_EDP_0_0P9
>  		};
> @@ -112,6 +121,9 @@ vreg_l1c: ldo1 {
>  			regulator-max-microvolt = <1800000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l12c: ldo12 {
> @@ -120,6 +132,9 @@ vreg_l12c: ldo12 {
>  			regulator-max-microvolt = <1800000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l13c: ldo13 {
> @@ -128,6 +143,9 @@ vreg_l13c: ldo13 {
>  			regulator-max-microvolt = <3072000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  		};
>  	};
>  
> @@ -143,6 +161,9 @@ vreg_l3d: ldo3 {
>  			regulator-max-microvolt = <1200000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l4d: ldo4 {
> @@ -151,6 +172,9 @@ vreg_l4d: ldo4 {
>  			regulator-max-microvolt = <1200000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l7d: ldo7 {
> @@ -159,6 +183,9 @@ vreg_l7d: ldo7 {
>  			regulator-max-microvolt = <3072000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l9d: ldo9 {
> @@ -167,6 +194,9 @@ vreg_l9d: ldo9 {
>  			regulator-max-microvolt = <912000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;
>  		};
>  	};
>  };
