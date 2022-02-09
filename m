Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4A54AFCE6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 20:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbiBITHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:07:20 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbiBITHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:07:11 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F5DC03E95E;
        Wed,  9 Feb 2022 11:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644433619; x=1675969619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7AgXELWMnukC7hGhrDSXmsJnyuyFaHyOrAOKrf0azr8=;
  b=evKaIEqhz9B+GehmpVDf/QsUXfEdURoTGe3KDfLgga+Jful3oF/g+4PP
   evg1Yy1OyG8hugMnF99NG5AJnMmVv4Nznt3BtF5dMXfLIuJnRotjZAums
   9ER/41ycMfWOAFUkG12pzaYtkgzN2TTDI274qDZtfek+SdQ2Hbwpqzrn7
   HYwxkrIhM1wWGbAWB3hD8z27GuaPg8reARJ6AZ43fncQp56RH9U0xHar7
   f7ipLUus8JKKiacxavc5LTRUOu8iKMrdREQ/0gWCwQSNBdYPCdpaaRX1o
   yUKjxfr+yGY7KWH3c6ayngfnoso9/ggW1BaK/dIrQwuqZCPYBYCLTcsME
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="310049494"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="310049494"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 11:05:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="500091163"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga002.jf.intel.com with ESMTP; 09 Feb 2022 11:05:21 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 219J5JUx032163;
        Wed, 9 Feb 2022 19:05:19 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org, x86@kernel.org
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        "Kristen Carlson Accardi" <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Tony Luck" <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        "Miroslav Benes" <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Will Deacon" <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        "Sami Tolvanen" <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        "Nicolas Pitre" <nico@fluxnic.net>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        live-patching@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v10 00/15] Function Granular KASLR
Date:   Wed,  9 Feb 2022 20:05:06 +0100
Message-Id: <20220209190506.1226783-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Wed, 9 Feb 2022 19:57:37 +0100

> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> 
> Function Granular Kernel Address Space Layout Randomization (FG-KASLR)

--- 8< ---

> From v9 ([1]):
>  - rebase on top of 5.17-rc3 + tip/master, notably:
>    * drop .fixup (the section was removed in 5.17 cycle) and
>      .Lbad_gs (was converted from a symbol to a label) references
>      and handling;
>    * use `is_enabled` and sed in scripts/link-vmlinux.sh (doesn't
>      include auto.conf anymore);
>  - s/ASM/asm across the series (Boris);
>  - update the year across the series;
>  - restructure the cover letter to make it more readable and give
>    the key ideas earlier (Chris);
>  - 0001: expand the commitmsg with how this was reproduced, drop
>    "Stable:" to avoid accidental LTS issues (Boris);
>  - 0002: get back to plain resetting `sympos` to zero when
>    applicable (Mirek); rephrase and expand the commitsg (Boris);
>  - 0003: expand the subject and the commitmsg with a bit of crucial
>    details, invert a couple branches to drop a `goto` and save one
>    indent level (Boris);
>    avoid using `bool` type in a structure, revert the for-loop back
>    to the `while`;
>  - 0004: rename `to` argument in asm symbol macros to `sect` to make
>    it less confusing, elaborate on "asm function sections" in the
>    commitmsg (Boris);
>  - 0005: replace "aflags" with the actual "KBUILD_AFLAGS" in the
>    commitmsg (Boris);
>  - 0006: build the new arch/x86/lib/orc.c only for CONFIG_MODULES=y
>    as this code was formerly guarded with the corresponding #ifdefs;
>  - 0007: rephrase the commitmsg;
>  - 0009: rename `base` in fgkaslr.c to `kallsyms_base` to dodge
>    from `-Wshadow`;
>    fix "indecis" -> "indices" and reduce variable scope in
>    layout_image();
>    include lib/orc.c in utils.c rather than fgkaslr.c itself;
>    replace {,u}int{32,64}_t -> {s,u}{32,64};
>  - 0010: change obsolete references to the section alignment of 64
>    as starting from v8 only the alignment of 128+ is being taken
>    into account (with CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y,
>    every function is aligned to 64, so it would blow up the kernel
>    image for no reason);
>  - 0012: rephrase the subject to give more clue.

The diff between v9 and v10 to ease (or harden) the reviewing is
appended.
Thanks!

--- 8< ---

> -- 
> 2.34.1

Al

--
diff --git a/0001-modpost-fix-removing-numeric-suffixes.patch b/0001-modpost-fix-removing-numeric-suffixes.patch
index 27a8903455e7..39c03757fab4 100644
--- a/0001-modpost-fix-removing-numeric-suffixes.patch
+++ b/0001-modpost-fix-removing-numeric-suffixes.patch
@@ -1,39 +1,42 @@
-From 79b9b05458e9c42f4c998dbe69b76906def9c19a Mon Sep 17 00:00:00 2001
+From e2396ff76455bee6819ab9c192b60c2b4386756a Mon Sep 17 00:00:00 2001
 From: Alexander Lobakin <alexandr.lobakin@intel.com>
 Date: Wed, 22 Dec 2021 16:44:07 +0100
-Subject: [PATCH v9 01/15] modpost: fix removing numeric suffixes
+Subject: [PATCH v10 01/15] modpost: fix removing numeric suffixes
 
-For now, that condition from remove_dot():
+`-z unique-symbol` linker flag which is planned to use with FG-KASLR
+to simplify livepatching (hopefully globally later on) triggers the
+following:
+
+ERROR: modpost: "param_set_uint.0" [vmlinux] is a static EXPORT_SYMBOL
+
+The reason is that for now the condition from remove_dot():
 
 if (m && (s[n + m] == '.' || s[n + m] == 0))
 
-which was designed to test if it's a dot or a \0 after the suffix
+which was designed to test if it's a dot or a '\0' after the suffix
 is never satisfied.
-This is due to that s[n + m] always points to the last digit of a
-numeric suffix, not on the symbol next to it:
+This is due to that `s[n + m]` always points to the last digit of a
+numeric suffix, not on the symbol next to it (from a custom debug
+print added to modpost):
 
 param_set_uint.0, s[n + m] is '0', s[n + m + 1] is '\0'
 
-So it's off by one and was like that since 2014.
-
-`-z uniq-symbol` linker flag which we are planning to use to
-simplify livepatching brings numeric suffixes back, fix this.
-Otherwise:
-
-ERROR: modpost: "param_set_uint.0" [vmlinux] is a static EXPORT_SYMBOL
+So it's off-by-one and was like that since 2014.
+Fix this for the sake of upcoming features, but don't bother
+stable-backporting, as it's well hidden -- apart from that LD flag,
+can be triggered only by GCC LTO which never landed upstream.
 
 Fixes: fcd38ed0ff26 ("scripts: modpost: fix compilation warning")
-Cc: stable@vger.kernel.org # 3.17+
 Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
 ---
  scripts/mod/modpost.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
-index cb8ab7d91d30..ccc6d35580f2 100644
+index 6bfa33217914..4648b7afe5cc 100644
 --- a/scripts/mod/modpost.c
 +++ b/scripts/mod/modpost.c
-@@ -1971,7 +1971,7 @@ static char *remove_dot(char *s)
+@@ -1986,7 +1986,7 @@ static char *remove_dot(char *s)
  
  	if (n && s[n]) {
  		size_t m = strspn(s + n + 1, "0123456789");
@@ -43,5 +46,5 @@ index cb8ab7d91d30..ccc6d35580f2 100644
  
  		/* strip trailing .lto */
 -- 
-2.33.1
+2.34.1
 
diff --git a/0002-livepatch-use-z-unique-symbol-if-available-to-nuke-p.patch b/0002-livepatch-avoid-position-based-search-if-z-unique-sy.patch
similarity index 66%
rename from 0002-livepatch-use-z-unique-symbol-if-available-to-nuke-p.patch
rename to 0002-livepatch-avoid-position-based-search-if-z-unique-sy.patch
index 5af4a9ad1cac..a490bc08252d 100644
--- a/0002-livepatch-use-z-unique-symbol-if-available-to-nuke-p.patch
+++ b/0002-livepatch-avoid-position-based-search-if-z-unique-sy.patch
@@ -1,42 +1,49 @@
-From fef47fddee9dc9afad7dca89932fce8a996aa2df Mon Sep 17 00:00:00 2001
+From e5c211b10e86f7d3cd319b795adac5c725faf09c Mon Sep 17 00:00:00 2001
 From: Alexander Lobakin <alexandr.lobakin@intel.com>
 Date: Wed, 22 Dec 2021 17:31:45 +0100
-Subject: [PATCH v9 02/15] livepatch: use `-z unique-symbol` if available to
- nuke pos-based search
+Subject: [PATCH v10 02/15] livepatch: avoid position-based search if `-z
+ unique-symbol` is available
 
-Position-based search, which means that if we have several symbols
-with the same name, we additionally need to provide an "index" of
-the desired symbol, is fragile. Par exemple, it breaks when two
-symbols with the same name are located in different sections.
+Position-based search, which means that if there are several symbols
+with the same name, the user needs to additionally provide the
+"index" of a desired symbol, is fragile. For example, it breaks
+when two symbols with the same name are located in different
+sections.
 
 Since a while, LD has a flag `-z unique-symbol` which appends
 numeric suffixes to the functions with the same name (in symtab
-and strtab).
+and strtab). It can be used to effectively prevent from having
+any ambiguity when referring to a symbol by its name.
 Check for its availability and always prefer when the livepatching
-is on. This needs a little adjustment to the modpost to make it
-strip suffixes before adding exports.
+is on. It can be used unconditionally later on after broader testing
+on a wide variety of machines, but for now let's stick to the actual
+CONFIG_LIVEPATCH=y case, which is true for most of distro configs
+anyways.
+This needs a little adjustment to the modpost to make it strip
+suffixes before adding exports. depmod needs some treatment as well,
+tho its false-positive warnings about unknown symbols are harmless
+and don't alter the return code.
 
-depmod needs some treatment as well, tho its false-positibe warnings
-about unknown symbols are harmless and don't alter the return code.
-And there is a bunch more livepatch code to optimize-out after
-introducing this, but let's leave it for later.
+There is probably a bunch more livepatch code to optimize-out after
+introducing this, leave it for later as well.
 
 Suggested-by: H.J. Lu <hjl.tools@gmail.com>
 Suggested-by: Peter Zijlstra <peterz@infradead.org>
 Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
+Suggested-by: Miroslav Benes <mbenes@suse.cz>
 Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
 ---
  Makefile                |  6 ++++++
  init/Kconfig            |  3 +++
- kernel/livepatch/core.c | 20 +++++++++++++-------
+ kernel/livepatch/core.c | 17 +++++++++++++----
  scripts/mod/modpost.c   | 42 ++++++++++++++++++++++-------------------
- 4 files changed, 45 insertions(+), 26 deletions(-)
+ 4 files changed, 45 insertions(+), 23 deletions(-)
 
 diff --git a/Makefile b/Makefile
-index d85f1ff79f5c..9dc15c67d132 100644
+index ceb987e5c87b..fa9f947c9839 100644
 --- a/Makefile
 +++ b/Makefile
-@@ -882,6 +882,12 @@ ifdef CONFIG_DEBUG_SECTION_MISMATCH
+@@ -871,6 +871,12 @@ ifdef CONFIG_DEBUG_SECTION_MISMATCH
  KBUILD_CFLAGS += -fno-inline-functions-called-once
  endif
  
@@ -50,7 +57,7 @@ index d85f1ff79f5c..9dc15c67d132 100644
  KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
  LDFLAGS_vmlinux += --gc-sections
 diff --git a/init/Kconfig b/init/Kconfig
-index 4b7bac10c72d..37926d19a74a 100644
+index e9119bf54b1f..8e900d17d42b 100644
 --- a/init/Kconfig
 +++ b/init/Kconfig
 @@ -86,6 +86,9 @@ config CC_HAS_ASM_INLINE
@@ -64,7 +71,7 @@ index 4b7bac10c72d..37926d19a74a 100644
  	bool
  
 diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
