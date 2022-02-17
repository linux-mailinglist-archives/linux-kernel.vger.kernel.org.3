Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A834BADA3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiBQX5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:57:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiBQX5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:57:22 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEDF41FB9;
        Thu, 17 Feb 2022 15:57:06 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e3so11733548wra.0;
        Thu, 17 Feb 2022 15:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CV06hFAyLzn/aD8fnpRK/3zrnOQF9gR6OQsK6DYukNA=;
        b=V+lwvo1A5Egv+htx60kGvxcifdXTpIa5CBWkt0yJ2FrezM/e/ukiDDbz5qJLekP4zD
         r7IDssYnvICkxaIvVe/8RBLdmr79Gm3aa0f4WybRMb6Uklz6ZZ0nPE1e5QV11CGmEW5N
         hZYhccgSpQnYmsUx3C0jPjGteZjYcw0bivgEy7gN1hQJwUeBR7TQwy5t5MYc1mbsBhhE
         DCBgxmqkyuM8gA7DrUfJ/WTbeZezYFxuj2mGoGTWr9uW71NmS6g6+uQ+DbE+HI+nOGGR
         y7UoKvKKbC143NUVNwMhxgIPnb8h0uEJkpDvPAv6ZlsufR09MPkhpn/Svvxxp2XkaNe+
         TobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CV06hFAyLzn/aD8fnpRK/3zrnOQF9gR6OQsK6DYukNA=;
        b=Ol6LGrjcg7/36aFQ6qafVa77hB4In0l24atGloydPSf8PMXHymiULcjez973UVTPsg
         VE24N1GxBfJPJgDQtDxZpkpMDtIcem0JK8Ag+jJIhOqfXYNPmCQ1xcNVHBlr1Jrl7Gh3
         tbqf9X3gwTinRDkwRVfXRp8WExHiF9zwpuM6tG9aft63K6EUUN5Wq53yR1PWoIwJ2Bvw
         nzNXwr6roMJsb9wyx5f776CBBgaXNDGFOygGlb9LcKcRaRJUbVpOm5ijzqVqoxqI6otE
         bkLGvjXfFUPEhxZRs/glm82syX72guvKzCwbTYxXMsewymoeWSyWG51hohyjV7WXbMa8
         VwrQ==
X-Gm-Message-State: AOAM5329k/9N+/R9SxlGSo8RM8LhkbXTjrfQn/kVBvt+Zs+C5WfQ+nmJ
        N0XC8YgKC0/rW64fR9zDCTw=
X-Google-Smtp-Source: ABdhPJy6VWta5jhRmRTHLGN5E72tk1P15lUWuXCDDZGvB502jEQ3R/2MXyMRsWOmkV/gQi6qn3GcWg==
X-Received: by 2002:adf:f14e:0:b0:1e4:a64c:c1f8 with SMTP id y14-20020adff14e000000b001e4a64cc1f8mr4054929wro.512.1645142225355;
        Thu, 17 Feb 2022 15:57:05 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id r2sm3691694wmq.24.2022.02.17.15.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:57:04 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/16] dt-bindings: clock: simplify qcom,gcc-apq8064 Documentation
Date:   Fri, 18 Feb 2022 00:56:49 +0100
Message-Id: <20220217235703.26641-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217235703.26641-1-ansuelsmth@gmail.com>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
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

Simplify qcon,gcc-apq8064 Documentation by using qcom,gcc-common.yaml as a
template and remove the compatible from qcom,gcc.yaml

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/clock/qcom,gcc-apq8064.yaml      | 29 +++++--------------
 .../bindings/clock/qcom,gcc-other.yaml        |  3 --
 2 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
index 8e2eac6cbfb9..97936411b6b4 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
@@ -6,6 +6,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Global Clock & Reset Controller Binding for APQ8064
 
+allOf:
+  - $ref: qcom,gcc.yaml#
+
 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
   - Taniya Das <tdas@codeaurora.org>
@@ -17,22 +20,12 @@ description: |
   See also:
   - dt-bindings/clock/qcom,gcc-msm8960.h
   - dt-bindings/reset/qcom,gcc-msm8960.h
+  - dt-bindings/clock/qcom,gcc-apq8084.h
+  - dt-bindings/reset/qcom,gcc-apq8084.h
 
 properties:
   compatible:
-    const: qcom,gcc-apq8064
-
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-  '#power-domain-cells':
-    const: 1
-
-  reg:
-    maxItems: 1
+    const: qcom,gcc-apq8084
 
   nvmem-cells:
     minItems: 1
@@ -53,21 +46,13 @@ properties:
   '#thermal-sensor-cells':
     const: 1
 
-  protected-clocks:
-    description:
-      Protected clock specifier list as per common clock binding.
-
 required:
   - compatible
-  - reg
-  - '#clock-cells'
-  - '#reset-cells'
-  - '#power-domain-cells'
   - nvmem-cells
   - nvmem-cell-names
   - '#thermal-sensor-cells'
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
index 824d80530683..2703b53150d8 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
@@ -15,8 +15,6 @@ description:
   power domains.
 
   See also:
-  - dt-bindings/clock/qcom,gcc-apq8084.h
-  - dt-bindings/reset/qcom,gcc-apq8084.h
   - dt-bindings/clock/qcom,gcc-ipq4019.h
   - dt-bindings/clock/qcom,gcc-ipq6018.h
   - dt-bindings/reset/qcom,gcc-ipq6018.h
@@ -40,7 +38,6 @@ allOf:
 properties:
   compatible:
     enum:
-      - qcom,gcc-apq8084
       - qcom,gcc-ipq4019
       - qcom,gcc-ipq6018
       - qcom,gcc-ipq8064
-- 
2.34.1

