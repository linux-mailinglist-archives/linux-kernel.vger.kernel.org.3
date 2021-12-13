Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26358473798
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243847AbhLMWeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243622AbhLMWdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:33:41 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2221C061756
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:33:40 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id b11so12192017pld.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=scGSNt6uiT68GmloPFkLQo38TtY5HHzZRzJwnKb/tm8=;
        b=ai5DZDbo/imH2A3y4iamQ0PI5zmYHQLTwbyd8wxJtevIEPEsA7nhyf8tAmNLpKHwrO
         pQp5kxZTIYqJr1GIvVqZUVCzfDSmqURi9chtDC9Tcl2rilnYGVIxVZsnahqjttehNGRm
         WRjAEp6GTdcSAPlsl1Y+RSR4WmHoWJFt5LHxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=scGSNt6uiT68GmloPFkLQo38TtY5HHzZRzJwnKb/tm8=;
        b=BLk2Z+6hf7jK5OknIb+UnFtRfLHRtn+4iP5DkZSfKuQILJrQkqbYozFLrmCAEZdpit
         tDaNK10pkIbV+Y84XvbVuw8/jmLG1D2b7AFZydOnsRS+3M5p6cNixGtZ3LO4Rc6pYvBz
         XuZD75ey1k3Zq7ROSGj3Bgw7hPRwxgTfqYXQ2pDBKPaoKCRbUgnhoMBEQl7/3vo7+4fd
         JA1vWBZ8hOlnVzoDeNVvq86MRfByv4LXRPWwOkd/653/cpONKZqzTrOc+SaJiZsWHnrC
         L4H8agNZw6RJzLTNjWhjMG1DimC1LUpiBI/O3dZB2vTA69GxzcMOBqr7K5fPWNZq1Uw/
         JdWA==
X-Gm-Message-State: AOAM530chYWUcigVJoFcsFDFD1UfC5ZLPJdA2e3PcwKkvd+iFFlQGgYq
        Rz13NCeOqkwIPpolriKf8dEr8pdj/h6mcw==
X-Google-Smtp-Source: ABdhPJxjK/sMGHAn0cmDPw6Nt+/V3BchIV3eFiKTDmjRfYuNAIc3B8GLXs5lyZN+/3snEEYuXnp/bA==
X-Received: by 2002:a17:903:1103:b0:143:a593:dc41 with SMTP id n3-20020a170903110300b00143a593dc41mr1758392plh.5.1639434819979;
        Mon, 13 Dec 2021 14:33:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c81sm13235931pfb.166.2021.12.13.14.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:33:37 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 06/17] fortify: Detect struct member overflows in memcpy() at compile-time
Date:   Mon, 13 Dec 2021 14:33:20 -0800
Message-Id: <20211213223331.135412-7-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211213223331.135412-1-keescook@chromium.org>
References: <20211213223331.135412-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=20908; h=from:subject; bh=o8OUT+lmB29deLmsQV7f5SXo1+RklL/iuqCwiLuVdtk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBht8o4Gsrhjb3WKKGqZq8rJYVbGonYLXPMahn69eiY 0W1COjCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbfKOAAKCRCJcvTf3G3AJjnID/ 4mouUoNM958UdC0O4Jvn7aj2aR8xq37174JmB8RV65ZiVoRDwVC7RXU2clmLPbR0bvwwRk2t/3lsXZ R+6h4+tA44HjJjS5hiitpLSVP45Af90+l4wf15eL4TXDcVPgCFfJvBrN5O2nIDshg4hCj2jL38uyeJ CsN0N8PazwIE6nD/cg3E4aQ/WMZFT1H39znEsC2dxoINLVBTKbAy53AvFOu9C8vnIUPKRl7UNmJUB6 sshUj7fbljTo4npptqUS3PFlZgRDRyrH5U/cyGZH8Sw7zRGZWb12SLpHrM5/vdLS6LetsdM1F69qGb Jo+eH5sEk1Y7dfx2AC8tsdCQ/xMV2BfR9/4IZvBKe59++CnWjmLYecfYddESWrn5BH12nNyKUQ6LcV 14X26LStsZsGDqZiPHNpefa1rEPSxMqs8UwDlwtfidMDtble2P5PrBY29b4T8Rsp9XG5ZpgKebM9RM STUlzbfaUtnreIs4SIG59euMDwI4UB8+B0oiSJpuNBPnItFgxdtf/Yl56PsYvyYSS6nR5TW1wiSH2e XJ31NRp7EGHVZUJqlD+fec+ClUpfqBrZwhiZuE7sIzlJcW57aafHh8RNdiDDU2ACWi3xP/hL2fFLn2 8Blo8tjV6FtJsLbIYwH+261VWx81ywVpmPQurbaX507TmAcxjuypBZXMtVrw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memcpy() is dead; long live memcpy()

