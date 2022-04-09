Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4C54FA6BC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 12:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241304AbiDIKSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 06:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241209AbiDIKSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 06:18:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9178AA94F1;
        Sat,  9 Apr 2022 03:16:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52F49B80122;
        Sat,  9 Apr 2022 10:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EC7C385A4;
        Sat,  9 Apr 2022 10:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649499383;
        bh=fSIERel0hD7IgNycNdkrfOcVGRyjKjmcNIBLPgDbTwY=;
        h=From:To:Cc:Subject:Date:From;
        b=c9iCjm/rZ/S7J2XfjOAWHVA+IEIm7ujXbfqjxbNuXl0CJ3FOh5NI90Mlr4wlyNMDQ
         lWFZM4bFJGm13niF13gDU6/1GZpVjkHnIhOv6ZIXNLFtzAPNJWlYNwpDoyi1K1lHdI
         HKosau6i0kpjuLb6RHSx91QY/wX4JnMnwF8i1k8wltI5+mj3NE2RdIDVh4M3sDQadr
         Pw8Ja8ZVNVeZLzFfu6S4lALmbmWU0/PAYSoq0hEctbKvo5sF0eUmubzQcEUh4RsXPv
         XwKK58+DSbpbW8TWyKCUcXP2iWXGUrfGpqPLehfBdsvI3MMs7DLeV7MBqfbLn1Xkoo
         LQI1Wbgs+2X8Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nd88i-002yJ4-Q8; Sat, 09 Apr 2022 11:16:20 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: [PATCH] dt-bindings: interrupt-controller: arm,gic-v3: Make the v2 compat requirements explicit
Date:   Sat,  9 Apr 2022 11:16:17 +0100
Message-Id: <20220409101617.268796-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org
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

A common mistake when writing a device tree for a platform that is using
GICv3 with ancient CPUs is to overlook the MMIO frames that implement
the GICv2 compatibility feature, because this feature is implemented by
the CPUs and not by the GIC itself.

The compatibility feature itself is optional (all the modern
implementations have dropped it), but is present in all the ARM Ltd
implementations of the ARMv8.0 architecture (A3x, A53, A57, A72, A73),
and many others from various implementers.

Make it explicit that GICC, GICH and GICV are required for these CPUs.
Also take this opportunity to update my email address, as people keep
sending them to the wrong place...

Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
---
 .../bindings/interrupt-controller/arm,gic-v3.yaml         | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index b7197f78e158..3912a89162f0 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ARM Generic Interrupt Controller, version 3
 
 maintainers:
-  - Marc Zyngier <marc.zyngier@arm.com>
+  - Marc Zyngier <maz@kernel.org>
 
 description: |
   AArch64 SMP cores are often associated with a GICv3, providing Private
@@ -78,7 +78,11 @@ properties:
       - GIC Hypervisor interface (GICH)
       - GIC Virtual CPU interface (GICV)
 
-      GICC, GICH and GICV are optional.
+      GICC, GICH and GICV are optional, but must be described if the CPUs
+      support them. Examples of such CPUs are ARM's implementations of the
+      ARMv8.0 architecture such as Cortex-A32, A34, A35, A53, A57, A72 and
+      A73 (this list is not exhaustive).
+
     minItems: 2
     maxItems: 4096   # Should be enough?
 
-- 
2.34.1

