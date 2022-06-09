Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D927D544A1A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243857AbiFIL2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243682AbiFIL1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:27:47 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B80616A520;
        Thu,  9 Jun 2022 04:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1654774066;
  x=1686310066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LmOhtt+sTSzENhRVy269JX54eQelMXkrz6ZoDjQkje8=;
  b=DNfaqDHh+SjfmXNCXYlH9lmp7oKyjOizcJ+GX2O8Z9EsMOMqo62TQpXe
   lHz9EHlYHlVzKYk7alyLdQThEQ52gn0/k9dndOPJ5VsJ4ZvNOrXWtHC0v
   myoL9gH0TVf4eUC6XNi59dh5MLpceh42pnFJW5hH8TG59Fi+KpwhBZbtw
   usoyHs9bJz1eb5FMXMtu8Uif3pFkt28N2iJfKbMR4AJ/9P6ciqKV1q1+Q
   Um5XqXXFlqUEQcBiOEPQ7rlVislobos9IcJfZxLL+98OITyEM/9VmKRAG
   F8VeRBdD4u2hlKy37wMbQ/NKf1uZd2YcAn0tw1a+Vs4gc1FvJBXe7XGcu
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <krzysztof.kozlowski@linaro.org>, <tglx@linutronix.de>,
        <daniel.lezcano@linaro.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <alim.akhtar@samsung.com>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: timer: exynos4210-mct: Add ARTPEC-8 MCT support
Date:   Thu, 9 Jun 2022 13:27:35 +0200
Message-ID: <20220609112738.359385-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609112738.359385-1-vincent.whitchurch@axis.com>
References: <20220609112738.359385-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARTPEC-8 has an MCT with 4 global and 8 local timer interrupts.

The SoC has a quad-core Cortex-A53 and a single-core Cortex-A5 which
share one MCT with one global and eight local timers.  The Cortex-A53
and Cortex-A5 do not have cache-coherency between them, and therefore
run two separate kernels.

The Cortex-A53 boots first and starts the global free-running counter
and also registers a clock events device using the global timer.  (This
global timer clock events is usually replaced by arch timer clock events
for each of the cores.)

When the A5 boots (via the A53), it should not use the global timer
interrupts or write to the global timer registers.  This is because even
if there are four global comparators, the control bits for all four are
in the same registers, and we would need to synchronize between the
cpus.  Instead, the global timer FRC (already started by the A53) should
be used as the clock source, and one of the local timers which are not
used by the A53 can be used for clock events on the A5.

To support this hardware, add a compatible for the MCT as well as two
new properties to describe the hardware-mandated sharing of the FRC and
dedicating local timers to specific processors.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
    v4:
    - Add Krzysztof's Reviewed-by.
    
    v3:
    - Add all required bindings for ARTPEC-8 in one patch
    - Rename and split local-timer-only to samsung,local-timers and
      samsung,frc-shared
    - Restrict above properties to the ARTPEC-8 compatible.
    - Rewrite descriptions of properties to hopefully describe hardware.
    
    v2:
    - Use devicetree property instead of module parameter.

 .../timer/samsung,exynos4210-mct.yaml         | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
index 9c81d00b12e0..829bd2227f7c 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -25,6 +25,7 @@ properties:
           - samsung,exynos4412-mct
       - items:
           - enum:
+              - axis,artpec8-mct
               - samsung,exynos3250-mct
               - samsung,exynos5250-mct
               - samsung,exynos5260-mct
@@ -45,6 +46,19 @@ properties:
   reg:
     maxItems: 1
 
+  samsung,frc-shared:
+    type: boolean
+    description: |
+      Indicates that the hardware requires that this processor share the
+      free-running counter with a different (main) processor.
+
+  samsung,local-timers:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 16
+    description: |
+      List of indices of local timers usable from this processor.
+
   interrupts:
     description: |
       Interrupts should be put in specific order. This is, the local timer
@@ -74,6 +88,17 @@ required:
   - reg
 
 allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - axis,artpec8-mct
+    then:
+      properties:
+        samsung,local-timers: false
+        samsung,frc-shared: false
   - if:
       properties:
         compatible:
@@ -101,6 +126,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - axis,artpec8-mct
               - samsung,exynos5260-mct
               - samsung,exynos5420-mct
               - samsung,exynos5433-mct
-- 
2.34.1

