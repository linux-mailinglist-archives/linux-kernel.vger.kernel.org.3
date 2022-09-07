Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E065AFA3E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiIGCuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiIGCup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:50:45 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21B67A535;
        Tue,  6 Sep 2022 19:50:43 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id l16so6954492ilj.2;
        Tue, 06 Sep 2022 19:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vJDBXnovG4Z5ADf3FUeK88wTNu6W40lgK1DC9Nn817Q=;
        b=q0AHnDZ7wYM3ueGaet/aHw4TsKG5colpARqageAbcNPXSqkBHeJr+T45MyM0KsJ+6u
         7xuPYde7UmKzfrhc6y78dDdwE4tWZttfuFvXimE3w8z5rBXMlEqvpVuqPjluVsS6bhwc
         E+JE8IBuVyylXyo1uonjANEuXQahuKc0mkMjGVuZwUzbIdRMpd1iinkRuGqL/vemYAAQ
         XOhWMM4VPVeyiCNrEvXv+8aIt2SSyTdT7FPfhD2ospKmKHQbU9HfilGwgkvVhE4h5bHp
         0AECal2cLr1zhTrgdk24YKbjoNaomKVWAUGtB92ptOswyL0WDVs7O9/2BNa3Z/kWlTGn
         ORFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vJDBXnovG4Z5ADf3FUeK88wTNu6W40lgK1DC9Nn817Q=;
        b=j6MpicSNdNK3siKtxPj4kJjzycJI7cbr/rb3dyxDwHz0wDBRREY2bXAEKL1Cj4XbgR
         FYTcSQQs1F3tE4BREcaXlPgYJ8fK5tTv4fMLW8pGBbu292fO/RioSz909lRf8lfG/LVV
         9Mawe9SuhmMEHxJCWz4FrVPK05nrhHK1GzJa3Q2Q6ZlQU+HQo1+G+QRtNMHHxgjez9tp
         xBD45xuxUFoV/L3Yxp7V2Rq6BAsGK6HlpUWQneDlmV5emORENl8q7r87jGtDRvGCrh0E
         kevX+jtVjiYIDcWZmIMzduXl1tmdcjTTsnlwOO4GFw7a8vorx4CS/T0bhLq/Rr06tVib
         0UdQ==
X-Gm-Message-State: ACgBeo3Uez9uhkALZFxNgwxcBTHhhWfFozcIkzckCYxDsqRAwXvKtk0s
        vCdPCcS4qJl1P1mGe7z5uT0=
X-Google-Smtp-Source: AA6agR7qMl6gJknV4RcjhrwOXKmIk4AJkmvXleSkpEgxVlZcajBAWhSn8CHQuHYFy6Aq3aX9FQ0rww==
X-Received: by 2002:a92:cb8e:0:b0:2f1:8533:4e1 with SMTP id z14-20020a92cb8e000000b002f1853304e1mr844482ilo.33.1662519043299;
        Tue, 06 Sep 2022 19:50:43 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::4aff])
        by smtp.gmail.com with UTF8SMTPSA id z27-20020a056638215b00b00349f45fcb72sm6425466jaj.11.2022.09.06.19.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 19:50:42 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, caleb@connolly.tech,
        jo@jsfamily.in, Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 1/3] dt-bindings: clock: gcc-sdm845: add sdm670 global clocks
Date:   Tue,  6 Sep 2022 22:50:33 -0400
Message-Id: <20220907025035.15609-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220907025035.15609-1-mailingradian@gmail.com>
References: <20220907025035.15609-1-mailingradian@gmail.com>
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
are some resources that don't. Add the new clock and extra BCR from
Snapdragon 670 and document the differences between the SoC parent clocks.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 .../bindings/clock/qcom,gcc-sdm845.yaml       | 24 +++++++++++++++----
 include/dt-bindings/clock/qcom,gcc-sdm845.h   |  2 ++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml b/Documentation/defaced/bindings/clock/qcom,gcc-sdm845.yaml
index daf7906ebc40..ba94dd32e619 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
@@ -19,23 +19,21 @@ description: |
 
 properties:
   compatible:
-    const: qcom,gcc-sdm845
+    enum:
+      - qcom,gcc-sdm670
+      - qcom,gcc-sdm845
 
   clocks:
     items:
       - description: Board XO source
       - description: Board active XO source
       - description: Sleep clock source
-      - description: PCIE 0 Pipe clock source
-      - description: PCIE 1 Pipe clock source
 
   clock-names:
     items:
       - const: bi_tcxo
       - const: bi_tcxo_ao
       - const: sleep_clk
-      - const: pcie_0_pipe_clk
-      - const: pcie_1_pipe_clk
 
   '#clock-cells':
     const: 1
@@ -63,6 +61,22 @@ required:
   - '#reset-cells'
   - '#power-domain-cells'
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: qcom,gcc-sdm845
+then:
+  properties:
+    clocks:
+      items:
+        - description: PCIE 0 Pipe clock source
+        - description: PCIE 1 Pipe clock source
+    clock-names:
+      items:
+        - const: pcie_0_pipe_clk
+        - const: pcie_1_pipe_clk
+
 additionalProperties: false
 
 examples:
diff --git a/include/dt-bindings/clock/qcom,gcc-sdm845.h b/include/dt-bindings/clock/qcom,gcc-sdm845.h
index 968fa65b9c42..9fef78fd031d 100644
--- a/include/dt-bindings/clock/qcom,gcc-sdm845.h
+++ b/include/dt-bindings/clock/qcom,gcc-sdm845.h
@@ -199,6 +199,7 @@
 #define GCC_QSPI_CNOC_PERIPH_AHB_CLK				189
 #define GCC_LPASS_Q6_AXI_CLK					190
 #define GCC_LPASS_SWAY_CLK					191
+#define GPLL6							192
 
 /* GCC Resets */
 #define GCC_MMSS_BCR						0
@@ -227,6 +228,7 @@
 #define GCC_USB_PHY_CFG_AHB2PHY_BCR				23
 #define GCC_PCIE_0_PHY_BCR					24
 #define GCC_PCIE_1_PHY_BCR					25
+#define GCC_SDCC1_BCR						26
 
 /* GCC GDSCRs */
 #define PCIE_0_GDSC						0
-- 
2.37.3

