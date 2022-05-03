Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E84518F85
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242321AbiECU6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242011AbiECU6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:58:43 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B6233E1C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:55:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so3368380pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 13:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ANvvfoJsMHIU8J1whkw86mXyIuy11/zkPRCmweDyDUY=;
        b=LfYvXfo5UrFi7QqSgYjmkU+NuXhIug3URPDe+TZJDsdTgB/ty6XtCDF+ZAeiM0QhNl
         W3kUGOV6FakPN3IdBaAgQoVEVuGtoGX0MD7mTZkxZYTMDkI0eC4wnd1h9CiS/i+D0FBE
         bVFcX/KTUlMNfkdEKGM9l9LqNZSrwHGI9qI9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ANvvfoJsMHIU8J1whkw86mXyIuy11/zkPRCmweDyDUY=;
        b=EEfh5HprgeKFZM+yAfdZUaj0JooAYSRxQjo6NwdyQNhU8xIdRYPtTyTcHBEuvGmEEr
         FbQi/F1M3gyFuSEKyfdQo+QlypBgfwpxXxtEL7CZe9mv7m99cYf5iOh3T/1kMu8MvnEu
         eaRjNG1Lof8dy8VeXPw7FUxpGDSYUof/h2QnTUj31hWIiKtTq01WwIDfllT1dieaBpQx
         6xiWbi0VFwACCUnguPzchzC3DXG0SmuKsBY0Dl2cjlIM5TWnpotlxt8cUwTTx1B7nJZv
         joKnpOziuDEj47+lQDWF7OlOzlL+u3c5u6vOhD63ODuRtwiw7sKlxTdrvIVtHsmRRBNK
         eHsA==
X-Gm-Message-State: AOAM531LsDbT3r/rQvosDFT/OhSeZLyTV3jwo5xG77miqO30sujFTq9v
        Xk54cUN4iOaBEIDmr1ZqiJWVTg==
X-Google-Smtp-Source: ABdhPJzQUhU7EJ/fEAemFTQQf6TTJP8RdhEmqho4i+ZCEnAstDVV2hZW+oFWSzMdgmiO/WObDWQDsw==
X-Received: by 2002:a17:902:9a49:b0:15d:1da8:81fa with SMTP id x9-20020a1709029a4900b0015d1da881famr18374107plv.114.1651611308698;
        Tue, 03 May 2022 13:55:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d16-20020aa78690000000b0050dc7628148sm6716986pfo.34.2022.05.03.13.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:55:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 3/6] randstruct: Reorganize Kconfigs and attribute macros
Date:   Tue,  3 May 2022 13:55:00 -0700
Message-Id: <20220503205503.3054173-4-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220503205503.3054173-1-keescook@chromium.org>
References: <20220503205503.3054173-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11221; h=from:subject; bh=LM/CNktcq953xhv+5bXRTSGy0dLJ5YoNbozOnQpL+r4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBicZamxn+qjom7FQIM9lrMVjKtUwJLzsxPHLLRZpDw gcUBks6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYnGWpgAKCRCJcvTf3G3AJh/RD/ 9AmXstTaGlTMOYjKI5q9Zxwb7mYJ8FkDOJdljwOi9CFAVl66HjC7OAazNegIagS/f91871rMMqyTZq NcxPrjqqexcrJvElnbSHSHBrUVDKvXDfkFRsylNpf79NRDaqLMhrxHINtle1DBVlm6Ee8dYj7AnBtB MZcy10JlrewqFNywN/iXpkSe+KDtiy8q3nLqsk6x9lOE/1qli/UJSsgnqSpYDJysXldr7eDBnpIlMk gHGX/8uCwWli3IrSYSki2arevQoH/7nH06MKuLRSZVbbBI/uLCVJc9UtM+DUuLMWUdlZRFHGU6giyD B3FcQ3Jdg6Zp3Hj4/eF+rx2Ain/4C4g7daNKa66XDbSX/pHAg0wmbCgOUetBO4tCl9pgZEr6ahIoI5 ljn4IOl7irfc1+pzHdj9Qk9fgzY6J0SFdp978dvbWGw2B1ppJs+lPBhFoZIpgx8kvwLtPhVWoLwobM kBB5+IszvAclP7vL/Mit5B7sPzeDmj/zCS4ZWo6i+KHUA/XiL1VOaf6q2iNn/2uOmmhIPJTiQFc94P mSXgRJp8UZRgWqCUWp2CG+ej9QwQufTDobK8FFYueyshAe0M10V+bpTasJHccfzpf6P+/Uldal4sqO uPId+UbGIlPdohiJg/vRy6N35kyEgim+026mJAz/mvxLx+3zWBfZ0Gkuj43Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for Clang supporting randstruct, reorganize the Kconfigs,
move the attribute macros, and generalize the feature to be named
CONFIG_RANDSTRUCT for on/off, CONFIG_RANDSTRUCT_FULL for the full
randomization mode, and CONFIG_RANDSTRUCT_PERFORMANCE for the cache-line
sized mode.

Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/kbuild/reproducible-builds.rst |  7 +--
 arch/riscv/Kconfig                           |  2 +-
 arch/x86/mm/pti.c                            |  2 +-
 include/linux/compiler-gcc.h                 |  8 ---
 include/linux/compiler_types.h               | 14 ++---
 include/linux/vermagic.h                     |  8 +--
 kernel/panic.c                               |  2 +-
 scripts/Makefile.gcc-plugins                 |  4 +-
 scripts/gcc-plugins/Kconfig                  | 38 ------------
 security/Kconfig.hardening                   | 62 ++++++++++++++++++++
 10 files changed, 81 insertions(+), 66 deletions(-)

