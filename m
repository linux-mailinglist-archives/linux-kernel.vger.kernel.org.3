Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258154B3B97
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 14:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbiBMNfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 08:35:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiBMNfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 08:35:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED825EDF6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 05:35:17 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644759315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3ela7ZpsbnM+/bKOUxwe+phJ8cb5bgrwTXVyFRHDvIQ=;
        b=vFj8NVfrsET5524EG8aseCOj/qK1tslDyUGUxsY/z3PbJSFjb4/H/nE0zhkte/Cm8EzcrH
        GuFuHMaPWzCRB7mB6ncIHkIOFC5MQx469+N6OMYTIjdsFl0FjWW2Gbyu7miDDkvS8daklS
        kPHKIJH0pP05E/s3cOMuZubAHEsG1wOlsVox6A8Fjl/kcIV5ANR6aU++Leu3CigU+jejOQ
        71fQiRbf6J3bYQpGN2DZvo+tCr97J+n5N0D6zwts4caszFKRrU9AxmwzsG7khjUDsELDk2
        oyUZxNeEQGexZvAh9EphHPp1NJk3BsNUHO3rEzQDh9hhOwWb9Dc8uPJcznS4Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644759315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3ela7ZpsbnM+/bKOUxwe+phJ8cb5bgrwTXVyFRHDvIQ=;
        b=Olm/IWUd7Spf1U7zz++ZmhnhMSUlPIB8NVyog/twETYrsatyq6Opt6ooWZFOz/64MgQHNy
        ax/T4+MCxRCvHHCw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for 5.17-rc4
Message-ID: <164475928137.320063.1917060351912448264.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 13 Feb 2022 14:35:15 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-=
02-13

up to:  1e34064b6055: Merge tag 'irqchip-fixes-5.17-2' of git://git.kernel.or=
g/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent


Interrupt chip driver fixes:

  - Don't install an hotplug notifier for GICV3-ITS on systems which do not
    need it to prevent a warning in the notifier about inconsistent state

  - Add the missing device tree matching for the T-HEAD PLIC variant so the
    related SoC is properly supported.


Thanks,

	tglx

------------------>
Guo Ren (2):
      dt-bindings: update riscv plic compatible string
      irqchip/sifive-plic: Add missing thead,c900-plic match string

Marc Zyngier (1):
      irqchip/gic-v3-its: Skip HP notifier when no ITS is registered


 .../interrupt-controller/sifive,plic-1.0.0.yaml     | 21 +++++++++++++++----=
--
 drivers/irqchip/irq-gic-v3-its.c                    |  3 +++
 drivers/irqchip/irq-sifive-plic.c                   |  1 +
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,pl=
ic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive=
,plic-1.0.0.yaml
index 0dfa6b26e099..27092c6a86c4 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.=
0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.=
0.yaml
@@ -35,6 +35,10 @@ description:
   contains a specific memory layout, which is documented in chapter 8 of the
   SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVC=
oreIP.pdf>.
=20
+  The thead,c900-plic is different from sifive,plic-1.0.0 in opensbi, the
+  T-HEAD PLIC implementation requires setting a delegation bit to allow acce=
ss
+  from S-mode. So add thead,c900-plic to distinguish them.
+
 maintainers:
   - Sagar Kadam <sagar.kadam@sifive.com>
   - Paul Walmsley  <paul.walmsley@sifive.com>
@@ -42,12 +46,17 @@ maintainers:
=20
 properties:
   compatible:
-    items:
-      - enum:
-          - sifive,fu540-c000-plic
-          - starfive,jh7100-plic
-          - canaan,k210-plic
-      - const: sifive,plic-1.0.0
+    oneOf:
+      - items:
+          - enum:
+              - sifive,fu540-c000-plic
+              - starfive,jh7100-plic
+              - canaan,k210-plic
+          - const: sifive,plic-1.0.0
+      - items:
+          - enum:
+              - allwinner,sun20i-d1-plic
+          - const: thead,c900-plic
=20
   reg:
     maxItems: 1
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index 9e93ff2b6375..cd772973114a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5517,6 +5517,9 @@ int __init its_lpi_memreserve_init(void)
 	if (!efi_enabled(EFI_CONFIG_TABLES))
 		return 0;
=20
+	if (list_empty(&its_nodes))
+		return 0;
+
 	gic_rdists->cpuhp_memreserve_state =3D CPUHP_INVALID;
 	state =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				  "irqchip/arm/gicv3/memreserve:online",
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-p=
lic.c
index 259065d271ef..09cc98266d30 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -398,3 +398,4 @@ static int __init plic_init(struct device_node *node,
=20
 IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
 IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy system=
s */
+IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_init); /* for firmw=
are driver */

