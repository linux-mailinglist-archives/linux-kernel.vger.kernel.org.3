Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0685056776B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiGETK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiGETKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:10:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E0517596;
        Tue,  5 Jul 2022 12:10:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n4so3994899ejz.10;
        Tue, 05 Jul 2022 12:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CVJmMjKSGPsdpVl5B7dwM8pbpVk/e6e/YzA6OtxjZig=;
        b=CjUSUKMCkTvMMEh/JZQo3huViXUt834Jy9D5OT6Nu/jzsf2ZG0KD4a+5YkVmMFSnDP
         itlzIVqtCdEvp28x4oYuksS6sknZbsjLWu+sqaXJQk2DcFjLMIeO/rfVA3fxenBHir3C
         8PzntEnBB4pWS1kpi3xyIob5UYKoq94yAC2bJpDGRUICgyTvpGENgNC4DqARgmY7j3hw
         0fX9BLO19x2lNWeIWJTvVj507a5favV4IA/hr0gbbRupflDIhhDlki6YJLnFJ9fiNtsn
         JUEjm3D6S5iTpVoo8lmrncz6yuMEcFBitKl4HTsi9Z+Qwl+Fi9kneNsiWRHXR0MGhJ0t
         AG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CVJmMjKSGPsdpVl5B7dwM8pbpVk/e6e/YzA6OtxjZig=;
        b=NkMFTJaxbY8qn5qb7FRSBJTfVUSwxIyihDwNml525AKnpKHSD6U1X3uTo0xVr9qIrT
         Dscc2mLTwKeh8lGIxIdo/1rkj1OuAp4cGuxqR4Fb0jTzXVUswmLobeq/JkDcUICjMD9f
         mSO5RTKCZ/GU0WFwEzJbHfUWieruBmVa+pyyWOyljLj3Pl7OzbKD2HbgSuv1yHUEVlcb
         usEql/guL5mERzo7nryqjfj64asG6LZjJ6F7KtR2SS904YjD8lMdC4HY+z+PaapG5l+i
         VAD4Uz5QdW16cAILdfzeXwpg+6aWe3hbqDAq7Cg8anuz/3eAk7xqQBF1MN4GvHbpwe5j
         hcfA==
X-Gm-Message-State: AJIora/TudzRr+owd73njU7oNHg2w0uwYVN9/EDO+wLb6MXPB/BVB4CB
        1GFShX9FV8rspb/PlcI0WP0=
X-Google-Smtp-Source: AGRyM1sL8YKIDJu6QR1k8rIEqDz9/5ygGkxtzS0/IVZmek0EulNtJ7RbEyeMEij5XFEWhRi1bxLb8g==
X-Received: by 2002:a17:906:4f:b0:712:af2:29d9 with SMTP id 15-20020a170906004f00b007120af229d9mr36201984ejg.751.1657048220335;
        Tue, 05 Jul 2022 12:10:20 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-13.xnet.hr. [88.207.99.13])
        by smtp.googlemail.com with ESMTPSA id es25-20020a056402381900b0043a6b86f024sm4519342edb.67.2022.07.05.12.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 12:10:20 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/3] dt-bindings: clock: Add support for IPQ8074 APSS clock controller
Date:   Tue,  5 Jul 2022 21:10:16 +0200
Message-Id: <20220705191017.1683716-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705191017.1683716-1-robimarko@gmail.com>
References: <20220705191017.1683716-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-binding for the IPQ8074 APSS clock controller which provides
clocks to the CPU cores.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v4:
* Dual license the bindings
* Update the copyright year

Changes in v2:
* Correct subject
---
 include/dt-bindings/clock/qcom,apss-ipq8074.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 include/dt-bindings/clock/qcom,apss-ipq8074.h

diff --git a/include/dt-bindings/clock/qcom,apss-ipq8074.h b/include/dt-bindings/clock/qcom,apss-ipq8074.h
new file mode 100644
index 000000000000..32538c9311ff
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,apss-ipq8074.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_QCA_APSS_IPQ8074_H
+#define _DT_BINDINGS_CLOCK_QCA_APSS_IPQ8074_H
+
+#define APSS_PLL_EARLY				0
+#define APSS_PLL				1
+#define APCS_ALIAS0_CLK_SRC			2
+#define APCS_ALIAS0_CORE_CLK			3
+
+#endif
-- 
2.36.1

