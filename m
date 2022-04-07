Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFCF4F81B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbiDGOeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343998AbiDGOdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:33:50 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A2D195D98
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:31:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n6so11174550ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xTGO8+ir1L12EdGW7G5ZCf2MEbhe7eIKjfTUHFlBJSE=;
        b=vOsBgT/5rRHAT2BpRTMGXU21rfA/nneTbwCCcs0YZUJt7weUxftILT73wOBNSkr/Qw
         bIz8+HkpEqIC1BvCtak4JgB6sR5f6q5DN2prJ2YhmfhBWErg2/qvk0pQz3AcyChQs5P/
         7dVYMTo40YOBmWOavmAhObUpdOCKMKoFZ6kKlHU3hKncSdUtBzy1MpFEoxH/VwGjcYYI
         +7g3v5h9e94dMp4U3xbdq977FYmr1i4Un+6QA0WHkQ/GNtaYqiLTs8/1D/39D/BV+It2
         OxQejeUUoh6D7Omu/kgMj9RCqjxfGCwancJhQuS/0mRGQQCA+aJ3aszJn1WgWJcnfW7t
         mwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xTGO8+ir1L12EdGW7G5ZCf2MEbhe7eIKjfTUHFlBJSE=;
        b=zi7TBtphblByfq9wJ8EQ3/c2tSMi9g0loUUfxFOSQUi1SthI6QqAm28y7isDLcsZ8J
         vmvqJL+wdxeGaYQ7Zu7yNgaWj1T03weZXwqJkaEUiAbzOTTN6BxMK/brDl59nl/ZSKEN
         B7+SIuHc8nyTeHDZZmtb+ihdfAD+oP/0XJaebpg4YCtkdxi9uTaINd4ft/F2+/B0EX6v
         v8Wz4DEKsf70zFOWWiW/+Z5lcj9tnygu9OLBSfXpUO/tPOhNxYg4Ksl+phqgjEp0OyUG
         qd9icAUG0JAwLIV1Tn7111HpLbqaSBhv2oNprRuLS5fYk9ElehEeoLQkzEqErNIBnQxq
         KTOg==
X-Gm-Message-State: AOAM532XDLtdAJhS4tTU52P1so6+34pNVzKjy0EwVuefRkuBr7Ll+1QN
        DwgSD1kp8D2WuHPEi8IJjgZJkNVRH/+9f116
X-Google-Smtp-Source: ABdhPJwEn2r3VlFitU4tuiJKYVwnXyd/xf6qDPbOCckKaFcucuivYiiCw9SjakKG3xcScH1mjI3mnA==
X-Received: by 2002:a17:907:3c81:b0:6e6:9387:3d74 with SMTP id gl1-20020a1709073c8100b006e693873d74mr13812853ejc.589.1649341904381;
        Thu, 07 Apr 2022 07:31:44 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id jg15-20020a170907970f00b006e0466dcc42sm7679473ejc.134.2022.04.07.07.31.43
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
Subject: [PATCH 2/2] ARM: dts: keystone: fix case in SPI NOR node compatible
Date:   Thu,  7 Apr 2022 16:31:40 +0200
Message-Id: <20220407143140.295092-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407143140.295092-1-krzysztof.kozlowski@linaro.org>
References: <20220407143140.295092-1-krzysztof.kozlowski@linaro.org>
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

Vendor prefix in compatible should be lower-case.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/keystone-k2e-evm.dts  | 2 +-
 arch/arm/boot/dts/keystone-k2hk-evm.dts | 2 +-
 arch/arm/boot/dts/keystone-k2l-evm.dts  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2e-evm.dts b/arch/arm/boot/dts/keystone-k2e-evm.dts
index 8f49883a675e..9e507293a8d7 100644
--- a/arch/arm/boot/dts/keystone-k2e-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2e-evm.dts
@@ -140,7 +140,7 @@ &spi0 {
 	nor_flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "Micron,n25q128a11";
+		compatible = "micron,n25q128a11";
 		spi-max-frequency = <54000000>;
 		m25p,fast-read;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/keystone-k2hk-evm.dts b/arch/arm/boot/dts/keystone-k2hk-evm.dts
index f968af0bfad3..1a1a49c19a19 100644
--- a/arch/arm/boot/dts/keystone-k2hk-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2hk-evm.dts
@@ -164,7 +164,7 @@ &spi0 {
 	nor_flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "Micron,n25q128a11";
+		compatible = "micron,n25q128a11";
 		spi-max-frequency = <54000000>;
 		m25p,fast-read;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/keystone-k2l-evm.dts b/arch/arm/boot/dts/keystone-k2l-evm.dts
index 32619b3c5804..06d55b89170d 100644
--- a/arch/arm/boot/dts/keystone-k2l-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2l-evm.dts
@@ -113,7 +113,7 @@ &spi0 {
 	nor_flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "Micron,n25q128a11";
+		compatible = "micron,n25q128a11";
 		spi-max-frequency = <54000000>;
 		m25p,fast-read;
 		reg = <0>;
-- 
2.32.0

