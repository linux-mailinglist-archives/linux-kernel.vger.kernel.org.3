Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407FF55EB2E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiF1Rm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbiF1Rm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:42:27 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3484D344FC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1656438126; bh=lMwpSrGfCnnfOa6lUw0QItM5hphcTF1x/DI+L0WGC7k=;
        h=X-EA-Auth:From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=Ev2prEgu/vsKUgzh8Y1Gajx29NAAugBn5HWU29FkaDAbnMMhbsbqS7gst9AqGpVhJ
         lIbqvN6E0sqII2xNDg4Nx0u6lcMZ9yHLE6jtDs1lS4JFjupLWiY+AMYprMLTSbYN4v
         bNrDHIGldwGPz34z5ZZpHAH8CE2OEZqvT/61gqWo=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via [213.182.55.207]
        Tue, 28 Jun 2022 19:42:06 +0200 (CEST)
X-EA-Auth: Fw/uCk9+z5eykL9c1RxZPwu2g094OyG4HXUlh5ScTUCrWhKb6VFUNJLuEQloEd669zuS2Y61RV7Tci6jejxIleVDBMwIynhP19g6DXcCDsw=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/7] dt-bindings: leds: is31fl319x: Document variants specificities
Date:   Tue, 28 Jun 2022 19:41:19 +0200
Message-Id: <20220628174124.2819238-5-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220628174124.2819238-1-vincent.knecht@mailoo.org>
References: <20220628174124.2819238-1-vincent.knecht@mailoo.org>
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



