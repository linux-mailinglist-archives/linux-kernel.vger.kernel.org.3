Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EF7474DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbhLNWF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:05:26 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58722 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237921AbhLNWEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:04:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2EB39CE1AFF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2602C34618;
        Tue, 14 Dec 2021 22:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639519481;
        bh=3tgi/sZEfVXOuV9GJDQAEE5SJoQkpPOmks3ld7BJRms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fsgP1WHmuuuY74nLGe8cIGRfWhJ/WmBfHCcfBiyxkGVcXMkdRDO8908oeTUI7SNwB
         NAchEK3dJJe7LNTnuWZO0rBjB0DATqfiW5vN1KVXQB5qH0gesl22ZJIRPlRjwdv7Y7
         pyOEto66hTvs4NwW7s8fgnM+yxZeOAr+LoGrDDr/C1UzRfFTB8TLSxQJtIIf/VY4RT
         hZHQyFGRya3Pv4zENbMffJDLpx1q101FcgJtsNV8cLCqajQvG/8vxeoEJFWzJ8QqVN
         0ex7BVU/0/zK+EJFTM3JkKYM8oDcdu2BQ3B/BUEWM0Sj3dL0jMetyqgItHaUrzXeBE
         rxUbdYXofBOfg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6AEA55C1506; Tue, 14 Dec 2021 14:04:41 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 09/29] kcsan: Document modeling of weak memory
Date:   Tue, 14 Dec 2021 14:04:19 -0800
Message-Id: <20211214220439.2236564-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
References: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Document how KCSAN models a subset of weak memory and the subset of
missing memory barriers it can detect as a result.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/dev-tools/kcsan.rst | 76 +++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 13 deletions(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index 7db43c7c09b8c..3ae866dcc9240 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -204,17 +204,17 @@ Ultimately this allows to determine the possible executions of concurrent code,
 and if that code is free from data races.
 
 KCSAN is aware of *marked atomic operations* (``READ_ONCE``, ``WRITE_ONCE``,
-``atomic_*``, etc.), but is oblivious of any ordering guarantees and simply
-assumes that memory barriers are placed correctly. In other words, KCSAN
-assumes that as long as a plain access is not observed to race with another
-conflicting access, memory operations are correctly ordered.
-
-This means that KCSAN will not report *potential* data races due to missing
-memory ordering. Developers should therefore carefully consider the required
-memory ordering requirements that remain unchecked. If, however, missing
-memory ordering (that is observable with a particular compiler and
-architecture) leads to an observable data race (e.g. entering a critical
-section erroneously), KCSAN would report the resulting data race.
+``atomic_*``, etc.), and a subset of ordering guarantees implied by memory
+barriers. With ``CONFIG_KCSAN_WEAK_MEMORY=y``, KCSAN models load or store
+buffering, and can detect missing ``smp_mb()``, ``smp_wmb()``, ``smp_rmb()``,
+``smp_store_release()``, and all ``atomic_*`` operations with equivalent
+implied barriers.
+
+Note, KCSAN will not report all data races due to missing memory ordering,
+specifically where a memory barrier would be required to prohibit subsequent
+memory operation from reordering before the barrier. Developers should
+therefore carefully consider the required memory ordering requirements that
+remain unchecked.
 
 Race Detection Beyond Data Races
 --------------------------------
@@ -268,6 +268,56 @@ marked operations, if all accesses to a variable that is accessed concurrently
 are properly marked, KCSAN will never trigger a watchpoint and therefore never
 report the accesses.
 
+Modeling Weak Memory
+~~~~~~~~~~~~~~~~~~~~
+
+KCSAN's approach to detecting data races due to missing memory barriers is
+based on modeling access reordering (with ``CONFIG_KCSAN_WEAK_MEMORY=y``).
+Each plain memory access for which a watchpoint is set up, is also selected for
+simulated reordering within the scope of its function (at most 1 in-flight
+access).
+
+Once an access has been selected for reordering, it is checked along every
+other access until the end of the function scope. If an appropriate memory
+barrier is encountered, the access will no longer be considered for simulated
+reordering.
+
+When the result of a memory operation should be ordered by a barrier, KCSAN can
+then detect data races where the conflict only occurs as a result of a missing
+barrier. Consider the example::
+
+    int x, flag;
+    void T1(void)
+    {
+        x = 1;                  // data race!
+        WRITE_ONCE(flag, 1);    // correct: smp_store_release(&flag, 1)
+    }
+    void T2(void)
+    {
+        while (!READ_ONCE(flag));   // correct: smp_load_acquire(&flag)
+        ... = x;                    // data race!
+    }
+
+When weak memory modeling is enabled, KCSAN can consider ``x`` in ``T1`` for
+simulated reordering. After the write of ``flag``, ``x`` is again checked for
+concurrent accesses: because ``T2`` is able to proceed after the write of
+``flag``, a data race is detected. With the correct barriers in place, ``x``
+would not be considered for reordering after the proper release of ``flag``,
+and no data race would be detected.
+
+Deliberate trade-offs in complexity but also practical limitations mean only a
+subset of data races due to missing memory barriers can be detected. With
+currently available compiler support, the implementation is limited to modeling
+the effects of "buffering" (delaying accesses), since the runtime cannot
+"prefetch" accesses. Also recall that watchpoints are only set up for plain
+accesses, and the only access type for which KCSAN simulates reordering. This
+means reordering of marked accesses is not modeled.
+
+A consequence of the above is that acquire operations do not require barrier
+instrumentation (no prefetching). Furthermore, marked accesses introducing
+address or control dependencies do not require special handling (the marked
+access cannot be reordered, later dependent accesses cannot be prefetched).
+
 Key Properties
 ~~~~~~~~~~~~~~
 
@@ -290,8 +340,8 @@ Key Properties
 4. **Detects Racy Writes from Devices:** Due to checking data values upon
    setting up watchpoints, racy writes from devices can also be detected.
 
-5. **Memory Ordering:** KCSAN is *not* explicitly aware of the LKMM's ordering
-   rules; this may result in missed data races (false negatives).
+5. **Memory Ordering:** KCSAN is aware of only a subset of LKMM ordering rules;
+   this may result in missed data races (false negatives).
 
 6. **Analysis Accuracy:** For observed executions, due to using a sampling
    strategy, the analysis is *unsound* (false negatives possible), but aims to
-- 
2.31.1.189.g2e36527f23

