Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5A257FE1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbiGYLKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiGYLKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:10:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82778B1D5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:10:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2DFC60F07
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 11:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B750C341C6;
        Mon, 25 Jul 2022 11:10:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UKzIoRW7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658747444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4hha2u7Ttf85rlfnP70RRrDiKMZ3achs4iQQcieqiRo=;
        b=UKzIoRW7iTYCNZ/fLqml5HAw2XqOA11ikyJa25vfT2zuEa+o7iNaa6pH+QFj7busp8sGbu
        zEbcoRIkdYGZfAP0kx6ADCT//5f8gh3tFABE2+RAqmlCcBwo7QeXiyMsBg9oye0dViu2HE
        hj4UBfEW2tVgo8Bgct+rh4ly+J8SrjY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b22d6502 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 25 Jul 2022 11:10:43 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Borislav Petkov <bp@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] random: discourage use of archrandom outside of rng
Date:   Mon, 25 Jul 2022 13:10:38 +0200
Message-Id: <20220725111038.720624-1-Jason@zx2c4.com>
In-Reply-To: <Yt5hwxC1xgvA8Asw@zx2c4.com>
References: <Yt5hwxC1xgvA8Asw@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav pointed out during the review of "random: handle archrandom
with multiple longs" that people might actually use this function, which
might not be good because the function has surprising semantics. This of
course was also the case before that patch, and indeed RDSEED-like
functions across architectures often behave surprisingly, failing often.
While random.c has been written specifically to work with that behavior,
not much else is well equipped for that.

So add a comment suggesting that this is not for general consumption.
Fortunately, nobody uses this for general consumption anyway, and people
who try quickly find themselves in trouble. But adding this comment out
of an abundance of caution was nonetheless suggested, and it at least
means there will be easier justification for cleaning up potential
misuses of the function later.

Cc: Borislav Petkov <bp@suse.de>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Johannes Berg <johannes@sipsolutions.net>
Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/arm64/include/asm/archrandom.h   | 13 +++++++++++++
 arch/powerpc/include/asm/archrandom.h |  8 ++++++++
 arch/s390/include/asm/archrandom.h    |  8 ++++++++
 arch/um/include/asm/archrandom.h      |  8 ++++++++
 arch/x86/include/asm/archrandom.h     |  9 ++++++---
 include/asm-generic/archrandom.h      |  8 ++++++++
 6 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/archrandom.h b/arch/arm64/include/asm/archrandom.h
index 109e2a4454be..0b5ee0e12a13 100644
--- a/arch/arm64/include/asm/archrandom.h
+++ b/arch/arm64/include/asm/archrandom.h
@@ -58,6 +58,10 @@ static inline bool __arm64_rndrrs(unsigned long *v)
 	return ok;
 }
 
