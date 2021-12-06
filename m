Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0F54697C6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245238AbhLFOJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245194AbhLFOI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:08:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96988C0613F8;
        Mon,  6 Dec 2021 06:05:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3316A612DD;
        Mon,  6 Dec 2021 14:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBA4C341C5;
        Mon,  6 Dec 2021 14:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638799526;
        bh=iqnIUFTvG4dqydzUEwOisbY0obinSDQOqpV1dMowINE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G45+lbNTMR0Cgg3Ya9RsHgANlttAMvutSNOl0+iTJOyFlB4/zAzyLXkUM5KerPiwd
         /SWDIK+E8jWFp42nBQDjbrBc0cFReMo3BUHz45vq7kLwqD33fAWND9TpGEjeMr1Vaw
         sFo/TZ2Wo7guFqUO5GbF41bbDaLKwcEtrKKh9l9HLXbuXcOmLWdSbVDSbT+FdN8WPS
         b0fzMPE13XDeg3UducwesJgU1aA8Vi5VcldRdnxL1oWpEHgAYAR1vmm57xOnOFJpY7
         +vnyacjAR7KLxdgO6F2iuz0m6khsOgvvwfpgJjHHhqmvHGIPSpXjTOsBaXdtb3g+wQ
         vltwkO16r4T5Q==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 02/19] kallsyms: increase maximum kernel symbol length to 512
Date:   Mon,  6 Dec 2021 15:02:56 +0100
Message-Id: <20211206140313.5653-3-ojeda@kernel.org>
In-Reply-To: <20211206140313.5653-1-ojeda@kernel.org>
References: <20211206140313.5653-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rust symbols can become quite long due to namespacing introduced
by modules, types, traits, generics, etc. For instance,
the following code:

    pub mod my_module {
        pub struct MyType;
        pub struct MyGenericType<T>(T);

        pub trait MyTrait {
            fn my_method() -> u32;
        }

        impl MyTrait for MyGenericType<MyType> {
            fn my_method() -> u32 {
                42
            }
        }
    }

generates a symbol of length 96 when using the upcoming v0 mangling scheme:

    _RNvXNtCshGpAVYOtgW1_7example9my_moduleINtB2_13MyGenericTypeNtB2_6MyTypeENtB2_7MyTrait9my_method

At the moment, Rust symbols may reach up to 300 in length.
Setting 512 as the maximum seems like a reasonable choice to
keep some headroom.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 include/linux/kallsyms.h            | 2 +-
 kernel/livepatch/core.c             | 4 ++--
 scripts/kallsyms.c                  | 2 +-
 tools/include/linux/kallsyms.h      | 2 +-
 tools/include/linux/lockdep.h       | 2 +-
 tools/lib/perf/include/perf/event.h | 2 +-
 tools/lib/symbol/kallsyms.h         | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 4176c7eca7b5..5fb17dd4b6fa 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -15,7 +15,7 @@
 
 #include <asm/sections.h>
 
-#define KSYM_NAME_LEN 128
+#define KSYM_NAME_LEN 512
 #define KSYM_SYMBOL_LEN (sizeof("%s+%#lx/%#lx [%s %s]") + \
 			(KSYM_NAME_LEN - 1) + \
 			2*(BITS_PER_LONG*3/10) + (MODULE_NAME_LEN - 1) + \
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 335d988bd811..73874e5edfda 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -213,7 +213,7 @@ static int klp_resolve_symbols(Elf64_Shdr *sechdrs, const char *strtab,
 	 * we use the smallest/strictest upper bound possible (56, based on
 	 * the current definition of MODULE_NAME_LEN) to prevent overflows.
 	 */
-	BUILD_BUG_ON(MODULE_NAME_LEN < 56 || KSYM_NAME_LEN != 128);
+	BUILD_BUG_ON(MODULE_NAME_LEN < 56 || KSYM_NAME_LEN != 512);
 
 	relas = (Elf_Rela *) relasec->sh_addr;
 	/* For each rela in this klp relocation section */
@@ -227,7 +227,7 @@ static int klp_resolve_symbols(Elf64_Shdr *sechdrs, const char *strtab,
 
 		/* Format: .klp.sym.sym_objname.sym_name,sympos */
 		cnt = sscanf(strtab + sym->st_name,
-			     ".klp.sym.%55[^.].%127[^,],%lu",
+			     ".klp.sym.%55[^.].%511[^,],%lu",
 			     sym_objname, sym_name, &sympos);
 		if (cnt != 3) {
 			pr_err("symbol %s has an incorrectly formatted name\n",
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 79b11bb7f07d..72ba0fe4e43b 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -27,7 +27,7 @@
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
 
-#define KSYM_NAME_LEN		128
+#define KSYM_NAME_LEN		512
 
 struct sym_entry {
 	unsigned long long addr;
diff --git a/tools/include/linux/kallsyms.h b/tools/include/linux/kallsyms.h
index efb6c3f5f2a9..5a37ccbec54f 100644
--- a/tools/include/linux/kallsyms.h
+++ b/tools/include/linux/kallsyms.h
@@ -6,7 +6,7 @@
 #include <stdio.h>
 #include <unistd.h>
 
-#define KSYM_NAME_LEN 128
+#define KSYM_NAME_LEN 512
 
 struct module;
 
diff --git a/tools/include/linux/lockdep.h b/tools/include/linux/lockdep.h
index e56997288f2b..d9c163f3ab24 100644
--- a/tools/include/linux/lockdep.h
+++ b/tools/include/linux/lockdep.h
@@ -47,7 +47,7 @@ static inline int debug_locks_off(void)
 
 #define task_pid_nr(tsk) ((tsk)->pid)
 
-#define KSYM_NAME_LEN 128
+#define KSYM_NAME_LEN 512
 #define printk(...) dprintf(STDOUT_FILENO, __VA_ARGS__)
 #define pr_err(format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 #define pr_warn pr_err
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 75ee385fb078..acc4fa065ec7 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -95,7 +95,7 @@ struct perf_record_throttle {
 };
 
 #ifndef KSYM_NAME_LEN
-#define KSYM_NAME_LEN 256
+#define KSYM_NAME_LEN 512
 #endif
 
 struct perf_record_ksymbol {
diff --git a/tools/lib/symbol/kallsyms.h b/tools/lib/symbol/kallsyms.h
index 72ab9870454b..542f9b059c3b 100644
--- a/tools/lib/symbol/kallsyms.h
+++ b/tools/lib/symbol/kallsyms.h
@@ -7,7 +7,7 @@
 #include <linux/types.h>
 
 #ifndef KSYM_NAME_LEN
-#define KSYM_NAME_LEN 256
+#define KSYM_NAME_LEN 512
 #endif
 
 static inline u8 kallsyms2elf_binding(char type)
-- 
2.34.0

