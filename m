Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019B8495460
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346689AbiATSqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:46:44 -0500
Received: from mail-4018.proton.ch ([185.70.40.18]:64371 "EHLO
        mail-4018.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346596AbiATSqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:46:39 -0500
Date:   Thu, 20 Jan 2022 18:46:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1642704395;
        bh=BrSJa8CL9j+/2ci4r4jMebkxbmilq3QtxhBgHxAwDCA=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc;
        b=kce+ma+VdvppR7D7YbXIygpTBXhTec3QFSSUCG0OfJppIwCvXZxShbo0UhIKyMZ/D
         TCcjS+5IBkoc6wpMH1nbA5qIRi8qIKTQAG5b2QSpOGEblYO3pVI3+0ik+GVJ1XN7Pp
         uvSw3/nNqIaoJ8AyAnG6HHli1pqU8nAAjBqmHxjQ=
To:     caleb@connolly.tech, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     ~postmarketos/upstreaming@lists.sr.ht
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: [PATCH] arm64: dts: qcom: sdm845-oneplus-*: add fuel gauge
Message-ID: <20220120184546.499030-1-caleb@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OnePlus 6 and 6T feature a BQ27411 fuel gauge for reading the
battery stats. Enable it and add a simple battery to document the
battery specs of each device.

Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi  | 11 +++++++++++
 .../arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts | 12 ++++++++++++
 arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts   | 12 ++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm=
64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 7f42e5315ecb..08deca53f0b2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -376,6 +376,17 @@ zap-shader {
 =09};
 };

+&i2c10 {
+=09status =3D "okay";
+=09clock-frequency =3D <100000>;
+
+=09bq27441_fg: bq27441-battery@55 {
+=09=09compatible =3D "ti,bq27411";
+=09=09status =3D "okay";
+=09=09reg =3D <0x55>;
+=09};
+};
+
 &i2c12 {
 =09status =3D "okay";
 =09clock-frequency =3D <400000>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts b/arch/a=
rm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
index 5936b47dee5f..bf2cf92e8976 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
@@ -13,6 +13,14 @@ / {
 =09chassis-type =3D "handset";
 =09qcom,msm-id =3D <0x141 0x20001>;
 =09qcom,board-id =3D <8 0 17819 22>;
+
+=09battery: battery {
+=09=09compatible =3D "simple-battery";
+
+=09=09charge-full-design-microamp-hours =3D <3300000>;
+=09=09voltage-min-design-microvolt =3D <3400000>;
+=09=09voltage-max-design-microvolt =3D <4400000>;
+=09};
 };

 &display_panel {
@@ -20,3 +28,7 @@ &display_panel {

 =09compatible =3D "samsung,sofef00";
 };
+
+&bq27441_fg {
+=09monitored-battery =3D <&battery>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts b/arch/arm6=
4/boot/dts/qcom/sdm845-oneplus-fajita.dts
index 78a0b99144e6..1b6b5bf368df 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
@@ -13,6 +13,14 @@ / {
 =09chassis-type =3D "handset";
 =09qcom,msm-id =3D <0x141 0x20001>;
 =09qcom,board-id =3D <8 0 18801 41>;
+
+=09battery: battery {
+=09=09compatible =3D "simple-battery";
+
+=09=09charge-full-design-microamp-hours =3D <3700000>;
+=09=09voltage-min-design-microvolt =3D <3400000>;
+=09=09voltage-max-design-microvolt =3D <4400000>;
+=09};
 };

 &display_panel {
@@ -21,6 +29,10 @@ &display_panel {
 =09compatible =3D "samsung,s6e3fc2x01";
 };

+&bq27441_fg {
+=09monitored-battery =3D <&battery>;
+};
+
 &rmi4_f12 {
 =09touchscreen-y-mm =3D <148>;
 };
--
2.34.1