diff --git a/Documentation/kbuild/reproducible-builds.rst b/Documentation/kbuild/reproducible-builds.rst
index 3b25655e441b..81ff30505d35 100644
--- a/Documentation/kbuild/reproducible-builds.rst
+++ b/Documentation/kbuild/reproducible-builds.rst
@@ -99,10 +99,9 @@ unreproducible parts can be treated as sources:
 Structure randomisation
 -----------------------
 
-If you enable ``CONFIG_GCC_PLUGIN_RANDSTRUCT``, you will need to
-pre-generate the random seed in
-``scripts/gcc-plugins/randomize_layout_seed.h`` so the same value
-is used in rebuilds.
+If you enable ``CONFIG_RANDSTRUCT``, you will need to pre-generate
+the random seed in ``scripts/gcc-plugins/randomize_layout_seed.h``
+so the same value is used in rebuilds.
 
 Debug info conflicts
 --------------------
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 00fd9c548f26..3ac2a81a55eb 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -468,7 +468,7 @@ config CC_HAVE_STACKPROTECTOR_TLS
 
 config STACKPROTECTOR_PER_TASK
 	def_bool y
-	depends on !GCC_PLUGIN_RANDSTRUCT
+	depends on !RANDSTRUCT
 	depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_TLS
 
 config PHYS_RAM_BASE_FIXED
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 5d5c7bb50ce9..ffe3b3a087fe 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -540,7 +540,7 @@ static inline bool pti_kernel_image_global_ok(void)
 	 * cases where RANDSTRUCT is in use to help keep the layout a
 	 * secret.
 	 */
-	if (IS_ENABLED(CONFIG_GCC_PLUGIN_RANDSTRUCT))
+	if (IS_ENABLED(CONFIG_RANDSTRUCT))
 		return false;
 
 	return true;
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 52299c957c98..a0c55eeaeaf1 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -66,14 +66,6 @@
 		__builtin_unreachable();	\
 	} while (0)
 
-#if defined(RANDSTRUCT_PLUGIN) && !defined(__CHECKER__)
-#define __randomize_layout __attribute__((randomize_layout))
-#define __no_randomize_layout __attribute__((no_randomize_layout))
-/* This anon struct can add padding, so only enable it under randstruct. */
-#define randomized_struct_fields_start	struct {
-#define randomized_struct_fields_end	} __randomize_layout;
-#endif
-
 /*
  * GCC 'asm goto' miscompiles certain code sequences:
  *
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 1c2c33ae1b37..d08dfcb0ac68 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -242,15 +242,15 @@ struct ftrace_likely_data {
 # define __latent_entropy
 #endif
 
-#ifndef __randomize_layout
+#if defined(RANDSTRUCT) && !defined(__CHECKER__)
+# define __randomize_layout __designated_init __attribute__((randomize_layout))
+# define __no_randomize_layout __attribute__((no_randomize_layout))
+/* This anon struct can add padding, so only enable it under randstruct. */
+# define randomized_struct_fields_start	struct {
+# define randomized_struct_fields_end	} __randomize_layout;
+#else
 # define __randomize_layout __designated_init
