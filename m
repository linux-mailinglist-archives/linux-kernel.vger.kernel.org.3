Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FAD4D1E04
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242055AbiCHQ6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243534AbiCHQ5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:57:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536F352B2A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:56:48 -0800 (PST)
Date:   Tue, 08 Mar 2022 16:56:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646758607;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sc/+FuQv3bGeB9ZDvrmW3VP9TSQijY8TnMjLCGiLDB0=;
        b=TxTckkvAnP3gJ0UkIGXI6yK7yBMAB4Lx2JNA8WaEusoK3kG1FC/zseBwERvXByep37uR6h
        QGNg+Jzxy77Uks7oamAqk6/Aa7vpBG9d6vUJ0FQrEuVWA5Ucz5s5Jc4T/xEUKAxFtj45MD
        fg+UyGhLZiyqdqmuKNymOosSmaC4qkHvnJd9DY3KYc6iddibdNh5Zx6p+t9bZi2C1dqDgH
        qjykjajOPKTWZMHa0wUG16Ge979ncYJFMgITiV9YtagkhnUa2rHSt6gK7pO1vIqM/kaNAx
        qDbV9ZUMVITgLpxuRTDaVJfFoMkpS337edYCAyzrvAfO0sBd+Z/4yKwP9868hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646758607;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sc/+FuQv3bGeB9ZDvrmW3VP9TSQijY8TnMjLCGiLDB0=;
        b=MHhrlTHIk4cO34dnEhz7KQTeWsGZGnYQN+8U2MDTDv1d2xuwgWunySUMklKZI689xYr9+/
        qpAHTRNCfBcggIBg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: apple,aic: Add CPU PMU
 per-cpu pseudo-interrupts
Cc:     Rob Herring <robh@kernel.org>, Hector Martin <marcan@marcan.st>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <164675860602.16921.1205276128705301674.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     74703b13f9d2ef286ef588f29295a2fd30b5f295
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/74703b13f9d2ef286ef588f29295a2fd30b5f295
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 01 Nov 2021 19:58:42 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 07 Feb 2022 16:00:41 

dt-bindings: apple,aic: Add CPU PMU per-cpu pseudo-interrupts

Advertise the two pseudo-interrupts that tied to the two PMU
flavours present in the Apple M1 SoC.

We choose the expose two different pseudo-interrupts to the OS
as the e-core PMU is obviously different from the p-core one,
effectively presenting two different devices.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml | 2 ++
 include/dt-bindings/interrupt-controller/apple-aic.h                  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
index 9735902..c7577d4 100644
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
index 604f2bb..bf3aac0 100644
--- a/include/dt-bindings/interrupt-controller/apple-aic.h
+++ b/include/dt-bindings/interrupt-controller/apple-aic.h
@@ -11,5 +11,7 @@
 #define AIC_TMR_HV_VIRT		1
 #define AIC_TMR_GUEST_PHYS	2
 #define AIC_TMR_GUEST_VIRT	3
+#define AIC_CPU_PMU_E		4
+#define AIC_CPU_PMU_P		5
 
 #endif
