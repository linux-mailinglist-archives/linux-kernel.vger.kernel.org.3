Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D7D54C7DA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345061AbiFOLv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346573AbiFOLu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:50:56 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFB14C429;
        Wed, 15 Jun 2022 04:50:55 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z7so15701525edm.13;
        Wed, 15 Jun 2022 04:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3DWcX8Od03/UApijSUWJq2RJ9QBnMd2wigkqz4nDJyM=;
        b=PBTExrVD+THL+SpJ9En5rEOJY31TcUF58Vd/88kyzxKIOgzcSgQFKACiHVrxYQ++X4
         8ZC9KRq4Ku5w45ZPUxcxyIjNShK/5pnk9/S/7LU74Bd1StdhQ6PXfXxGUmgeJBOqlPH+
         3KvLipLIZAM/QV/tWQjt6zDek0+LzBllDUIQnMFuUmsyg6z9NbVRCTYqAjVB4au2a9b3
         DgLBIbSfFceYXItQvG365H3tdyLO67OQX/IjVj72Y1y/R2SCsmLxCkbsvUSo708dB76q
         55S/Xz2myZiRQQxRy1SbG+sRAv5CmDEDBKMkLVUse1aCpWOq8aefuaTvdF9BRpn1NI3i
         Sb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3DWcX8Od03/UApijSUWJq2RJ9QBnMd2wigkqz4nDJyM=;
        b=r6Slwo5Q8qkQo7HkcamxD0IMnC3Wvb+pPek1JAuSFXzvPWRfOvjFr998YT+uJ5vtBj
         DducOAYRLzbZOXA+RSpyNf6to3xKtA0QgwlxPDGOFnB1kd6x0TCn4yqRKdRQPsIPOrV6
         TwYidkwLzYZ5mYNmWNVSaQxKJD1tUaoF+pkFI9zf9gyULatRoBUD6lfTS32pIF8KoxEW
         gj73RyT0ijYeYOKUrsNAtwEHjfvRFkIEohUz4kJ56Vb/l47jSCkikZpUJ+2N+lltoEEr
         j5LEI49LagyDS3i+xmPrD18gxYhP9ogYvXlIAhazG2QONB3UmrLBVBF2LQy84lUUCBkH
         mNTA==
X-Gm-Message-State: AOAM532Jqo1EO0AbRkWPP29FkZY4lt4+IB8pxJsLhDNh7ZinNUN5sou9
        4BWaW68FVwXFQCXSMmHUbe0=
X-Google-Smtp-Source: AGRyM1vj8HkiO0aUwCSPFvYx6F5XRhfVJlPRVZQWvaSTk0/0Y0eH/fVQWG5Eb/ftiiUH4kG/q47peA==
X-Received: by 2002:a50:ec12:0:b0:42d:cbcf:a629 with SMTP id g18-20020a50ec12000000b0042dcbcfa629mr12151968edr.224.1655293855007;
        Wed, 15 Jun 2022 04:50:55 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00715a02874acsm4561158ejd.35.2022.06.15.04.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:50:54 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/18] ARM: dts: imx6q-apalis: Add LVDS panel support
Date:   Wed, 15 Jun 2022 13:49:57 +0200
Message-Id: <20220615115006.45672-10-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220615115006.45672-1-max.oss.09@gmail.com>
References: <20220615115006.45672-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

Add LVDS panel and endpoint linkage support but keep the inherited
disabled state. This allows to enable it in an overlay per the current
system configuration.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6q-apalis-eval.dts       |  4 ---
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts |  4 ---
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      |  4 ---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         | 36 +++++++++++++++++++
 4 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index fdcb740a7a54..51efa7c57879 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -88,10 +88,6 @@
 	status = "okay";
 };
 
-&ldb {
-	status = "okay";
-};
-
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_reset_moci>;
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
index 21f88e19e87d..beb1981fc775 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
@@ -104,10 +104,6 @@
 	status = "okay";
 };
 
-&ldb {
-	status = "okay";
-};
-
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_reset_moci>;
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index e6fc76776b2e..3d42f8ffeb34 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -94,10 +94,6 @@
 	status = "okay";
 };
 
-&ldb {
-	status = "okay";
-};
-
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_reset_moci>;
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 240783d0901c..636b04139a5b 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -82,6 +82,18 @@
 		};
 	};
 
+	panel_lvds: panel-lvds {
+		compatible = "panel-lvds";
+		backlight = <&backlight>;
+		status = "disabled";
+
+		port {
+			lvds_panel_in: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
+
 	reg_module_3v3: regulator-module-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "+V3.3";
@@ -624,6 +636,30 @@
 	remote-endpoint = <&lcd_display_in>;
 };
 
+&ldb {
+	lvds-channel@0 {
+		port@4 {
+			reg = <4>;
+
+			lvds0_out: endpoint {
+				remote-endpoint = <&lvds_panel_in>;
+			};
+		};
+	};
+
+	lvds-channel@1 {
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <18>;
+
+		port@4 {
+			reg = <4>;
+
+			lvds1_out: endpoint {
+			};
+		};
+	};
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
-- 
2.20.1