-#endif
-
-#ifndef __no_randomize_layout
 # define __no_randomize_layout
-#endif
-
-#ifndef randomized_struct_fields_start
 # define randomized_struct_fields_start
 # define randomized_struct_fields_end
 #endif
diff --git a/include/linux/vermagic.h b/include/linux/vermagic.h
index 329d63babaeb..efb51a2da599 100644
--- a/include/linux/vermagic.h
+++ b/include/linux/vermagic.h
@@ -32,11 +32,11 @@
 #else
 #define MODULE_VERMAGIC_MODVERSIONS ""
 #endif
-#ifdef RANDSTRUCT_PLUGIN
+#ifdef RANDSTRUCT
 #include <generated/randomize_layout_hash.h>
-#define MODULE_RANDSTRUCT_PLUGIN "RANDSTRUCT_PLUGIN_" RANDSTRUCT_HASHED_SEED
+#define MODULE_RANDSTRUCT "RANDSTRUCT_" RANDSTRUCT_HASHED_SEED
 #else
-#define MODULE_RANDSTRUCT_PLUGIN
+#define MODULE_RANDSTRUCT
 #endif
 
 #define VERMAGIC_STRING 						\
@@ -44,6 +44,6 @@
 	MODULE_VERMAGIC_SMP MODULE_VERMAGIC_PREEMPT 			\
 	MODULE_VERMAGIC_MODULE_UNLOAD MODULE_VERMAGIC_MODVERSIONS	\
 	MODULE_ARCH_VERMAGIC						\
-	MODULE_RANDSTRUCT_PLUGIN
+	MODULE_RANDSTRUCT
 
 #endif /* _LINUX_VERMAGIC_H */
diff --git a/kernel/panic.c b/kernel/panic.c
index eb4dfb932c85..8355b19676f8 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -48,7 +48,7 @@ unsigned int __read_mostly sysctl_oops_all_cpu_backtrace;
 
 int panic_on_oops = CONFIG_PANIC_ON_OOPS_VALUE;
 static unsigned long tainted_mask =
-	IS_ENABLED(CONFIG_GCC_PLUGIN_RANDSTRUCT) ? (1 << TAINT_RANDSTRUCT) : 0;
+	IS_ENABLED(CONFIG_RANDSTRUCT) ? (1 << TAINT_RANDSTRUCT) : 0;
 static int pause_on_oops;
 static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 927c3dd57f84..827c47ce5c73 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -24,8 +24,8 @@ gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)		\
 
 gcc-plugin-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)	+= randomize_layout_plugin.so
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)		\
-		+= -DRANDSTRUCT_PLUGIN
-gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE)	\
+		+= -DRANDSTRUCT
+gcc-plugin-cflags-$(CONFIG_RANDSTRUCT_PERFORMANCE)		\
 		+= -fplugin-arg-randomize_layout_plugin-performance-mode
 
 gcc-plugin-$(CONFIG_GCC_PLUGIN_STACKLEAK)	+= stackleak_plugin.so
diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index 51d81c3f03d6..e383cda05367 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -46,44 +46,6 @@ config GCC_PLUGIN_LATENT_ENTROPY
 	   * https://grsecurity.net/
 	   * https://pax.grsecurity.net/
 
