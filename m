Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871D552ADFE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiEQWVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiEQWV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:21:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E2128E38;
        Tue, 17 May 2022 15:21:25 -0700 (PDT)
Date:   Tue, 17 May 2022 22:21:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652826083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p40IlWUsYe19ibepCHY2XKMhknMLi/undpqdrFUrafY=;
        b=SK5fCQgoYjRW5Xr7Hcx/y7EcTeqDv4zdZAPrcpl4HORjS+8kQLA+HW14mxVziBgYkfwDjJ
        7tJy3C7EaYNucuNxWYMhe0kk5knvZ5DIORCbjW3wkT5HGG4xUFX9Q5V7YlkAosYqz9+NjZ
        keDVADO8knesH1FzNI8Q3AMCuizaPanWVe6JLdXEvGqWKUgVXV0WfJOO923rd2IDKZZsje
        aAZ3uc7VpRWWux6DCJWt2vKve9Uu/CBCuqUnsWs9l7Xc9kBGxBKBmGQ8tqEVpyyczl9Acs
        xIOqc8bMPXkSppG/yjw3taRLP4bW/1AMMSx/HuSvJfo9jYj74xHhTsRHvJMclw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652826083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p40IlWUsYe19ibepCHY2XKMhknMLi/undpqdrFUrafY=;
        b=1FVoc6XL8b7GZF0og5kqFgktFH3XRWeZQZ7tABogCZiFw44jYa+J74r5G+5EP2+Pg5YMPE
        V/JYfiGPsAOwr3Bg==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: Add generic try_cmpxchg64 support
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220515184205.103089-2-ubizjak@gmail.com>
References: <20220515184205.103089-2-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <165282608247.4207.13301051850549186943.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0aa7be05d83cc584da0782405e8007e351dfb6cc
Gitweb:        https://git.kernel.org/tip/0aa7be05d83cc584da0782405e8007e351dfb6cc
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Sun, 15 May 2022 20:42:03 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 18 May 2022 00:08:27 +02:00

locking/atomic: Add generic try_cmpxchg64 support

Add generic support for try_cmpxchg64{,_acquire,_release,_relaxed}
and their falbacks involving cmpxchg64.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220515184205.103089-2-ubizjak@gmail.com
---
 include/linux/atomic/atomic-arch-fallback.h | 72 +++++++++++++++++++-
 include/linux/atomic/atomic-instrumented.h  | 40 ++++++++++-
 scripts/atomic/gen-atomic-fallback.sh       | 31 +++++----
 scripts/atomic/gen-atomic-instrumented.sh   |  2 +-
 4 files changed, 129 insertions(+), 16 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 6db58d1..77bc552 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -147,6 +147,76 @@
 
 #endif /* arch_try_cmpxchg_relaxed */
 
+#ifndef arch_try_cmpxchg64_relaxed
+#ifdef arch_try_cmpxchg64
+#define arch_try_cmpxchg64_acquire arch_try_cmpxchg64
+#define arch_try_cmpxchg64_release arch_try_cmpxchg64
+#define arch_try_cmpxchg64_relaxed arch_try_cmpxchg64
+#endif /* arch_try_cmpxchg64 */
+
+#ifndef arch_try_cmpxchg64
+#define arch_try_cmpxchg64(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg64((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg64 */
+
+#ifndef arch_try_cmpxchg64_acquire
+#define arch_try_cmpxchg64_acquire(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg64_acquire((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg64_acquire */
+
+#ifndef arch_try_cmpxchg64_release
+#define arch_try_cmpxchg64_release(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg64_release((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg64_release */
+
+#ifndef arch_try_cmpxchg64_relaxed
+#define arch_try_cmpxchg64_relaxed(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg64_relaxed((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg64_relaxed */
+
+#else /* arch_try_cmpxchg64_relaxed */
+
+#ifndef arch_try_cmpxchg64_acquire
+#define arch_try_cmpxchg64_acquire(...) \
+	__atomic_op_acquire(arch_try_cmpxchg64, __VA_ARGS__)
+#endif
+
+#ifndef arch_try_cmpxchg64_release
+#define arch_try_cmpxchg64_release(...) \
+	__atomic_op_release(arch_try_cmpxchg64, __VA_ARGS__)
+#endif
+
+#ifndef arch_try_cmpxchg64
+#define arch_try_cmpxchg64(...) \
+	__atomic_op_fence(arch_try_cmpxchg64, __VA_ARGS__)
+#endif
+
+#endif /* arch_try_cmpxchg64_relaxed */
+
 #ifndef arch_atomic_read_acquire
 static __always_inline int
 arch_atomic_read_acquire(const atomic_t *v)