tl;dr: In order to eliminate a large class of common buffer overflow
flaws that continue to persist in the kernel, have memcpy() (under
CONFIG_FORTIFY_SOURCE) perform bounds checking of the destination struct
member when they have a known size. This would have caught all of the
memcpy()-related buffer write overflow flaws identified in at least the
last three years.

Background and analysis:

While stack-based buffer overflow flaws are largely mitigated by stack
canaries (and similar) features, heap-based buffer overflow flaws continue
to regularly appear in the kernel. Many classes of heap buffer overflows
are mitigated by FORTIFY_SOURCE when using the strcpy() family of
functions, but a significant number remain exposed through the memcpy()
family of functions.

At its core, FORTIFY_SOURCE uses the compiler's __builtin_object_size()
internal[0] to determine the available size at a target address based on
the compile-time known structure layout details. It operates in two
modes: outer bounds (0) and inner bounds (1). In mode 0, the size of the
enclosing structure is used. In mode 1, the size of the specific field
is used. For example:

	struct object {
		u16 scalar1;	/* 2 bytes */
		char array[6];	/* 6 bytes */
		u64 scalar2;	/* 8 bytes */
		u32 scalar3;	/* 4 bytes */
		u32 scalar4;	/* 4 bytes */
	} instance;

__builtin_object_size(instance.array, 0) == 22, since the remaining size
of the enclosing structure starting from "array" is 22 bytes (6 + 8 +
4 + 4).

__builtin_object_size(instance.array, 1) == 6, since the remaining size
of the specific field "array" is 6 bytes.

The initial implementation of FORTIFY_SOURCE used mode 0 because there
were many cases of both strcpy() and memcpy() functions being used to
write (or read) across multiple fields in a structure. For example,
it would catch this, which is writing 2 bytes beyond the end of
"instance":

	memcpy(&instance.array, data, 24);

While this didn't protect against overwriting adjacent fields in a given
structure, it would at least stop overflows from reaching beyond the
end of the structure into neighboring memory, and provided a meaningful
mitigation of a subset of buffer overflow flaws. However, many desirable
targets remain within the enclosing structure (for example function
pointers).

As it happened, there were very few cases of strcpy() family functions
intentionally writing beyond the end of a string buffer. Once all known
cases were removed from the kernel, the strcpy() family was tightened[1]
to use mode 1, providing greater mitigation coverage.

What remains is switching memcpy() to mode 1 as well, but making the
switch is much more difficult because of how frustrating it can be to
find existing "normal" uses of memcpy() that expect to write (or read)
across multiple fields. The root cause of the problem is that the C
language lacks a common pattern to indicate the intent of an author's
use of memcpy(), and is further complicated by the available compile-time
and run-time mitigation behaviors.

The FORTIFY_SOURCE mitigation comes in two halves: the compile-time half,
when both the buffer size _and_ the length of the copy is known, and the
run-time half, when only the buffer size is known. If neither size is
known, there is no bounds checking possible. At compile-time when the
compiler sees that a length will always exceed a known buffer size,
a warning can be deterministically emitted. For the run-time half,
the length is tested against the known size of the buffer, and the
overflowing operation is detected. (The performance overhead for these
tests is virtually zero.)

It is relatively easy to find compile-time false-positives since a warning
is always generated. Fixing the false positives, however, can be very
time-consuming as there are hundreds of instances. While it's possible
some over-read conditions could lead to kernel memory exposures, the bulk
of the risk comes from the run-time flaws where the length of a write
may end up being attacker-controlled and lead to an overflow.

Many of the compile-time false-positives take a form similar to this:

	memcpy(&instance.scalar2, data, sizeof(instance.scalar2) +
					sizeof(instance.scalar3));

