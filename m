Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABE54D1A67
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347459AbiCHOZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347353AbiCHOZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:25:23 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A236347AF5;
        Tue,  8 Mar 2022 06:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646749467;
  x=1678285467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6KwAXn4jvSph/kkMgeY9egBCzjFV3kNndn+PTRpZ548=;
  b=gKmdEYXwJY8KE9ZYdnBVVQtB70opXBFB+odyd2FHOGMCIoxFBwUyFEa1
   XPgSZNVeLUtEGYmjhhBb625SYjZLOIx7otitfxn5691lBZzcoGl9+Z+0z
   WpbM0YIphiocp0362ZP4M0yVQtjWzFFpWlqQuE6qDox+Fi32ylZMvfEtD
   HvwH3vOuHoT9PfWHb5A7N68h7P7QlyRBeKtX7KerqdF3g/KoaBpGMiNk3
   4/DMvuaBcbLJWGNA5OymjYGNy8iOG2+QUinBq3Qck+rPZ8Zj6BlPRvzaM
   Vx+4vhyt3IqIqkOJBOFs3EVozN4Frnjgw7wQ/hV0Jto63X/YMpbTQQlEx
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <krzysztof.kozlowski@canonical.com>, <tglx@linutronix.de>,
        <daniel.lezcano@linaro.org>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <robh+dt@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2 2/4] dt-bindings: timer: exynos4210-mct: Support using only local timer
Date:   Tue, 8 Mar 2022 15:24:08 +0100
Message-ID: <20220308142410.3193729-3-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220308142410.3193729-1-vincent.whitchurch@axis.com>
References: <20220308142410.3193729-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARTPEC-8 SoC has a quad-core Cortex-A53 and a single-core Cortex-A5
which share one MCT with one global and eight local timers.  The
Cortex-A53 and Cortex-A5 do not have cache-coherency between them, and
therefore run two separate kernels.

The Cortex-A53 boots first and starts the global FRC and also registers
a clock events device using the global timer.  (This global timer clock
events is usually replaced by arch timer clock events for each of the
cores.)

When the A5 boots, we should not use the global timer interrupts or
write to the global timer registers.  This is because even if there are
four global comparators, the control bits for all four are in the same
registers, and we would need to synchronize between the cpus.  Instead,
the global timer FRC (already started by the A53) should be used as the
clock source, and one of the local timers which are not used by the A53
can be used for clock events on the A5.

To support this usecase, add a property to the binding to specify the
first local timer index to be used. If this parameter is non-zero, the
global timer interrupts will also not be used.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
    v2: New.

 .../bindings/timer/samsung,exynos4210-mct.yaml           | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
index dce42f1f7574..46f466081836 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -47,6 +47,15 @@ properties:
   reg:
     maxItems: 1
 
+  local-timer-index:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    maximum: 15     # Last local timer index
+    description: |
+      If present, sets the first local timer index to use.  If this value is
+      set to a non-default value, the global timer will not be used for
+      interrupts.
+
   interrupts:
     description: |
       Interrupts should be put in specific order. This is, the local timer
-- 
2.34.1

