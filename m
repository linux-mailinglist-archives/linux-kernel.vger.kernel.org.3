Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB261584C49
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbiG2HBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiG2HBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:01:42 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AA52F39D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:01:40 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id C23F8302C2E;
        Fri, 29 Jul 2022 09:01:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1659078094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B5yEFAJsNzK2P3Idr1Ql1MAP9Q2Tlri6Ym2Ak1ckCII=;
        b=M+RHsBLs6DOjXSjOxbuyM0Miw/O4D+x95Lh9oLPRe9BSHyLPX+WirX416PbErrIuqAKETQ
        +S98hXou9XbW531rcG9JRHhUoNUXvpnKQTH3qW6sdH/GDRnEOTBHrCfeq+wD2gdd3ZLMkf
        bQz0aKpf8RGVoC3SQqJTaW4agc6UaE+FfmoShI2wCDyKplx+x7mVY8Y1buxTJDKMKjxo2i
        AevOqVdh0Dt9VWDWVw5Ia4+pLOvQVYD7pEN8xS2oE2vcHsWlDq5zdFMoxb8BfUsHzzCavc
        j+mBOSU4KJeKDOYcIQdQ1d7Lr5G1rpI5N4NP4zJnXtbxrqaGpvrIO8r2a6oUHw==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Gow <davidgow@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v5 3/5] cpumask: fix invalid uniprocessor mask assumption
Date:   Fri, 29 Jul 2022 09:01:20 +0200
Message-Id: <e78c55ecb98172356248a7a89da501479ead6ae0.1659077534.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1659077534.git.sander@svanheule.net>
References: <cover.1659077534.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On uniprocessor builds, any CPU mask is assumed to contain exactly one CPU
(cpu0).  This assumption ignores the existence of empty masks, potentially
resulting in incorrect behaviour.  For example, for_each_cpu() will run
one iteration of the loop even when passed an empty cpumask.

cpumask_first_zero(), cpumask_next_zero(), and for_each_cpu_not() don't
provide behaviour matching the assumption that a UP mask is always "1",
but instead provide behaviour matching the empty mask.

Drop the incorrectly optimised code and use the generic implementations in
all cases.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <vschneid@redhat.com>
---
Changes since v4:
- Reflow commit message
 
Changes since v3:
- Add back UP-optimised cpumask_local_spread, cpumask_any_distribute,
  cpumask_any_and_distribute

Changes since v1:
- Drop UP implementations instead of trying to fix them

 include/linux/cpumask.h | 99 ++++++++---------------------------------
 lib/Makefile            |  3 +-
 lib/cpumask.c           |  2 +
 3 files changed, 22 insertions(+), 82 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 533612770bc0..6c5b4ee000f2 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -116,85 +116,6 @@ static __always_inline unsigned int cpumask_check(unsigned int cpu)
 	return cpu;
 }
 
-#if NR_CPUS == 1
-/* Uniprocessor.  Assume all masks are "1". */
-static inline unsigned int cpumask_first(const struct cpumask *srcp)
-{
-	return 0;
-}
-
-static inline unsigned int cpumask_first_zero(const struct cpumask *srcp)
-{
-	return 0;
-}
-
-static inline unsigned int cpumask_first_and(const struct cpumask *srcp1,
-					     const struct cpumask *srcp2)
-{
-	return 0;
-}
-
-static inline unsigned int cpumask_last(const struct cpumask *srcp)
-{
-	return 0;
-}
-
-/* Valid inputs for n are -1 and 0. */
-static inline unsigned int cpumask_next(int n, const struct cpumask *srcp)
-{
-	return n+1;
-}
-
-static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
-{
-	return n+1;
-}
-
-static inline unsigned int cpumask_next_and(int n,
-					    const struct cpumask *srcp,
-					    const struct cpumask *andp)
-{
-	return n+1;
-}
-
-static inline unsigned int cpumask_next_wrap(int n, const struct cpumask *mask,
-					     int start, bool wrap)
-{
-	/* cpu0 unless stop condition, wrap and at cpu0, then nr_cpumask_bits */
-	return (wrap && n == 0);
-}
-
-/* cpu must be a valid cpu, ie 0, so there's no other choice. */
-static inline unsigned int cpumask_any_but(const struct cpumask *mask,
-					   unsigned int cpu)
-{
-	return 1;
-}
-
-static inline unsigned int cpumask_local_spread(unsigned int i, int node)
-{
-	return 0;
-}
-
-static inline int cpumask_any_and_distribute(const struct cpumask *src1p,
-					     const struct cpumask *src2p) {
-	return cpumask_first_and(src1p, src2p);
-}
-
-static inline int cpumask_any_distribute(const struct cpumask *srcp)
-{
-	return cpumask_first(srcp);
-}
-
-#define for_each_cpu(cpu, mask)			\
-	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
-#define for_each_cpu_not(cpu, mask)		\
-	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
-#define for_each_cpu_wrap(cpu, mask, start)	\
-	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)(start))
-#define for_each_cpu_and(cpu, mask1, mask2)	\
-	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask1, (void)mask2)
-#else
 /**
  * cpumask_first - get the first cpu in a cpumask
  * @srcp: the cpumask pointer
@@ -260,10 +181,29 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 
 int __pure cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
 int __pure cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
+
+#if NR_CPUS == 1
+/* Uniprocessor: there is only one valid CPU */
+static inline unsigned int cpumask_local_spread(unsigned int i, int node)
+{
+	return 0;
+}
+
+static inline int cpumask_any_and_distribute(const struct cpumask *src1p,
+					     const struct cpumask *src2p) {
+	return cpumask_first_and(src1p, src2p);
+}
+
+static inline int cpumask_any_distribute(const struct cpumask *srcp)
+{
+	return cpumask_first(srcp);
+}
+#else
 unsigned int cpumask_local_spread(unsigned int i, int node);
 int cpumask_any_and_distribute(const struct cpumask *src1p,
 			       const struct cpumask *src2p);
 int cpumask_any_distribute(const struct cpumask *srcp);
+#endif /* NR_CPUS */
 
 /**
  * for_each_cpu - iterate over every cpu in a mask
@@ -324,7 +264,6 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
 	for ((cpu) = -1;						\
 		(cpu) = cpumask_next_and((cpu), (mask1), (mask2)),	\
 		(cpu) < nr_cpu_ids;)
-#endif /* SMP */
 
 #define CPU_BITS_NONE						\
 {								\
diff --git a/lib/Makefile b/lib/Makefile
index f99bf61f8bbc..bcc7e8ea0cde 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -34,10 +34,9 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o \
-	 buildid.o
+	 buildid.o cpumask.o
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
-lib-$(CONFIG_SMP) += cpumask.o
 
 lib-y	+= kobject.o klist.o
 obj-y	+= lockref.o
diff --git a/lib/cpumask.c b/lib/cpumask.c
index a971a82d2f43..b9728513a4d4 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -192,6 +192,7 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
 }
 #endif
 
+#if NR_CPUS > 1
 /**
  * cpumask_local_spread - select the i'th cpu with local numa cpu's first
  * @i: index number
@@ -279,3 +280,4 @@ int cpumask_any_distribute(const struct cpumask *srcp)
 	return next;
 }
 EXPORT_SYMBOL(cpumask_any_distribute);
+#endif /* NR_CPUS */
-- 
2.37.1

