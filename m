Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86563537B12
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 15:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbiE3NJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 09:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbiE3NIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:08:54 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D9470904
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:08:52 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id l30so11585355lfj.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xhBF+mq2nRVeP17buWzIlAWcN9E9F7b4oLu8aafORZA=;
        b=ID4SCZeXTdBpxCoDaFFSZBoc7VbsiEM49mXCwnC8Wvxv8CkiXPTxj5KdxmADQvr3dd
         KqjnF9xqxcOk+pvbZp/Jq8KWzTWv0MUZf2I9eTiKc8L7bSdYibI3t30V4W54DF7Uj2LL
         yE9f2uWFVUMDWQfEUXxeGX6MmKVBdSFzCh2HVlNdpdI0uWkAxIRG5ADg6Wl0D/u1lqBY
         2xPd1Xles83SKc5Udm9V26XJfbu1OgRkkXH3WY5X1/NBjWAOrWQRs20iWzW3ok8U0dt6
         6uWvfKdGeTHcWd2/uxsa0Kz3sZy2TKVp0U/2SjZH/ei/1U3wbYEHz8NCK+Nifw6zaQFT
         8aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xhBF+mq2nRVeP17buWzIlAWcN9E9F7b4oLu8aafORZA=;
        b=gQlAX2k1AS9AsUvdPAaT0fp8EA0VEnvdLmMT5wbhFAN46uJjEmmcuyNwS/4ViDJT5F
         7CM+2sTkK1sIub28hUJ/JJUbF8UpElkV0BIfDliDihR9D7I/6s2PCMdvICZ7qaLeszsp
         UbXLUNuA8n8YKEwVnSgSvsQCSOK+IfG4TtMCbx3GfCx32VUgBlPlxbLPpDQx+Sz6t+RO
         aVt+CBFkVv8vd+M7IHbOS3mCq5QVnM/yoDpOwx1CAsQpGxx5YhJJoY/mrp1tbPrpSomX
         ZQCq/aYRZw2eCLy7KXSHme/sCXacRub2jQ2YnuA3lu3P+YTWaZvPqUMjm1B3/kopmeU0
         cwxg==
X-Gm-Message-State: AOAM5322tUXMwK7SdV8+2zT2g0UgytwoUujQNhkmHrYcaUfqtCTiVtnZ
        +8Y326oNXVqqEuo6hrL1Zez96Q==
X-Google-Smtp-Source: ABdhPJyksoTM977XMM2Gk9evMv3u2OuHg7XZe5tJpgGPDRKmXVL9MYvNTzPzp3wm6bJxPzegG1UTHg==
X-Received: by 2002:a19:2d19:0:b0:478:ae7c:cd5d with SMTP id k25-20020a192d19000000b00478ae7ccd5dmr17221585lfj.385.1653916130953;
        Mon, 30 May 2022 06:08:50 -0700 (PDT)
Received: from panikiel.wifi.semihalf.net ([83.142.187.86])
        by smtp.gmail.com with ESMTPSA id d22-20020ac25456000000b00477a7c8a0f0sm2295701lfn.295.2022.05.30.06.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 06:08:49 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>,
        Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH 2/3] dts: socfpga: Add Google Chameleon v3 devicetree
Date:   Mon, 30 May 2022 15:08:38 +0200
Message-Id: <20220530130839.120710-3-pan@semihalf.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220530130839.120710-1-pan@semihalf.com>
References: <20220530130839.120710-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree for the Google Chameleon v3 board.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
Signed-off-by: Alexandru M Stan <amstan@chromium.org>
---
 arch/arm/boot/dts/Makefile                    |  1 +
 .../boot/dts/socfpga_arria10_chameleonv3.dts  | 90 +++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 023c8b4ba45c..9417106d3289 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1146,6 +1146,7 @@ dtb-$(CONFIG_ARCH_S5PV210) += \
 	s5pv210-torbreck.dtb
 dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += \
 	socfpga_arria5_socdk.dtb \
+	socfpga_arria10_chameleonv3.dtb \
 	socfpga_arria10_socdk_nand.dtb \
 	socfpga_arria10_socdk_qspi.dtb \
 	socfpga_arria10_socdk_sdmmc.dtb \
diff --git a/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts b/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
new file mode 100644
index 000000000000..988cc445438e
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 Google LLC
+ */
+/dts-v1/;
+#include "socfpga_arria10_mercury_aa1.dtsi"
+
+/ {
+	model = "Google Chameleon V3";
+	compatible = "google,chameleon-v3",
+		     "altr,socfpga-arria10", "altr,socfpga";
+
+	aliases {
+		serial0 = &uart0;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+	};
+};
+
+&gmac0 {
+	status = "okay";
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&gpio2 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	ssm2603: ssm2603@1a {
+		compatible = "adi,ssm2603";
+		reg = <0x1a>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	u80: u80@21 {
+		compatible = "nxp,pca9535";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"SOM_AUD_MUTE",
+			"DP1_OUT_CEC_EN",
+			"DP2_OUT_CEC_EN",
+			"DP1_SOM_PS8469_CAD",
+			"DPD_SOM_PS8469_CAD",
+			"DP_OUT_PWR_EN",
+			"STM32_RST_L",
+			"STM32_BOOT0",
+
+			"FPGA_PROT",
+			"STM32_FPGA_COMM0",
+			"TP119",
+			"TP120",
+			"TP121",
+			"TP122",
+			"TP123",
+			"TP124";
+	};
+};
+
+&mmc {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+};
-- 
2.36.1.124.g0e6072fb45-goog

