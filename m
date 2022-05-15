Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1192A527933
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 20:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbiEOSme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 14:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbiEOSma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 14:42:30 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E38CDE7
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 11:42:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l18so24846069ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 11:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KXuxsvvmzObesTCgGUdp3DjkR6F9yj2J25L79TJ+yVs=;
        b=Uj3BfnqK/PmvLMxm1jp32TG/3B40iMvsJHg7IfNSusjVrvdAp56m23eiIXkrAwCb4T
         iE+7bBSHW3vFA52sNt8UDCbohdsxkYhhKxHqUAyYCH2RSQQy+g81sH3WVeItnC0jy+43
         5D/B+p95bcX3nfnTftSTxVC8b0DDVTlYfOdXXFLlNXB1+EZxCsnw2oDebhL/UjbYbpPH
         V5lSRHcKLZ8Yc8mh7Djf9uxLaYLIoeTrna0QQCA2+/wHH0h6TsuLO+N+owZtIh8C28N4
         DUrD9wpSR4/SAAHNB1bSb2oHJg/bGME7xjcRmO223wZjaunRZE/dy2xw08N9Q4Xe3tPf
         svZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KXuxsvvmzObesTCgGUdp3DjkR6F9yj2J25L79TJ+yVs=;
        b=mUvlLXZiAiKZvl74WJtvba0e2BhrpOljMCjqunL4J8Htrb9qOCLBDvbRmYIPtugF3N
         e1iC9U8aUivEC5b+L3LLe5I9A2iebYiDIEV06E6fTPnY8671u1LUijXXmk0wUQbaWrd6
         k5EYGFUx6cQHj8C7LCiuyM6OH9+qtDqeNE1sWo1GAFp6KkhU1MzspIqRNn1Zqg+lvShr
         UFKcTk9syUIDSequfQ5z9P1fxHSmY6kozGf+DVmhfDB3yLFBzzg5JNSVu0UNlr0q1o4a
         czo9HHSDo98SSRBz3JizC+a6ufHcM4llABqFfsOJGdo6658HXJlPPJElTTz8RzedqpcG
         ZWNw==
X-Gm-Message-State: AOAM530+TLDr6GtYjuA9pBpvb3hMJ3Ye5+x5kPbeGtM8x1YutGjNgXgg
        80bfhEP7Bm/AixVrTUmoiVo=
X-Google-Smtp-Source: ABdhPJwmEoJLpzsl3G+0/bDswbbrNULzSz7kliPeluMB6W1M4y5SVrDdF4tYBj3xh+ENkY7qZ4/7eA==
X-Received: by 2002:a17:906:2989:b0:6f3:a215:8426 with SMTP id x9-20020a170906298900b006f3a2158426mr12613463eje.725.1652640147724;
        Sun, 15 May 2022 11:42:27 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id hv7-20020a17090760c700b006f3ef214e62sm2861898ejc.200.2022.05.15.11.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 11:42:27 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>
Subject: [PATCH v3 1/2] locking/atomic: Add generic try_cmpxchg64 support
Date:   Sun, 15 May 2022 20:42:03 +0200
Message-Id: <20220515184205.103089-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220515184205.103089-1-ubizjak@gmail.com>
References: <20220515184205.103089-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic support for try_cmpxchg64{,_acquire,_release,_relaxed}
and their falbacks involving cmpxchg64.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marco Elver <elver@google.com>
---
 include/linux/atomic/atomic-arch-fallback.h | 72 ++++++++++++++++++++-
 include/linux/atomic/atomic-instrumented.h  | 40 +++++++++++-
 scripts/atomic/gen-atomic-fallback.sh       | 31 +++++----
 scripts/atomic/gen-atomic-instrumented.sh   |  2 +-
 4 files changed, 129 insertions(+), 16 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 6db58d180866..77bc5522e61c 100644
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
index 5d69b143c28e..7a139ec030b0 100644
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
index 8e2da71f1d5f..3a07695e3c89 100755
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
index 68f902731d01..77c06526a574 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -166,7 +166,7 @@ grep '^[a-z]' "$1" | while read name meta args; do
 done
 
 
-for xchg in "xchg" "cmpxchg" "cmpxchg64" "try_cmpxchg"; do
+for xchg in "xchg" "cmpxchg" "cmpxchg64" "try_cmpxchg" "try_cmpxchg64"; do
 	for order in "" "_acquire" "_release" "_relaxed"; do
 		gen_xchg "${xchg}" "${order}" ""
 		printf "\n"
-- 
2.35.1

