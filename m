Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66DF4F81D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344045AbiDGOfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344082AbiDGOfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:35:34 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815E01B7572
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:33:19 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id bq8so11225827ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZhILZayX6pXffknKnd7HfQgbBKm0wpl0VHuQYrvMsZ0=;
        b=oW2QY6FhGdQmhBgp/MADoYPdud7e2/D0LNs/qdWYbhbNaEcAPcVX5b3hhAJY3VQ5b2
         7gC62rgwdrtW0dN34ZqnDI949PTioIaYWOmD8g9DRjeJOFGDNtUkU/2K+DkcBusmwsHh
         qgNCoe8enlFYxi3NEz+kwrxqVILx9Ub4fvDS3bmFlkjWL8vnmVpp069M6FBYtVW5xyrE
         HZjS6fs5ZQEKL5sl4QfpEkSJ6vRUmOJhHjbOOO/pm+eRDIIpCcBvIsH/6KT27ZMUg4Ee
         2y+5/E5s2YMnRNLGT8OS6ZwKzo3/BQIwG8BulPimXxSeVP3UoSNxqEA6Kbr4TzFqlNZg
         4/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZhILZayX6pXffknKnd7HfQgbBKm0wpl0VHuQYrvMsZ0=;
        b=U6QKoM0NzyKrpk6fFoS5pDlDsnEguj6SKdnUJ25plenwCLyPKBqSvsHN4qjn0eu5PZ
         Ai4IW93IXGXohRTA9loKxDYpsvKjAWGlTjzrkvfUBlXgyhdFMInX0dROvsXD966LkYnA
         VuQOm9HfTRIkkj3spO/jBpJVGHduAIW6LCqDa7edY5vtIWD3fU8qnOCgtJmX4gF4b+Uv
         3khXagAVDVRljnkb2dNTb2FIwT2QgPC0HynibZL8cfk6KeRPZdGBbz0hVX+f9xrVfDLP
         ayuhC/AyMIKMGGW4yQI+jtpWNhPysSBQqUg743BV3trnjcu4h+uhVKJdY4ymqDKPnenu
         uSFw==
X-Gm-Message-State: AOAM531bxEVyxx/mOSkIcziycuhWV+5GKGOT3gcAatih4i9WFqCkQHVh
        Tx9eGc62vgpFXAqY2x7TbwZGEw==
X-Google-Smtp-Source: ABdhPJzuh9XHvvGbe8ZPu/7duVfCJ0rW8LwjHVbbAzHzQRh2mnP/nQ+KvF7KNjIa4gr2QrU8GxcQVw==
X-Received: by 2002:a17:907:3f92:b0:6e7:2ad3:a92b with SMTP id hr18-20020a1709073f9200b006e72ad3a92bmr14282064ejc.239.1649341936092;
        Thu, 07 Apr 2022 07:32:16 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id n9-20020a05640205c900b00418d79d4a61sm9602135edx.97.2022.04.07.07.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:32:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: broadcom: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 16:32:10 +0200
Message-Id: <20220407143211.295271-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and SPI NOR dtschema expects "flash".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts | 2 +-
 arch/arm/boot/dts/bcm958522er.dts                 | 2 +-
 arch/arm/boot/dts/bcm958525er.dts                 | 2 +-
 arch/arm/boot/dts/bcm958525xmc.dts                | 2 +-
 arch/arm/boot/dts/bcm958622hr.dts                 | 2 +-
 arch/arm/boot/dts/bcm958623hr.dts                 | 2 +-
 arch/arm/boot/dts/bcm958625hr.dts                 | 2 +-
 arch/arm/boot/dts/bcm958625k.dts                  | 2 +-
 arch/arm/boot/dts/bcm988312hr.dts                 | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts b/arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts
