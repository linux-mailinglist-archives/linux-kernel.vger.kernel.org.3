Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF3E464F16
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349642AbhLANxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349657AbhLANxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:53:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77723C06175F;
        Wed,  1 Dec 2021 05:49:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44996B81F44;
        Wed,  1 Dec 2021 13:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EE2C53FD5;
        Wed,  1 Dec 2021 13:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638366561;
        bh=X/TOSABGXyhguNIQ5nvMQgqvEdCTbMIljoksW4btRZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BxXC7aTnIQ/jix3JMmxWaTIx+hrxGIi63Oki+7OfQvq+ZS7hTjc2Ixwh0aP2x6JfI
         WacUH0vI7Tjhtw0lLkxFsTHHUnVR7lDkxZufq/DE1W2g3b/lbloQrRqOXgSziu00oG
         YTDgGeExNhjIgScubaaCLhvkpbA9xSxO0jc1/3EZRy2u1t2xkDcEr7COgD2ce+Wb2i
         pYJAIl3A9cOblLmmU6vdctX8ZyWrAhrtbwpyaFitYq8bEGglS7MEUpwnWhbJ1UnPfO
         idi/yW5hKw0T1gRnW3R5u+Wwvm1KXh7cFdMDin0OLmj7k5/oM61iT5HEWB5DCl0CrY
         E0jeYTELdSbeQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1msPz5-0098G7-2H; Wed, 01 Dec 2021 13:49:19 +0000
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
Subject: [PATCH v2 2/8] dt-bindings: apple,aic: Add CPU PMU per-cpu pseudo-interrupts
Date:   Wed,  1 Dec 2021 13:49:03 +0000
Message-Id: <20211201134909.390490-3-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201134909.390490-1-maz@kernel.org>
References: <20211201134909.390490-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, robh+dt@kernel.org, tglx@linutronix.de, dougallj@gmail.com, kernel-team@android.com, robh@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Advertise the two pseudo-interrupts that tied to the two PMU
flavours present in the Apple M1 SoC.

We choose the expose two different pseudo-interrupts to the OS
as the e-core PMU is obviously different from the p-core one,
effectively presenting two different devices.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/apple,aic.yaml     | 2 ++
 include/dt-bindings/interrupt-controller/apple-aic.h            | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
index cf6c091a07b1..b95e41816953 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
@@ -56,6 +56,8 @@ properties:
           - 1: virtual HV timer
           - 2: physical guest timer
           - 3: virtual guest timer
+          - 4: 'efficient' CPU PMU
+          - 5: 'performance' CPU PMU
 
       The 3rd cell contains the interrupt flags. This is normally
       IRQ_TYPE_LEVEL_HIGH (4).
diff --git a/include/dt-bindings/interrupt-controller/apple-aic.h b/include/dt-bindings/interrupt-controller/apple-aic.h
index 604f2bb30ac0..bf3aac0e5491 100644
--- a/include/dt-bindings/interrupt-controller/apple-aic.h
+++ b/include/dt-bindings/interrupt-controller/apple-aic.h
@@ -11,5 +11,7 @@
 #define AIC_TMR_HV_VIRT		1
 #define AIC_TMR_GUEST_PHYS	2
 #define AIC_TMR_GUEST_VIRT	3
+#define AIC_CPU_PMU_E		4
+#define AIC_CPU_PMU_P		5
 
 #endif
-- 
2.30.2

