Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4C2575F51
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbiGOKZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiGOKZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:25:09 -0400
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C44282F95;
        Fri, 15 Jul 2022 03:25:08 -0700 (PDT)
Date:   Fri, 15 Jul 2022 10:25:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1657880706; x=1658139906;
        bh=zPqdR+HafcwDy1W0JQxmXtHI+hMl6rra+AYRnvrWqpM=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=Z7MD4Xjv8hln3g+8ABCao0ivtjTYtaLMuOFSS9XlNcVo3KA2qKxSxYz+ZY+eUjvNy
         YR1wYfIFFBPPb4zRqdrHSMrp9YSar7pVR3/yjmWOYpy8jg9p6cFaXoYzDvds8Q8i9Z
         Ag75usy/AB765k564FuAOBaGuD/Z+MYflB5r1zC8KRkhjB/6cNnuwPGF/QdRH+jX0v
         kvnNK0CcciB+fZykVRuPh4FrNdqWQ7aFXuYu8v6Re3tpr18TiZnDtWS6Vhv5QOEaED
         fUmLN73Dp2Fk9FyvLL5iePPcE1iYpuwuN4X9OjvjAQ2DKFVatqICLUvH9rBtZdbqNY
         07jtbaavddqug==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
Reply-To: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: [RESEND PATCH 4/4] arm64: dts: qcom: msm8916-samsung-e2015: Add touchkey
Message-ID: <20220715102413.4119-1-linmengbo0689@protonmail.com>
In-Reply-To: <20220715102055.3844-1-linmengbo0689@protonmail.com>
References: <20220715102055.3844-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Samsung Galaxy E5 and E7 the touch key is supplied by a single
fixed regulator (enabled via GPIO 97) that supplies both MCU and LED.
Add it to the device tree.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../qcom/msm8916-samsung-e2015-common.dtsi    | 26 +++++++++++++++++++
 .../dts/qcom/msm8916-samsung-grandmax.dts     |  4 +++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
index 373154ee2643..9f3aca17130d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
@@ -19,6 +19,19 @@ muic: extcon@14 {
 =09=09};
 =09};

+=09reg_touch_key: regulator-touch-key {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "touch_key";
+=09=09regulator-min-microvolt =3D <3300000>;
+=09=09regulator-max-microvolt =3D <3300000>;
+
+=09=09gpio =3D <&msmgpio 97 GPIO_ACTIVE_HIGH>;
+=09=09enable-active-high;
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&tkey_en_default>;
+=09};
+
 =09vibrator: vibrator {
 =09=09compatible =3D "gpio-vibrator";
 =09=09enable-gpios =3D <&msmgpio 76 GPIO_ACTIVE_HIGH>;
@@ -28,6 +41,11 @@ vibrator: vibrator {
 =09};
 };

+&touchkey {
+=09vcc-supply =3D <&reg_touch_key>;
+=09vdd-supply =3D <&reg_touch_key>;
+};
+
 &msmgpio {
 =09motor_en_default: motor-en-default {
 =09=09pins =3D "gpio76";
@@ -36,4 +54,12 @@ motor_en_default: motor-en-default {
 =09=09drive-strength =3D <2>;
 =09=09bias-disable;
 =09};
+
+=09tkey_en_default: tkey-en-default {
+=09=09pins =3D "gpio97";
+=09=09function =3D "gpio";
+
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts b/arch/a=
rm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
index 41aada4bfb80..f68dd3d69a33 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
@@ -27,6 +27,10 @@ / {
 =09/delete-node/ i2c-tkey;
 };

+&reg_touch_key {
+=09status =3D "disabled";
+};
+
 &vibrator {
 =09enable-gpios =3D <&msmgpio 72 GPIO_ACTIVE_HIGH>;
 };
--
2.30.2


