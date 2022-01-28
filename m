Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BE849FF8E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240545AbiA1R3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:29:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44518 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbiA1R3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:29:50 -0500
Date:   Fri, 28 Jan 2022 17:29:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643390989;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iUbt+XsdZt/0I+fpO0xMrokgkgc9LK4Grb7ieRcxOzY=;
        b=WIBbuEDJRyJ9R8AyS2SW9kkNYHI/hOX44bMlMGWP/KhNm9hkz1ANhlFzJCCzuZN2h+1akc
        UFrjPoNr7vWhxD3PDLnhpUU3kNYO2kJqCGtEprNzJxFwLk9oCsn9M6vlIFYnh9MCOn4vO1
        qboYVKI9pt2kP593gvDEbztx6OfQb7WhOeFoGJAkNqjhVOXu3xGsI4Zs5dKhxyhiwuCaQj
        ygIhuVp2gaB1AAoX+Ijy1k02/imAtm3xO++gDuI1xMjLuNDjxb2Sp2kfK7YD/QyGP45npl
        bod4Px5rXdMD5RFZjOLcV1StakSTxSenggJZLeDWaAXNgklPFras6dXtHZCfSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643390989;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iUbt+XsdZt/0I+fpO0xMrokgkgc9LK4Grb7ieRcxOzY=;
        b=L6OVt3Ht5NMNyrYtdeLs5vY5L+nR/3ZMJct38U3SiMC7XRbykEWHMxOQCJrPaYSmhBaGH+
        F6fPWkgGIYAFxYBw==
From:   "irqchip-bot for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] dt-bindings: interrupt-controller:
 sifive,plic: Fix number of interrupts
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3Cf73a0aead89e1426b146c4c64f797aa035868bf0=2E16433?=
 =?utf-8?q?60419=2Egit=2Egeert=40linux-m68k=2Eorg=3E?=
References: =?utf-8?q?=3Cf73a0aead89e1426b146c4c64f797aa035868bf0=2E164336?=
 =?utf-8?q?0419=2Egit=2Egeert=40linux-m68k=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <164339098831.16921.9376678877863309527.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     8fbc16d26d3a1ed3d80553b773be29408750987b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/8fbc16d26d3a1ed3d80553b773be29408750987b
Author:        Geert Uytterhoeven <geert@linux-m68k.org>
AuthorDate:    Fri, 28 Jan 2022 10:03:57 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 28 Jan 2022 17:27:26 

dt-bindings: interrupt-controller: sifive,plic: Fix number of interrupts

The number of interrupts lacks an upper bound, thus assuming one,
causing properly grouped "interrupts-extended" properties to be flagged
as an error by "make dtbs_check".

Fix this by adding the missing "maxItems", using the architectural
maximum of 15872 interrupts.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/f73a0aead89e1426b146c4c64f797aa035868bf0.1643360419.git.geert@linux-m68k.org
---
 Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 08d5a57..5edaa08 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -61,6 +61,7 @@ properties:
 
   interrupts-extended:
     minItems: 1
+    maxItems: 15872
     description:
       Specifies which contexts are connected to the PLIC, with "-1" specifying
       that a context is not present. Each node pointed to should be a
