Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BD74705A4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243243AbhLJQbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238946AbhLJQaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:30:55 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EC2C0617A2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ZY5zG/pWLUQcrv7ffZuMeljdeGYbmgoSR8jdzkhGEEk=; b=qq9JAtUeQiaC+EY3DzQebNqt4N
        3UGVmDYeoeHxMHu15zInYOaqZLr7JwUP8Hx4gJotJJCgUtJB4fu3nStpxrw/oqc4OmPbTLod15mNd
        rxnAv2hRiZn3c8wxB3qAh116JEnLoH9mtlYOaQb9FkSWZ57E6qXiMYAD14E/dT3hZ/9DSgQg/+Fy9
        Pzuk6MKX59AzEFKKI+AYPkcI2mSD/pVAxajSArLTSe51OyfZv0reIaMQW4IR3C6yV+qUPLmzjeV3T
        i9FzJiISVsA3tZOFMdwwW24orbT2xV4Lil7YddrsVa/BecC/kuSkZoTvYbirHqfMXtxJ6v41H8Thx
        zVa6H2KA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvijm-000aWX-CT; Fri, 10 Dec 2021 16:27:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81C3B3002C5;
        Fri, 10 Dec 2021 17:27:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5D27B2B3C36BB; Fri, 10 Dec 2021 17:27:09 +0100 (CET)
Message-ID: <20211210162313.308243536@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 10 Dec 2021 17:16:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, elver@google.com, keescook@chromium.org,
        hch@infradead.org, torvalds@linux-foundation.org, axboe@kernel.dk
Subject: [PATCH v2 1/9] atomic: Prepare scripts for macro ops
References: <20211210161618.645249719@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the limited usability of the GCC 'Labels as Values' extention,
specifically it refuses to have a goto in an __always_inline function,
even with a compile time constant label pointer, some new atomic ops
will need to be introduced as macros.

The xchg/cmpxchg family is already macros so extend that code to the
regular atomic ops.

Specifically introduce meta-'M', meta-'m' and meta-'n' to signify the
op is a macro and add arg-'L', arg-'V' and arg-'P' for Label, VarArg
and Pair arguments respectively.

This unconvered some latent bugs in the instrumentation wrappery,
specifically the try_cmpxchg() @oldp argument was instrumented as an
atomic_read_write, while it's a regular read_write and many of the
gen_xchg() ops had atomic_write instrumentation while
atomic_read_write seems more appropriate.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/atomic/atomic-instrumented.h |   78 +++++++--------
 scripts/atomic/atomic-tbl.sh               |    8 +
 scripts/atomic/atomics.tbl                 |    5 +
 scripts/atomic/gen-atomic-fallback.sh      |    4 
 scripts/atomic/gen-atomic-instrumented.sh  |  142 +++++++++++++++++++----------
 scripts/atomic/gen-atomic-long.sh          |   32 +++++-
 6 files changed, 177 insertions(+), 92 deletions(-)

--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -501,7 +501,7 @@ static __always_inline bool
 atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg(v, old, new);
 }
 
@@ -509,7 +509,7 @@ static __always_inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_acquire(v, old, new);
 }
 
@@ -517,7 +517,7 @@ static __always_inline bool
 atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_release(v, old, new);
 }
 
@@ -525,7 +525,7 @@ static __always_inline bool
 atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
 }
 
@@ -1079,7 +1079,7 @@ static __always_inline bool
 atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg(v, old, new);
 }
 
@@ -1087,7 +1087,7 @@ static __always_inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_acquire(v, old, new);
 }
 
@@ -1095,7 +1095,7 @@ static __always_inline bool
 atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_release(v, old, new);
 }
 
@@ -1103,7 +1103,7 @@ static __always_inline bool
 atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
 }
 
@@ -1657,7 +1657,7 @@ static __always_inline bool
 atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic_long_try_cmpxchg(v, old, new);
 }
 
@@ -1665,7 +1665,7 @@ static __always_inline bool
 atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic_long_try_cmpxchg_acquire(v, old, new);
 }
 
@@ -1673,7 +1673,7 @@ static __always_inline bool
 atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic_long_try_cmpxchg_release(v, old, new);
 }
 
