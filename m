Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1394A6439
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242031AbiBASvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:51:35 -0500
Received: from foss.arm.com ([217.140.110.172]:58718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229915AbiBASvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:51:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A35511B3;
        Tue,  1 Feb 2022 10:51:33 -0800 (PST)
Received: from e127744.arm.com (unknown [10.57.88.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4925D3F40C;
        Tue,  1 Feb 2022 10:51:31 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf symbols: Remove demangle-rust files as superfluous
Date:   Tue,  1 Feb 2022 18:50:53 +0000
Message-Id: <20220201185054.1041917-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Demangling of Rust legacy symbols has been working through libbfd for
some time now, making these files no longer needed, so remove them.

Signed-off-by: German Gomez <german.gomez@arm.com>
---
Before and after the commit:

$ perf record rustc
$ perf report

2.98%  rustc    rustc                                [.] <std::collections::hash::map::DefaultHasher as core::hash::Hasher>::write
2.77%  rustc    rustc                                [.] std::collections::hash::map::HashMap<K,V,S>::entry
2.09%  rustc    rustc                                [.] <<toml::value::Value as serde::de::Deserialize>::deserialize::ValueVisitor as serde::de::Visitor>::visit_map
2.05%  rustc    rustc                                [.] <toml::de::MapVisitor as serde::de::MapAccess>::next_key_seed
1.52%  rustc    rustc                                [.] std::collections::hash::map::HashMap<K,V,S>::get
0.59%  rustc    rustc                                [.] <toml::de::MapVisitor as serde::de::MapAccess>::next_value_seed
---
 tools/perf/util/Build           |   1 -
 tools/perf/util/demangle-rust.c | 269 --------------------------------
 tools/perf/util/demangle-rust.h |   8 -
 tools/perf/util/symbol-elf.c    |   7 -
 4 files changed, 285 deletions(-)
 delete mode 100644 tools/perf/util/demangle-rust.c
 delete mode 100644 tools/perf/util/demangle-rust.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 2a403cefc..e59788ef6 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -193,7 +193,6 @@ perf-$(CONFIG_LIBCAP) += cap.o
 
 perf-y += demangle-ocaml.o
 perf-y += demangle-java.o
-perf-y += demangle-rust.o
 
 ifdef CONFIG_JITDUMP
 perf-$(CONFIG_LIBELF) += jitdump.o
diff --git a/tools/perf/util/demangle-rust.c b/tools/perf/util/demangle-rust.c
deleted file mode 100644
index a659fc69f..000000000
--- a/tools/perf/util/demangle-rust.c
+++ /dev/null
@@ -1,269 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <string.h>
-#include "debug.h"
-
-#include "demangle-rust.h"
-
-/*
- * Mangled Rust symbols look like this:
- *
- *     _$LT$std..sys..fd..FileDesc$u20$as$u20$core..ops..Drop$GT$::drop::hc68340e1baa4987a
- *
- * The original symbol is:
- *
- *     <std::sys::fd::FileDesc as core::ops::Drop>::drop
- *
- * The last component of the path is a 64-bit hash in lowercase hex, prefixed
- * with "h". Rust does not have a global namespace between crates, an illusion
- * which Rust maintains by using the hash to distinguish things that would
- * otherwise have the same symbol.
- *
- * Any path component not starting with a XID_Start character is prefixed with
- * "_".
- *
- * The following escape sequences are used:
- *
- *     ","  =>  $C$
- *     "@"  =>  $SP$
- *     "*"  =>  $BP$
- *     "&"  =>  $RF$
- *     "<"  =>  $LT$
- *     ">"  =>  $GT$
- *     "("  =>  $LP$
- *     ")"  =>  $RP$
- *     " "  =>  $u20$
- *     "'"  =>  $u27$
- *     "["  =>  $u5b$
- *     "]"  =>  $u5d$
- *     "~"  =>  $u7e$
- *
- * A double ".." means "::" and a single "." means "-".
- *
- * The only characters allowed in the mangled symbol are a-zA-Z0-9 and _.:$
- */
-
-static const char *hash_prefix = "::h";
-static const size_t hash_prefix_len = 3;
-static const size_t hash_len = 16;
-
-static bool is_prefixed_hash(const char *start);
-static bool looks_like_rust(const char *sym, size_t len);
-static bool unescape(const char **in, char **out, const char *seq, char value);
-
-/*
- * INPUT:
- *     sym: symbol that has been through BFD-demangling
- *
- * This function looks for the following indicators:
- *
- *  1. The hash must consist of "h" followed by 16 lowercase hex digits.
- *
- *  2. As a sanity check, the hash must use between 5 and 15 of the 16 possible
- *     hex digits. This is true of 99.9998% of hashes so once in your life you
- *     may see a false negative. The point is to notice path components that
- *     could be Rust hashes but are probably not, like "haaaaaaaaaaaaaaaa". In
- *     this case a false positive (non-Rust symbol has an important path
- *     component removed because it looks like a Rust hash) is worse than a
- *     false negative (the rare Rust symbol is not demangled) so this sets the
- *     balance in favor of false negatives.
- *
- *  3. There must be no characters other than a-zA-Z0-9 and _.:$
- *
- *  4. There must be no unrecognized $-sign sequences.
- *
- *  5. There must be no sequence of three or more dots in a row ("...").
- */
-bool
-rust_is_mangled(const char *sym)
-{
-	size_t len, len_without_hash;
-
-	if (!sym)
-		return false;
-
-	len = strlen(sym);
-	if (len <= hash_prefix_len + hash_len)
-		/* Not long enough to contain "::h" + hash + something else */
-		return false;
-
-	len_without_hash = len - (hash_prefix_len + hash_len);
-	if (!is_prefixed_hash(sym + len_without_hash))
-		return false;
-
-	return looks_like_rust(sym, len_without_hash);
-}
-
-/*
- * A hash is the prefix "::h" followed by 16 lowercase hex digits. The hex
- * digits must comprise between 5 and 15 (inclusive) distinct digits.
- */
-static bool is_prefixed_hash(const char *str)
-{
-	const char *end;
-	bool seen[16];
-	size_t i;
-	int count;
-
-	if (strncmp(str, hash_prefix, hash_prefix_len))
-		return false;
-	str += hash_prefix_len;
-
-	memset(seen, false, sizeof(seen));
-	for (end = str + hash_len; str < end; str++)
-		if (*str >= '0' && *str <= '9')
-			seen[*str - '0'] = true;
-		else if (*str >= 'a' && *str <= 'f')
-			seen[*str - 'a' + 10] = true;
-		else
-			return false;
-
-	/* Count how many distinct digits seen */
-	count = 0;
-	for (i = 0; i < 16; i++)
-		if (seen[i])
-			count++;
-
-	return count >= 5 && count <= 15;
-}
-
-static bool looks_like_rust(const char *str, size_t len)
-{
-	const char *end = str + len;
-
-	while (str < end)
-		switch (*str) {
-		case '$':
-			if (!strncmp(str, "$C$", 3))
-				str += 3;
-			else if (!strncmp(str, "$SP$", 4)
-					|| !strncmp(str, "$BP$", 4)
-					|| !strncmp(str, "$RF$", 4)
-					|| !strncmp(str, "$LT$", 4)
-					|| !strncmp(str, "$GT$", 4)
-					|| !strncmp(str, "$LP$", 4)
-					|| !strncmp(str, "$RP$", 4))
-				str += 4;
-			else if (!strncmp(str, "$u20$", 5)
-					|| !strncmp(str, "$u27$", 5)
-					|| !strncmp(str, "$u5b$", 5)
-					|| !strncmp(str, "$u5d$", 5)
-					|| !strncmp(str, "$u7e$", 5))
-				str += 5;
-			else
-				return false;
-			break;
-		case '.':
-			/* Do not allow three or more consecutive dots */
-			if (!strncmp(str, "...", 3))
-				return false;
-			/* Fall through */
-		case 'a' ... 'z':
-		case 'A' ... 'Z':
-		case '0' ... '9':
-		case '_':
-		case ':':
-			str++;
-			break;
-		default:
-			return false;
-		}
-
-	return true;
-}
-
-/*
- * INPUT:
- *     sym: symbol for which rust_is_mangled(sym) returns true
- *
- * The input is demangled in-place because the mangled name is always longer
- * than the demangled one.
- */
-void
-rust_demangle_sym(char *sym)
-{
-	const char *in;
-	char *out;
-	const char *end;
-
-	if (!sym)
-		return;
-
-	in = sym;
-	out = sym;
-	end = sym + strlen(sym) - (hash_prefix_len + hash_len);
-
-	while (in < end)
-		switch (*in) {
-		case '$':
-			if (!(unescape(&in, &out, "$C$", ',')
-					|| unescape(&in, &out, "$SP$", '@')
-					|| unescape(&in, &out, "$BP$", '*')
-					|| unescape(&in, &out, "$RF$", '&')
-					|| unescape(&in, &out, "$LT$", '<')
-					|| unescape(&in, &out, "$GT$", '>')
-					|| unescape(&in, &out, "$LP$", '(')
-					|| unescape(&in, &out, "$RP$", ')')
-					|| unescape(&in, &out, "$u20$", ' ')
-					|| unescape(&in, &out, "$u27$", '\'')
-					|| unescape(&in, &out, "$u5b$", '[')
-					|| unescape(&in, &out, "$u5d$", ']')
-					|| unescape(&in, &out, "$u7e$", '~'))) {
-				pr_err("demangle-rust: unexpected escape sequence");
-				goto done;
-			}
-			break;
-		case '_':
-			/*
-			 * If this is the start of a path component and the next
-			 * character is an escape sequence, ignore the
-			 * underscore. The mangler inserts an underscore to make
-			 * sure the path component begins with a XID_Start
-			 * character.
-			 */
-			if ((in == sym || in[-1] == ':') && in[1] == '$')
-				in++;
-			else
-				*out++ = *in++;
-			break;
-		case '.':
-			if (in[1] == '.') {
-				/* ".." becomes "::" */
-				*out++ = ':';
-				*out++ = ':';
-				in += 2;
-			} else {
-				/* "." becomes "-" */
-				*out++ = '-';
-				in++;
-			}
-			break;
-		case 'a' ... 'z':
-		case 'A' ... 'Z':
-		case '0' ... '9':
-		case ':':
-			*out++ = *in++;
-			break;
-		default:
-			pr_err("demangle-rust: unexpected character '%c' in symbol\n",
-				*in);
-			goto done;
-		}
-
-done:
-	*out = '\0';
-}
-
-static bool unescape(const char **in, char **out, const char *seq, char value)
-{
-	size_t len = strlen(seq);
-
-	if (strncmp(*in, seq, len))
-		return false;
-
-	**out = value;
-
-	*in += len;
-	*out += 1;
-
-	return true;
-}
diff --git a/tools/perf/util/demangle-rust.h b/tools/perf/util/demangle-rust.h
deleted file mode 100644
index 2fca618b1..000000000
--- a/tools/perf/util/demangle-rust.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __PERF_DEMANGLE_RUST
-#define __PERF_DEMANGLE_RUST 1
-
-bool rust_is_mangled(const char *str);
-void rust_demangle_sym(char *str);
-
-#endif /* __PERF_DEMANGLE_RUST */
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 31cd59a2b..3ed0bef81 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -14,7 +14,6 @@
 #include "symsrc.h"
 #include "demangle-ocaml.h"
 #include "demangle-java.h"
-#include "demangle-rust.h"
 #include "machine.h"
 #include "vdso.h"
 #include "debug.h"
@@ -258,12 +257,6 @@ static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 			demangled = java_demangle_sym(elf_name, JAVA_DEMANGLE_NORET);
 		}
 	}
-	else if (rust_is_mangled(demangled))
-		/*
-		    * Input to Rust demangling is the BFD-demangled
-		    * name which it Rust-demangles in place.
-		    */
-		rust_demangle_sym(demangled);
 
 	return demangled;
 }
-- 
2.25.1