@@ -2386,4 +2456,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 8e2cc06bc0d2c0967d2f8424762bd48555ee40ae
+// b5e87bdd5ede61470c29f7a7e4de781af3770f09
diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
index 5d69b14..7a139ec 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -2006,6 +2006,44 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	arch_try_cmpxchg_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
+#define try_cmpxchg64(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	kcsan_mb(); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg64(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+
+#define try_cmpxchg64_acquire(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg64_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+
+#define try_cmpxchg64_release(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	kcsan_release(); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg64_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+
+#define try_cmpxchg64_relaxed(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg64_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+
 #define cmpxchg_local(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -2045,4 +2083,4 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 })
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// 87c974b93032afd42143613434d1a7788fa598f9
+// 764f741eb77a7ad565dc8d99ce2837d5542e8aee
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 8e2da71..3a07695 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -164,41 +164,44 @@ gen_xchg_fallbacks()
 
 gen_try_cmpxchg_fallback()
 {
+	local cmpxchg="$1"; shift;
 	local order="$1"; shift;
 
 cat <<EOF
-#ifndef arch_try_cmpxchg${order}
-#define arch_try_cmpxchg${order}(_ptr, _oldp, _new) \\
+#ifndef arch_try_${cmpxchg}${order}
+#define arch_try_${cmpxchg}${order}(_ptr, _oldp, _new) \\
 ({ \\
 	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \\
-	___r = arch_cmpxchg${order}((_ptr), ___o, (_new)); \\
+	___r = arch_${cmpxchg}${order}((_ptr), ___o, (_new)); \\
 	if (unlikely(___r != ___o)) \\
 		*___op = ___r; \\
 	likely(___r == ___o); \\
 })
-#endif /* arch_try_cmpxchg${order} */
+#endif /* arch_try_${cmpxchg}${order} */
 
 EOF
 }
 
 gen_try_cmpxchg_fallbacks()
 {
-	printf "#ifndef arch_try_cmpxchg_relaxed\n"
-	printf "#ifdef arch_try_cmpxchg\n"
+	local cmpxchg="$1"; shift;
 
-	gen_basic_fallbacks "arch_try_cmpxchg"
+	printf "#ifndef arch_try_${cmpxchg}_relaxed\n"
+	printf "#ifdef arch_try_${cmpxchg}\n"
 
-	printf "#endif /* arch_try_cmpxchg */\n\n"
+	gen_basic_fallbacks "arch_try_${cmpxchg}"
+
+	printf "#endif /* arch_try_${cmpxchg} */\n\n"
 
 	for order in "" "_acquire" "_release" "_relaxed"; do
-		gen_try_cmpxchg_fallback "${order}"
+		gen_try_cmpxchg_fallback "${cmpxchg}" "${order}"
 	done
 
-	printf "#else /* arch_try_cmpxchg_relaxed */\n"
+	printf "#else /* arch_try_${cmpxchg}_relaxed */\n"
 
-	gen_order_fallbacks "arch_try_cmpxchg"
+	gen_order_fallbacks "arch_try_${cmpxchg}"
 
-	printf "#endif /* arch_try_cmpxchg_relaxed */\n\n"
+	printf "#endif /* arch_try_${cmpxchg}_relaxed */\n\n"
 }
 
 cat << EOF
@@ -218,7 +221,9 @@ for xchg in "arch_xchg" "arch_cmpxchg" "arch_cmpxchg64"; do
 	gen_xchg_fallbacks "${xchg}"
 done
 
-gen_try_cmpxchg_fallbacks
+for cmpxchg in "cmpxchg" "cmpxchg64"; do
+	gen_try_cmpxchg_fallbacks "${cmpxchg}"
+done
 
 grep '^[a-z]' "$1" | while read name meta args; do
 	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index 68f9027..77c0652 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -166,7 +166,7 @@ grep '^[a-z]' "$1" | while read name meta args; do
 done
 
 
-for xchg in "xchg" "cmpxchg" "cmpxchg64" "try_cmpxchg"; do
+for xchg in "xchg" "cmpxchg" "cmpxchg64" "try_cmpxchg" "try_cmpxchg64"; do
 	for order in "" "_acquire" "_release" "_relaxed"; do
 		gen_xchg "${xchg}" "${order}" ""
 		printf "\n"
