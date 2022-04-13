Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8284A50028A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbiDMXXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239170AbiDMXWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8CA923BF4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649892022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w9z8Mm94f59mo8BEOPCdxnOAjEXlHponYE16hwUlryo=;
        b=IfQcd2eV3GcMs28p/T2hhguD6H2qSRm0k1Xcowh3KsfXNv2eqVoPWZWc9oJcjsU+6B5ME+
        nJGoAcHzsnkpvx+7j4W0x2kfJEiJMsTV7gKiBMPWQnBmFfRCTY/iBaKEALywmigrVldfV/
        pFDz3eRu3rFhffSi1quLYFfARRLVWNA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-fPgyQ8j-O5-ABMNOUkYjag-1; Wed, 13 Apr 2022 19:20:21 -0400
X-MC-Unique: fPgyQ8j-O5-ABMNOUkYjag-1
Received: by mail-qv1-f69.google.com with SMTP id e10-20020a0562140d8a00b00443c3595342so3020835qve.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w9z8Mm94f59mo8BEOPCdxnOAjEXlHponYE16hwUlryo=;
        b=DznmWyMuBWJZDFnBtp2qBjCKwdXQltzbeELJwdPgTbUPkvfAptZFB/HFg2P2pbpWKF
         1rFmAb9uVGzeiAtDTJKwoqM83P1kYHy9UgHz8sQ+LZPBzmr2YP8YLv0UUm4sjBuaWStP
         cE4pVwqBT2WuKTCdcSB54YbZQNsygyEHwswOzE22Cu7o/m9VwBTb1VJ9x24d1F/xXLkg
         RVJi682ifNXKLwDoj3/GI3hF8mX/rfxgkiNV2/U+EwV1wQonEu4mxwzPN5NZxpj2vGed
         rVWTGjPK4fOEmnQQZvytQJei73es/icRIGTb2JowoIX58w4Y4KWA6wrPNuyn4LImoJm1
         b9Nw==
X-Gm-Message-State: AOAM532rM1yjSSLYYBCmdD4IuSTv6y7qwb6VKsFOVfYbpgPKFse4muoB
        XAf4BoDowJ8mb0XtBdNeawbeZ8gbsuR/s/Xb1aKtwk4CkflY03kVyrULaXOUb3fMXPQpq+cOYeN
        8Be6xNOruzwq6++FpnzcvonKQ
X-Received: by 2002:a37:2756:0:b0:69c:2921:4ec0 with SMTP id n83-20020a372756000000b0069c29214ec0mr8703579qkn.742.1649892019925;
        Wed, 13 Apr 2022 16:20:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz52++23YGaPLs+LAxSJE6WcX6Rf+1Uj4unAPyGfVcfWUqNnjxRP+4liICOLQwm61C2rIHTuA==
X-Received: by 2002:a37:2756:0:b0:69c:2921:4ec0 with SMTP id n83-20020a372756000000b0069c29214ec0mr8703564qkn.742.1649892019609;
        Wed, 13 Apr 2022 16:20:19 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id b20-20020a05622a021400b002f08f5658a2sm193925qtx.68.2022.04.13.16.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:20:19 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 14/18] objtool: Add toolchain hacks cmdline option
Date:   Wed, 13 Apr 2022 16:19:49 -0700
Message-Id: <e04ec8f01fcb537675d6bd94ef65103a0a749318.1649891421.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649891421.git.jpoimboe@redhat.com>
References: <cover.1649891421.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objtool secretly does a few awful hacks to overcome toolchain
limitations.  Make those hacks explicit (and optional for other arches)
by associating them with a new '--hacks' cmdline option and
corresponding CONFIG_HAVE_TOOLCHAIN_HACKS.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/Kconfig                            | 4 ++++
 arch/x86/Kconfig                        | 1 +
 arch/x86/include/asm/jump_label.h       | 6 +++---
 lib/Kconfig.debug                       | 4 ++--
 lib/Kconfig.kcsan                       | 4 ++--
 scripts/Makefile.build                  | 1 +
 scripts/link-vmlinux.sh                 | 4 ++++
 tools/objtool/builtin-check.c           | 4 +++-
 tools/objtool/check.c                   | 4 ++--
 tools/objtool/include/objtool/builtin.h | 1 +
 10 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 04cdef16db24..cb5fc88cb996 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1031,6 +1031,10 @@ config ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 config HAVE_OBJTOOL
 	bool
 
+config HAVE_TOOLCHAIN_HACKS
+	bool
+	select OBJTOOL
+
 config HAVE_STACK_VALIDATION
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bce0c23f3550..410c4e2c7390 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -232,6 +232,7 @@ config X86
 	select HAVE_MOVE_PUD
 	select HAVE_NMI
 	select HAVE_OBJTOOL			if X86_64
+	select HAVE_TOOLCHAIN_HACKS		if HAVE_OBJTOOL
 	select HAVE_OPTPROBES
 	select HAVE_PCSPKR_PLATFORM
 	select HAVE_PERF_EVENTS
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 3ce0e67c579c..032434791bf1 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -20,7 +20,7 @@
 	_ASM_PTR "%c0 + %c1 - .\n\t"			\
 	".popsection \n\t"
 
-#ifdef CONFIG_OBJTOOL
+#ifdef CONFIG_HAVE_TOOLCHAIN_HACKS
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
@@ -34,7 +34,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 	return true;
 }
 
