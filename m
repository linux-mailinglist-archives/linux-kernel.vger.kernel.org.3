Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F9C506A51
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351308AbiDSL00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351351AbiDSL0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:26:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8008340D4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U4rmiZ9oOL9Z5+8vJhg7eHo7h/LTKylpnoudlz3i/v8=; b=vr3vEspmdayYnTztFUuc/4B69X
        /JCPUE3D7ARSeG/6sN4ohkY0EtXlrx/Sl70M1nLTqk1dcYqC8RaqM/dprRNtQxRPkUutu9s69BrOv
        88VugPDrKUvbIngtM2KvNKjcx8i4HogEQmvJv3vL8yDBlxmlOfpfuhiIL426fLy93svX5WHPLku0l
        b3PVZZKIhe0jIa9JYDpPmkOSMcthDudRAXoUqcRMl88Jpz9I+2+jG53uob2mJcxUNAhE7masGxhBW
        +syfUxpNl9J4jPK2JtluVh9Kbca0xfgqm3JuygQtp09k6V0Sz7gQC5WMYl0wmJSy9uNknwGxCsNJs
        XIo1KSwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nglvq-00328P-26; Tue, 19 Apr 2022 11:22:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20B28986195; Tue, 19 Apr 2022 13:22:04 +0200 (CEST)
Date:   Tue, 19 Apr 2022 13:22:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 17/25] objtool: Add CONFIG_OBJTOOL
Message-ID: <20220419112204.GS2731@worktop.programming.kicks-ass.net>
References: <cover.1650300597.git.jpoimboe@redhat.com>
 <939bf3d85604b2a126412bf11af6e3bd3b872bcb.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <939bf3d85604b2a126412bf11af6e3bd3b872bcb.1650300597.git.jpoimboe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 09:50:36AM -0700, Josh Poimboeuf wrote:

>  config X86_SMAP
>  	def_bool y
>  	prompt "Supervisor Mode Access Prevention" if EXPERT
> +	select OBJTOOL if HAVE_OBJTOOL
>  	help
>  	  Supervisor Mode Access Prevention (SMAP) is a security
>  	  feature in newer Intel processors.  There is a small

Runs into:


commit dbae0a934f09208075ec3e73491bd0844e1397b3
Author: Borislav Petkov <bp@suse.de>
Date:   Thu Jan 27 12:56:23 2022 +0100

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

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a9f3d3158e77..e0bb710f0fa9 100644
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
index 5d54c39a063f..12fbe2b1e98a 100644
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
index b0142e01002e..5bc8bee64bb0 100644
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
index 1231d63f836d..1ae0fab7d902 100644
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
index d17b39893b79..bab490379c65 100644
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
index c71d1075db93..747df070fb5e 100644
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
index 9717e6f6fb31..7e7aa1d030a6 100644
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
index 20f44504a644..3a2fffdf49d4 100755
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
index 1231d63f836d..1ae0fab7d902 100644
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
