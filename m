Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728024E739C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359134AbiCYMi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiCYMiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:38:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560F484EFF;
        Fri, 25 Mar 2022 05:37:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 707AC619F7;
        Fri, 25 Mar 2022 12:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39018C340F3;
        Fri, 25 Mar 2022 12:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648211836;
        bh=OHmFKewARZKJ1dIeeWMfSBVkRhMpf0/mziLxeR6DTV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uIWGdGHLMI3I1tljkx2O9161q8AhbtsaBvGbeNZNiCa4k98iVQ/ElOrBogPbBjCCd
         QHmiPcNslHTB+2MqbWfrxlBudx66YP9Whz/cKHXXitVUYO6l3AjRB7UfcztBENHz0o
         Jw6h9HXIwOZQQ5lUTQfe0Y5mf3pCr19zw0sbwtiHr9yW1X7cJ7D+Fw44TSjd8OphyI
         9l98MmLo098XNtbeKBfMBNWfO2psBqOIGs/lBbDpDupwdJAOp52EhLitLwGOg8xJoJ
         UJgpzNJUMj1ICMU/wiLlv5L8ZqHpnQPvsa60Uu4Dy9/Pmy4kuKz0H3GsrsG59j1HUz
         Kiv+iy5zZqN3g==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, robh+dt@kernel.org
Cc:     richard@nod.at, krzk@kernel.org, vigneshr@ti.com, kishon@ti.com,
        nm@ti.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: mtd: ti,elm: Convert to yaml
Date:   Fri, 25 Mar 2022 14:37:05 +0200
Message-Id: <20220325123707.22020-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220325123707.22020-1-rogerq@kernel.org>
References: <20220325123707.22020-1-rogerq@kernel.org>
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

hwmod framework use is deprecated for new platforms
so mark it so.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 Documentation/devicetree/bindings/mtd/elm.txt | 16 -------
 .../devicetree/bindings/mtd/ti,elm.yaml       | 47 +++++++++++++++++++
 2 files changed, 47 insertions(+), 16 deletions(-)
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
index 000000000000..e36452b742c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
@@ -0,0 +1,47 @@
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
+    const: ti,am3352-elm
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
+    elm: ecc@0 {
+        compatible = "ti,am3352-elm";
+        reg = <0x0 0x2000>;
+        interrupts = <4>;
+    };
-- 
2.17.1

