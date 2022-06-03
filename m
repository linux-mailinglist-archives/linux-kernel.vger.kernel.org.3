Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66C553C777
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243013AbiFCJYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243003AbiFCJYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:24:32 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7618F3A1A9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 02:24:30 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id o15so7818977ljp.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 02:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tpu4e6Tsi3OmnWPgulA1jvkS03wWrtbDigf/xuLhW00=;
        b=NpNnQezQYCyV6S3ekD1A4pX1wxEID/EwaDPAMUYveMjCaWoyUrO4SYsVtMj+zgjuoU
         fR3zH+X03ZhtufIeO7nU8GD939xhLKn5KzX38w2B7TdeYBYviL6knS9+1th9VWdJwWrC
         cM/avtVhwbXohNHww481KnICboEn4DhiuRIziedkw7PzHzNypdzFjqQPPWiun/enTHmv
         wnjIOPg+MiW1kbVIzPQr8Wp6bflB5OtfrnGtZ294KCWoL4g2qBUt0wJ7Z1k2O8SdkWLp
         JkO1e8mKHPg1WODr4Ec58J8bqpktgLWY0rx5dzNesctgALK8KGAr3fk1yISK8Olmfvja
         7uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tpu4e6Tsi3OmnWPgulA1jvkS03wWrtbDigf/xuLhW00=;
        b=0PEHRNw9d4iV2+a92XbausmR5GDqaJfIDPU3F0geaHKkMYFZ8qjjF5zLktKzCxtQj3
         YtdhcBlaafY7BkX+iqJflwQNwXDRkBtwCMJkHdmO2CnZTD94/FTEYrWOBYJSVThFW0xy
         WEhp4ExJy6XQ7+2GLubDFtUzRl/XS2YVvmY8u3AJvJqxBttJpMCE9/SURSscsNVQ+Ohu
         SiJLdecv5XcdoCKqk0wOdLmmL64jTsEMTf6XvikVV+ZuN+RHKIgmCx3IRLOaCScNOr+O
         zojPJkyUWJrF+G5QKHgxWbv69nSrEGVuZyUo/0qh1omu2oVDQhyR9qf0/ekRjBQncgYm
         zBcA==
X-Gm-Message-State: AOAM530vifpPbnIo+nupeRmvsPbbhaWFk+cJpFnAP3g+jc9aknm0xhzk
        /Ed5+ZvjyBedFIbBmXyTdFkBaQ==
X-Google-Smtp-Source: ABdhPJxL5dx5oS8uVRLqjW6ypxjzwJ1bUtmGE5vf2et5FTGdGN6JZkqShOWlXOTxCmRP0ZzdtQ3dHA==
X-Received: by 2002:a2e:b0d6:0:b0:255:7d62:d75c with SMTP id g22-20020a2eb0d6000000b002557d62d75cmr1957870ljl.118.1654248268846;
        Fri, 03 Jun 2022 02:24:28 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-204-250.toya.net.pl. [31.182.204.250])
        by smtp.gmail.com with ESMTPSA id e10-20020a2e9e0a000000b002555dd9c20fsm1224434ljk.20.2022.06.03.02.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 02:24:28 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dinguyen@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amstan@chromium.org,
        upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/5] ARM: dts: socfpga: Change Mercury+ AA1 dts to dtsi
Date:   Fri,  3 Jun 2022 11:23:50 +0200
Message-Id: <20220603092354.141927-2-pan@semihalf.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220603092354.141927-1-pan@semihalf.com>
References: <20220603092354.141927-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mercury+ AA1 is not a standalone board, rather it's a module
with an Arria 10 SoC. Remove status = "okay" and i2c aliases, as they
are routed to the base board and should be enabled from there.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/Makefile                    |  1 -
 ...1.dts => socfpga_arria10_mercury_aa1.dtsi} | 28 -------------------
 2 files changed, 29 deletions(-)
 rename arch/arm/boot/dts/{socfpga_arria10_mercury_aa1.dts => socfpga_arria10_mercury_aa1.dtsi} (84%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index edfbedaa6168..023c8b4ba45c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1146,7 +1146,6 @@ dtb-$(CONFIG_ARCH_S5PV210) += \
 	s5pv210-torbreck.dtb
 dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += \
 	socfpga_arria5_socdk.dtb \
-	socfpga_arria10_mercury_aa1.dtb \
 	socfpga_arria10_socdk_nand.dtb \
 	socfpga_arria10_socdk_qspi.dtb \
 	socfpga_arria10_socdk_sdmmc.dtb \
diff --git a/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
similarity index 84%
rename from arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts
rename to arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
index a75c059b6727..4b21351f2694 100644
--- a/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts
+++ b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-/dts-v1/;
 
 #include "socfpga_arria10.dtsi"
 
@@ -11,8 +10,6 @@ / {
 	aliases {
 		ethernet0 = &gmac0;
 		serial1 = &uart1;
-		i2c0 = &i2c0;
-		i2c1 = &i2c1;
 	};
 
 	memory@0 {
@@ -43,7 +40,6 @@ &gmac0 {
 	phy-addr = <0xffffffff>; /* probe for phy addr */
 
 	max-frame-size = <3800>;
-	status = "okay";
 
 	phy-handle = <&phy3>;
 
@@ -69,22 +65,8 @@ phy3: ethernet-phy@3 {
 	};
 };
 
-&gpio0 {
-	status = "okay";
-};
-
-&gpio1 {
-	status = "okay";
-};
-
-&gpio2 {
-	status = "okay";
-};
-
 &i2c1 {
-	status = "okay";
 	isl12022: isl12022@6f {
-		status = "okay";
 		compatible = "isil,isl12022";
 		reg = <0x6f>;
 	};
@@ -92,7 +74,6 @@ isl12022: isl12022@6f {
 
 /* Following mappings are taken from arria10 socdk dts */
 &mmc {
-	status = "okay";
 	cap-sd-highspeed;
 	broken-cd;
 	bus-width = <4>;
@@ -101,12 +82,3 @@ &mmc {
 &osc1 {
 	clock-frequency = <33330000>;
 };
-
-&uart1 {
-	status = "okay";
-};
-
-&usb0 {
-	status = "okay";
-	dr_mode = "host";
-};
-- 
2.36.1.255.ge46751e96f-goog

