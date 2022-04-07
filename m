Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A519C4F77FD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242116AbiDGHrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242080AbiDGHqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:46:45 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E309B201B3;
        Thu,  7 Apr 2022 00:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649317485;
  x=1680853485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vA3kixnFjao/9/fHNVBKrG7js6zXxb2/Djlg20H3FvE=;
  b=cXt2dZZiZX2S9nCWfCk5JC/4ZWuNU2Hohwnvt6+nNwMHZgpy1/jutTYC
   s/I4VPntNzz2ZhjhDEwz8VdT7E3TIzscwwgLFaf00xVnPmQN2YmiOn27l
   lm6opZufaG6KU4FPGDJG0Q2GGaDtw8IVFPZnkEvXQTWKSipPnuzje0Mqr
   7oYGtF1wh3W6CtzoSsfm0HyYCDuerg4bwIj+1Fi5Py/ceOi/1Ww8aNhmq
   HmoWtCAv+b4iaBU1ZWBzq1YMrsmbnV+qeL0/QpeBhCXEqa0StVlgzN2HP
   1+2VwsC4SkD/BOlCSLoIYXV2VKx83fNKgxi1xgxXomDUWfu2TyqhGK+ao
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <krzk@kernel.org>, <tglx@linutronix.de>,
        <daniel.lezcano@linaro.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <alim.akhtar@samsung.com>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: timer: exynos4210-mct: Add ARTPEC-8 MCT support
Date:   Thu, 7 Apr 2022 09:44:29 +0200
Message-ID: <20220407074432.424578-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220407074432.424578-1-vincent.whitchurch@axis.com>
References: <20220407074432.424578-1-vincent.whitchurch@axis.com>
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

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
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
index 1584944c7ac4..bcfc849ca087 100644
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
@@ -46,6 +47,19 @@ properties:
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
@@ -75,6 +89,17 @@ required:
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
@@ -102,6 +127,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - axis,artpec8-mct
               - samsung,exynos5260-mct
               - samsung,exynos5420-mct
               - samsung,exynos5433-mct
-- 
2.34.1

