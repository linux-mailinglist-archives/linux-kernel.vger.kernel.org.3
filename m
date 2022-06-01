Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22D453AA74
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355763AbiFAPsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354843AbiFAPrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:47:46 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD5531223
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:47:45 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i10so3499476lfj.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 08:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y3JvSDWyNzZ3ubMu+5VkO/66cKXhEY5f22UYF/SL+Mg=;
        b=Vhh2E7NNBEcv7+QVjiVBJmG8TCrBPdxgdnYQJ3YWT/7igbMMDlzAqIUzfy3Vrv8aN2
         KoVnWp3dlV7NAsUrzB5c+hPHcxZM+zfUZKDBllQG7CVwWTEh0sScluIjVIGqyvWBrtcN
         aoUEifsKbNzpETq8OkaFf6unIfaAkau07wNjJAhTfMJFNLRW4l6Vu4AyhVoXhnrfjJ+F
         MyfqIzSUP659htUlP7mBvN2Lq25A0ZU/K5ZdZOaht8BIPUl+LWY1tUcSrSxsw1ahTDgN
         NTILbXSzjLkl62pmtrUk2QhnB4G05WAq/VJjQnIo6+qgQ8OSOx0NECnHB22lBtQvUBe9
         XpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y3JvSDWyNzZ3ubMu+5VkO/66cKXhEY5f22UYF/SL+Mg=;
        b=RL8/QMYm/y80F7jflU+aGy176Jpl9Uz+LwmiDOpit8qllKgVOpCL21y3G7YQ9CW41D
         xQse2pHqaxY/nPtQVF9WQ259wHlqZ3yTg1KEJ2ghQWoLi0IbHAAAlVjnC48Iyjw4xX/s
         AbRNRi+Y2LpP+jx0Wq14yx6AeQb4bNgtyxvL72fZQuk3syP5XcOce+CPGK2rQPDYRuaK
         dh6CkaYlqIHWK5D3ZbO2CtkbroRMU2Wrh9e/9G9d6Exe1OraBFIFr5Mmr0WOCi2SNwq7
         1lceWMTKt3ZQM1Ynn32ETyn7LHQSIMuQ9EchXKaN7w3OE795ahBFGxYkOzCHE3zzLVLb
         PGGg==
X-Gm-Message-State: AOAM531BxGZOoPAlenlrWqXP/YrMZLWc1pSXwJNuJZ3VszXG2MilyELn
        7BONeXApHhsVzM7Wkd2kn5LkqQ==
X-Google-Smtp-Source: ABdhPJyz31uUXCHhwnTbXJyTM8r9rEhWOAlYmT/8lkQ3scCemE7RzYx9SUMpUL5FgRRdnLPpnVMKfg==
X-Received: by 2002:a05:6512:3130:b0:479:2e0:631b with SMTP id p16-20020a056512313000b0047902e0631bmr2903593lfd.561.1654098464757;
        Wed, 01 Jun 2022 08:47:44 -0700 (PDT)
Received: from panikiel.wifi.semihalf.net ([83.142.187.86])
        by smtp.gmail.com with ESMTPSA id f10-20020a19380a000000b00478ad871b25sm431219lfa.145.2022.06.01.08.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 08:47:44 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        amstan@chromium.org, upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH v2 4/5] ARM: dts: socfpga: Add Google Chameleon v3 devicetree
Date:   Wed,  1 Jun 2022 17:46:46 +0200
Message-Id: <20220601154647.80071-5-pan@semihalf.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220601154647.80071-1-pan@semihalf.com>
References: <20220601154647.80071-1-pan@semihalf.com>
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
index 000000000000..422d00cd4c74
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
+	compatible = "google,chameleon-v3", "enclustra,mercury-aa1",
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
+	ssm2603: audio-codec@1a {
+		compatible = "adi,ssm2603";
+		reg = <0x1a>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	u80: gpio@21 {
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
2.36.1.255.ge46751e96f-goog

