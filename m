Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43C6546E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350619AbiFJUR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350576AbiFJURV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:17:21 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33549263E8B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 13:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=k1; bh=e
        ta8dtU2rO2nv3AvWtWxiqiF668N5cDYxBtyB21CX/0=; b=Jo2HIGAziZse900i+
        6UKgDhrpwCIAmI+MLqa12vWmd6PZJIt6TBajZa1gQlY8ZNSGbBG+zDvP/NU1hvip
        qNHNg+DC/6/pMcOz+Eshyw4V4W/0EaYoO8rrUDzPAOtL7lCRTVOSkbBJ/T+GPQ54
        2sgQusZJH/RwjQb5NNhMSq/pE4=
Received: (qmail 365634 invoked from network); 10 Jun 2022 22:17:11 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Jun 2022 22:17:11 +0200
X-UD-Smtp-Session: l3s3148p1@W1qKnx3hGiFZD+3R
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
Subject: [PATCH v3 2/2] dt-bindings: thermal: rcar-gen3-thermal: Add r8a779f0 support
Date:   Fri, 10 Jun 2022 22:17:01 +0200
Message-Id: <20220610201701.7946-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220610201701.7946-1-wsa+renesas@sang-engineering.com>
References: <20220610201701.7946-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add support for R-Car S4. The S4 IP differs a bit from its siblings in
such way that it has 3 out of 4 TSC nodes for Linux and the interrupts
are not routed to the INTC-AP but to the ECM.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since V2:
* make interrupts not required for this SoC

Tested with:
make dtbs_check DT_SCHEMA_FILES=thermal/rcar-gen3-thermal.yaml

 .../bindings/thermal/rcar-gen3-thermal.yaml   | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
index 72dc7eb27f8d..0f05f5c886c5 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
@@ -8,9 +8,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Renesas R-Car Gen3 Thermal Sensor
 
 description:
-  On R-Car Gen3 SoCs, the thermal sensor controllers (TSC) control the thermal
-  sensors (THS) which are the analog circuits for measuring temperature (Tj)
-  inside the LSI.
+  On most R-Car Gen3 and later SoCs, the thermal sensor controllers (TSC)
+  control the thermal sensors (THS) which are the analog circuits for
+  measuring temperature (Tj) inside the LSI.
 
 maintainers:
   - Niklas Söderlund <niklas.soderlund@ragnatech.se>
@@ -27,6 +27,7 @@ properties:
       - renesas,r8a77965-thermal # R-Car M3-N
       - renesas,r8a77980-thermal # R-Car V3H
       - renesas,r8a779a0-thermal # R-Car V3U
+      - renesas,r8a779f0-thermal # R-Car S4-8
 
   reg: true
 
@@ -79,8 +80,16 @@ else:
         - description: TSC1 registers
         - description: TSC2 registers
         - description: TSC3 registers
-  required:
-    - interrupts
+  if:
+    not:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r8a779f0-thermal
+  then:
+    required:
+      - interrupts
 
 additionalProperties: false
 
-- 
2.35.1

