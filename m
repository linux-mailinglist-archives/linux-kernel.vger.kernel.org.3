Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BB4507DB3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 02:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358598AbiDTApx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 20:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358585AbiDTApr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:45:47 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385042F3BE;
        Tue, 19 Apr 2022 17:43:03 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 799551BF208;
        Wed, 20 Apr 2022 00:42:56 +0000 (UTC)
From:   joao@overdrivepizza.com
To:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     joao@overdrivepizza.com, peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: [RFC PATCH 02/11] kbuild: Support FineIBT build
Date:   Tue, 19 Apr 2022 17:42:32 -0700
Message-Id: <20220420004241.2093-3-joao@overdrivepizza.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420004241.2093-1-joao@overdrivepizza.com>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Moreira <joao@overdrivepizza.com>

Add FineIBT compilation flags to Makefiles, preserving translation
units which should not get it.

Signed-off-by: Joao Moreira <joao@overdrivepizza.com>
---
 arch/x86/Kconfig             | 10 ++++++++++
 arch/x86/Makefile            |  3 +++
 arch/x86/entry/vdso/Makefile |  5 +++++
 arch/x86/kernel/Makefile     |  1 +
 arch/x86/purgatory/Makefile  |  4 ++++
 5 files changed, 23 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b0142e01002e..37e49e9187a0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1872,6 +1872,16 @@ config X86_KERNEL_IBT
 	  does significantly reduce the number of ENDBR instructions in the
 	  kernel image.
 
+config CC_HAS_FINEIBT
+	def_bool $(cc-option, -fcf-protection=branch -mfine-ibt) && $(as-instr,endbr64)
+
+config X86_KERNEL_FINEIBT
+	prompt "Fine-grain Indirect Branch Tracking"
+	bool
+	depends on X86_KERNEL_IBT && CC_HAS_FINEIBT
+	help
+	  Build the kernel with Fine-grained IBT.
+
 config X86_INTEL_MEMORY_PROTECTION_KEYS
 	prompt "Memory Protection Keys"
 	def_bool y
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 63d50f65b828..768e318eb78f 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -73,6 +73,9 @@ ifeq ($(CONFIG_X86_KERNEL_IBT),y)
 #   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104816
 #
 KBUILD_CFLAGS += $(call cc-option,-fcf-protection=branch -fno-jump-tables)
+ifeq ($(CONFIG_X86_KERNEL_FINEIBT),y)
+KBUILD_CFLAGS += $(call cc-option, -mfine-ibt)
+endif
 else
 KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
 endif
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 693f8b9031fb..3dce5571460e 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -91,7 +91,11 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
+ifdef CONFIG_X86_KERNEL_FINEIBT
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS) -mfine-ibt,$(KBUILD_CFLAGS)) $(CFL)
+else
 $(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+endif
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -151,6 +155,7 @@ KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out -mfine-ibt,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
 KBUILD_CFLAGS_32 += -fno-stack-protector
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index c41ef42adbe8..cb947569e9d8 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -148,6 +148,7 @@ obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
+obj-$(CONFIG_X86_KERNEL_FINEIBT)	+= fineibt.o
 
 ###
 # 64 bit specific files
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index ae53d54d7959..e16b25a598ba 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -55,6 +55,10 @@ ifdef CONFIG_RETPOLINE
 PURGATORY_CFLAGS_REMOVE		+= $(RETPOLINE_CFLAGS)
 endif
 
+ifdef CONFIG_X86_KERNEL_FINEIBT
+PURGATORY_CFLAGS_REMOVE += -mfine-ibt
+endif
+
 CFLAGS_REMOVE_purgatory.o	+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS)
 
-- 
2.35.1

