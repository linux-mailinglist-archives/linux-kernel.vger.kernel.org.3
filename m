Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366DE526627
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382087AbiEMPbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382132AbiEMPbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:31:19 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602F66F4AB
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:31:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ks9so16987750ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KXuxsvvmzObesTCgGUdp3DjkR6F9yj2J25L79TJ+yVs=;
        b=aXWfHMALpGfKhmrHrc/L4dv2J+Gp58oc75+F7mRYLtgpTkhkNDsbFFBigLbuyvjJjV
         IAw8zNjauvMxIqDCXFWAgkCxENedb90d2PKTxvvlaH82wv2drHpkq2BIJWfuWyUFTWTx
         fF9h3wmDRUEDcp1PNzBueNP1WPRK3an9B3T826qVc6OkkFibUhKaqtqFWtAT3UXDpY4a
         JG6wovGRwx75OLtX4en6r5HHU1cT59pHu+BKWSSVluKuxxddL3/cHVESAyfylqtSdp1K
         vohsEbeyS89HBT7UuR1rYoIoOeMLWxGQoC27irR0SsVp/JN6KDbKETR8em9TFXBXxWHb
         jTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KXuxsvvmzObesTCgGUdp3DjkR6F9yj2J25L79TJ+yVs=;
        b=kfcVtE+otw1yPEXQnJ33tr3EV08JV6ikjFJH/hF5gcLsUgJWPCioYkZUlvKtto9fR+
         +6PZCRIhVgjFzvzh90R/d0uZdJK/efD2Djuo1qrs+QQmvMZtlOJL18mUJhlXDrNwtH0Z
         jyTQAW9EN8BLgU9n/svM57txTHJcEXstFISPc2hjVhsbE1wqS+/o1fzrBrIQUA8vYFL2
         igJyeglpGi0l2o66r13tNFquFlbYkG0lPAFwiBT40qlrDEv5uNIINgYy/Qn3AW8Weol4
         r1RlaGAjyfl78n4a3JIrmFIhGLNDG27ss2t9b1sGRfr8WnqN2hOdcLv9NEP6ZAR9UALs
         NN7w==
X-Gm-Message-State: AOAM531GhVQC3dW7W38NfkoCLBcRVuq9210x9ls7yqJaE58XVGG9zjA/
        fyczZWIQTwIbC5pND/0qrtY=
X-Google-Smtp-Source: ABdhPJx7eYHdJ0ONJxZKP1JzGM3vzvvj/Gwx5mHue0RCmDN2ejLLc4U4ZxaUUkOBjDrog8CHBPigWA==
X-Received: by 2002:a17:906:19c6:b0:6ce:98a4:5ee6 with SMTP id h6-20020a17090619c600b006ce98a45ee6mr4757605ejd.567.1652455875913;
        Fri, 13 May 2022 08:31:15 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id h9-20020a50cdc9000000b0042617ba63d5sm1075706edj.95.2022.05.13.08.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 08:31:15 -0700 (PDT)
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
Subject: [PATCH v2 1/2] locking/atomic: Add generic try_cmpxchg64 support
Date:   Fri, 13 May 2022 17:30:08 +0200
Message-Id: <20220513153009.228282-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513153009.228282-1-ubizjak@gmail.com>
References: <20220513153009.228282-1-ubizjak@gmail.com>
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

