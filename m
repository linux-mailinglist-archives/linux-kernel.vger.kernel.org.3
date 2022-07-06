Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A285689FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiGFNtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiGFNs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:48:56 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34E7BC35
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:48:54 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id rpos2700G4C55Sk01posbB; Wed, 06 Jul 2022 15:48:52 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o95Oe-002LRM-5A; Wed, 06 Jul 2022 15:48:52 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o95Od-009ffu-Mb; Wed, 06 Jul 2022 15:48:51 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Finn Thain <fthain@linux-m68k.org>,
        Laurent Vivier <laurent@vivier.eu>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: Add forward declaration for show_registers()
Date:   Wed,  6 Jul 2022 15:48:50 +0200
Message-Id: <d5b6a7f9af3e82f0ccb67edac09d9ee45d457932.1657114791.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several forward declarations for show_registers() in C source
files.  Replace these by a single common forward declaration in
<asm/processor.h>, and include <asm/processor.h> where needed.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be queued in the m68k tree for v5.20.

 arch/m68k/include/asm/processor.h | 1 +
 arch/m68k/kernel/traps.c          | 1 +
 arch/m68k/mac/macints.c           | 3 +--
 arch/m68k/virt/ints.c             | 3 +--
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/include/asm/processor.h b/arch/m68k/include/asm/processor.h
index ffeda9aa526a5420..d86b4009880b4e79 100644
--- a/arch/m68k/include/asm/processor.h
+++ b/arch/m68k/include/asm/processor.h
@@ -151,6 +151,7 @@ static inline void release_thread(struct task_struct *dead_task)
 }
 
 unsigned long __get_wchan(struct task_struct *p);
+void show_registers(struct pt_regs *regs);
 
 #define	KSTK_EIP(tsk)	\
     ({			\
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 59fc63feb0dcce8a..5c8cba0efc63e580 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -36,6 +36,7 @@
 #include <linux/uaccess.h>
 #include <asm/traps.h>
 #include <asm/machdep.h>
+#include <asm/processor.h>
 #include <asm/siginfo.h>
 #include <asm/tlbflush.h>
 
diff --git a/arch/m68k/mac/macints.c b/arch/m68k/mac/macints.c
index 883e48230f87a187..5cbaf6e9497c698a 100644
--- a/arch/m68k/mac/macints.c
+++ b/arch/m68k/mac/macints.c
@@ -126,8 +126,7 @@
 #include <asm/mac_baboon.h>
 #include <asm/hwtest.h>
 #include <asm/irq_regs.h>
-
-extern void show_registers(struct pt_regs *);
+#include <asm/processor.h>
 
 static unsigned int mac_irq_startup(struct irq_data *);
 static void mac_irq_shutdown(struct irq_data *);
diff --git a/arch/m68k/virt/ints.c b/arch/m68k/virt/ints.c
index 95818f901ebe322d..896aa6eb8bcc6f3d 100644
--- a/arch/m68k/virt/ints.c
+++ b/arch/m68k/virt/ints.c
@@ -12,6 +12,7 @@
 #include <asm/hwtest.h>
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
+#include <asm/processor.h>
 #include <asm/virt.h>
 
 #define GFPIC_REG_IRQ_PENDING           0x04
@@ -19,8 +20,6 @@
 #define GFPIC_REG_IRQ_DISABLE           0x0c
 #define GFPIC_REG_IRQ_ENABLE            0x10
 
-extern void show_registers(struct pt_regs *regs);
-
 static struct resource picres[6];
 static const char *picname[6] = {
 	"goldfish_pic.0",
-- 
2.25.1

