Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742BD5283BA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243411AbiEPMAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243331AbiEPL7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:59:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA13F16584;
        Mon, 16 May 2022 04:59:31 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dk23so28149832ejb.8;
        Mon, 16 May 2022 04:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t6QnOlaEmPk5w0CUbgkiElPmdAVeupgyOfiVgHTVYrs=;
        b=poefYTAJysRL8JajKHfgAq/lICxCmMyF+rhh0w43DuY6aRO8dzAW0s4xWZ3AxcN1n7
         +Qv4CUjgVmaQ8cSg7Jg+3yGpN3EN/8Fhtlpl9piAUXSk714XXKzGwXOCrmazlOzm/9QX
         kSdJFE0379pD9qH85ORs2ojBZibpxusIVI/20KqVZTJhgg+XEOXNNM/mKewxJP78kxmw
         f3QsOCabKNhfGB/DrBTOhj8A22j3ls9EqztCyOjB0CnbqHprT0GuRDBOvDSr6NVgA/hh
         z/zcmbAJ2x0Bzpnn+YfK0e2TaZbSRwlFcMfANmdGZsBZkJjH3PaKkejGg6OyETR+ys/s
         DAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t6QnOlaEmPk5w0CUbgkiElPmdAVeupgyOfiVgHTVYrs=;
        b=WG9vILC4SPlfRBD5i03GRC7WvKtlYgEE/tUF8LijrbNUeLHX4M2DcmhUWKz5cqnPIQ
         wSe8eQ0zCf8lnb++3F0S+8UI2bji7+/VIVVFwVWe4PB7nEU7B3XAP+uEPq0x8h5Wr8Z3
         NPT633A48vXKNuyrTuSitXPwbHuqkcqLJ+VAz/v00n0Aiveh4ZkQn9QxyDijq4asQKDu
         qrDpKOon5LJ1Zg2ne5+1HrRHz3L7IcrD8J/hi416jK8DM5W4auT9PrIRflMk/cLUvalv
         LjBlQeH80Elpn8sHM8oRQJgMzZPQKjjnSlooRpprTNO7LMoRBYn+lFt0LH7BJ0F1Jhxx
         rR1g==
X-Gm-Message-State: AOAM533H5E7Xy9rpQYQ6m5wBvgFWoNNn09r9+4tSc8/UVtxQiiOLHCL6
        UvnmKhhXAslP5H44fhgNAas=
X-Google-Smtp-Source: ABdhPJxwm87KMgQCehgWjFdS+7fr1G8eU83fjJqZBMEpJZZWwL64J1D4qLUTjnVUDevA3y+Pc27FSQ==
X-Received: by 2002:a17:907:3e03:b0:6da:8c5a:6d4a with SMTP id hp3-20020a1709073e0300b006da8c5a6d4amr15173944ejc.585.1652702370206;
        Mon, 16 May 2022 04:59:30 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906779200b006f3ef214dacsm3711008ejm.18.2022.05.16.04.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:59:29 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 08/17] ARM: dts: imx6q-apalis: Add LVDS panel support
Date:   Mon, 16 May 2022 13:58:36 +0200
Message-Id: <20220516115846.58328-9-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220516115846.58328-1-max.oss.09@gmail.com>
References: <20220516115846.58328-1-max.oss.09@gmail.com>
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

 arch/arm/boot/dts/imx6q-apalis-eval.dts       |  4 ---
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts |  4 ---
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      |  4 ---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         | 36 +++++++++++++++++++
 4 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index 5985d1169be1..948bbece3ab5 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -102,10 +102,6 @@
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
index 6743617ad1c1..28e5d6b68530 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -108,10 +108,6 @@
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
index 3aa66b6d0c88..428841cdaac2 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -68,6 +68,18 @@
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
@@ -610,6 +622,30 @@
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

