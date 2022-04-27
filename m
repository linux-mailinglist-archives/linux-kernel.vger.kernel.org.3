Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C00E511B23
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbiD0Nwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbiD0Nwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:52:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214FA2D1FC;
        Wed, 27 Apr 2022 06:49:25 -0700 (PDT)
Date:   Wed, 27 Apr 2022 13:49:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651067364;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o09dgPtOiVRK9GaVotA4uOKUz1x/rmltdj8kFoTFHd8=;
        b=OlF1KPcZdnL+a1kOLPOxFEYtgyUx6zu/FXlAnEIUAVPlMwwQdhFs3lnEIYQWndJpaYWAGA
        8kVG5yEy+VMVilhFsOMpCw+ze38OjmcKmy+gBlrJncJYp/B4LzS7kfvJXbW6/gCTyJzCd1
        gIbR6Z8jk/zmQUMntFocSwrg9EwZW5ROi8RuVz/9FTaJ1SQ9pjnOMZliT0PgsUPOaOa5Es
        FAZH3gZ9QNuuGWIye8KxPhh5l7R8pA9hgWWrSfQd3xmJxu6ECXvpgpJh4Q9X5fzxUVPQJO
        43E9hHmERptnVdMn1Sv0Gn+igHkEHZKqOk/mkuxmBHVPUiNvbsr6IrlK7hzaAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651067364;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o09dgPtOiVRK9GaVotA4uOKUz1x/rmltdj8kFoTFHd8=;
        b=+qK/qTiWiW4er13TxRhEhdZFVEQ0SkHgq0CAArvz1H2+RqLp6XDzULVZVP9m2eSfS4/cVj
        6AO/l/qsi5BgWjBQ==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/splitlock] x86/split-lock: Remove unused TIF_SLD bit
Cc:     Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220310204854.31752-3-tony.luck@intel.com>
References: <20220310204854.31752-3-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <165106736325.4207.3606646429905878612.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/splitlock branch of tip:

Commit-ID:     ef79970d7ccdc4e8855aa6079fc2f4797a6807fb
Gitweb:        https://git.kernel.org/tip/ef79970d7ccdc4e8855aa6079fc2f4797a6807fb
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Thu, 10 Mar 2022 12:48:54 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Apr 2022 15:43:39 +02:00

x86/split-lock: Remove unused TIF_SLD bit

Changes to the "warn" mode of split lock handling mean that TIF_SLD is
never set.

Remove the bit, and the functions that use it.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220310204854.31752-3-tony.luck@intel.com

---
 arch/x86/include/asm/cpu.h         |  2 --
 arch/x86/include/asm/thread_info.h |  4 +---
 arch/x86/kernel/cpu/intel.c        | 12 ------------
 arch/x86/kernel/process.c          |  3 ---
 4 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 86e5e4e..d1c86b2 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -43,14 +43,12 @@ unsigned int x86_model(unsigned int sig);
 unsigned int x86_stepping(unsigned int sig);
 #ifdef CONFIG_CPU_SUP_INTEL
 extern void __init sld_setup(struct cpuinfo_x86 *c);
-extern void switch_to_sld(unsigned long tifn);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
 extern bool handle_guest_split_lock(unsigned long ip);
 extern void handle_bus_lock(struct pt_regs *regs);
 u8 get_this_hybrid_cpu_type(void);
 #else
 static inline void __init sld_setup(struct cpuinfo_x86 *c) {}
-static inline void switch_to_sld(unsigned long tifn) {}
 static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 {
 	return false;
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index ebec69c..f0cb881 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -92,7 +92,6 @@ struct thread_info {
 #define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
 #define TIF_NOTIFY_SIGNAL	17	/* signal notifications exist */
-#define TIF_SLD			18	/* Restore split lock detection on context switch */
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
@@ -116,7 +115,6 @@ struct thread_info {
 #define _TIF_NOCPUID		(1 << TIF_NOCPUID)
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
-#define _TIF_SLD		(1 << TIF_SLD)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
 #define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
@@ -128,7 +126,7 @@ struct thread_info {
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
 	(_TIF_NOCPUID | _TIF_NOTSC | _TIF_BLOCKSTEP |		\
-	 _TIF_SSBD | _TIF_SPEC_FORCE_UPDATE | _TIF_SLD)
+	 _TIF_SSBD | _TIF_SPEC_FORCE_UPDATE)
 
 /*
  * Avoid calls to __switch_to_xtra() on UP as STIBP is not evaluated.
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index be2a0bd..672e253 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1233,18 +1233,6 @@ void handle_bus_lock(struct pt_regs *regs)
 }
 
 /*
- * This function is called only when switching between tasks with
- * different split-lock detection modes. It sets the MSR for the
- * mode of the new task. This is right most of the time, but since
- * the MSR is shared by hyperthreads on a physical core there can
- * be glitches when the two threads need different modes.
- */
-void switch_to_sld(unsigned long tifn)
-{
-	sld_update_msr(!(tifn & _TIF_SLD));
-}
-
-/*
  * Bits in the IA32_CORE_CAPABILITIES are not architectural, so they should
  * only be trusted if it is confirmed that a CPU model implements a
  * specific feature at a particular bit position.
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b370767..bcc76c1 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -686,9 +686,6 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 		/* Enforce MSR update to ensure consistent state */
 		__speculation_ctrl_update(~tifn, tifn);
 	}
-
-	if ((tifp ^ tifn) & _TIF_SLD)
-		switch_to_sld(tifn);
 }
 
 /*
