Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CC55354EE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347809AbiEZUp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349026AbiEZUpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:45:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C23434B6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:45:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id wh22so5166580ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h+A3qo6BldJs7yB/PUZIl3d+cRoad7gVEXVoqQHqU1I=;
        b=bsgklBTJ5kRGLaDjr1BfSDjF1LVpD2uDeE4Cb6TesbVm7pPQRfsRxCEA3IhYwiCk29
         uPGnS1ku5A8/1gUu1EBhlwaWa4l1MW35jGgmfYB12OYCt14rnwHUI5mdm4ZyGbL7rGTb
         PcIeDNiDsgUlpgkLZUg/70YBUS6aKSK2bMKe26r1SgMtkl25sWih7r/kV0mbctgGmDG0
         LubrrOByyAJe7+gV37x9aH6a5r6oEZysuurR1wjxszu3tiQ9w+KPQESd0lEnYJwvcqQN
         jnjUBv/GlpyQ9oy8zoaP8pj8NBmNvOFMWBkHdcqHVkA1qROpQVMsLoqjZ6rKD0kNPOzX
         hKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+A3qo6BldJs7yB/PUZIl3d+cRoad7gVEXVoqQHqU1I=;
        b=k4MUD9P76+8DsciO6jBXfPkJ27V9R0o5TIt6WhY9+l8uZYFl8RhYTbl/+LJm4d7y68
         z1v/Yj/ut1QnDbMAaYFVn/R+yzDlPCLPEBeHJqiQ7dvRyCApes6RzPSe6/ZnOetMXeZZ
         OTK5hwsXJpQFJukCEQKybNLZjagPA1d9UpZv8iAHYCDJRCxMWirmcDUtdKXIC1PpBzjW
         hBxJ0L/7EVVV0laxIEWCySVDecrAoS+U8khoF7mrEOpXbfp/3SiuobPmYuvv7l0EZIWo
         a4dZTbiLXfUJ35SC17rrMcenbyYmzZmCRwLAF1cKDQUzNgqcbaaUHLEU3EtlUyTdNKDk
         oRRw==
X-Gm-Message-State: AOAM531/PWYGX/AyLqnvWSizo0RUZbRvNwihj1fs755FeyYGTfn6n/BT
        dNGjQLisWipKYU/7gBxs5d/iCA==
X-Google-Smtp-Source: ABdhPJxbfx0ehewyZhx++Y7dMO9l/5GqNy/H+1t0rKskIYQrY9Sk4ZR/QsPiB+GGpu0kCkRrHSGEWA==
X-Received: by 2002:a17:906:99c3:b0:6ff:1254:7227 with SMTP id s3-20020a17090699c300b006ff12547227mr8743993ejn.692.1653597932074;
        Thu, 26 May 2022 13:45:32 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id rv3-20020a1709068d0300b006fec69a3978sm769550ejc.207.2022.05.26.13.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:45:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: pxa: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:45:25 +0200
Message-Id: <20220526204525.832847-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526204525.832847-1-krzysztof.kozlowski@linaro.org>
References: <20220526204525.832847-1-krzysztof.kozlowski@linaro.org>
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
 arch/arm/boot/dts/pxa300-raumfeld-common.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/pxa300-raumfeld-common.dtsi b/arch/arm/boot/dts/pxa300-raumfeld-common.dtsi
index 8a6721d436bd..147c99191dc2 100644
--- a/arch/arm/boot/dts/pxa300-raumfeld-common.dtsi
+++ b/arch/arm/boot/dts/pxa300-raumfeld-common.dtsi
@@ -189,31 +189,31 @@ max8660: regulator@34 {
 
 		regulators {
 			regulator-v3 {
-				regulator-compatible= "V3(DCDC)";
+				regulator-compatible = "V3(DCDC)";
 				regulator-min-microvolt = <725000>;
 				regulator-max-microvolt = <1800000>;
 			};
 
 			regulator-v4 {
-				regulator-compatible= "V4(DCDC)";
+				regulator-compatible = "V4(DCDC)";
 				regulator-min-microvolt = <725000>;
 				regulator-max-microvolt = <1800000>;
 			};
 
 			regulator-v5 {
-				regulator-compatible= "V5(LDO)";
+				regulator-compatible = "V5(LDO)";
 				regulator-min-microvolt = <1700000>;
 				regulator-max-microvolt = <2000000>;
 			};
 
 			reg_vcc_sdio: regulator-v6 {
-				regulator-compatible= "V6(LDO)";
+				regulator-compatible = "V6(LDO)";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 			};
 
 			regulator-v7 {
-				regulator-compatible= "V7(LDO)";
+				regulator-compatible = "V7(LDO)";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 			};
-- 
2.34.1

