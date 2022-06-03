Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A566253C5AA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 09:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242306AbiFCHCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 03:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242332AbiFCHBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 03:01:40 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B1D36688
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 23:59:26 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l18so192864lje.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 23:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UfwBRuu4ZM72mhs6ACHC3c3G4LBBG//hhQB7GRYTpTo=;
        b=USv+GhMboj2lAxWfNUSe0iScIubFVAj+yQq/JocetYGClDaPJnhUJ6iT1SOrTVoUmt
         w0w2wGhGtqH8kpGEW0WY6k54zslFbFFJ8zRKzi/GvNPUX/Ihun0UB8QOKTe5XIaZlXG7
         NoVBIAE3y0WDEv9sH4mLQjROSHP14ErS9ZKHNnOh5ISkOvWgOi5p8HFo92d1RD3AP83z
         PFybXiKrFc5zu9HwO9tLVEJqBlUVRf5kAxSLtmhoxSrn+WjFsyFHzzYQnlyoMCPzUkA1
         wGdwWjXkPWcRDT8vUoK/E0qM6UUEVHDwYzexo9pJxNTAeN6Teigi8PZQbJTBW15VfXQy
         aEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UfwBRuu4ZM72mhs6ACHC3c3G4LBBG//hhQB7GRYTpTo=;
        b=ZJ+KOFjZ0lvxieRzjUOeMuTrzX6nxjqNBSUPyrLsy1blFerMiCTo+SaC4XdXKqf+29
         8XTZ4A4UkYBI3clqZVHwH4h4TiW0z6Q6yExd0E21VHr94WvCpvzcHAlw60P5h3wb9q84
         HEghz05ctDpl6ljlb5ec4F7hoHGrwGhDOASJbqiopXXZ28S54K7WWOe7XxKZ+L4/tKFq
         YztwQECIQEudmAZhdtxLhkdAH/aiilZDT3UlZITjQzqSI6C+pMiggav6NZdKnP/fc1CG
         PVum8+b4jYSxRNkWYJD6LC/IO6AL9KuAo9TVpatRB+ILiM0qhZvAQiyfYbheJzvvc3ky
         UQgw==
X-Gm-Message-State: AOAM533Hgq81Ixm23YenPllrA2MNXtBoEXvTO+Who7jLAM/dn5BQx/cL
        gQna3Gek4u/6TiIellkqPt0QnA==
X-Google-Smtp-Source: ABdhPJwIDJQ9CWAfQyIdRk8vfL6WkSfsvZgwkikbXxTyggbh4o9LLRzARA0ua9afMswiXEcqDSXMJQ==
X-Received: by 2002:a2e:91d1:0:b0:255:7676:7547 with SMTP id u17-20020a2e91d1000000b0025576767547mr3636414ljg.207.1654239564538;
        Thu, 02 Jun 2022 23:59:24 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-204-250.toya.net.pl. [31.182.204.250])
        by smtp.gmail.com with ESMTPSA id b8-20020ac247e8000000b004786321c697sm1056447lfp.138.2022.06.02.23.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 23:59:24 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dinguyen@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amstan@chromium.org,
        upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH v3 1/5] ARM: dts: socfpga: Change Mercury+ AA1 dts to dtsi
Date:   Fri,  3 Jun 2022 08:58:12 +0200
Message-Id: <20220603065816.87952-2-pan@semihalf.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220603065816.87952-1-pan@semihalf.com>
References: <20220603065816.87952-1-pan@semihalf.com>
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

