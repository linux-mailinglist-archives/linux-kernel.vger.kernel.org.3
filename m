Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4094E5127
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiCWLUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243815AbiCWLUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:20:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2C5222AD;
        Wed, 23 Mar 2022 04:19:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3338FB81E73;
        Wed, 23 Mar 2022 11:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58774C340F4;
        Wed, 23 Mar 2022 11:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648034342;
        bh=+03pVkLbs0yuhRnH8RNFU31AS/8ObnDLFNLKlsjbZ2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HKjUs0jB2XX/ceZA+FvvVLWF9rIo5TOsm+krntfedyTSeMryLPYfGufnka/DfODQw
         xPzBRNI7PSvJ7MTzcOz9XrMpC4q0v0zuMIX08L90zFBiJz+lnVXzr8zjObRC7naHxy
         PlbNDWEQcOKaqeiwWGSPDUOkFlhALUOBGbHzaQ1vQK5dbu9NNJ5Xa4qbQIMMq1R2G+
         Koe0WS0b739fkeYnx7dyjC7C/NQWVzUijxs+9R7G4c9DLI/YYRezcluhSrsxNrJlm/
         9GtGWK7I04T3fP6Botce+vzHP5zUtwe8nu1YXZpKniw46xb5Bn6YXlIRM4F7k8SHNp
         vlAWeu7VNTWRg==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, robh+dt@kernel.org
Cc:     richard@nod.at, vigneshr@ti.com, kishon@ti.com, nm@ti.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 1/3] dt-bindings: mtd: ti,elm: Convert to yaml
Date:   Wed, 23 Mar 2022 13:18:49 +0200
Message-Id: <20220323111851.4699-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220323111851.4699-1-rogerq@kernel.org>
References: <20220323111851.4699-1-rogerq@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert elm.txt to ti,elm.yaml.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 Documentation/devicetree/bindings/mtd/elm.txt | 16 -------
 .../devicetree/bindings/mtd/ti,elm.yaml       | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/elm.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/ti,elm.yaml

diff --git a/Documentation/devicetree/bindings/mtd/elm.txt b/Documentation/devicetree/bindings/mtd/elm.txt
deleted file mode 100644
index 59ddc61c1076..000000000000
--- a/Documentation/devicetree/bindings/mtd/elm.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Error location module
-
-Required properties:
-- compatible: Must be "ti,am3352-elm"
-- reg: physical base address and size of the registers map.
-- interrupts: Interrupt number for the elm.
-
-Optional properties:
-- ti,hwmods: Name of the hwmod associated to the elm
-
-Example:
-elm: elm@0 {
-	compatible = "ti,am3352-elm";
-	reg = <0x48080000 0x2000>;
-	interrupts = <4>;
-};
diff --git a/Documentation/devicetree/bindings/mtd/ti,elm.yaml b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
new file mode 100644
index 000000000000..24ed0fb84204
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/ti,elm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments Error Location Module (ELM).
+
+maintainers:
+  - Roger Quadros <rogerq@kernel.org>
+
+description:
+  ELM module is used together with GPMC and NAND Flash to detect
+  errors and the location of the error based on BCH algorithms
+  so they can be corrected if possible.
+
+properties:
+  compatible:
+    items:
+      - const: ti,am3352-elm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  ti,hwmods:
+    description:
+      Name of the HWMOD associated with ELM. This is for legacy
+      platforms only.
+    $ref: /schemas/types.yaml#/definitions/string
+    deprecated: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    elm: elm@0 {
+        compatible = "ti,am3352-elm";
+        reg = <0x0 0x2000>;
+        interrupts = <4>;
+    };
-- 
2.17.1

