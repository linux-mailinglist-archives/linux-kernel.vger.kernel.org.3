Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF3A4F1E92
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381122AbiDDWIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379937AbiDDSYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:24:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1454E22B39;
        Mon,  4 Apr 2022 11:22:21 -0700 (PDT)
Date:   Mon, 04 Apr 2022 18:22:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649096540;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xDIM4Cos2tbwzCb31rfLiWuVjwuxyUy9LIUQtWRwmf8=;
        b=wTNkCxcK1Go4i162/UhVT5Y6k5khf0tLLygX6yXXz/BHLTpy3xTzqbMkU9k6MEQcIGotr3
        ZawOaUNbFaLsAuCmsMDXFKhYBD4hlb2lXndUOXoAXieAxTEOvbnn0ITFaAuLBfZBLMcR+E
        Pst8m8TQxsBFpYHvtkqf3sA8TPjmzg4KO/KI2ltGLs3H8kicNq9vISFxv0MPy7Vx92xayO
        D6WnXbF2+6z3qzELULcUKvAL9W2ZwTdzZgOusbtm0Tk6Rpf2VyAUPSn0mcj+9BQtEwKmM+
        Uvd2JMrt0+Uc+FwoskKTcl4hY0AG5MIiFf52h14KaMgxw4jhR2CAH3klSwmRWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649096540;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xDIM4Cos2tbwzCb31rfLiWuVjwuxyUy9LIUQtWRwmf8=;
        b=X8ac+OEx4MvZGqI7Kj0U179cSP8tHx0ZSJ998w4mquGIonzZlyTy8PEZVysDYNnn0t4t9U
        scrNRTW4CLP0ayAQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Remove CONFIG_X86_SMAP and "nosmap"
Cc:     Borislav Petkov <bp@suse.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220127115626.14179-4-bp@alien8.de>
References: <20220127115626.14179-4-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <164909653949.389.11692542693797938034.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     dbae0a934f09208075ec3e73491bd0844e1397b3
Gitweb:        https://git.kernel.org/tip/dbae0a934f09208075ec3e73491bd0844e1397b3
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 27 Jan 2022 12:56:23 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Apr 2022 10:16:57 +02:00

x86/cpu: Remove CONFIG_X86_SMAP and "nosmap"

Those were added as part of the SMAP enablement but SMAP is currently
an integral part of kernel proper and there's no need to disable it
anymore.

Rip out that functionality. Leave --uaccess default on for objtool as
this is what objtool should do by default anyway.

If still needed - clearcpuid=smap.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20220127115626.14179-4-bp@alien8.de
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 Documentation/x86/cpuinfo.rst                   |  5 +--
 arch/x86/Kconfig                                | 11 +-------
 arch/x86/include/asm/disabled-features.h        |  8 +-----
 arch/x86/include/asm/smap.h                     | 24 +----------------
 arch/x86/kernel/cpu/common.c                    | 15 +----------
 scripts/Makefile.build                          |  2 +-
 scripts/link-vmlinux.sh                         |  6 ++--
 tools/arch/x86/include/asm/disabled-features.h  |  8 +-----
 9 files changed, 10 insertions(+), 71 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a9f3d31..e0bb710 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3461,7 +3461,7 @@
 			noexec=on: enable non-executable mappings (default)
 			noexec=off: disable non-executable mappings
 
-	nosmap		[X86,PPC]
+	nosmap		[PPC]
 			Disable SMAP (Supervisor Mode Access Prevention)
 			even if it is supported by processor.
 
diff --git a/Documentation/x86/cpuinfo.rst b/Documentation/x86/cpuinfo.rst
index 5d54c39..12fbe2b 100644
--- a/Documentation/x86/cpuinfo.rst
+++ b/Documentation/x86/cpuinfo.rst
@@ -140,9 +140,8 @@ from #define X86_FEATURE_UMIP (16*32 + 2).
 
 In addition, there exists a variety of custom command-line parameters that
 disable specific features. The list of parameters includes, but is not limited
-to, nofsgsbase, nosmap, and nosmep. 5-level paging can also be disabled using
-"no5lvl". SMAP and SMEP are disabled with the aforementioned parameters,
-respectively.
+to, nofsgsbase, and nosmep. 5-level paging can also be disabled using
+"no5lvl". SMEP is disabled with the aforementioned parameter.
 
 e: The feature was known to be non-functional.
 ----------------------------------------------
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b0142e0..5bc8bee 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1816,17 +1816,6 @@ config ARCH_RANDOM
 	  If supported, this is a high bandwidth, cryptographically
 	  secure hardware random number generator.
 
-config X86_SMAP
-	def_bool y
-	prompt "Supervisor Mode Access Prevention" if EXPERT
-	help
-	  Supervisor Mode Access Prevention (SMAP) is a security
-	  feature in newer Intel processors.  There is a small
-	  performance cost if this enabled and turned on; there is
-	  also a small increase in the kernel size if this is enabled.
-
-	  If unsure, say Y.
-
 config X86_UMIP
 	def_bool y
 	prompt "User Mode Instruction Prevention" if EXPERT
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 1231d63..1ae0fab 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -10,12 +10,6 @@
  * cpu_feature_enabled().
  */
 