-config GCC_PLUGIN_RANDSTRUCT
-	bool "Randomize layout of sensitive kernel structures"
-	select MODVERSIONS if MODULES
-	help
-	  If you say Y here, the layouts of structures that are entirely
-	  function pointers (and have not been manually annotated with
-	  __no_randomize_layout), or structures that have been explicitly
-	  marked with __randomize_layout, will be randomized at compile-time.
-	  This can introduce the requirement of an additional information
-	  exposure vulnerability for exploits targeting these structure
-	  types.
-
-	  Enabling this feature will introduce some performance impact,
-	  slightly increase memory usage, and prevent the use of forensic
-	  tools like Volatility against the system (unless the kernel
-	  source tree isn't cleaned after kernel installation).
-
-	  The seed used for compilation is located at
-	  scripts/gcc-plugins/randomize_layout_seed.h.  It remains after
-	  a make clean to allow for external modules to be compiled with
-	  the existing seed and will be removed by a make mrproper or
-	  make distclean.
-
-	  This plugin was ported from grsecurity/PaX. More information at:
-	   * https://grsecurity.net/
-	   * https://pax.grsecurity.net/
-
-config GCC_PLUGIN_RANDSTRUCT_PERFORMANCE
-	bool "Use cacheline-aware structure randomization"
-	depends on GCC_PLUGIN_RANDSTRUCT
-	depends on !COMPILE_TEST	# do not reduce test coverage
-	help
-	  If you say Y here, the RANDSTRUCT randomization will make a
-	  best effort at restricting randomization to cacheline-sized
-	  groups of elements.  It will further not randomize bitfields
-	  in structures.  This reduces the performance hit of RANDSTRUCT
-	  at the cost of weakened randomization.
-
 config GCC_PLUGIN_ARM_SSP_PER_TASK
 	bool
 	depends on GCC_PLUGINS && ARM
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index ded4d7c0d132..364e3f8c6eea 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -266,4 +266,66 @@ config ZERO_CALL_USED_REGS
 
 endmenu
 
+choice
+	prompt "Randomize layout of sensitive kernel structures"
+	default RANDSTRUCT_FULL if COMPILE_TEST && GCC_PLUGINS
+	default RANDSTRUCT_NONE
+	help
+	  If you enable this, the layouts of structures that are entirely
+	  function pointers (and have not been manually annotated with
+	  __no_randomize_layout), or structures that have been explicitly
+	  marked with __randomize_layout, will be randomized at compile-time.
+	  This can introduce the requirement of an additional information
+	  exposure vulnerability for exploits targeting these structure
+	  types.
+
+	  Enabling this feature will introduce some performance impact,
+	  slightly increase memory usage, and prevent the use of forensic
+	  tools like Volatility against the system (unless the kernel
+	  source tree isn't cleaned after kernel installation).
+
+	  The seed used for compilation is located at
+	  scripts/randomize_layout_seed.h. It remains after a "make clean"
+	  to allow for external modules to be compiled with the existing
+	  seed and will be removed by a "make mrproper" or "make distclean".
+
+	config RANDSTRUCT_NONE
+		bool "Disable structure layout randomization"
+		help
+		  Build normally: no structure layout randomization.
+
+	config RANDSTRUCT_FULL
+		bool "Fully randomize structure layout"
+		depends on GCC_PLUGINS
+		select MODVERSIONS if MODULES
+		help
+		  Fully randomize the member layout of sensitive
+		  structures as much as possible, which may have both a
+		  memory size and performance impact.
+
+	config RANDSTRUCT_PERFORMANCE
+		bool "Limit randomization of structure layout to cache-lines"
+		depends on GCC_PLUGINS
+		select MODVERSIONS if MODULES
+		help
+		  Randomization of sensitive kernel structures will make a
+		  best effort at restricting randomization to cacheline-sized
+		  groups of members. It will further not randomize bitfields
+		  in structures. This reduces the performance hit of RANDSTRUCT
+		  at the cost of weakened randomization.
+endchoice
+
+config RANDSTRUCT
+	def_bool !RANDSTRUCT_NONE
+
+config GCC_PLUGIN_RANDSTRUCT
+	def_bool GCC_PLUGINS && RANDSTRUCT
+	help
+	  Use GCC plugin to randomize structure layout.
+
+	  This plugin was ported from grsecurity/PaX. More
+	  information at:
+	   * https://grsecurity.net/
+	   * https://pax.grsecurity.net/
+
 endmenu
-- 
2.32.0

