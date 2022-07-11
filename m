Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220AC570067
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiGKL0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiGKLZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:25:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F127B2ACF;
        Mon, 11 Jul 2022 03:59:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r129-20020a1c4487000000b003a2d053adcbso4762549wma.4;
        Mon, 11 Jul 2022 03:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kTqxGKRaQ+4R4vGFv2ndzSh2OvA6/IVMbt55ouGGu20=;
        b=cTAZD0es7Gkom7UES3GVk4DHAgKqa4fpHjhnfruyCk6cElvXVB3AGQ73llxREalBjz
         CLTCXnwSYQwTorfOLGMsHT06lUE8Q+6uNeksCL9LZQIe8qIgJWBwDk8FPB6nFUc5vXmq
         FwwiydQRM6M6CWZzD1L3UmE7imKlB6UXvITpqOjzeY0eseaXLbrVxnpJWJkKsiwQI/l3
         8ycLxUEDq7bVo4beQWdjefAi7IX2b4Cr2u1G8NbQklieVXlW+LA7+nahwHrRd87fOyXr
         gSoc5WZC9BybqPmfaOWg1Wk1B7vogAeL55+GiCAyAMZSSq8bYioCFmog/yfcxPoOku/v
         aInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kTqxGKRaQ+4R4vGFv2ndzSh2OvA6/IVMbt55ouGGu20=;
        b=jQoVhLw91YEqBHs+Ma4V8AB6mc65a+kliJpGJc2X5+yWfwUy3vXDTPrGe2Mt/mw9NG
         tJT8SztO/fEqWrjXBQG/viGCB1Mf0jRumBiCL4mbgRmO0GdGbb6qwd6j6TVaktK/1Pn3
         2hAsOdVEaqZIkbjCHX2mgEmNzGkF30bKj9zmYKMw88WHYwcN2noFAQfqPGEH9FnSB3BA
         TRxDtKBxo2lMCKsfffxb7WCteqv/8DEP6WRYLvC04oVqgNVuCQi1QwZ1GOytJ3cKTYgk
         4qeUSaLvYSkD98fG+/JjAZtZ9/IiBscDUTDPWmcJi3B1VciBmuRwncAjkWXMLEFgQQim
         OC+w==
X-Gm-Message-State: AJIora9jsBLiXu0Jn+apMCgsctnNo5Gh/clk5D+kAXW7wdlmpZpxNKFe
        AT4LgmtUNlvGWWbhdrwC+0w=
X-Google-Smtp-Source: AGRyM1uhOQQf/o5f2uaOMpY2jcWb2zxhDgkdYJHMeAGh6gqF+Em11CqLmIlInFCXeWqh/0ebZsnNcA==
X-Received: by 2002:a05:600c:284a:b0:3a1:996f:3cad with SMTP id r10-20020a05600c284a00b003a1996f3cadmr15317824wmb.95.1657537173471;
        Mon, 11 Jul 2022 03:59:33 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-242-cbl.xnet.hr. [94.253.144.242])
        by smtp.googlemail.com with ESMTPSA id w15-20020a1cf60f000000b003a2c7bf0497sm6504617wmc.16.2022.07.11.03.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:59:32 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/4] dt-bindings: mailbox: qcom: set correct #clock-cells
Date:   Mon, 11 Jul 2022 12:59:28 +0200
Message-Id: <20220711105931.43164-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
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

IPQ6018 and IPQ8074 require #clock-cells to be set to 1 as their APSS
clock driver provides multiple clock outputs.

So allow setting 1 as #clock-cells and check that its set to 1 for IPQ6018
and IPQ8074, check others for 0 as its currently.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v3:
* Drop not needed blank line

Changes in v2:
* Correct subject name
---
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 3b5ba7ecc19d..95ecb84e3278 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -50,7 +50,7 @@ properties:
     const: 1
 
   '#clock-cells':
-    const: 0
+    enum: [0, 1]
 
   clock-names:
     minItems: 2
@@ -96,6 +96,21 @@ allOf:
       properties:
         clocks:
           maxItems: 3
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,ipq6018-apcs-apps-global
+            - qcom,ipq8074-apcs-apps-global
+    then:
+      properties:
+        '#clock-cells':
+          const: 1
+    else:
+      properties:
+        '#clock-cells':
+          const: 0
+
 examples:
 
   # Example apcs with msm8996
-- 
2.36.1

