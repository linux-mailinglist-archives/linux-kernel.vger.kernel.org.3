Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACB358D82F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 13:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242184AbiHILdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 07:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241225AbiHILda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 07:33:30 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC4B23BE7
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 04:33:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z2so14753752edc.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 04:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=x3bw1N8szhh7d6pxXib0z3o5fV1poB2Dnpq9g+GqWfE=;
        b=OQ/DWe5VUeZAH+1DdVahKr7jz9M2442x1j/0LEsOpagYS3BWVr9kbZPPzHY5A7Mih7
         haQoM5cnhNj1VCi5lUmu5/YANzrW1SpcYmrA/hBft4XxzAp0Bl8pFvoObwfdhr48XKQj
         q7rqD1djN7GKsUxISd78n20q+7F7wZofL+jcKZu2zpLEU24s5YBER4fCiEyRtqKfupNN
         g2wyjFFakVDXxEgjcm3uB35ONZ2YLe2rg02MC/ir/GoJm5DVAxQAjKM3To4BC14GH7NK
         pUqxI5WN2tJD3kzsqgvbeTZ9u7FNcmRCLPiKsa7KkMRJnhfPOP5EwXYBTwhqdFvbIiu5
         /gXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=x3bw1N8szhh7d6pxXib0z3o5fV1poB2Dnpq9g+GqWfE=;
        b=gMt6nV2kflvKnbpUe8gTbkK4VS3VGwklU6fVz2QeZGBc4mcsjrnMegaBpU/nA17Jeg
         rR1RBD8yANVcmUp+rWBx1iYjFUGcJBIASHe8Op9ARXxKXz4SlG/Bo4lynLb/hFo2zONm
         /e7Au6gMObajzI8aJwRH/Heptd30tx7OP4+azJaHvR7HWe+VlqP3xrUoyypeNUGN+syA
         9a0WSFyMDnAVVAKydEKkemNlQJ9YjHNPSGD6NoBtypIICG+MQbRTIJKzRQCo4/fNCy+J
         C7UVsGelVBeTpBxM92OX3qj6aTmy1P2uSw+wFEsQrlN8bRNt5dFdAJ4tuvv7fuRNSpz+
         stCQ==
X-Gm-Message-State: ACgBeo0HAZgpXrgOrhNTU1foXX65B1FF+I+t6NXCLCwrBREhZ88CPICu
        N+0pgRLRmm/vG2Pna3KGkwc3jQwtktGmtQ==
X-Google-Smtp-Source: AA6agR5HHwJUmw5IS10MTLpKuBI8W22bArsju7xvjpYEqguFpu8LEaqilx/1c5WKuXDEeaiXcv2jUg==
X-Received: by 2002:a05:6402:3506:b0:43e:954b:bc8a with SMTP id b6-20020a056402350600b0043e954bbc8amr21322991edd.266.1660044806790;
        Tue, 09 Aug 2022 04:33:26 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id kw21-20020a170907771500b00731219a2797sm1003845ejc.210.2022.08.09.04.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 04:33:26 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 2/9] dt-bindings: clock: Add bindings for Exynos850 CMU_IS
Date:   Tue,  9 Aug 2022 14:33:16 +0300
Message-Id: <20220809113323.29965-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220809113323.29965-1-semen.protsenko@linaro.org>
References: <20220809113323.29965-1-semen.protsenko@linaro.org>
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

CMU_IS generates CSIS, IPP, ITP, VRA and GDC clocks for BLK_IS. Add
clock indices and bindings documentation for CMU_IS domain.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - (none)

 .../clock/samsung,exynos850-clock.yaml        | 25 ++++++++++++
 include/dt-bindings/clock/exynos850.h         | 40 ++++++++++++++++++-
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
index 53511f056251..7f2e0b1c764c 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
@@ -38,6 +38,7 @@ properties:
       - samsung,exynos850-cmu-core
       - samsung,exynos850-cmu-dpu
       - samsung,exynos850-cmu-hsi
