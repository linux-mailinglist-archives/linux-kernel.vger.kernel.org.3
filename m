Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C9650B52A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446745AbiDVKiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446690AbiDVKhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:37:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699EB267D;
        Fri, 22 Apr 2022 03:35:02 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:34:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623701;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oiEYmoZjIQrxdFGwC+0CzfQvHyMPdpawUJRLao7DDa4=;
        b=eVfOyHIVmsugcS3svJ0So0tIVmSoxp5WDCrQjvoPDXz9dzvmvwWDtmyK+eZI/+7M5vuV7H
        I5hkLhJZr0Bu+/wGSCsukLTiPoSPK86o8GDEVS30M17SRIvJwNTy865u5kut7V5yOIdFaI
        ldJgGNj8YHNTESWZ8Uogzq5oLk3rQGJeoE7aKV1MRME1VionjluxqgrOaiWM07rcpFy3Pa
        CX97EKm5RImWxzBQeqPACxxnVLw5d7BHYaw8X8vVbwQO3x7N+sSrHsf7fvQrmkVZjvZwB9
        /2Wiq0zANlhHC4w09fslF/NUMlmAd5ownsGBT88NWvqvLGUeffgGAxPd1uN9xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623701;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oiEYmoZjIQrxdFGwC+0CzfQvHyMPdpawUJRLao7DDa4=;
        b=NFeAERcHYlEGG1jPZDXVjGCb/ZdSud6Q/SYZTJzbYs73GVIKKm7kn4XJuA8NJ2fyRxMJTo
        FAczuZ6M/SJ181DQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Make jump label hack optional
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <3bdcbfdd27ecb01ddec13c04bdf756a583b13d24.1650300597.git.jpoimboe@redhat.com>
References: <3bdcbfdd27ecb01ddec13c04bdf756a583b13d24.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165062369992.4207.4944845531831968750.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     4ab7674f5951ac6a8ac4fa8828090edb64a4771f
Gitweb:        https://git.kernel.org/tip/4ab7674f5951ac6a8ac4fa8828090edb64a4771f
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:39 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:32:04 +02:00

objtool: Make jump label hack optional

Objtool secretly does a jump label hack to overcome the limitations of
the toolchain.  Make the hack explicit (and optional for other arches)
by turning it into a cmdline option and kernel config option.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/3bdcbfdd27ecb01ddec13c04bdf756a583b13d24.1650300597.git.jpoimboe@redhat.com
---
 arch/Kconfig                            |  4 +++-
 arch/x86/Kconfig                        |  1 +-
 arch/x86/include/asm/jump_label.h       |  6 ++--
 scripts/Makefile.build                  |  1 +-
 scripts/link-vmlinux.sh                 |  4 +++-
 tools/objtool/builtin-check.c           | 37 ++++++++++++++++++------
 tools/objtool/check.c                   |  2 +-
 tools/objtool/include/objtool/builtin.h |  1 +-
 8 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 04cdef1..9dce6d6 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -46,6 +46,7 @@ config JUMP_LABEL
 	bool "Optimize very unlikely/likely branches"
 	depends on HAVE_ARCH_JUMP_LABEL
 	depends on CC_HAS_ASM_GOTO
+	select OBJTOOL if HAVE_JUMP_LABEL_HACK
 	help
 	 This option enables a transparent branch optimization that
 	 makes certain almost-always-true or almost-always-false branch
@@ -1031,6 +1032,9 @@ config ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 config HAVE_OBJTOOL
 	bool
 
+config HAVE_JUMP_LABEL_HACK
+	bool
+
 config HAVE_STACK_VALIDATION
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 43e26ee..26d012f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -212,6 +212,7 @@ config X86
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select HAVE_JUMP_LABEL_HACK		if HAVE_OBJTOOL
 	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZ4
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 3ce0e67..071572e 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -20,7 +20,7 @@
 	_ASM_PTR "%c0 + %c1 - .\n\t"			\
 	".popsection \n\t"
 
-#ifdef CONFIG_OBJTOOL
+#ifdef CONFIG_HAVE_JUMP_LABEL_HACK
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
@@ -34,7 +34,7 @@ l_yes:
 	return true;
 }
 
