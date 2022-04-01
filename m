Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21744EFAEF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351777AbiDAUNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351830AbiDAUMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:12:54 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9256B2228C5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:10:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id lr4so8049216ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3WbIpF98MWzltj5pHpPewHmcZnvPZ1G6miuRkL5lhvM=;
        b=h4ZMCbeZbZ15ApsHplBXZOaUReTIfshGysMFKuZp9Hp1V+jLNLTT1gTGKc0Owu7wuQ
         WFCA5FbmdrHCT+14khiTiGkaRFYpzqhFGRQZC3qn7i4aeQWmPT+FSL+Bk1jjjLTLR127
         3gGEc0VGwJPmQHI7VwB/HqUyBhbLM0lp/TJoY/de1rIsiIdRLXYnm9kk2Xe4AZTHKe2G
         cFO3AbsfBFLawzegGTHl5bOgRlvAI1/1VmLZb6ymVZIq1/IKycNRMQt6Cx1M6BMTyrvE
         8vBdgzJodCIqNhvPgD24ZGcqH7u2l3NEs+hv02lt+ccTK4tktRAvFuG6+u3z7HhEOv1y
         kk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3WbIpF98MWzltj5pHpPewHmcZnvPZ1G6miuRkL5lhvM=;
        b=ckBIsMIC+it0pFHWDMt3xHS1VsZp6brFQKDini9llnTx8NTRKmynWlbaoRifbY0pvw
         +qhQSeqGA2zgzCj4vCsufRm+JFVcS9y0Yt2e3XmLEFmBTVuLLKpOw24/P5JVf5sBtW29
         rQAGCMa4JcxgfEYDVakTSM4CZLH/O1/7I9HsQzNhBJuu2uMXeEOtuDCTDQubNTq4raWE
         GEkAby0YCAmxUpb93U8PhBDpkXbMzsL5vwvXwBBf4P5kxnwPrlK4PZsM30tQ0iSPjWAT
         APblfi+wY0yB87yA6b32/33RwaZJvap9T5ZHT02MyouKDsUOP3nsT8EkX9Avv03/t4Nw
         STAw==
X-Gm-Message-State: AOAM531dldjR66xV31LPw0aq2NnKRmyVYNYHcmH/5113vWxQGJADyyYp
        lOkozgEwHOijUUt0ChWVxSzVsg==
X-Google-Smtp-Source: ABdhPJy5lzy8T7QZIDqoRD7PyP2aI6bTp/WQoo/mRBvhtJabBLNpQQRDZ5OTpRdDjJO0ZWvLJsJpBw==
X-Received: by 2002:a17:907:6286:b0:6da:6e24:5e43 with SMTP id nd6-20020a170907628600b006da6e245e43mr1263842ejc.449.1648843856887;
        Fri, 01 Apr 2022 13:10:56 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bx5-20020a0564020b4500b00418fca53406sm1509041edb.27.2022.04.01.13.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:10:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 09/10] dt-bindings: clock: qcom,rpmcc: convert to dtschema
Date:   Fri,  1 Apr 2022 22:10:34 +0200
Message-Id: <20220401201035.189106-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220401201035.189106-1-krzysztof.kozlowski@linaro.org>
References: <20220401201035.189106-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Convert the Qualcomm RPM Clock Controller bindings to DT schema and
include it in parent's schema (SMD RPM).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/clock/qcom,rpmcc.txt  | 63 -----------------
 .../devicetree/bindings/clock/qcom,rpmcc.yaml | 69 +++++++++++++++++++
 .../bindings/soc/qcom/qcom,smd-rpm.yaml       |  4 ++
 3 files changed, 73 insertions(+), 63 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
