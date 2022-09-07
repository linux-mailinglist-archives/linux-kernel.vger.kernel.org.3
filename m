Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5AD5B0FF0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 00:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiIGWkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 18:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiIGWj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 18:39:57 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE02322500;
        Wed,  7 Sep 2022 15:39:46 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 10so12700481iou.2;
        Wed, 07 Sep 2022 15:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nJhtURph2clFtTICvm5PxUbfBWsBOsmwiqzfykqgDOM=;
        b=YUK4/ytyK2FQC6H+iSm0k7AsrcMZZQhlKAZBTfMlgw+XFvQBJDagm4wi09cVV3ZyIe
         bqugmfUpkFfUdSlA3yLU4BCrXQXho2OPMdsEXJ54M1pCFgQz8cjbiT1OVS3Sj8CcbbxY
         iq57/5sNx2Z1p8fjYblGoMbxvsVJ3slNpzdE5GW65d3CouTr5kllM+pYwsvFFkvfOcGN
         mP8erPN92ibbdNVM/dr8hPePlceLTU/M95QMa9LRWAymhvQLbofvi1/gokPTBZKVyf3Q
         ZRu6dO3wJY52/86zAZ2B/npJuj2CVXvWNUUr6Lxutwh6fXKGK3yGHfwD13q+d68QAJCi
         pHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nJhtURph2clFtTICvm5PxUbfBWsBOsmwiqzfykqgDOM=;
        b=maZ/xmG1gf9g5d1tMGOTi3p2PkXsK92N7LQhU9s5ab5rKrPpt7IR4U9kXIgRAahofi
         B2t7Tp+oHd3S1C4IXqel9G7aCI9m7KK2ZzjPrxVGRumbZCciC70sOX9vEfdEIQR7AcSM
         gc7Hw1xcixv5n/pkdalZDCJ2rBRGuFo/lNiIIqABxFfKp1/evfhJOjk530kpfW08eXPs
         7oMlDMFa9nfltEjvsHm9191cqQB3uCWkMWK+hpBc/CdU+LgRT7N1QCpRyC7/bt4HzNUx
         9r1NQ2q3QJWpX0+qstY/jPWCmUtqh/H/QMwNJ3+a1Z0tlhjb9VvMlsGiGF9sKLP64+Gi
         gDCw==
X-Gm-Message-State: ACgBeo3InHcKiwFgdT8/9C8dG2UPgpRyz8726RaWi45ZmtH6CzUfm708
        b4PVnQxu9/nlDlCknOQ1T2BlDVcEaQI=
X-Google-Smtp-Source: AA6agR405YV78ta/CWP6Vxv1Z86FTMQwlFd3rEj0PxOhyS/bsjorxYjwSCh3714LQ56EMk9J0mm7tw==
X-Received: by 2002:a05:6638:16c2:b0:351:f0d0:b68b with SMTP id g2-20020a05663816c200b00351f0d0b68bmr3251878jat.60.1662590385871;
        Wed, 07 Sep 2022 15:39:45 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::4aff])
        by smtp.gmail.com with UTF8SMTPSA id i3-20020a02ca03000000b00349eece079dsm7496747jak.35.2022.09.07.15.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 15:39:45 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     andersson@kernel.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, caleb@connolly.tech,
        jo@jsfamily.in, Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: clock: gcc-sdm845: add sdm670 global clocks
Date:   Wed,  7 Sep 2022 18:39:25 -0400
Message-Id: <20220907223927.139858-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220907223927.139858-1-mailingradian@gmail.com>
References: <20220907223927.139858-1-mailingradian@gmail.com>
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
 .../bindings/clock/qcom,gcc-sdm845.yaml       | 60 +++++++++++++++----
 include/dt-bindings/clock/qcom,gcc-sdm845.h   |  2 +
 2 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
index daf7906ebc40..661e89599a10 100644
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
@@ -63,6 +57,46 @@ required:
   - '#reset-cells'
   - '#power-domain-cells'
 
+allOf:
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

