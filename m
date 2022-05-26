Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8291F5354F5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348693AbiEZUqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349009AbiEZUqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:46:18 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9EB3BC
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:46:09 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y32so4066648lfa.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zKFl69Qf/EfZisA1xjfBE06TiXrFDlro+owcvXYxfLs=;
        b=OPrJTmWWghJxejBwqiBJKnQTE203iScML6t38O4ge+iX4qrqf9UUL8F1yxMhy9/D2I
         vtU5EtfG4quCCB2ZCn7woUy8Nlfcnv6W5+2drvtJ1F47aHI0CBGa6KfwacFvANbHiQao
         m3YW06Doa442ooxkosamZ/z07i70Y14NmNCWJbkzdISVa3PiF39J7UMufwc0qNQQB8ef
         Z5aLWglU/wPFO1tD7Oz7/WJAfzKfC7X6M5Hm/VD4FRMeOyTIjryxWRjYBVdpBAtWMojw
         6Qj2YFapZvbVb/Jm/d+V7ugCCRHN1STPy/TpgRt/Xu2neoZSth7ha2V06YLazxgi8ONB
         CqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zKFl69Qf/EfZisA1xjfBE06TiXrFDlro+owcvXYxfLs=;
        b=IZY5tIjdbiiI1yTXQy6s7ycKBA0XBXulR3VQny2Nk+G8zgm5M6Zjqit/IPl5cbsSZb
         fE6CTBsrYFDJNt1C+OqjioNj0F+u3BOv7DhZggBbNTIcK4zh1CVhoDLaU46weUvJTpMM
         QhFCxqZ03ldaC7EY5xc5jOUt6ufVA0pBBepOTZWoYD+IrYZkvR1IJtgpNjzmRR2A2cMv
         0amH9/ezDLc5xQvKdLN+7Y3WgMZOzARdsOcKrUNiW4NgZixsjLF7iBjB7Q8QUXo7Trr7
         vzatV8FvluaOnxbunW8cN0X5ndy2eEAr3S9qMpTRNrJREcXtAm1ANSvXY76wMLZ8+Zcd
         ow6g==
X-Gm-Message-State: AOAM531H/hrP845JgwlfIAa3GEIUWDzbUzK7M2cmjhEei+4Kv2aiQALt
        vsPy1LhaIwH56Av3HJMiNz/+jBugvdBr1t8p
X-Google-Smtp-Source: ABdhPJxjg7MxB9+eNd5wcXXuMUeFFezHj5yR25BZpYg2A0ogiMJQ3jbwAK7yX/hn0Rc1JtM5uBcpOw==
X-Received: by 2002:a17:907:a414:b0:6ff:2e46:e891 with SMTP id sg20-20020a170907a41400b006ff2e46e891mr2501719ejc.758.1653597956660;
        Thu, 26 May 2022 13:45:56 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z1-20020a1709067e4100b006fe8ac6bc69sm827633ejr.140.2022.05.26.13.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:45:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: amlogic: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:45:51 +0200
Message-Id: <20220526204552.832961-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                      | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                       | 2 +-
 .../boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 3f5254eeb47b..04f797b5a012 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1535,7 +1535,7 @@ aobus: bus@ff800000 {
 
 			sysctrl_AO: sys-ctrl@0 {
 				compatible = "amlogic,meson-axg-ao-sysctrl", "simple-mfd", "syscon";
-				reg =  <0x0 0x0 0x0 0x100>;
+				reg = <0x0 0x0 0x0 0x100>;
 
 				clkc_AO: clock-controller {
 					compatible = "amlogic,meson-axg-aoclkc";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index aa14ea017a61..023a52005494 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -450,7 +450,7 @@ aobus: bus@c8100000 {
 
 			sysctrl_AO: sys-ctrl@0 {
 				compatible = "amlogic,meson-gx-ao-sysctrl", "simple-mfd", "syscon";
-				reg =  <0x0 0x0 0x0 0x100>;
+				reg = <0x0 0x0 0x0 0x100>;
 
 				clkc_AO: clock-controller {
 					compatible = "amlogic,meson-gx-aoclkc";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
index fcb304c5a40f..6831137c5c10 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
@@ -216,7 +216,7 @@ &uart_A {
 
 	bluetooth {
 		compatible = "realtek,rtl8822cs-bt";
-		enable-gpios  = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
 		host-wake-gpios = <&gpio GPIOX_18 GPIO_ACTIVE_HIGH>;
        };
 };
-- 
2.34.1

