Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC13F584E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbiG2J4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiG2J4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:56:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30B039B88
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659088573; x=1690624573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ig/bFrcmXsae31Urb9bDMuHxR6Wq30Ca+Z2ThxZn9uM=;
  b=I1OIbtiHnowOJ2oS7gt1p5441PLQS2xwNtr8JOePtY0Vqy4g34XFgWUd
   eJqJbF3JrypFx5p+ooAghzawzrPqsDdMCPf+wSCHUmtUw5x0JfWdXEwt1
   PuPNgMBEdfYfPa+WX5kxzpH58KXVDc3lJsk8L5byK7519FVasYESWSWQr
   0tcyFOhlQw5kCIS/Irr0rJXoxOpUxgOX2/0VPA16tEy1PrYNoEywg7Mzq
   hIT9UZaVWOjhKyZle1MZtQDjuyL7d+D3oHG/2AUcYTrpyeKeLzflIWQUF
   87CkSMxyATyFXAdKwfag4z12Fb1jq4IoV8AdNLYuSnoyax9h8yfACZNGE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="375036998"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="375036998"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 02:56:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="629315490"
Received: from sunyi-station.sh.intel.com (HELO sunyi-station..) ([10.239.159.10])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2022 02:56:11 -0700
From:   Yi Sun <yi.sun@intel.com>
To:     dave.hansen@intel.com, sohil.mehta@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        david.laight@aculab.com
Cc:     heng.su@intel.com, yi.sun@intel.com
Subject: [PATCH v2 1/2] x86/fpu: Measure the Latency of XSAVE and XRSTOR
Date:   Fri, 29 Jul 2022 17:56:07 +0800
Message-Id: <20220729095608.1475138-2-yi.sun@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220729095608.1475138-1-yi.sun@intel.com>
References: <20220729095608.1475138-1-yi.sun@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two trace points x86_fpu_latency_xsave and x86_fpu_latency_xrstor.
The latency dumped by the new trace points can tell when XSAVE/XRSTOR
are getting more or less expensive, and get out the RFBM
(requested-feature bitmap) and XINUSE to figure out the reason.

Calculate the latency of instructions XSAVE and XRSTOR within a
single trace event respectively. Another option considered was to
have 2 separated trace events marking the start and finish of the
XSAVE/XRSTOR. The latency was calculated from the 2 trace points in
user space, but there was significant overhead added by the trace
function itself.

In internal testing, the single trace point option which is
implemented here proved to save big overhead introduced by trace
function.

Make use of trace_clock() to calculate the latency, which is based on
cpu_clock() with precision at most ~1 jiffy between CPUs.

CONFIG_X86_DEBUG_FPU and CONFIG_TRACEPOINTS are required. And the
compiler will get rid of all the extra crust when either of the two
configs is disabled.

If both of the configs are enabled, xsave/xrstor_tracing_enabled
would be reduced to a static check for tracing enabled. Thus, in the
fast path there would be only 2 additional static checks.

Since trace points can be enabled dynamically, while the code is
checking tracepoint_enabled(trace_event), the trace_event could be
concurrently enabled. Hence there is probability to get single once
noisy result 'trace_clock() - (-1)' at the moment enabling the trace
points x86_fpu_latency_*. Leave the noise here instead of additional
conditions while calling the x86_fpu_latency_* because it's not worth
for the only once noise. It's easy to filter out by the following
consuming script or other user space tool.

Trace log looks like following:
  x86_fpu_latency_xsave: x86/fpu: latency:100 RFBM:0x202e7 XINUSE:0x202
  x86_fpu_latency_xrstor: x86/fpu: latency:99 RFBM:0x202e7 XINUSE:0x202

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yi Sun <yi.sun@intel.com>

diff --git a/arch/x86/include/asm/trace/fpu.h b/arch/x86/include/asm/trace/fpu.h
index 4645a6334063..5f7cb633df09 100644
--- a/arch/x86/include/asm/trace/fpu.h
+++ b/arch/x86/include/asm/trace/fpu.h
@@ -89,6 +89,41 @@ DEFINE_EVENT(x86_fpu, x86_fpu_xstate_check_failed,
 	TP_ARGS(fpu)
 );
 
+DECLARE_EVENT_CLASS(x86_fpu_latency,
+	TP_PROTO(struct fpstate *fpstate, u64 latency),
+	TP_ARGS(fpstate, latency),
+
+	TP_STRUCT__entry(
+		__field(struct fpstate *, fpstate)
+		__field(u64, latency)
+		__field(u64, rfbm)
+		__field(u64, xinuse)
+	),
+
+	TP_fast_assign(
+		__entry->fpstate = fpstate;
+		__entry->latency = latency;
+		__entry->rfbm = fpstate->xfeatures;
+		__entry->xinuse = fpstate->regs.xsave.header.xfeatures;
+	),
+
+	TP_printk("x86/fpu: latency:%lld RFBM:0x%llx XINUSE:0x%llx",
+		__entry->latency,
+		__entry->rfbm,
+		__entry->xinuse
+	)
+);
+
+DEFINE_EVENT(x86_fpu_latency, x86_fpu_latency_xsave,
+	TP_PROTO(struct fpstate *fpstate, u64 latency),
+	TP_ARGS(fpstate, latency)
+);
+
+DEFINE_EVENT(x86_fpu_latency, x86_fpu_latency_xrstor,
+	TP_PROTO(struct fpstate *fpstate, u64 latency),
+	TP_ARGS(fpstate, latency)
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

