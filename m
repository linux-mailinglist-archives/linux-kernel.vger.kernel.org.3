Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A935564146
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 18:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbiGBQIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 12:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiGBQIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 12:08:43 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0BBE09F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 09:08:38 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 4A21D2F29DA;
        Sat,  2 Jul 2022 18:08:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1656778114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HgR7Wjj7jo2qbr8hVcKZouv7Jy3+ITFYDiBA1XO9ego=;
        b=m1vSefP+aWdwrzMtbwfzU1VLn6AgOgi9cNAOkIUer7THOIGN+9681UNlxSh7rgmXenUsQk
        41XYZG8Lo+1Vyb4ey7pqozvZsIzKn1U4jv+7damxplyZHIkIkE4XZY8RwNv1dotGVaUmFa
        0g5+VUqjq+D+VgxkLETmcpBg4UQLkb584jZ3owcmCYKY39Lh+pkGkqTRYIxvbcN65UYQT9
        SZ12QMtGYvr5oWGS7myR2kjOvCAvMmXF1hATnNc9wz2+67jAKnR2cZXkf1QgY0gQyc7kxV
        /yTnThJN8JKbx1ktpG8juYMcz6NHHabQA6JIY/s9A8ow1w6Vt/Ry0xaP3HKJHA==
From:   Sander Vanheule <sander@svanheule.net>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        elver@google.com, gregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, vschneid@redhat.com,
        Yury Norov <yury.norov@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v4 2/5] cpumask: Fix invalid uniprocessor mask assumption
Date:   Sat,  2 Jul 2022 18:08:25 +0200
Message-Id: <86bf3f005abba2d92120ddd0809235cab4f759a6.1656777646.git.sander@svanheule.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656777646.git.sander@svanheule.net>
References: <cover.1656777646.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On uniprocessor builds, any CPU mask is assumed to contain exactly one
CPU (cpu0). This assumption ignores the existence of empty masks,
resulting in incorrect behaviour.
cpumask_first_zero(), cpumask_next_zero(), and for_each_cpu_not() don't
provide behaviour matching the assumption that a UP mask is always "1",
and instead provide behaviour matching the empty mask.

Drop the incorrectly optimised code and use the generic implementations
in all cases.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---

Notes:
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
index fe29ac7cc469..7fbef41b3093 100644
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
2.36.1

