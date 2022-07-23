Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D2457ECC9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 10:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237171AbiGWIiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 04:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbiGWIiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 04:38:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA3B48E90
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 01:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658565485; x=1690101485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2OKJ7eYx8kgMq1wjIN4GfPIdGHp9k4EAlETkb0zCShI=;
  b=SEhTmR7wjoH+fPIJFmtE89cZRr6zP0XszQZOEr63MZNP6V+dMgANj7GW
   /hRnEM5AxbO7ex2gytIRdM2NShgRjrLEFOeD/b37mIxbOMxhh+bpjdHii
   2p1T9K1I6liLaO2yfZB2DnqC6jKEmnYPwhLG+wld/eNmvmAiB9BL4F5gR
   EyBqsKYkcJfnNgnmcknjDTTy8y7jbPMG908WyRakhXqUYwxYjtL/fDZEN
   tNqyRCdMdW710IxlpsR7+S4PeoCJ5UscQEN2CXPHH9WYvjyczci64tvgd
   wsBN3wJCx6XRBF1j4AoEOVgPjmPL/mQaekZRyS9ZXqTvNQI2/8SLwsjU+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="285002865"
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="285002865"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 01:38:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="574436596"
Received: from sunyi-station.sh.intel.com (HELO sunyi-station..) ([10.239.159.10])
  by orsmga006.jf.intel.com with ESMTP; 23 Jul 2022 01:38:03 -0700
From:   Yi Sun <yi.sun@intel.com>
To:     dave.hansen@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     sohil.mehta@intel.com, tony.luck@intel.com, heng.su@intel.com,
        yi.sun@intel.com
Subject: [PATCH 1/2] x86/fpu: Measure the Latency of XSAVE and XRSTOR
Date:   Sat, 23 Jul 2022 16:37:59 +0800
Message-Id: <20220723083800.824442-2-yi.sun@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220723083800.824442-1-yi.sun@intel.com>
References: <20220723083800.824442-1-yi.sun@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate the latency of instructions xsave and xrstor with new trace
points x86_fpu_latency_xsave and x86_fpu_latency_xrstor.

The delta TSC can be calculated within a single trace event. Another
option considered was to have 2 separated trace events marking the
start and finish of the xsave/xrstor instructions. The delta TSC was
calculated from the 2 trace points in user space, but there was
significant overhead added by the trace function itself.

In internal testing, the single trace point option which is
implemented here proved to be more accurate.

Together with the latency, dump the RFBM(requested-feature bitmap)
and XINUSE to identify the type of xsave/xrstor.

Trace log looks like following:
  x86_fpu_latency_xsave: x86/fpu: latency:100 RFBM:0x202e7 XINUSE:0x202
  x86_fpu_latency_xrstor: x86/fpu: latency:99 RFBM:0x202e7 XINUSE:0x202

To enable it, CONFIG_X86_DEBUG_FPU and CONFIG_TRACEPOINTS are required.
The compiler can get rid of all the extra crust when either of the two
configs is disabled.

If both of the two configs are enabled, xsave/xrstor_tracing_enabled
would be reduced to a static check for tracing enabled. Thus, in the
fast path there would be only 2 additional static checks.

Since tracepoints can be enabled dynamically, while the code is
checking tracepoint_enabled(trace_event), the trace_event could be
concurrently enabled. Hence there is probability to get single once
noisy result 'trace_clock() - (-1)' at the moment enabling the trace
points x86_fpu_latency_*. Leave the noise here instead of additional
conditions before calling the x86_fpu_latency_* because that makes the
latency more accurate and it's easy to filer the noise out by the
following consuming script.

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yi Sun <yi.sun@intel.com>

diff --git a/arch/x86/include/asm/trace/fpu.h b/arch/x86/include/asm/trace/fpu.h
index 4645a6334063..b40328f4e90d 100644
--- a/arch/x86/include/asm/trace/fpu.h
+++ b/arch/x86/include/asm/trace/fpu.h
@@ -89,6 +89,41 @@ DEFINE_EVENT(x86_fpu, x86_fpu_xstate_check_failed,
 	TP_ARGS(fpu)
 );
 
+DECLARE_EVENT_CLASS(x86_fpu_latency,
+	TP_PROTO(struct fpstate *fpstate, u64 dtsc),
+	TP_ARGS(fpstate, dtsc),
+
+	TP_STRUCT__entry(
+		__field(struct fpstate *, fpstate)
+		__field(u64, dtsc)
+		__field(u64, rfbm)
+		__field(u64, xinuse)
+	),
+
+	TP_fast_assign(
+		__entry->fpstate = fpstate;
+		__entry->dtsc = dtsc;
+		__entry->rfbm = fpstate->xfeatures;
+		__entry->xinuse = fpstate->regs.xsave.header.xfeatures;
+	),
+
+	TP_printk("x86/fpu: latency:%lld RFBM:0x%llx XINUSE:0x%llx",
+		__entry->dtsc,
+		__entry->rfbm,
+		__entry->xinuse
+	)
+);
+
+DEFINE_EVENT(x86_fpu_latency, x86_fpu_latency_xsave,
+	TP_PROTO(struct fpstate *fpstate, u64 dtsc),
+	TP_ARGS(fpstate, dtsc)
+);
+
+DEFINE_EVENT(x86_fpu_latency, x86_fpu_latency_xrstor,
+	TP_PROTO(struct fpstate *fpstate, u64 dtsc),
+	TP_ARGS(fpstate, dtsc)
+);
+
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH asm/trace/
 #undef TRACE_INCLUDE_FILE
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index d22ace092ca2..c5d294e5ee52 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -5,6 +5,9 @@
 #include <asm/cpufeature.h>
 #include <asm/fpu/xstate.h>
 #include <asm/fpu/xcr.h>
