Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35D4505CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346701AbiDRQzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346595AbiDRQyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:54:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76FAF33340
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r7maJXgp62wMR2+BaJIy73ifAiDaDMrmt/iAqLxQ2aM=;
        b=L7SQgYgGfW6nhKcj8A/D0+Lw1dwL3sTrWbD8uFdxaUj5kD1Ah6VKvwn0aCEbYxxzQoeBtA
        AVYIQK4IbxKS1agXVXTruyTCOBh99duO10Kt8JcANE/tGuEmVsljfwlpnSTLwAsWVgPuAx
        iMdsuC4EmzPELyP/UHQ9xt4hy+pkTRs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-vYudvZ7MOmKZrtNkVjUQVg-1; Mon, 18 Apr 2022 12:51:30 -0400
X-MC-Unique: vYudvZ7MOmKZrtNkVjUQVg-1
Received: by mail-qk1-f198.google.com with SMTP id m23-20020a05620a221700b006809e1fa4fdso10733980qkh.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r7maJXgp62wMR2+BaJIy73ifAiDaDMrmt/iAqLxQ2aM=;
        b=CjUl+gnJ9G/QPfjedQayki6QByH3Jd4jewuMobKQ66OVIzkhzICIUdBXwmovTkD9SK
         XNkTUB5yLypL2NooqkV0ACrC4ewelmmUcAT0K/TLJIZ4K+vjUYOMCA7zFvVrDFQ1iw3l
         iatXa9ES2tQD5irwBc6ueWAnaCDKGey7S2XYr5x4Y1RBDEj6MxKqIaMUjp3zkBTjUafB
         tGJuONZ6wyrtkc/SrpjDlvjfX6bmmnUm9vYn/ne6/0PsEbD34cYAginHekWd316gUlwJ
         HeDmJnjfZ2xxltEPhThYcKU99kplpcoXzTlIu5XtXtBGbbmPn4v3za4twtd4uTZC9cla
         QNgQ==
X-Gm-Message-State: AOAM532SYCe7lC+nav0gVWYoFUc9bjzFw6XHoyRibZeiL3Pa/zLDBCRx
        M3PngFXXucEX7S0j3xO3rLrwAcfhIuaTg/mJ7lKFfJwk8sF9x61KsQfhXol63W/y6GKO8cK4XnB
        LIttE5mHgTcGfJwXPgCHHVx7g
X-Received: by 2002:a05:620a:404c:b0:69c:10ec:338a with SMTP id i12-20020a05620a404c00b0069c10ec338amr7354248qko.114.1650300689574;
        Mon, 18 Apr 2022 09:51:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdw0Xrlr89DRCL2uBkbQ77olLLvfIwpy0xao8Wiwwvfo9U2kM8wzxHMxi6K/jjP4pW2rESZA==
X-Received: by 2002:a05:620a:404c:b0:69c:10ec:338a with SMTP id i12-20020a05620a404c00b0069c10ec338amr7354234qko.114.1650300689237;
        Mon, 18 Apr 2022 09:51:29 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:51:28 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 24/25] objtool: Remove --lto and --vmlinux in favor of --link
Date:   Mon, 18 Apr 2022 09:50:43 -0700
Message-Id: <dcd3ceffd15a54822c6183e5766d21ad06082b45.1650300597.git.jpoimboe@redhat.com>
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

The '--lto' option is a confusing way of telling objtool to do stack
validation despite it being a linked object.  It's no longer needed now
that an explicit '--stackval' option exists.  The '--vmlinux' option is
also redundant.

Remove both options in favor of a straightforward '--link' option which
identifies a linked object.

Also, implicitly set '--link' with a warning if the user forgets to do
so and we can tell that it's a linked object.  This makes it easier for
manual vmlinux runs.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 scripts/Makefile.build                  |  4 ++-
 scripts/link-vmlinux.sh                 |  8 ++---
 tools/objtool/builtin-check.c           | 39 +++++++++++++++++++++---
 tools/objtool/check.c                   | 40 +++++++++----------------
 tools/objtool/elf.c                     |  3 ++
 tools/objtool/include/objtool/builtin.h |  3 +-
 tools/objtool/include/objtool/elf.h     | 12 +++++++-
 7 files changed, 70 insertions(+), 39 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 6c206a1bab97..ac8167227bc0 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -229,7 +229,7 @@ objtool := $(objtree)/tools/objtool/objtool
 objtool_args =								\
 	$(if $(CONFIG_HAVE_JUMP_LABEL_HACK), --hacks=jump_label)	\
 	$(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)		\
-	$(if $(CONFIG_X86_KERNEL_IBT), --lto --ibt)			\
+	$(if $(CONFIG_X86_KERNEL_IBT), --ibt)				\
 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
 	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
@@ -237,6 +237,7 @@ objtool_args =								\
 	$(if $(CONFIG_STACK_VALIDATION), --stackval)			\
 	$(if $(CONFIG_HAVE_STATIC_CALL_INLINE), --static-call)		\
 	$(if $(CONFIG_X86_SMAP), --uaccess)				\
