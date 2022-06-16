Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A4D54D66E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348798AbiFPAxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348429AbiFPAxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:53:51 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561A352E71
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:53:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z17so103584pff.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cvvN8aBgTj9HE/8ZJgUwMRYXoKBSvquSuql4gX904u8=;
        b=m4X8tc/NeQV4uX2ihYpGARyheg93SpNMVBaA/z+4HAdniayLLeti8D1EIlsGvdTmI7
         OGunSmuBHcNa1fceZCkfcknYCf27JwxhewXCg0kQzOEI/bd/gFp/YavdRZBd9i8dRuaa
         UWWR2cdaxdFMxGGmRuLfs+KgyV4f81ZDl2UqJ8vC1jK8oOu8AlO2bibruHvTq52teMay
         vmLoL9VcE01zsyXEombWiXhOfQgn1dX/aakTXqEJkdqH+OHTvZbiyswbEi4xhkL9pTiT
         JqOyz4L1pPrk+6ZBowqLVvI7IMOQ+2dYj61wd3Ki3GJP/bsTLkpmmGL8wAWDQAP1ZJh1
         Olcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cvvN8aBgTj9HE/8ZJgUwMRYXoKBSvquSuql4gX904u8=;
        b=7sMCNhAUZOPwlS/QaNHTCy3Osx25LyW2WRR/v8kEn/8y/kwohba/g7I5R7zwBwTMjz
         LTJyYy4Zy1xkVKTe2VdTry/UlCX7k+8TD37PjxZyejrE5rK6g44MhT8gCBdeUFSE0QfS
         05zA8RUK5RpkJfPKFFkcseO0nU98/OEIeBdYXIJMvOJBqkhQ/t85YHnE/XLTthsuvNc4
         lWYwIKFcahKAxPcnR/Tf1lX/s6avmzLf+HlDSE1NE2Ctw4dC7TmyLlYomcDV1OsUo2lL
         iN9DIHvlSfoyi50XUmUsryqlW2Ew0qp8qED87aPuA+nd6mX9tumEnwFt0KNs1m4QfYrq
         WOmg==
X-Gm-Message-State: AJIora8a1TSQIIp0CDZICPovx7cQ5JXHX6zipKV31gtMzQnC+AP0sWAs
        saUr5BK9UAk87dzhaWxGt7/n7A==
X-Google-Smtp-Source: AGRyM1trMeeEPUM8xA2lwAFvt7jemmODw29ElIK08LzXDNqlwQ4AIXWQuAPAAAOL5K9gcbHeI7raFA==
X-Received: by 2002:a05:6a00:1a8f:b0:51c:2f82:cdba with SMTP id e15-20020a056a001a8f00b0051c2f82cdbamr2259455pfv.85.1655340829859;
        Wed, 15 Jun 2022 17:53:49 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:53:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 02/40] dt-bindings: input: gpio-keys: reference input.yaml and document properties
Date:   Wed, 15 Jun 2022 17:52:55 -0700
Message-Id: <20220616005333.18491-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
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

The original text bindings documented "autorepeat" and "label"
properties (in the device node, beside the nodes with keys).  DTS use
also poll-interval.  Reference the input.yaml to get these top-level
properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/input/gpio-keys.yaml  | 32 +++++++++++--------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
index 27bb5c6ab8d9..e722e681d237 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
@@ -15,6 +15,13 @@ properties:
       - gpio-keys
       - gpio-keys-polled
 
+  autorepeat: true
+
+  label:
+    description: Name of entire device
+
+  poll-interval: true
+
 patternProperties:
   "^(button|event|key|switch|(button|event|key|switch)-[a-z0-9-]+|[a-z0-9-]+-(button|event|key|switch))$":
     $ref: input.yaml#
@@ -94,19 +101,18 @@ patternProperties:
 
     unevaluatedProperties: false
 
-if:
-  properties:
-    compatible:
-      const: gpio-keys-polled
-then:
-  properties:
-    poll-interval:
-      description:
-        Poll interval time in milliseconds
-      $ref: /schemas/types.yaml#/definitions/uint32
-
-  required:
-    - poll-interval
+allOf:
+  - $ref: input.yaml#
+  - if:
+      properties:
+        compatible:
+          const: gpio-keys-polled
+    then:
+      required:
+        - poll-interval
+    else:
+      properties:
+        poll-interval: false
 
 additionalProperties: false
 
-- 
2.34.1

