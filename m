Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9BA5439F1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 19:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiFHRHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 13:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237494AbiFHRFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:05:06 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F408271A81
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:53:54 -0700 (PDT)
Date:   Wed, 08 Jun 2022 16:53:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1654707232; x=1654966432;
        bh=NTQKID+P6bfYd2k0VkyU/2Td+qJJ4uMnG1+NHLimZJM=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=XWVVjhVogiP0j+qooPSRX7WA631cydiXaNvkxI8inrldH5Ot5LgK+E45NQinzaZBA
         Wu4ULipxn/7hvQ75wVFJOKhzu/mxoAvNhJC1a+yRNdgq+OSs7hYCHVLOpLV2ndlS7x
         Z5NfugD+J69aaBg0ZluGb7u82YH3UKLI9dSq5QU4=
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH] arm64: dts: qcom/sdm845-shift-axolotl: Enable pmi9889 LPG LED
Message-ID: <19c35ce5-d98c-b5b2-893b-d89425693add@connolly.tech>
In-Reply-To: <20220512054439.13971-1-me@dylanvanassche.be>
References: <20220512054439.13971-1-me@dylanvanassche.be>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/05/2022 06:44, Dylan Van Assche wrote:
> Enables the RGB notification LED on the SHIFT 6mq (sdm845-shift-axolotl)
> with the Qualcomm Light Pulse Generator bindings by Bjorn Andersson [1].
> Patches are merged in for-next branch of linux-leds.
> Tested these changes on the SHIFT 6mq.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/=
commit/?h=3Dfor-next&id=3Da8e53db46f19f67be6a26488aafb7d10c78e33bd
>
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
Tested-by: Caleb Connolly <caleb@connolly.tech>
Reviewed-by: Caleb Connolly <caleb@connolly.tech>
> ---
>   .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 29 +++++++++++++++++++
>   1 file changed, 29 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm=
64/boot/dts/qcom/sdm845-shift-axolotl.dts
> index 847f6217a77b..af412ac2c9d0 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> @@ -2,11 +2,13 @@
>   /*
>    * Copyright (c) 2022, Alexander Martinz <amartinz@shiftphones.com>
>    * Copyright (c) 2022, Caleb Connolly <caleb@connolly.tech>
> + * Copyright (c) 2022, Dylan Van Assche <me@dylanvanassche.be>
>    */
>
>   /dts-v1/;
>
>   #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>   #include "sdm845.dtsi"
>   #include "pm8998.dtsi"
> @@ -554,6 +556,33 @@ &pmi8998_smb2 {
>   =09monitored-battery =3D <&battery>;
>   };
>
> +&pmi8998_lpg {
> +=09status =3D "okay";
> +
> +=09multi-led {
> +=09=09color =3D <LED_COLOR_ID_RGB>;
> +=09=09function =3D LED_FUNCTION_STATUS;
> +
> +=09=09#address-cells =3D <1>;
> +=09=09#size-cells =3D <0>;
> +
> +=09=09led@3 {
> +=09=09=09reg =3D <3>;
> +=09=09=09color =3D <LED_COLOR_ID_BLUE>;
> +=09=09};
> +
> +=09=09led@4 {
> +=09=09=09reg =3D <4>;
> +=09=09=09color =3D <LED_COLOR_ID_GREEN>;
> +=09=09};
> +
> +=09=09led@5 {
> +=09=09=09reg =3D <5>;
> +=09=09=09color =3D <LED_COLOR_ID_RED>;
> +=09=09};
> +=09};
> +};
> +
>   &qup_uart9_default {
>   =09pinconf-rx {
>   =09=09pins =3D "gpio5";
> --
> 2.36.1
>

--
Kind Regards,
Caleb

