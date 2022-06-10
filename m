Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2B5546E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350578AbiFJURZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350567AbiFJURU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:17:20 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AF7263DF3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 13:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=hNV1WlueTAONPz2Y8SW3TAXCUDV
        2QsHbUFKgF3Q7K8A=; b=fpqNppWEgz0ms0ypFuFC4b5varfz0sKyROTDibVnEMd
        K37XQzd2KccWm2PBS7V4RM1Sg891IKU8l2wKTMy+btQnvIeS8eb0tAnNZNZ0CmoV
        2YsSf4qMyr8QNP6jwPRam0UkjgBzdOUF8guFG/VsPS4QlzvfMDvigLTbOEGe9A4k
        =
Received: (qmail 365587 invoked from network); 10 Jun 2022 22:17:09 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Jun 2022 22:17:09 +0200
X-UD-Smtp-Session: l3s3148p1@Url1nx3h9ktZD+3R
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: thermal: rcar-gen3-thermal: use positive logic
Date:   Fri, 10 Jun 2022 22:17:00 +0200
Message-Id: <20220610201701.7946-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When handling the V3U/r8a779a0 exception, avoid using 'not:' because
then its subschemas are far away in the 'else:' branch. Keep them
together using positive logic.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes since v2:
* new patch

Tested with:
make dtbs_check DT_SCHEMA_FILES=thermal/rcar-gen3-thermal.yaml

 .../bindings/thermal/rcar-gen3-thermal.yaml   | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
index 1368d90da0e8..72dc7eb27f8d 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
@@ -57,31 +57,30 @@ required:
   - "#thermal-sensor-cells"
 
 if:
-  not:
-    properties:
-      compatible:
-        contains:
-          enum:
-            - renesas,r8a779a0-thermal
+  properties:
+    compatible:
+      contains:
+        enum:
+          - renesas,r8a779a0-thermal
 then:
   properties:
     reg:
-      minItems: 2
       items:
+        - description: TSC0 registers
         - description: TSC1 registers
         - description: TSC2 registers
         - description: TSC3 registers
-  required:
-    - interrupts
+        - description: TSC4 registers
 else:
   properties:
     reg:
+      minItems: 2
       items:
-        - description: TSC0 registers
         - description: TSC1 registers
         - description: TSC2 registers
         - description: TSC3 registers
-        - description: TSC4 registers
+  required:
+    - interrupts
 
 additionalProperties: false
 
-- 
2.35.1

