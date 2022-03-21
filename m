Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9784E2BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350031AbiCUPUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350063AbiCUPTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:19:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD2B2BDB;
        Mon, 21 Mar 2022 08:18:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q8so9804323wrc.0;
        Mon, 21 Mar 2022 08:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=31lps4Y21piTFXnOFtNqGqL08nWOpZSPVGhTdbNgLbg=;
        b=mDnw/cUqMU6dauqrttWkO3pJEkG+CjnaG4Y9w9THrckWQKJpWwO8uNzRWGCrTCdC46
         gvIjBC6gYJBq0zuuqxF3dahB6oxfxFpcOpN1cUc824mx+mStw4YMCO0NjPVRJ0YqNW24
         CZm3CHX80oMuUTOm+pdtDLKV+L8t1BjWYCo6A/v2hq41UL/Atu16xKfQ23Szy5UUZmTJ
         HR8pRdlpjwXJt6re+EuxrodALxHJI3/zCBR5HbaCJJKNApRt+i997r79NrrfWnBEzFXc
         3K49Ypy8mgRZjN8ElxAY3brGjjLPIIeVhizG2yAciHU3domSSTgYq6yK5pKpSx4b4I2P
         6ASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31lps4Y21piTFXnOFtNqGqL08nWOpZSPVGhTdbNgLbg=;
        b=1OJvclOWxKCT+8biyX+KkjCyWjD7CsGN/H9/sDvGn0LLCBvsWPy5FK1f81T2qj31Ul
         OKWKHn91p3S1lQl/a4X4r1OW9DIsN2vgb8WsoHoYE7RMyxDQeRs6ssSIU4LO+iP0dq1L
         s6KlCgB0ax7maArEgUAiH3j7gesOlSHkL9LBscAqGbDanAJwFJylwVGJNNDZs0DnJn7v
         MW//JFFekEl64nAvKMEe/aH52ti71aB/qf9/HfAv/2OS+S+hkJZvc5JVQkrMCxPi0XV6
         qiXSG1Zc3/J6wNa0oM75NPjVX5EmCd1AitU/3bX8cxkhpls0SShLAoctVctGmpYS9cG6
         loaQ==
X-Gm-Message-State: AOAM533mL4w07gfmPegUqQCHAk/IIp9PASqhzCBQwNMRgabctvji+x3k
        K9+ujNrQA+lx3T4OpIs44Ew=
X-Google-Smtp-Source: ABdhPJwiZtXwDHK2dAwaBHRjkGQ6pZeR+SFSW9i15vQuhr91BATdi7sDdqRDbqr/6lBaAZLo2c7G8Q==
X-Received: by 2002:a05:6000:1e1e:b0:204:203:73ba with SMTP id bj30-20020a0560001e1e00b00204020373bamr8506072wrb.445.1647875880388;
        Mon, 21 Mar 2022 08:18:00 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id 10-20020a5d47aa000000b00204012e4373sm7239729wrb.101.2022.03.21.08.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:17:59 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 14/18] dt-bindings: clock: Convert qcom,krait-cc to yaml
Date:   Mon, 21 Mar 2022 15:48:21 +0100
Message-Id: <20220321144825.11736-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321144825.11736-1-ansuelsmth@gmail.com>
References: <20220321144825.11736-1-ansuelsmth@gmail.com>
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

Convert qcom,krait-cc to yaml Documentation.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/clock/qcom,krait-cc.txt          | 34 -----------
 .../bindings/clock/qcom,krait-cc.yaml         | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 34 deletions(-)
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
index 000000000000..e879bfbe67ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
@@ -0,0 +1,59 @@
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
+      - description: phandle to CPU0 aux clock
+      - description: phandle to CPU1 aux clock
+      - description: phandle to QSB fixed clk
+
+  clock-names:
+    items:
+      - const: hfpll0
+      - const: hfpll1
+      - const: acpu0_aux
+      - const: acpu1_aux
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
+      clocks = <&hfpll0>, <&hfpll1>,
+               <&acpu0_aux>, <&acpu1_aux>, <&qsb>;
+      clock-names = "hfpll0", "hfpll1",
+                    "acpu0_aux", "acpu1_aux", "qsb";
+      #clock-cells = <1>;
+    };
+...
-- 
2.34.1

