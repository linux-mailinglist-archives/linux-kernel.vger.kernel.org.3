Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5D258D832
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 13:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242404AbiHILdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 07:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241412AbiHILdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 07:33:31 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7B323BFE
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 04:33:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i14so21677370ejg.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 04:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cCwcywsP+Q8pFGrRpLkItK7/GuA7qeDKcbe6OfitMjM=;
        b=KvAZ2IoN1+wzhpsZ0h0PV3rsQPdKrLYpQ3uUqeLn5AH02NLpINpz+MgZdOpt0L1Jdt
         td5FTY4B8C8Pfh6coO9BKCViM9tSNNasY3wOoo/+CTIo92vlmAsU9Y0D4HFc5RVGyRq7
         AVTb5tt/wlentTkjjQFDsNSa9XNZANoh/R4jrSo9VRIDBWGn+/Eju2GgkZjKrZPgWA7a
         zq3Rq0AuLvjyF5MrPFK5LR+CNif+2tP24G8iFVvbt0qKlGhmA2lzDdZOjALb551Sj7d4
         tBym/H2tjsFdSj9PEDuYwrLxjrMrlNDKHCNyqQ48/OXV5BJDT4pLPEnkagq2YvUlmR/D
         smFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cCwcywsP+Q8pFGrRpLkItK7/GuA7qeDKcbe6OfitMjM=;
        b=CUsOvxZAGvZf8V+HlgMIkw7zIuHVF1oCVax7mzigsMbAGPR9crx1UN83zQYlABpFAg
         wgmf/6uXsNx+uxBVPjTrsYK2lBJjQMfGsH2gpr5Rd5Bme5EhphQQ1hACFK86hBuxJD7K
         LotUM8ErQJNs4+nhFBhnAB3ce9ukEGl5/mTINY0iU9hAGiPDtkS73FPLk7m0mHVS+6h6
         tlBj4rAHVOxdfwNg1renwwQik+pCWECBPRuYh+RI6jVCOvQPM0Z/XlWlw9VX7ZshVuey
         fnRtDqp+rRKp1Qms8L59E9+g7ZFDT3OAMJQuCnhDySMyfkZYfm4HmPz7jsbSePDlmmp3
         mLNA==
X-Gm-Message-State: ACgBeo134uGw+I30TgvYg82MIdAGUfFSjc3jSQZj/J2wdZH34k1Atvqm
        yH124m9cLsI/Sap3YlgVUMkeyg==
X-Google-Smtp-Source: AA6agR5aWq4lEiBZ+pUNHwi+9fOXDG9GgzYd9TTDQ+m7U/IpGDc0h5iU+Ror21mdqx1LP4Mw3+90pA==
X-Received: by 2002:a17:907:e8d:b0:730:a4e8:27ed with SMTP id ho13-20020a1709070e8d00b00730a4e827edmr16038849ejc.58.1660044807880;
        Tue, 09 Aug 2022 04:33:27 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id lb5-20020a170907784500b0072b13ac9ca3sm1012099ejc.183.2022.08.09.04.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 04:33:27 -0700 (PDT)
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
Subject: [PATCH v2 3/9] dt-bindings: clock: Add bindings for Exynos850 CMU_MFCMSCL
Date:   Tue,  9 Aug 2022 14:33:17 +0300
Message-Id: <20220809113323.29965-4-semen.protsenko@linaro.org>
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

CMU_MFCMSCL generates MFC, M2M, MCSC and JPEG clocks for BLK_MFCMSCL.
Add clock indices and binding documentation for CMU_MFCMSCL.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - (none)

 .../clock/samsung,exynos850-clock.yaml        | 25 +++++++++++++++
 include/dt-bindings/clock/exynos850.h         | 32 ++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
index 7f2e0b1c764c..141cf173f87d 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
@@ -39,6 +39,7 @@ properties:
       - samsung,exynos850-cmu-dpu
       - samsung,exynos850-cmu-hsi
       - samsung,exynos850-cmu-is
