Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08A157EF9C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbiGWO00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237749AbiGWO0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:26:18 -0400
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF7213F9C;
        Sat, 23 Jul 2022 07:26:16 -0700 (PDT)
Date:   Sat, 23 Jul 2022 14:26:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1658586374; x=1658845574;
        bh=t7qO8/etsffdba29XGI7QY2+c1Zw0zXG8dwZdbEe+FI=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=dwzIQO91BWpL9vCrgjbyAusHGD+5VThza4MzDblPyIJKjY50bSJjpSn/QUhpYuOTL
         1eOHHjWyBSTc9qfpBfctDi/MByEwYgSuFlQ6QaaF9I0MkJi0W2xHyHaAHUMviDfPoI
         mpcw6xp8Sa7aiq30LVVL08ojD/9DbK9K8rajTu+1En+dcIS7pTI7QgJc7TnfKyLqj0
         t+APl7Bsp4dlu4pUXHjSvwslJbr5+OWxxj0itYsdy93iw0LVJPNyelr4dM5f3fovZX
         TnRHsa5W2pUCtRxxdA/jhr2Q56MQJECUYXfuqTvornwA509Pzme8sGPNysHiZLvfsN
         lVW/HqUhpUFsg==
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
Subject: [PATCH v5 4/4] arm64: dts: qcom: msm8916-samsung-e2015: Add touchkey
Message-ID: <20220723142509.136627-1-linmengbo0689@protonmail.com>
In-Reply-To: <20220723141835.136196-1-linmengbo0689@protonmail.com>
References: <20220723141835.136196-1-linmengbo0689@protonmail.com>
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
index 3677fd81b6c1..0f01e6c2aa72 100644
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
@@ -36,6 +49,11 @@ &blsp_i2c2 {
 =09/delete-node/ magnetometer@12;
 };

+&touchkey {
+=09vcc-supply =3D <&reg_touch_key>;
+=09vdd-supply =3D <&reg_touch_key>;
+};
+
 &msmgpio {
 =09motor_en_default: motor-en-default {
 =09=09pins =3D "gpio76";
@@ -44,4 +62,12 @@ motor_en_default: motor-en-default {
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
index 74c07a970317..87e990f4f9fc 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
@@ -37,6 +37,10 @@ keyled {
 =09};
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


