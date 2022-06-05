Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFC453DA67
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 08:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349398AbiFEGXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 02:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244197AbiFEGWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 02:22:52 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38C613DFF
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 23:22:50 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 1FBBD2E2DA2;
        Sun,  5 Jun 2022 08:22:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1654410167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B2PsbTSzMFRa3tyPILmOXv9dgA1FxVSPhNZx0CHBfy0=;
        b=sF4xPDC9G4yDNXhqzUbkFfKUg9R3JTWuiemiwN3WWKhjGzslMkvxwA7kgk+PWEVYbROfN6
        9yv84tV6yXfkiPTcipIue2eCFHduOuYF5O66yJWi0v56clh/+USZesE2iwknIRLwN2Jlcg
        9sL9/tQhPg+CjAzOp2exqHLtacuKCtgKbILMqCKYhpJ12kvXQsYDYh0uXc/H3eJHCNdvVg
        lkEO3FTKYO3vS4jSRFcQJ3Oes6Z7Q1d9FFNH9sI/FzvoSk12IMj2jdkX7D/xnVcOMa9jwm
        n/600jmZgsC4rSn1LSI4Sg2CrvjwebJvUTpyBgmSxhmoQ2991hdozbUIDH6SIQ==
From:   Sander Vanheule <sander@svanheule.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v3 1/4] cpumask: Fix invalid uniprocessor mask assumption
Date:   Sun,  5 Jun 2022 08:22:38 +0200
Message-Id: <cc1f7d3334348cccbf9fde091015a802f379a9be.1654410109.git.sander@svanheule.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654410109.git.sander@svanheule.net>
References: <cover.1654410109.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
Changes since v1:
- Drop UP implementations instead of trying to fix them
---
 include/linux/cpumask.h | 80 -----------------------------------------
 lib/Makefile            |  3 +-
 2 files changed, 1 insertion(+), 82 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index fe29ac7cc469..d6add0e29ef4 100644
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
@@ -324,7 +245,6 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
 	for ((cpu) = -1;						\
 		(cpu) = cpumask_next_and((cpu), (mask1), (mask2)),	\
 		(cpu) < nr_cpu_ids;)
-#endif /* SMP */
 
 #define CPU_BITS_NONE						\
 {								\
diff --git a/lib/Makefile b/lib/Makefile
index 89fcae891361..6f26a429115b 100644
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
-- 
2.36.1

