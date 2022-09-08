Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99705B29F6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 01:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiIHXMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 19:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiIHXMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:12:41 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C02B109D35;
        Thu,  8 Sep 2022 16:12:38 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id j1so14418053qvv.8;
        Thu, 08 Sep 2022 16:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LekhyfyLEGrL/Y4ELhup3OR30c1ArC1GLd91TT7wsJM=;
        b=GDDdHvfaPa928ajEpfAPttUEV8FG+WOP9cOClsshONomluO48RSAKoDjxdIL5uorDH
         wDct4pSyIbYKLhOq2o+/F5E5JgJwIM7Oez39pUDlquD3xA2l4JUraSWV48hkFCRWOGbo
         2eA3abM9RLqUzB9QtMnNFvNcTRXpP8xbW2c3Kh2hmNkkPZve03YY10xnG8Zvp9d3ZGgY
         JVeZ9xYgYjRGgm0N/rm5BdoLCtXq/g0WMk7ScwY8gE+QA9OmmaBmV2AjhHBuKXV021CQ
         aPRvqgTXvUVyylzpHPFRZAqK4cRZh3JCA9WZpxNdtVJaWQIxCJ6BGh3M3ZCpFXnsN5tp
         I2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LekhyfyLEGrL/Y4ELhup3OR30c1ArC1GLd91TT7wsJM=;
        b=tLsAU0nUCpgh/R0xnpXeRGPye5NzIt5Bge2o0JqGQgIbxI/HGcQsuVxAzDeSeUTK7L
         RfKAvFC/9CqlZA8s6P627wwgeO/T6VDGTe3R4ihio+GZWWiFn8qWvXhH0KYcON4SaeCV
         TmYOJUWxf64xDg2H05LLkuunFCA36eeyeBoCujvmuG+4YHsht4vgPuQtxZJkasqNgELj
         jBdL+HeIPcH87zQrHgxO53cA6w0Du4WLsjeOwb1/km1/SBsEG0dVh6FemLsKl/gSsCKR
         LlRT83fLY0r6dfgFbJ1ceKIuOCvThp3oHzr0TdIW9nz5JG+Rj8otUiPAAwd0dkp1ckB6
         w1fQ==
X-Gm-Message-State: ACgBeo2fcDr5V7neFvxbvO2PlcvT/0L8dI1kNf+es3tBxDBWiTdHgweI
        SLgdh/QO9FFv97jPnyB37s4H3PZmij8=
X-Google-Smtp-Source: AA6agR5Xlxpt4VG9p2JKsfgy75lK21+aOI3vSt6zCd/lQEygSYMb/HYXVmKaWp+NrHQynu/ZOisS8A==
X-Received: by 2002:a05:6214:224a:b0:4aa:a7c3:f6c3 with SMTP id c10-20020a056214224a00b004aaa7c3f6c3mr9694581qvc.129.1662678756345;
        Thu, 08 Sep 2022 16:12:36 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::6f2a])
        by smtp.gmail.com with UTF8SMTPSA id t11-20020a05620a034b00b006a5d2eb58b2sm86597qkm.33.2022.09.08.16.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 16:12:35 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Caleb Connolly <caleb@connolly.tech>,
        Joel Selvaraj <jo@jsfamily.in>,
        Richard Acayan <mailingradian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/3] dt-bindings: clock: gcc-sdm845: add sdm670 global clocks
Date:   Thu,  8 Sep 2022 19:12:22 -0400
Message-Id: <20220908231224.209020-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220908231224.209020-1-mailingradian@gmail.com>
References: <20220908231224.209020-1-mailingradian@gmail.com>
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

The Snapdragon 670 clocks will be added into the sdm845 gcc driver. Most
of the new clocks, GDSCs, and resets already have reserved IDs but there
are some resources that don't. Add the new clock from Snapdragon 670 and
document the differences between the SoC parent clocks.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/qcom,gcc-sdm845.yaml       | 61 +++++++++++++++----
 include/dt-bindings/clock/qcom,gcc-sdm845.h   |  1 +
 2 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
index daf7906ebc40..06693c492d02 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
@@ -19,23 +19,17 @@ description: |
 
 properties:
   compatible:
-    const: qcom,gcc-sdm845
+    enum:
+      - qcom,gcc-sdm670
+      - qcom,gcc-sdm845
 
   clocks:
-    items:
-      - description: Board XO source
-      - description: Board active XO source
-      - description: Sleep clock source
-      - description: PCIE 0 Pipe clock source
-      - description: PCIE 1 Pipe clock source
+    minItems: 3
+    maxItems: 5
 
   clock-names:
-    items:
-      - const: bi_tcxo
-      - const: bi_tcxo_ao
-      - const: sleep_clk
-      - const: pcie_0_pipe_clk
-      - const: pcie_1_pipe_clk
+    minItems: 3
+    maxItems: 5
 
   '#clock-cells':
     const: 1
@@ -63,6 +57,47 @@ required:
   - '#reset-cells'
   - '#power-domain-cells'
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,gcc-sdm670
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Board XO source
+            - description: Board active XO source
+            - description: Sleep clock source
+        clock-names:
+          items:
+            - const: bi_tcxo
+            - const: bi_tcxo_ao
+            - const: sleep_clk
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,gcc-sdm845
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Board XO source
+            - description: Board active XO source
+            - description: Sleep clock source
+            - description: PCIE 0 Pipe clock source
+            - description: PCIE 1 Pipe clock source
+        clock-names:
+          items:
+            - const: bi_tcxo
+            - const: bi_tcxo_ao
+            - const: sleep_clk
+            - const: pcie_0_pipe_clk
+            - const: pcie_1_pipe_clk
+
 additionalProperties: false
 
 examples:
diff --git a/include/dt-bindings/clock/qcom,gcc-sdm845.h b/include/dt-bindings/clock/qcom,gcc-sdm845.h
index 968fa65b9c42..d78b899263a2 100644
--- a/include/dt-bindings/clock/qcom,gcc-sdm845.h
+++ b/include/dt-bindings/clock/qcom,gcc-sdm845.h
@@ -199,6 +199,7 @@
 #define GCC_QSPI_CNOC_PERIPH_AHB_CLK				189
 #define GCC_LPASS_Q6_AXI_CLK					190
 #define GCC_LPASS_SWAY_CLK					191
+#define GPLL6							192
 
 /* GCC Resets */
 #define GCC_MMSS_BCR						0
-- 
2.37.3

