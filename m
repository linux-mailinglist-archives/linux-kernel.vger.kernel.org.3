Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45763505CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346666AbiDRQyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346545AbiDRQyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:54:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A06943336B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uqyyOyU+oF0x6XbbGeKBAVgTXffqShf6wIPFqSB+NZE=;
        b=Z/86KZVAOPhkm8jlbLW0eAOCU3e6+F+oO/tDnFnUT7iptOF9GU++Sof0wJxNdj4MCUos0x
        vJdtUbble7xeb/aUGOl+aR5LRC0hHIHxG+6n0XjuyhUmDbr7Fy316kS1qfNo8r7TWWcpnk
        5Cs0a04bK2G/PWhpATWqHAVsRS5A97c=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-51c0E7QPNkCH86XnfD94GQ-1; Mon, 18 Apr 2022 12:51:25 -0400
X-MC-Unique: 51c0E7QPNkCH86XnfD94GQ-1
Received: by mail-qt1-f198.google.com with SMTP id a25-20020ac844b9000000b002f1f8988487so2465003qto.17
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uqyyOyU+oF0x6XbbGeKBAVgTXffqShf6wIPFqSB+NZE=;
        b=oxlmJIMixnVfjSy7nDobN9SZMe224wCPzRVtICZPC9ED4awRAOnNtqmjXUxT7pH5IQ
         +yEp74rVrPKTbiRBeV2CdIgGA8Y6TdJWmlBDPf9NzhiWLmVKWe4tr7zd0OosU7Cc34Oo
         VrXtuUwvPC1jYYI79ROUQlOFp6gK9rTcu7QzCK2TjjXCjen1pozdyelvsilaeitI/DIs
         wo5mryP7YXBJFrJJn3tynAHApZIn2Ls4KpmrUccBGhmmJt62F1fkoMX6l2V9PVHL6Ayy
         omFQ/feUArjcE+wDP6Shhb1DmWRwdhXzHQ5t3R7bGpYH70O6W00QbDWKMrUYXeuX0Vas
         S5Sg==
X-Gm-Message-State: AOAM532XDEGZwmkDc7aRyXTatnT87aWk/8nkQwE1hYnqdVgUamgfQ9L9
        sK/2bxcZaagwJz9/3QBpW90SChVorHtmwRMxJcDVWgW3BszMcm+h6fyem2kJhzESZ9+VUS14d8O
        w32ISF6Aw8N8nkrvPSn0Kog32
X-Received: by 2002:ac8:5a45:0:b0:2e2:27e5:1416 with SMTP id o5-20020ac85a45000000b002e227e51416mr7535514qta.481.1650300684672;
        Mon, 18 Apr 2022 09:51:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHn2j17gsdewITv0R11ecOMcEfblsLj29W1j/mkPgh7bmqQV4dWr28x/DNR9bsasZbzx1pog==
X-Received: by 2002:ac8:5a45:0:b0:2e2:27e5:1416 with SMTP id o5-20020ac85a45000000b002e227e51416mr7535501qta.481.1650300684396;
        Mon, 18 Apr 2022 09:51:24 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:51:23 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 21/25] objtool: Make noinstr hacks optional
Date:   Mon, 18 Apr 2022 09:50:40 -0700
Message-Id: <b326eeb9c33231b9dfbb925f194ed7ee40edcd7c.1650300597.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650300597.git.jpoimboe@redhat.com>
References: <cover.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objtool has some hacks in place to workaround toolchain limitations
which otherwise would break no-instrumentation rules.  Make the hacks
explicit (and optional for other arches) by turning it into a cmdline
option and kernel config option.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/Kconfig                            | 3 +++
 arch/x86/Kconfig                        | 1 +
 lib/Kconfig.debug                       | 4 ++--
 lib/Kconfig.kcsan                       | 5 +++--
 scripts/Makefile.build                  | 1 +
 scripts/link-vmlinux.sh                 | 4 ++++
 tools/objtool/builtin-check.c           | 8 +++++++-
 tools/objtool/check.c                   | 2 +-
 tools/objtool/include/objtool/builtin.h | 1 +
 9 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9dce6d6e3bc3..6ba6e34db0ea 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1035,6 +1035,9 @@ config HAVE_OBJTOOL
 config HAVE_JUMP_LABEL_HACK
 	bool
 
+config HAVE_NOINSTR_HACK
+	bool
+
 config HAVE_STACK_VALIDATION
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 46218967129f..cc7cca041745 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -231,6 +231,7 @@ config X86
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
+	select HAVE_NOINSTR_HACK		if HAVE_OBJTOOL
 	select HAVE_NMI
 	select HAVE_OBJTOOL			if X86_64
 	select HAVE_OPTPROBES
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c0e4e47f3ce3..7d2bbc3e558e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2036,11 +2036,11 @@ config KCOV
 	bool "Code coverage for fuzzing"
 	depends on ARCH_HAS_KCOV
 	depends on CC_HAS_SANCOV_TRACE_PC || GCC_PLUGINS
