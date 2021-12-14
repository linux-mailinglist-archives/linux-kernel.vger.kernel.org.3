Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7154E474AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbhLNS1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhLNS1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:27:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D7AC061574;
        Tue, 14 Dec 2021 10:27:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 386E1616A1;
        Tue, 14 Dec 2021 18:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912AFC34604;
        Tue, 14 Dec 2021 18:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639506420;
        bh=JUqDleAAmmdXoCD3MpSn26A3e+dzkil8Xshl3lWRacM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DZs2p2u+doCFSWlU6AUx7+7jXEqhFiHKqNGF9eKt66KATiNhGu/BnoiweV9mFUPpL
         ZQjH+BBki2tvbrlHb1wJ3Cl8dOeQh+0sycpoQzBL+yig/6QrD5Q5H0kYagOzVrEjS3
         xACB8XLbRe9nG5A7hNBYpDoR0VDDQwxzWPn30/bQk8obwGqDRPRKb1JtCVjT3YNsag
         GiHzwOPStAo4kw7HDvpGvKpAdIPZn7OS7xxnF0Gf83IrFu3qGQWXnxtnx4EJGh9oRz
         RFmoMfu/sHh0EQXWvZ5qb5yxqZstkhiEa1dMmzakHVTO36TpZbTVFcQ60IKftt43F4
         bD5GKamDzuhEw==
Received: from cfbb000407.r.cam.camfibre.uk ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mxCVu-00C7Tq-PM; Tue, 14 Dec 2021 18:26:58 +0000
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
Subject: [PATCH v3 02/10] dt-bindings: apple,aic: Add CPU PMU per-cpu pseudo-interrupts
Date:   Tue, 14 Dec 2021 18:26:26 +0000
Message-Id: <20211214182634.727330-3-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211214182634.727330-1-maz@kernel.org>
References: <20211214182634.727330-1-maz@kernel.org>
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
Reviewed-by: Hector Martin <marcan@marcan.st>
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