@@ -1681,7 +1681,7 @@ static __always_inline bool
 atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return arch_atomic_long_try_cmpxchg_relaxed(v, old, new);
 }
 
@@ -1758,84 +1758,84 @@ atomic_long_dec_if_positive(atomic_long_
 #define xchg(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_xchg(__ai_ptr, __VA_ARGS__); \
 })
 
 #define xchg_acquire(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_xchg_acquire(__ai_ptr, __VA_ARGS__); \
 })
 
 #define xchg_release(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_xchg_release(__ai_ptr, __VA_ARGS__); \
 })
 
 #define xchg_relaxed(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg_acquire(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg_release(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg_relaxed(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg64(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg64_acquire(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64_acquire(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg64_release(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64_release(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg64_relaxed(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
 })
 
@@ -1843,8 +1843,8 @@ atomic_long_dec_if_positive(atomic_long_
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
@@ -1852,8 +1852,8 @@ atomic_long_dec_if_positive(atomic_long_
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
@@ -1861,8 +1861,8 @@ atomic_long_dec_if_positive(atomic_long_
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
@@ -1870,46 +1870,46 @@ atomic_long_dec_if_positive(atomic_long_
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
 #define cmpxchg_local(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg64_local(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__); \
 })
 
 #define sync_cmpxchg(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__); \
 })
 
 #define cmpxchg_double(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
 	arch_cmpxchg_double(__ai_ptr, __VA_ARGS__); \
 })
 
-
 #define cmpxchg_double_local(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
+	instrument_atomic_read_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
 	arch_cmpxchg_double_local(__ai_ptr, __VA_ARGS__); \
 })
 
+
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// 2a9553f0a9d5619f19151092df5cabbbf16ce835
+// 66cdf9a0e0a995cba29c61baf018f7ef35974ae5
--- a/scripts/atomic/atomic-tbl.sh
+++ b/scripts/atomic/atomic-tbl.sh
@@ -15,7 +15,7 @@ meta_in()
 #meta_has_ret(meta)
 meta_has_ret()
 {
-	meta_in "$1" "bBiIfFlR"
+	meta_in "$1" "bBiIfFlRm"
 }
 
 #meta_has_acquire(meta)
@@ -36,6 +36,12 @@ meta_has_relaxed()
 	meta_in "$1" "BFIR"
 }
 
+#meta_has_macro(meta)
+meta_has_macro()
+{
+	meta_in "$1" "mn"
+}
+
 #find_fallback_template(pfx, name, sfx, order)
 find_fallback_template()
 {
--- a/scripts/atomic/atomics.tbl
+++ b/scripts/atomic/atomics.tbl
@@ -10,12 +10,17 @@
 # * F/f	- fetch: returns base type (has fetch_ variants)
 # * l	- load: returns base type (has _acquire order variant)
 # * s	- store: returns void (has _release order variant)
+# * m	- macro: with return value
+# * n	- macro: with No return value
 #
 # Where args contains list of type[:name], where type is:
 # * cv	- const pointer to atomic base type (atomic_t/atomic64_t/atomic_long_t)
 # * v	- pointer to atomic base type (atomic_t/atomic64_t/atomic_long_t)
+# * P	- pointer to pair of atomic base type
 # * i	- base type (int/s64/long)
 # * p	- pointer to base type (int/s64/long)
+# * L	- label for exception case
+# * V:... - vararg
 #
 read			l	cv
 set			s	v	i
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -27,7 +27,9 @@ gen_template_fallback()
 	if [ ! -z "${template}" ]; then
 		printf "#ifndef ${atomicname}\n"
 		. ${template}
-		printf "#define ${atomicname} ${atomicname}\n"
+		if ! meta_has_macro "${meta}"; then
+			printf "#define ${atomicname} ${atomicname}\n"
+		fi
 		printf "#endif\n\n"
 	fi
 }
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -13,9 +13,15 @@ gen_param_check()
 	local type="${arg%%:*}"
 	local name="$(gen_param_name "${arg}")"
 	local rw="write"
+	local pfx;
+	local mult;
 
 	case "${type#c}" in
+	v) pfx="atomic_";;
+	P) pfx="atomic_"; mult="2 * ";;
 	i) return;;
