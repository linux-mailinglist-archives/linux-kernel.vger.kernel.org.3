Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546A95AFC36
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiIGGN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiIGGNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:13:18 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2AB97B20
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:13:15 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MMsPj5QCTz9sgw;
        Wed,  7 Sep 2022 08:13:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id H9xiPUbq3jNX; Wed,  7 Sep 2022 08:13:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MMsPj4CW2z9sgv;
        Wed,  7 Sep 2022 08:13:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 821B48B77C;
        Wed,  7 Sep 2022 08:13:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id f1KxZi3iBxI0; Wed,  7 Sep 2022 08:13:13 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6091B8B763;
        Wed,  7 Sep 2022 08:13:13 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2876D6ZP3067010
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 7 Sep 2022 08:13:06 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2876D5wm3067007;
        Wed, 7 Sep 2022 08:13:05 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] powerpc/math-emu: Inhibit W=1 warnings
Date:   Wed,  7 Sep 2022 08:12:54 +0200
Message-Id: <688084b40b5ac88f2905cb207d5dad947d8d34dc.1662531153.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662531168; l=13126; s=20211009; h=from:subject:message-id; bh=b576t2E6RSt/Cyuc4aIIUG2lONaSLKtwKoCaYCrZZWw=; b=9IIqfZH7YWB17O+OgcSURYP6bioY6RGaMhOGrullYBtb1jyh3y/sh+gqtL7Gs1Ru0VIb+i8++sfg hStbZ05nBhsq/coBroKilPBD01XozUMSQHzw9Tc0bxRYjmWIcAi2
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

When building with W=1 you get:

	arch/powerpc/math-emu/fre.c:6:5: error: no previous prototype for 'fre' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fsqrt.c:11:1: error: no previous prototype for 'fsqrt' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fsqrts.c:12:1: error: no previous prototype for 'fsqrts' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/frsqrtes.c:6:5: error: no previous prototype for 'frsqrtes' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/mtfsf.c:10:1: error: no previous prototype for 'mtfsf' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/mtfsfi.c:10:1: error: no previous prototype for 'mtfsfi' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fabs.c:7:1: error: no previous prototype for 'fabs' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fadd.c:11:1: error: no previous prototype for 'fadd' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fadds.c:12:1: error: no previous prototype for 'fadds' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fcmpo.c:11:1: error: no previous prototype for 'fcmpo' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fcmpu.c:11:1: error: no previous prototype for 'fcmpu' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fcmpu.c:14:19: error: variable 'B_c' set but not used [-Werror=unused-but-set-variable]
	arch/powerpc/math-emu/fcmpu.c:13:19: error: variable 'A_c' set but not used [-Werror=unused-but-set-variable]
	arch/powerpc/math-emu/fctiw.c:11:1: error: no previous prototype for 'fctiw' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fctiwz.c:11:1: error: no previous prototype for 'fctiwz' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fdiv.c:11:1: error: no previous prototype for 'fdiv' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fdivs.c:12:1: error: no previous prototype for 'fdivs' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fmadd.c:11:1: error: no previous prototype for 'fmadd' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fmadds.c:12:1: error: no previous prototype for 'fmadds' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fmsub.c:11:1: error: no previous prototype for 'fmsub' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fmsubs.c:12:1: error: no previous prototype for 'fmsubs' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fmul.c:11:1: error: no previous prototype for 'fmul' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fmuls.c:12:1: error: no previous prototype for 'fmuls' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fnabs.c:7:1: error: no previous prototype for 'fnabs' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fneg.c:7:1: error: no previous prototype for 'fneg' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fnmadd.c:11:1: error: no previous prototype for 'fnmadd' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fnmadds.c:12:1: error: no previous prototype for 'fnmadds' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fnmsub.c:11:1: error: no previous prototype for 'fnmsub' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fnmsubs.c:12:1: error: no previous prototype for 'fnmsubs' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fres.c:7:1: error: no previous prototype for 'fres' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/frsp.c:12:1: error: no previous prototype for 'frsp' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fsel.c:11:1: error: no previous prototype for 'fsel' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/lfs.c:12:1: error: no previous prototype for 'lfs' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/frsqrte.c:7:1: error: no previous prototype for 'frsqrte' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fsub.c:11:1: error: no previous prototype for 'fsub' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fsubs.c:12:1: error: no previous prototype for 'fsubs' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/mcrfs.c:10:1: error: no previous prototype for 'mcrfs' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/mffs.c:10:1: error: no previous prototype for 'mffs' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/mtfsb0.c:10:1: error: no previous prototype for 'mtfsb0' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/mtfsb1.c:10:1: error: no previous prototype for 'mtfsb1' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/stfiwx.c:7:1: error: no previous prototype for 'stfiwx' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/stfs.c:12:1: error: no previous prototype for 'stfs' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/fmr.c:7:1: error: no previous prototype for 'fmr' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/lfd.c:10:1: error: no previous prototype for 'lfd' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/stfd.c:7:1: error: no previous prototype for 'stfd' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/math_efp.c:177:5: error: no previous prototype for 'do_spe_mathemu' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/math_efp.c:726:5: error: no previous prototype for 'speround_handler' [-Werror=missing-prototypes]
	arch/powerpc/math-emu/math_efp.c:893:12: error: no previous prototype for 'spe_mathemu_init' [-Werror=missing-prototypes]

