Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941934F147C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239808AbiDDMNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238413AbiDDMNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:13:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35F53DDC2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 05:11:27 -0700 (PDT)
Message-ID: <20220404104820.656881574@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649074286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=xsFN8sY54byFTi37jBVKNT5P0eoTZc+cI8FTL3H6E7s=;
        b=coo+8/U0eLBjV0Nz3mVJR7RZZaBeG1yjjfqR08sxucGGNJK+s0B411X9jheqsPkSGyDg+t
        xKFvkAjWC0n0LUWlLXG30PkmuF8OM1ZplGZueJqHIKOEgEpBJamRK8jUnadBlM49wZJx76
        Aj2OkDY+dD3BdB3hn7yXBM9S3ZejCar8utlpGAQK2ranrUQEeGVPG5TL5UX6CVXFPTb8ce
        XuvosY0JcXuzFIWDyPsGvSS3z6phUjH9QDjJDVdN5SooG0Z7B4VIwVn1Ihm2fKMGzieT+l
        w1bABzGT8l82FqTrSIiVPxEeZaAwqxncxSt1j4figu7MPc1EPOF3eQgEnwCRQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649074286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=xsFN8sY54byFTi37jBVKNT5P0eoTZc+cI8FTL3H6E7s=;
        b=uwBEmCS+vasX4tmnL3fW0sqjN0AmlsA+pkJs9sRGSyzX0LoTOwYxvie1drH9p5laVPpar2
        0YjVnESOeO5nLBCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: [patch 2/3] x86/fpu/xsave: Prepare for optimized compaction
References: <20220404103741.809025935@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  4 Apr 2022 14:11:26 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XSAVES/C allow for optimized compaction by saving only the active component
states and compact the storage so it is linear without holes, which is
better for prefetching and dTLB.

This needs preparation in the copy to/from UABI functions. They have to be
aware of the optimized layout.

The change for __copy_xstate_to_uabi_buf() is trivial. It just has to avoid
calculating the offset in the XSTATE buffer when a component is in init
state. That's an improvement in general.

For copy_uabi_to_xstate() it's more effort when supervisor states are
supported and active. If the user space buffer has active states which are
not in the set of current states of the XSTATE buffer, then the buffer
layout will change which means the supervisor states might be overwritten.

Provide a function, which moves them out of the way and invoke it before
any of the extended features is copied from the user space buffer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/xstate.c |   77 ++++++++++++++++++++++++++++++++++++++++---
 arch/x86/kernel/fpu/xstate.h |   14 ++++++-
 2 files changed, 84 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1147,10 +1147,10 @@ void __copy_xstate_to_uabi_buf(struct me
 			pkru.pkru = pkru_val;
 			membuf_write(&to, &pkru, sizeof(pkru));
 		} else {
-			copy_feature(header.xfeatures & BIT_ULL(i), &to,
-				     __raw_xsave_addr(xsave, i),
-				     __raw_xsave_addr(xinit, i),
-				     xstate_sizes[i]);
+			bool active = header.xfeatures & BIT_ULL(i);
+			void *from = __raw_xsave_addr(active ? xsave : xinit, i);
+
+			membuf_write(&to, from, xstate_sizes[i]);
 		}
 		/*
 		 * Keep track of the last copied state in the non-compacted
@@ -1195,6 +1195,73 @@ static int copy_from_buffer(void *dst, u
 	return 0;
 }
 
+/*
+ * Prepare the kernel XSTATE buffer for saving the user supplied XSTATE. If
+ * the XGETBV1 based optimization is in use then the kernel buffer might
+ * not have the user supplied active features set and an eventual active
+ * supervisor state has to be moved out of the way. With optimized
+ * compaction the features which are to be stored need to be set in the
+ * XCOMP_BV field of the XSTATE header.
+ */
+static void xsave_adjust_xcomp(struct fpstate *fpstate, u64 xuser)
+{
+	struct xregs_state *xsave = &fpstate->regs.xsave;
+	u64 xtmp, xall, xbv, xcur = xsave->header.xfeatures;
+	int i;
+
+	/* Nothing to do if optimized compaction is not in use */
+	if (!xsave_use_xgetbv1())
+		return;
+
+	/*
+	 * Check whether the current xstate buffer contains supervisor
+	 * state. If not, just set the user supplied features.
+	 */
+	if (!(xcur & XFEATURE_MASK_SUPERVISOR_ALL)) {
+		__xstate_init_xcomp_bv(xsave, xuser);
+		return;
+	}
+
+	/*
+	 * Set legacy features. They are at a fixed offset and do not
+	 * affect the layout.
+	 */
+	xbv = xsave->header.xcomp_bv;
+	xbv |= xuser & (XFEATURE_MASK_FP | XFEATURE_MASK_SSE);
+
+	/*
+	 * Check whether there is new extended state in the user supplied
+	 * buffer. If not, then nothing has to be moved around.
+	 */
+	if (!(xuser & ~xbv)) {
+		__xstate_init_xcomp_bv(xsave, xbv);
+		return;
+	}
+
+	/*
+	 * No more optimizations. Set the user features and move the
+	 * supervisor state(s). If the new user feature is past
+	 * the supervisor state, then the loop is moving nothing.
+	 */
+	xtmp = xbv & XFEATURE_MASK_SUPERVISOR_ALL;
+	xall = xbv | xuser;
+
+	for (i = fls64(xtmp) - 1; i >= FIRST_EXTENDED_XFEATURE;
+	     i = fls64(xtmp) - 1) {
+		unsigned int to, from;
+
+		from = xfeature_get_offset(xbv, i);
+		to = xfeature_get_offset(xall, i);
+		if (from < to) {
+			memmove((void *)xsave + to, (void *)xsave + from,
+				xstate_sizes[i]);
+		} else {
+			WARN_ON_ONCE(to < from);
+		}
+		xtmp &= ~BIT_ULL(i);
+	}
+	__xstate_init_xcomp_bv(xsave, xall);
+}
 
 static int copy_uabi_to_xstate(struct fpstate *fpstate, const void *kbuf,
 			       const void __user *ubuf)
@@ -1232,6 +1299,8 @@ static int copy_uabi_to_xstate(struct fp
 		}
 	}
 
+	xsave_adjust_xcomp(fpstate, hdr.xfeatures);
+
 	for (i = 0; i < XFEATURE_MAX; i++) {
 		u64 mask = ((u64)1 << i);
 
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -10,14 +10,22 @@
 DECLARE_PER_CPU(u64, xfd_state);
 #endif
 
-static inline void xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
+static inline bool xsave_use_xgetbv1(void) { return false; }
+
+static inline void __xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
 {
 	/*
 	 * XRSTORS requires these bits set in xcomp_bv, or it will
-	 * trigger #GP:
+	 * trigger #GP. It's also required for XRSTOR when the buffer
+	 * was saved with XSAVEC in compacted format.
 	 */
+	xsave->header.xcomp_bv = mask | XCOMP_BV_COMPACTED_FORMAT;
+}
+
+static inline void xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
+{
 	if (cpu_feature_enabled(X86_FEATURE_XCOMPACTED))
-		xsave->header.xcomp_bv = mask | XCOMP_BV_COMPACTED_FORMAT;
+		__xstate_init_xcomp_bv(xsave, mask);
 }
 
 static inline u64 xstate_get_group_perm(bool guest)