-#else /* !CONFIG_OBJTOOL */
+#else /* !CONFIG_HAVE_TOOLCHAIN_HACKS */
 
 static __always_inline bool arch_static_branch(struct static_key * const key, const bool branch)
 {
@@ -48,7 +48,7 @@ static __always_inline bool arch_static_branch(struct static_key * const key, co
 	return true;
 }
 
-#endif /* CONFIG_OBJTOOL */
+#endif /* CONFIG_HAVE_TOOLCHAIN_HACKS */
 
 static __always_inline bool arch_static_branch_jump(struct static_key * const key, const bool branch)
 {
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c0e4e47f3ce3..616b93d5db6d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2036,11 +2036,11 @@ config KCOV
 	bool "Code coverage for fuzzing"
 	depends on ARCH_HAS_KCOV
 	depends on CC_HAS_SANCOV_TRACE_PC || GCC_PLUGINS
-	depends on !ARCH_WANTS_NO_INSTR || HAVE_OBJTOOL || \
+	depends on !ARCH_WANTS_NO_INSTR || HAVE_TOOLCHAIN_HACKS || \
 		   GCC_VERSION >= 120000 || CLANG_VERSION >= 130000
 	select DEBUG_FS
 	select GCC_PLUGIN_SANCOV if !CC_HAS_SANCOV_TRACE_PC
-	select OBJTOOL if HAVE_OBJTOOL
+	select OBJTOOL if HAVE_TOOLCHAIN_HACKS
 	help
 	  KCOV exposes kernel code coverage information in a form suitable
 	  for coverage-guided fuzzing (randomized testing).
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 901c3b509aca..2bdb46354d6a 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -187,8 +187,8 @@ config KCSAN_WEAK_MEMORY
 	# We can either let objtool nop __tsan_func_{entry,exit}() and builtin
 	# atomics instrumentation in .noinstr.text, or use a compiler that can
 	# implement __no_kcsan to really remove all instrumentation.
-	depends on HAVE_OBJTOOL || CC_IS_GCC || CLANG_VERSION >= 140000
-	select OBJTOOL if HAVE_OBJTOOL
+	depends on HAVE_TOOLCHAIN_HACKS || CC_IS_GCC || CLANG_VERSION >= 140000
+	select OBJTOOL if HAVE_TOOLCHAIN_HACKS
 	help
 	  Enable support for modeling a subset of weak memory, which allows
 	  detecting a subset of data races due to missing memory barriers.
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 3f20d565733c..3b53de3dec67 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -227,6 +227,7 @@ ifdef CONFIG_OBJTOOL
 objtool := $(objtree)/tools/objtool/objtool
 
 objtool_args =								\
+	$(if $(CONFIG_HAVE_TOOLCHAIN_HACKS), --hacks)			\
 	$(if $(CONFIG_X86_KERNEL_IBT), --lto --ibt)			\
 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
 	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 33f14fe1ddde..480a49e47fbc 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -117,6 +117,10 @@ objtool_link()
 		# Don't perform vmlinux validation unless explicitly requested,
 		# but run objtool on vmlinux.o now that we have an object file.
 
+		if is_enabled CONFIG_HAVE_TOOLCHAIN_HACKS; then
+			objtoolopt="${objtoolopt} --hacks"
+		fi
+
 		if is_enabled CONFIG_X86_KERNEL_IBT; then
 			objtoolopt="${objtoolopt} --ibt"
 		fi
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index c663828834e1..13e1c46f155a 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -38,6 +38,7 @@ static int parse_dumpstr(const struct option *opt, const char *str, int unset)
 
 const struct option check_options[] = {
 	OPT_GROUP("Actions:"),
+	OPT_BOOLEAN('h', "hacks", &opts.hacks, "patch some toolchain bugs/limitations"),
 	OPT_BOOLEAN('i', "ibt", &opts.ibt, "validate and annotate IBT"),
 	OPT_BOOLEAN('m', "mcount", &opts.mcount, "annotate mcount/fentry calls for ftrace"),
 	OPT_BOOLEAN('n', "noinstr", &opts.noinstr, "validate noinstr rules"),
@@ -91,7 +92,8 @@ int cmd_parse_options(int argc, const char **argv, const char * const usage[])
 
 static bool opts_valid(void)
 {
-	if (opts.ibt		||
+	if (opts.hacks		||
+	    opts.ibt		||
 	    opts.mcount		||
 	    opts.noinstr	||
 	    opts.orc		||
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 511b76aaa6de..273ba6840ed2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1145,7 +1145,7 @@ static void annotate_call_site(struct objtool_file *file,
 	 * attribute so they need a little help, NOP out any such calls from
 	 * noinstr text.
 	 */
-	if (insn->sec->noinstr && sym->profiling_func) {
+	if (opts.hacks && insn->sec->noinstr && sym->profiling_func) {
 		if (reloc) {
 			reloc->type = R_NONE;
 			elf_write_reloc(file->elf, reloc);
@@ -1593,7 +1593,7 @@ static int handle_jump_alt(struct objtool_file *file,
 		return -1;
 	}
 
-	if (special_alt->key_addend & 2) {
+	if (opts.hacks && special_alt->key_addend & 2) {
 		struct reloc *reloc = insn_reloc(file, orig_insn);
 
 		if (reloc) {
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 6ffa6b5dc276..7bc76edb0a85 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -17,6 +17,7 @@ enum dump {
 struct opts {
 	/* actions: */
 	enum dump dump;
+	bool hacks;
 	bool ibt;
 	bool mcount;
 	bool noinstr;
-- 
2.34.1

