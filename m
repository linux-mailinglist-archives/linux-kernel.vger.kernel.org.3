Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBE355EC7E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbiF1SWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiF1SWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:22:14 -0400
Received: from msg-4.mailo.com (ip-15.mailobj.net [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE76420BE0;
        Tue, 28 Jun 2022 11:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1656440523; bh=lMwpSrGfCnnfOa6lUw0QItM5hphcTF1x/DI+L0WGC7k=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=R8c66a8irKzJckJJFjcaOmvxJ+MwMGiBcvEnGx3hASR0LcKr1+vJOWKIssQrNO5GQ
         esRrh4vsZV+3KdULveGw+Z6IBaV+qR2XOnqJ+LMTyhHKxgWyf0bgL6Z9nukheUX6CK
         yEsNcs3j90K9cPBJEpouy25ZhRKcVN/yKKTO4vvg=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via [213.182.55.207]
        Tue, 28 Jun 2022 20:22:03 +0200 (CEST)
X-EA-Auth: ftK1yHwyaTDgCNjIesKP72Xw9Euc28QTyTzLAFHx55IiRY2zzsNLJ6lfPbf3oFlm1gAfgcoKiSdPMRkyFDurer/ID1UUS1mwyKDKjlUf6xs=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v1 RESEND 4/7] dt-bindings: leds: is31fl319x: Document variants specificities
Date:   Tue, 28 Jun 2022 20:21:42 +0200
Message-Id: <20220628182147.2837180-5-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220628182147.2837180-1-vincent.knecht@mailoo.org>
References: <20220628182147.2837180-1-vincent.knecht@mailoo.org>
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

Add conditionals depending on compatibles to document variants specs:
- possible reg addresses
- whether audio-gain-db is supported or not
- maximum number of leds
- led-max-microamp values

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 .../bindings/leds/issi,is31fl319x.yaml        | 80 ++++++++++++++++++-
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml b/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
index 155df2e5cbd5..940333f2d69c 100644
--- a/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
+++ b/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
@@ -65,8 +65,6 @@ patternProperties:
         maximum: 9
 
       led-max-microamp:
-        default: 20000
-        enum: [5000, 10000, 15000, 20000, 25000, 30000, 35000, 40000]
         description:
           Note that a driver will take the lowest of all LED limits
           since the chip has a single global setting. The lowest value
@@ -75,6 +73,84 @@ patternProperties:
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