+#include <asm/trace/fpu.h>
+
+#include <linux/trace_clock.h>
 
 #ifdef CONFIG_X86_64
 DECLARE_PER_CPU(u64, xfd_state);
@@ -68,6 +71,20 @@ static inline u64 xfeatures_mask_independent(void)
 	return XFEATURE_MASK_INDEPENDENT;
 }
 
+static inline bool xsave_tracing_enabled(void)
+{
+	if (!IS_ENABLED(CONFIG_X86_DEBUG_FPU))
+		return false;
+	return tracepoint_enabled(x86_fpu_latency_xsave);
+}
+
+static inline bool xrstor_tracing_enabled(void)
+{
+	if (!IS_ENABLED(CONFIG_X86_DEBUG_FPU))
+		return false;
+	return tracepoint_enabled(x86_fpu_latency_xrstor);
+}
+
 /* XSAVE/XRSTOR wrapper functions */
 
 #ifdef CONFIG_X86_64
@@ -110,7 +127,7 @@ static inline u64 xfeatures_mask_independent(void)
  * original instruction which gets replaced. We need to use it here as the
  * address of the instruction where we might get an exception at.
  */
-#define XSTATE_XSAVE(st, lmask, hmask, err)				\
+#define __XSTATE_XSAVE(st, lmask, hmask, err)				\
 	asm volatile(ALTERNATIVE_2(XSAVE,				\
 				   XSAVEOPT, X86_FEATURE_XSAVEOPT,	\
 				   XSAVES,   X86_FEATURE_XSAVES)	\
@@ -122,11 +139,22 @@ static inline u64 xfeatures_mask_independent(void)
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
 
+#define XSTATE_XSAVE(fps, lmask, hmask, err)				\
+	do {								\
+		struct fpstate *f = fps;				\
+		u64 tc = -1;						\
+		if (xsave_tracing_enabled())				\
+			tc = trace_clock();				\
+		__XSTATE_XSAVE(&f->regs.xsave, lmask, hmask, err);	\
+		if (xsave_tracing_enabled())				\
+			trace_x86_fpu_latency_xsave(f, trace_clock() - tc);\
+	} while (0)
+
 /*
  * Use XRSTORS to restore context if it is enabled. XRSTORS supports compact
  * XSAVE area format.
  */
-#define XSTATE_XRESTORE(st, lmask, hmask)				\
+#define __XSTATE_XRESTORE(st, lmask, hmask)				\
 	asm volatile(ALTERNATIVE(XRSTOR,				\
 				 XRSTORS, X86_FEATURE_XSAVES)		\
 		     "\n"						\
@@ -136,6 +164,17 @@ static inline u64 xfeatures_mask_independent(void)
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
 
+#define XSTATE_XRESTORE(fps, lmask, hmask)				\
+	do {								\
+		struct fpstate *f = fps;				\
+		u64 tc = -1;						\
+		if (xrstor_tracing_enabled())				\
+			tc = trace_clock();				\
+		__XSTATE_XRESTORE(&f->regs.xsave, lmask, hmask);	\
+		if (xrstor_tracing_enabled())				\
+			trace_x86_fpu_latency_xrstor(f, trace_clock() - tc);\
+	} while (0)
+
 #if defined(CONFIG_X86_64) && defined(CONFIG_X86_DEBUG_FPU)
 extern void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor);
 #else
@@ -180,7 +219,7 @@ static inline void os_xsave(struct fpstate *fpstate)
 	WARN_ON_FPU(!alternatives_patched);
 	xfd_validate_state(fpstate, mask, false);
 
-	XSTATE_XSAVE(&fpstate->regs.xsave, lmask, hmask, err);
+	XSTATE_XSAVE(fpstate, lmask, hmask, err);
 
 	/* We should never fault when copying to a kernel buffer: */
 	WARN_ON_FPU(err);
@@ -197,7 +236,7 @@ static inline void os_xrstor(struct fpstate *fpstate, u64 mask)
 	u32 hmask = mask >> 32;
 
 	xfd_validate_state(fpstate, mask, true);
-	XSTATE_XRESTORE(&fpstate->regs.xsave, lmask, hmask);
+	XSTATE_XRESTORE(fpstate, lmask, hmask);
 }
 
 /* Restore of supervisor state. Does not require XFD */
@@ -207,7 +246,7 @@ static inline void os_xrstor_supervisor(struct fpstate *fpstate)
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 
-	XSTATE_XRESTORE(&fpstate->regs.xsave, lmask, hmask);
+	XSTATE_XRESTORE(fpstate, lmask, hmask);
 }
 
 /*
-- 
2.34.1