+	L) return;;
+	V) return;;
 	esac
 
 	if [ ${type#c} != ${type} ]; then
@@ -27,7 +33,16 @@ gen_param_check()
 		rw="read_write"
 	fi
 
-	printf "\tinstrument_atomic_${rw}(${name}, sizeof(*${name}));\n"
+	if meta_has_macro "${meta}"; then
+		name="__ai_${name}"
+	fi
+
+	printf "\tinstrument_${pfx}${rw}(${name}, ${mult}sizeof(*${name}));"
+	if meta_has_macro "${meta}"; then
+		printf " \\"
+	fi
+	printf "\n"
+
 }
 
 #gen_params_checks(meta, arg...)
@@ -41,6 +56,52 @@ gen_params_checks()
 	done
 }
 
+#gen_var(arg)
+gen_var()
+{
+	local type="${1%%:*}"
+	local name="$(gen_param_name "$1")"
+
+	case "${type#c}" in
+	L) return;;
+	V) return;;
+	esac
+
+	printf "\ttypeof(${name}) __ai_${name} = (${name}); \\\\\n";
+}
+
+#gen_vars(arg...)
+gen_vars()
+{
+	while [ "$#" -gt 0 ]; do
+		gen_var "$1"
+		shift
+	done
+}
+
+#gen_varg(arg)
+gen_varg()
+{
+	local type="${1%%:*}"
+	local name="$(gen_param_name "$1")"
+
+	case "${type#c}" in
+	L)	printf "${name}";;
+	V)	printf "__VA_ARGS__";;
+	*)	printf "__ai_${name}";;
+	esac
+}
+
+#gen_vargs(arg...)
+gen_vargs()
+{
+	while [ "$#" -gt 0 ]; do
+		printf "$(gen_varg "$1")"
+		[ "$#" -gt 1 ] && printf ", "
+		shift
+	done
+}
+
 #gen_proto_order_variant(meta, pfx, name, sfx, order, atomic, int, arg...)
 gen_proto_order_variant()
 {
@@ -51,57 +112,49 @@ gen_proto_order_variant()
 	local order="$1"; shift
 	local atomic="$1"; shift
 	local int="$1"; shift
+	local atomicname;
 
-	local atomicname="${atomic}_${pfx}${name}${sfx}${order}"
+	if [ -n "${atomic}" ]; then
+		atomicname="${atomic}_${pfx}${name}${sfx}${order}"
+	else
+		atomicname="${pfx}${name}${sfx}${order}"
+	fi
 
-	local ret="$(gen_ret_type "${meta}" "${int}")"
-	local params="$(gen_params "${int}" "${atomic}" "$@")"
 	local checks="$(gen_params_checks "${meta}" "$@")"
 	local args="$(gen_args "$@")"
-	local retstmt="$(gen_ret_stmt "${meta}")"
-
-cat <<EOF
-static __always_inline ${ret}
-${atomicname}(${params})
-{
-${checks}
-	${retstmt}arch_${atomicname}(${args});
-}
-EOF
 
-	printf "\n"
-}
-
-gen_xchg()
-{
-	local xchg="$1"; shift
-	local mult="$1"; shift
+	if meta_has_macro "${meta}"; then
 
-	if [ "${xchg%${xchg#try_cmpxchg}}" = "try_cmpxchg" ] ; then
+		local vars="$(gen_vars "$@")"
+		local vargs="$(gen_vargs "$@")"
 
 cat <<EOF
-#define ${xchg}(ptr, oldp, ...) \\
+#define ${atomicname}(${args}) \\
 ({ \\
-	typeof(ptr) __ai_ptr = (ptr); \\
-	typeof(oldp) __ai_oldp = (oldp); \\
-	instrument_atomic_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
-	instrument_atomic_write(__ai_oldp, ${mult}sizeof(*__ai_oldp)); \\
-	arch_${xchg}(__ai_ptr, __ai_oldp, __VA_ARGS__); \\
+${vars}
+${checks}
+	arch_${atomicname}(${vargs}); \\
 })
 EOF
 
 	else
 
+		local ret="$(gen_ret_type "${meta}" "${int}")"
+		local params="$(gen_params "${int}" "${atomic}" "$@")"
+		local retstmt="$(gen_ret_stmt "${meta}")"
+
 cat <<EOF
-#define ${xchg}(ptr, ...) \\
-({ \\
-	typeof(ptr) __ai_ptr = (ptr); \\
-	instrument_atomic_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
-	arch_${xchg}(__ai_ptr, __VA_ARGS__); \\
-})
+static __always_inline ${ret}
+${atomicname}(${params})
+{
+${checks}
+	${retstmt}arch_${atomicname}(${args});
+}
 EOF
 
 	fi
+
+	printf "\n"
 }
 
 cat << EOF
