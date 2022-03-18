Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3B04DDDF4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbiCRQKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238627AbiCRQKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:10:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531AA13FA9;
        Fri, 18 Mar 2022 09:08:45 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id d10so17885174eje.10;
        Fri, 18 Mar 2022 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fMAOn8pwa3go68WYxvsLY0rJlkkqdpP8FjSo1TfU57o=;
        b=Tgra4fbpbW9t+HZRAw86segcuw0VfmNAIXD5YHR39256d4GYZ6jRq5mda6yC7mWYQ1
         38wYF6XtHAn7ii6r+E28n02Q614VsVdebJwi2gquWnk3ZMMBwEa6OyZc636obr9HlYD1
         kwcj0/daNDs8aIBHhENu4XWnwnrLuJmYre2+KV+2If1J8Amck0jhlDyuuWLPpN3u/NAl
         WLxMezdDq2b2UL4RZaaxerSk8TF+LkEeHXdTTCpSRJ2V9A7OuySPqa+wTqvfvxPbDqhU
         jKfQ30vQ+cNDS309kyFWBBLU1CiGuVTvK/ijisAI9QZYte9RYqNaECvlpRW+6Rroit0O
         TTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fMAOn8pwa3go68WYxvsLY0rJlkkqdpP8FjSo1TfU57o=;
        b=ynOLbfj6fcj/CeJ/uFPz9gFuzUYIf/o//ogD8+Ek6OWh0O9ELX3Fpe+StwHlKVyhPn
         V6oHx0k8tNGWxdG2zrR0u2/JA0mRPEx9a3SA0uraWkYap9qwpl7KWwqWv1jcNwdZmyVM
         8lLrW1XGSWh7lfItSpSz+5rks2ofRcLfckL7w3k6mCbSTjCDb7eOv1wqEJlNL4cGMrg1
         GnNMacw307LMuvlXzsCF8lduqpzN9x/+ZgxRillqglhsb6gejSBknrPQGXLwc4CwiQI3
         qsyFguDL2WBgL7hwufSHMujWyGTEDB8jPRaCMZD1GCdMT9/IWXVmYJu43qWB0IbLbTYV
         LRMQ==
X-Gm-Message-State: AOAM530DzoUu4p3BE0WLMg+qzcdm9+mlbxQJvYOnpMn2/7cc6Tixklbk
        p4hzX8vzRDZvmgzxGuaGfzk=
X-Google-Smtp-Source: ABdhPJxGRu5YdV2nhP6CtQGugP2YPlfhsiru2e+bq88JZH7KtZ35S1O8/ZUUOUYJI0B5PWn5t3M/fA==
X-Received: by 2002:a17:907:9687:b0:6df:8f17:c16b with SMTP id hd7-20020a170907968700b006df8f17c16bmr8238158ejc.363.1647619723638;
        Fri, 18 Mar 2022 09:08:43 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm3754118ejz.199.2022.03.18.09.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:08:43 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 14/16] dt-bindings: clock: Convert qcom,krait-cc to yaml
Date:   Fri, 18 Mar 2022 17:08:25 +0100
Message-Id: <20220318160827.8860-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220318160827.8860-1-ansuelsmth@gmail.com>
References: <20220318160827.8860-1-ansuelsmth@gmail.com>
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

Convert qcom,krait-cc to yaml and add missing l2 clocks and names
definiton.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/clock/qcom,krait-cc.txt          | 34 ----------
 .../bindings/clock/qcom,krait-cc.yaml         | 63 +++++++++++++++++++
 2 files changed, 63 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt b/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
deleted file mode 100644
index 030ba60dab08..000000000000
--- a/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-Krait Clock Controller
-
-PROPERTIES
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-			"qcom,krait-cc-v1"
-			"qcom,krait-cc-v2"
-
-- #clock-cells:
-	Usage: required
-	Value type: <u32>
-	Definition: must be 1
-
-- clocks:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: reference to the clock parents of hfpll, secondary muxes.
-
-- clock-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "hfpll0", "hfpll1", "acpu0_aux", "acpu1_aux", "qsb".
-
-Example:
-
-	kraitcc: clock-controller {
-		compatible = "qcom,krait-cc-v1";
-		clocks = <&hfpll0>, <&hfpll1>, <&acpu0_aux>, <&acpu1_aux>, <qsb>;
-		clock-names = "hfpll0", "hfpll1", "acpu0_aux", "acpu1_aux", "qsb";
-		#clock-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
new file mode 100644
index 000000000000..f89b70ab01ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,krait-cc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Krait Clock Controller
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+description: |
+  Qualcomm Krait Clock Controller used to correctly scale the CPU and the L2
+  rates.
+
+properties:
+  compatible:
+    enum:
+      - qcom,krait-cc-v1
+      - qcom,krait-cc-v2
+
+  clocks:
+    items:
+      - description: phandle to hfpll for CPU0 mux
+      - description: phandle to hfpll for CPU1 mux
+      - description: phandle to hfpll for L2 mux
+      - description: phandle to CPU0 aux clock
+      - description: phandle to CPU1 aux clock
+      - description: phandle to L2 aux clock
+      - description: phandle to QSB fixed clk
+
+  clock-names:
+    items:
+      - const: hfpll0
+      - const: hfpll1
+      - const: hfpll_l2
+      - const: acpu0_aux
+      - const: acpu1_aux
+      - const: acpu_l2_aux
+      - const: qsb
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller {
+      compatible = "qcom,krait-cc-v1";
+      clocks = <&hfpll0>, <&hfpll1>, <&hfpll_l2>,
+               <&acpu0_aux>, <&acpu1_aux>, <&acpu_l2_aux>, <&qsb>;
+      clock-names = "hfpll0", "hfpll1", "hfpll_l2",
+                    "acpu0_aux", "acpu1_aux", "acpu_l2_aux", "qsb";
+      #clock-cells = <1>;
+    };
+...
-- 
2.34.1

