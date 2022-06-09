Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274E35452D4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbiFIRTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239242AbiFIRTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:19:21 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCAEA88BA;
        Thu,  9 Jun 2022 10:19:19 -0700 (PDT)
Received: from g550jk.localnet (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id B3332CCDF9;
        Thu,  9 Jun 2022 17:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1654795156; bh=2MPN+doYZMUaXvC0iC9GlfoIDwZjXtdp86X30pYRS8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LkphQxXrMOnXuVuC1qZaoqrtpghwAWoxfgVdQoaVnDCtJTtTbZR5CvIYYMCA5O9QB
         BSPM6RIWIVfdnFljl/Pc4h16y8vvs+3Zsw9v20J5YSr0flQtYf/I+euWkmsUNgHLcy
         V27ER+iCOi5z9LCcyq68onwPMA6HCGbo++HlZIqc=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Martinz <amartinz@shiftphones.com>,
        Dylan Van Assche <me@dylanvanassche.be>,
        Alexander Martinz <amartinz@shiftphones.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom/sdm845-shift-axolotl: Add audio support
Date:   Thu, 09 Jun 2022 19:19:15 +0200
Message-ID: <11993096.O9o76ZdvQC@g550jk>
In-Reply-To: <20220609095412.211060-2-amartinz@shiftphones.com>
References: <20220609095412.211060-1-amartinz@shiftphones.com> <20220609095412.211060-2-amartinz@shiftphones.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Donnerstag, 9. Juni 2022 11:54:12 CEST Alexander Martinz wrote:
> This patch adds audio support for the SHIFT6mq phone.
> 
> The primary microphone and headphone jack are handled by the
> SDM845 sound card and WCD9340 codec.
> 
> The primary speaker needs to go through the TFA9890 speaker
> amplifier.
> 
> Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
> Tested-by: Dylan Van Assche <me@dylanvanassche.be>
> ---
>  .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts index
> fa72f23ef0c2..8c4967d6d0e3 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> @@ -8,6 +8,8 @@
> 
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include <dt-bindings/sound/qcom,q6afe.h>
> +#include <dt-bindings/sound/qcom,q6asm.h>
>  #include "sdm845.dtsi"
>  #include "pm8998.dtsi"
>  #include "pmi8998.dtsi"
> @@ -492,6 +494,19 @@ touchscreen@38 {
>  	};
>  };
> 
> +&i2c11 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	tfa9890_codec: tfa9890@34 {
> +		compatible = "nxp,tfa9890";
> +		reg = <0x34>;
> +		vddd-supply = <&vreg_s4a_1p8>;
> +		reset-gpio = <&tlmm 7 0>;
> +		#sound-dai-cells = <1>;
> +	};
> +};
> +
>  &ipa {
>  	status = "okay";
> 
> @@ -530,6 +545,27 @@ volume_down_resin: resin {
>  	};
>  };
> 
> +&q6afedai {
> +	qi2s@22 {
> +		reg = <22>;
> +		qcom,sd-lines = <0>;
> +	};
> +};

While my patch hasn't been reviewed yet, I have proposed to change the magic 
number <22> to the constant QUATERNARY_MI2S_RX here in existing dts files which 
better describes what the reg here is.

https://lore.kernel.org/linux-arm-msm/20220603094710.64591-1-luca.weiss@fairphone.com/

Maybe worth doing the same here for v2?

Regards
Luca



