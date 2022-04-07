Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753DE4F81CF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344074AbiDGOgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344058AbiDGOfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:35:19 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65B91AE3FD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:33:18 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id ot30so11173491ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=deYcd73u1EhKyJcYQ9j7yr80yzbyfraQrPNmCBZemxk=;
        b=FygBkBxumA/U2oeWmN2ccLIHZdubNyHkGVwevnFSh/a73mrmBM2pduFBlWnCIFHJYi
         G4FbWCaq5m3/hgtFLwHPlHww3iYZibnxWrjUS/MQ8vNUQVKPy4JEI16M8FwACRTW0WnN
         EOvkQYe4Aujn9dE9p6XMbQ4t2FdFU6j985XaybxcKNPKHs2puMWbDPEZNFKvYOtvdAAf
         VAjfymFxn9jnzHaSYP6B3T2zpVtcC7Qf4tBeFS88zu4in6RtvB6mYvqsp2PkdqYOh9++
         U4lNtFHrWvgE8EOfmNQrDr0csuhHf9orFaxAIRwF+VQN1x0A//xdO6YgtUDtNXbPIWem
         Wm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=deYcd73u1EhKyJcYQ9j7yr80yzbyfraQrPNmCBZemxk=;
        b=64AQSJgWG6yFLMf02Jg7KP0rCMOUr6MDvlIIubW/jAyCp8DB0nVd9dv8a/xJTnsVhr
         Sl+j8K481yOEF0e2O4YpdQTFo9fgbtX6BxyaN9HtSNx7dmTvUThStirSMJcobC6no6nK
         0rJDJ3+BDYkfifal/iiH9JddeCsNUEP8JMCTMEw/b4R6FQFoysLkvNixskzYp9XnJ0l8
         D/6c87qc7tEFpxmCF5s08JQQDYK9XCK/7jjtPgVDvrXkT/4KLewF0bRYGZ13y9W4xMsS
         BYzpPHWD+32i3U7I9y25h0Gh1p+94dCXn74pvV9t2hl1LTPQIJJ8Ns4hjOEvkYMWjh8t
         7LCQ==
X-Gm-Message-State: AOAM532Mtp5sKXXsEiM+FMUVlnn8G/vjv7n713UgjAb2iXNiXk/AoMDc
        9Djh3wvRk3cIvdDPHzopUgw9yg==
X-Google-Smtp-Source: ABdhPJyRvvMBgSDzdUUw5OErNuL/yMlO6NqgfK6Q3GDBpllbDVGKJlEH2/OOhCnyFMnWsCy65QTF2Q==
X-Received: by 2002:a17:907:7f0f:b0:6e4:c15e:7751 with SMTP id qf15-20020a1709077f0f00b006e4c15e7751mr13830915ejc.266.1649341937047;
        Thu, 07 Apr 2022 07:32:17 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id n9-20020a05640205c900b00418d79d4a61sm9602135edx.97.2022.04.07.07.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:32:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: broadcom: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 16:32:11 +0200
Message-Id: <20220407143211.295271-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407143211.295271-1-krzysztof.kozlowski@linaro.org>
References: <20220407143211.295271-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and SPI NOR dtschema expects "flash".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts  | 2 +-
 arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts  | 2 +-
 arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
index 12a4b1c03390..e34172e3117e 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
@@ -203,7 +203,7 @@ nand_sel: nand_sel {
 
 &qspi {
 	bspi-sel = <0>;
-	flash: m25p80@0 {
+	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "m25p80";
diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts b/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts
index f00c21e0767e..7bf26f3e36bf 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2-xmc.dts
@@ -146,7 +146,7 @@ &sata {
 };
 
 &qspi {
-	flash: m25p80@0 {
+	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "m25p80";
diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts b/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
index 77efa28c4dd5..dfac910a45d6 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
@@ -61,7 +61,7 @@ &ssp0 {
 	cs-gpios = <&gpio_hsls 34 0>;
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <20000000>;
@@ -76,7 +76,7 @@ &ssp1 {
 	cs-gpios = <&gpio_hsls 96 0>;
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <20000000>;
-- 
2.32.0

