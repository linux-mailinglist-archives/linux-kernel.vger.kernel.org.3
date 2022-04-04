Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4AB4F147D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239812AbiDDMNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239076AbiDDMN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:13:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967CD3DDC2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 05:11:29 -0700 (PDT)
Message-ID: <20220404104820.713066297@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649074287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ao8ewpta1h3rBHe+eerTP6dP9fqXfbqWk7GzZd3tujY=;
        b=ufgtnfyeeDiba+d+6EKLpU3I9fACAe6mSFYME8ao1PGAvRPN+iUPHsdz7aVwLLTH2gFQMv
        r/N2g9tDW9YT/kG+EgjWHiUHHopPNtjKuef+TqZSR6r5KFbbmctpt50m4uvDMeSSokJoQ/
        LrZYOtwY2Q24GGj1NCV9Dsquev8VbOgFzdtJjbMZG2Xoxk76sp4YutM/s1M6B44a2BnkcN
        h+7P3tfHkHXg6UUfpM0iZUGiBDYrAOudWHqQTuQvT2y/Q1yjFjozu1Wmke6FXqnm1OoZtB
        ZY3Erq8sVRGl0QqfuCmxYOcpS9hP5HwJK44hp1pcRBCTIHqdKqKDdWeD+h41ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649074287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ao8ewpta1h3rBHe+eerTP6dP9fqXfbqWk7GzZd3tujY=;
        b=u5bWR62vuxn6XVr7n1PDxmCCOIeqO4ff8Nc85hqIaqMz9//g97CfMquF/rx1p5p9GVewlH
        mNwKXxGa2Time/Dg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: [patch 3/3] x86/fpu/xsave: Optimize XSAVEC/S when XGETBV1 is supported
References: <20220404103741.809025935@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  4 Apr 2022 14:11:27 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XSAVEC/S store the FPU state in compacted format, which avoids holes in the
memory image. The kernel uses this feature in a very naive way and just
avoids holes which come from unsupported features, like PT. That's a
marginal saving of 128 byte vs. the uncompacted format on a SKL-X.

The first 576 bytes are fixed. 512 byte legacy (FP/SSE) and 64 byte XSAVE
header. On a SKL-X machine the other components are stored at the following
offsets:
 
 xstate_offset[2]:  576, xstate_sizes[2]:  256
 xstate_offset[3]:  832, xstate_sizes[3]:   64
 xstate_offset[4]:  896, xstate_sizes[4]:   64
 xstate_offset[5]:  960, xstate_sizes[5]:   64
 xstate_offset[6]: 1024, xstate_sizes[6]:  512
 xstate_offset[7]: 1536, xstate_sizes[7]: 1024
 xstate_offset[9]: 2560, xstate_sizes[9]:    8

XSAVEC/S use the init optimization which does not write data of a component
when the component is in init state. The state is stored in the XSTATE_BV
bitmap of the XSTATE header.

The kernel requests to save all enabled components, which results in a
suboptimal write/read pattern when the set of active components is sparse.

A typical scenario is an active set of 0x202 (PKRU + SSE) out of the full
supported set of 0x2FF. That means XSAVEC/S writes and XRSTOR[S] reads:

  - SSE in the legacy area (0-511)
  - Part of the XSTATE header (512-575)
  - PKRU at offset 2560

which is suboptimal. Prefetch works better when the access is linear. But
what's worse is that PKRU can be located in a different page which
obviously affects dTLB.

XSAVEC/S allows to further reduce the memory footprint when the active
feature set is sparse and the CPU supports XGETBV1. XGETBV1 reads the state
of the XSTATE components as a bitmap. This bitmap can be fed into XSAVEC/S
to request only the storage of the active components, which changes the
layout of the state buffer to:

  - SSE in the legacy area (0-511)
  - Part of the XSTATE header (512-575)
  - PKRU at offset 576

This optimization does not gain much for e.g. a kernel build, but for
context switch heavy applications it's very visible. Perf stats from
hackbench:

Before:

        242,618.89 msec task-clock                #  102.928 CPUs utilized            ( +-  0.20% )
         1,038,988      context-switches          #    0.004 M/sec                    ( +-  0.54% )
           460,081      cpu-migrations            #    0.002 M/sec                    ( +-  0.56% )
            10,813      page-faults               #    0.045 K/sec                    ( +-  0.62% )
   506,912,353,968      cycles                    #    2.089 GHz                      ( +-  0.20% )
   167,267,811,210      instructions              #    0.33  insn per cycle           ( +-  0.04% )
    34,481,978,727      branches                  #  142.124 M/sec                    ( +-  0.04% )
       305,975,304      branch-misses             #    0.89% of all branches          ( +-  0.09% )

           2.35717 +- 0.00607 seconds time elapsed  ( +-  0.26% )

   506,064,738,921      cycles                                                        ( +-  0.43% )
     3,334,160,871      L1-dcache-load-misses                                         ( +-  0.77% )
       135,271,979      dTLB-load-misses                                              ( +-  2.12% )
        18,169,634      dTLB-store-misses                                             ( +-  1.78% )

            2.3323 +- 0.0117 seconds time elapsed  ( +-  0.50% )

