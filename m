Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B955251BC89
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350513AbiEEJyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbiEEJyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:54:14 -0400
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE30327FE9;
        Thu,  5 May 2022 02:50:29 -0700 (PDT)
X-Virus-Scanned: Yes
From:   Sven Schwermer <sven@svenschwermer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1651744226;
        bh=Cju5atHZSKbs0+hWDH/edUW4chChIFgp/6aEsqfLeOU=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=J8oZofZ/VXB6zqcaglqQeDMRUKvGMGXnmDyYkDb+s2f8YbL04jFqlW52WYzfDa0CL
         gAnXpZGfEfIUGEEL9jDbKZ5PYWu7zmg0chw9kDmfQZxPxptoTrp1IsqiraBBUIZqK+
         BfsmvLna9qIFrHSyMe5CndtwmgmdQ/KkIuO8O3VN602skYLZkdKBwUBOWh98+4wdq0
         wUJ7cx3E5H4Li+kMwkiVFSpbCVjvDtslnIc4CcqRG5cWNLOiFY3MuItM/rJsC0iPkY
         NPv0sVEHrLLgJ9GnwLa/VePrEisY+83s1S2LqcwPHjmvDTRYkufPhMkOF10BOuhka9
         3u/gueJt9dr/A==
To:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        schuchmann@schleissheimer.de
Subject: [PATCH v3 1/2] dt-bindings: leds: Add multi-color default-intensities property
Date:   Thu,  5 May 2022 11:50:08 +0200
Message-Id: <eef2dba9633a860063527628a72f6a4523aaf6cd.1651744128.git.sven.schwermer@disruptive-technologies.com>
In-Reply-To: <20220502204616.GA27288@ucw.cz>
References: <20220502204616.GA27288@ucw.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>

This allows to assign intensity values to the individual sub LEDs
(colors) at driver probe time, i.e. most commonly at kernel boot time.
This is crucial for setting a specific color early in the boot process.

Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
---

Notes:
    V1->V2: no changes
    V2->V3:
    - Use color-intensity mapping instead of simple intensity array
    - Add example DTS snippet

 .../bindings/leds/leds-class-multicolor.yaml  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
index f41d021ed677..41050de496f6 100644
--- a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
@@ -31,6 +31,19 @@ patternProperties:
           include/linux/leds/common.h.
         enum: [ 8, 9 ]
 
+      default-intensities:
+        description: |
+          This parameter, if present, sets the initial intensities of the
+          individual colors. The format is a list of pairs, mapping an intensity
+          value to a sub LED identified by its color.
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+        items:
+          minItems: 2
+          maxItems: 2
+          items:
+            - description: color identifier (LED_COLOR_ID_*)
+            - description: intensity value
+
     $ref: "common.yaml#"
 
     required:
@@ -38,4 +51,28 @@ patternProperties:
 
 additionalProperties: true
 
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    multi-led {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      color = <LED_COLOR_ID_RGB>;
+      default-intensities = <LED_COLOR_ID_RED 64>,
+                            <LED_COLOR_ID_BLUE 0>;
+      led@0 {
+        reg = <0>;
+        color = <LED_COLOR_ID_RED>;
+      };
+      led@1 {
+        reg = <1>;
+        color = <LED_COLOR_ID_GREEN>;
+      };
+      led@2 {
+        reg = <2>;
+        color = <LED_COLOR_ID_BLUE>;
+      };
+    };
 ...
-- 
2.36.0