+/*
+ * This should only be used by drivers/char/random.c. Other drivers *must*
+ * use get_random_bytes() instead.
+ */
 static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
 {
 	/*
@@ -71,6 +75,10 @@ static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t
 	return 0;
 }
 
+/*
+ * This should only be used by drivers/char/random.c. Other drivers *must*
+ * use get_random_bytes() instead.
+ */
 static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
 {
 	if (!max_longs)
@@ -121,6 +129,11 @@ static inline bool __init __early_cpu_has_rndr(void)
 	return (ftr >> ID_AA64ISAR0_EL1_RNDR_SHIFT) & 0xf;
 }
 
+
+/*
+ * This should only be used by drivers/char/random.c. Other drivers *must*
+ * use get_random_bytes() instead.
+ */
 static inline size_t __init __must_check
 arch_get_random_seed_longs_early(unsigned long *v, size_t max_longs)
 {
diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
index 0e365c5b2396..7accfe346d49 100644
--- a/arch/powerpc/include/asm/archrandom.h
+++ b/arch/powerpc/include/asm/archrandom.h
@@ -4,11 +4,19 @@
 
 #include <asm/machdep.h>
 
+/*
+ * This should only be used by drivers/char/random.c. Other drivers *must*
+ * use get_random_bytes() instead.
+ */
 static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
 {
 	return 0;
 }
 
+/*
+ * This should only be used by drivers/char/random.c. Other drivers *must*
+ * use get_random_bytes() instead.
+ */
 static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
 {
 	if (max_longs && ppc_md.get_random_seed && ppc_md.get_random_seed(v))
diff --git a/arch/s390/include/asm/archrandom.h b/arch/s390/include/asm/archrandom.h
index cf5e000df0a1..ae1efdd6f3a9 100644
--- a/arch/s390/include/asm/archrandom.h
+++ b/arch/s390/include/asm/archrandom.h
@@ -18,11 +18,19 @@
 DECLARE_STATIC_KEY_FALSE(s390_arch_random_available);
 extern atomic64_t s390_arch_random_counter;
 
+/*
+ * This should only be used by drivers/char/random.c. Other drivers *must*
+ * use get_random_bytes() instead.
+ */
 static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
 {
 	return 0;
 }
 
+/*
+ * This should only be used by drivers/char/random.c. Other drivers *must*
+ * use get_random_bytes() instead.
+ */
 static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
 {
 	if (static_branch_likely(&s390_arch_random_available)) {
diff --git a/arch/um/include/asm/archrandom.h b/arch/um/include/asm/archrandom.h
index 24e16c979c51..d2b20bb0ed53 100644
--- a/arch/um/include/asm/archrandom.h
+++ b/arch/um/include/asm/archrandom.h
@@ -7,6 +7,10 @@
 /* This is from <os.h>, but better not to #include that in a global header here. */
 ssize_t os_getrandom(void *buf, size_t len, unsigned int flags);
 
+/*
+ * This should only be used by drivers/char/random.c. Other drivers *must*
+ * use get_random_bytes() instead.
+ */
 static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
 {
 	ssize_t ret;
@@ -17,6 +21,10 @@ static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t
 	return ret / sizeof(*v);
 }
 
+/*
+ * This should only be used by drivers/char/random.c. Other drivers *must*
+ * use get_random_bytes() instead.
+ */
 static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
 {
 	return 0;
diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archrandom.h
index 02bae8e0758b..8352948e6412 100644
--- a/arch/x86/include/asm/archrandom.h
+++ b/arch/x86/include/asm/archrandom.h
@@ -41,15 +41,18 @@ static inline bool __must_check rdseed_long(unsigned long *v)
 }
 
 /*
- * These are the generic interfaces; they must not be declared if the
- * stubs in <linux/random.h> are to be invoked.
+ * This should only be used by drivers/char/random.c. Other drivers *must*
+ * use get_random_bytes() instead.
  */
-
 static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
 {
 	return max_longs && static_cpu_has(X86_FEATURE_RDRAND) && rdrand_long(v) ? 1 : 0;
 }
 
+/*
+ * This should only be used by drivers/char/random.c. Other drivers *must*
+ * use get_random_bytes() instead.
+ */
 static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
 {
 	return max_longs && static_cpu_has(X86_FEATURE_RDSEED) && rdseed_long(v) ? 1 : 0;
diff --git a/include/asm-generic/archrandom.h b/include/asm-generic/archrandom.h
index 3cd7f980cfdc..800b41639dd7 100644
--- a/include/asm-generic/archrandom.h
+++ b/include/asm-generic/archrandom.h
@@ -2,11 +2,19 @@
 #ifndef __ASM_GENERIC_ARCHRANDOM_H__
 #define __ASM_GENERIC_ARCHRANDOM_H__
 
+/*
+ * This should only be used by drivers/char/random.c. Other drivers *must*
+ * use get_random_bytes() instead.
+ */
 static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
 {
 	return 0;
 }
 
+/*
+ * This should only be used by drivers/char/random.c. Other drivers *must*
+ * use get_random_bytes() instead.
+ */
 static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
 {
 	return 0;
-- 
2.35.1

