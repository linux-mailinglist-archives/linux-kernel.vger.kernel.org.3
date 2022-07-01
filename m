Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B973556348B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiGANpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiGANpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:45:10 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6022252F;
        Fri,  1 Jul 2022 06:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1656683079; bh=/SVrJu8HUYn/zMI8qvKwd54V1yrEpq8nFnuKYXes/pc=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=b41KRg5sTBw7K5FjPQavkHS2bCbclBIg0amKv2imu0vjwmd+UTqEaUKVCHsrC3K7G
         5m7g42EjwDh40QLKvbHJ13Efv2YE80iYvDb9Dq86oRKHDrgmgyb3UJlY7JNigGu4ve
         vWJYx/k6emBiQeU8Zkkqj88pCqzUDinxk2jkS+sk=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via [213.182.55.207]
        Fri,  1 Jul 2022 15:44:39 +0200 (CEST)
X-EA-Auth: hq57Tmjon9Xg6T8opbV135yFjwz0Mkh73U9UC1SW0TG+bpX7AXK06TZDOWK+8eBjxtJ6k1ZvbggAk++YsOAo/FAP99tF+ygWBOF8UYH2Qvw=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH v2 2/6] dt-bindings: leds: is31fl319x: Document variants specificities
Date:   Fri,  1 Jul 2022 15:44:09 +0200
Message-Id: <20220701134415.4017794-3-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220701134415.4017794-1-vincent.knecht@mailoo.org>
References: <20220701134415.4017794-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add si-en compatibles for all chip variants and add conditionals
depending on compatibles to document variants specs:
- possible reg addresses
- whether audio-gain-db is supported or not
- maximum number of leds
- led-max-microamp values

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 .../bindings/leds/issi,is31fl319x.yaml        | 84 ++++++++++++++++++-
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml b/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
index 17635a7cf8af..ddbe8ba9b002 100644
--- a/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
+++ b/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
@@ -28,6 +28,10 @@ properties:
       - issi,is31fl3193
       - issi,is31fl3196
       - issi,is31fl3199
+      - si-en,sn3190
+      - si-en,sn3191
+      - si-en,sn3193
+      - si-en,sn3196
       - si-en,sn3199
 
   reg:
@@ -61,8 +65,6 @@ patternProperties:
         maximum: 9
 
       led-max-microamp:
-        default: 20000
-        enum: [5000, 10000, 15000, 20000, 25000, 30000, 35000, 40000]
         description:
           Note that a driver will take the lowest of all LED limits
           since the chip has a single global setting. The lowest value
@@ -71,6 +73,84 @@ patternProperties:
           and not the current, which will always have its peak value
           equal to led-max-microamp.
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - issi,is31fl3190
+              - issi,is31fl3191
+              - issi,is31fl3193
+              - si-en,sn3190
+              - si-en,sn3191
+              - si-en,sn3193
+    then:
+      properties:
+        reg:
+          enum: [0x68, 0x69, 0x6a, 0x6b]
+
+        audio-gain-db: false
+
+      patternProperties:
+        "^led@[1-9]$":
+          properties:
+            led-max-microamp:
+              default: 42000
+              enum: [5000, 10000, 17500, 30000, 42000]
+    else:
+      properties:
+        reg:
+          enum: [0x64, 0x65, 0x66, 0x67]
+
+      patternProperties:
+        "^led@[1-9]$":
+          properties:
+            led-max-microamp:
+              default: 20000
+              enum: [5000, 10000, 15000, 20000, 25000, 30000, 35000, 40000]
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - issi,is31fl3190
+              - issi,is31fl3191
+              - si-en,sn3190
+              - si-en,sn3191
+    then:
+      patternProperties:
+        "^led@[1-9]$":
+          properties:
+            reg:
+              maximum: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - issi,is31fl3193
+              - si-en,sn3193
+    then:
+      patternProperties:
+        "^led@[1-9]$":
+          properties:
+            reg:
+              maximum: 3
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - issi,is31fl3196
+              - si-en,sn3196
+    then:
+      patternProperties:
+        "^led@[1-9]$":
+          properties:
+            reg:
+              maximum: 6
+
 required:
   - compatible
   - reg
-- 
2.35.3



