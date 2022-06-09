Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F3C5452AC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344929AbiFIRIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbiFIRIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:08:04 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0059112DBD9;
        Thu,  9 Jun 2022 10:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1654794457;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=kGZmmOADn0EKx1aFs3YZdMQLcwtTt5OJKjbF5f+Rez0=;
    b=JjDiEl1F3iWYsjzzx1Y3CxkcU62MDCi+eUrW55ZHZT3AuzZifhN8sJ2bh8RaYw93gV
    X7IJyWbuXU3V15njIAffIS2bkkwihgt8qk+RLm7Ip8ryFJSRfqosYksOHrJvqfOocKY6
    wEzsKnRfAlmeCAQ9GKf7JcWaJ22Wcpcwq1YhBfFAKWRp+F3xlg1aXVGL7J6V7VsW1Dtp
    EVuTY3ByedGLBt/90gOizrQwVXyg6ED5NVx7DOlLgBeqKkH2y/PjIpOlG79JDj45ZmX0
    lCNS8KBC97PCS3E7s/tXSUOKDlWJRCH5lNCW9XmdJDU1yz3ScFI+Ekt/wJs8h1/WAJ4X
    K/NA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrKw5+aY="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.45.0 SBL|AUTH)
    with ESMTPSA id 9056edy59H7aBv1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 9 Jun 2022 19:07:36 +0200 (CEST)
Date:   Thu, 9 Jun 2022 19:07:29 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Alexander Martinz <amartinz@shiftphones.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: Re: [PATCH 2/2] arm64: dts: qcom/sdm845-shift-axolotl: Add audio
 support
Message-ID: <YqIo0TJHqCx33NLj@gerhold.net>
References: <20220609095412.211060-1-amartinz@shiftphones.com>
 <20220609095412.211060-2-amartinz@shiftphones.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609095412.211060-2-amartinz@shiftphones.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 11:54:12AM +0200, Alexander Martinz wrote:
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
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> index fa72f23ef0c2..8c4967d6d0e3 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
[...]
> @@ -492,6 +494,19 @@ touchscreen@38 {
>  	};
>  };
>  
> +&i2c11 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	tfa9890_codec: tfa9890@34 {

Please use "audio-codec@" as suggested in the bindings. Also, I think a
label such as "speaker_codec: " would make it more obvious that this is
the speaker. But that's personal preference. :)

> +		compatible = "nxp,tfa9890";
> +		reg = <0x34>;
> +		vddd-supply = <&vreg_s4a_1p8>;
> +		reset-gpio = <&tlmm 7 0>;

The mainline driver does not support the reset-gpio (it resets via the
I2C registers instead). Can just drop this.

Alternatively we could document it to the DT schema and describe it here
for completeness. That way it's already there if someone ever considers
it necessary for the driver.

> +		#sound-dai-cells = <1>;

Should be <0>. You might want to check your addition with
"make dtbs_check" to make sure it matches the DT schema. :)

Also, I would recommend adding a "sound-name-prefix". The prefix is used
for the ALSA mixers which makes it more obvious that they belong to the
speaker. (See example in DT schema.)

> +	};
> +};
> +
>  &ipa {
>  	status = "okay";
>  
[...]
> @@ -756,6 +879,24 @@ &venus {
>  	firmware-name = "qcom/sdm845/axolotl/venus.mbn";
>  };
>  
> +&wcd9340 {
> +	pinctrl-0 = <&wcd_intr_default>;
> +	pinctrl-names = "default";
> +	clock-names = "extclk";
> +	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
> +	reset-gpios = <&tlmm 64 0>;

0 => GPIO_ACTIVE_HIGH

Thanks,
Stephan
