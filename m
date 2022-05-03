Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977FA518513
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbiECNJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiECNIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:08:34 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27D12528E
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 06:05:00 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dk23so33316362ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 06:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rOsJ9Zrz7rA4F/2ineOAizsi6mknMU/UXeuWBA/JKfA=;
        b=U6leyOc4PR5xVs7AFN2B+5EUZ25Eq16L2YBKHN1RSYWmLmTsJLKoJWrDJCQFhEmka9
         jLs92EDKpNXIuq2kblx6rXcc36SbyY3cfl3KpnjZc3W3Mmr7SL9eRP715QZsYFE+8IYQ
         dBZzTG8ZFAWpTHLa9TdG2/lO15NDdpTNmhBiNZ2h2NZ2p4Dp6tnBZoqXGNEC8PhCixx7
         8Z7cZEXHL3wo992HOSFiHuuSKaFh/NtSVYWCRIhAPmaVvZ/yY323adDL1SOGZLQyAVT9
         EoJWe82PCeUlyY0Uf6r016cV7WOhjTb7sovR1HFec/nvpXBED17x6XX0wTx0LBeDsqJm
         W8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rOsJ9Zrz7rA4F/2ineOAizsi6mknMU/UXeuWBA/JKfA=;
        b=EXnILVlF2IV+TyAlM4Ibmx/d/zusLON+ZFK6rIH0+NyykcyduZ+ovYlZbnU5+G06BM
         LXEtnxVIB4lBM4YQX1jCOF6TXgc6kVm0kBWlJMJShd//khwQMA3WkiWuV+zAjcSY3Sa4
         5YG9h+3ZwDFxum017kuJD6wosk9iQklnpDA4uWV2PSwL9r3MtDBmLY4OBVX5AZS/aiQu
         BYH62pKupvusiSp0lNc3GF5Tp+9TNF+64YhRnFAzMKTTkUMyC5+NH5f8ezYgwzMaSLbG
         9B6SYU2KseSdPFoEqwW8oj4TFsyDPctm4ZdblmjH3mEBBPoL75MePY6lX8+9G048+V7o
         1sIQ==
X-Gm-Message-State: AOAM530ShrCGXjHfpNmLkKf5A48/kWcqehH19gXTayR0wvw4o0hYcVR6
        4HaY6P2mUxoNtHPsZ1453QDzWQ==
X-Google-Smtp-Source: ABdhPJy2J8mmkdiJxvqH8dGikN58L5gi+Ssd9S6yZ79H1xJDZryQTFJORRerTTeD7nXWU6jstgzEkQ==
X-Received: by 2002:a17:907:6da5:b0:6f3:c4b1:378b with SMTP id sb37-20020a1709076da500b006f3c4b1378bmr15574510ejc.307.1651583099425;
        Tue, 03 May 2022 06:04:59 -0700 (PDT)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id y13-20020aa7cccd000000b0042617ba639asm7868782edt.36.2022.05.03.06.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 06:04:58 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathan@marek.ca, tdas@codeaurora.org,
        anischal@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Dmitry Baryshkov <dmityr.baryshkov@linaro.org>
Subject: [PATCH v2 5/8] dt-bindings: clock: Add Qcom SM8350 GPUCC bindings
Date:   Tue,  3 May 2022 15:04:45 +0200
Message-Id: <20220503130448.520470-5-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220503130448.520470-1-robert.foss@linaro.org>
References: <20220503130448.520470-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for graphics clock controller for
Qualcomm Technology Inc's SM8350 SoCs.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmityr.baryshkov@linaro.org>
---
 .../devicetree/bindings/clock/qcom,gpucc.yaml |  2 +
 include/dt-bindings/clock/qcom,gpucc-sm8350.h | 52 +++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8350.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
index 9ebcb1943b0a..4090cc7ea2ae 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
@@ -20,6 +20,7 @@ description: |
     dt-bindings/clock/qcom,gpucc-sm6350.h
     dt-bindings/clock/qcom,gpucc-sm8150.h
     dt-bindings/clock/qcom,gpucc-sm8250.h
+    dt-bindings/clock/qcom,gpucc-sm8350.h
 
 properties:
   compatible:
@@ -31,6 +32,7 @@ properties:
       - qcom,sm6350-gpucc
       - qcom,sm8150-gpucc
       - qcom,sm8250-gpucc
+      - qcom,sm8350-gpucc
 
   clocks:
     items:
diff --git a/include/dt-bindings/clock/qcom,gpucc-sm8350.h b/include/dt-bindings/clock/qcom,gpucc-sm8350.h
new file mode 100644
index 000000000000..d2294e0d527e
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gpucc-sm8350.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8350_H
+#define _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8350_H
+
+/* GPU_CC clocks */
+#define GPU_CC_AHB_CLK			0
+#define GPU_CC_CB_CLK			1
+#define GPU_CC_CRC_AHB_CLK		2
+#define GPU_CC_CX_APB_CLK		3
+#define GPU_CC_CX_GMU_CLK		4
+#define GPU_CC_CX_QDSS_AT_CLK		5
+#define GPU_CC_CX_QDSS_TRIG_CLK		6
+#define GPU_CC_CX_QDSS_TSCTR_CLK	7
+#define GPU_CC_CX_SNOC_DVM_CLK		8
+#define GPU_CC_CXO_AON_CLK		9
+#define GPU_CC_CXO_CLK			10
+#define GPU_CC_FREQ_MEASURE_CLK		11
+#define GPU_CC_GMU_CLK_SRC		12
+#define GPU_CC_GX_GMU_CLK		13
+#define GPU_CC_GX_QDSS_TSCTR_CLK	14
+#define GPU_CC_GX_VSENSE_CLK		15
+#define GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK	16
+#define GPU_CC_HUB_AHB_DIV_CLK_SRC	17
+#define GPU_CC_HUB_AON_CLK		18
+#define GPU_CC_HUB_CLK_SRC		19
+#define GPU_CC_HUB_CX_INT_CLK		20
+#define GPU_CC_HUB_CX_INT_DIV_CLK_SRC	21
+#define GPU_CC_MND1X_0_GFX3D_CLK	22
+#define GPU_CC_MND1X_1_GFX3D_CLK	23
+#define GPU_CC_PLL0			24
+#define GPU_CC_PLL1			25
+#define GPU_CC_SLEEP_CLK		26
+
+/* GPU_CC resets */
+#define GPUCC_GPU_CC_ACD_BCR		0
+#define GPUCC_GPU_CC_CB_BCR		1
+#define GPUCC_GPU_CC_CX_BCR		2
+#define GPUCC_GPU_CC_FAST_HUB_BCR	3
+#define GPUCC_GPU_CC_GFX3D_AON_BCR	4
+#define GPUCC_GPU_CC_GMU_BCR		5
+#define GPUCC_GPU_CC_GX_BCR		6
+#define GPUCC_GPU_CC_XO_BCR		7
+
+/* GPU_CC GDSCRs */
+#define GPU_CX_GDSC			0
+#define GPU_GX_GDSC			1
+
+#endif
-- 
2.34.1

