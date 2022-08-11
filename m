Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E729358F6ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 06:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiHKE03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 00:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiHKE0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 00:26:23 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A8619C1C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:26:20 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-10cf9f5b500so20326914fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=jUKsu0lhTbXIcD5FnG5XfET8ojcYleI7FIdCXl2Va6Q=;
        b=blbEER1F1wxbTHQUgg+RH2LGrMyQlbIn/TV0IwctsOdjqWh8z5HKRpgqX/5BlqrKqc
         kcb9x/aj2qeWPhN7df+rE8jlKHwaLZDC25mD7blN0/ucutZnRmVgBrdjzmjLYosq1uca
         BVKDQ2AQa75kcKWiToYmeSofNWGK8ROHtCgDu1byrrQYDsa9vJHip1YAx4FkOE6aWPm7
         3JloGqC2f0uk9XlSI5UVAsUTZpqntZG2fFrhNY3Vziy4IZCmdN6ObZrlCzjeRQKXtNUN
         QfNsTXN5M01jbUd8OieaCumLfLgJzQYJTU+Nall1unnWejsp/L8K1qOzrfGsBGY7yGHL
         karg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=jUKsu0lhTbXIcD5FnG5XfET8ojcYleI7FIdCXl2Va6Q=;
        b=joCNBgkR0Zqt3CPR1wkSCc0iyM4OPR4Dozi6NRwM45hq0kCe539lfu8iencisDtHz3
         t8GGeNhg0djiaavVlrvzMBufEsIq2KaYt30XRiVcvcNid9WDIjEnKQMhdLM/35p3YmCO
         FzTqTQbrfVvFZTReSTh5d3f1KUBpyQDPsifbM1aOTE6KgIjCVn2yeMXgbhiJGlc5RO+I
         rspSCKvylYVt/0mOmBcCia02ab4zjGPtkXEx7rm+kXUr3f9nZIbFm1uiXCgsYhsN6VHL
         pGSaL5QiUmjz6VQrYE3atv3xo68q8YAh2jIdFvzma8s1zbXlF/WedrOeD1YUoE8vUZ8K
         2g3w==
X-Gm-Message-State: ACgBeo1gJ2H9UlRsxiyQCLIQNxBe5MAZ4w/nJlZ2xAS7qIRtznJToHxS
        TPktCvISY9COYKA/h0//xIW9cA==
X-Google-Smtp-Source: AA6agR4Sw+tImrRgav7VLc9aizrg5JzFFsQAFPizwinOvwIs4uuvT7ftqEiW7Qsdj84FFaS9zAslPQ==
X-Received: by 2002:a05:6870:c6a4:b0:10e:585c:ba1a with SMTP id cv36-20020a056870c6a400b0010e585cba1amr2900443oab.41.1660191979967;
        Wed, 10 Aug 2022 21:26:19 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l17-20020a9d7351000000b006370c0e5be0sm1009517otk.48.2022.08.10.21.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 21:26:19 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: clock: Add Qualcomm SC8280XP GPU binding
Date:   Wed, 10 Aug 2022 21:28:54 -0700
Message-Id: <20220811042855.3867774-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811042855.3867774-1-bjorn.andersson@linaro.org>
References: <20220811042855.3867774-1-bjorn.andersson@linaro.org>
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

Add compatible for the Qualcomm SC8280XP GPU.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/clock/qcom,gpucc.yaml |  2 ++
 .../dt-bindings/clock/qcom,gpucc-sc8280xp.h   | 35 +++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sc8280xp.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
index 9ebcb1943b0a..a7d0af1bd9e0 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
@@ -17,6 +17,7 @@ description: |
     dt-bindings/clock/qcom,gpucc-sdm845.h
     dt-bindings/clock/qcom,gpucc-sc7180.h
     dt-bindings/clock/qcom,gpucc-sc7280.h
+    dt-bindings/clock/qcom,gpucc-sc8280xp.h
     dt-bindings/clock/qcom,gpucc-sm6350.h
     dt-bindings/clock/qcom,gpucc-sm8150.h
     dt-bindings/clock/qcom,gpucc-sm8250.h
@@ -28,6 +29,7 @@ properties:
       - qcom,sc7180-gpucc
       - qcom,sc7280-gpucc
       - qcom,sc8180x-gpucc
+      - qcom,sc8280xp-gpucc
       - qcom,sm6350-gpucc
       - qcom,sm8150-gpucc
       - qcom,sm8250-gpucc
diff --git a/include/dt-bindings/clock/qcom,gpucc-sc8280xp.h b/include/dt-bindings/clock/qcom,gpucc-sc8280xp.h
new file mode 100644
index 000000000000..bb7da46333b0
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gpucc-sc8280xp.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_SC8280XP_H
+#define _DT_BINDINGS_CLK_QCOM_GPU_CC_SC8280XP_H
+
+/* GPU_CC clocks */
+#define GPU_CC_PLL0						0
+#define GPU_CC_PLL1						1
+#define GPU_CC_AHB_CLK						2
+#define GPU_CC_CB_CLK						3
+#define GPU_CC_CRC_AHB_CLK					4
+#define GPU_CC_CX_GMU_CLK					5
+#define GPU_CC_CX_SNOC_DVM_CLK					6
+#define GPU_CC_CXO_AON_CLK					7
+#define GPU_CC_CXO_CLK						8
+#define GPU_CC_FREQ_MEASURE_CLK					9
+#define GPU_CC_GMU_CLK_SRC					10
+#define GPU_CC_GX_GMU_CLK					11
+#define GPU_CC_GX_VSENSE_CLK					12
+#define GPU_CC_HUB_AHB_DIV_CLK_SRC				13
+#define GPU_CC_HUB_AON_CLK					14
+#define GPU_CC_HUB_CLK_SRC					15
+#define GPU_CC_HUB_CX_INT_CLK					16
+#define GPU_CC_HUB_CX_INT_DIV_CLK_SRC				17
+#define GPU_CC_SLEEP_CLK					18
+#define GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK				19
+
+/* GPU_CC power domains */
+#define GPU_CC_CX_GDSC				0
+#define GPU_CC_GX_GDSC				1
+
+#endif
-- 
2.35.1