-	depends on !ARCH_WANTS_NO_INSTR || HAVE_OBJTOOL || \
+	depends on !ARCH_WANTS_NO_INSTR || HAVE_NOINSTR_HACK || \
 		   GCC_VERSION >= 120000 || CLANG_VERSION >= 130000
 	select DEBUG_FS
 	select GCC_PLUGIN_SANCOV if !CC_HAS_SANCOV_TRACE_PC
-	select OBJTOOL if HAVE_OBJTOOL
+	select OBJTOOL if HAVE_NOINSTR_HACK
 	help
 	  KCOV exposes kernel code coverage information in a form suitable
 	  for coverage-guided fuzzing (randomized testing).
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 901c3b509aca..47a693c45864 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -187,8 +187,9 @@ config KCSAN_WEAK_MEMORY
 	# We can either let objtool nop __tsan_func_{entry,exit}() and builtin
 	# atomics instrumentation in .noinstr.text, or use a compiler that can
 	# implement __no_kcsan to really remove all instrumentation.
-	depends on HAVE_OBJTOOL || CC_IS_GCC || CLANG_VERSION >= 140000
-	select OBJTOOL if HAVE_OBJTOOL
+	depends on !ARCH_WANTS_NO_INSTR || HAVE_NOINSTR_HACK || \
+		   CC_IS_GCC || CLANG_VERSION >= 140000
+	select OBJTOOL if HAVE_NOINSTR_HACK
 	help
 	  Enable support for modeling a subset of weak memory, which allows
 	  detecting a subset of data races due to missing memory barriers.
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index f1d2c2e4f15b..6c206a1bab97 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -228,6 +228,7 @@ objtool := $(objtree)/tools/objtool/objtool
 
 objtool_args =								\
 	$(if $(CONFIG_HAVE_JUMP_LABEL_HACK), --hacks=jump_label)	\
+	$(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)		\
 	$(if $(CONFIG_X86_KERNEL_IBT), --lto --ibt)			\
 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
 	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index fa1f16840e76..90c9c4c05d95 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -121,6 +121,10 @@ objtool_link()
 			objtoolopt="${objtoolopt} --hacks=jump_label"
 		fi
 
+		if is_enabled CONFIG_HAVE_NOINSTR_HACK; then
+			objtoolopt="${objtoolopt} --hacks=noinstr"
+		fi
+
 		if is_enabled CONFIG_X86_KERNEL_IBT; then
 			objtoolopt="${objtoolopt} --ibt"
 		fi
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index b2c626d9e2bf..1803a63147e4 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -47,12 +47,17 @@ static int parse_hacks(const struct option *opt, const char *str, int unset)
 		found = true;
 	}
 
+	if (!str || strstr(str, "noinstr")) {
+		opts.hack_noinstr = true;
+		found = true;
+	}
+
 	return found ? 0 : -1;
 }
 
 const struct option check_options[] = {
 	OPT_GROUP("Actions:"),
-	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label", "patch toolchain bugs/limitations", parse_hacks),
+	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr", "patch toolchain bugs/limitations", parse_hacks),
 	OPT_BOOLEAN('i', "ibt", &opts.ibt, "validate and annotate IBT"),
 	OPT_BOOLEAN('m', "mcount", &opts.mcount, "annotate mcount/fentry calls for ftrace"),
 	OPT_BOOLEAN('n', "noinstr", &opts.noinstr, "validate noinstr rules"),
@@ -108,6 +113,7 @@ int cmd_parse_options(int argc, const char **argv, const char * const usage[])
 static bool opts_valid(void)
 {
 	if (opts.hack_jump_label	||
+	    opts.hack_noinstr		||
 	    opts.ibt			||
 	    opts.mcount			||
 	    opts.noinstr		||
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index eb3dffab8767..6a7b5fa3fe1b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1145,7 +1145,7 @@ static void annotate_call_site(struct objtool_file *file,
 	 * attribute so they need a little help, NOP out any such calls from
 	 * noinstr text.
 	 */
-	if (insn->sec->noinstr && sym->profiling_func) {
+	if (opts.hack_noinstr && insn->sec->noinstr && sym->profiling_func) {
 		if (reloc) {
 			reloc->type = R_NONE;
 			elf_write_reloc(file->elf, reloc);
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index c6acf05ec859..f3a1a754b5c4 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -13,6 +13,7 @@ struct opts {
 	/* actions: */
 	bool dump_orc;
 	bool hack_jump_label;
+	bool hack_noinstr;
 	bool ibt;
 	bool mcount;
 	bool noinstr;
-- 
2.34.1