and the run-time ones are similar, but lack a constant expression for the
size of the copy:

	memcpy(instance.array, data, length);

The former is meant to cover multiple fields (though its style has been
frowned upon more recently), but has been technically legal. Both lack
any expressivity in the C language about the author's _intent_ in a way
that a compiler can check when the length isn't known at compile time.
A comment doesn't work well because what's needed is something a compiler
can directly reason about. Is a given memcpy() call expected to overflow
into neighbors? Is it not? By using the new struct_group() macro, this
intent can be much more easily encoded.

It is not as easy to find the run-time false-positives since the code path
to exercise a seemingly out-of-bounds condition that is actually expected
may not be trivially reachable. Tightening the restrictions to block an
operation for a false positive will either potentially create a greater
flaw (if a copy is truncated by the mitigation), or destabilize the kernel
(e.g. with a BUG()), making things completely useless for the end user.

As a result, tightening the memcpy() restriction (when there is a
reasonable level of uncertainty of the number of false positives), needs
to first WARN() with no truncation. (Though any sufficiently paranoid
end-user can always opt to set the panic_on_warn=1 sysctl.) Once enough
development time has passed, the mitigation can be further intensified.

Given the potential frustrations of weeding out all the false positives
when tightening the run-time checks, it is reasonable to wonder if these
changes would actually add meaningful protection. Looking at just the
last three years, there are 23 identified flaws with a CVE that mention
"buffer overflow", and 11 are memcpy()-related buffer overflows.

(For the remaining 12: 7 are array index overflows that would be
mitigated by systems built with CONFIG_UBSAN_BOUNDS=y: CVE-2019-0145,
CVE-2019-14835, CVE-2019-14896, CVE-2019-14897, CVE-2019-14901,
CVE-2019-17666, CVE-2021-28952. 2 are miscalculated allocation
sizes which could be mitigated with memory tagging: CVE-2019-16746,
CVE-2019-2181. 1 is an iovec buffer bug maybe mitigated by memory tagging:
CVE-2020-10742. 1 is a type confusion bug mitigated by stack canaries:
CVE-2020-10942. 1 is a string handling logic bug with no mitigation I'm
aware of: CVE-2021-28972.)

At my last count on an x86_64 allmodconfig build, there are 25,018 calls
to memcpy(). With callers instrumented to report all places where the
buffer size is known but the length remains unknown (i.e. a run-time
bounds check is added), we can count how many new run-time bounds checks
are added when the destination and source arguments of memcpy() are
changed to use "mode 1" bounds checking: 1540. In addition, there were
146 new compile-time warnings to evaluate and fix.

With this it's also possible to compare the places where the known 11
memcpy() flaw overflows happened against the resulting list of potential
new bounds checks, as a measure of potential efficacy of the tightened
mitigation. Much to my surprise, horror, and delight, all 11 flaws would
have been detected by the newly added run-time bounds checks, making this
a distinctly clear mitigation improvement: 100% coverage for memcpy()
flaws, with a possible 2 orders of magnitude gain in coverage over
existing but undiscovered run-time dynamic length flaws, against only 6%
of all callers maybe gaining a false positive run-time check, with fewer
than 150 new compile-time instances needing evaluation.

Specifically these would have been mitigated:
CVE-2020-24490 https://git.kernel.org/linus/a2ec905d1e160a33b2e210e45ad30445ef26ce0e
CVE-2020-12654 https://git.kernel.org/linus/3a9b153c5591548612c3955c9600a98150c81875
CVE-2020-12653 https://git.kernel.org/linus/b70261a288ea4d2f4ac7cd04be08a9f0f2de4f4d
CVE-2019-14895 https://git.kernel.org/linus/3d94a4a8373bf5f45cf5f939e88b8354dbf2311b
CVE-2019-14816 https://git.kernel.org/linus/7caac62ed598a196d6ddf8d9c121e12e082cac3a
CVE-2019-14815 https://git.kernel.org/linus/7caac62ed598a196d6ddf8d9c121e12e082cac3a
CVE-2019-14814 https://git.kernel.org/linus/7caac62ed598a196d6ddf8d9c121e12e082cac3a
CVE-2019-10126 https://git.kernel.org/linus/69ae4f6aac1578575126319d3f55550e7e440449
CVE-2019-9500  https://git.kernel.org/linus/1b5e2423164b3670e8bc9174e4762d297990deff
no-CVE-yet     https://git.kernel.org/linus/130f634da1af649205f4a3dd86cbe5c126b57914
no-CVE-yet     https://git.kernel.org/linus/d10a87a3535cce2b890897914f5d0d83df669c63