Fix the warnings in math_efp.c by adding prototypes of do_spe_mathemu()
and speround_handler() to asm/processor.h and declare spe_mathemu_init()
static.

The other warnings are benign and not worth the churn of fixing them,
expecially the 'unused-but-set-variable' which would impact the core
part of 'math-emu'.

So silence them by adding -Wno-missing-prototypes -Wno-unused-but-set-variable.

But then you get:

	arch/powerpc/math-emu/fre.c:6:5: error: no previous declaration for 'fre' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fsqrt.c:11:1: error: no previous declaration for 'fsqrt' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fsqrts.c:12:1: error: no previous declaration for 'fsqrts' [-Werror=missing-declarations]
	arch/powerpc/math-emu/frsqrtes.c:6:5: error: no previous declaration for 'frsqrtes' [-Werror=missing-declarations]
	arch/powerpc/math-emu/mtfsf.c:10:1: error: no previous declaration for 'mtfsf' [-Werror=missing-declarations]
	arch/powerpc/math-emu/mtfsfi.c:10:1: error: no previous declaration for 'mtfsfi' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fabs.c:7:1: error: no previous declaration for 'fabs' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fadd.c:11:1: error: no previous declaration for 'fadd' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fadds.c:12:1: error: no previous declaration for 'fadds' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fcmpo.c:11:1: error: no previous declaration for 'fcmpo' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fcmpu.c:11:1: error: no previous declaration for 'fcmpu' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fctiw.c:11:1: error: no previous declaration for 'fctiw' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fctiwz.c:11:1: error: no previous declaration for 'fctiwz' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fdiv.c:11:1: error: no previous declaration for 'fdiv' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fdivs.c:12:1: error: no previous declaration for 'fdivs' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fmadd.c:11:1: error: no previous declaration for 'fmadd' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fmadds.c:12:1: error: no previous declaration for 'fmadds' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fmsub.c:11:1: error: no previous declaration for 'fmsub' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fmsubs.c:12:1: error: no previous declaration for 'fmsubs' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fmul.c:11:1: error: no previous declaration for 'fmul' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fmuls.c:12:1: error: no previous declaration for 'fmuls' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fnabs.c:7:1: error: no previous declaration for 'fnabs' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fneg.c:7:1: error: no previous declaration for 'fneg' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fnmadd.c:11:1: error: no previous declaration for 'fnmadd' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fnmadds.c:12:1: error: no previous declaration for 'fnmadds' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fnmsub.c:11:1: error: no previous declaration for 'fnmsub' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fnmsubs.c:12:1: error: no previous declaration for 'fnmsubs' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fres.c:7:1: error: no previous declaration for 'fres' [-Werror=missing-declarations]
	arch/powerpc/math-emu/frsp.c:12:1: error: no previous declaration for 'frsp' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fsel.c:11:1: error: no previous declaration for 'fsel' [-Werror=missing-declarations]
	arch/powerpc/math-emu/lfs.c:12:1: error: no previous declaration for 'lfs' [-Werror=missing-declarations]
	arch/powerpc/math-emu/frsqrte.c:7:1: error: no previous declaration for 'frsqrte' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fsub.c:11:1: error: no previous declaration for 'fsub' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fsubs.c:12:1: error: no previous declaration for 'fsubs' [-Werror=missing-declarations]
	arch/powerpc/math-emu/mcrfs.c:10:1: error: no previous declaration for 'mcrfs' [-Werror=missing-declarations]
	arch/powerpc/math-emu/mffs.c:10:1: error: no previous declaration for 'mffs' [-Werror=missing-declarations]
	arch/powerpc/math-emu/mtfsb0.c:10:1: error: no previous declaration for 'mtfsb0' [-Werror=missing-declarations]
	arch/powerpc/math-emu/mtfsb1.c:10:1: error: no previous declaration for 'mtfsb1' [-Werror=missing-declarations]
	arch/powerpc/math-emu/stfiwx.c:7:1: error: no previous declaration for 'stfiwx' [-Werror=missing-declarations]
	arch/powerpc/math-emu/stfs.c:12:1: error: no previous declaration for 'stfs' [-Werror=missing-declarations]
	arch/powerpc/math-emu/fmr.c:7:1: error: no previous declaration for 'fmr' [-Werror=missing-declarations]
	arch/powerpc/math-emu/lfd.c:10:1: error: no previous declaration for 'lfd' [-Werror=missing-declarations]
	arch/powerpc/math-emu/stfd.c:7:1: error: no previous declaration for 'stfd' [-Werror=missing-declarations]

