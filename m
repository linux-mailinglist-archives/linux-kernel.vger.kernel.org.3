Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF4D58CD77
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243992AbiHHSQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243993AbiHHSQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:16:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ED09FF2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:16:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b6so5173740wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 11:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=QRWRO8agMBm5i20KyVm3mywJyV1BaORmn3HrLI4GpCc=;
        b=pwqMX7Q9CHrO7SpRd5ToAko8dl6oZZDH80VvBOh5clpHnWpVs8NYF+2Lkcj/Jw0LFg
         4Xtg6KIDgW8qhTgvAPdYszHFLRiKAjIqAnt/HZ8rQXwdCG6EmEIplo+avaxIuNqeQX68
         Zu0ZKXPRcC8uYjCkBUd8qnhxmeYOVU0p9gJWjaphj713cnryNMs6wZ7sqe/7XAb0ZjmO
         QuevMnxxe7c8L0tEm0bcVRFPfnziEaJJPaVhkvGlU+T0WEUV8ksHddoi1B43e2szwym8
         sTXGjTcFxw3GY781nUbWgkzvVahVhEWor/v2H2pbzTZeOyFA2KtH9304WtRPyAIdjIQw
         XMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=QRWRO8agMBm5i20KyVm3mywJyV1BaORmn3HrLI4GpCc=;
        b=rbuMiq+ChYd1jPRumGH2GDlwuF+CBxPR+Bde94P+3vhyevfyXTiANmrGpW02oqXCzC
         np8/TovPhTi9g0fThV6sEtxns//m0vNU1Qf9RRf/cLS+kgRNR0V60GI7y8KVCP9neqKZ
         ExIRNoOwsBIH/CCfPp8i59yT+mQEIrk8OtdAUAUfJn0WvxEpdeC9Twbay3TJI/LpRVE0
         F34TPwHGDtCEsFJD8E/z3zRPbXYpBEO7fZzOTPEsoux6rNSHTGg/pyi08xyheTsEpLxz
         gFuJeaNDGBgVI2fDyjnUEm0pQef64yBMan9YYgTGyla8SmPp/ownN5+XrstppgG13txd
         YeFw==
X-Gm-Message-State: ACgBeo0WE07hDLLdV0jMIhOVAFjSy69wYOZYfcZVZ98lkj7xzOSDOHmw
        VmBuwwQphBhMUh9YQb5T8S7xNQ==
X-Google-Smtp-Source: AA6agR4Wuu50Mj+pYnt7tY3CJjHpyNSUyGeVjSHsZ5J4loZftwx36rOlwB40WstVF6ooDbr2f8BTRA==
X-Received: by 2002:a05:600c:4f07:b0:3a3:2277:7064 with SMTP id l7-20020a05600c4f0700b003a322777064mr13267433wmq.181.1659982558784;
        Mon, 08 Aug 2022 11:15:58 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id m1-20020a7bcb81000000b003a3278d5cafsm18572351wmi.28.2022.08.08.11.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 11:15:58 -0700 (PDT)
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
Subject: [PATCH 1/7] dt-bindings: clock: Add bindings for Exynos850 CMU_AUD
Date:   Mon,  8 Aug 2022 21:15:57 +0300
Message-Id: <20220808181557.10385-1-semen.protsenko@linaro.org>
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

CMU_AUD generates Cortex-A32 clock, bus clock and audio clocks for
BLK_AUD. Add clock indices and binding documentation for CMU_AUD.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../clock/samsung,exynos850-clock.yaml        | 19 ++++++
 include/dt-bindings/clock/exynos850.h         | 68 ++++++++++++++++++-
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
index 80ba60838f2b..523fdfaae891 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
@@ -33,6 +33,7 @@ properties:
     enum:
       - samsung,exynos850-cmu-top
       - samsung,exynos850-cmu-apm
+      - samsung,exynos850-cmu-aud
       - samsung,exynos850-cmu-cmgp
       - samsung,exynos850-cmu-core
       - samsung,exynos850-cmu-dpu
@@ -88,6 +89,24 @@ allOf:
             - const: oscclk
             - const: dout_clkcmu_apm_bus
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-aud
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: AUD clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: dout_aud
+
   - if:
       properties:
         compatible:
diff --git a/include/dt-bindings/clock/exynos850.h b/include/dt-bindings/clock/exynos850.h
index 0b6a3c6a7c90..3dc55d4e5b9e 100644
--- a/include/dt-bindings/clock/exynos850.h
+++ b/include/dt-bindings/clock/exynos850.h
@@ -58,7 +58,10 @@
 #define CLK_MOUT_CLKCMU_APM_BUS		46
 #define CLK_DOUT_CLKCMU_APM_BUS		47
 #define CLK_GOUT_CLKCMU_APM_BUS		48
