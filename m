Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1135E505CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbiDRQyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346581AbiDRQyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35B0233366
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=877IgX7l5iksJjHrBazlyOLpYNAXfGObg9kksRPUq7I=;
        b=XZytLI92RrHGELhq/Xa5TFGd5QPVCOxSbVAsn1gVcJcjF8N+zs2vF7Qhbp4PVd0TAutFF2
        YQH6b7A10dLRi2HW2gncTL+mEkLXbYj19fNScbG8oW3fvqAXKkoW4h2ZvmC3U6WOZXI1xg
        7S8HEGce1/SChDz0YwBn6hzOI0OsE9k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-kVBHnA-GP92Pr3AMDvnNpg-1; Mon, 18 Apr 2022 12:51:23 -0400
X-MC-Unique: kVBHnA-GP92Pr3AMDvnNpg-1
Received: by mail-qk1-f197.google.com with SMTP id bp31-20020a05620a459f00b00699fabcc554so10736339qkb.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=877IgX7l5iksJjHrBazlyOLpYNAXfGObg9kksRPUq7I=;
        b=DvF3J/rwultH+lcSLBmQPuz5hJhGJ+Y1MJJ/6J+SwPlLqIsu1Hq+9OI1I7QVLZ1O9M
         pnhvWrSMeka9dNfJMcsZVOl/BTIOuCPYK7x3yXl0Gt01K+Eo8h49u6YwCr4hBDflEbu5
         7c0j8p+Np5Lz8KYC25TKA0w1Lyv90X4JKTrdzBSUdcvF+sJWcOh5+BwXDK9CjldWl6ho
         UK3bQTiTHS8JQJrCK8Zl88IvlJx9PETg+gEj/tc3egwM2KR3d0kxhbOv6q4V+tLj9D1/
         /+lMIpAXkXl5QcbmUjzL8I9YI5SyyfoNuwLNt/JK6pNWmiWsThPhMsoYGndgPCHtM5WO
         rVWQ==
X-Gm-Message-State: AOAM531+feHMRECEAHg8dpBtiYE/YKHac7RjPUCXhU+F0aBwlsmAyk8f
        Edo4aQl5xg5wyEyaMXkompus6PUamYTKo7ydfp/QoTisXlikSve1pga+v6O6Tro80UbJZ6mNs41
        dhIYTRdxiXL3/utr9YZ3qPjXn
X-Received: by 2002:ac8:7d50:0:b0:2f1:f199:3f57 with SMTP id h16-20020ac87d50000000b002f1f1993f57mr7800201qtb.525.1650300683128;
        Mon, 18 Apr 2022 09:51:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwG4cOq1unS852QsokIDL5Wk7ENznw0SL9ejbz1MC4t6l0hYAeiiN/Lkd74zxCEDVn+HHdT1A==
X-Received: by 2002:ac8:7d50:0:b0:2f1:f199:3f57 with SMTP id h16-20020ac87d50000000b002f1f1993f57mr7800191qtb.525.1650300682855;
        Mon, 18 Apr 2022 09:51:22 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:51:22 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 20/25] objtool: Make jump label hack optional
Date:   Mon, 18 Apr 2022 09:50:39 -0700
Message-Id: <3bdcbfdd27ecb01ddec13c04bdf756a583b13d24.1650300597.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650300597.git.jpoimboe@redhat.com>
References: <cover.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objtool secretly does a jump label hack to overcome the limitations of
the toolchain.  Make the hack explicit (and optional for other arches)
by turning it into a cmdline option and kernel config option.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/Kconfig                            |  4 +++
 arch/x86/Kconfig                        |  1 +
 arch/x86/include/asm/jump_label.h       |  6 ++--
 scripts/Makefile.build                  |  1 +
 scripts/link-vmlinux.sh                 |  4 +++
 tools/objtool/builtin-check.c           | 37 +++++++++++++++++++------
 tools/objtool/check.c                   |  2 +-
 tools/objtool/include/objtool/builtin.h |  1 +
 8 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 04cdef16db24..9dce6d6e3bc3 100644
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
index bce0c23f3550..46218967129f 100644
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
index 3ce0e67c579c..071572e23d3a 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -20,7 +20,7 @@
 	_ASM_PTR "%c0 + %c1 - .\n\t"			\
 	".popsection \n\t"
 
-#ifdef CONFIG_OBJTOOL
+#ifdef CONFIG_HAVE_JUMP_LABEL_HACK
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
@@ -34,7 +34,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 	return true;
 }
 
-#else /* !CONFIG_OBJTOOL */
+#else /* !CONFIG_HAVE_JUMP_LABEL_HACK */
 
 static __always_inline bool arch_static_branch(struct static_key * const key, const bool branch)
 {
@@ -48,7 +48,7 @@ static __always_inline bool arch_static_branch(struct static_key * const key, co
 	return true;
 }
 
-#endif /* CONFIG_OBJTOOL */
+#endif /* CONFIG_HAVE_JUMP_LABEL_HACK */
 
 static __always_inline bool arch_static_branch_jump(struct static_key * const key, const bool branch)
 {
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 3f20d565733c..f1d2c2e4f15b 100644
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
index 33f14fe1ddde..fa1f16840e76 100755
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
index c8c4d2bab42f..b2c626d9e2bf 100644
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
index ffb843ef372d..eb3dffab8767 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1593,7 +1593,7 @@ static int handle_jump_alt(struct objtool_file *file,
 		return -1;
 	}
 
-	if (special_alt->key_addend & 2) {
+	if (opts.hack_jump_label && special_alt->key_addend & 2) {
 		struct reloc *reloc = insn_reloc(file, orig_insn);
 
 		if (reloc) {
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index dc4757205b8d..c6acf05ec859 100644
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
-- 
2.34.1