-index 335d988bd811..b2c787297f85 100644
+index 585494ec464f..7a330465a8c7 100644
 --- a/kernel/livepatch/core.c
 +++ b/kernel/livepatch/core.c
 @@ -143,11 +143,13 @@ static int klp_find_callback(void *data, const char *name,
@@ -85,33 +92,22 @@ index 335d988bd811..b2c787297f85 100644
  		return 1;
  
  	return 0;
-@@ -171,17 +173,21 @@ static int klp_find_object_symbol(const char *objname, const char *name,
+@@ -169,6 +171,13 @@ static int klp_find_object_symbol(const char *objname, const char *name,
+ 	else
+ 		kallsyms_on_each_symbol(klp_find_callback, &args);
  
++	/*
++	 * If the LD's `-z unique-symbol` flag is available and enabled,
++	 * sympos checks are not relevant.
++	 */
++	if (IS_ENABLED(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL))
++		sympos = 0;
++
  	/*
  	 * Ensure an address was found. If sympos is 0, ensure symbol is unique;
--	 * otherwise ensure the symbol position count matches sympos.
-+	 * otherwise ensure the symbol position count matches sympos. If the LD
-+	 * `-z unique` flag is enabled, sympos checks are not relevant.
- 	 */
--	if (args.addr == 0)
-+	if (args.addr == 0) {
- 		pr_err("symbol '%s' not found in symbol table\n", name);
--	else if (args.count > 1 && sympos == 0) {
-+	} else if (IS_ENABLED(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL)) {
-+		goto out_ok;
-+	} else if (args.count > 1 && sympos == 0) {
- 		pr_err("unresolvable ambiguity for symbol '%s' in object '%s'\n",
- 		       name, objname);
- 	} else if (sympos != args.count && sympos > 0) {
- 		pr_err("symbol position %lu for symbol '%s' in object '%s' not found\n",
- 		       sympos, name, objname ? objname : "vmlinux");
- 	} else {
-+out_ok:
- 		*addr = args.addr;
- 		return 0;
- 	}
+ 	 * otherwise ensure the symbol position count matches sympos.
 diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
-index ccc6d35580f2..f39cc73a082c 100644
+index 4648b7afe5cc..ec521ccebea6 100644
 --- a/scripts/mod/modpost.c
 +++ b/scripts/mod/modpost.c
 @@ -689,11 +689,28 @@ static void handle_modversion(const struct module *mod,
@@ -158,7 +154,7 @@ index ccc6d35580f2..f39cc73a082c 100644
  		}
  		if (strcmp(symname, "init_module") == 0)
  			mod->has_init = 1;
-@@ -1965,22 +1985,6 @@ static void check_sec_ref(struct module *mod, const char *modname,
+@@ -1980,22 +2000,6 @@ static void check_sec_ref(struct module *mod, const char *modname,
  	}
  }
  
@@ -182,5 +178,5 @@ index ccc6d35580f2..f39cc73a082c 100644
  {
  	const char *symname;
 -- 
-2.33.1
+2.34.1
 
diff --git a/0003-kallsyms-Hide-layout.patch b/0003-kallsyms-randomize-proc-kallsyms-output-order.patch
similarity index 72%
rename from 0003-kallsyms-Hide-layout.patch
rename to 0003-kallsyms-randomize-proc-kallsyms-output-order.patch
index 7a4c211571e1..853ab3066f99 100644
--- a/0003-kallsyms-Hide-layout.patch
+++ b/0003-kallsyms-randomize-proc-kallsyms-output-order.patch
@@ -1,18 +1,29 @@
-From e6ebaa477467ce29918cee3f531c028a822aeb21 Mon Sep 17 00:00:00 2001
+From 00f254dededfeaf9e3845dc9aa64dbc275cd7226 Mon Sep 17 00:00:00 2001
 From: Kristen Carlson Accardi <kristen@linux.intel.com>
 Date: Fri, 27 Aug 2021 16:41:30 +0200
-Subject: [PATCH v9 03/15] kallsyms: Hide layout
+Subject: [PATCH v10 03/15] kallsyms: randomize /proc/kallsyms output order
 
-This patch makes /proc/kallsyms display in a random order, rather
-than sorted by address in order to hide the newly randomized address
-layout.
+For now, /proc/kallsyms printing code replaces the actual addresses
+with zeros for !CAP_SYSLOG accesses, but still emits the symbols
+sorted by address.
+This makes it easier for an attacker to determine the address of a
+desired function if the address of some other symbol is already
+known. It is especially critical for FG-KASLR as the text layout
+with it is random each boot and sorted /proc/kallsyms renders the
+entire feature useless.
 
-alobakin:
-Don't depend FG-KASLR and always do that for unpriviledged accesses
-as suggested by several folks.
-Also, introduce and use a shuffle_array() macro which shuffles an
-array using Fisher-Yates. We'll make use of it several more times
-later on.
+Make /proc/kallsyms display symbols in a random order to completely
+hide the kernel layout. Determine the full number of symbols prior
+to traversing through them and then shuffle the indexes, so the
+printing function will pick them randomly.
+
+Alexander Lobakin:
+
+Don't depend FG-KASLR and always do that for unprivileged accesses
+as suggested by several folks. Rename show_value to show_layout to
+reflect the new functionality.
+Also, introduce and use a generic shuffle_array() macro which
+shuffles an arbitrary array using a Fisher-Yates algorithm.
 
 Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
 Reviewed-by: Tony Luck <tony.luck@intel.com>
@@ -24,12 +35,12 @@ Suggested-by: Peter Zijlstra <peterz@infradead.org> # always do that, macro
 Co-developed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
 Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
 ---
- include/linux/random.h | 16 ++++++++
- kernel/kallsyms.c      | 93 ++++++++++++++++++++++++++++++++++--------
- 2 files changed, 93 insertions(+), 16 deletions(-)
+ include/linux/random.h | 16 +++++++
+ kernel/kallsyms.c      | 94 +++++++++++++++++++++++++++++++++++-------
+ 2 files changed, 95 insertions(+), 15 deletions(-)
 
 diff --git a/include/linux/random.h b/include/linux/random.h
-index f45b8be3e3c4..c859a698089c 100644
+index c45b2693e51f..596b27423150 100644
 --- a/include/linux/random.h
 +++ b/include/linux/random.h
 @@ -110,6 +110,22 @@ declare_get_random_var_wait(long)
@@ -37,7 +48,7 @@ index f45b8be3e3c4..c859a698089c 100644
  unsigned long randomize_page(unsigned long start, unsigned long range);
  
 +/**
-+ * shuffle_array - use a Fisher Yates algorithm to shuffle an array.
++ * shuffle_array - use a Fisher-Yates algorithm to shuffle an array.
 + * @arr: pointer to the array
 + * @nents: the number of elements in the array
 + */
@@ -56,10 +67,10 @@ index f45b8be3e3c4..c859a698089c 100644
   * This is designed to be standalone for just prandom
   * users, but for now we include it from <linux/random.h>
 diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
-index 3011bc33a5ba..5d41b993113f 100644
+index 951c93216fc4..d991afa9b5bf 100644
 --- a/kernel/kallsyms.c
 +++ b/kernel/kallsyms.c
-@@ -574,13 +574,15 @@ struct kallsym_iter {
+@@ -575,13 +575,15 @@ struct kallsym_iter {
  	loff_t pos_mod_end;
  	loff_t pos_ftrace_mod_end;
  	loff_t pos_bpf_end;
@@ -71,12 +82,12 @@ index 3011bc33a5ba..5d41b993113f 100644
  	char module_name[MODULE_NAME_LEN];
  	int exported;
 -	int show_value;
-+	bool show_layout;
++	int show_layout:1;
 +	loff_t shuffled_pos[];
  };
  
  int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
-@@ -660,11 +662,19 @@ static int get_ksymbol_bpf(struct kallsym_iter *iter)
+@@ -661,11 +663,19 @@ static int get_ksymbol_bpf(struct kallsym_iter *iter)
   */
  static int get_ksymbol_kprobe(struct kallsym_iter *iter)
  {
@@ -99,12 +110,15 @@ index 3011bc33a5ba..5d41b993113f 100644
  }
  
  /* Returns space to next name. */
-@@ -687,11 +697,12 @@ static void reset_iter(struct kallsym_iter *iter, loff_t new_pos)
+@@ -688,11 +698,16 @@ static void reset_iter(struct kallsym_iter *iter, loff_t new_pos)
  	iter->name[0] = '\0';
  	iter->nameoff = get_symbol_offset(new_pos);
  	iter->pos = new_pos;
--	if (new_pos == 0) {
-+	if (iter->show_layout && new_pos == 0) {
++
++	if (!iter->show_layout)
++		return;
++
+ 	if (new_pos == 0) {
  		iter->pos_arch_end = 0;
  		iter->pos_mod_end = 0;
  		iter->pos_ftrace_mod_end = 0;
@@ -113,7 +127,7 @@ index 3011bc33a5ba..5d41b993113f 100644
  	}
  }
  
-@@ -720,13 +731,23 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
+@@ -721,13 +736,23 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
  	    get_ksymbol_bpf(iter))
  		return 1;
  
@@ -139,7 +153,7 @@ index 3011bc33a5ba..5d41b993113f 100644
  	if (pos >= kallsyms_num_syms)
  		return update_iter_mod(iter, pos);
  
-@@ -769,7 +790,7 @@ static int s_show(struct seq_file *m, void *p)
+@@ -770,7 +795,7 @@ static int s_show(struct seq_file *m, void *p)
  	if (!iter->name[0])
  		return 0;
  
@@ -148,7 +162,7 @@ index 3011bc33a5ba..5d41b993113f 100644
  
  	if (iter->module_name[0]) {
  		char type;
-@@ -806,9 +827,10 @@ static inline int kallsyms_for_perf(void)
+@@ -807,9 +832,10 @@ static inline int kallsyms_for_perf(void)
  }
  
  /*
@@ -162,7 +176,7 @@ index 3011bc33a5ba..5d41b993113f 100644
   *
   * Otherwise, require CAP_SYSLOG (assuming kptr_restrict isn't set to
   * block even that).
-@@ -838,16 +860,54 @@ static int kallsyms_open(struct inode *inode, struct file *file)
+@@ -839,16 +865,53 @@ static int kallsyms_open(struct inode *inode, struct file *file)
  	 * using get_symbol_offset for every symbol.
  	 */
  	struct kallsym_iter *iter;
@@ -188,15 +202,14 @@ index 3011bc33a5ba..5d41b993113f 100644
  	 */
 -	iter->show_value = kallsyms_show_value(file->f_cred);
 +	fake.show_layout = kallsyms_show_value(file->f_cred);
-+	if (fake.show_layout)
-+		goto open;
-+
-+	for (pos = kallsyms_num_syms; update_iter_mod(&fake, pos); pos++)
-+		;
++	if (!fake.show_layout) {
++		pos = kallsyms_num_syms;
++		while (update_iter_mod(&fake, pos))
++			pos++;
 +
-+	size = struct_size(iter, shuffled_pos, fake.pos_end + 1);
++		size = struct_size(iter, shuffled_pos, fake.pos_end + 1);
++	}
 +
-+open:
 +	iter = __seq_open_private(file, &kallsyms_op, size);
 +	if (!iter)
 +		return -ENOMEM;
@@ -222,7 +235,7 @@ index 3011bc33a5ba..5d41b993113f 100644
  	return 0;
  }
  
-@@ -858,6 +918,7 @@ const char *kdb_walk_kallsyms(loff_t *pos)
+@@ -859,6 +922,7 @@ const char *kdb_walk_kallsyms(loff_t *pos)
  	if (*pos == 0) {
  		memset(&kdb_walk_kallsyms_iter, 0,
  		       sizeof(kdb_walk_kallsyms_iter));
@@ -231,5 +244,5 @@ index 3011bc33a5ba..5d41b993113f 100644
  	}
  	while (1) {
 -- 
-2.33.1
+2.34.1
 
diff --git a/0004-arch-introduce-ASM-function-sections.patch b/0004-arch-introduce-asm-function-sections.patch
similarity index 80%
rename from 0004-arch-introduce-ASM-function-sections.patch
rename to 0004-arch-introduce-asm-function-sections.patch
index 1fc7bda06800..dc350b7b72bf 100644
--- a/0004-arch-introduce-ASM-function-sections.patch
+++ b/0004-arch-introduce-asm-function-sections.patch
@@ -1,20 +1,24 @@
-From 229aee37a21b49a0f1b0cddd993aefb71666e204 Mon Sep 17 00:00:00 2001
+From 45f20e8d29557c731b3eea5abedc3e852a7ca65e Mon Sep 17 00:00:00 2001
 From: Alexander Lobakin <alexandr.lobakin@intel.com>
 Date: Wed, 22 Dec 2021 19:12:44 +0100
-Subject: [PATCH v9 04/15] arch: introduce ASM function sections
+Subject: [PATCH v10 04/15] arch: introduce asm function sections
 
-Sometimes it is useful to create a separate section for every
+Sometimes it can be useful to create a separate section for every
 function (symbol in general) to be able then to selectively merge
-them back into on or several others. This is how DCE and a part of
-LTO work.
-Currently, only C functions are in scope and the compilers are able
-to do this automatically when `-ffunction-section` is specified.
+them back into one or several others. This is how Dead Code
+Elimination (DCE, CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) and a part
+of Link-Time Optimization (LTO, currently CONFIG_LTO_CLANG) work.
+Currently, this can only be done for C functions as the compilers
+are able to do this automatically when `-ffunction-sections` is
+specified.
 
-Add a basic infra for supporting ASM function sections. If any of
-the required build options (DCE, LTO, FG-KASLR later) is on and
-the target architecture claims it supports them, all ASM functions
-and "code" will be placed into separate named sections by default.
-This is achieved using --sectname-subst GAS flag which will then
+Add a basic infra for supporting asm function sections, which means
+support for putting functions written in assembly into separate
+sections. If any of the required build options (DCE, LTO, FG-KASLR
+later) is on and the target architecture claims it supports them,
+all asm functions and "code" will be placed into separate so-named
+("current_section.function_name") sections by default.
+This is achieved using `--sectname-subst` GAS flag which will then
 substitute "%S" in a .pushsection or .section directive with the
 name of the current section. So,
 
@@ -40,16 +44,16 @@ Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
  Makefile                          |  18 +++++
  arch/Kconfig                      |   6 ++
  include/asm-generic/vmlinux.lds.h |  21 +++---
- include/linux/linkage.h           | 118 +++++++++++++++++++++++++++++-
- init/Kconfig                      |  11 +++
+ include/linux/linkage.h           | 119 +++++++++++++++++++++++++++++-
+ init/Kconfig                      |  10 +++
  scripts/mod/modpost.c             |   6 +-
  6 files changed, 167 insertions(+), 13 deletions(-)
 
 diff --git a/Makefile b/Makefile
-index 9dc15c67d132..b921b1fabf70 100644
+index fa9f947c9839..fbe2d13028f4 100644
 --- a/Makefile
 +++ b/Makefile
-@@ -888,6 +888,24 @@ ifeq ($(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL)$(CONFIG_LIVEPATCH),yy)
+@@ -877,6 +877,24 @@ ifeq ($(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL)$(CONFIG_LIVEPATCH),yy)
  KBUILD_LDFLAGS += -z unique-symbol
  endif
  
@@ -75,18 +79,18 @@ index 9dc15c67d132..b921b1fabf70 100644
  KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
  LDFLAGS_vmlinux += --gc-sections
 diff --git a/arch/Kconfig b/arch/Kconfig
-index d3c4ab249e9c..b31a836bc252 100644
+index 678a80713b21..550f0599e211 100644
 --- a/arch/Kconfig
 +++ b/arch/Kconfig
-@@ -1312,6 +1312,12 @@ config ARCH_HAS_PARANOID_L1D_FLUSH
- config DYNAMIC_SIGFRAME
+@@ -1322,6 +1322,12 @@ config DYNAMIC_SIGFRAME
+ config HAVE_ARCH_NODE_DEV_GROUP
  	bool
  
 +config ARCH_SUPPORTS_ASM_FUNCTION_SECTIONS
 +	bool
 +	help
 +	  An arch should select this if it can be built and run with its
-+	  ASM functions placed into separate sections to improve DCE and LTO.
++	  asm functions placed into separate sections to improve DCE and LTO.
 +
  source "kernel/gcov/Kconfig"
  
@@ -152,16 +156,17 @@ index 42f3866bca69..e7b8a84e0e64 100644
  #define HEAD_TEXT_SECTION							\
  	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {		\
 diff --git a/include/linux/linkage.h b/include/linux/linkage.h
-index dbf8506decca..0c0ddf4429dc 100644
+index dbf8506decca..f3b966a6427e 100644
 --- a/include/linux/linkage.h
 +++ b/include/linux/linkage.h
-@@ -73,6 +73,37 @@
+@@ -73,6 +73,38 @@
  #define __ALIGN_STR	".align 4,0x90"
  #endif
  
 +/*
 + * Allow ASM symbols to have their own unique sections if they are being
-+ * generated by the compiler for C functions (DCE, LTO).
++ * generated by the compiler for C functions (DCE, LTO). Correlates with
++ * the presence of the `-ffunction-section` in KBUILD_CFLAGS.
 + */
 +#if defined(CONFIG_HAVE_ASM_FUNCTION_SECTIONS) && \
 +    ((defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) && !defined(MODULE)) || \
@@ -176,13 +181,13 @@ index dbf8506decca..0c0ddf4429dc 100644
 +#define __ASM_PUSH_SECTION(name)			\
 +	".pushsection %S." name ", \"ax\""
 +
-+#else /* Just .text */
++#else /* !(CONFIG_HAVE_ASM_FUNCTION_SECTIONS && (DCE || LTO)) */
 +
 +#define SYM_PUSH_SECTION(name)
 +#define SYM_POP_SECTION()
 +#define __ASM_PUSH_SECTION(name)
 +
-+#endif /* Just .text */
++#endif /* !(CONFIG_HAVE_ASM_FUNCTION_SECTIONS && (DCE || LTO)) */
 +
 +#define ASM_PUSH_SECTION(name)				\
 +	__ASM_PUSH_SECTION(__stringify(name))
@@ -193,12 +198,12 @@ index dbf8506decca..0c0ddf4429dc 100644
  #ifdef __ASSEMBLY__
  
  /* SYM_T_FUNC -- type used by assembler to mark functions */
-@@ -209,6 +240,15 @@
+@@ -209,6 +241,15 @@
  	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
  #endif
  
 +/*
-+ * SYM_FUNC_START_WEAK -- use where there are two global names for one
++ * SYM_FUNC_START_WEAK_ALIAS -- use where there are two global names for one
 + * function, and one of them is weak
 + */
 +#ifndef SYM_FUNC_START_WEAK_ALIAS
@@ -209,7 +214,7 @@ index dbf8506decca..0c0ddf4429dc 100644
  /*
   * SYM_FUNC_START_ALIAS -- use where there are two global names for one
   * function
-@@ -225,12 +265,24 @@
+@@ -225,12 +266,24 @@
   * later.
   */
  #define SYM_FUNC_START(name)				\
@@ -222,8 +227,8 @@ index dbf8506decca..0c0ddf4429dc 100644
 + * placed into a section specified in the second argument
 + */
 +#ifndef SYM_FUNC_START_SECT
-+#define SYM_FUNC_START_SECT(name, to)			\
-+	SYM_PUSH_SECTION(to) ASM_NL			\
++#define SYM_FUNC_START_SECT(name, sect)			\
++	SYM_PUSH_SECTION(sect) ASM_NL			\
  	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
  #endif
  
@@ -234,7 +239,7 @@ index dbf8506decca..0c0ddf4429dc 100644
  	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)
  #endif
  
-@@ -238,24 +290,38 @@
+@@ -238,24 +291,38 @@
  #ifndef SYM_FUNC_START_LOCAL
  /* the same as SYM_FUNC_START_LOCAL_ALIAS, see comment near SYM_FUNC_START */
  #define SYM_FUNC_START_LOCAL(name)			\
@@ -254,8 +259,8 @@ index dbf8506decca..0c0ddf4429dc 100644
 + * will be conditionally placed into a section specified in the second argument
 + */
 +#ifndef SYM_FUNC_START_LOCAL_NOALIGN_SECT
-+#define SYM_FUNC_START_LOCAL_NOALIGN_SECT(name, to)	\
-+	SYM_PUSH_SECTION(to) ASM_NL			\
++#define SYM_FUNC_START_LOCAL_NOALIGN_SECT(name, sect)	\
++	SYM_PUSH_SECTION(sect) ASM_NL			\
  	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)
  #endif
  
@@ -273,7 +278,7 @@ index dbf8506decca..0c0ddf4429dc 100644
  	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)
  #endif
  
-@@ -272,24 +338,59 @@
+@@ -272,24 +339,59 @@
  #ifndef SYM_FUNC_END
  /* the same as SYM_FUNC_END_ALIAS, see comment near SYM_FUNC_START */
  #define SYM_FUNC_END(name)				\
@@ -294,8 +299,8 @@ index dbf8506decca..0c0ddf4429dc 100644
 + * conditionally placed into a section specified in the second argument
 + */
 +#ifndef SYM_CODE_START_SECT
-+#define SYM_CODE_START_SECT(name, to)			\
-+	SYM_PUSH_SECTION(to) ASM_NL			\
++#define SYM_CODE_START_SECT(name, sect)			\
++	SYM_PUSH_SECTION(sect) ASM_NL			\
  	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
  #endif
  
@@ -312,8 +317,8 @@ index dbf8506decca..0c0ddf4429dc 100644
 + * in the second argument
 + */
 +#ifndef SYM_CODE_START_NOALIGN_SECT
-+#define SYM_CODE_START_NOALIGN_SECT(name, to)		\
-+	SYM_PUSH_SECTION(to) ASM_NL			\
++#define SYM_CODE_START_NOALIGN_SECT(name, sect)		\
++	SYM_PUSH_SECTION(sect) ASM_NL			\
  	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)
  #endif
  
@@ -329,12 +334,12 @@ index dbf8506decca..0c0ddf4429dc 100644
 + * be conditionally placing into a section specified in the second argument
 + */
 +#ifndef SYM_CODE_START_LOCAL_SECT
-+#define SYM_CODE_START_LOCAL_SECT(name, to)		\
-+	SYM_PUSH_SECTION(to) ASM_NL			\
++#define SYM_CODE_START_LOCAL_SECT(name, sect)		\
++	SYM_PUSH_SECTION(sect) ASM_NL			\
  	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
  #endif
  
-@@ -299,13 +400,26 @@
+@@ -299,13 +401,26 @@
   */
  #ifndef SYM_CODE_START_LOCAL_NOALIGN
  #define SYM_CODE_START_LOCAL_NOALIGN(name)		\
@@ -348,8 +353,8 @@ index dbf8506decca..0c0ddf4429dc 100644
 + * specified in the second argument
 + */
 +#ifndef SYM_CODE_START_LOCAL_NOALIGN_SECT
-+#define SYM_CODE_START_LOCAL_NOALIGN_SECT(name, to)	\
-+	SYM_PUSH_SECTION(to) ASM_NL			\
++#define SYM_CODE_START_LOCAL_NOALIGN_SECT(name, sect)	\
++	SYM_PUSH_SECTION(sect) ASM_NL			\
  	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)
  #endif
  
@@ -363,10 +368,10 @@ index dbf8506decca..0c0ddf4429dc 100644
  
  /* === data annotations === */
 diff --git a/init/Kconfig b/init/Kconfig
-index 37926d19a74a..3babc0aeac61 100644
+index 8e900d17d42b..4acfc80f22df 100644
 --- a/init/Kconfig
 +++ b/init/Kconfig
-@@ -1386,6 +1386,17 @@ config CC_OPTIMIZE_FOR_SIZE
+@@ -1386,6 +1386,16 @@ config CC_OPTIMIZE_FOR_SIZE
  
  endchoice
  
@@ -375,17 +380,16 @@ index 37926d19a74a..3babc0aeac61 100644
 +	depends on $(cc-option,-Wa$(comma)--sectname-subst)
 +	def_bool y
 +	help
-+	  This enables ASM function sections if both architecture
-+	  and toolchain supports that. It allows creating a separate
-+	  .text section for each ASM function in order to improve
-+	  DCE and LTO (works the same way as -ffunction-sections for
-+	  C code).
++	  This enables asm function sections if both architecture and
++	  toolchain support it. It allows creating a separate section
++	  for each function written in assembly in order to improve DCE
++	  and LTO (works the same way as -ffunction-sections for C code).
 +
  config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
  	bool
  	help
 diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
-index f39cc73a082c..a6e9e75ff3e5 100644
+index ec521ccebea6..84d2c44f9383 100644
 --- a/scripts/mod/modpost.c
 +++ b/scripts/mod/modpost.c
 @@ -960,7 +960,9 @@ static void check_section(const char *modname, struct elf_info *elf,
@@ -409,5 +413,5 @@ index f39cc73a082c..a6e9e75ff3e5 100644
  	const char *symbol_white_list[20];
  	void (*handler)(const char *modname, struct elf_info *elf,
 -- 
-2.33.1
+2.34.1
 
diff --git a/0005-x86-support-ASM-function-sections.patch b/0005-x86-support-asm-function-sections.patch
similarity index 88%
rename from 0005-x86-support-ASM-function-sections.patch
rename to 0005-x86-support-asm-function-sections.patch
index feb5fb741943..4c6889d57782 100644
--- a/0005-x86-support-ASM-function-sections.patch
+++ b/0005-x86-support-asm-function-sections.patch
@@ -1,18 +1,19 @@
-From 645835128b5bbf6aabe83383b7075974229506b9 Mon Sep 17 00:00:00 2001
+From 1c8cf0c01c1e62a345807d0e877afcace2f6a555 Mon Sep 17 00:00:00 2001
 From: Alexander Lobakin <alexandr.lobakin@intel.com>
 Date: Wed, 22 Dec 2021 20:15:03 +0100
-Subject: [PATCH v9 05/15] x86: support ASM function sections
+Subject: [PATCH v10 05/15] x86: support asm function sections
 
 Address places which need special care and enable
 CONFIG_ARCH_SUPPORTS_ASM_FUNCTION_SECTIONS.
 
 Notably:
- - propagate --sectname-subst to aflags in x86/boot/Makefile and
-   x86/boot/compressed/Makefile as both override aflags;
- - symbols starting with a dot (like ".Lbad_gs") should be handled
-   manually with SYM_*_START_SECT(.Lbad_gs, bad_gs) as "two dots"
-   is a special (and CPP doesn't want to concatenate two dots in
-   general);
+ - propagate `--sectname-subst` to KBUILD_AFLAGS in
+   x86/boot/Makefile and x86/boot/compressed/Makefile as both
+   override them;
+ - symbols starting with a dot (like ".Lrelocated") should be
+   handled manually with SYM_*_START_SECT(.Lrelocated, relocated)
+   as "two dots" is a special (and CPP doesn't want to concatenate
+   two dots in general);
  - some symbols explicitly need to reside in one section (like
    kexec control code, hibernation page etc.);
  - macros creating aliases for functions (like __memcpy() for
@@ -21,12 +22,12 @@ Notably:
    don't have SYM_PUSH_SECTION() inside);
  - things like ".org", ".align" should be manually pushed to
    the same section the next symbol goes to;
- - expand indirect_thunk and .fixup wildcards in vmlinux.lds.S
-   to catch symbols back into the "main" section;
+ - expand indirect_thunk wildcards in vmlinux.lds.S to catch
+   symbols back into the "main" section;
  - inline ASM functions like __raw_callee*() should be pushed
    manually as well.
 
-With these changes and `-ffunction-sections enabled`, "plain"
+With these changes and `-ffunction-sections` enabled, "plain"
 ".text" section is empty which means that everything works
 right as expected.
 
@@ -40,7 +41,6 @@ Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
  arch/x86/boot/pmjump.S                        |  2 +-
  arch/x86/crypto/aesni-intel_asm.S             |  4 +--
  arch/x86/crypto/poly1305-x86_64-cryptogams.pl |  4 +++
- arch/x86/entry/entry_64.S                     |  2 +-
  arch/x86/include/asm/paravirt.h               |  2 ++
  arch/x86/include/asm/qspinlock_paravirt.h     |  2 ++
  arch/x86/kernel/head_32.S                     |  4 +--
@@ -49,7 +49,7 @@ Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
  arch/x86/kernel/kvm.c                         |  2 ++
  arch/x86/kernel/relocate_kernel_32.S          | 10 +++---
  arch/x86/kernel/relocate_kernel_64.S          | 12 ++++---
- arch/x86/kernel/vmlinux.lds.S                 |  4 +--
+ arch/x86/kernel/vmlinux.lds.S                 |  2 +-
  arch/x86/kvm/emulate.c                        |  7 +++-
  arch/x86/lib/copy_user_64.S                   |  2 +-
  arch/x86/lib/error-inject.c                   |  2 ++
@@ -60,10 +60,10 @@ Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
  arch/x86/lib/putuser.S                        |  2 +-
  arch/x86/power/hibernate_asm_32.S             | 10 +++---
  arch/x86/power/hibernate_asm_64.S             | 10 +++---
- 28 files changed, 91 insertions(+), 52 deletions(-)
+ 27 files changed, 89 insertions(+), 50 deletions(-)
 
 diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
-index 5c2ccb85f2ef..3e4ea355147b 100644
+index 391c4cac8958..f6bb48d41349 100644
 --- a/arch/x86/Kconfig
 +++ b/arch/x86/Kconfig
 @@ -102,6 +102,7 @@ config X86
@@ -73,7 +73,7 @@ index 5c2ccb85f2ef..3e4ea355147b 100644
 +	select ARCH_SUPPORTS_ASM_FUNCTION_SECTIONS
  	select ARCH_SUPPORTS_ATOMIC_RMW
  	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
- 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
+ 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK	if X86_64
 diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
 index b5aecb524a8a..080990b09f06 100644
 --- a/arch/x86/boot/Makefile
@@ -87,10 +87,10 @@ index b5aecb524a8a..080990b09f06 100644
  KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
  GCOV_PROFILE := n
 diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
-index 431bf7f846c3..4bf32db56010 100644
+index 6115274fe10f..e7ee94d5f55a 100644
 --- a/arch/x86/boot/compressed/Makefile
 +++ b/arch/x86/boot/compressed/Makefile
-@@ -55,6 +55,7 @@ KBUILD_CFLAGS += $(CLANG_FLAGS)
+@@ -58,6 +58,7 @@ KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
  CFLAGS_sev.o += -I$(objtree)/arch/x86/lib/
  
  KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
@@ -113,7 +113,7 @@ index 659fad53ca82..a3a667f5e5cd 100644
  
  	.text
 diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
-index 572c535cf45b..c496dab184ef 100644
+index fd9441f40457..b6fb27fd7abd 100644
 --- a/arch/x86/boot/compressed/head_64.S
 +++ b/arch/x86/boot/compressed/head_64.S
 @@ -72,7 +72,7 @@
@@ -251,7 +251,7 @@ index cbec8bd0841f..e647c17000a9 100644
  	movl	%ecx, %ds
  	movl	%ecx, %es
 diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
-index 4e3972570916..d3d511058520 100644
+index 363699dd7220..6b92beb7820a 100644
 --- a/arch/x86/crypto/aesni-intel_asm.S
 +++ b/arch/x86/crypto/aesni-intel_asm.S
 @@ -1752,8 +1752,8 @@ SYM_FUNC_END(aesni_gcm_finalize)
@@ -267,7 +267,7 @@ index 4e3972570916..d3d511058520 100644
 @@ -1763,8 +1763,8 @@ SYM_FUNC_START_LOCAL(_key_expansion_256a)
  	movaps %xmm0, (TKEYP)
  	add $0x10, TKEYP
- 	ret
+ 	RET
 -SYM_FUNC_END(_key_expansion_256a)
  SYM_FUNC_END_ALIAS(_key_expansion_128)
 +SYM_FUNC_END(_key_expansion_256a)
@@ -304,21 +304,8 @@ index 71fae5a09e56..221a4596f390 100644
  ___
  
  &declare_function("poly1305_blocks_avx", 32, 4);
-diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
-index 97b1f84bb53f..15eae25753fb 100644
---- a/arch/x86/entry/entry_64.S
-+++ b/arch/x86/entry/entry_64.S
-@@ -745,7 +745,7 @@ EXPORT_SYMBOL(asm_load_gs_index)
- 	_ASM_EXTABLE(.Lgs_change, .Lbad_gs)
- 	.section .fixup, "ax"
- 	/* running with kernelgs */
--SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
-+SYM_CODE_START_LOCAL_NOALIGN_SECT(.Lbad_gs, bad_gs)
- 	swapgs					/* switch back to user gs */
- .macro ZAP_GS
- 	/* This can't be a string because the preprocessor needs to see it. */
 diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
-index 21c4a694ca11..f045af533161 100644
+index 0d76502cc6f5..3efdac789bc4 100644
 --- a/arch/x86/include/asm/paravirt.h
 +++ b/arch/x86/include/asm/paravirt.h
 @@ -663,6 +663,7 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
@@ -331,14 +318,14 @@ index 21c4a694ca11..f045af533161 100644
  	    PV_THUNK_NAME(func) ":"					\
 @@ -673,6 +674,7 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
  	    FRAME_END							\
- 	    "ret;"							\
+ 	    ASM_RET							\
  	    ".size " PV_THUNK_NAME(func) ", .-" PV_THUNK_NAME(func) ";"	\
 +	    ASM_POP_SECTION() ";"					\
  	    ".popsection")
  
  #define PV_CALLEE_SAVE_REGS_THUNK(func)			\
 diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
-index 159622ee0674..209f610dda18 100644
+index 1474cf96251d..3fde623bbcb2 100644
 --- a/arch/x86/include/asm/qspinlock_paravirt.h
 +++ b/arch/x86/include/asm/qspinlock_paravirt.h
 @@ -35,6 +35,7 @@ PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
@@ -351,19 +338,19 @@ index 159622ee0674..209f610dda18 100644
  	".align 4,0x90;"
 @@ -58,6 +59,7 @@ asm    (".pushsection .text;"
  	FRAME_END
- 	"ret;"
+ 	ASM_RET
  	".size " PV_UNLOCK ", .-" PV_UNLOCK ";"
 +	ASM_POP_SECTION() ";"
  	".popsection");
  
  #else /* CONFIG_64BIT */
 diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
-index d8c64dab0efe..aa7a99876397 100644
+index eb8656bac99b..d58422148481 100644
 --- a/arch/x86/kernel/head_32.S
 +++ b/arch/x86/kernel/head_32.S
 @@ -342,7 +342,7 @@ setup_once:
  	andl $0,setup_once_ref	/* Once is enough, thanks */
- 	ret
+ 	RET
  
 -SYM_FUNC_START(early_idt_handler_array)
 +SYM_FUNC_START_SECT(early_idt_handler_array, early_idt_handler)
@@ -380,10 +367,10 @@ index d8c64dab0efe..aa7a99876397 100644
  	 * The stack is the hardware frame, an error code or zero, and the
  	 * vector number.
 diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
-index d8b3ebd2bb85..1bc081c92775 100644
+index 9c63fc5988cd..a19b6fa2bf87 100644
 --- a/arch/x86/kernel/head_64.S
 +++ b/arch/x86/kernel/head_64.S
-@@ -350,7 +350,7 @@ SYM_DATA(initial_stack, .quad init_thread_union + THREAD_SIZE - FRAME_SIZE)
+@@ -367,7 +367,7 @@ SYM_DATA(initial_stack, .quad init_thread_union + THREAD_SIZE - FRAME_SIZE)
  	__FINITDATA
  
  	__INIT
@@ -392,7 +379,7 @@ index d8b3ebd2bb85..1bc081c92775 100644
  	i = 0
  	.rept NUM_EXCEPTION_VECTORS
  	.if ((EXCEPTION_ERRCODE_MASK >> i) & 1) == 0
-@@ -368,7 +368,7 @@ SYM_CODE_START(early_idt_handler_array)
+@@ -385,7 +385,7 @@ SYM_CODE_START(early_idt_handler_array)
  	UNWIND_HINT_IRET_REGS offset=16
  SYM_CODE_END(early_idt_handler_array)
  
@@ -402,7 +389,7 @@ index d8b3ebd2bb85..1bc081c92775 100644
  	 * The stack is the hardware frame, an error code or zero, and the
  	 * vector number.
 diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
-index fce99e249d61..6938dccfa4a7 100644
+index 6290712cb36d..e0be6bc76337 100644
 --- a/arch/x86/kernel/kprobes/core.c
 +++ b/arch/x86/kernel/kprobes/core.c
 @@ -1019,6 +1019,7 @@ NOKPROBE_SYMBOL(kprobe_int3_handler);
@@ -415,14 +402,14 @@ index fce99e249d61..6938dccfa4a7 100644
  	"__kretprobe_trampoline:\n"
 @@ -1053,6 +1054,7 @@ asm(
  #endif
- 	"	ret\n"
+ 	ASM_RET
  	".size __kretprobe_trampoline, .-__kretprobe_trampoline\n"
 +	ASM_POP_SECTION() "\n"
  );
  NOKPROBE_SYMBOL(__kretprobe_trampoline);
  /*
 diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
-index 59abbdad7729..25a08ba473a0 100644
+index a438217cbfac..6a497d5647e7 100644
 --- a/arch/x86/kernel/kvm.c
 +++ b/arch/x86/kernel/kvm.c
 @@ -1021,6 +1021,7 @@ extern bool __raw_callee_save___kvm_vcpu_is_preempted(long);
@@ -442,7 +429,7 @@ index 59abbdad7729..25a08ba473a0 100644
  
  #endif
 diff --git a/arch/x86/kernel/relocate_kernel_32.S b/arch/x86/kernel/relocate_kernel_32.S
-index f469153eca8a..9077aa9367ca 100644
+index fcc8a7699103..ff36f21e665a 100644
 --- a/arch/x86/kernel/relocate_kernel_32.S
 +++ b/arch/x86/kernel/relocate_kernel_32.S
 @@ -35,7 +35,7 @@
@@ -455,7 +442,7 @@ index f469153eca8a..9077aa9367ca 100644
  
  	pushl	%ebx
 @@ -94,7 +94,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
- 	ret
+ 	RET
  SYM_CODE_END(relocate_kernel)
  
 -SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
@@ -464,7 +451,7 @@ index f469153eca8a..9077aa9367ca 100644
  	pushl	$0
  	/* store the start address on the stack */
 @@ -193,7 +193,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
- 	ret
+ 	RET
  SYM_CODE_END(identity_mapped)
  
 -SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
@@ -482,7 +469,7 @@ index f469153eca8a..9077aa9367ca 100644
  	movl	4(%esp), %ecx
  	pushl	%ebp
 @@ -274,5 +274,7 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
- 	ret
+ 	RET
  SYM_CODE_END(swap_pages)
  
 +SYM_PUSH_SECTION(kexec_control_code)
@@ -490,7 +477,7 @@ index f469153eca8a..9077aa9367ca 100644
  .set kexec_control_code_size, . - relocate_kernel
 +SYM_POP_SECTION()
 diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
-index c8fe74a28143..91336d71dd2d 100644
+index 399f075ccdc4..fb8ff461436e 100644
 --- a/arch/x86/kernel/relocate_kernel_64.S
 +++ b/arch/x86/kernel/relocate_kernel_64.S
 @@ -38,9 +38,11 @@
@@ -507,7 +494,7 @@ index c8fe74a28143..91336d71dd2d 100644
  	/*
  	 * %rdi indirection_page
 @@ -107,7 +109,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
- 	ret
+ 	RET
  SYM_CODE_END(relocate_kernel)
  
 -SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
@@ -516,7 +503,7 @@ index c8fe74a28143..91336d71dd2d 100644
  	/* set return address to 0 if not preserving context */
  	pushq	$0
 @@ -213,7 +215,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
- 	ret
+ 	RET
  SYM_CODE_END(identity_mapped)
  
 -SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
@@ -534,7 +521,7 @@ index c8fe74a28143..91336d71dd2d 100644
  	movq	%rdi, %rcx 	/* Put the page_list in %rcx */
  	xorl	%edi, %edi
 @@ -291,5 +293,7 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
- 	ret
+ 	RET
  SYM_CODE_END(swap_pages)
  
 +SYM_PUSH_SECTION(kexec_control_code)
@@ -542,16 +529,10 @@ index c8fe74a28143..91336d71dd2d 100644
  .set kexec_control_code_size, . - relocate_kernel
 +SYM_POP_SECTION()
 diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
-index 3d6dc12d198f..6f026400261e 100644
+index 27f830345b6f..5550bd68f6e7 100644
 --- a/arch/x86/kernel/vmlinux.lds.S
 +++ b/arch/x86/kernel/vmlinux.lds.S
-@@ -137,12 +137,12 @@ SECTIONS
- 		ALIGN_ENTRY_TEXT_END
- 		SOFTIRQENTRY_TEXT
- 		STATIC_CALL_TEXT
--		*(.fixup)
-+		*(SECT_WILDCARD(.fixup))
- 		*(.gnu.warning)
+@@ -141,7 +141,7 @@ SECTIONS
  
  #ifdef CONFIG_RETPOLINE
  		__indirect_thunk_start = .;
@@ -561,10 +542,10 @@ index 3d6dc12d198f..6f026400261e 100644
  #endif
  	} :text =0xcccc
 diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
-index 28b1a4e57827..00466f15c4ed 100644
+index 40da8c7f3019..85ce58b041ac 100644
 --- a/arch/x86/kvm/emulate.c
 +++ b/arch/x86/kvm/emulate.c
-@@ -307,6 +307,7 @@ static void invalidate_registers(struct x86_emulate_ctxt *ctxt)
+@@ -309,6 +309,7 @@ static void invalidate_registers(struct x86_emulate_ctxt *ctxt)
  static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
  
  #define __FOP_FUNC(name) \
@@ -572,17 +553,17 @@ index 28b1a4e57827..00466f15c4ed 100644
  	".align " __stringify(FASTOP_SIZE) " \n\t" \
  	".type " name ", @function \n\t" \
  	name ":\n\t"
-@@ -316,7 +317,8 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
+@@ -318,7 +319,8 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
  
  #define __FOP_RET(name) \
- 	"ret \n\t" \
+ 	"11: " ASM_RET \
 -	".size " name ", .-" name "\n\t"
 +	".size " name ", .-" name "\n\t" \
 +	ASM_POP_SECTION() "\n\t"
  
  #define FOP_RET(name) \
  	__FOP_RET(#name)
-@@ -324,11 +326,13 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
+@@ -326,11 +328,13 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
  #define FOP_START(op) \
  	extern void em_##op(struct fastop *fake); \
  	asm(".pushsection .text, \"ax\" \n\t" \
@@ -596,7 +577,7 @@ index 28b1a4e57827..00466f15c4ed 100644
  	    ".popsection")
  
  #define __FOPNOP(name) \
-@@ -428,6 +432,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
+@@ -430,6 +434,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
  
  /* Special case for SETcc - 1 instruction per cc */
  #define FOP_SETCC(op) \
@@ -605,23 +586,23 @@ index 28b1a4e57827..00466f15c4ed 100644
  	".type " #op ", @function \n\t" \
  	#op ": \n\t" \
 diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
-index 2797e630b9b1..d351e1288a23 100644
+index 8ca5ecf16dc4..ddbd6b5b7b47 100644
 --- a/arch/x86/lib/copy_user_64.S
 +++ b/arch/x86/lib/copy_user_64.S
-@@ -232,7 +232,7 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
+@@ -220,7 +220,7 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
   * Output:
   * eax uncopied bytes or 0 if successful.
   */
 -SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
 +SYM_CODE_START_LOCAL_SECT(.Lcopy_user_handle_tail, copy_user_handle_tail)
- 	movl %edx,%ecx
- 1:	rep movsb
- 2:	mov %ecx,%eax
+ 	cmp $X86_TRAP_MC,%eax
+ 	je 3f
+ 
 diff --git a/arch/x86/lib/error-inject.c b/arch/x86/lib/error-inject.c
-index be5b5fb1598b..e3ecab588a4c 100644
+index 520897061ee0..720a73d4ee70 100644
 --- a/arch/x86/lib/error-inject.c
 +++ b/arch/x86/lib/error-inject.c
-@@ -7,11 +7,13 @@ asmlinkage void just_return_func(void);
+@@ -8,11 +8,13 @@ asmlinkage void just_return_func(void);
  
  asm(
  	".text\n"
@@ -629,14 +610,14 @@ index be5b5fb1598b..e3ecab588a4c 100644
  	".type just_return_func, @function\n"
  	".globl just_return_func\n"
  	"just_return_func:\n"
- 	"	ret\n"
+ 		ASM_RET
  	".size just_return_func, .-just_return_func\n"
 +	ASM_POP_SECTION() "\n"
  );
  
  void override_function_with_return(struct pt_regs *regs)
 diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
-index fa1bc2104b32..35d93412605a 100644
+index b70d98d79a9d..06d288909a68 100644
 --- a/arch/x86/lib/getuser.S
 +++ b/arch/x86/lib/getuser.S
 @@ -163,8 +163,7 @@ SYM_FUNC_START(__get_user_nocheck_8)
@@ -659,7 +640,7 @@ index fa1bc2104b32..35d93412605a 100644
  bad_get_user_8:
  	xor %edx,%edx
 diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
-index 1cc9da6e29c7..1414c62f7c32 100644
+index 59cf2343f3d9..2dc6033e2932 100644
 --- a/arch/x86/lib/memcpy_64.S
 +++ b/arch/x86/lib/memcpy_64.S
 @@ -27,8 +27,8 @@
@@ -675,7 +656,7 @@ index 1cc9da6e29c7..1414c62f7c32 100644
 @@ -40,8 +40,8 @@ SYM_FUNC_START_WEAK(memcpy)
  	movl %edx, %ecx
  	rep movsb
- 	ret
+ 	RET
 -SYM_FUNC_END(memcpy)
  SYM_FUNC_END_ALIAS(__memcpy)
 +SYM_FUNC_END(memcpy)
@@ -683,7 +664,7 @@ index 1cc9da6e29c7..1414c62f7c32 100644
  EXPORT_SYMBOL(__memcpy)
  
 diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
-index 64801010d312..e397791ec067 100644
+index 50ea390df712..0040ac38751b 100644
 --- a/arch/x86/lib/memmove_64.S
 +++ b/arch/x86/lib/memmove_64.S
 @@ -24,9 +24,8 @@
@@ -700,14 +681,14 @@ index 64801010d312..e397791ec067 100644
 @@ -206,7 +205,7 @@ SYM_FUNC_START(__memmove)
  	movb %r11b, (%rdi)
  13:
- 	retq
+ 	RET
 -SYM_FUNC_END(__memmove)
  SYM_FUNC_END_ALIAS(memmove)
 +SYM_FUNC_END(__memmove)
  EXPORT_SYMBOL(__memmove)
  EXPORT_SYMBOL(memmove)
 diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
-index 9827ae267f96..5fa7f64edc9c 100644
+index d624f2bc42f1..32cf147393e7 100644
 --- a/arch/x86/lib/memset_64.S
 +++ b/arch/x86/lib/memset_64.S
 @@ -17,8 +17,9 @@
@@ -724,7 +705,7 @@ index 9827ae267f96..5fa7f64edc9c 100644
 @@ -41,8 +42,8 @@ SYM_FUNC_START(__memset)
  	rep stosb
  	movq %r9,%rax
- 	ret
+ 	RET
 -SYM_FUNC_END(__memset)
  SYM_FUNC_END_ALIAS(memset)
 +SYM_FUNC_END(__memset)
@@ -732,7 +713,7 @@ index 9827ae267f96..5fa7f64edc9c 100644
  EXPORT_SYMBOL(__memset)
  
 diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
-index 0ea344c5ea43..a7e1be50841a 100644
+index ecb2049c1273..be6b2dc0967c 100644
 --- a/arch/x86/lib/putuser.S
 +++ b/arch/x86/lib/putuser.S
 @@ -102,7 +102,7 @@ SYM_FUNC_END(__put_user_8)
@@ -745,7 +726,7 @@ index 0ea344c5ea43..a7e1be50841a 100644
  .Lbad_put_user:
  	movl $-EFAULT,%ecx
 diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
-index 8786653ad3c0..492dd2bcce4b 100644
+index 5606a15cf9a1..06f666e3e28a 100644
 --- a/arch/x86/power/hibernate_asm_32.S
 +++ b/arch/x86/power/hibernate_asm_32.S
 @@ -16,7 +16,7 @@
@@ -758,7 +739,7 @@ index 8786653ad3c0..492dd2bcce4b 100644
  	movl %ebx, saved_context_ebx
  	movl %ebp, saved_context_ebp
 @@ -35,7 +35,7 @@ SYM_FUNC_START(swsusp_arch_suspend)
- 	ret
+ 	RET
  SYM_FUNC_END(swsusp_arch_suspend)
  
 -SYM_CODE_START(restore_image)
@@ -788,7 +769,7 @@ index 8786653ad3c0..492dd2bcce4b 100644
  	movl	%ebp, %cr3
  	movl	mmu_cr4_features, %ecx
 diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
-index d9bed596d849..225be7a985d5 100644
+index 0a0539e1cc81..fdca1949ad9f 100644
 --- a/arch/x86/power/hibernate_asm_64.S
 +++ b/arch/x86/power/hibernate_asm_64.S
 @@ -24,8 +24,10 @@
@@ -804,7 +785,7 @@ index d9bed596d849..225be7a985d5 100644
  	movq    %r9, %cr3
  
 @@ -69,7 +71,7 @@ SYM_FUNC_START(restore_registers)
- 	ret
+ 	RET
  SYM_FUNC_END(restore_registers)
  
 -SYM_FUNC_START(swsusp_arch_suspend)
@@ -813,7 +794,7 @@ index d9bed596d849..225be7a985d5 100644
  	movq	%rsp, pt_regs_sp(%rax)
  	movq	%rbp, pt_regs_bp(%rax)
 @@ -99,7 +101,7 @@ SYM_FUNC_START(swsusp_arch_suspend)
- 	ret
+ 	RET
  SYM_FUNC_END(swsusp_arch_suspend)
  
 -SYM_FUNC_START(restore_image)
@@ -831,5 +812,5 @@ index d9bed596d849..225be7a985d5 100644
  	movq	%rax, %cr3
  	/* flush TLB */
 -- 
-2.33.1
+2.34.1
 
diff --git a/0006-x86-decouple-ORC-table-sorting-into-a-separate-file.patch b/0006-x86-decouple-ORC-table-sorting-into-a-separate-file.patch
index 15cebf05e392..8d19203e6f3d 100644
--- a/0006-x86-decouple-ORC-table-sorting-into-a-separate-file.patch
+++ b/0006-x86-decouple-ORC-table-sorting-into-a-separate-file.patch
@@ -1,7 +1,8 @@
-From 3a67355398231e6c81343069cb4682e6e3404766 Mon Sep 17 00:00:00 2001
+From 51fa39c629ffb032548911b411b3fd4dc6b48788 Mon Sep 17 00:00:00 2001
 From: Alexander Lobakin <alexandr.lobakin@intel.com>
 Date: Wed, 22 Dec 2021 21:36:33 +0100
-Subject: [PATCH v9 06/15] x86: decouple ORC table sorting into a separate file
+Subject: [PATCH v10 06/15] x86: decouple ORC table sorting into a separate
+ file
 
 In order to be able to sort ORC entries from both the kernel and
 the pre-boot compressed environment, place ORC sorting function
@@ -18,11 +19,11 @@ Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
 ---
  arch/x86/include/asm/orc_types.h       |  7 +++
  arch/x86/kernel/unwind_orc.c           | 63 +--------------------
- arch/x86/lib/Makefile                  |  1 +
- arch/x86/lib/orc.c                     | 76 ++++++++++++++++++++++++++
+ arch/x86/lib/Makefile                  |  3 +
+ arch/x86/lib/orc.c                     | 78 ++++++++++++++++++++++++++
  scripts/sorttable.h                    |  5 --
  tools/arch/x86/include/asm/orc_types.h |  7 +++
- 6 files changed, 92 insertions(+), 67 deletions(-)
+ 6 files changed, 96 insertions(+), 67 deletions(-)
  create mode 100644 arch/x86/lib/orc.c
 
 diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
@@ -132,23 +133,25 @@ index 2de3c8c5eba9..e5748bf15966 100644
  	mod->arch.orc_unwind_ip = orc_ip;
  	mod->arch.orc_unwind = orc;
 diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
-index c6506c6a7092..4335518adcaf 100644
+index f76747862bd2..ff094cecebc4 100644
 --- a/arch/x86/lib/Makefile
 +++ b/arch/x86/lib/Makefile
-@@ -50,6 +50,7 @@ lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o insn-eval.o
+@@ -50,6 +50,9 @@ lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o insn-eval.o
  lib-$(CONFIG_RANDOMIZE_BASE) += kaslr.o
  lib-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
  lib-$(CONFIG_RETPOLINE) += retpoline.o
++ifdef CONFIG_MODULES
 +lib-$(CONFIG_UNWINDER_ORC) += orc.o
++endif
  
  obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
  obj-y += iomem.o
 diff --git a/arch/x86/lib/orc.c b/arch/x86/lib/orc.c
 new file mode 100644
-index 000000000000..5c37494bbbb5
+index 000000000000..6a42842bf4ef
 --- /dev/null
 +++ b/arch/x86/lib/orc.c
-@@ -0,0 +1,76 @@
+@@ -0,0 +1,78 @@
 +// SPDX-License-Identifier: GPL-2.0-only
 +/*
 + * ORC sorting shared by the compressed boot code and ORC module
@@ -208,6 +211,7 @@ index 000000000000..5c37494bbbb5
 +	 * whitelisted .o files which didn't get objtool generation.
 +	 */
 +	orc_a = cur_orc_table + (a - cur_orc_ip_table);
++
 +	return orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end ? -1 : 1;
 +}
 +
@@ -219,17 +223,18 @@ index 000000000000..5c37494bbbb5
 +	 * .orc_unwind entry so they can both be swapped.
 +	 */
 +	sort_mutex_lock();
++
 +	cur_orc_ip_table = ip_table;
 +	cur_orc_table = orc_table;
-+	sort(ip_table, num_orcs, sizeof(int), orc_sort_cmp,
-+	     orc_sort_swap);
++	sort(ip_table, num_orcs, sizeof(int), orc_sort_cmp, orc_sort_swap);
++
 +	sort_mutex_unlock();
 +}
 diff --git a/scripts/sorttable.h b/scripts/sorttable.h
-index a2baa2fefb13..44f8d7d654ff 100644
+index deb7c1d3e979..a6bb46f36854 100644
 --- a/scripts/sorttable.h
 +++ b/scripts/sorttable.h
-@@ -96,11 +96,6 @@ struct orc_entry *g_orc_table;
+@@ -103,11 +103,6 @@ struct orc_entry *g_orc_table;
  
  pthread_t orc_sort_thread;
  
@@ -260,5 +265,5 @@ index 5a2baf28a1dc..7708548713c4 100644
  
  #endif /* _ORC_TYPES_H */
 -- 
-2.33.1
+2.34.1
 
diff --git a/0007-Makefile-Add-build-and-config-option-for-CONFIG_FG_K.patch b/0007-Makefile-add-config-options-and-build-scripts-for-FG.patch
similarity index 65%
rename from 0007-Makefile-Add-build-and-config-option-for-CONFIG_FG_K.patch
rename to 0007-Makefile-add-config-options-and-build-scripts-for-FG.patch
index c798a0b89456..8b8445ae9c96 100644
--- a/0007-Makefile-Add-build-and-config-option-for-CONFIG_FG_K.patch
+++ b/0007-Makefile-add-config-options-and-build-scripts-for-FG.patch
@@ -1,35 +1,38 @@
-From 259a6e21bc646c8e0a5e1f3928ca389064246d1b Mon Sep 17 00:00:00 2001
+From 4dabd4d7cc343fc2c0af0a3a9326dbbc06922808 Mon Sep 17 00:00:00 2001
 From: Kristen Carlson Accardi <kristen@linux.intel.com>
 Date: Fri, 27 Aug 2021 15:57:37 +0200
-Subject: [PATCH v9 07/15] Makefile: Add build and config option for
- CONFIG_FG_KASLR
+Subject: [PATCH v10 07/15] Makefile: add config options and build scripts for
+ FG-KASLR
 
-Allow user to select CONFIG_FG_KASLR if dependencies are met. Change
-the make file to build with -ffunction-sections if CONFIG_FG_KASLR.
+Add Kconfig symbols CONFIG_ARCH_SUPPORTS_FG_KASLR and
+CONFIG_FG_KASLR. The first is hidden and used to indicate that
+a particular architecture supports it, the second allows a user
+to enable FG-KASLR when the former is set to 'y'.
+Make Kbuild not consolidate function sections back into `.text`
+on linking if CONFIG_FG_KASLR is enabled (even with
+CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y) as the feature itself
+relies on functions still being separated in the final vmlinux.
 
-While the only architecture that supports CONFIG_FG_KASLR does not
-currently enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION, make sure these
-2 features play nicely together for the future by ensuring that if
-CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is selected when used with
-CONFIG_FG_KASLR the function sections will not be consolidated back
-into .text. Thanks to Kees Cook for the dead code elimination changes.
+Alexander Lobakin:
 
-alobakin:
-Improve cflags management in the top Makefile: don't turn on
--f{data,function}-sections with ClangLTO as this is a no-op
-provoking a full rebuild.
-Add ".symtab_shndx" to the list of known sections since we are going
-to support it. Otherwise LD will emit a warning when there are more
-than 64k sections and CONFIG_LD_ORPHAN_WARN=y.
+Improve KBUILD_CFLAGS{,_MODULE} management in the top Makefile:
+don't turn on -f{data,function}-sections with ClangLTO as this is a
+no-op provoking a full rebuild.
+Add ".symtab_shndx" to the list of known sections since it is going
+to be supported by the architecture-specific code. Otherwise LD
+emits a warning when there are more than 64k sections and
+CONFIG_LD_ORPHAN_WARN=y.
 Turn ".text" LD script wildcard into ".text.__unused__" to make sure
 all kernel code will land into our special sections.
 Make FG-KASLR depend on `-z unique-symbol`. With every function being
 in a separate section (randomly ordered each boot), position-based
-search is impossible. This flag is likely to be widely available.
+search is impossible. This flag is likely to be widely available
+(on non-LLD builds).
 
 Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
-Reviewed-by: Tony Luck <tony.luck@intel.com>
+Suggested-by: Kees Cook <keescook@chromium.org> # coexistence with DCE
 Reviewed-by: Kees Cook <keescook@chromium.org>
+Reviewed-by: Tony Luck <tony.luck@intel.com>
 Tested-by: Tony Luck <tony.luck@intel.com>
 Co-developed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
 Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
@@ -37,15 +40,15 @@ Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
  Makefile                          | 17 ++++++++++++++---
  arch/Kconfig                      |  6 +++++-
  include/asm-generic/vmlinux.lds.h | 20 ++++++++++++++++++--
- include/linux/linkage.h           |  3 ++-
- init/Kconfig                      | 18 ++++++++++++++++--
- 5 files changed, 55 insertions(+), 9 deletions(-)
+ include/linux/linkage.h           |  9 +++++----
+ init/Kconfig                      | 19 +++++++++++++++++--
+ 5 files changed, 59 insertions(+), 12 deletions(-)
 
 diff --git a/Makefile b/Makefile
-index b921b1fabf70..3346269341d4 100644
+index fbe2d13028f4..4328d53d8b25 100644
 --- a/Makefile
 +++ b/Makefile
-@@ -883,7 +883,7 @@ KBUILD_CFLAGS += -fno-inline-functions-called-once
+@@ -872,7 +872,7 @@ KBUILD_CFLAGS += -fno-inline-functions-called-once
  endif
  
  # Prefer linking with the `-z unique-symbol` if available, this eliminates
@@ -54,7 +57,7 @@ index b921b1fabf70..3346269341d4 100644
  ifeq ($(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL)$(CONFIG_LIVEPATCH),yy)
  KBUILD_LDFLAGS += -z unique-symbol
  endif
-@@ -892,7 +892,7 @@ endif
+@@ -881,7 +881,7 @@ endif
  # `include/linux/linkage.h` for explanation. This flag is to enable GAS to
  # insert the name of the previous section instead of `%S` inside .pushsection
  ifdef CONFIG_HAVE_ASM_FUNCTION_SECTIONS
@@ -63,7 +66,7 @@ index b921b1fabf70..3346269341d4 100644
  SECSUBST_AFLAGS := -Wa,--sectname-subst
  KBUILD_AFLAGS_KERNEL += $(SECSUBST_AFLAGS)
  KBUILD_CFLAGS_KERNEL += $(SECSUBST_AFLAGS)
-@@ -906,8 +906,19 @@ KBUILD_CFLAGS_MODULE += -Wa,--sectname-subst
+@@ -895,8 +895,19 @@ KBUILD_CFLAGS_MODULE += -Wa,--sectname-subst
  endif
  endif # CONFIG_HAVE_ASM_FUNCTION_SECTIONS
  
@@ -85,15 +88,15 @@ index b921b1fabf70..3346269341d4 100644
  endif
  
 diff --git a/arch/Kconfig b/arch/Kconfig
-index b31a836bc252..01c026d090d4 100644
+index 550f0599e211..e06aeeea39f4 100644
 --- a/arch/Kconfig
 +++ b/arch/Kconfig
-@@ -1316,7 +1316,11 @@ config ARCH_SUPPORTS_ASM_FUNCTION_SECTIONS
+@@ -1326,7 +1326,11 @@ config ARCH_SUPPORTS_ASM_FUNCTION_SECTIONS
  	bool
  	help
  	  An arch should select this if it can be built and run with its
--	  ASM functions placed into separate sections to improve DCE and LTO.
-+	  ASM functions placed into separate sections to improve DCE, LTO
+-	  asm functions placed into separate sections to improve DCE and LTO.
++	  asm functions placed into separate sections to improve DCE, LTO
 +	  and FG-KASLR.
 +
 +config ARCH_SUPPORTS_FG_KASLR
@@ -153,15 +156,17 @@ index e7b8a84e0e64..586465b2abb2 100644
  		.shstrtab 0 : { *(.shstrtab) }
  
 diff --git a/include/linux/linkage.h b/include/linux/linkage.h
-index 0c0ddf4429dc..f3c96fb6a534 100644
+index f3b966a6427e..95ca162a868c 100644
 --- a/include/linux/linkage.h
 +++ b/include/linux/linkage.h
-@@ -75,10 +75,11 @@
+@@ -75,11 +75,12 @@
  
  /*
   * Allow ASM symbols to have their own unique sections if they are being
-- * generated by the compiler for C functions (DCE, LTO).
-+ * generated by the compiler for C functions (DCE, FG-KASLR, LTO).
+- * generated by the compiler for C functions (DCE, LTO). Correlates with
+- * the presence of the `-ffunction-section` in KBUILD_CFLAGS.
++ * generated by the compiler for C functions (DCE, FG-KASLR, LTO). Correlates
++ * with the presence of the `-ffunction-section` in KBUILD_CFLAGS.
   */
  #if defined(CONFIG_HAVE_ASM_FUNCTION_SECTIONS) && \
      ((defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) && !defined(MODULE)) || \
@@ -169,22 +174,39 @@ index 0c0ddf4429dc..f3c96fb6a534 100644
       (defined(CONFIG_LTO_CLANG)))
  
  #define SYM_PUSH_SECTION(name)				\
+@@ -91,13 +92,13 @@
+ #define __ASM_PUSH_SECTION(name)			\
+ 	".pushsection %S." name ", \"ax\""
+ 
+-#else /* !(CONFIG_HAVE_ASM_FUNCTION_SECTIONS && (DCE || LTO)) */
++#else /* !(CONFIG_HAVE_ASM_FUNCTION_SECTIONS && (DCE || FG_KASLR || LTO)) */
+ 
+ #define SYM_PUSH_SECTION(name)
+ #define SYM_POP_SECTION()
+ #define __ASM_PUSH_SECTION(name)
+ 
+-#endif /* !(CONFIG_HAVE_ASM_FUNCTION_SECTIONS && (DCE || LTO)) */
++#endif /* !(CONFIG_HAVE_ASM_FUNCTION_SECTIONS && (DCE || FG_KASLR || LTO)) */
+ 
+ #define ASM_PUSH_SECTION(name)				\
+ 	__ASM_PUSH_SECTION(__stringify(name))
 diff --git a/init/Kconfig b/init/Kconfig
-index 3babc0aeac61..a74b3c3acb49 100644
+index 4acfc80f22df..26f9a6e52dbd 100644
 --- a/init/Kconfig
 +++ b/init/Kconfig
-@@ -1394,8 +1394,8 @@ config HAVE_ASM_FUNCTION_SECTIONS
- 	  This enables ASM function sections if both architecture
- 	  and toolchain supports that. It allows creating a separate
- 	  .text section for each ASM function in order to improve
--	  DCE and LTO (works the same way as -ffunction-sections for
--	  C code).
-+	  DCE, LTO and FG-KASLR (works the same way as -ffunction-sections
+@@ -1393,8 +1393,9 @@ config HAVE_ASM_FUNCTION_SECTIONS
+ 	help
+ 	  This enables asm function sections if both architecture and
+ 	  toolchain support it. It allows creating a separate section
+-	  for each function written in assembly in order to improve DCE
+-	  and LTO (works the same way as -ffunction-sections for C code).
++	  for each function written in assembly in order to improve DCE,
++	  LTO and FG-KASLR (works the same way as -ffunction-sections
 +	  for C code).
  
  config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
  	bool
-@@ -2065,6 +2065,20 @@ config PROFILING
+@@ -2061,6 +2062,20 @@ config PROFILING
  config TRACEPOINTS
  	bool
  
@@ -206,5 +228,5 @@ index 3babc0aeac61..a74b3c3acb49 100644
  
  source "arch/Kconfig"
 -- 
-2.33.1
+2.34.1
 
diff --git a/0008-x86-tools-Add-relative-relocs-for-randomized-functio.patch b/0008-x86-tools-Add-relative-relocs-for-randomized-functio.patch
index 240a2efd1df8..197364848196 100644
--- a/0008-x86-tools-Add-relative-relocs-for-randomized-functio.patch
+++ b/0008-x86-tools-Add-relative-relocs-for-randomized-functio.patch
@@ -1,7 +1,7 @@
-From 052c4d03eca1ae7c3925d4b829c2d25ad998588f Mon Sep 17 00:00:00 2001
+From 786423924d3f28a659978af6f2eeb96d050a6793 Mon Sep 17 00:00:00 2001
 From: Kristen Carlson Accardi <kristen@linux.intel.com>
 Date: Fri, 27 Aug 2021 16:08:09 +0200
-Subject: [PATCH v9 08/15] x86/tools: Add relative relocs for randomized
+Subject: [PATCH v10 08/15] x86/tools: Add relative relocs for randomized
  functions
 
 When reordering functions, the relative offsets for relocs that
@@ -10,11 +10,14 @@ sections will need to be adjusted. Add code to detect whether a
 reloc satisfies these cases, and if so, add them to the appropriate
 reloc list.
 
+Alexander Lobakin:
+
+Don't split relocs' usage string across lines to ease grepping.
+
 Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
 Reviewed-by: Tony Luck <tony.luck@intel.com>
 Tested-by: Tony Luck <tony.luck@intel.com>
 Reviewed-by: Kees Cook <keescook@chromium.org>
-[ alobakin: don't split relocs' usage string across lines ]
 Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
 ---
  arch/x86/boot/compressed/Makefile |  7 ++++++-
@@ -24,10 +27,10 @@ Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
  4 files changed, 45 insertions(+), 12 deletions(-)
 
 diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
-index 4bf32db56010..2cf809f5c642 100644
+index e7ee94d5f55a..b1f5817c5737 100644
 --- a/arch/x86/boot/compressed/Makefile
 +++ b/arch/x86/boot/compressed/Makefile
-@@ -107,6 +107,11 @@ $(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
+@@ -110,6 +110,11 @@ $(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
  	$(call if_changed,ld)
  
  OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
@@ -39,7 +42,7 @@ index 4bf32db56010..2cf809f5c642 100644
  $(obj)/vmlinux.bin: vmlinux FORCE
  	$(call if_changed,objcopy)
  
-@@ -114,7 +119,7 @@ targets += $(patsubst $(obj)/%,%,$(vmlinux-objs-y)) vmlinux.bin.all vmlinux.relo
+@@ -117,7 +122,7 @@ targets += $(patsubst $(obj)/%,%,$(vmlinux-objs-y)) vmlinux.bin.all vmlinux.relo
  
  CMD_RELOCS = arch/x86/tools/relocs
  quiet_cmd_relocs = RELOCS  $@
@@ -49,7 +52,7 @@ index 4bf32db56010..2cf809f5c642 100644
  	$(call if_changed,relocs)
  
 diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
-index c736cf2ac76b..8aa1f39be561 100644
+index e2c5b296120d..96b6042fc76f 100644
 --- a/arch/x86/tools/relocs.c
 +++ b/arch/x86/tools/relocs.c
 @@ -45,6 +45,8 @@ struct section {
@@ -186,5 +189,5 @@ index 6634352a20bc..d6acda36575a 100644
  	return 0;
  }
 -- 
-2.33.1
+2.34.1
 
diff --git a/0009-x86-Add-support-for-function-granular-KASLR.patch b/0009-x86-Add-support-for-function-granular-KASLR.patch
index 0ebc0dedf4fe..bc167354f4b0 100644
--- a/0009-x86-Add-support-for-function-granular-KASLR.patch
+++ b/0009-x86-Add-support-for-function-granular-KASLR.patch
@@ -1,11 +1,10 @@
-From 332cdd61cec4b2315b1fa440947f014e8cd77f3f Mon Sep 17 00:00:00 2001
+From 0f075ed9b0a747d78e0cb74df5c9f90ae1273061 Mon Sep 17 00:00:00 2001
 From: Kristen Carlson Accardi <kristen@linux.intel.com>
 Date: Fri, 27 Aug 2021 16:13:21 +0200
-Subject: [PATCH v9 09/15] x86: Add support for function granular KASLR
+Subject: [PATCH v10 09/15] x86: Add support for function granular KASLR
 
-This commit contains the changes required to re-layout the kernel text
-sections generated by -ffunction-sections shortly after decompression.
-Documentation of the feature is also added.
+Add the x86-specific bits to re-layout the kernel text sections
+generated by -ffunction-sections shortly after decompression.
 
 After decompression, the decompressed image's elf headers are parsed.
 In order to manually update certain data structures that are built with
@@ -37,7 +36,8 @@ with new symbol locations, and then re-sorted by the new address. The
 orc table will have been updated as part of applying relocations, but since
 it is expected to be sorted by address, it will need to be resorted.
 
-alobakin:
+Alexander Lobakin:
+
 Handle .altinstr_replacement relocations. Add vmlinux symbols to be
 able to determine if a code location belongs to them, and treat this
 code as text.
@@ -45,11 +45,10 @@ Use the new "gen-symbols.h" header file to ad hoc create a list of
 symbols needed for both objcopy (as plain text) and C source
 (fgkaslr.c, twice). With this approach, it's easier to add new
 sections if needed.
-Make use of our "arch/x86/lib/orc.c" introduced a bunch commits
-earlier to sort ORC entries at pre-boot time -- include it directly,
-similarly to extable.c et al.
-Finally, use the new shuffle_array() macro landed in the kallsyms
-commit to randomize our section list.
+Make use of the "arch/x86/lib/orc.c" to sort ORC entries at pre-boot
+time -- include it directly, similarly to extable.c et al.
+Finally, use the shuffle_array() macro instead of open-coding it
+to randomize the section list.
 
 Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
 Reviewed-by: Tony Luck <tony.luck@intel.com>
@@ -62,15 +61,15 @@ Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
 ---
  arch/x86/boot/compressed/.gitignore    |   1 +
  arch/x86/boot/compressed/Makefile      |  15 +-
- arch/x86/boot/compressed/fgkaslr.c     | 755 +++++++++++++++++++++++++
+ arch/x86/boot/compressed/fgkaslr.c     | 752 +++++++++++++++++++++++++
  arch/x86/boot/compressed/gen-symbols.h |  30 +
- arch/x86/boot/compressed/misc.c        | 153 ++++-
+ arch/x86/boot/compressed/misc.c        | 144 ++++-
  arch/x86/boot/compressed/misc.h        |  28 +
- arch/x86/boot/compressed/utils.c       |  13 +
+ arch/x86/boot/compressed/utils.c       |  16 +
  arch/x86/include/asm/boot.h            |  13 +-
  arch/x86/kernel/vmlinux.lds.S          |   2 +
  include/uapi/linux/elf.h               |   1 +
- 10 files changed, 982 insertions(+), 29 deletions(-)
+ 10 files changed, 975 insertions(+), 27 deletions(-)
  create mode 100644 arch/x86/boot/compressed/fgkaslr.c
  create mode 100644 arch/x86/boot/compressed/gen-symbols.h
  create mode 100644 arch/x86/boot/compressed/utils.c
@@ -87,10 +86,10 @@ index 25805199a506..bc5f8436be1d 100644
  mkpiggy
  piggy.S
 diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
-index 2cf809f5c642..6f8dcbbbad80 100644
+index b1f5817c5737..caa7d120f0eb 100644
 --- a/arch/x86/boot/compressed/Makefile
 +++ b/arch/x86/boot/compressed/Makefile
-@@ -90,6 +90,7 @@ vmlinux-objs-y := $(obj)/vmlinux.lds $(obj)/kernel_info.o $(obj)/head_$(BITS).o
+@@ -93,6 +93,7 @@ vmlinux-objs-y := $(obj)/vmlinux.lds $(obj)/kernel_info.o $(obj)/head_$(BITS).o
  
  vmlinux-objs-$(CONFIG_EARLY_PRINTK) += $(obj)/early_serial_console.o
  vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/kaslr.o
@@ -98,7 +97,7 @@ index 2cf809f5c642..6f8dcbbbad80 100644
  ifdef CONFIG_X86_64
  	vmlinux-objs-y += $(obj)/ident_map_64.o
  	vmlinux-objs-y += $(obj)/idt_64.o $(obj)/idt_handlers_64.o
-@@ -108,11 +109,21 @@ $(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
+@@ -111,11 +112,21 @@ $(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
  
  OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
  
@@ -124,16 +123,16 @@ index 2cf809f5c642..6f8dcbbbad80 100644
  targets += $(patsubst $(obj)/%,%,$(vmlinux-objs-y)) vmlinux.bin.all vmlinux.relocs
 diff --git a/arch/x86/boot/compressed/fgkaslr.c b/arch/x86/boot/compressed/fgkaslr.c
 new file mode 100644
-index 000000000000..91b3b6ea3a93
+index 000000000000..85eb1ef574a2
 --- /dev/null
 +++ b/arch/x86/boot/compressed/fgkaslr.c
-@@ -0,0 +1,755 @@
+@@ -0,0 +1,752 @@
 +// SPDX-License-Identifier: GPL-2.0-only
 +/*
 + * This contains the routines needed to reorder the kernel text section
 + * at boot time.
 + *
-+ * Copyright (C) 2020-2021, Intel Corporation.
++ * Copyright (C) 2020-2022, Intel Corporation.
 + * Author: Kristen Carlson Accardi <kristen@linux.intel.com>
 + */
 +
@@ -169,14 +168,14 @@ index 000000000000..91b3b6ea3a93
 +#undef GEN
 +
 +/* addresses in mapped address space */
-+static int *base;
++static int *kallsyms_base;
 +static u8 *names;
 +static unsigned long relative_base;
 +static unsigned int *markers_addr;
 +
 +struct kallsyms_name {
 +	u8 len;
-+	u8 indecis[256];
++	u8 indices[256];
 +};
 +
 +static struct kallsyms_name *names_table;
@@ -324,9 +323,9 @@ index 000000000000..91b3b6ea3a93
 +	int idx1, idx2;
 +
 +	/* Determine our index into the array. */
-+	idx1 = (const int *)a - base;
-+	idx2 = (const int *)b - base;
-+	swap(base[idx1], base[idx2]);
++	idx1 = (const int *)a - kallsyms_base;
++	idx2 = (const int *)b - kallsyms_base;
++	swap(kallsyms_base[idx1], kallsyms_base[idx2]);
 +
 +	/* Swap the names table. */
 +	memcpy(&name_a, &names_table[idx1], sizeof(name_a));
@@ -380,7 +379,7 @@ index 000000000000..91b3b6ea3a93
 +		names_table[i].len = names[offset];
 +		offset++;
 +		for (j = 0; j < names_table[i].len; j++) {
-+			names_table[i].indecis[j] = names[offset];
++			names_table[i].indices[j] = names[offset];
 +			offset++;
 +		}
 +	}
@@ -412,7 +411,7 @@ index 000000000000..91b3b6ea3a93
 +		names[offset] = (u8)names_table[i].len;
 +		offset++;
 +		for (j = 0; j < names_table[i].len; j++) {
-+			names[offset] = (u8)names_table[i].indecis[j];
++			names[offset] = names_table[i].indices[j];
 +			offset++;
 +		}
 +	}
@@ -433,7 +432,7 @@ index 000000000000..91b3b6ea3a93
 +	debug_putstr("\nRe-sorting kallsyms...\n");
 +
 +	num_syms = *(int *)(addr_kallsyms_num_syms + map);
-+	base = (int *)(addr_kallsyms_offsets + map);
++	kallsyms_base = (int *)(addr_kallsyms_offsets + map);
 +	relative_base = *(unsigned long *)(addr_kallsyms_relative_base + map);
 +	markers_addr = (unsigned int *)(addr_kallsyms_markers + map);
 +	names = (u8 *)(addr_kallsyms_names + map);
@@ -452,14 +451,14 @@ index 000000000000..91b3b6ea3a93
 +		 * according to kernel/kallsyms.c, positive offsets are absolute
 +		 * values and negative offsets are relative to the base.
 +		 */
-+		if (base[i] >= 0)
-+			addr = base[i];
++		if (kallsyms_base[i] >= 0)
++			addr = kallsyms_base[i];
 +		else
-+			addr = relative_base - 1 - base[i];
++			addr = relative_base - 1 - kallsyms_base[i];
 +
 +		if (adjust_address(&addr))
 +			/* here we need to recalcuate the offset */
-+			base[i] = relative_base - 1 - addr;
++			kallsyms_base[i] = relative_base - 1 - addr;
 +	}
 +
 +	/*
@@ -468,7 +467,7 @@ index 000000000000..91b3b6ea3a93
 +	 */
 +	deal_with_names(num_syms);
 +
-+	sort(base, num_syms, sizeof(int), kallsyms_cmp, kallsyms_swp);
++	sort(kallsyms_base, num_syms, sizeof(int), kallsyms_cmp, kallsyms_swp);
 +
 +	/* write the newly sorted names table over the old one */
 +	write_sorted_names(num_syms);
@@ -528,9 +527,6 @@ index 000000000000..91b3b6ea3a93
 +	sort_extable(start_ex_table, stop_ex_table);
 +}
 +
-+#define ORC_COMPRESSED_BOOT
-+#include "../../lib/orc.c"
-+
 +static void update_orc_table(unsigned long map)
 +{
 +	int *ip_table = (int *)(addr___start_orc_unwind_ip + map);
@@ -885,7 +881,7 @@ index 000000000000..91b3b6ea3a93
 +}
 diff --git a/arch/x86/boot/compressed/gen-symbols.h b/arch/x86/boot/compressed/gen-symbols.h
 new file mode 100644
-index 000000000000..6828c80dd19f
+index 000000000000..15b7ddec2762
 --- /dev/null
 +++ b/arch/x86/boot/compressed/gen-symbols.h
 @@ -0,0 +1,30 @@
@@ -894,7 +890,7 @@ index 000000000000..6828c80dd19f
 + * List of symbols needed for both C code and objcopy when FG-KASLR is on.
 + * We declare them once and then just use GEN() definition.
 + *
-+ * Copyright (C) 2021, Intel Corporation.
++ * Copyright (C) 2021-2022, Intel Corporation.
 + * Author: Alexander Lobakin <alexandr.lobakin@intel.com>
 + */
 +
@@ -920,27 +916,23 @@ index 000000000000..6828c80dd19f
 +GEN(kallsyms_token_table)
 +#endif /* GEN */
 diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
-index a4339cb2d247..bd733e1abc75 100644
+index a4339cb2d247..838c1b2b721a 100644
 --- a/arch/x86/boot/compressed/misc.c
 +++ b/arch/x86/boot/compressed/misc.c
-@@ -207,10 +207,21 @@ static void handle_relocations(void *output, unsigned long output_len,
+@@ -207,10 +207,19 @@ static void handle_relocations(void *output, unsigned long output_len,
  	if (IS_ENABLED(CONFIG_X86_64))
  		delta = virt_addr - LOAD_PHYSICAL_ADDR;
  
 -	if (!delta) {
--		debug_putstr("No relocation needed... ");
--		return;
 +	/*
 +	 * it is possible to have delta be zero and still have enabled
-+	 * fg kaslr. We need to perform relocations for fgkaslr regardless
++	 * FG-KASLR. We need to perform relocations for it regardless
 +	 * of whether the base address has moved.
 +	 */
-+	if (!IS_ENABLED(CONFIG_FG_KASLR) ||
-+	    cmdline_find_option_bool("nokaslr")) {
-+		if (!delta) {
-+			debug_putstr("No relocation needed... ");
-+			return;
-+		}
++	if ((cmdline_find_option_bool("nokaslr") ||
++	     !IS_ENABLED(CONFIG_FG_KASLR)) && !delta) {
+ 		debug_putstr("No relocation needed... ");
+ 		return;
  	}
 +
 +	pre_relocations_cleanup(map);
@@ -948,7 +940,7 @@ index a4339cb2d247..bd733e1abc75 100644
  	debug_putstr("Performing relocations... ");
  
  	/*
-@@ -234,35 +245,105 @@ static void handle_relocations(void *output, unsigned long output_len,
+@@ -234,35 +243,103 @@ static void handle_relocations(void *output, unsigned long output_len,
  	 */
  	for (reloc = output + output_len - sizeof(*reloc); *reloc; reloc--) {
  		long extended = *reloc;
@@ -968,18 +960,17 @@ index a4339cb2d247..bd733e1abc75 100644
  			error("32-bit relocation outside of kernel!\n");
  
 -		*(uint32_t *)ptr += delta;
-+		value = *(int32_t *)ptr;
++		value = *(u32 *)ptr;
 +
 +		/*
-+		 * If using fgkaslr, the value of the relocation
++		 * If using FG-KASLR, the value of the relocation
 +		 * might need to be changed because it referred
 +		 * to an address that has moved.
 +		 */
 +		adjust_address(&value);
 +
 +		value += delta;
-+
-+		*(uint32_t *)ptr = value;
++		*(u32 *)ptr = value;
  	}
  #ifdef CONFIG_X86_64
  	while (*--reloc) {
@@ -988,8 +979,8 @@ index a4339cb2d247..bd733e1abc75 100644
 +		Elf64_Shdr *s;
 +
 +		/*
-+		 * if using fgkaslr, we might have moved the address
-+		 * of the relocation. Check it to see if it needs adjusting
++		 * if using FG-KASLR, we might have moved the address of
++		 * the relocation. Check it to see if it needs adjusting
 +		 * from the original address.
 +		 */
 +		s = adjust_address(&extended);
@@ -1001,7 +992,7 @@ index a4339cb2d247..bd733e1abc75 100644
  			error("inverse 32-bit relocation outside of kernel!\n");
  
 -		*(int32_t *)ptr -= delta;
-+		value = *(int32_t *)ptr;
++		value = *(s32 *)ptr;
 +		oldvalue = value;
 +
 +		/*
@@ -1014,22 +1005,22 @@ index a4339cb2d247..bd733e1abc75 100644
 +
 +		/*
 +		 * only percpu symbols need to have their values adjusted for
-+		 * base address kaslr since relative offsets within the .text
++		 * base address KASLR since relative offsets within the .text
 +		 * and .text.* sections are ok wrt each other.
 +		 */
 +		if (is_percpu_addr(*reloc, oldvalue))
 +			value -= delta;
 +
-+		*(int32_t *)ptr = value;
++		*(s32 *)ptr = value;
  	}
  	for (reloc--; *reloc; reloc--) {
  		long extended = *reloc;
 +		long value;
 +
 +		/*
-+		 * if using fgkaslr, we might have moved the address
-+		 * of the relocation. Check it to see if it needs adjusting
-+		 * from the original address.
++		 * if using FG-KASLR, we might have moved the address of the
++		 * relocation. Check it to see if it needs adjusting from the
++		 * original address.
 +		 */
 +		adjust_address(&extended);
 +
@@ -1040,7 +1031,7 @@ index a4339cb2d247..bd733e1abc75 100644
  			error("64-bit relocation outside of kernel!\n");
  
 -		*(uint64_t *)ptr += delta;
-+		value = *(int64_t *)ptr;
++		value = *(u64 *)ptr;
 +
 +		/*
 +		 * If using fgkaslr, the value of the relocation
@@ -1050,25 +1041,23 @@ index a4339cb2d247..bd733e1abc75 100644
 +		adjust_address(&value);
 +
 +		value += delta;
-+
-+		*(uint64_t *)ptr = value;
++		*(u64 *)ptr = value;
  	}
 +	post_relocations_cleanup(map);
  #endif
  }
  #else
-@@ -271,6 +352,35 @@ static inline void handle_relocations(void *output, unsigned long output_len,
+@@ -271,6 +348,34 @@ static inline void handle_relocations(void *output, unsigned long output_len,
  { }
  #endif
  
 +static void layout_image(void *output, Elf_Ehdr *ehdr, Elf_Phdr *phdrs)
 +{
-+	int i;
-+	void *dest;
-+	Elf_Phdr *phdr;
++	u32 i;
 +
 +	for (i = 0; i < ehdr->e_phnum; i++) {
-+		phdr = &phdrs[i];
++		const Elf_Phdr *phdr = &phdrs[i];
++		void *dest;
 +
 +		switch (phdr->p_type) {
 +		case PT_LOAD:
@@ -1093,15 +1082,15 @@ index a4339cb2d247..bd733e1abc75 100644
  static void parse_elf(void *output)
  {
  #ifdef CONFIG_X86_64
-@@ -282,6 +392,7 @@ static void parse_elf(void *output)
+@@ -280,6 +385,7 @@ static void parse_elf(void *output)
+ 	Elf32_Ehdr ehdr;
+ 	Elf32_Phdr *phdrs, *phdr;
  #endif
++	int nokaslr;
  	void *dest;
  	int i;
-+	int nokaslr;
  
- 	memcpy(&ehdr, output, sizeof(ehdr));
- 	if (ehdr.e_ident[EI_MAG0] != ELFMAG0 ||
-@@ -292,6 +403,12 @@ static void parse_elf(void *output)
+@@ -292,6 +398,12 @@ static void parse_elf(void *output)
  		return;
  	}
  
@@ -1114,7 +1103,7 @@ index a4339cb2d247..bd733e1abc75 100644
  	debug_putstr("Parsing ELF... ");
  
  	phdrs = malloc(sizeof(*phdrs) * ehdr.e_phnum);
-@@ -300,26 +417,10 @@ static void parse_elf(void *output)
+@@ -300,26 +412,10 @@ static void parse_elf(void *output)
  
  	memcpy(phdrs, output + ehdr.e_phoff, sizeof(*phdrs) * ehdr.e_phnum);
  
@@ -1186,15 +1175,15 @@ index 16ed360b6692..1315a101c1c9 100644
  void choose_random_location(unsigned long input,
 diff --git a/arch/x86/boot/compressed/utils.c b/arch/x86/boot/compressed/utils.c
 new file mode 100644
-index 000000000000..7c3c745f6251
+index 000000000000..0fbc2c18d0b9
 --- /dev/null
 +++ b/arch/x86/boot/compressed/utils.c
-@@ -0,0 +1,13 @@
+@@ -0,0 +1,16 @@
 +// SPDX-License-Identifier: GPL-2.0-only
 +/*
 + * This contains various libraries that are needed for FG-KASLR.
 + *
-+ * Copyright (C) 2020-2021, Intel Corporation.
++ * Copyright (C) 2020-2022, Intel Corporation.
 + * Author: Kristen Carlson Accardi <kristen@linux.intel.com>
 + */
 +
@@ -1203,8 +1192,11 @@ index 000000000000..7c3c745f6251
 +
 +#include "../../../../lib/sort.c"
 +#include "../../../../lib/bsearch.c"
++
++#define ORC_COMPRESSED_BOOT
++#include "../../lib/orc.c"
 diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
-index 9191280d9ea3..ce5fdee49046 100644
+index 9191280d9ea3..a37be0dd3179 100644
 --- a/arch/x86/include/asm/boot.h
 +++ b/arch/x86/include/asm/boot.h
 @@ -24,7 +24,18 @@
@@ -1214,7 +1206,7 @@ index 9191280d9ea3..ce5fdee49046 100644
 -#if defined(CONFIG_KERNEL_BZIP2)
 +#ifdef CONFIG_FG_KASLR
 +/*
-+ * We need extra boot heap when using fgkaslr because we make a copy
++ * We need extra boot heap when using FG-KASLR because we make a copy
 + * of the original decompressed kernel to avoid issues with writing
 + * over ourselves when shuffling the sections. We also need extra
 + * space for resorting kallsyms after shuffling. This value could
@@ -1228,10 +1220,10 @@ index 9191280d9ea3..ce5fdee49046 100644
  #elif defined(CONFIG_KERNEL_ZSTD)
  /*
 diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
-index 6f026400261e..6620f069b7ef 100644
+index 5550bd68f6e7..54f16801e9d6 100644
 --- a/arch/x86/kernel/vmlinux.lds.S
 +++ b/arch/x86/kernel/vmlinux.lds.S
-@@ -304,7 +304,9 @@ SECTIONS
+@@ -303,7 +303,9 @@ SECTIONS
  	 * get the address and the length of them to patch the kernel safely.
  	 */
  	.altinstr_replacement : AT(ADDR(.altinstr_replacement) - LOAD_OFFSET) {
@@ -1254,5 +1246,5 @@ index 61bf4774b8f2..1c74d9594919 100644
   
  typedef struct elf32_shdr {
 -- 
-2.33.1
+2.34.1
 
diff --git a/0010-FG-KASLR-use-a-scripted-approach-to-handle-.text.-se.patch b/0010-FG-KASLR-use-a-scripted-approach-to-handle-.text.-se.patch
index d6daea5c55da..d8a0674d2d15 100644
--- a/0010-FG-KASLR-use-a-scripted-approach-to-handle-.text.-se.patch
+++ b/0010-FG-KASLR-use-a-scripted-approach-to-handle-.text.-se.patch
@@ -1,7 +1,7 @@
-From 9bed576c3e177e0d5d9b7c4d79469110845101ea Mon Sep 17 00:00:00 2001
+From 148870a73d8c955a514cf2362a04fa531bf82ff3 Mon Sep 17 00:00:00 2001
 From: Alexander Lobakin <alexandr.lobakin@intel.com>
 Date: Fri, 27 Aug 2021 16:29:40 +0200
-Subject: [PATCH v9 10/15] FG-KASLR: use a scripted approach to handle .text.*
+Subject: [PATCH v10 10/15] FG-KASLR: use a scripted approach to handle .text.*
  sections
 
 Instead of relying on the linker and his heuristics about where to
@@ -19,12 +19,12 @@ total number of sections and the boottime delay (which is still
 barely noticeable). The values of 4-8 are still strong enough and
 allows to save some space, and so on.
 
-We also keep tracking the maximal alignment we found while
+We also keep tracking the maximum alignment we found while
 traversing through the readelf output and the number of times we
-spotted it. It's actual only for values >= 64 and is required to
+spotted it. It's actual only for values >= 128 and is required to
 reserve some space between the last .text.* section and the _etext
 marker.
-The reason is that e.g. x86 has at least 3 ASM sections (4 with
+The reason is that e.g. x86 has at least 3 asm sections (4 with
 ClangCFI) aligned to 4096, and when mixing them with the small
 sections, we could go past the _etext and render the kernel
 unbootable. This reserved space ensures this won't happen.
@@ -39,15 +39,15 @@ Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
  include/asm-generic/vmlinux.lds.h |   6 ++
  init/Kconfig                      |  14 +++
  scripts/generate_text_sections.pl | 165 ++++++++++++++++++++++++++++++
- scripts/link-vmlinux.sh           |  29 +++++-
- 5 files changed, 216 insertions(+), 2 deletions(-)
+ scripts/link-vmlinux.sh           |  30 +++++-
+ 5 files changed, 217 insertions(+), 2 deletions(-)
  create mode 100755 scripts/generate_text_sections.pl
 
 diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
-index 6620f069b7ef..6f039bf9de34 100644
+index 54f16801e9d6..06ba33f5bc58 100644
 --- a/arch/x86/kernel/vmlinux.lds.S
 +++ b/arch/x86/kernel/vmlinux.lds.S
-@@ -147,9 +147,11 @@ SECTIONS
+@@ -146,9 +146,11 @@ SECTIONS
  #endif
  	} :text =0xcccc
  
@@ -78,10 +78,10 @@ index 586465b2abb2..e63d5a69f1bc 100644
   * GCC 4.5 and later have a 32 bytes section alignment for structures.
   * Except GCC 4.9, that feels the need to align on 64 bytes.
 diff --git a/init/Kconfig b/init/Kconfig
-index a74b3c3acb49..381b063b4925 100644
+index 26f9a6e52dbd..5fbd1c294df4 100644
 --- a/init/Kconfig
 +++ b/init/Kconfig
-@@ -2079,6 +2079,20 @@ config FG_KASLR
+@@ -2076,6 +2076,20 @@ config FG_KASLR
  
  	  If unsure, say N.
  
@@ -104,7 +104,7 @@ index a74b3c3acb49..381b063b4925 100644
  source "arch/Kconfig"
 diff --git a/scripts/generate_text_sections.pl b/scripts/generate_text_sections.pl
 new file mode 100755
-index 000000000000..c95b9be28920
+index 000000000000..999e1b68181f
 --- /dev/null
 +++ b/scripts/generate_text_sections.pl
 @@ -0,0 +1,165 @@
@@ -115,7 +115,7 @@ index 000000000000..c95b9be28920
 +# to avoid orphan/heuristic section placement and double-checks we don't have
 +# any symbols in plain .text section.
 +#
-+# Copyright (C) 2021, Intel Corporation.
++# Copyright (C) 2021-2022, Intel Corporation.
 +# Author: Alexander Lobakin <alexandr.lobakin@intel.com>
 +#
 +
@@ -161,7 +161,7 @@ index 000000000000..c95b9be28920
 +
 +## max alignment found to reserve some space. It would probably be
 +## better to start from 64, but CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B
-+## (which aligns every function to 64b) would kill us then
++## (which aligns every function to 64b) would explode the $count then
 +my $max_align = 128;
 +my $count = 0;
 +
@@ -219,7 +219,7 @@ index 000000000000..c95b9be28920
 +	print "\t\t*(.text)\n";
 +	print "\t}\n";
 +
-+	## If we have ASM function sections, we shouldn't have anything
++	## If we have asm function sections, we shouldn't have anything
 +	## in here.
 +	if ($add_assert) {
 +		print "\tASSERT(SIZEOF(.text.0) == 0, \"Plain .text is not empty!\")\n\n";
@@ -248,7 +248,7 @@ index 000000000000..c95b9be28920
 +}
 +
 +sub print_reserve {
-+	## If we have text sections aligned with 64 bytes or more, make
++	## If we have text sections aligned with 128 bytes or more, make
 +	## sure we reserve some space for them to not overlap _etext
 +	## while shuffling sections.
 +	if (!$count) {
@@ -274,10 +274,10 @@ index 000000000000..c95b9be28920
 +read_sections();
 +print_lds();
 diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
-index 5cdd9bc5c385..9d8894cb1c21 100755
+index 666f7bbc13eb..701cf540c12e 100755
 --- a/scripts/link-vmlinux.sh
 +++ b/scripts/link-vmlinux.sh
-@@ -66,6 +66,22 @@ gen_symversions()
+@@ -70,6 +70,23 @@ gen_symversions()
  	done
  }
  
@@ -285,14 +285,15 @@ index 5cdd9bc5c385..9d8894cb1c21 100755
 +# declare all custom text sections for future boottime shuffling
 +gen_text_sections()
 +{
-+	local a=""
++	local shift=$(sed -n 's/^CONFIG_FG_KASLR_SHIFT=\(.*\)$/\1/p' include/config/auto.conf)
++	local assert=""
 +
-+	[ -n "${CONFIG_HAVE_ASM_FUNCTION_SECTIONS}" ] && a="-a"
++	is_enabled CONFIG_HAVE_ASM_FUNCTION_SECTIONS && assert="-a"
 +
 +	info GEN .tmp_vmlinux.lds
 +
 +	${PERL} ${srctree}/scripts/generate_text_sections.pl	\
-+		${a} -s "${CONFIG_FG_KASLR_SHIFT}" vmlinux.o	\
++		${assert} -s "${shift}" vmlinux.o		\
 +		< "${objtree}/${KBUILD_LDS}"			\
 +		> .tmp_vmlinux.lds
 +}
@@ -300,7 +301,7 @@ index 5cdd9bc5c385..9d8894cb1c21 100755
  # Link of vmlinux.o used for section mismatch analysis
  # ${1} output file
  modpost_link()
-@@ -155,12 +171,19 @@ vmlinux_link()
+@@ -162,12 +179,19 @@ vmlinux_link()
  	local ld
  	local ldflags
  	local ldlibs
@@ -311,16 +312,16 @@ index 5cdd9bc5c385..9d8894cb1c21 100755
  	# skip output file argument
  	shift
  
-+	if [ -n "${CONFIG_FG_KASLR}" ]; then
++	if is_enabled CONFIG_FG_KASLR; then
 +		lds=".tmp_vmlinux.lds"
 +	else
 +		lds="${objtree}/${KBUILD_LDS}"
 +	fi
 +
- 	if [ -n "${CONFIG_LTO_CLANG}" ]; then
+ 	if is_enabled CONFIG_LTO_CLANG; then
  		# Use vmlinux.o instead of performing the slow LTO link again.
  		objs=vmlinux.o
-@@ -182,7 +205,7 @@ vmlinux_link()
+@@ -189,7 +213,7 @@ vmlinux_link()
  		ldlibs=
  	fi
  
@@ -329,17 +330,17 @@ index 5cdd9bc5c385..9d8894cb1c21 100755
  
  	# The kallsyms linking does not need debug symbols included.
  	if [ "$output" != "${output#.tmp_vmlinux.kallsyms}" ] ; then
-@@ -342,6 +365,10 @@ info GEN modules.builtin
+@@ -346,6 +370,10 @@ info GEN modules.builtin
  tr '\0' '\n' < modules.builtin.modinfo | sed -n 's/^[[:alnum:]:_]*\.file=//p' |
  	tr ' ' '\n' | uniq | sed -e 's:^:kernel/:' -e 's/$/.ko/' > modules.builtin
  
-+if [ -n "${CONFIG_FG_KASLR}" ]; then
++if is_enabled CONFIG_FG_KASLR; then
 +	gen_text_sections
 +fi
 +
  btf_vmlinux_bin_o=""
- if [ -n "${CONFIG_DEBUG_INFO_BTF}" ]; then
+ if is_enabled CONFIG_DEBUG_INFO_BTF; then
  	btf_vmlinux_bin_o=.btf.vmlinux.bin.o
 -- 
-2.33.1
+2.34.1
 
diff --git a/0011-x86-boot-allow-FG-KASLR-to-be-selected.patch b/0011-x86-boot-allow-FG-KASLR-to-be-selected.patch
index c38f1de36de4..3675cc78d97f 100644
--- a/0011-x86-boot-allow-FG-KASLR-to-be-selected.patch
+++ b/0011-x86-boot-allow-FG-KASLR-to-be-selected.patch
@@ -1,11 +1,11 @@
-From f6e70105a68e1d772107bc9edc39a6c43e4c0b1d Mon Sep 17 00:00:00 2001
+From 007d007823bf3395e6a086f6f37383b80302a2e5 Mon Sep 17 00:00:00 2001
 From: Alexander Lobakin <alexandr.lobakin@intel.com>
 Date: Fri, 27 Aug 2021 16:43:53 +0200
-Subject: [PATCH v9 11/15] x86/boot: allow FG-KASLR to be selected
+Subject: [PATCH v10 11/15] x86/boot: allow FG-KASLR to be selected
 
-Now that we have full support of FG-KASLR from both kernel core
-and x86 code, allow FG-KASLR to be enabled for x86_64 if the
-"regular" KASLR is also turned on.
+Now that the kernel has full support of FG-KASLR from both core and
+x86 code, allow FG-KASLR to be enabled for x86_64 if the "regular"
+KASLR is also turned on.
 
 Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
 ---
@@ -13,7 +13,7 @@ Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
-index 3e4ea355147b..f7472528f3dd 100644
+index f6bb48d41349..d5442107a915 100644
 --- a/arch/x86/Kconfig
 +++ b/arch/x86/Kconfig
 @@ -105,6 +105,7 @@ config X86
@@ -21,9 +21,9 @@ index 3e4ea355147b..f7472528f3dd 100644
  	select ARCH_SUPPORTS_ATOMIC_RMW
  	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
 +	select ARCH_SUPPORTS_FG_KASLR		if X86_64 && RANDOMIZE_BASE
+ 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK	if X86_64
  	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
  	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
- 	select ARCH_SUPPORTS_LTO_CLANG
 -- 
-2.33.1
+2.34.1
 
diff --git a/0012-module-Reorder-functions.patch b/0012-module-add-arch-indep-FG-KASLR-for-randomizing-funct.patch
similarity index 87%
rename from 0012-module-Reorder-functions.patch
rename to 0012-module-add-arch-indep-FG-KASLR-for-randomizing-funct.patch
index 707f4c8b305e..2461865b59f8 100644
--- a/0012-module-Reorder-functions.patch
+++ b/0012-module-add-arch-indep-FG-KASLR-for-randomizing-funct.patch
@@ -1,7 +1,8 @@
-From f5644bd95ba176c0851073958047eb715a7d30cd Mon Sep 17 00:00:00 2001
+From 85ec1552ebe35533ca5cde2dd1cae081a924e7f5 Mon Sep 17 00:00:00 2001
 From: Kristen Carlson Accardi <kristen@linux.intel.com>
 Date: Fri, 27 Aug 2021 16:51:49 +0200
-Subject: [PATCH v9 12/15] module: Reorder functions
+Subject: [PATCH v10 12/15] module: add arch-indep FG-KASLR for randomizing
+ function layout
 
 Introduce a new config option to allow modules to be re-ordered
 by function. This option can be enabled independently of the
@@ -14,13 +15,15 @@ If a module has functions split out into separate text sections
 (i.e. compiled with the -ffunction-sections flag), reorder the
 functions to provide some code diversification to modules.
 
-alobakin:
+Alexander Lobakin:
+
 Make it work with ClangCFI -- in such builds, .text section must
 always come first and be page-aligned. Exclude it from the shuffle
 list and leave as it is.
 Make this feature depend on `-z unique-symbol` as well, due to the
-very same reasons.
-Traditionally, use common shuffle_array() from <linux/random.h>.
+very same reasons as for FG-KASLR for vmlinux.
+Use common shuffle_array() from <linux/random.h> instead of
+open-coding it.
 
 Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
 Reviewed-by: Kees Cook <keescook@chromium.org>
@@ -41,10 +44,10 @@ Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
  4 files changed, 91 insertions(+), 3 deletions(-)
 
 diff --git a/Makefile b/Makefile
-index 3346269341d4..74d270c77d96 100644
+index 4328d53d8b25..cf7cf5cbdad9 100644
 --- a/Makefile
 +++ b/Makefile
-@@ -900,7 +900,7 @@ export SECSUBST_AFLAGS
+@@ -889,7 +889,7 @@ export SECSUBST_AFLAGS
  endif
  
  # Same for modules. LD DCE doesn't work for them, thus not checking for it
@@ -53,7 +56,7 @@ index 3346269341d4..74d270c77d96 100644
  KBUILD_AFLAGS_MODULE += -Wa,--sectname-subst
  KBUILD_CFLAGS_MODULE += -Wa,--sectname-subst
  endif
-@@ -909,6 +909,10 @@ endif # CONFIG_HAVE_ASM_FUNCTION_SECTIONS
+@@ -898,6 +898,10 @@ endif # CONFIG_HAVE_ASM_FUNCTION_SECTIONS
  # ClangLTO implies `-ffunction-sections -fdata-sections`, no need
  # to specify them manually and trigger a pointless full rebuild
  ifndef CONFIG_LTO_CLANG
@@ -65,10 +68,10 @@ index 3346269341d4..74d270c77d96 100644
  KBUILD_CFLAGS_KERNEL += -ffunction-sections
  endif
 diff --git a/include/linux/linkage.h b/include/linux/linkage.h
-index f3c96fb6a534..deb26069278a 100644
+index 95ca162a868c..12cf21f9d8ad 100644
 --- a/include/linux/linkage.h
 +++ b/include/linux/linkage.h
-@@ -80,6 +80,7 @@
+@@ -81,6 +81,7 @@
  #if defined(CONFIG_HAVE_ASM_FUNCTION_SECTIONS) && \
      ((defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) && !defined(MODULE)) || \
       (defined(CONFIG_FG_KASLR) && !defined(MODULE)) || \
@@ -77,10 +80,10 @@ index f3c96fb6a534..deb26069278a 100644
  
  #define SYM_PUSH_SECTION(name)				\
 diff --git a/init/Kconfig b/init/Kconfig
-index 381b063b4925..38c82e21efd7 100644
+index 5fbd1c294df4..86a2d3fd6390 100644
 --- a/init/Kconfig
 +++ b/init/Kconfig
-@@ -2376,6 +2376,20 @@ config UNUSED_KSYMS_WHITELIST
+@@ -2386,6 +2386,20 @@ config UNUSED_KSYMS_WHITELIST
  	  one per line. The path can be absolute, or relative to the kernel
  	  source tree.
  
@@ -102,7 +105,7 @@ index 381b063b4925..38c82e21efd7 100644
  
  config MODULES_TREE_LOOKUP
 diff --git a/kernel/module.c b/kernel/module.c
-index 84a9141a5e15..802e1098eaf4 100644
+index 46a5c2ed1928..616a622953fa 100644
 --- a/kernel/module.c
 +++ b/kernel/module.c
 @@ -57,6 +57,7 @@
@@ -113,7 +116,7 @@ index 84a9141a5e15..802e1098eaf4 100644
  #include <uapi/linux/module.h>
  #include "module-internal.h"
  
-@@ -1527,7 +1528,7 @@ static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
+@@ -1526,7 +1527,7 @@ static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
  
  	for (section = 0; section < sect_attrs->nsections; section++)
  		kfree(sect_attrs->attrs[section].battr.attr.name);
@@ -122,7 +125,7 @@ index 84a9141a5e15..802e1098eaf4 100644
  }
  
  static void add_sect_attrs(struct module *mod, const struct load_info *info)
-@@ -1544,7 +1545,7 @@ static void add_sect_attrs(struct module *mod, const struct load_info *info)
+@@ -1543,7 +1544,7 @@ static void add_sect_attrs(struct module *mod, const struct load_info *info)
  	size[0] = ALIGN(struct_size(sect_attrs, attrs, nloaded),
  			sizeof(sect_attrs->grp.bin_attrs[0]));
  	size[1] = (nloaded + 1) * sizeof(sect_attrs->grp.bin_attrs[0]);
@@ -131,7 +134,7 @@ index 84a9141a5e15..802e1098eaf4 100644
  	if (sect_attrs == NULL)
  		return;
  
-@@ -2416,6 +2417,71 @@ static bool module_init_layout_section(const char *sname)
+@@ -2415,6 +2416,71 @@ static bool module_init_layout_section(const char *sname)
  	return module_init_section(sname);
  }
  
@@ -203,7 +206,7 @@ index 84a9141a5e15..802e1098eaf4 100644
  /*
   * Lay out the SHF_ALLOC sections in a way not dissimilar to how ld
   * might -- code, read-only data, read-write data, small data.  Tally
-@@ -2510,6 +2576,9 @@ static void layout_sections(struct module *mod, struct load_info *info)
+@@ -2509,6 +2575,9 @@ static void layout_sections(struct module *mod, struct load_info *info)
  			break;
  		}
  	}
@@ -214,5 +217,5 @@ index 84a9141a5e15..802e1098eaf4 100644
  
  static void set_license(struct module *mod, const char *license)
 -- 
-2.33.1
+2.34.1
 
diff --git a/0013-module-use-a-scripted-approach-for-FG-KASLR.patch b/0013-module-use-a-scripted-approach-for-FG-KASLR.patch
index 4d372dd63639..0a45b214e453 100644
--- a/0013-module-use-a-scripted-approach-for-FG-KASLR.patch
+++ b/0013-module-use-a-scripted-approach-for-FG-KASLR.patch
@@ -1,7 +1,7 @@
-From d9657682acf698c3ff18c17435ad16f19b5743ea Mon Sep 17 00:00:00 2001
+From 5a60699c43cc6a9e7f7014bf7c6ae918d1fb1db1 Mon Sep 17 00:00:00 2001
 From: Alexander Lobakin <alexandr.lobakin@intel.com>
 Date: Thu, 23 Dec 2021 00:09:25 +0100
-Subject: [PATCH v9 13/15] module: use a scripted approach for FG-KASLR
+Subject: [PATCH v10 13/15] module: use a scripted approach for FG-KASLR
 
 Use the same methods and scripts to generate an LD script for every
 module containing all the output text sections.
@@ -60,10 +60,10 @@ index e63d5a69f1bc..9f67660ace18 100644
   * Used by scripts/generate_text_sections.pl to inject text sections,
   * harmless if FG-KASLR is disabled.
 diff --git a/init/Kconfig b/init/Kconfig
-index 38c82e21efd7..d4000885b27d 100644
+index 86a2d3fd6390..90951631aa03 100644
 --- a/init/Kconfig
 +++ b/init/Kconfig
-@@ -2381,7 +2381,6 @@ config MODULE_FG_KASLR
+@@ -2391,7 +2391,6 @@ config MODULE_FG_KASLR
  	depends on $(cc-option,-ffunction-sections)
  	depends on LD_HAS_Z_UNIQUE_SYMBOL || !LIVEPATCH
  	default FG_KASLR
@@ -71,7 +71,7 @@ index 38c82e21efd7..d4000885b27d 100644
  	help
  	  This option randomizes the module text section by reordering the text
  	  section by function at module load time. In order to use this
-@@ -2390,6 +2389,20 @@ config MODULE_FG_KASLR
+@@ -2400,6 +2399,20 @@ config MODULE_FG_KASLR
  
  	  If unsure, say N.
  
@@ -142,7 +142,7 @@ index 7f39599e9fae..4ca9d8fc978d 100644
  # Add FORCE to the prequisites of a target to force it to be always rebuilt.
  # ---------------------------------------------------------------------------
 diff --git a/scripts/generate_text_sections.pl b/scripts/generate_text_sections.pl
-index c95b9be28920..79a37a3c079f 100755
+index 999e1b68181f..a05ae9fb0041 100755
 --- a/scripts/generate_text_sections.pl
 +++ b/scripts/generate_text_sections.pl
 @@ -48,6 +48,7 @@ my $readelf = $ENV{'READELF'} || die "$0: ERROR: READELF not set?";
@@ -167,7 +167,7 @@ index c95b9be28920..79a37a3c079f 100755
  			next;
  		}
 @@ -141,7 +148,7 @@ sub print_reserve {
- 	## If we have text sections aligned with 64 bytes or more, make
+ 	## If we have text sections aligned with 128 bytes or more, make
  	## sure we reserve some space for them to not overlap _etext
  	## while shuffling sections.
 -	if (!$count) {
@@ -210,5 +210,5 @@ index 1d0e1e4dc3d2..6e957aa614b1 100644
  
  /* bring in arch-specific sections */
 -- 
-2.33.1
+2.34.1
 
diff --git a/0014-Documentation-add-documentation-for-FG-KASLR.patch b/0014-Documentation-add-documentation-for-FG-KASLR.patch
index 811e0e75de79..018778c38f4c 100644
--- a/0014-Documentation-add-documentation-for-FG-KASLR.patch
+++ b/0014-Documentation-add-documentation-for-FG-KASLR.patch
@@ -1,7 +1,7 @@
-From 612099530af493bdf26798897acf6b922c55b0ae Mon Sep 17 00:00:00 2001
+From e18582a0728127ad8607f1cebbd23314d95e398b Mon Sep 17 00:00:00 2001
 From: Kristen Carlson Accardi <kristen@linux.intel.com>
 Date: Fri, 27 Aug 2021 16:56:23 +0200
-Subject: [PATCH v9 14/15] Documentation: add documentation for FG-KASLR
+Subject: [PATCH v10 14/15] Documentation: add documentation for FG-KASLR
 
 Describe the main principles behind the FG-KASLR hardening feature
 in a new doc section.
@@ -16,10 +16,10 @@ Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
  create mode 100644 Documentation/security/fgkaslr.rst
 
 diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
-index fc34332c8d9a..b79423c5a41a 100644
+index f5a27f067db9..bb8804c5fa5c 100644
 --- a/Documentation/admin-guide/kernel-parameters.txt
 +++ b/Documentation/admin-guide/kernel-parameters.txt
-@@ -2224,6 +2224,12 @@
+@@ -2235,6 +2235,12 @@
  			kernel and module base offset ASLR (Address Space
  			Layout Randomization).
  
@@ -223,5 +223,5 @@ index 16335de04e8c..41444124090f 100644
     lsm
     lsm-development
 -- 
-2.33.1
+2.34.1
 
diff --git a/0015-maintainers-add-MAINTAINERS-entry-for-FG-KASLR.patch b/0015-maintainers-add-MAINTAINERS-entry-for-FG-KASLR.patch
index be939d69282a..61c615cd2352 100644
--- a/0015-maintainers-add-MAINTAINERS-entry-for-FG-KASLR.patch
+++ b/0015-maintainers-add-MAINTAINERS-entry-for-FG-KASLR.patch
@@ -1,7 +1,7 @@
-From 07533a2b6703a950bde7e4a3fce7a752ed17e180 Mon Sep 17 00:00:00 2001
+From 22aaf043900d66d1f0b17a064774aca1d22b81d2 Mon Sep 17 00:00:00 2001
 From: Alexander Lobakin <alexandr.lobakin@intel.com>
 Date: Fri, 27 Aug 2021 16:58:35 +0200
-Subject: [PATCH v9 15/15] maintainers: add MAINTAINERS entry for FG-KASLR
+Subject: [PATCH v10 15/15] maintainers: add MAINTAINERS entry for FG-KASLR
 
 Add an entry for FG-KASLR containing the maintainers, reviewers,
 public mailing lists, files and so on.
@@ -12,10 +12,10 @@ Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
  1 file changed, 12 insertions(+)
 
 diff --git a/MAINTAINERS b/MAINTAINERS
-index 8912b2c1260c..efdb313b6813 100644
+index f53d30463c21..49a0974d32a7 100644
 --- a/MAINTAINERS
 +++ b/MAINTAINERS
-@@ -7853,6 +7853,18 @@ L:	platform-driver-x86@vger.kernel.org
+@@ -7925,6 +7925,18 @@ L:	platform-driver-x86@vger.kernel.org
  S:	Maintained
  F:	drivers/platform/x86/fujitsu-tablet.c
  
@@ -35,5 +35,5 @@ index 8912b2c1260c..efdb313b6813 100644
  M:	Miklos Szeredi <miklos@szeredi.hu>
  L:	linux-fsdevel@vger.kernel.org
 -- 
-2.33.1
+2.34.1
--
2.34.1
