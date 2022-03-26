Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12D64E7FED
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 09:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiCZIJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 04:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiCZIJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 04:09:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD72632EFE;
        Sat, 26 Mar 2022 01:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F1A9B81123;
        Sat, 26 Mar 2022 08:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5255DC34111;
        Sat, 26 Mar 2022 08:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648282062;
        bh=gr9HchemhlHv/PQFsx5RRjuRl/DHTMwiXnwOfg3j+ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=It5KV9kPNYm7RhNQVTe7cIzRFDFdtthuOV8V4V004ekTLCBKbgBsDHEdVzqnRRCOK
         a97Cs5YHsROi9+/708bNV9zzIjZC0xPuIhvrYZV2u0WRE/7b3JficOgxM8WfQtVmcs
         ID1y62wPWqKzlI5ur+cm5EO0L+FUFh8r42iQt+RF0Grz7nNWXLKZCCz9utTnarMl9p
         IPtBp+sbHXZaTKB04R1ndbJaS2C62gUD/phVtFMXTOW5PTilrpigikyqZElou1hvSF
         9a+q4HtVpX/e8S1IXxbiBR3lLx154tL2Os17QY3wM1K3o1j80aQNjmE+Aku8mrLGyj
         eYutuvq62H2wg==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, robh+dt@kernel.org
Cc:     krzk@kernel.org, richard@nod.at, vigneshr@ti.com, kishon@ti.com,
        nm@ti.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: mtd: ti,elm: Add support for AM64 ELM
Date:   Sat, 26 Mar 2022 10:07:25 +0200
Message-Id: <20220326080726.30372-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220326080726.30372-1-rogerq@kernel.org>
References: <20220326080726.30372-1-rogerq@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI's AM64 SoC has the Error Locator Module. Add compatible and
related properties to support ELM on AM64 SoC.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 .../devicetree/bindings/mtd/ti,elm.yaml       | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/ti,elm.yaml b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
index 1821395bbfb6..87128c004596 100644
--- a/Documentation/devicetree/bindings/mtd/ti,elm.yaml
+++ b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     enum:
       - ti,am3352-elm
+      - ti,am64-elm
 
   reg:
     maxItems: 1
@@ -25,6 +26,17 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+    description: Functional clock.
+
+  clock-names:
+    items:
+      - const: fck
+
+  power-domains:
+    maxItems: 1
+
   ti,hwmods:
     description:
       Name of the HWMOD associated with ELM. This is for legacy
@@ -37,6 +49,18 @@ required:
   - reg
   - interrupts
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,am64-elm
+    then:
+      required:
+        - clocks
+        - clock-names
+        - power-domains
+
 additionalProperties: false
 
 examples:
-- 
2.17.1

