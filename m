Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876014AE19E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385604AbiBHS5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385440AbiBHS5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:57:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10297C0612C1;
        Tue,  8 Feb 2022 10:57:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86E0C61411;
        Tue,  8 Feb 2022 18:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53CAC340F9;
        Tue,  8 Feb 2022 18:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644346624;
        bh=Zeps+GeA7ULcv2qdwDmPHpGj1ews/29DjRK2xfNXanY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=siBE5wAkKpbkSaStlvAa4XnSEEjqiefGF8kQMgfR3EJxzxhzPe01D2CDx+zxSM5i6
         Dm9vvXPSbmlQvGKRh/FHlhZvLZo2YJzo9Tq6LvqmmIoHOQg9eQRjOR1i6N50I40XgU
         lcGgpbtpswOkKfSKHxw+k+1Jc5mGIjUaD92J70mQ/S2HF1hw8uix9+QkJWXuboLIhA
         fPEvdOWOgtXtsc6a8/4CGF8xZt6++bvRak2dOkrXQa8eJrGl6RZGBGi1fc+fJ+LBox
         7jCsSs+xpBBwoQC2YRA8cz5MN4p3P/HCQpFTHGlA0NqQPK956Y2Jjt9I4SV3K/e3sT
         p6kH3FWVkj5Cw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nHVfi-006MEi-Sd; Tue, 08 Feb 2022 18:57:02 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dougall <dougallj@gmail.com>, kernel-team@android.com,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 03/10] dt-bindings: apple,aic: Add affinity description for per-cpu pseudo-interrupts
Date:   Tue,  8 Feb 2022 18:55:57 +0000
Message-Id: <20220208185604.1097957-4-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220208185604.1097957-1-maz@kernel.org>
References: <20220208185604.1097957-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, robh+dt@kernel.org, tglx@linutronix.de, dougallj@gmail.com, kernel-team@android.com, robh@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the FIQ per-cpu pseudo-interrupts are better described with
a specific affinity, the most obvious candidate being the CPU PMUs.

Augment the AIC binding to be able to specify that affinity in the
interrupt controller node.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 .../interrupt-controller/apple,aic.yaml       | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
index c7577d401786..85c85b694217 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
@@ -70,6 +70,35 @@ properties:
   power-domains:
     maxItems: 1
 
+  affinities:
+    type: object
+    additionalProperties: false
+    description:
+      FIQ affinity can be expressed as a single "affinities" node,
+      containing a set of sub-nodes, one per FIQ with a non-default
+      affinity.
+    patternProperties:
+      "^.+-affinity$":
+        type: object
+        additionalProperties: false
+        properties:
+          apple,fiq-index:
+            description:
+              The interrupt number specified as a FIQ, and for which
+              the affinity is not the default.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            maximum: 5
+
+          cpus:
+            $ref: /schemas/types.yaml#/definitions/phandle-array
+            description:
+              Should be a list of phandles to CPU nodes (as described in
+              Documentation/devicetree/bindings/arm/cpus.yaml).
+
+        required:
+          - fiq-index
+          - cpus
+
 required:
   - compatible
   - '#interrupt-cells'
-- 
2.30.2

