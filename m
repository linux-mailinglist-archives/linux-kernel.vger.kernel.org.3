Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417024FE878
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 21:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348695AbiDLTKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 15:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240382AbiDLTKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:10:38 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C84318371;
        Tue, 12 Apr 2022 12:08:20 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c199so12835474qkg.4;
        Tue, 12 Apr 2022 12:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0umzI7dcNqCPGkKM4AfkCdjqy62DU/Gn3M5wYOh27O8=;
        b=BS9UHDc5tsLhhX7P38/FennKlpIGYY4fhtlUvZszeQQGPjjzaAsOkA9UGTBxGWqb2y
         NFAPCwEiFRVXkPGnMo7d9WoxNdijn6lOVyEluMXxHPpDm6K8JdF9bqPs4bBK9Ar+JcnC
         8GMMbp+WY5csg1hsZ7tmAyNfxN6E3V20a4qiHuAT384N6SROWBKIMR92vqVkSKK+8fLn
         a0/OR83LclGGfzeRsNCMsn0S3nWDrOHZ5OqBhrVJV3GnYLJUPin3xTY3EbV/Dri8z0Kt
         Z1ocBwg4XjUYqNw4RHUFFyJ/Eo6poELQvfy6tGn5suWphfQEqUJH3+O9HeRKKsuam44e
         ysfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0umzI7dcNqCPGkKM4AfkCdjqy62DU/Gn3M5wYOh27O8=;
        b=LyW/+bNe7DSLBuquBr2YuOK1XQK7Zdgi/ONnS8UA6TOQ7SZUMC9IF4JLHSYEeuv/w1
         NfjJOCfF9FWRUOzPd1bYw3fgqOKKDHSeskcSljFx+SVk3jkLWndt3xCEh51wECjGdN8V
         KiRJm8+kieZoxYPajZ73Lmk9C0CppYPpzTpo+EiBNznHJKvfJZECASluLpVSfUg//1S6
         x/lSbeotTu53qxJuZhQv/xVoxxxLknbzcUFLhJwXviG1YyveHsBBFRt417tvFP0aqfbV
         dCEC4AgmtEZ6hMTUcbAmRE8jziDgkAhHqtwxcYp/xkB5SN0FKz26ltZiP/tNMxPan7Ff
         zdGg==
X-Gm-Message-State: AOAM531fi39xOWOTNluLhfrFHU3ayDHg/6HayZrITMT/oKPs3N8AoDKa
        37d62dnYOZjlrCOiYNoSQ64=
X-Google-Smtp-Source: ABdhPJxP6Mf1uHRMVsZYVU2fInVooyZ6O5LlrdzZ+GFqe7O1/ZgwrXNug0QaCiwEMXUXXkUk20SUsA==
X-Received: by 2002:a37:9c7:0:b0:69c:1c7b:6053 with SMTP id 190-20020a3709c7000000b0069c1c7b6053mr4478132qkj.682.1649790499567;
        Tue, 12 Apr 2022 12:08:19 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id u5-20020a05622a198500b002ee933faf83sm5032929qtc.73.2022.04.12.12.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 12:08:19 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: add rk356x sfc support
Date:   Tue, 12 Apr 2022 15:08:17 -0400
Message-Id: <20220412190817.125886-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Add the sfc node to the rk356x device tree.
The sfc node on rk356x can function as a boot device and supports four
lanes of receive data and one lane of transmit data for supported
SPI-NOR chips.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index d5131f5aaf73..b52edcdbbe7d 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -812,6 +812,17 @@ sdmmc1: mmc@fe2c0000 {
 		status = "disabled";
 	};
 
+	sfc: spi@fe300000 {
+		compatible = "rockchip,sfc";
+		reg = <0x0 0xfe300000 0x0 0x4000>;
+		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
+		clock-names = "clk_sfc", "hclk_sfc";
+		pinctrl-0 = <&fspi_pins>;
+		pinctrl-names = "default";
+		status = "disabled";
+	};
+
 	sdhci: mmc@fe310000 {
 		compatible = "rockchip,rk3568-dwcmshc";
 		reg = <0x0 0xfe310000 0x0 0x10000>;
-- 
2.25.1

