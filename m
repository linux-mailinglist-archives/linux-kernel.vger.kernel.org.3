Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A875354E5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349176AbiEZUon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349129AbiEZUn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:43:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2265C6311
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:43:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id q21so5194574ejm.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QcLvN03w1UKQPgjX9rv1d+qE6eJZjbxTCqhmh4Irl8s=;
        b=E7k7ti+TRjeingo8wiGVBmQhssUIKMovZq1CTFf8w0jfK1VOBKzeIvuBZ/R7Nk8+2A
         QLYTqx9W16pwQSh+Q72mBZwKap2PcQcem3gT500kqHb5BSaZtZGnun8lQ+XgIYMvs2Wm
         MGWpYFkwHUmBH4XshWzqYAkZiDGm1KyDr8hWyC13lHFLmbh9G9zeCS4WE+vK/3ahSqjs
         vgb90soY7g7HsjHcbvHFfqvUfM1uQXrxQ8TUlqgSqJKJ6HOspYgZpaEgTtyjGBvYjluR
         cSQtC4FudRd34ZUqiRfzzOM+3xwYEWQrzcjMfQOZdMqA3X1uRV/99BZNrZrsJe1bRtez
         HgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QcLvN03w1UKQPgjX9rv1d+qE6eJZjbxTCqhmh4Irl8s=;
        b=mHW56UwPnoBihQ9tCp3cV+oVD8knGgNh39VNXeN5B/mypxHLxXoQyb8Wl4I5gYSUma
         jzbycfDT1NzV5jMaTkw2AFIOBfFcAeYjnJREIwCnRGfN73xhfKjU8NE1LWD1eW4nwMIR
         idnPQt3nDhj2NqSzP8fBD8qw7hrBL6sZzA3FWOKack9VqpL4QtMD2fBlUGU3iZPL9S/R
         pPnNAF4r8fUAEPS/fHgYQ2+LDg48kBkqA61Hh8ZcsqOxnP5X4tMewdPxegLUN6EXpDwX
         u1z061CS3zr2tSkOCah79YCIHIgJldKMq19OYskTqje2pHcsVyy1sr9xCpq3GTLB+pBI
         2JYQ==
X-Gm-Message-State: AOAM5331PNQWTp6uarpBKlrobFBs16NCfTX+2gPeJBUL/KdO2odcf0rS
        Co1IsHgMpwzjzrl39Jk+Riy3/A==
X-Google-Smtp-Source: ABdhPJzkQvWbZM/xotHvMbcGMGsupNTjLEPyTrX5WSzU+1e2khzPqzlRKi6W6SCEInuggwcCLax6AQ==
X-Received: by 2002:a17:907:6d26:b0:6fe:b8cc:4613 with SMTP id sa38-20020a1709076d2600b006feb8cc4613mr26198968ejc.229.1653597825692;
        Thu, 26 May 2022 13:43:45 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id qw39-20020a1709066a2700b006f3ef214e59sm788041ejc.191.2022.05.26.13.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:43:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: broadcom: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:43:39 +0200
Message-Id: <20220526204339.832296-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526204339.832296-1-krzysztof.kozlowski@linaro.org>
References: <20220526204339.832296-1-krzysztof.kozlowski@linaro.org>
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
 arch/arm/boot/dts/bcm28155-ap.dts | 8 ++++----
 arch/arm/boot/dts/bcm283x.dtsi    | 6 +++---
 arch/arm/boot/dts/bcm5301x.dtsi   | 6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index ead6e9804dbf..78465ad37c5f 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -31,22 +31,22 @@ uart@3e000000 {
 	};
 
 	i2c@3e016000 {
-		status="okay";
+		status = "okay";
 		clock-frequency = <400000>;
 	};
 
 	i2c@3e017000 {
-		status="okay";
+		status = "okay";
 		clock-frequency = <400000>;
 	};
 
 	i2c@3e018000 {
-		status="okay";
+		status = "okay";
 		clock-frequency = <400000>;
 	};
 
 	i2c@3500d000 {
-		status="okay";
+		status = "okay";
 		clock-frequency = <100000>;
 
 		pmu: pmu@8 {
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index c113661a6668..2718e1033929 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -50,9 +50,9 @@ cpu_thermal: cpu-thermal {
 
 			trips {
 				cpu-crit {
-					temperature	= <90000>;
-					hysteresis	= <0>;
-					type		= "critical";
+					temperature = <90000>;
+					hysteresis = <0>;
+					type = "critical";
 				};
 			};
 
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 65f8a759f1e3..5fc1b847f4aa 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -568,9 +568,9 @@ cpu_thermal: cpu-thermal {
 
 			trips {
 				cpu-crit {
-					temperature	= <125000>;
-					hysteresis	= <0>;
-					type		= "critical";
+					temperature = <125000>;
+					hysteresis = <0>;
+					type = "critical";
 				};
 			};
 
-- 
2.34.1

