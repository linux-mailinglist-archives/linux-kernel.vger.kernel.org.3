Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B95B474ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbhLNS1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbhLNS1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:27:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BD6C06173E;
        Tue, 14 Dec 2021 10:27:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34B6CB81C53;
        Tue, 14 Dec 2021 18:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F1CC34610;
        Tue, 14 Dec 2021 18:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639506420;
        bh=eE+a2Gf7Eb4EYOYDngrt1iDAhmc9juBU3zk7/0ma9Sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=os5pRyO0rdjqOLkQJWCJ7sJu0uYgcvsGd9/1RFSDShk1VWOiR/x9LfZF2/NIAMYGA
         VVlQe0dxP4u0OkBsPgCzfUOWMeor1rZ7jzoJpgOeDSr+YnmXOLikHVjcblk8HWsX6b
         06DWpUaH52pgfWcR90HGDro7uz8iKio+3noA8qdW3eG/o6BUe/l+JNW+aLrvReKzuk
         rh06pF8C8Vziuhw8dudc04/vxpqvOZDZIR8cgYZFpkDJHG56SYi60xPj1tq5qAAsNK
         TYsgCsPbYd7zWsyKbfasVO7T44Yj5sNLlU4y4D2Z4ADXrsEDw8Zj+kvRsT0/p1Rpns
         pVUJcm+b8jS6A==
Received: from cfbb000407.r.cam.camfibre.uk ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mxCVv-00C7Tq-0M; Tue, 14 Dec 2021 18:26:59 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dougall <dougallj@gmail.com>, kernel-team@android.com
Subject: [PATCH v3 03/10] dt-bindings: apple,aic: Add affinity description for per-cpu pseudo-interrupts
Date:   Tue, 14 Dec 2021 18:26:27 +0000
Message-Id: <20211214182634.727330-4-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211214182634.727330-1-maz@kernel.org>
References: <20211214182634.727330-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, robh+dt@kernel.org, tglx@linutronix.de, dougallj@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the FIQ per-cpu pseudo-interrupts are better described with
a specific affinity, the most obvious candidate being the CPU PMUs.

Augment the AIC binding to be able to specify that affinity in the
interrupt controller node.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 .../interrupt-controller/apple,aic.yaml       | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
index b95e41816953..ac1c82cffa0a 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
@@ -67,6 +67,32 @@ properties:
       Specifies base physical address and size of the AIC registers.
     maxItems: 1
 
+  affinities:
+    type: object
+    description:
+      FIQ affinity can be expressed as a single "affinities" node,
+      containing a set of sub-nodes, one per FIQ with a non-default
+      affinity.
+    patternProperties:
+      "^.+-affinity$":
+        type: object
+        properties:
+          fiq-index:
+            description:
+              The interrupt number specified as a FIQ, and for which
+              the affinity is not the default.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            maximum: 5
+          affinity:
+            $ref: /schemas/types.yaml#/definitions/phandle-array
+            description:
+              Should be a list of phandles to CPU nodes (as described in
+              Documentation/devicetree/bindings/arm/cpus.yaml).
+
+        required:
+          - fiq-index
+          - affinity
+
 required:
   - compatible
   - '#interrupt-cells'
-- 
2.30.2