deleted file mode 100644
index da295c3c004b..000000000000
--- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
+++ /dev/null
@@ -1,63 +0,0 @@
-Qualcomm RPM Clock Controller Binding
-------------------------------------------------
-The RPM is a dedicated hardware engine for managing the shared
-SoC resources in order to keep the lowest power profile. It
-communicates with other hardware subsystems via shared memory
-and accepts clock requests, aggregates the requests and turns
-the clocks on/off or scales them on demand.
-
-Required properties :
-- compatible : shall contain only one of the following. The generic
-               compatible "qcom,rpmcc" should be also included.
-
-			"qcom,rpmcc-mdm9607", "qcom,rpmcc"
-			"qcom,rpmcc-msm8660", "qcom,rpmcc"
-			"qcom,rpmcc-apq8060", "qcom,rpmcc"
-			"qcom,rpmcc-msm8226", "qcom,rpmcc"
-			"qcom,rpmcc-msm8916", "qcom,rpmcc"
-			"qcom,rpmcc-msm8936", "qcom,rpmcc"
-			"qcom,rpmcc-msm8953", "qcom,rpmcc"
-			"qcom,rpmcc-msm8974", "qcom,rpmcc"
-			"qcom,rpmcc-msm8976", "qcom,rpmcc"
-			"qcom,rpmcc-apq8064", "qcom,rpmcc"
-			"qcom,rpmcc-ipq806x", "qcom,rpmcc"
-			"qcom,rpmcc-msm8992",·"qcom,rpmcc"
-			"qcom,rpmcc-msm8994",·"qcom,rpmcc"
-			"qcom,rpmcc-msm8996", "qcom,rpmcc"
-			"qcom,rpmcc-msm8998", "qcom,rpmcc"
-			"qcom,rpmcc-qcm2290", "qcom,rpmcc"
-			"qcom,rpmcc-qcs404", "qcom,rpmcc"
-			"qcom,rpmcc-sdm660", "qcom,rpmcc"
-			"qcom,rpmcc-sm6115", "qcom,rpmcc"
-			"qcom,rpmcc-sm6125", "qcom,rpmcc"
-
-- #clock-cells : shall contain 1
-
-The clock enumerators are defined in <dt-bindings/clock/qcom,rpmcc.h>
-and come in pairs: FOO_CLK followed by FOO_A_CLK. The latter clock
-is an "active" clock, which means that the consumer only care that the
-clock is available when the apps CPU subsystem is active, i.e. not
-suspended or in deep idle. If it is important that the clock keeps running
-during system suspend, you need to specify the non-active clock, the one
-not containing *_A_* in the enumerator name.
-
-Example:
-	smd {
-		compatible = "qcom,smd";
-
-		rpm {
-			interrupts = <0 168 1>;
-			qcom,ipc = <&apcs 8 0>;
-			qcom,smd-edge = <15>;
-
-			rpm_requests {
-				compatible = "qcom,rpm-msm8916";
-				qcom,smd-channels = "rpm_requests";
-
-				rpmcc: clock-controller {
-					compatible = "qcom,rpmcc-msm8916", "qcom,rpmcc";
-					#clock-cells = <1>;
-				};
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
new file mode 100644
index 000000000000..6a492b1ebc7c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,rpmcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPM Clock Controller
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description: |
+  The clock enumerators are defined in <dt-bindings/clock/qcom,rpmcc.h> and
+  come in pairs:: FOO_CLK followed by FOO_A_CLK. The latter clock is
+  an "active" clock, which means that the consumer only care that the clock is
+  available when the apps CPU subsystem is active, i.e. not suspended or in
+  deep idle. If it is important that the clock keeps running during system
+  suspend, you need to specify the non-active clock, the one not containing
+  *_A_* in the enumerator name.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,rpmcc-apq8060
+          - qcom,rpmcc-apq8064
+          - qcom,rpmcc-ipq806x
+          - qcom,rpmcc-mdm9607
+          - qcom,rpmcc-msm8226
+          - qcom,rpmcc-msm8660
+          - qcom,rpmcc-msm8916
+          - qcom,rpmcc-msm8936
+          - qcom,rpmcc-msm8953
+          - qcom,rpmcc-msm8974
+          - qcom,rpmcc-msm8976
+          - qcom,rpmcc-msm8992
+          - qcom,rpmcc-msm8994
+          - qcom,rpmcc-msm8996
+          - qcom,rpmcc-msm8998
+          - qcom,rpmcc-qcm2290
+          - qcom,rpmcc-qcs404
+          - qcom,rpmcc-sdm660
+          - qcom,rpmcc-sm6115
+          - qcom,rpmcc-sm6125
+      - const: qcom,rpmcc
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    rpm {
+        rpm-requests {
+            compatible = "qcom,rpm-msm8916";
+            qcom,smd-channels = "rpm_requests";
+
+            clock-controller {
+                compatible = "qcom,rpmcc-msm8916", "qcom,rpmcc";
+                #clock-cells = <1>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index bf862a11f721..49e9755b3a90 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -45,6 +45,10 @@ properties:
       - qcom,rpm-qcm2290
       - qcom,rpm-qcs404
 
+  clock-controller:
+    $ref: /schemas/clock/qcom,rpmcc.yaml#
+    unevaluatedProperties: false
+
   qcom,smd-channels:
     $ref: /schemas/types.yaml#/definitions/string-array
     description: Channel name used for the RPM communication
-- 
2.32.0