To accelerate the review of potential run-time false positives, it's
also worth noting that it is possible to partially automate checking
by examining the memcpy() buffer argument to check for the destination
struct member having a neighboring array member. It is reasonable to
expect that the vast majority of run-time false positives would look like
the already evaluated and fixed compile-time false positives, where the
most common pattern is neighboring arrays. (And, FWIW, several of the
compile-time fixes were actual bugs.)

Implementation:

Tighten the memcpy() destination buffer size checking to use the actual
("mode 1") target buffer size as the bounds check instead of their
enclosing structure's ("mode 0") size. Use a common inline for memcpy()
(and memmove() in a following patch), since all the tests are the
same. All new cross-field memcpy() uses must use the struct_group() macro
or similar to target a specific range of fields, so that FORTIFY_SOURCE
can reason about the size and safety of the copy.

For now, cross-member "mode 1" read detection at compile-time will be
limited to W=1 builds, since it is, unfortunately, very common. As the
priority is solving write overflows, read overflows can be part of the
next phase.

For run-time, the "mode 0" size checking and mitigation is left unchanged,
with "mode 1" to be added in stages. In this patch, no new run-time
checks are added. Future patches will first bounds-check writes,
and only perform a WARN() for now. This way any missed run-time false
positives can be flushed out over the coming several development cycles,
but system builders who have tested their workloads to be WARN()-free
can enable the panic_on_warn=1 sysctl to immediately gain a mitigation
against this class of buffer overflows. Once that is under way, run-time
bounds-checking of reads can be similarly added.

Related classes of flaws that remain unmitigated:

- memcpy() with raw pointers (e.g. void *, char *, etc) have no good
  mitigation beyond memory tagging (and even that would only protect
  against inter-object overflow, not intra-object neighboring field
  overflows). Some kind of "fat pointer" solution is likely needed to
  gain proper size-of-buffer awareness.

- type confusion where a higher level type's allocation size does
  not match the resulting cast type eventually passed to a deeper
  memcpy() call where the compiler cannot see the true type. In
  theory, greater static analysis could catch these.

[0] https://gcc.gnu.org/onlinedocs/gcc/Object-Size-Checking.html
[1] https://git.kernel.org/linus/6a39e62abbafd1d58d1722f40c7d26ef379c6a2f

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h                | 109 ++++++++++++++++--
 lib/Makefile                                  |   3 +-
 lib/string_helpers.c                          |   6 +
 .../read_overflow2_field-memcpy.c             |   5 +
 .../write_overflow_field-memcpy.c             |   5 +
 5 files changed, 115 insertions(+), 13 deletions(-)
 create mode 100644 lib/test_fortify/read_overflow2_field-memcpy.c
 create mode 100644 lib/test_fortify/write_overflow_field-memcpy.c

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index a6cd6815f249..132efa1ff49f 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -8,7 +8,9 @@
 void fortify_panic(const char *name) __noreturn __cold;
 void __read_overflow(void) __compiletime_error("detected read beyond size of object (1st parameter)");
 void __read_overflow2(void) __compiletime_error("detected read beyond size of object (2nd parameter)");
+void __read_overflow2_field(size_t avail, size_t wanted) __compiletime_warning("detected read beyond size of field (2nd parameter); maybe use struct_group()?");
 void __write_overflow(void) __compiletime_error("detected write beyond size of object (1st parameter)");