@@ -142,24 +195,23 @@ grep '^[a-z]' "$1" | while read name met
 	gen_proto "${meta}" "${name}" "atomic_long" "long" ${args}
 done
 
-
-for xchg in "xchg" "cmpxchg" "cmpxchg64" "try_cmpxchg"; do
+for xchg in "xchg" "cmpxchg" "cmpxchg64"; do
 	for order in "" "_acquire" "_release" "_relaxed"; do
-		gen_xchg "${xchg}${order}" ""
-		printf "\n"
+		gen_proto_order_variant "m" "" "${xchg}" "" "${order}" "" "" "v:ptr" "V:..."
 	done
 done
 
-for xchg in "cmpxchg_local" "cmpxchg64_local" "sync_cmpxchg"; do
-	gen_xchg "${xchg}" ""
-	printf "\n"
+for order in "" "_acquire" "_release" "_relaxed"; do
+	gen_proto_order_variant "m" "" "try_cmpxchg" "" "${order}" "" "" "v:ptr" "p:oldp" "V:..."
 done
 
-gen_xchg "cmpxchg_double" "2 * "
-
-printf "\n\n"
+for xchg in "cmpxchg_local" "cmpxchg64_local" "sync_cmpxchg"; do
+	gen_proto_order_variant "m" "" "${xchg}" "" "" "" "" "v:ptr" "V:..."
+done
 
-gen_xchg "cmpxchg_double_local" "2 * "
+for xchg in "cmpxchg_double" "cmpxchg_double_local"; do
+	gen_proto_order_variant "m" "" "${xchg}" "" "" "" "" "P:ptr" "V:..."
+done
 
 cat <<EOF
 
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -17,16 +17,21 @@ gen_cast()
 	printf "($(gen_param_type "${arg}" "${int}" "${atomic}"))"
 }
 
-#gen_args_cast(int, atomic, arg...)
+#gen_args_cast(meta, int, atomic, arg...)
 gen_args_cast()
 {
+	local meta=$1; shift
 	local int="$1"; shift
 	local atomic="$1"; shift
 
 	while [ "$#" -gt 0 ]; do
 		local cast="$(gen_cast "$1" "${int}" "${atomic}")"
 		local arg="$(gen_param_name "$1")"
-		printf "${cast}${arg}"
+		if meta_has_macro "${meta}" && [ "${1%%:*}" != "L" ]; then
+			printf "${cast}(${arg})"
+		else
+			printf "${cast}${arg}"
+		fi
 		[ "$#" -gt 1 ] && printf ", "
 		shift;
 	done
@@ -40,10 +45,24 @@ gen_proto_order_variant()
 	local atomic="$1"; shift
 	local int="$1"; shift
 
-	local ret="$(gen_ret_type "${meta}" "long")"
-	local params="$(gen_params "long" "atomic_long" "$@")"
-	local argscast="$(gen_args_cast "${int}" "${atomic}" "$@")"
-	local retstmt="$(gen_ret_stmt "${meta}")"
+	local argscast="$(gen_args_cast "${meta}" "${int}" "${atomic}" "$@")"
+
+	if meta_has_macro "${meta}"; then
+
+		local args="$(gen_args "$@")"
+
+cat <<EOF
+#define arch_atomic_long_${name}(${args}) \\
+({ \\
+	arch_${atomic}_${name}(${argscast}) \\
+})
+
+EOF
+	else
+
+		local ret="$(gen_ret_type "${meta}" "long")"
+		local params="$(gen_params "long" "atomic_long" "$@")"
+		local retstmt="$(gen_ret_stmt "${meta}")"
 
 cat <<EOF
 static __always_inline ${ret}
@@ -53,6 +72,7 @@ arch_atomic_long_${name}(${params})
 }
 
 EOF
+	fi
 }
 
 cat << EOF