So also add -Wno-missing-declarations.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/processor.h | 2 ++
 arch/powerpc/kernel/traps.c          | 2 --
 arch/powerpc/math-emu/Makefile       | 7 +++++++
 arch/powerpc/math-emu/math_efp.c     | 2 +-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index fdfaae194ddd..97a77b37daa3 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -426,6 +426,8 @@ extern int fix_alignment(struct pt_regs *);
 #endif
 
 int do_mathemu(struct pt_regs *regs);
+int do_spe_mathemu(struct pt_regs *regs);
+int speround_handler(struct pt_regs *regs);
 
 /* VMX copying */
 int enter_vmx_usercopy(void);
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index dadfcef5d6db..dcf4046f8565 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -2103,7 +2103,6 @@ DEFINE_INTERRUPT_HANDLER(CacheLockingException)
 #ifdef CONFIG_SPE
 DEFINE_INTERRUPT_HANDLER(SPEFloatingPointException)
 {
-	extern int do_spe_mathemu(struct pt_regs *regs);
 	unsigned long spefscr;
 	int fpexc_mode;
 	int code = FPE_FLTUNK;
@@ -2153,7 +2152,6 @@ DEFINE_INTERRUPT_HANDLER(SPEFloatingPointException)
 
 DEFINE_INTERRUPT_HANDLER(SPEFloatingPointRoundException)
 {
-	extern int speround_handler(struct pt_regs *regs);
 	int err;
 
 	interrupt_cond_local_irq_enable(regs);
diff --git a/arch/powerpc/math-emu/Makefile b/arch/powerpc/math-emu/Makefile
index 26fef2e5672e..603e59c3db10 100644
--- a/arch/powerpc/math-emu/Makefile
+++ b/arch/powerpc/math-emu/Makefile
@@ -16,3 +16,10 @@ obj-$(CONFIG_SPE)		+= math_efp.o
 
 CFLAGS_fabs.o = -fno-builtin-fabs
 CFLAGS_math.o = -fno-builtin-fabs
+
+ccflags-remove-y = -Wmissing-prototypes -Wmissing-declarations -Wunused-but-set-variable
+
+ifdef KBUILD_EXTRA_WARN
+CFLAGS_math.o += -Wmissing-prototypes -Wmissing-declarations -Wunused-but-set-variable
+CFLAGS_math_efp.o += -Wmissing-prototypes -Wmissing-declarations -Wunused-but-set-variable
+endif
diff --git a/arch/powerpc/math-emu/math_efp.c b/arch/powerpc/math-emu/math_efp.c
index f01e3475f689..34f62aafe706 100644
--- a/arch/powerpc/math-emu/math_efp.c
+++ b/arch/powerpc/math-emu/math_efp.c
@@ -890,7 +890,7 @@ int speround_handler(struct pt_regs *regs)
 	return 0;
 }
 
-int __init spe_mathemu_init(void)
+static int __init spe_mathemu_init(void)
 {
 	u32 pvr, maj, min;
 
-- 
2.37.1

