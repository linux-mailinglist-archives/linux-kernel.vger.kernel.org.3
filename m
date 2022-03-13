Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE87E4D77D0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbiCMTHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbiCMTGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:06:48 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1401751336;
        Sun, 13 Mar 2022 12:05:19 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id d10so29556480eje.10;
        Sun, 13 Mar 2022 12:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fMAOn8pwa3go68WYxvsLY0rJlkkqdpP8FjSo1TfU57o=;
        b=iaD4nEn8TP5faC6pEMwcRqU4nV8uFaV9PEQjF0q819n6g75l3gqLEmvDn6SR6sYuV+
         DCgflnLnhDNhSzN5eiK+Q7VHwoGya248hwgVjixVOL9qKnZ75yervrC1g1kdnPqne20P
         AM3Ew2vYgv5Hzo1tDItHRm2Y6gSqHM1tnabgWPs9jcwGPk7WDh9aK9I8MbKNurHbmxgI
         sVM3CW3AyTXWXrcXWAxk/YP7AaSibMyJhBWIqDN47jDKVtoSSqH5G63Fy+KEBund/KBB
         GhQZ/kl0gKvA508xxGZAn8yydbF2gDyMLr60+0TdzARkz06lnHaEfEQgI0ozOU3V4lkW
         OhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fMAOn8pwa3go68WYxvsLY0rJlkkqdpP8FjSo1TfU57o=;
        b=TH2BxIWsWTZGzc2ScvfhWobX0cG8OU8eXHPbsZLN7+U3UoakaBHWWyLTiKCtCA+Mj9
         UEFeyLiCbcIuNd+C1EWcHY7/tgHy4gFB/z+vRsBozvWiNUzr2hRftgK/cJPVc2FL9LfS
         QjEGRjx/fCq3orLlQYPI/td+Hi0jRdXSrq/rzaBjNLj0cxeI6P7Jm4KbiMXX0zT2h1cJ
         EpS4subBKt2HE4GTxgS+r2UPgtJTdlvwvjduKoiY3MfRY17k+Kk2hvCRMgr9wmjKhmAd
         S5FwqKpCChrXSkmyg44Vgh2FKS6o/ujExsOwCq9znjYTciI/wtQR39qBa12RwLnxFgzh
         ivug==
X-Gm-Message-State: AOAM532Wz6VpCRrt5oM0s4AaEwcQaMJf66gMqKWuRCi4c3GDA/k9U5fG
        jNJeXukRe6vhYxAX0QNR3SU=
X-Google-Smtp-Source: ABdhPJzf4xDkkfnpb+RM9j0/iSL/WQMVi2u50zBYUZftCYGQ6lnYQdMtI5BTO8qZKzaTYy27FrYP6A==
X-Received: by 2002:a17:907:8a0d:b0:6d6:dae9:7263 with SMTP id sc13-20020a1709078a0d00b006d6dae97263mr16380785ejc.671.1647198317421;
        Sun, 13 Mar 2022 12:05:17 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm5856697ejk.119.2022.03.13.12.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:05:17 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 14/16] dt-bindings: clock: Convert qcom,krait-cc to yaml
Date:   Sun, 13 Mar 2022 20:04:17 +0100
Message-Id: <20220313190419.2207-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220313190419.2207-1-ansuelsmth@gmail.com>
References: <20220313190419.2207-1-ansuelsmth@gmail.com>
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

