Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482554C31DD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiBXQtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiBXQtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:49:10 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146B31A94A5;
        Thu, 24 Feb 2022 08:48:40 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id bg16-20020a05600c3c9000b00380f6f473b0so175283wmb.1;
        Thu, 24 Feb 2022 08:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9jUsMvSJyjDnNMHHbljdznqa7LR3R0B/qy7w2RSz/mk=;
        b=lsyDtV7HtSMst5QQRur1xoQukBkDwtjxdbZYthhPYsxZFQxdMriA6FuDgp7w+V58Pg
         kueKkwvv0VpTwiiJMAAm82hyOi9cJiX7sQ2gn0bBi1Eps5Z03CVzOo+Qo7gNWwZ5bFGW
         PpZg17aokGQh851Tkmeu563oCG1Wc5g18yXQYVjXTDFYWI3SjjyfqmymKgP3ufPdFGpq
         5q4w1thsDyaKEQNPh6WC3189nOx0HzuS9e4W1fiXw5SEq4qyopdV1ChsTgFJnZqK+Anr
         RGxtvbOJpYSkna3RDaLkOlF4a67/4UKANDvZZl7U+Zb4DcFAlpErXErtfXfSEpeSSDOu
         ZWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9jUsMvSJyjDnNMHHbljdznqa7LR3R0B/qy7w2RSz/mk=;
        b=uWhfM7OjGyZmewKc5RjpbcuZPXRtU7btqckpN4L+Bux8xkDg5XtuN4pU1rDdzs2roG
         Nbx3Wn+6FjUqOmUd20Q3GYMcO7CMMZAmZf9ANlQDCPspkjLDeksNcJREqbo/E47Ax/nT
         /g/PJ9Q+PUcu7f0Aw8C/IKnRfM4Jel65VTbqSszo/C3KK9cTOOSze+Oks68gcfP5wT8R
         XecPQcRgci7QiKpj2GT2vZHcxwzCPKafE4N9yOLweI0Liu3Yk2bhrXrke2M1RECGy2j/
         ai0vysouRoXwqTyoj9g1XVodkXP4MzY2NHqvSDgl1faoEXvWwPSCKfzDTmbJS8EWsMSe
         cX/A==
X-Gm-Message-State: AOAM531JLfGNUeh7h04wyk9xLTVdWtiBS4ciSbXqQpU2/EJnjQQFik1L
        qV2Hlu7U4Bkss6jPGbXIico=
X-Google-Smtp-Source: ABdhPJxwoai7eIcfY1jUfIUwCoT+odof+IxRyUjtYdsQVYSufhrjLsnAaNEnhE9UA7r+wSRqO8drZQ==
X-Received: by 2002:a7b:c192:0:b0:380:fa7a:4f7d with SMTP id y18-20020a7bc192000000b00380fa7a4f7dmr3062814wmi.119.1645721318442;
        Thu, 24 Feb 2022 08:48:38 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.140.187])
        by smtp.googlemail.com with ESMTPSA id k18sm2694095wrp.104.2022.02.24.08.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:48:38 -0800 (PST)
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
Subject: [PATCH v5 02/15] dt-bindings: clock: simplify qcom,gcc-apq8064 Documentation
Date:   Thu, 24 Feb 2022 17:48:18 +0100
Message-Id: <20220224164831.21475-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224164831.21475-1-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com>
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

Simplify qcon,gcc-apq8064 Documentation by using qcom,gcc.yaml as a
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
index 4e5903bcd70d..47e1c5332d76 100644
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

