Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4061553C02E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239333AbiFBVEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiFBVEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:04:41 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9D235261
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 14:04:40 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id A97FB2E19A7;
        Thu,  2 Jun 2022 23:04:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1654203875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pF66QpOyvZMR2LFw2QHcaSzXeOw1CJi9PNuSQ7tymZ8=;
        b=O5dI7xEPkLH+jtbBoL9KLnYtwqnk4QnmWui0gpR/128I0pvRa7I34DnFlZaq2m4QOaPVVv
        3/tG6NLr22ZeqYuQtKhg0tHtlvNfUaR5VCbiLftV8WWXidFla3Q2BZkPYViCase2Zp7cDC
        3Z4ZZUlWINElmpK65Q4kF3wEhieIaKBSrT22LHdoihOumlvxl5J3mnFSPa/VvIKIKFQPRP
        VPsP4N3pMaa2MvTM1MpPShurtZSgITvwFwrUt0HftLvwsRah/ktfegXABwwDlxcP4Lshhq
        NK465gNjG3Bej5pO2vfpo9x6jnmYbRiqb9bYZEJs+b1zQihATuQQecvYLFmWaw==
From:   Sander Vanheule <sander@svanheule.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v1 1/2] cpumask: Fix invalid uniprocessor mask assumption
Date:   Thu,  2 Jun 2022 23:04:19 +0200
Message-Id: <017b97698ba58d33bf45d30317d5a73c5b93d2a0.1654201862.git.sander@svanheule.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654201862.git.sander@svanheule.net>
References: <cover.1654201862.git.sander@svanheule.net>
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
CPU (cpu0). This ignores the existence of empty masks, resulting in
incorrect behaviour for most of the implemented optimisations.

Replace the uniprocessor optimisations with implementations that also
take into account empty masks. Also drop the incorrectly optimised
for_each_cpu implementations and use the generic implementations in all
cases.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 include/linux/cpumask.h | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index fe29ac7cc469..ce8c7b27f6c9 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -117,51 +117,54 @@ static __always_inline unsigned int cpumask_check(unsigned int cpu)
 }
 
 #if NR_CPUS == 1
-/* Uniprocessor.  Assume all masks are "1". */
+/* Uniprocessor. Assume all valid masks are "1" or empty. */
 static inline unsigned int cpumask_first(const struct cpumask *srcp)
 {
-	return 0;
+	return !(*cpumask_bits(srcp) & 1);
 }
 
 static inline unsigned int cpumask_first_zero(const struct cpumask *srcp)
 {
-	return 0;
+	return *cpumask_bits(srcp) & 1;
 }
 
 static inline unsigned int cpumask_first_and(const struct cpumask *srcp1,
 					     const struct cpumask *srcp2)
 {
-	return 0;
+	return !(*cpumask_bits(srcp1) & *cpumask_bits(srcp2) & 1);
 }
 
 static inline unsigned int cpumask_last(const struct cpumask *srcp)
 {
-	return 0;
+	return cpumask_first(srcp);
 }
 
 /* Valid inputs for n are -1 and 0. */
 static inline unsigned int cpumask_next(int n, const struct cpumask *srcp)
 {
-	return n+1;
+	return !!(n + 1 + cpumask_first(srcp));
 }
 
 static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 {
-	return n+1;
+	return !!(n + 1 + cpumask_first_zero(srcp));
 }
 
 static inline unsigned int cpumask_next_and(int n,
 					    const struct cpumask *srcp,
 					    const struct cpumask *andp)
 {
-	return n+1;
+	return !!(n + 1 + cpumask_first_and(srcp, andp));
 }
 
 static inline unsigned int cpumask_next_wrap(int n, const struct cpumask *mask,
 					     int start, bool wrap)
 {
-	/* cpu0 unless stop condition, wrap and at cpu0, then nr_cpumask_bits */
-	return (wrap && n == 0);
+	/*
+	 * nr_cpumask_bits at stop condition, wrap and at cpu0, or empty mask
+	 * otherwise cpu0
+	 */
+	return (wrap && n == 0) || cpumask_first(mask);
 }
 
 /* cpu must be a valid cpu, ie 0, so there's no other choice. */
@@ -186,14 +189,6 @@ static inline int cpumask_any_distribute(const struct cpumask *srcp)
 	return cpumask_first(srcp);
 }
 
-#define for_each_cpu(cpu, mask)			\
-	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
-#define for_each_cpu_not(cpu, mask)		\
-	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
-#define for_each_cpu_wrap(cpu, mask, start)	\
-	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)(start))
-#define for_each_cpu_and(cpu, mask1, mask2)	\
-	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask1, (void)mask2)
 #else
 /**
  * cpumask_first - get the first cpu in a cpumask
@@ -259,11 +254,13 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 }
 
 int __pure cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
+extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap);
 int __pure cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
 int cpumask_any_and_distribute(const struct cpumask *src1p,
 			       const struct cpumask *src2p);
 int cpumask_any_distribute(const struct cpumask *srcp);
+#endif /* SMP */
 
 /**
  * for_each_cpu - iterate over every cpu in a mask
@@ -289,7 +286,6 @@ int cpumask_any_distribute(const struct cpumask *srcp);
 		(cpu) = cpumask_next_zero((cpu), (mask)),	\
 		(cpu) < nr_cpu_ids;)
 
-extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap);
 
 /**
  * for_each_cpu_wrap - iterate over every cpu in a mask, starting at a specified location
@@ -324,7 +320,6 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
 	for ((cpu) = -1;						\
 		(cpu) = cpumask_next_and((cpu), (mask1), (mask2)),	\
 		(cpu) < nr_cpu_ids;)
-#endif /* SMP */
 
 #define CPU_BITS_NONE						\
 {								\
-- 
2.36.1

