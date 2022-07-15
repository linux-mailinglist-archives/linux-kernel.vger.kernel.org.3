Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE08575F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiGOKY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiGOKY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:24:56 -0400
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FA8774AB;
        Fri, 15 Jul 2022 03:24:55 -0700 (PDT)
Date:   Fri, 15 Jul 2022 10:24:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1657880693; x=1658139893;
        bh=nJjBOg+KZDuep5ju6jcUjcAcUZtT4ZszCml4jwBd4aU=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=PPTTHy2Xb0Fz62u1uEF+r669hJZwlv3psxi11B46sSf90WFfv5tfJTt8rRoyAkpEm
         2Yw3+9ZW5qj98dLXLs2qoCCGRoeLnIcKkYY/bXqgbZwgxw5akH7CTu04n1oLC6achi
         dx7vm46c2feJQ4+h1b75H+YvLHnt2VqpXpAHk19Wo5l3gaU99izUOT6eq+pc+SXdHF
         aZDR/QVb3rrx6e1mMa9Sed7ml58jyOuT1Bdgurr0KM4slDYyDO3wtko1UpAp9klNcp
         Z8+ABIG7t8U1vkWy6LQJ9LBDlUj7Th0hW3rrTFHcLD6cTt9xScFG75EJD7INVh+U41
         +Y7hK9jpXa2fw==
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
Subject: [RESEND PATCH 2/4] arm64: dts: qcom: msm8916-samsung-e2015: Add initial common dtsi
Message-ID: <20220715102343.4004-1-linmengbo0689@protonmail.com>
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

Samsung Galaxy E5, E7 and Grand Max are smartphones using the MSM8916 SoC
released in 2015.

e2015 and a2015 are similar, with some differences in accelerometer,
MUIC and Vibrator. The common parts are shared in
msm8916-samsung-a2015-common.dtsi to reduce duplication.

Add a common device tree for with initial support for:

- GPIO keys and vibrator
- Hall sensor (except Grand Max)
- SDHCI (internal and external storage)
- USB Device Mode
- UART (on USB connector via the SM5504 MUIC)
- WCNSS (WiFi/BT)
- Regulators
- S3FWRN5 NFC (except Grand Max)

The three devices (and all other variants of E5/E7/Grand Max released in
2015) are very similar, with some differences in display, touchscreen,
sensors and NFC. The common parts are shared in
msm8916-samsung-e2015-common.dtsi to reduce duplication.

Unfortunately, some E5/E7/Grand Max were released with outdated 32-bit
only firmware and never received any update from Samsung. Since the 32-bit
TrustZone firmware is signed there seems to be no way currently to
actually boot this device tree on arm64 Linux on those variants at the
moment.

However, it is possible to use this device tree by compiling an ARM32
kernel instead. The device tree can be easily built on ARM32 with
an #include and it works really well there. To avoid confusion for others
it is still better to add this device tree on arm64. Otherwise it's easy
to forget to update this one when making some changes that affect all
MSM8916 devices.

Maybe someone finds a way to boot ARM64 Linux on those device at some
point. In this case I expect that this device tree can be simply used
as-is.

Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |  3 ++
 .../qcom/msm8916-samsung-e2015-common.dtsi    | 39 +++++++++++++++++++
 .../boot/dts/qcom/msm8916-samsung-e5.dts      | 24 ++++++++++++
 .../boot/dts/qcom/msm8916-samsung-e7.dts      | 29 ++++++++++++++
 .../dts/qcom/msm8916-samsung-grandmax.dts     | 36 +++++++++++++++++
 5 files changed, 131 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.d=
tsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-e5.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-e7.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/M=
akefile
index 2f8aec2cc6db..941494553b9e 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -15,6 +15,9 @@ dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-longcheer-l8910.dt=
b
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-a3u-eur.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-a5u-eur.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-e5.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-e7.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-grandmax.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-j5.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-serranove.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-wingtech-wt88047.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
new file mode 100644
index 000000000000..373154ee2643
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "msm8916-samsung-a2015-common.dtsi"
+
+/ {
+=09i2c-muic {
+=09=09/* SM5504 MUIC instead of SM5502 */
+=09=09/delete-node/ extcon@25;
+
+=09=09muic: extcon@14 {
+=09=09=09compatible =3D "siliconmitus,sm5504-muic";
+=09=09=09reg =3D <0x14>;
+
+=09=09=09interrupt-parent =3D <&msmgpio>;
+=09=09=09interrupts =3D <12 IRQ_TYPE_EDGE_FALLING>;
+
+=09=09=09pinctrl-names =3D "default";
+=09=09=09pinctrl-0 =3D <&muic_int_default>;
+=09=09};
+=09};
+
+=09vibrator: vibrator {
+=09=09compatible =3D "gpio-vibrator";
+=09=09enable-gpios =3D <&msmgpio 76 GPIO_ACTIVE_HIGH>;
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&motor_en_default>;
+=09};
+};
+
+&msmgpio {
+=09motor_en_default: motor-en-default {
+=09=09pins =3D "gpio76";
+=09=09function =3D "gpio";
+
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e5.dts b/arch/arm64/b=
oot/dts/qcom/msm8916-samsung-e5.dts
new file mode 100644
index 000000000000..777eb934eb4b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e5.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-samsung-e2015-common.dtsi"
+
+/*
+ * NOTE: The original firmware from Samsung can only boot ARM32 kernels on=
 some
+ * variants.
+ * Unfortunately, the firmware is signed and cannot be replaced easily.
+ * There seems to be no way to boot ARM64 kernels on 32-bit devices at the
+ * moment, even though the hardware would support it.
+ *
+ * However, it is possible to use this device tree by compiling an ARM32 k=
ernel
+ * instead. For clarity and build testing this device tree is maintained n=
ext
+ * to the other MSM8916 device trees. However, it is actually used through
+ * arch/arm/boot/dts/qcom-msm8916-samsung-e5.dts
+ */
+
+/ {
+=09model =3D "Samsung Galaxy E5";
+=09compatible =3D "samsung,e5", "qcom,msm8916";
+=09chassis-type =3D "handset";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e7.dts b/arch/arm64/b=
oot/dts/qcom/msm8916-samsung-e7.dts
new file mode 100644
index 000000000000..b412b61ca258
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e7.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-samsung-e2015-common.dtsi"
+
+/*
+ * NOTE: The original firmware from Samsung can only boot ARM32 kernels on=
 some
+ * variants.
+ * Unfortunately, the firmware is signed and cannot be replaced easily.
+ * There seems to be no way to boot ARM64 kernels on 32-bit devices at the
+ * moment, even though the hardware would support it.
+ *
+ * However, it is possible to use this device tree by compiling an ARM32 k=
ernel
+ * instead. For clarity and build testing this device tree is maintained n=
ext
+ * to the other MSM8916 device trees. However, it is actually used through
+ * arch/arm/boot/dts/qcom-msm8916-samsung-e7.dts
+ */
+
+/ {
+=09model =3D "Samsung Galaxy E7";
+=09compatible =3D "samsung,e7", "qcom,msm8916";
+=09chassis-type =3D "handset";
+};
+
+&pm8916_l17 {
+=09regulator-min-microvolt =3D <3000000>;
+=09regulator-max-microvolt =3D <3000000>;
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts b/arch/a=
rm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
new file mode 100644
index 000000000000..41aada4bfb80
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-samsung-e2015-common.dtsi"
+
+/*
+ * NOTE: The original firmware from Samsung can only boot ARM32 kernels on=
 some
+ * variants.
+ * Unfortunately, the firmware is signed and cannot be replaced easily.
+ * There seems to be no way to boot ARM64 kernels on 32-bit devices at the
+ * moment, even though the hardware would support it.
+ *
+ * However, it is possible to use this device tree by compiling an ARM32 k=
ernel
+ * instead. For clarity and build testing this device tree is maintained n=
ext
+ * to the other MSM8916 device trees. However, it is actually used through
+ * arch/arm/boot/dts/qcom-msm8916-samsung-grandmax.dts
+ */
+
+/ {
+=09model =3D "Samsung Galaxy Grand Max";
+=09compatible =3D "samsung,grandmax", "qcom,msm8916";
+=09chassis-type =3D "handset";
+
+=09/delete-node/ gpio-hall-sensor;
+=09/delete-node/ i2c-nfc;
+=09/delete-node/ i2c-tkey;
+};
+
+&vibrator {
+=09enable-gpios =3D <&msmgpio 72 GPIO_ACTIVE_HIGH>;
+};
+
+&motor_en_default {
+=09pins =3D "gpio72";
+};
--
2.30.2