+	$(if $(linked-object), --link)					\
 	$(if $(part-of-module), --module)				\
 	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable)
 
@@ -306,6 +307,7 @@ quiet_cmd_cc_prelink_modules = LD [M]  $@
 # modules into native code
 $(obj)/%.prelink.o: objtool-enabled = y
 $(obj)/%.prelink.o: part-of-module := y
+$(obj)/%.prelink.o: linked-object := y
 
 $(obj)/%.prelink.o: $(obj)/%.o FORCE
 	$(call if_changed,cc_prelink_modules)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index fce4f41816cd..eb9324f07f3d 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -114,8 +114,8 @@ objtool_link()
 
 	if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; then
 
-		# Don't perform vmlinux validation unless explicitly requested,
-		# but run objtool on vmlinux.o now that we have an object file.
+		# For LTO and IBT, objtool doesn't run on individual
+		# translation units.  Run everything on vmlinux instead.
 
 		if is_enabled CONFIG_HAVE_JUMP_LABEL_HACK; then
 			objtoolopt="${objtoolopt} --hacks=jump_label"
@@ -156,8 +156,6 @@ objtool_link()
 		if is_enabled CONFIG_X86_SMAP; then
 			objtoolopt="${objtoolopt} --uaccess"
 		fi
-
-		objtoolopt="${objtoolopt} --lto"
 	fi
 
 	if is_enabled CONFIG_NOINSTR_VALIDATION; then
@@ -170,7 +168,7 @@ objtool_link()
 			objtoolopt="${objtoolopt} --no-unreachable"
 		fi
 
-		objtoolopt="${objtoolopt} --vmlinux"
+		objtoolopt="${objtoolopt} --link"
 
 		info OBJTOOL ${1}
 		tools/objtool/objtool ${objtoolopt} ${1}
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 1803a63147e4..f4c3a5091737 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -9,6 +9,11 @@
 #include <objtool/builtin.h>
 #include <objtool/objtool.h>
 
