Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D8F4993EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 21:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386101AbiAXUfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 15:35:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54018 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348693AbiAXUMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:12:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3CE8B8123F;
        Mon, 24 Jan 2022 20:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83020C340F5;
        Mon, 24 Jan 2022 20:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643055158;
        bh=LIpzrBypwYEGVNUjiOpGMHuLMUB4NRzeRBE/q+tX41U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O0w4JTLS/QPzG+PD1NU35JZbHIr5W+1sR2XF3TomuspTnLcw1SSE95XTSH+9A+aYA
         EEwhHMGpY1pSBYOWxDLDh6rm3SrBM4FCg96UgZwnnLlcb1LirMecVjvManY5yQfHng
         pkMggytohHcloxokTUvb5xlqvSGAzrxuR0chBgQVwPqJJubsUvGsZigL/Gsk5FJna3
         04un9rXI/o6KX674qY5mFYorTU3mx61hJOU/uHIbXl0DAkcyDMJjfWsQJsa4aPTlz4
         v6XzxNs+7sEE+O0WR8HUN/WYnizhQxszb/iUc8M6chuTwZyZ912WpN3yokS026Wc8I
         QuzdNqDrCrCMA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nC5hc-002Y3f-JF; Mon, 24 Jan 2022 20:12:36 +0000
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
Subject: [PATCH v4 03/10] dt-bindings: apple,aic: Add affinity description for per-cpu pseudo-interrupts
Date:   Mon, 24 Jan 2022 20:12:24 +0000
Message-Id: <20220124201231.298961-4-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124201231.298961-1-maz@kernel.org>
References: <20220124201231.298961-1-maz@kernel.org>
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
 .../interrupt-controller/apple,aic.yaml       | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
index c7577d401786..d97683eb2c54 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
@@ -70,6 +70,33 @@ properties:
   power-domains:
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