-#else /* !CONFIG_OBJTOOL */
+#else /* !CONFIG_HAVE_JUMP_LABEL_HACK */
 
 static __always_inline bool arch_static_branch(struct static_key * const key, const bool branch)
 {
@@ -48,7 +48,7 @@ l_yes:
 	return true;
 }
 
-#endif /* CONFIG_OBJTOOL */
+#endif /* CONFIG_HAVE_JUMP_LABEL_HACK */
 
 static __always_inline bool arch_static_branch_jump(struct static_key * const key, const bool branch)
 {
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 3f20d56..f1d2c2e 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -227,6 +227,7 @@ ifdef CONFIG_OBJTOOL
 objtool := $(objtree)/tools/objtool/objtool
 
 objtool_args =								\
+	$(if $(CONFIG_HAVE_JUMP_LABEL_HACK), --hacks=jump_label)	\
 	$(if $(CONFIG_X86_KERNEL_IBT), --lto --ibt)			\
 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
 	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 33f14fe..fa1f168 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -117,6 +117,10 @@ objtool_link()
 		# Don't perform vmlinux validation unless explicitly requested,
 		# but run objtool on vmlinux.o now that we have an object file.
 
+		if is_enabled CONFIG_HAVE_JUMP_LABEL_HACK; then
+			objtoolopt="${objtoolopt} --hacks=jump_label"
+		fi
+
 		if is_enabled CONFIG_X86_KERNEL_IBT; then
 			objtoolopt="${objtoolopt} --ibt"
 		fi
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index c8c4d2b..b2c626d 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -31,8 +31,28 @@ static int parse_dump(const struct option *opt, const char *str, int unset)
 	return -1;
 }
 
+static int parse_hacks(const struct option *opt, const char *str, int unset)
+{
+	bool found = false;
+
+	/*
+	 * Use strstr() as a lazy method of checking for comma-separated
+	 * options.
+	 *
+	 * No string provided == enable all options.
+	 */
+
+	if (!str || strstr(str, "jump_label")) {
+		opts.hack_jump_label = true;
+		found = true;
+	}
+
+	return found ? 0 : -1;
+}
+
 const struct option check_options[] = {
 	OPT_GROUP("Actions:"),
+	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label", "patch toolchain bugs/limitations", parse_hacks),
 	OPT_BOOLEAN('i', "ibt", &opts.ibt, "validate and annotate IBT"),
 	OPT_BOOLEAN('m', "mcount", &opts.mcount, "annotate mcount/fentry calls for ftrace"),
 	OPT_BOOLEAN('n', "noinstr", &opts.noinstr, "validate noinstr rules"),
@@ -87,14 +107,15 @@ int cmd_parse_options(int argc, const char **argv, const char * const usage[])
 
 static bool opts_valid(void)
 {
-	if (opts.ibt		||
-	    opts.mcount		||
-	    opts.noinstr	||
-	    opts.orc		||
-	    opts.retpoline	||
-	    opts.sls		||
-	    opts.stackval	||
-	    opts.static_call	||
+	if (opts.hack_jump_label	||
+	    opts.ibt			||
+	    opts.mcount			||
+	    opts.noinstr		||
+	    opts.orc			||
+	    opts.retpoline		||
+	    opts.sls			||
+	    opts.stackval		||
+	    opts.static_call		||
 	    opts.uaccess) {
 		if (opts.dump_orc) {
 			fprintf(stderr, "--dump can't be combined with other options\n");
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b9ac351..d157978 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1592,7 +1592,7 @@ static int handle_jump_alt(struct objtool_file *file,
 		return -1;
 	}
 
-	if (special_alt->key_addend & 2) {
+	if (opts.hack_jump_label && special_alt->key_addend & 2) {
 		struct reloc *reloc = insn_reloc(file, orig_insn);
 
 		if (reloc) {
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index dc47572..c6acf05 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -12,6 +12,7 @@ extern const struct option check_options[];
 struct opts {
 	/* actions: */
 	bool dump_orc;
+	bool hack_jump_label;
 	bool ibt;
 	bool mcount;
 	bool noinstr;
