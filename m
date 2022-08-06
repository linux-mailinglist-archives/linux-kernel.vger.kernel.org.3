Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F99B58B85A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 23:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiHFVCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 17:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiHFVCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 17:02:44 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101721180F;
        Sat,  6 Aug 2022 14:02:44 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r186so5468559pgr.2;
        Sat, 06 Aug 2022 14:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cwBgkJUZDFQk22Vxi4B/5USog1bwDuUOWtWL0DhbtIg=;
        b=VAbmlScAxnYrEw8uHKGvm0WO6+fcXvmUw5Wurdw/r8CXoOFC0ODPyHR3tiJfXU8eqh
         ni71EDVft0eB0pRwFdABgQzSjs70mhyvqUxabRp65XWAgjCECRsy84CGyXFXJrfTEIph
         fF+Cu12Zevap/GFw0E1AQpuG5XfA27uaHJMgdLmoel/8jyP/cG4SyXBQY5lUl6/sUE1e
         xyjS7Yh2L+sBx61rg0IKrv9RHCNqtCq0IeZ2gqM0y1n5SDOyjF0WVjTUkaOcVpW2EAfN
         cTmIh6kyBS0SiKCj3TSTcxYXwciI22xIdjb36F5v1o9hoh8nkC5YASwxX8ILVMLXP/b7
         VI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cwBgkJUZDFQk22Vxi4B/5USog1bwDuUOWtWL0DhbtIg=;
        b=4qm/J6mVh9lzCM9BudQON7FGaQNOlXqULn+a5m3YEQUqzrI5/O64je9FfzVJjQReRL
         BtYgdF3oFWiXciZB/BGvhKuOKQ0DQvUuz4Y5CV5UFiIZin5eQWcyZ6DSgS55I9bDorEu
         w81+OOfCUEV0605DloPbtzPEKoMjCrdiTzSkZNfY9CtO9v1pbmM6WWeP3ZldXxoHfRAs
         Aiarm/eBG1IO3RI2Io0jtYMKuHv6ejt+IUrORt91i3n/vpMhggI1aa54SDy7LDwpd5sg
         0TTcd15DmZkkGXjgnbyXQ5umdEPYOmsV3FKcZs9SV9FGADOCaVfoW9zmQYuPqr/dZ6IE
         vyvQ==
X-Gm-Message-State: ACgBeo2TVX2lWdXDcagOe4aICj73rkx7LUxSUlA9KlrONF6A4B5o+Y1C
        Z9yChElZq+/VIvrs980d/Gw=
X-Google-Smtp-Source: AA6agR6wlttnE4n3UDJLaMezhCFEVAHwfhxrsRyBRl2QcBkrwIpoQ94tKV7m0Oe1QZVJx0dcTha2RA==
X-Received: by 2002:a65:6b93:0:b0:41b:823d:416f with SMTP id d19-20020a656b93000000b0041b823d416fmr10256733pgw.262.1659819763540;
        Sat, 06 Aug 2022 14:02:43 -0700 (PDT)
Received: from fedora.. ([2405:201:e01d:6040:3f6e:eaa:537b:816f])
        by smtp.gmail.com with ESMTPSA id c203-20020a624ed4000000b0052ea306a1e8sm4538815pfb.210.2022.08.06.14.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 14:02:43 -0700 (PDT)
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH v3 1/2] arm64: dts: qcom: split beryllium dts into common dtsi and tianma dts
Date:   Sun,  7 Aug 2022 02:32:19 +0530
Message-Id: <20220806210220.31565-2-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220806210220.31565-1-joelselvaraj.oss@gmail.com>
References: <20220806210220.31565-1-joelselvaraj.oss@gmail.com>
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
sdm845-xiaomi-beryllium-tianma.dts

Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile                      |  2 +-
 ...ryllium.dts => sdm845-xiaomi-beryllium-common.dtsi} |  9 +++++----
 .../boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts   | 10 ++++++++++
 3 files changed, 16 insertions(+), 5 deletions(-)
 rename arch/arm64/boot/dts/qcom/{sdm845-xiaomi-beryllium.dts => sdm845-xiaomi-beryllium-common.dtsi} (98%)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 2f8aec2cc6db..02db413b228c 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -106,7 +106,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-oneplus-fajita.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akari.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akatsuki.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-apollo.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-tianma.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
similarity index 98%
rename from arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
rename to arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index d88dc07205f7..83edcb1171f5 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -221,8 +221,7 @@ &dsi0 {
 	status = "okay";
 	vdda-supply = <&vreg_l26a_1p2>;
 
-	panel@0 {
-		compatible = "tianma,fhd-video";
+	display_panel: panel@0 {
 		reg = <0>;
 		vddio-supply = <&vreg_l14a_1p8>;
 		vddpos-supply = <&lab>;
@@ -234,8 +233,10 @@ panel@0 {
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
@@ -243,7 +244,7 @@ tianma_nt36672a_in_0: endpoint {
 };
 
 &dsi0_out {
-	remote-endpoint = <&tianma_nt36672a_in_0>;
+	remote-endpoint = <&panel_in_0>;
 	data-lanes = <0 1 2 3>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
new file mode 100644
index 000000000000..fcbef5ad2909
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include "sdm845-xiaomi-beryllium-common.dtsi"
+
+&display_panel {
+	compatible = "tianma,fhd-video";
+	status = "okay";
+};
-- 
2.37.1

