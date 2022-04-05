Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223784F50B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450955AbiDFBhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347253AbiDENKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:10:44 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D1BA6E37
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:12:19 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KXmjY3Stqz9sTJ;
        Tue,  5 Apr 2022 14:12:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XwgVdGL26zT2; Tue,  5 Apr 2022 14:12:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KXmjY2RwLz9sT7;
        Tue,  5 Apr 2022 14:12:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3B5928B779;
        Tue,  5 Apr 2022 14:12:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZJexvocFpr6n; Tue,  5 Apr 2022 14:12:17 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0CF288B774;
        Tue,  5 Apr 2022 14:12:17 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 235CCBIV352496
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 5 Apr 2022 14:12:11 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 235CCB6d352495;
        Tue, 5 Apr 2022 14:12:11 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5] powerpc/8xx: Remove mpc8xx_pics_init()
Date:   Tue,  5 Apr 2022 14:12:03 +0200
Message-Id: <58300782fe882417695235d42e5fbdeeb6f3cea2.1649160685.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <d3a7dc832d905bed14b35d83410cdb69a7ba20e8.1649160685.git.christophe.leroy@csgroup.eu>
References: <d3a7dc832d905bed14b35d83410cdb69a7ba20e8.1649160685.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1649160722; l=4798; s=20211009; h=from:subject:message-id; bh=pY1fhlB4drjwk/3+pxQE7CefbR+wPtLpYYs8Ip+Getc=; b=cnwhGRM1PoqJ4/7lR965xpIoTBOZKzsRUaeO3R2kujou6NOwDmd07g2hhNk2MeOMOgVuKi2uI/7W faJDjc5VCaPvYOmA1cDXB8ndKTNGG1NqnLHEWr4kSPaK/4sGqQ8h
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpc8xx_pics_init() is now only a trampoline to
mpc8xx_pic_init().

Remove mpc8xx_pics_init() and use mpc8xx_pic_init()
directly.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/8xx/adder875.c        |  2 +-
 arch/powerpc/platforms/8xx/ep88xc.c          |  2 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c      | 14 --------------
 arch/powerpc/platforms/8xx/mpc86xads_setup.c |  2 +-
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |  2 +-
 arch/powerpc/platforms/8xx/mpc8xx.h          |  1 -
 arch/powerpc/platforms/8xx/tqm8xx_setup.c    |  2 +-
 7 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/adder875.c b/arch/powerpc/platforms/8xx/adder875.c
index 651486acb896..9b5c0c181fa3 100644
--- a/arch/powerpc/platforms/8xx/adder875.c
+++ b/arch/powerpc/platforms/8xx/adder875.c
@@ -104,7 +104,7 @@ define_machine(adder875) {
 	.name = "Adder MPC875",
 	.probe = adder875_probe,
 	.setup_arch = adder875_setup,
-	.init_IRQ = mpc8xx_pics_init,
+	.init_IRQ = mpc8xx_pic_init,
 	.get_irq = mpc8xx_get_irq,
 	.restart = mpc8xx_restart,
 	.calibrate_decr = generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/8xx/ep88xc.c b/arch/powerpc/platforms/8xx/ep88xc.c
index ebcf34a14789..7526ef88bd33 100644
--- a/arch/powerpc/platforms/8xx/ep88xc.c
+++ b/arch/powerpc/platforms/8xx/ep88xc.c
@@ -166,7 +166,7 @@ define_machine(ep88xc) {
 	.name = "Embedded Planet EP88xC",
 	.probe = ep88xc_probe,
 	.setup_arch = ep88xc_setup_arch,
-	.init_IRQ = mpc8xx_pics_init,
+	.init_IRQ = mpc8xx_pic_init,
 	.get_irq	= mpc8xx_get_irq,
 	.restart = mpc8xx_restart,
 	.calibrate_decr = mpc8xx_calibrate_decr,
diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index a03ba0ad7312..15a09b15aaa4 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -204,17 +204,3 @@ void __noreturn mpc8xx_restart(char *cmd)
 	in_8(&clk_r->res[0]);
 	panic("Restart failed\n");
 }
-
-/* Initialize the internal interrupt controllers.  The number of
- * interrupts supported can vary with the processor type, and the
- * 82xx family can have up to 64.
- * External interrupts can be either edge or level triggered, and
- * need to be initialized by the appropriate driver.
- */
-void __init mpc8xx_pics_init(void)
-{
-	if (mpc8xx_pic_init()) {
-		printk(KERN_ERR "Failed interrupt 8xx controller  initialization\n");
-		return;
-	}
-}
diff --git a/arch/powerpc/platforms/8xx/mpc86xads_setup.c b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
index 8d02f5ff4481..a82d69e8bb01 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
@@ -140,7 +140,7 @@ define_machine(mpc86x_ads) {
 	.name			= "MPC86x ADS",
 	.probe			= mpc86xads_probe,
 	.setup_arch		= mpc86xads_setup_arch,
-	.init_IRQ		= mpc8xx_pics_init,
+	.init_IRQ		= mpc8xx_pic_init,
 	.get_irq		= mpc8xx_get_irq,
 	.restart		= mpc8xx_restart,
 	.calibrate_decr		= mpc8xx_calibrate_decr,
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index a0c83c1905c6..e02290175a19 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -216,7 +216,7 @@ define_machine(mpc885_ads) {
 	.name			= "Freescale MPC885 ADS",
 	.probe			= mpc885ads_probe,
 	.setup_arch		= mpc885ads_setup_arch,
-	.init_IRQ		= mpc8xx_pics_init,
+	.init_IRQ		= mpc8xx_pic_init,
 	.get_irq		= mpc8xx_get_irq,
 	.restart		= mpc8xx_restart,
 	.calibrate_decr		= mpc8xx_calibrate_decr,
diff --git a/arch/powerpc/platforms/8xx/mpc8xx.h b/arch/powerpc/platforms/8xx/mpc8xx.h
index 31cc2ecace42..79fae3324866 100644
--- a/arch/powerpc/platforms/8xx/mpc8xx.h
+++ b/arch/powerpc/platforms/8xx/mpc8xx.h
@@ -15,7 +15,6 @@ extern void __noreturn mpc8xx_restart(char *cmd);
 extern void mpc8xx_calibrate_decr(void);
 extern int mpc8xx_set_rtc_time(struct rtc_time *tm);
 extern void mpc8xx_get_rtc_time(struct rtc_time *tm);
-extern void mpc8xx_pics_init(void);
 extern unsigned int mpc8xx_get_irq(void);
 
 #endif /* __MPC8xx_H */
diff --git a/arch/powerpc/platforms/8xx/tqm8xx_setup.c b/arch/powerpc/platforms/8xx/tqm8xx_setup.c
index 4cea8b1afa44..7f1131545da1 100644
--- a/arch/powerpc/platforms/8xx/tqm8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/tqm8xx_setup.c
@@ -142,7 +142,7 @@ define_machine(tqm8xx) {
 	.name			= "TQM8xx",
 	.probe			= tqm8xx_probe,
 	.setup_arch		= tqm8xx_setup_arch,
-	.init_IRQ		= mpc8xx_pics_init,
+	.init_IRQ		= mpc8xx_pic_init,
 	.get_irq		= mpc8xx_get_irq,
 	.restart		= mpc8xx_restart,
 	.calibrate_decr		= mpc8xx_calibrate_decr,
-- 
2.35.1

