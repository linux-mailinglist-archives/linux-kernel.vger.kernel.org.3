Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D105354F7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbiEZUqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346148AbiEZUqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:46:15 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1595DBC7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:45:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i27so5064111ejd.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6IYNJKDiS0GsxsIfjukniKUSVecFLdtV/BJTHhq/ubw=;
        b=owB1dleLPG3OEjVQ4kP49KUKmgZfacfRD5gYgPRUOIMN9K8eJhrh7WsqO81aI5JY2N
         opwnKxla+8MAlR9Zi7c0OeSV+2PWc5oTLpcFm2y1vOUusMOCPrLds6xD1tYc7QBFIKNP
         NE68c3ZMgmcJmtFzaxACWNdcQZvl/vkOqOuPSvPA+pMkuaXM0qU5gLLEcacIW8wWtSkZ
         0O03bC5+93aU6iKf/iKLvgxZeIwKJas1lslpIZFSBTUZLYBa+VCcOmniNQaLw7YLE1Ds
         dMVDslwWbvbc4TevZUSOthF+Q+C2aYrjyBUs604DXzMHMGAIJpNVcLMNW+JqKc4supIG
         /V8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6IYNJKDiS0GsxsIfjukniKUSVecFLdtV/BJTHhq/ubw=;
        b=zb2TqVxshXVBi9KY2MaMFAzC71AnTVOmT6zKfavJqPOeic0wQPdtN9mIrh/lgubU86
         qRy6ATTozZNFLkuc/iK+OSSUAMj6nPUPyPX2PV/bSYoidWOnjJIIsTl9xClPvWEHrMLi
         MAseNOAyVrudGaieiVR0JLZv11AXLWzvjAoIiayaGchC3rGONKcy3kjfqCor+PJOi27O
         f43l9yAGWFxkD1YTXQVH3a0zBoCqxDWz+s+EtZBzAPrwPEGgBqKEQnL2lTrQ6djS66Z2
         3hzz3uz0ub9Y3Zs08YWgxFXHm16pDhSsjh4wbejqB+gOkR9WxOFvrA4G5tEIRy+0OjKn
         bmlQ==
X-Gm-Message-State: AOAM531Qz34dgxQcgtyAqjYX93fIvAVNm3S81qQ7JCScF1kbJYYbGzl4
        nK37MR8PV0WzAZDAWtZb9MaKIg==
X-Google-Smtp-Source: ABdhPJz8AXnd6L8rAXQTGJvqOqAm1R+IiFsGG7//dQPGu4ApZsgRXYECTsCTneE4TJbZqANQfqfPlw==
X-Received: by 2002:a17:907:1c81:b0:6ff:335d:a0f7 with SMTP id nb1-20020a1709071c8100b006ff335da0f7mr845104ejc.182.1653597958016;
        Thu, 26 May 2022 13:45:58 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z1-20020a1709067e4100b006fe8ac6bc69sm827633ejr.140.2022.05.26.13.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:45:57 -0700 (PDT)
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
Subject: [PATCH 2/2] ARM: dts: meson: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:45:52 +0200
Message-Id: <20220526204552.832961-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526204552.832961-1-krzysztof.kozlowski@linaro.org>
References: <20220526204552.832961-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
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

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm/boot/dts/meson.dtsi   | 4 ++--
 arch/arm/boot/dts/meson8.dtsi  | 2 +-
 arch/arm/boot/dts/meson8b.dtsi | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 26eaba3fa96f..8e3860d5d916 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -214,14 +214,14 @@ aobus: aobus@c8100000 {
 			ranges = <0x0 0xc8100000 0x100000>;
 
 			ao_arc_rproc: remoteproc@1c {
-				compatible= "amlogic,meson-mx-ao-arc";
+				compatible = "amlogic,meson-mx-ao-arc";
 				reg = <0x1c 0x8>, <0x38 0x8>;
 				reg-names = "remap", "cpu";
 				status = "disabled";
 			};
 
 			ir_receiver: ir-receiver@480 {
-				compatible= "amlogic,meson6-ir";
+				compatible = "amlogic,meson6-ir";
 				reg = <0x480 0x20>;
 				interrupts = <GIC_SPI 15 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 9997a5d0333a..0f8bac8bac8b 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -430,7 +430,7 @@ mux {
 };
 
 &ao_arc_rproc {
-	compatible= "amlogic,meson8-ao-arc", "amlogic,meson-mx-ao-arc";
+	compatible = "amlogic,meson8-ao-arc", "amlogic,meson-mx-ao-arc";
 	amlogic,secbus2 = <&secbus2>;
 	sram = <&ao_arc_sram>;
 	resets = <&reset RESET_MEDIA_CPU>;
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 94f1c03decce..cf9c04a61ba3 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -384,7 +384,7 @@ mux {
 };
 
 &ao_arc_rproc {
-	compatible= "amlogic,meson8b-ao-arc", "amlogic,meson-mx-ao-arc";
+	compatible = "amlogic,meson8b-ao-arc", "amlogic,meson-mx-ao-arc";
 	amlogic,secbus2 = <&secbus2>;
 	sram = <&ao_arc_sram>;
 	resets = <&reset RESET_MEDIA_CPU>;
-- 
2.34.1