-#define TOP_NR_CLK			49
+#define CLK_MOUT_AUD			49
+#define CLK_GOUT_AUD			50
+#define CLK_DOUT_AUD			51
+#define TOP_NR_CLK			52
 
 /* CMU_APM */
 #define CLK_RCO_I3C_PMIC		1
@@ -87,6 +90,69 @@
 #define CLK_GOUT_SYSREG_APM_PCLK	24
 #define APM_NR_CLK			25
 
+/* CMU_AUD */
+#define CLK_DOUT_AUD_AUDIF		1
+#define CLK_DOUT_AUD_BUSD		2
+#define CLK_DOUT_AUD_BUSP		3
+#define CLK_DOUT_AUD_CNT		4
+#define CLK_DOUT_AUD_CPU		5
+#define CLK_DOUT_AUD_CPU_ACLK		6
+#define CLK_DOUT_AUD_CPU_PCLKDBG	7
+#define CLK_DOUT_AUD_FM			8
+#define CLK_DOUT_AUD_FM_SPDY		9
+#define CLK_DOUT_AUD_MCLK		10
+#define CLK_DOUT_AUD_UAIF0		11
+#define CLK_DOUT_AUD_UAIF1		12
+#define CLK_DOUT_AUD_UAIF2		13
+#define CLK_DOUT_AUD_UAIF3		14
+#define CLK_DOUT_AUD_UAIF4		15
+#define CLK_DOUT_AUD_UAIF5		16
+#define CLK_DOUT_AUD_UAIF6		17
+#define CLK_FOUT_AUD_PLL		18
+#define CLK_GOUT_AUD_ABOX_ACLK		19
+#define CLK_GOUT_AUD_ASB_CCLK		20
+#define CLK_GOUT_AUD_CA32_CCLK		21
+#define CLK_GOUT_AUD_CNT_BCLK		22
+#define CLK_GOUT_AUD_CODEC_MCLK		23
+#define CLK_GOUT_AUD_DAP_CCLK		24
+#define CLK_GOUT_AUD_GPIO_PCLK		25
+#define CLK_GOUT_AUD_PPMU_ACLK		26
+#define CLK_GOUT_AUD_PPMU_PCLK		27
+#define CLK_GOUT_AUD_SPDY_BCLK		28
+#define CLK_GOUT_AUD_SYSMMU_CLK		29
+#define CLK_GOUT_AUD_SYSREG_PCLK	30
+#define CLK_GOUT_AUD_TZPC_PCLK		31
+#define CLK_GOUT_AUD_UAIF0_BCLK		32
+#define CLK_GOUT_AUD_UAIF1_BCLK		33
+#define CLK_GOUT_AUD_UAIF2_BCLK		34
+#define CLK_GOUT_AUD_UAIF3_BCLK		35
+#define CLK_GOUT_AUD_UAIF4_BCLK		36
+#define CLK_GOUT_AUD_UAIF5_BCLK		37
+#define CLK_GOUT_AUD_UAIF6_BCLK		38
+#define CLK_GOUT_AUD_WDT_PCLK		39
+#define CLK_MOUT_AUD_CPU		40
+#define CLK_MOUT_AUD_CPU_HCH		41
+#define CLK_MOUT_AUD_CPU_USER		42
+#define CLK_MOUT_AUD_FM			43
+#define CLK_MOUT_AUD_PLL		44
+#define CLK_MOUT_AUD_TICK_USB_USER	45
+#define CLK_MOUT_AUD_UAIF0		46
+#define CLK_MOUT_AUD_UAIF1		47
+#define CLK_MOUT_AUD_UAIF2		48
+#define CLK_MOUT_AUD_UAIF3		49
+#define CLK_MOUT_AUD_UAIF4		50
+#define CLK_MOUT_AUD_UAIF5		51
+#define CLK_MOUT_AUD_UAIF6		52
+#define IOCLK_AUDIOCDCLK0		53
+#define IOCLK_AUDIOCDCLK1		54
+#define IOCLK_AUDIOCDCLK2		55
+#define IOCLK_AUDIOCDCLK3		56
+#define IOCLK_AUDIOCDCLK4		57
+#define IOCLK_AUDIOCDCLK5		58
+#define IOCLK_AUDIOCDCLK6		59
+#define TICK_USB			60
+#define AUD_NR_CLK			61
+
 /* CMU_CMGP */
 #define CLK_RCO_CMGP			1
 #define CLK_MOUT_CMGP_ADC		2
-- 
2.30.2

