Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8380E58CD7C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244014AbiHHSQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243815AbiHHSQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:16:04 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66C8DEBD
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:16:01 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 186-20020a1c02c3000000b003a34ac64bdfso5546756wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=LxdWIrp6h2qjt0XVQVzdJXERuzfBADuhugCm++L0IwA=;
        b=N86YZZzuDnayOOaNi0efsePGXbiSOgAKze9kj85wpmPnFsUWscz6Lt4mKGpZ+r9z4Q
         r/p/F+B9TunZGM7AYbeUGvs29EYQCJleei5hT9/XacRD6Knr9jY5PkbaKy3OP0LdyRsU
         Pn+NZynHTpnAeV7gkSaxUGdZpthYL5Y0BNlgtWXVxZx3svBLFoSABI3DMbXE58c0v3tB
         +8wriagIXcoGQn/Grf3Vu4ga65fFlwxbji/Yo4/jFKGRA/XuCDmZMtb/7CyW5QfeV4Vg
         4auHyMeFrvYg2j9VFuKZgJB8Ha3Y+DZq1ZsJT1NE9OWhF6r+SF3DQhrFQL4Z2UdP81AV
         xpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=LxdWIrp6h2qjt0XVQVzdJXERuzfBADuhugCm++L0IwA=;
        b=Y8zsknqhxIEZ6KtrwI46AwuZy4OAzq51pb07n/reaxGZBeo2vY2ocCxRnzQCL2hzQt
         Pb+WgwXZpUCTksEyCSXQBq2jyQDAYn7WJrXzmng6loNxwQzIIiZ5eXr2aLVMZZlTHFrW
         rq+aEvJIRBaNpMvbXoFPCYr7YTZRu3CRf1ndPDc2kPDx6XzCniOV49jNEKwom1Zh27YB
         NwrF5zS2GtCBPbXIcNKbo8gM2fMNCD7KXiseN2MxCviLtpBBsVf1UpvwYeNuyCsUwVY0
         IwFsNG/Oe3HX1yWqYu6DQxyifomZuD5UAoGxf01eP/48iMGqrCW8+ySwFEYb3Qa2c6yd
         qAog==
X-Gm-Message-State: ACgBeo0YAlWfGbvqw2rO6wpckdQSs56sQyAqDo/z3yli2diLhqEOG0L7
        OnPBP+vEDY2RBFp5HaXJ8EoCuw==
X-Google-Smtp-Source: AA6agR7762jwygrYknaBhp5g+DOZxc8wyUU/dys/HAGUHbSlGQMGaOy9oH6+cmlbhZmUTQG4Hw7sWg==
X-Received: by 2002:a05:600c:1c19:b0:3a5:51aa:d041 with SMTP id j25-20020a05600c1c1900b003a551aad041mr444559wms.172.1659982560243;
        Mon, 08 Aug 2022 11:16:00 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id c5-20020adfe705000000b0021f1522c93bsm14273227wrm.45.2022.08.08.11.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 11:15:59 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] dt-bindings: clock: Add bindings for Exynos850 CMU_IS
Date:   Mon,  8 Aug 2022 21:15:59 +0300
Message-Id: <20220808181559.10438-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
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

CMU_IS generates CSIS, IPP, ITP, VRA and GDC clocks for BLK_IS. Add
clock indices and bindings documentation for CMU_IS domain.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../clock/samsung,exynos850-clock.yaml        | 25 ++++++++++++
 include/dt-bindings/clock/exynos850.h         | 40 ++++++++++++++++++-
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
index 523fdfaae891..c9f78ae7a9fa 100644
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