index 2e7fda9b998c..975f854f652f 100644
--- a/arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts
+++ b/arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts
@@ -34,7 +34,7 @@ &qspi {
 	status = "okay";
 	bspi-sel = <0>;
 
-	flash: m25p80@0 {
+	flash: flash@0 {
 		compatible = "m25p80";
 		reg = <0>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/bcm958522er.dts b/arch/arm/boot/dts/bcm958522er.dts
index 60376b62cd5f..15f023656df0 100644
--- a/arch/arm/boot/dts/bcm958522er.dts
+++ b/arch/arm/boot/dts/bcm958522er.dts
@@ -136,7 +136,7 @@ nand_sel: nand_sel {
 &qspi {
 	status = "okay";
 	bspi-sel = <0>;
-	flash: m25p80@0 {
+	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "m25p80";
diff --git a/arch/arm/boot/dts/bcm958525er.dts b/arch/arm/boot/dts/bcm958525er.dts
index 8eeb319f5b54..9b9c225a1fb3 100644
--- a/arch/arm/boot/dts/bcm958525er.dts
+++ b/arch/arm/boot/dts/bcm958525er.dts
@@ -136,7 +136,7 @@ nand_sel: nand_sel {
 &qspi {
 	status = "okay";
 	bspi-sel = <0>;
-	flash: m25p80@0 {
+	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "m25p80";
diff --git a/arch/arm/boot/dts/bcm958525xmc.dts b/arch/arm/boot/dts/bcm958525xmc.dts
index dc86d5a91292..ca9311452739 100644
--- a/arch/arm/boot/dts/bcm958525xmc.dts
+++ b/arch/arm/boot/dts/bcm958525xmc.dts
@@ -152,7 +152,7 @@ nand_sel: nand_sel {
 &qspi {
 	status = "okay";
 	bspi-sel = <0>;
-	flash: m25p80@0 {
+	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "m25p80";
diff --git a/arch/arm/boot/dts/bcm958622hr.dts b/arch/arm/boot/dts/bcm958622hr.dts
index c457e53d886e..9db3c851451a 100644
--- a/arch/arm/boot/dts/bcm958622hr.dts
+++ b/arch/arm/boot/dts/bcm958622hr.dts
@@ -140,7 +140,7 @@ nand_sel: nand_sel {
 &qspi {
 	status = "okay";
 	bspi-sel = <0>;
-	flash: m25p80@0 {
+	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "m25p80";
diff --git a/arch/arm/boot/dts/bcm958623hr.dts b/arch/arm/boot/dts/bcm958623hr.dts
index c06871915a1c..32786e7c4e12 100644
--- a/arch/arm/boot/dts/bcm958623hr.dts
+++ b/arch/arm/boot/dts/bcm958623hr.dts
@@ -144,7 +144,7 @@ &sata_phy0 {
 &qspi {
 	status = "okay";
 	bspi-sel = <0>;
-	flash: m25p80@0 {
+	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "m25p80";
diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index b22fc6624ae4..74263d98de73 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -151,7 +151,7 @@ nand_sel: nand_sel {
 &qspi {
 	status = "okay";
 	bspi-sel = <0>;
-	flash: m25p80@0 {
+	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "m25p80";
diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
index 0183f8965a74..69ebc7a913a7 100644
--- a/arch/arm/boot/dts/bcm958625k.dts
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -155,7 +155,7 @@ &pwm {
 &qspi {
 	status = "okay";
 	bspi-sel = <0>;
-	flash: m25p80@0 {
+	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "m25p80";
diff --git a/arch/arm/boot/dts/bcm988312hr.dts b/arch/arm/boot/dts/bcm988312hr.dts
index 007e34715956..e96bc3f2d5cf 100644
--- a/arch/arm/boot/dts/bcm988312hr.dts
+++ b/arch/arm/boot/dts/bcm988312hr.dts
@@ -140,7 +140,7 @@ nand_sel: nand_sel {
 &qspi {
 	status = "okay";
 	bspi-sel = <0>;
-	flash: m25p80@0 {
+	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "m25p80";
-- 
2.32.0