+void __write_overflow_field(size_t avail, size_t wanted) __compiletime_warning("detected write beyond size of field (1st parameter); maybe use struct_group()?");
 
 #define __compiletime_strlen(p)					\
 ({								\
@@ -209,22 +211,105 @@ __FORTIFY_INLINE void *memset(void *p, int c, __kernel_size_t size)
 	return __underlying_memset(p, c, size);
 }
 
-__FORTIFY_INLINE void *memcpy(void *p, const void *q, __kernel_size_t size)
+/*
+ * To make sure the compiler can enforce protection against buffer overflows,
+ * memcpy(), memmove(), and memset() must not be used beyond individual
+ * struct members. If you need to copy across multiple members, please use
+ * struct_group() to create a named mirror of an anonymous struct union.
+ * (e.g. see struct sk_buff.)
+ *
+ * Mitigation coverage
+ *					Bounds checking at:
+ *					+-------+-------+-------+-------+
+ *					| Compile time  | Run time      |
+ * memcpy() argument sizes:		| write | read  | write | read  |
+ *					+-------+-------+-------+-------+
+ * memcpy(known,   known,   constant)	|   y   |   y   |  n/a  |  n/a  |
+ * memcpy(unknown, known,   constant)	|   n   |   y   |   V   |  n/a  |
+ * memcpy(known,   unknown, constant)	|   y   |   n   |  n/a  |   V   |
+ * memcpy(unknown, unknown, constant)	|   n   |   n   |   V   |   V   |
+ * memcpy(known,   known,   dynamic)	|   n   |   n   |   b   |   B   |
+ * memcpy(unknown, known,   dynamic)	|   n   |   n   |   V   |   B   |
+ * memcpy(known,   unknown, dynamic)	|   n   |   n   |   b   |   V   |
+ * memcpy(unknown, unknown, dynamic)	|   n   |   n   |   V   |   V   |
+ *					+-------+-------+-------+-------+
+ *
+ * y = deterministic compile-time bounds checking
+ * n = cannot do deterministic compile-time bounds checking
+ * n/a = no run-time bounds checking needed since compile-time deterministic
+ * b = perform run-time bounds checking
+ * B = can perform run-time bounds checking, but current unenforced
+ * V = vulnerable to run-time overflow
+ *
+ */
+__FORTIFY_INLINE void fortify_memcpy_chk(__kernel_size_t size,
+					 const size_t p_size,
+					 const size_t q_size,
+					 const size_t p_size_field,
+					 const size_t q_size_field,
+					 const char *func)
 {
-	size_t p_size = __builtin_object_size(p, 0);
-	size_t q_size = __builtin_object_size(q, 0);
-
 	if (__builtin_constant_p(size)) {
-		if (p_size < size)
+		/*
+		 * Length argument is a constant expression, so we
+		 * can perform compile-time bounds checking where
+		 * buffer sizes are known.
+		 */
+
+		/* Error when size is larger than enclosing struct. */
+		if (p_size > p_size_field && p_size < size)
 			__write_overflow();
-		if (q_size < size)
+		if (q_size > q_size_field && q_size < size)
 			__read_overflow2();
+
+		/* Warn when write size argument larger than dest field. */
+		if (p_size_field < size)
+			__write_overflow_field(p_size_field, size);
+		/*
+		 * Warn for source field over-read when building with W=1
+		 * or when an over-write happened, so both can be fixed at
+		 * the same time.
+		 */
+		if ((IS_ENABLED(KBUILD_EXTRA_WARN1) || p_size_field < size) &&
+		    q_size_field < size)
+			__read_overflow2_field(q_size_field, size);
 	}
-	if (p_size < size || q_size < size)
-		fortify_panic(__func__);
-	return __underlying_memcpy(p, q, size);
+	/*
+	 * At this point, length argument may not be a constant expression,
+	 * so run-time bounds checking can be done where buffer sizes are
+	 * known. (This is not an "else" because the above checks may only
+	 * be compile-time warnings, and we want to still warn for run-time
+	 * overflows.)
+	 */
+
+	/*
+	 * Always stop accesses beyond the struct that contains the
+	 * field, when the buffer's remaining size is known.
+	 * (The -1 test is to optimize away checks where the buffer
+	 * lengths are unknown.)
+	 */
+	if ((p_size != (size_t)(-1) && p_size < size) ||
+	    (q_size != (size_t)(-1) && q_size < size))
+		fortify_panic(func);
 }
 
+#define __fortify_memcpy_chk(p, q, size, p_size, q_size,		\
+			     p_size_field, q_size_field, op) ({		\
+	size_t __fortify_size = (size_t)(size);				\
+	fortify_memcpy_chk(__fortify_size, p_size, q_size,		\
+			   p_size_field, q_size_field, #op);		\
+	__underlying_##op(p, q, __fortify_size);			\
+})
+
+/*
+ * __builtin_object_size() must be captured here to avoid evaluating argument
+ * side-effects further into the macro layers.
+ */
+#define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,			\
+		__builtin_object_size(p, 0), __builtin_object_size(q, 0), \
+		__builtin_object_size(p, 1), __builtin_object_size(q, 1), \
+		memcpy)
+
 __FORTIFY_INLINE void *memmove(void *p, const void *q, __kernel_size_t size)
 {
 	size_t p_size = __builtin_object_size(p, 0);
@@ -304,13 +389,14 @@ __FORTIFY_INLINE void *kmemdup(const void *p, size_t size, gfp_t gfp)
 	return __real_kmemdup(p, size, gfp);
 }
 
