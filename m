Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14116578437
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbiGRNrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbiGRNrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:47:17 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D62823BEF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:47:16 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r6so15362445edd.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QLXcO+/DeVvroNSKtoBH7xkBrxaixn+m7ZXcphJScZ4=;
        b=OUe8s7UaGSYQhtXEcwd7vyVlFYoZSshrHjKGvtrjy1uXiTBlfcsJJw8S6zT7Fu5zPj
         X6JEPoXS3xOYVFvn6oIfKqyHmxi+7KfJ8Kqg5zN8lJOZfd2jvWiSRyq1lLk2P9+sbnck
         6/XU9FC8H1dcyJCyh+kyg3m2GC3gbZIQiMQlPw2kJGo/XYspw4um6wrMQrALMV06c83T
         PNELPsFVMUo+g0uhQsU2iAFZVUE0DeXOYJALbTR/EDQ1CaRe8epfyhO68ooEOjEo7fcX
         OuVqmm3ZnYIA4su4AY5SF3QyT5LRVZnIUK8EFGypqSY/QaHCh7frt5q005YaJoMNOgvk
         vYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QLXcO+/DeVvroNSKtoBH7xkBrxaixn+m7ZXcphJScZ4=;
        b=KNBWieJPoongwBuDivj9tAT/uuNY5zSsvn9QVv48TKURFIcL1g93ApeuROYbhPedLD
         Adb6/UAFwqKQx3ub4DanhtaQ7snxPpd1vYQCdva48PWMVvPzctVkhRWc0HZBRAKCa2t1
         padZMDEb4DUTzE7g4WPMk+a6s9S0SktI7IqTRBFCTBj7juxSVyxPLmY6ZD8+a2ylQTP6
         i/Hr+VQEIIaz0yo/3Rf9+Py7xgiROLoCR+9yD+0iuLv2RxTDM4bLrTLf+ci5exZMhZoW
         kVZl+xg7QsLAu0pgATkGh8QVKMRuFwXgVSQ3bVOQ0lZ9DROdatHtYwX/tibHmBuVphiK
         hYfg==
X-Gm-Message-State: AJIora8KrDFIDbJgOkz6lTW0mtUAPU5vFNWdRFnysv3mMnZJ9eyfRlA0
        YXcC9WOhUEmHcMWlCZeNmDxpht96u+rRRw==
X-Google-Smtp-Source: AGRyM1ufjspydgfYT9znb9vumeuD09pRVh6WvdeFYRjunUZoGh6EuvOHdbh5EVi7zEzms3DbWr8mlw==
X-Received: by 2002:a05:6402:1f0b:b0:43b:4188:8019 with SMTP id b11-20020a0564021f0b00b0043b41888019mr21362974edb.11.1658152034805;
        Mon, 18 Jul 2022 06:47:14 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id s5-20020a1709066c8500b0071c6dc728b2sm5507305ejr.86.2022.07.18.06.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 06:47:14 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] locking/atomic: Add missing cast to try_cmpxchg() fallbacks
Date:   Mon, 18 Jul 2022 15:47:06 +0200
Message-Id: <20220718134706.2548-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cast _oldp to the type of _ptr to avoid incompatible-pointer-types warning.

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Fixes: 29f006fdefe6f ("asm-generic/atomic: Add try_cmpxchg() fallbacks")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 include/linux/atomic/atomic-arch-fallback.h | 18 +++++++++---------
 scripts/atomic/gen-atomic-fallback.sh       |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 77bc5522e61c..19debd501ee7 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -87,7 +87,7 @@
 #ifndef arch_try_cmpxchg
 #define arch_try_cmpxchg(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
 	___r = arch_cmpxchg((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -98,7 +98,7 @@
 #ifndef arch_try_cmpxchg_acquire
 #define arch_try_cmpxchg_acquire(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
 	___r = arch_cmpxchg_acquire((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -109,7 +109,7 @@
 #ifndef arch_try_cmpxchg_release
 #define arch_try_cmpxchg_release(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
 	___r = arch_cmpxchg_release((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -120,7 +120,7 @@
 #ifndef arch_try_cmpxchg_relaxed
 #define arch_try_cmpxchg_relaxed(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
 	___r = arch_cmpxchg_relaxed((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -157,7 +157,7 @@
 #ifndef arch_try_cmpxchg64
 #define arch_try_cmpxchg64(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
 	___r = arch_cmpxchg64((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -168,7 +168,7 @@
 #ifndef arch_try_cmpxchg64_acquire
 #define arch_try_cmpxchg64_acquire(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
 	___r = arch_cmpxchg64_acquire((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -179,7 +179,7 @@
 #ifndef arch_try_cmpxchg64_release
 #define arch_try_cmpxchg64_release(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
 	___r = arch_cmpxchg64_release((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -190,7 +190,7 @@
 #ifndef arch_try_cmpxchg64_relaxed
 #define arch_try_cmpxchg64_relaxed(_ptr, _oldp, _new) \
 ({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \
 	___r = arch_cmpxchg64_relaxed((_ptr), ___o, (_new)); \
 	if (unlikely(___r != ___o)) \
 		*___op = ___r; \
@@ -2456,4 +2456,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// b5e87bdd5ede61470c29f7a7e4de781af3770f09
+// 1b4d4c82ae653389cd1538d5b07170267d9b3837
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 3a07695e3c89..39f447161108 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -171,7 +171,7 @@ cat <<EOF
 #ifndef arch_try_${cmpxchg}${order}
 #define arch_try_${cmpxchg}${order}(_ptr, _oldp, _new) \\
 ({ \\
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \\
+	typeof(*(_ptr)) *___op = (typeof(_ptr))(_oldp), ___o = *___op, ___r; \\
 	___r = arch_${cmpxchg}${order}((_ptr), ___o, (_new)); \\
 	if (unlikely(___r != ___o)) \\
 		*___op = ___r; \\
-- 
2.35.3

