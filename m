Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2395678F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiGEU4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiGEU4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:56:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF4B14011;
        Tue,  5 Jul 2022 13:56:02 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sb34so23654680ejc.11;
        Tue, 05 Jul 2022 13:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yEYQM6TR6Lv5Jiw6nCrjGX8nWRViVOLatITa68KGyzE=;
        b=gzL6Mbkzc4j3EWv61fLpJlmcDxBJIO8hqhOB+bJsuXPSK4Bqxj8tYYGbBoO645Uqas
         +x1pMYiFy3Tu048BxzRuxsAGMy14Gk3DcbxtSBX/tvHFDWPcZiAWJ/+yr+nXAH9jz1vt
         eH6+BD55goyEDuWHEKMSg07OnEFtpMVUuNrdjZiG+g+c0TB+JYmu/Uxx2+kAjJFPUsq+
         Ds59aPmNvxEmh4L6/YLssYqH3HgMx33Fwyfu1/krOnkxzRNurqjEZRYfygZxa6D55PZl
         QmezTQT/G2pIV2zO1xWuT77CA+z4lnwlKCE8XUJQLuhPVgNxQG5wGduj0zCw/xn4ir0B
         c7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yEYQM6TR6Lv5Jiw6nCrjGX8nWRViVOLatITa68KGyzE=;
        b=KQfE4vGlhU5bwRtEt0izqIEXD3DURP8DHCF/TVRnCgjkn8i/IWLMPCMxdXZXgBvVgw
         yrhVJGqO20qAeClRFOaOsLpq3mq6LQ8/6Cgkuf5aaZWzlf/NdxgdveXCEiRXgI39S6iB
         LotH4qTru0oAZZF7oeGCPHaEFDv4rIRN3UCny7neUN7/BID70uOPNCFVJxVdDnBVno2m
         ybDsror9dw5PQatGSaiNveWpVr2x0lYIUT7jbcpYr9bEhPcZG6U5rLGHVpfV0XvRDphR
         96IQ/SodPzGiPm13rN7c7IzROIjnKOfl2j3iQoc8GRWiqvEptc8L3J81dzvpiv7Kav/k
         l6EQ==
X-Gm-Message-State: AJIora/ZJJF9avNFcmWGwA8TJXNChVIG92e4MhUwv7zS2vUdOpGDlnEf
        U9aFdJ2nYWTWZlQRcOyq+63n78exh+8=
X-Google-Smtp-Source: AGRyM1sj9anNe408c+d34oQAg9RdUzXXWOiVmT1Z1YMcvhx9ubFksw3/p50z5ViQ9pCUFqafeGbmlA==
X-Received: by 2002:a17:907:7636:b0:72a:9297:37d1 with SMTP id jy22-20020a170907763600b0072a929737d1mr23263427ejc.349.1657054561319;
        Tue, 05 Jul 2022 13:56:01 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id dm3-20020a05640222c300b0043a70c51470sm3836956edb.55.2022.07.05.13.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:56:00 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 1/5] dt-bindings: clock: fix wrong clock documentation for qcom,rpmcc
Date:   Tue,  5 Jul 2022 22:28:33 +0200
Message-Id: <20220705202837.667-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705202837.667-1-ansuelsmth@gmail.com>
References: <20220705202837.667-1-ansuelsmth@gmail.com>
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

qcom,rpmcc describe 2 different kind of device.
Currently we have definition for rpm-smd based device but we lack
Documentation for simple rpm based device.

Add the missing clk for ipq806x, apq8060, msm8660 and apq8064 and
provide and additional example.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/clock/qcom,rpmcc.yaml | 77 ++++++++++++++++++-
 1 file changed, 73 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
index 9d296b89a8d0..028eb0277495 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
@@ -48,16 +48,65 @@ properties:
   '#clock-cells':
     const: 1
 
-  clocks:
-    maxItems: 1
+  clocks: true
 
-  clock-names:
-    const: xo
+  clock-names: true
 
 required:
   - compatible
   - '#clock-cells'
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - qcom,rpmcc-apq8060
+          - qcom,rpmcc-ipq806x
+          - qcom,rpmcc-msm8660
+
+then:
+  properties:
+    clocks:
+      description: pxo clock
+
+    clock-names:
+      const: pxo
+
+  required:
+    - clocks
+    - clock-names
+
+else:
+  if:
+    properties:
+      compatible:
+        contains:
+          const: qcom,rpmcc-apq8064
+  then:
+    properties:
+      clocks:
+        items:
+          - description: pxo clock
+          - description: cxo clock
+
+      clock-names:
+        items:
+          - const: pxo
+          - const: cxo
+
+    required:
+      - clocks
+      - clock-names
+
+  else:
+    properties:
+      clocks:
+        description: xo clock
+
+      clock-names:
+        const: xo
+
 additionalProperties: false
 
 examples:
@@ -73,3 +122,23 @@ examples:
             };
         };
     };
+
+  - |
+    rpm {
+        clock-controller {
+            compatible = "qcom,rpmcc-ipq806x", "qcom,rpmcc";
+            #clock-cells = <1>;
+            clocks = <&pxo_board>;
+            clock-names = "pxo";
+        };
+    };
+
+  - |
+    rpm {
+        clock-controller {
+            compatible = "qcom,rpmcc-apq8064", "qcom,rpmcc";
+            #clock-cells = <1>;
+            clocks = <&pxo_board>, <&cxo_board>;
+            clock-names = "pxo", "cxo";
+        };
+    };
-- 
2.36.1

