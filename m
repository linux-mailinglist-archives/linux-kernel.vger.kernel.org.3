Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E1855CBAA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345601AbiF1MXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345661AbiF1MX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:23:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBE31D312;
        Tue, 28 Jun 2022 05:23:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 310A2B81E06;
        Tue, 28 Jun 2022 12:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B11C341CA;
        Tue, 28 Jun 2022 12:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656419005;
        bh=SmqaQDNLD/5+VbZXpZxV6RGZ6+ob/LvJ25zs+IIEgoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YVCm1kwexQmPi05+mfii6ESvEleglXwgOHzBVhuvhGo4HP0VCgTMC+pJS//xGUXO9
         l4lvreqRYEuyiVXOmdh8nxSwIjl7aNuMTWMG386GCB0uQI6eBZJr+JMsPpyfObx1EI
         dxxYfMr+HsF6XLgPkOc2vcMvy2/9ceuNDlVGQN+qMQIhhp1rCD3JItN0gomxE43fDs
         dW0Myl451THIzRUxYeEjhxLqrTPxu/CyI7sFb0GZm9aDEF/PdhEpmur4J0weH/qqHP
         vnZnKhUP0zsGRAcjJAByrR/0/QNqGVR/4BsAHMUwxt5l6HFOudPo6ucFljBeSFI4a7
         7YNYmxpvZah5w==
From:   Roger Quadros <rogerq@kernel.org>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     vigneshr@ti.com, t-patil@ti.com, sjakhade@cadence.com,
        s-vadapalli@ti.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 5/7] dt-bindings: phy: ti,phy-j721e-wiz: Add support for ti,j7200-wiz-10g
Date:   Tue, 28 Jun 2022 15:22:53 +0300
Message-Id: <20220628122255.24265-6-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220628122255.24265-1-rogerq@kernel.org>
References: <20220628122255.24265-1-rogerq@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ti,j7200-wiz-10g supports an additional reference clock.
Add compatible and the additional clock.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 .../bindings/phy/ti,phy-j721e-wiz.yaml        | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index 3127bb648427..8305654b66c9 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -16,19 +16,23 @@ properties:
       - ti,j721e-wiz-16g
       - ti,j721e-wiz-10g
       - ti,am64-wiz-10g
+      - ti,j7200-wiz-10g
 
   power-domains:
     maxItems: 1
 
   clocks:
-    maxItems: 3
+    minItems: 3
+    maxItems: 4
     description: clock-specifier to represent input to the WIZ
 
   clock-names:
+    minItems: 3
     items:
       - const: fck
       - const: core_ref_clk
       - const: ext_ref_clk
+      - const: core_ref1_clk
 
   num-lanes:
     minimum: 1
@@ -106,6 +110,11 @@ properties:
       - assigned-clocks
       - assigned-clock-parents
 
+  ti,scm:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      phandle to System Control Module for syscon regmap access.
+
 patternProperties:
   "^pll[0|1]-refclk$":
     type: object
@@ -173,6 +182,16 @@ required:
   - "#reset-cells"
   - ranges
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,j7200-wiz-10g
+    then:
+      required:
+        - ti,scm
+
 additionalProperties: false
 
 examples:
-- 
2.17.1

