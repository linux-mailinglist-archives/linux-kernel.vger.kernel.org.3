Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1787C57272E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiGLUYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiGLUY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:24:28 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99C860512;
        Tue, 12 Jul 2022 13:24:26 -0700 (PDT)
Date:   Tue, 12 Jul 2022 20:22:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=protonmail3; t=1657657463; x=1657916663;
        bh=/BMaCo6X5dvTlMSHAbwWvDTwHD6m6QUY38PzBciixOY=;
        h=Date:To:From:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=iPZosarhOKEL6fXh4ZYsbzkIUXYpA4FNJpye++/F7eYvtokNg/zlhT8GevVhdWfII
         3/5YK6XgXzSLieZ//jUb2APRbgBIE7EaWBIrpCyTbbZgUFUK+DAHmnFerjd/P7IDVY
         gru6rMroKAt/Tm7FADP2M/sDPT3vvT47YvPOSjocuNqy8yclBeGOTnjnuG50qh4njI
         GCGJ9Vx1gWnUGnj4Y/sVsZDP5QIAjCp4FIUuT44xcCRiTbWYocs9YszFa1VvjqoFmD
         oLdkhXdGioi3zi1GVFI1Q2VEwQLnEzoK27tzzq+AafBmzQvJEgNMuyz74PJUk5kbl/
         Cr/IReRDboJ2Q==
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?utf-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   =?utf-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>
Reply-To: =?utf-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>
Subject: [PATCH 1/2] arm64: dts: imx8qm-mek: mux and hook up GPIOs related to SD1
Message-ID: <20220712202211.8592-1-tszucs@protonmail.ch>
Feedback-ID: 53029:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl node grouping USDHC1_DATA6, USDHC1_DATA7 and USDHC1_RESET_B and=
 use
them as Write Protect and Card Detect for usdhc2 and regulator enable for
SD1_SPWR respectively.

Fixes: 307fd14d4b14 ("arm64: dts: imx: add imx8qm mek support")

Signed-off-by: Tam=C3=A1s Sz=C5=B1cs <tszucs@protonmail.ch>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot=
/dts/freescale/imx8qm-mek.dts
index ce9d3f0b98fc..19b60efe3639 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -32,7 +32,7 @@ reg_usdhc2_vmmc: usdhc2-vmmc {
 =09=09regulator-name =3D "SD1_SPWR";
 =09=09regulator-min-microvolt =3D <3000000>;
 =09=09regulator-max-microvolt =3D <3000000>;
-=09=09gpio =3D <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
+=09=09gpio =3D <&lsio_gpio4 7 GPIO_ACTIVE_HIGH>;
 =09=09enable-active-high;
 =09};
 };
@@ -79,11 +79,11 @@ &usdhc1 {

 &usdhc2 {
 =09pinctrl-names =3D "default";
-=09pinctrl-0 =3D <&pinctrl_usdhc2>;
+=09pinctrl-0 =3D <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
 =09bus-width =3D <4>;
 =09vmmc-supply =3D <&reg_usdhc2_vmmc>;
-=09cd-gpios =3D <&lsio_gpio4 22 GPIO_ACTIVE_LOW>;
-=09wp-gpios =3D <&lsio_gpio4 21 GPIO_ACTIVE_HIGH>;
+=09cd-gpios =3D <&lsio_gpio5 22 GPIO_ACTIVE_LOW>;
+=09wp-gpios =3D <&lsio_gpio5 21 GPIO_ACTIVE_HIGH>;
 =09status =3D "okay";
 };

@@ -141,4 +141,12 @@ IMX8QM_USDHC1_DATA3_CONN_USDHC1_DATA3=09=09=090x000000=
21
 =09=09=09IMX8QM_USDHC1_VSELECT_CONN_USDHC1_VSELECT=09=090x00000021
 =09=09>;
 =09};
+
+=09pinctrl_usdhc2_gpio: usdhc2grpgpio {
+=09=09fsl,pins =3D <
+=09=09=09IMX8QM_USDHC1_DATA6_LSIO_GPIO5_IO21=09=09=090x00000021
+=09=09=09IMX8QM_USDHC1_DATA7_LSIO_GPIO5_IO22=09=09=090x00000021
+=09=09=09IMX8QM_USDHC1_RESET_B_LSIO_GPIO4_IO07=09=09=090x00000021
+=09=09>;
+=09};
 };
--
2.30.2