-/* defined after fortified strlen and memcpy to reuse them */
+/* Defined after fortified strlen to reuse it. */
 __FORTIFY_INLINE char *strcpy(char *p, const char *q)
 {
 	size_t p_size = __builtin_object_size(p, 1);
 	size_t q_size = __builtin_object_size(q, 1);
 	size_t size;
 
+	/* If neither buffer size is known, immediately give up. */
 	if (p_size == (size_t)-1 && q_size == (size_t)-1)
 		return __underlying_strcpy(p, q);
 	size = strlen(q) + 1;
@@ -320,14 +406,13 @@ __FORTIFY_INLINE char *strcpy(char *p, const char *q)
 	/* Run-time check for dynamic size overflow. */
 	if (p_size < size)
 		fortify_panic(__func__);
-	memcpy(p, q, size);
+	__underlying_memcpy(p, q, size);
 	return p;
 }
 
 /* Don't use these outside the FORITFY_SOURCE implementation */
 #undef __underlying_memchr
 #undef __underlying_memcmp
-#undef __underlying_memcpy
 #undef __underlying_memmove
 #undef __underlying_memset
 #undef __underlying_strcat
diff --git a/lib/Makefile b/lib/Makefile
index b213a7bbf3fd..7ea43029431b 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -373,7 +373,8 @@ TEST_FORTIFY_LOG = test_fortify.log
 quiet_cmd_test_fortify = TEST    $@
       cmd_test_fortify = $(CONFIG_SHELL) $(srctree)/scripts/test_fortify.sh \
 			$< $@ "$(NM)" $(CC) $(c_flags) \
-			$(call cc-disable-warning,fortify-source)
+			$(call cc-disable-warning,fortify-source) \
+			-DKBUILD_EXTRA_WARN1
 
 targets += $(TEST_FORTIFY_LOGS)
 clean-files += $(TEST_FORTIFY_LOGS)
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 90f9f1b7afec..4f877e9551d5 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -968,6 +968,12 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
 EXPORT_SYMBOL(memcpy_and_pad);
 
 #ifdef CONFIG_FORTIFY_SOURCE
+/* These are placeholders for fortify compile-time warnings. */
+void __read_overflow2_field(size_t avail, size_t wanted) { }
+EXPORT_SYMBOL(__read_overflow2_field);
+void __write_overflow_field(size_t avail, size_t wanted) { }
+EXPORT_SYMBOL(__write_overflow_field);
+
 void fortify_panic(const char *name)
 {
 	pr_emerg("detected buffer overflow in %s\n", name);
diff --git a/lib/test_fortify/read_overflow2_field-memcpy.c b/lib/test_fortify/read_overflow2_field-memcpy.c
new file mode 100644
index 000000000000..de9569266223
--- /dev/null
+++ b/lib/test_fortify/read_overflow2_field-memcpy.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define TEST	\
+	memcpy(large, instance.buf, sizeof(instance.buf) + 1)
+
+#include "test_fortify.h"
diff --git a/lib/test_fortify/write_overflow_field-memcpy.c b/lib/test_fortify/write_overflow_field-memcpy.c
new file mode 100644
index 000000000000..28cc81058dd3
--- /dev/null
+++ b/lib/test_fortify/write_overflow_field-memcpy.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define TEST	\
+	memcpy(instance.buf, large, sizeof(instance.buf) + 1)
+
+#include "test_fortify.h"
-- 
2.30.2

