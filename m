Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937A65A3FC0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 22:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiH1U5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 16:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiH1U5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 16:57:35 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC1530F4F;
        Sun, 28 Aug 2022 13:57:34 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id n202so5162696iod.6;
        Sun, 28 Aug 2022 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=7P/6pkBG5AXeUM81e7/yIGOGSbeqlS3w48j+SavUKtc=;
        b=XrIMXoY9cddywFxBuH/YBKppaCUzYQB5cf7PDPN+gfTFB/sYRVQXE+jMWGZ9ylWNC2
         zj1DGScRszt4TYs42WcIInfpD9+jxJZtFXEpkvftMsPlNyNHBckzETF6mxCnCa1fQRI4
         g3SttZwqE3hzVq9MKr02VfK6Bl1YF5YH3uRQ6qtcOH8gYN/UA3bHM/02EPFLNAUgop6j
         Y6qM50yW+HiQGLsRK24/iwalUSAOOAeU1RLdtNHvrKV2jC2euL9WLDuCnUXSpbW6wgJ5
         dpClEw5vd3S9Y0j4SEQrx58LQJGplEKH2VWdUE2PJL4x98zc5YvwnWQFtMt9MKAg5Wc/
         GLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7P/6pkBG5AXeUM81e7/yIGOGSbeqlS3w48j+SavUKtc=;
        b=Ih2isFSjVAczZ8hmUkkq0EtmcE89ZSPAHy9Zmw3r/RExc1tUlF2T5fZVpNe0aBEmsr
         SSqnXtppFTCLK6W2OEsVtgOG0eXwkH4YSBkwcNvg2y3ZWgJKDlvptnw3CdPLdrXhrjvs
         aD8vxDyVvuGKlzV57sv5uQc0xRgvNONoZNdyWEE9MQlUcpQdpiEAxAt/ck4Q6dWMoUDm
         yC27XLpIkJirdmdoUcni5HHHyUO4k5GFwaiENMcqYDshCpUv7YyVjN594LaZZGIpNim1
         jVufWqYu3/iJjifn5sDkcptCTThCPkFej6MY8hNUH8ix35IxfJLQj+/8dgzawGs1DQI9
         ZwEA==
X-Gm-Message-State: ACgBeo0kI1ZMQZ/Z2m2XmHp2QwsKIT5guhgoTjLWTG45+pmIS98XJg5y
        slsXgrIq5+hv5HggUgAxPlo=
X-Google-Smtp-Source: AA6agR5BwsSpiNXIfiqcAo4SLAi5MdpWnyaVhQHPJrajOvWoDZX+QsY1vMgzu/KIn8gH7XCnMybsfQ==
X-Received: by 2002:a05:6638:d41:b0:349:f7fd:9e1f with SMTP id d1-20020a0566380d4100b00349f7fd9e1fmr9013325jak.278.1661720254217;
        Sun, 28 Aug 2022 13:57:34 -0700 (PDT)
Received: from fedora.. ([2604:2d80:4d8e:a000:6063:7cd5:2f24:16a6])
        by smtp.gmail.com with ESMTPSA id k7-20020a02c767000000b00349be1ef390sm3572404jao.121.2022.08.28.13.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 13:57:33 -0700 (PDT)
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
Subject: [PATCH v4 2/4] arm64: dts: qcom: split beryllium dts into common dtsi and tianma dts
Date:   Sun, 28 Aug 2022 15:57:21 -0500
Message-Id: <20220828205723.20834-3-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220828205723.20834-1-joelselvaraj.oss@gmail.com>
References: <20220828205723.20834-1-joelselvaraj.oss@gmail.com>
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
sdm845-xiaomi-beryllium-tianma.dts. The model and compatible property
are also updated to distinguish between the variants.

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
index 000000000000..5411ca29a89b
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
+	compatible = "xiaomi,beryllium-tianma", "qcom,sdm845";
+};
+
+&display_panel {
+	compatible = "tianma,fhd-video";
+	status = "okay";
+};
-- 
2.37.2