+#define ERROR(format, ...)				\
+	fprintf(stderr,					\
+		"error: objtool: " format "\n",		\
+		##__VA_ARGS__)
+
 struct opts opts;
 
 static const char * const check_usage[] = {
@@ -73,12 +78,11 @@ const struct option check_options[] = {
 	OPT_BOOLEAN(0, "backtrace", &opts.backtrace, "unwind on error"),
 	OPT_BOOLEAN(0, "backup", &opts.backup, "create .orig files before modification"),
 	OPT_BOOLEAN(0, "dry-run", &opts.dryrun, "don't write modifications"),
-	OPT_BOOLEAN(0, "lto", &opts.lto, "whole-archive like runs"),
+	OPT_BOOLEAN(0, "link", &opts.link, "object is a linked object"),
 	OPT_BOOLEAN(0, "module", &opts.module, "object is part of a kernel module"),
 	OPT_BOOLEAN(0, "no-unreachable", &opts.no_unreachable, "skip 'unreachable instruction' warnings"),
 	OPT_BOOLEAN(0, "sec-address", &opts.sec_address, "print section addresses in warnings"),
 	OPT_BOOLEAN(0, "stats", &opts.stats, "print statistics"),
-	OPT_BOOLEAN(0, "vmlinux", &opts.vmlinux, "vmlinux.o validation"),
 
 	OPT_END(),
 };
@@ -124,7 +128,7 @@ static bool opts_valid(void)
 	    opts.static_call		||
 	    opts.uaccess) {
 		if (opts.dump_orc) {
-			fprintf(stderr, "--dump can't be combined with other options\n");
+			ERROR("--dump can't be combined with other options");
 			return false;
 		}
 
@@ -134,10 +138,34 @@ static bool opts_valid(void)
 	if (opts.dump_orc)
 		return true;
 
-	fprintf(stderr, "At least one command required\n");
+	ERROR("At least one command required");
 	return false;
 }
 
+static bool link_opts_valid(struct objtool_file *file)
+{
+	if (opts.link)
+		return true;
+
+	if (has_multiple_files(file->elf)) {
+		ERROR("Linked object detected, forcing --link");
+		opts.link = true;
+		return true;
+	}
+
+	if (opts.noinstr) {
+		ERROR("--noinstr requires --link");
+		return false;
+	}
+
+	if (opts.ibt) {
+		ERROR("--ibt requires --link");
+		return false;
+	}
+
+	return true;
+}
+
 int objtool_run(int argc, const char **argv)
 {
 	const char *objname;
@@ -157,6 +185,9 @@ int objtool_run(int argc, const char **argv)
 	if (!file)
 		return 1;
 
+	if (!link_opts_valid(file))
+		return 1;
+
 	ret = check(file);
 	if (ret)
 		return ret;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6a7b5fa3fe1b..60b6a2a712b5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -264,7 +264,8 @@ static void init_cfi_state(struct cfi_state *cfi)
 	cfi->drap_offset = -1;
 }
 
-static void init_insn_state(struct insn_state *state, struct section *sec)
+static void init_insn_state(struct objtool_file *file, struct insn_state *state,
+			    struct section *sec)
 {
 	memset(state, 0, sizeof(*state));
 	init_cfi_state(&state->cfi);
@@ -274,7 +275,7 @@ static void init_insn_state(struct insn_state *state, struct section *sec)
 	 * not correctly determine insn->call_dest->sec (external symbols do
 	 * not have a section).
 	 */
-	if (opts.vmlinux && opts.noinstr && sec)
+	if (opts.link && opts.noinstr && sec)
 		state->noinstr = sec->noinstr;
 }
 
@@ -3406,7 +3407,7 @@ static int validate_unwind_hints(struct objtool_file *file, struct section *sec)
 	if (!file->hints)
 		return 0;
 
-	init_insn_state(&state, sec);
+	init_insn_state(file, &state, sec);
 
 	if (sec) {
 		insn = find_insn(file, sec, 0);
@@ -3492,14 +3493,14 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 		return true;
 
 	/*
-	 * Whole archive runs might encounder dead code from weak symbols.
+	 * Whole archive runs might encounter dead code from weak symbols.
 	 * This is where the linker will have dropped the weak symbol in
 	 * favour of a regular symbol, but leaves the code in place.
 	 *
 	 * In this case we'll find a piece of code (whole function) that is not
 	 * covered by a !section symbol. Ignore them.
 	 */
-	if (!insn->func && opts.lto) {
+	if (opts.link && !insn->func) {
 		int size = find_symbol_hole_containing(insn->sec, insn->offset);
 		unsigned long end = insn->offset + size;
 
@@ -3621,7 +3622,7 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 		if (func->type != STT_FUNC)
 			continue;
 
-		init_insn_state(&state, sec);
+		init_insn_state(file, &state, sec);
 		set_func_state(&state.cfi);
 
 		warnings += validate_symbol(file, sec, func, &state);
@@ -3630,7 +3631,7 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 	return warnings;
 }
 
-static int validate_vmlinux_functions(struct objtool_file *file)
+static int validate_noinstr_sections(struct objtool_file *file)
 {
 	struct section *sec;
 	int warnings = 0;
@@ -3891,16 +3892,6 @@ int check(struct objtool_file *file)
 {
 	int ret, warnings = 0;
 
-	if (opts.lto && !(opts.vmlinux || opts.module)) {
-		fprintf(stderr, "--lto requires: --vmlinux or --module\n");
-		return 1;
-	}
-
-	if (opts.ibt && !opts.lto) {
-		fprintf(stderr, "--ibt requires: --lto\n");
-		return 1;
-	}
-
 	arch_initial_func_cfi_state(&initial_func_cfi);
 	init_cfi_state(&init_cfi);
 	init_cfi_state(&func_cfi);
@@ -3921,15 +3912,6 @@ int check(struct objtool_file *file)
 	if (list_empty(&file->insn_list))
 		goto out;
 
-	if (opts.vmlinux && !opts.lto) {
-		ret = validate_vmlinux_functions(file);
-		if (ret < 0)
-			goto out;
-
-		warnings += ret;
-		goto out;
-	}
-
 	if (opts.retpoline) {
 		ret = validate_retpoline(file);
 		if (ret < 0)
@@ -3954,6 +3936,12 @@ int check(struct objtool_file *file)
 				goto out;
 			warnings += ret;
 		}
+
+	} else if (opts.noinstr) {
+		ret = validate_noinstr_sections(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
 	}
 
 	if (opts.ibt) {
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index f7b2ad27bb1c..41fea838aeba 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -377,6 +377,9 @@ static void elf_add_symbol(struct elf *elf, struct symbol *sym)
 	sym->type = GELF_ST_TYPE(sym->sym.st_info);
 	sym->bind = GELF_ST_BIND(sym->sym.st_info);
 
+	if (sym->type == STT_FILE)
+		elf->num_files++;
+
 	sym->offset = sym->sym.st_value;
 	sym->len = sym->sym.st_size;
 
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index f3a1a754b5c4..280ea18b7f2b 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -28,12 +28,11 @@ struct opts {
 	bool backtrace;
 	bool backup;
 	bool dryrun;
-	bool lto;
+	bool link;
 	bool module;
 	bool no_unreachable;
 	bool sec_address;
 	bool stats;
-	bool vmlinux;
 };
 
 extern struct opts opts;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 22ba7e2b816e..9bb1e20c4462 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -86,7 +86,7 @@ struct elf {
 	int fd;
 	bool changed;
 	char *name;
-	unsigned int text_size;
+	unsigned int text_size, num_files;
 	struct list_head sections;
 
 	int symbol_bits;
@@ -131,6 +131,16 @@ static inline u32 reloc_hash(struct reloc *reloc)
 	return sec_offset_hash(reloc->sec, reloc->offset);
 }
 
+/*
+ * Try to see if it's a whole archive (vmlinux.o or module).
+ *
+ * Note this will miss the case where a module only has one source file.
+ */
+static inline bool has_multiple_files(struct elf *elf)
+{
+	return elf->num_files > 1;
+}
+
 struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
 
-- 
2.34.1

