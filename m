Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C400F570062
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiGKL0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiGKLZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:25:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38B22AF8;
        Mon, 11 Jul 2022 03:59:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id y22-20020a7bcd96000000b003a2e2725e89so2480589wmj.0;
        Mon, 11 Jul 2022 03:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CMUVv/tE+dGyKOrvqDmuCdHpuwmXgZgMiezQmg+PaDo=;
        b=cPx0TrUmvAftcE5MaNP2oWUkDqOsiHR3GcMp0Khgs1G2knx+LF8gtvmB4VzyCZzh/q
         3Awr+kKVRfKFiRsSh4BccUt3G7dSksUm3eJ10uxHLqCRMb7joCOrD5xo6TB6U9Bh/GrK
         IcaykbPo7CN0JmV/jx4gvp4stBL0TPKzDGEtowqXDc66wuREcAwJ7vpQesqa4RfnvFxc
         USlU9NXEerMqxi6m/guPJN/BCRko9m0lH+e/NcBIedI/kyRRpwY8UwNYg0pbkfzQMGCN
         5GCmLeBd/68vy/ikazh0NpWpVIrdQ3MLLfZBlpDr4BJLzXjY77mwPdxlwIRI4nes8AbE
         cgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CMUVv/tE+dGyKOrvqDmuCdHpuwmXgZgMiezQmg+PaDo=;
        b=PveRDO1EA7vZg49GHmnC3/QNgeg5RW2m4R9GOWMQjEFZ5aTsHFxxIhsqbQcev4ElFl
         fSMoeGoAj/9Jx25SJrffTQwO3hbGYEIRvLZlWQp5fcGxs8cGR6idavq8LzTOYPe666xU
         YBKdg02P2KVKnKWKshPnuppUuffOCebLWqXkifIewM6mPIXY0DbZxHpd2kea/0OXTyqF
         pvavrLQ0DY+pNV3ZuON3t1jrnQYtBemDZrYDAw3koHQYS95SzrConrJu8mfAzRucdFZd
         J2pqFtQS0PktovnbRHw7ZO8eQ69TxLzUs9QW29UJ9VabLto5Z/hFAe0L/26jB8C2+LcI
         njZg==
X-Gm-Message-State: AJIora+r8rwDSDJ3sbIhcdVw/jLMvLU4ZNEsYtWHvvvtfhjcWwn/h8BT
        nUOt+UofMlt9QM49shdrPEA=
X-Google-Smtp-Source: AGRyM1v3HpQpv9UCgB6CfGp4rFla4uENCrT4CsrBLRbNF8KdYqeEYUNkTMqxDe/qeFtbVy4JuztpiQ==
X-Received: by 2002:a05:600c:41c7:b0:3a2:e8fd:fe52 with SMTP id t7-20020a05600c41c700b003a2e8fdfe52mr3133168wmh.123.1657537174480;
        Mon, 11 Jul 2022 03:59:34 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-242-cbl.xnet.hr. [94.253.144.242])
        by smtp.googlemail.com with ESMTPSA id w15-20020a1cf60f000000b003a2c7bf0497sm6504617wmc.16.2022.07.11.03.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:59:34 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v7 2/4] dt-bindings: mailbox: qcom: correct clocks for IPQ6018 and IPQ8074
Date:   Mon, 11 Jul 2022 12:59:29 +0200
Message-Id: <20220711105931.43164-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711105931.43164-1-robimarko@gmail.com>
References: <20220711105931.43164-1-robimarko@gmail.com>
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

IPQ6018 APSS driver is registered by APCS as they share the same register
space, and it uses "pll" and "xo" as inputs.

Correct the allowed clocks for IPQ6018 and IPQ8074 as they share the same
driver to allow "pll" and "xo" as clock-names.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 .../mailbox/qcom,apcs-kpss-global.yaml        | 44 ++++++++++++++-----
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 95ecb84e3278..939ce63fa824 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -41,10 +41,6 @@ properties:
   clocks:
     description: phandles to the parent clocks of the clock driver
     minItems: 2
-    items:
-      - description: primary pll parent of the clock driver
-      - description: auxiliary parent
-      - description: reference clock
 
   '#mbox-cells':
     const: 1
@@ -54,10 +50,6 @@ properties:
 
   clock-names:
     minItems: 2
-    items:
-      - const: pll
-      - const: aux
-      - const: ref
 
 required:
   - compatible
@@ -71,8 +63,6 @@ allOf:
       properties:
         compatible:
           enum:
-            - qcom,ipq6018-apcs-apps-global
-            - qcom,ipq8074-apcs-apps-global
             - qcom,msm8916-apcs-kpss-global
             - qcom,msm8994-apcs-kpss-global
             - qcom,msm8996-apcs-hmss-global
@@ -86,7 +76,13 @@ allOf:
     then:
       properties:
         clocks:
-          maxItems: 2
+          items:
+            - description: primary pll parent of the clock driver
+            - description: auxiliary parent
+        clock-names:
+          items:
+            - const: pll
+            - const: aux
   - if:
       properties:
         compatible:
@@ -95,7 +91,31 @@ allOf:
     then:
       properties:
         clocks:
-          maxItems: 3
+          items:
+            - description: primary pll parent of the clock driver
+            - description: auxiliary parent
+            - description: reference clock
+        clock-names:
+          items:
+            - const: pll
+            - const: aux
+            - const: ref
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,ipq6018-apcs-apps-global
+            - qcom,ipq8074-apcs-apps-global
+    then:
+      properties:
+        clocks:
+          items:
+            - description: primary pll parent of the clock driver
+            - description: XO clock
+        clock-names:
+          items:
+            - const: pll
+            - const: xo
   - if:
       properties:
         compatible:
-- 
2.36.1