+      - samsung,exynos850-cmu-is
       - samsung,exynos850-cmu-peri
 
   clocks:
@@ -191,6 +192,30 @@ allOf:
             - const: dout_hsi_mmc_card
             - const: dout_hsi_usb20drd
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-is
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: CMU_IS bus clock (from CMU_TOP)
+            - description: Image Texture Processing core clock (from CMU_TOP)
+            - description: Visual Recognition Accelerator clock (from CMU_TOP)
+            - description: Geometric Distortion Correction clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: dout_is_bus
+            - const: dout_is_itp
+            - const: dout_is_vra
+            - const: dout_is_gdc
+
   - if:
       properties:
         compatible:
diff --git a/include/dt-bindings/clock/exynos850.h b/include/dt-bindings/clock/exynos850.h
index 3dc55d4e5b9e..f8bf26f118c1 100644
--- a/include/dt-bindings/clock/exynos850.h
+++ b/include/dt-bindings/clock/exynos850.h
@@ -61,7 +61,19 @@
 #define CLK_MOUT_AUD			49
 #define CLK_GOUT_AUD			50
 #define CLK_DOUT_AUD			51
-#define TOP_NR_CLK			52
+#define CLK_MOUT_IS_BUS			52
+#define CLK_MOUT_IS_ITP			53
+#define CLK_MOUT_IS_VRA			54
+#define CLK_MOUT_IS_GDC			55
+#define CLK_GOUT_IS_BUS			56
+#define CLK_GOUT_IS_ITP			57
+#define CLK_GOUT_IS_VRA			58
+#define CLK_GOUT_IS_GDC			59
+#define CLK_DOUT_IS_BUS			60
+#define CLK_DOUT_IS_ITP			61
+#define CLK_DOUT_IS_VRA			62
+#define CLK_DOUT_IS_GDC			63
+#define TOP_NR_CLK			64
 
 /* CMU_APM */
 #define CLK_RCO_I3C_PMIC		1
@@ -187,6 +199,32 @@
 #define CLK_GOUT_SYSREG_HSI_PCLK	13
 #define HSI_NR_CLK			14
 
+/* CMU_IS */
+#define CLK_MOUT_IS_BUS_USER		1
+#define CLK_MOUT_IS_ITP_USER		2
+#define CLK_MOUT_IS_VRA_USER		3
+#define CLK_MOUT_IS_GDC_USER		4
+#define CLK_DOUT_IS_BUSP		5
+#define CLK_GOUT_IS_CMU_IS_PCLK		6
+#define CLK_GOUT_IS_CSIS0_ACLK		7
+#define CLK_GOUT_IS_CSIS1_ACLK		8
+#define CLK_GOUT_IS_CSIS2_ACLK		9
+#define CLK_GOUT_IS_TZPC_PCLK		10
+#define CLK_GOUT_IS_CSIS_DMA_CLK	11
+#define CLK_GOUT_IS_GDC_CLK		12
+#define CLK_GOUT_IS_IPP_CLK		13
+#define CLK_GOUT_IS_ITP_CLK		14
+#define CLK_GOUT_IS_MCSC_CLK		15
+#define CLK_GOUT_IS_VRA_CLK		16
+#define CLK_GOUT_IS_PPMU_IS0_ACLK	17
+#define CLK_GOUT_IS_PPMU_IS0_PCLK	18
+#define CLK_GOUT_IS_PPMU_IS1_ACLK	19
+#define CLK_GOUT_IS_PPMU_IS1_PCLK	20
+#define CLK_GOUT_IS_SYSMMU_IS0_CLK	21
+#define CLK_GOUT_IS_SYSMMU_IS1_CLK	22
+#define CLK_GOUT_IS_SYSREG_PCLK		23
+#define IS_NR_CLK			24
+
 /* CMU_PERI */
 #define CLK_MOUT_PERI_BUS_USER		1
 #define CLK_MOUT_PERI_UART_USER		2
-- 
2.30.2