After:

        222,252.90 msec task-clock                #  103.800 CPUs utilized            ( +-  0.51% )
         1,004,665      context-switches          #    0.005 M/sec                    ( +-  0.42% )
           459,123      cpu-migrations            #    0.002 M/sec                    ( +-  0.33% )
            10,677      page-faults               #    0.048 K/sec                    ( +-  0.79% )
   464,356,465,870      cycles                    #    2.089 GHz                      ( +-  0.51% )
   166,615,501,152      instructions              #    0.36  insn per cycle           ( +-  0.05% )
    34,355,848,663      branches                  #  154.580 M/sec                    ( +-  0.05% )
       300,049,704      branch-misses             #    0.87% of all branches          ( +-  0.14% )

            2.1412 +- 0.0117 seconds time elapsed  ( +-  0.55% )

   473,864,807,936      cycles                                                        ( +-  0.64% )
     3,198,078,809      L1-dcache-load-misses                                         ( +-  0.24% )
        27,798,721      dTLB-load-misses                                              ( +-  2.33% )
         4,981,069      dTLB-store-misses                                             ( +-  1.80% )

            2.1733 +- 0.0132 seconds time elapsed  ( +-  0.61% )

The most significant change is in dTLB misses.

The effect depends on the application scenario, the kernel configuration
and the allocation placement of task_struct, so it might be not noticable
at all. As the XGETBV1 optimization is not introducing a measurable
overhead it's worth to use it if supported by the hardware.

Enable it when available with a static key and mask out the non-active
states in the requested bitmap for XSAVEC/S.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/xstate.c |   10 ++++++++--
 arch/x86/kernel/fpu/xstate.h |   16 +++++++++++++---
 2 files changed, 21 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -86,6 +86,8 @@ static unsigned int xstate_flags[XFEATUR
 #define XSTATE_FLAG_SUPERVISOR	BIT(0)
 #define XSTATE_FLAG_ALIGNED64	BIT(1)
 
+DEFINE_STATIC_KEY_FALSE(__xsave_use_xgetbv1);
+
 /*
  * Return whether the system supports a given xfeature.
  *
@@ -1481,7 +1483,7 @@ void xfd_validate_state(struct fpstate *
 }
 #endif /* CONFIG_X86_DEBUG_FPU */
 
-static int __init xfd_update_static_branch(void)
+static int __init fpu_update_static_branches(void)
 {
 	/*
 	 * If init_fpstate.xfd has bits set then dynamic features are
@@ -1489,9 +1491,13 @@ static int __init xfd_update_static_bran
 	 */
 	if (init_fpstate.xfd)
 		static_branch_enable(&__fpu_state_size_dynamic);
+
+	if (cpu_feature_enabled(X86_FEATURE_XGETBV1) &&
+	    cpu_feature_enabled(X86_FEATURE_XCOMPACTED))
+		static_branch_enable(&__xsave_use_xgetbv1);
 	return 0;
 }
-arch_initcall(xfd_update_static_branch)
+arch_initcall(fpu_update_static_branches)
 
 void fpstate_free(struct fpu *fpu)
 {
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -10,7 +10,12 @@
 DECLARE_PER_CPU(u64, xfd_state);
 #endif
 
-static inline bool xsave_use_xgetbv1(void) { return false; }
+DECLARE_STATIC_KEY_FALSE(__xsave_use_xgetbv1);
+
+static __always_inline __pure bool xsave_use_xgetbv1(void)
+{
+	return static_branch_likely(&__xsave_use_xgetbv1);
+}
 
 static inline void __xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
 {
@@ -185,13 +190,18 @@ static inline int __xfd_enable_feature(u
 static inline void os_xsave(struct fpstate *fpstate)
 {
 	u64 mask = fpstate->xfeatures;
-	u32 lmask = mask;
-	u32 hmask = mask >> 32;
+	u32 lmask, hmask;
 	int err;
 
 	WARN_ON_FPU(!alternatives_patched);
 	xfd_validate_state(fpstate, mask, false);
 
+	if (xsave_use_xgetbv1())
+		mask &= xgetbv(1);
+
+	lmask = mask;
+	hmask = mask >> 32;
+
 	XSTATE_XSAVE(&fpstate->regs.xsave, lmask, hmask, err);
 
 	/* We should never fault when copying to a kernel buffer: */