+      - samsung,exynos850-cmu-mfcmscl
       - samsung,exynos850-cmu-peri
 
   clocks:
@@ -216,6 +217,30 @@ allOf:
             - const: dout_is_vra
             - const: dout_is_gdc
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-mfcmscl
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: Multi-Format Codec clock (from CMU_TOP)
+            - description: Memory to Memory Scaler clock (from CMU_TOP)
+            - description: Multi-Channel Scaler clock (from CMU_TOP)
+            - description: JPEG codec clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: dout_mfcmscl_mfc
+            - const: dout_mfcmscl_m2m
+            - const: dout_mfcmscl_mcsc
+            - const: dout_mfcmscl_jpeg
+
   - if:
       properties:
         compatible:
diff --git a/include/dt-bindings/clock/exynos850.h b/include/dt-bindings/clock/exynos850.h
index f8bf26f118c1..88d5289883d3 100644
--- a/include/dt-bindings/clock/exynos850.h
+++ b/include/dt-bindings/clock/exynos850.h
@@ -73,7 +73,19 @@
 #define CLK_DOUT_IS_ITP			61
 #define CLK_DOUT_IS_VRA			62
 #define CLK_DOUT_IS_GDC			63
-#define TOP_NR_CLK			64
+#define CLK_MOUT_MFCMSCL_MFC		64
+#define CLK_MOUT_MFCMSCL_M2M		65
+#define CLK_MOUT_MFCMSCL_MCSC		66
+#define CLK_MOUT_MFCMSCL_JPEG		67
+#define CLK_GOUT_MFCMSCL_MFC		68
+#define CLK_GOUT_MFCMSCL_M2M		69
+#define CLK_GOUT_MFCMSCL_MCSC		70
+#define CLK_GOUT_MFCMSCL_JPEG		71
+#define CLK_DOUT_MFCMSCL_MFC		72
+#define CLK_DOUT_MFCMSCL_M2M		73
+#define CLK_DOUT_MFCMSCL_MCSC		74
+#define CLK_DOUT_MFCMSCL_JPEG		75
+#define TOP_NR_CLK			76
 
 /* CMU_APM */
 #define CLK_RCO_I3C_PMIC		1
@@ -225,6 +237,24 @@
 #define CLK_GOUT_IS_SYSREG_PCLK		23
 #define IS_NR_CLK			24
 
+/* CMU_MFCMSCL */
+#define CLK_MOUT_MFCMSCL_MFC_USER		1
+#define CLK_MOUT_MFCMSCL_M2M_USER		2
+#define CLK_MOUT_MFCMSCL_MCSC_USER		3
+#define CLK_MOUT_MFCMSCL_JPEG_USER		4
+#define CLK_DOUT_MFCMSCL_BUSP			5
+#define CLK_GOUT_MFCMSCL_CMU_MFCMSCL_PCLK	6
+#define CLK_GOUT_MFCMSCL_TZPC_PCLK		7
+#define CLK_GOUT_MFCMSCL_JPEG_ACLK		8
+#define CLK_GOUT_MFCMSCL_M2M_ACLK		9
+#define CLK_GOUT_MFCMSCL_MCSC_CLK		10
+#define CLK_GOUT_MFCMSCL_MFC_ACLK		11
+#define CLK_GOUT_MFCMSCL_PPMU_ACLK		12
+#define CLK_GOUT_MFCMSCL_PPMU_PCLK		13
+#define CLK_GOUT_MFCMSCL_SYSMMU_CLK		14
+#define CLK_GOUT_MFCMSCL_SYSREG_PCLK		15
+#define MFCMSCL_NR_CLK				16
+
 /* CMU_PERI */
 #define CLK_MOUT_PERI_BUS_USER		1
 #define CLK_MOUT_PERI_UART_USER		2
-- 
2.30.2