-#ifdef CONFIG_X86_SMAP
-# define DISABLE_SMAP	0
-#else
-# define DISABLE_SMAP	(1<<(X86_FEATURE_SMAP & 31))
-#endif
-
 #ifdef CONFIG_X86_UMIP
 # define DISABLE_UMIP	0
 #else
@@ -80,7 +74,7 @@
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	(DISABLE_PTI)
 #define DISABLED_MASK8	0
-#define DISABLED_MASK9	(DISABLE_SMAP|DISABLE_SGX)
+#define DISABLED_MASK9	(DISABLE_SGX)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	0
 #define DISABLED_MASK12	0
diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index d17b398..bab4903 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -19,25 +19,14 @@
 
 #ifdef __ASSEMBLY__
 
-#ifdef CONFIG_X86_SMAP
-
 #define ASM_CLAC \
 	ALTERNATIVE "", __ASM_CLAC, X86_FEATURE_SMAP
 
 #define ASM_STAC \
 	ALTERNATIVE "", __ASM_STAC, X86_FEATURE_SMAP
 
-#else /* CONFIG_X86_SMAP */
-
-#define ASM_CLAC
-#define ASM_STAC
-
-#endif /* CONFIG_X86_SMAP */
-
 #else /* __ASSEMBLY__ */
 
-#ifdef CONFIG_X86_SMAP
-
 static __always_inline void clac(void)
 {
 	/* Note: a barrier is implicit in alternative() */
@@ -76,19 +65,6 @@ static __always_inline void smap_restore(unsigned long flags)
 #define ASM_STAC \
 	ALTERNATIVE("", __ASM_STAC, X86_FEATURE_SMAP)
 
-#else /* CONFIG_X86_SMAP */
-
-static inline void clac(void) { }
-static inline void stac(void) { }
-
-static inline unsigned long smap_save(void) { return 0; }
-static inline void smap_restore(unsigned long flags) { }
-
-#define ASM_CLAC
-#define ASM_STAC
-
-#endif /* CONFIG_X86_SMAP */
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_SMAP_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c71d107..747df07 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -382,13 +382,6 @@ static __always_inline void setup_smep(struct cpuinfo_x86 *c)
 		cr4_set_bits(X86_CR4_SMEP);
 }
 
-static __init int setup_disable_smap(char *arg)
-{
-	setup_clear_cpu_cap(X86_FEATURE_SMAP);
-	return 1;
-}
-__setup("nosmap", setup_disable_smap);
-
 static __always_inline void setup_smap(struct cpuinfo_x86 *c)
 {
 	unsigned long eflags = native_save_fl();
@@ -396,14 +389,8 @@ static __always_inline void setup_smap(struct cpuinfo_x86 *c)
 	/* This should have been cleared long ago */
 	BUG_ON(eflags & X86_EFLAGS_AC);
 
-	if (cpu_has(c, X86_FEATURE_SMAP)) {
-#ifdef CONFIG_X86_SMAP
+	if (cpu_has(c, X86_FEATURE_SMAP))
 		cr4_set_bits(X86_CR4_SMAP);
-#else
-		clear_cpu_cap(c, X86_FEATURE_SMAP);
-		cr4_clear_bits(X86_CR4_SMAP);
-#endif
-	}
 }
 
 static __always_inline void setup_umip(struct cpuinfo_x86 *c)
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9717e6f..7e7aa1d 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -233,7 +233,7 @@ objtool_args =								\
 	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
 	$(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
-	$(if $(CONFIG_X86_SMAP), --uaccess)				\
+	--uaccess							\
 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
 	$(if $(CONFIG_SLS), --sls)
 
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 20f4450..3a2fffd 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -146,9 +146,9 @@ objtool_link()
 		if is_enabled CONFIG_RETPOLINE; then
 			objtoolopt="${objtoolopt} --retpoline"
 		fi
-		if is_enabled CONFIG_X86_SMAP; then
-			objtoolopt="${objtoolopt} --uaccess"
-		fi
+
+		objtoolopt="${objtoolopt} --uaccess"
+
 		if is_enabled CONFIG_SLS; then
 			objtoolopt="${objtoolopt} --sls"
 		fi
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 1231d63..1ae0fab 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -10,12 +10,6 @@
  * cpu_feature_enabled().
  */
 
-#ifdef CONFIG_X86_SMAP
-# define DISABLE_SMAP	0
-#else
-# define DISABLE_SMAP	(1<<(X86_FEATURE_SMAP & 31))
-#endif
-
 #ifdef CONFIG_X86_UMIP
 # define DISABLE_UMIP	0
 #else
@@ -80,7 +74,7 @@
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	(DISABLE_PTI)
 #define DISABLED_MASK8	0
-#define DISABLED_MASK9	(DISABLE_SMAP|DISABLE_SGX)
+#define DISABLED_MASK9	(DISABLE_SGX)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	0
 #define DISABLED_MASK12	0
