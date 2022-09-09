Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD915B2D2B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 05:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiIIDzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 23:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiIIDzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 23:55:00 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C272E6A8;
        Thu,  8 Sep 2022 20:54:57 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id n81so66414iod.6;
        Thu, 08 Sep 2022 20:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hzWkF9U7GwfQZbqCRBtHPI7uI9X33E5IkM3JzVbQ3ls=;
        b=b+Y/VNdA4+xoM8pVOCI53LPqBohWnizKD8y/3PSsAi4hGfsFVRmMLIQrZxfPeKTdam
         +bR73BSM2tUY/bAoY1JHbx0Ckksiicp/S8ZbCqy157R/L8LdAWDzmsUu2IiWxet1D9uH
         No2UUIQO3JbDurUx/U3Aq++aZF2m88YZmqyJWVENZ8nV9aGvCF8BW0ie5uKOGCZ8gzGI
         y9vjvNFW2bsWh83+NnfcoVjWGBgXiEcPnqd8E03VBaZV1mZwvD9tyAvRVMP5CvzW2Mgu
         yE96j0Jk0xTbPRQe/9QKhEaDyFpjgYOuVUy0x3AiO9H+3+R7WY1FUEoBdkz9xqjBK/Ze
         ZyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hzWkF9U7GwfQZbqCRBtHPI7uI9X33E5IkM3JzVbQ3ls=;
        b=AM/lLvPjlR2XcmAmRvE7QcqL5ahbbg591mouAwy5klfUCLFaXY62yh2L9DViMRJ6vi
         wy1A51n5PyOAsEzoyPxZOa9Ots5lL/5h8Dy0JJ6+aFi4tC0j9U6fN9BeCKW318VImyU/
         Ccz/FMpNvUzOWMrobEEg8XPUKK4HZQMMUd00by3/j71qDSMtDTF0ZXrZO7zOMnO2CG7j
         D3V9mCeR0OYWuNF8jtqcu7AVfOEwavxnyhExXUf9w7XOQAKh6vc23COTaM4XK9CtJ2ep
         wZ05ei32GDFzg22VBj7WLubAFkGuatAoWJTBOGg2kJwXWWsYyClqycGTlGlLiI4qfqtE
         mCaA==
X-Gm-Message-State: ACgBeo2etO0qwYHPrgk5xxF4RFRpvgryJyUI9z3wMue5QH21FmpOw1dp
        oDe7DRPTMAkSAgk3Wp+H7tc=
X-Google-Smtp-Source: AA6agR7ftXd9zpmsRzWvroM4gXvAezffFWHO+o7CaarPU2uTaB3nphX7V3UDopjCGrPpuXc7yPhLlw==
X-Received: by 2002:a02:c6c6:0:b0:359:b2d9:8838 with SMTP id r6-20020a02c6c6000000b00359b2d98838mr765781jan.298.1662695696675;
        Thu, 08 Sep 2022 20:54:56 -0700 (PDT)
Received: from fedora.. ([2604:2d80:4d8e:a000:6063:7cd5:2f24:16a6])
        by smtp.gmail.com with ESMTPSA id n28-20020a02715c000000b00346b4b25252sm330579jaf.13.2022.09.08.20.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 20:54:56 -0700 (PDT)
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH v5 1/3] arm64: dts: qcom: split beryllium dts into common dtsi and tianma dts
Date:   Thu,  8 Sep 2022 22:54:45 -0500
Message-Id: <20220909035447.36674-2-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909035447.36674-1-joelselvaraj.oss@gmail.com>
References: <20220909035447.36674-1-joelselvaraj.oss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two panel variants of Xiaomi Poco F1. Tianma and EBBG panel.
The previous beryllium dts supported the Tianma variant. In order to
add support for EBBG variant, the common nodes from beryllium dts are
moved to a new common dtsi and to make the variants distinguishable,
sdm845-xiaomi-beryllium.dts is now named as
sdm845-xiaomi-beryllium-tianma.dts. The model property is updated to
distinguish between the variants. The compatibility property is
moved to the tianma variant, but it is not updated to avoid any
further conflict with other projects/users that might depend on it.

Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 arch/arm64/boot/dts/qcom/Makefile                 |  2 +-
 ...um.dts => sdm845-xiaomi-beryllium-common.dtsi} | 11 +++++------
 .../dts/qcom/sdm845-xiaomi-beryllium-tianma.dts   | 15 +++++++++++++++
 3 files changed, 21 insertions(+), 7 deletions(-)
 rename arch/arm64/boot/dts/qcom/{sdm845-xiaomi-beryllium.dts => sdm845-xiaomi-beryllium-common.dtsi} (98%)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 1d86a33de528..d0bba59d2a8c 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -128,7 +128,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-oneplus-fajita.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akari.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akatsuki.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-apollo.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-tianma.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-polaris.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
similarity index 98%
rename from arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
rename to arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 82c27f90d300..940ac9cd0aba 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -26,8 +26,6 @@
 /delete-node/ &rmtfs_mem;
 
 / {
-	model = "Xiaomi Pocophone F1";
-	compatible = "xiaomi,beryllium", "qcom,sdm845";
 	chassis-type = "handset";
 
 	/* required for bootloader to select correct board */
@@ -221,8 +219,7 @@ &dsi0 {
 	status = "okay";
 	vdda-supply = <&vreg_l26a_1p2>;
 
-	panel@0 {
-		compatible = "tianma,fhd-video";
+	display_panel: panel@0 {
 		reg = <0>;
 		vddio-supply = <&vreg_l14a_1p8>;
 		vddpos-supply = <&lab>;
@@ -234,8 +231,10 @@ panel@0 {
 		backlight = <&pmi8998_wled>;
 		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
 
+		status = "disabled";
+
 		port {
-			tianma_nt36672a_in_0: endpoint {
+			panel_in_0: endpoint {
 				remote-endpoint = <&dsi0_out>;
 			};
 		};
@@ -243,7 +242,7 @@ tianma_nt36672a_in_0: endpoint {
 };
 
 &dsi0_out {
-	remote-endpoint = <&tianma_nt36672a_in_0>;
+	remote-endpoint = <&panel_in_0>;
 	data-lanes = <0 1 2 3>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
new file mode 100644
index 000000000000..8e176111e599
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include "sdm845-xiaomi-beryllium-common.dtsi"
+
+/ {
+	model = "Xiaomi Pocophone F1 (Tianma)";
+	compatible = "xiaomi,beryllium", "qcom,sdm845";
+};
+
+&display_panel {
+	compatible = "tianma,fhd-video";
+	status = "okay";
+};
-- 
2.37.3

