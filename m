Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C134F81B4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343973AbiDGOeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343992AbiDGOdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:33:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01991959D6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:31:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l26so11295884ejx.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3c4ULYqb2r78UM7M6kBpgVt9ArEFqjKiJDG/EUfI7EM=;
        b=VkRRhO5Htk9J8iPE4fwyidyVP9kGsvQt1jd+50DCDtNh740qsQjPk+0esm7Ho2m2yQ
         llHL49kjOgc23CDPyKBIAKRuPwQzMpvz7HFy3djOsdYGNx2tB9toRQujtFCQlgQkzaMU
         gYmByiZAdLFs/RTE7QDym0AZCPvRqzfPCJKHEjELLzWgffkQJTcYsBJtFemM7qe07FJ4
         GBC0Xjdv6BDTprAdsucm/VtTzWb3UusRHgA5gFaZsRVzBz4i6dlP2qv5XKpU8W9W3Qg0
         a01ZzfZsz18AlZWjOujDAHlELzV04rNpF75FvF5ADvTispATTNk8oguhxomE+WqRpKXN
         p6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3c4ULYqb2r78UM7M6kBpgVt9ArEFqjKiJDG/EUfI7EM=;
        b=tGg+kpfiEmrzcdFBI/CgIXkCyx4NysN3ZU24JqV0EpHZnXwBOMMucxxhnReY/Iz/oD
         Mqy4Po1z/hugLzHxWa3KGY3+uekJpbPxwBfKJ8dBLG6JyCPA2WFHfYmSDiQOlycxh/yv
         x+2K+a5XlGrGZ+/jbjXTwdgw3VKhcJIpGDnT6CnSGLWmW3SODiVfiKgMxOAAZ6s7tApo
         T1jAUOwx/c8HGMU+p7HYNEpiWbCsS4ehP24txcDqVVRX32B0LJwWZxqz2/gCP1vaeDWS
         T58gqC7Jl0TdDRuvHIVHE9/+5FLWCVkHD6JNdBKmtwMyS71eyLVtvZL9nBq3lsmpR7Uk
         0Y/A==
X-Gm-Message-State: AOAM533jZEBMxH2OJDoa150MB9gwTN4rkwjhFZMmvYd8wnJqfixJWNVB
        nHHjASuOtRzC7oThO3waLOxAZQ==
X-Google-Smtp-Source: ABdhPJzByXzTdSf0FG7Hc6VhTH3jvhfUKEXHdN7edMmNurXCL6LekWQxJu3O24JVa2wP65vZv3oWeA==
X-Received: by 2002:a17:906:69d1:b0:6ce:7201:ec26 with SMTP id g17-20020a17090669d100b006ce7201ec26mr13584648ejs.105.1649341903463;
        Thu, 07 Apr 2022 07:31:43 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id jg15-20020a170907970f00b006e0466dcc42sm7679473ejc.134.2022.04.07.07.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:31:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: keystone: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 16:31:39 +0200
Message-Id: <20220407143140.295092-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and SPI NOR dtschema expects "flash".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/keystone-k2e-evm.dts  | 2 +-
 arch/arm/boot/dts/keystone-k2g-evm.dts  | 2 +-
 arch/arm/boot/dts/keystone-k2g-ice.dts  | 2 +-
 arch/arm/boot/dts/keystone-k2hk-evm.dts | 2 +-
 arch/arm/boot/dts/keystone-k2l-evm.dts  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2e-evm.dts b/arch/arm/boot/dts/keystone-k2e-evm.dts
index 66fec5f5d081..8f49883a675e 100644
--- a/arch/arm/boot/dts/keystone-k2e-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2e-evm.dts
@@ -137,7 +137,7 @@ partition@180000 {
 };
 
 &spi0 {
-	nor_flash: n25q128a11@0 {
+	nor_flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "Micron,n25q128a11";
diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index d800f26b6275..88be868cf71e 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -392,7 +392,7 @@ &qspi {
 	pinctrl-0 = <&qspi_pins>;
 	cdns,rclk-en;
 
-	flash0: m25p80@0 {
+	flash0: flash@0 {
 		compatible = "s25fl512s", "jedec,spi-nor";
 		reg = <0>;
 		spi-tx-bus-width = <1>;
diff --git a/arch/arm/boot/dts/keystone-k2g-ice.dts b/arch/arm/boot/dts/keystone-k2g-ice.dts
index 2a2d38cf0fff..bd84d7f0f2fe 100644
--- a/arch/arm/boot/dts/keystone-k2g-ice.dts
+++ b/arch/arm/boot/dts/keystone-k2g-ice.dts
@@ -325,7 +325,7 @@ &qspi {
 	cdns,rclk-en;
 	status = "okay";
 
-	flash0: m25p80@0 {
+	flash0: flash@0 {
 		compatible = "s25fl256s1", "jedec,spi-nor";
 		reg = <0>;
 		spi-tx-bus-width = <1>;
diff --git a/arch/arm/boot/dts/keystone-k2hk-evm.dts b/arch/arm/boot/dts/keystone-k2hk-evm.dts
index ad4e22afe133..f968af0bfad3 100644
--- a/arch/arm/boot/dts/keystone-k2hk-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2hk-evm.dts
@@ -161,7 +161,7 @@ dtt@50 {
 };
 
 &spi0 {
-	nor_flash: n25q128a11@0 {
+	nor_flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "Micron,n25q128a11";
diff --git a/arch/arm/boot/dts/keystone-k2l-evm.dts b/arch/arm/boot/dts/keystone-k2l-evm.dts
index e200533d26a4..32619b3c5804 100644
--- a/arch/arm/boot/dts/keystone-k2l-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2l-evm.dts
@@ -110,7 +110,7 @@ partition@180000 {
 };
 
 &spi0 {
-	nor_flash: n25q128a11@0 {
+	nor_flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "Micron,n25q128a11";
-- 
2.32.0

