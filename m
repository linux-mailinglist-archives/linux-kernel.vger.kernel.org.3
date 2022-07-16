Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9BB577271
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbiGPXSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbiGPXRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:17:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEBA222B6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:37 -0700 (PDT)
Message-ID: <20220716230953.558921214@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=38u937fwI+dedrnZIykHKHbxdYzLzIUKpcUX1dAfXdw=;
        b=z1m9Uz3ZPv3XGE2Kk3qMGigHQ181tfTp2tUkxLDVCbvdScqcqFpz0YjDpoUAXOWqZNv3xH
        KfUDwXf4Zf8s8tGQYAFZqPRaPTFCcsxAH8V3gih2u7AJHgsMRt0Prt/7WaisvbpG9upIK4
        XNNxDxx39Q6AhI0DSE/Ea9gOAul4u4/P+tbc0mVgbeYtZjY4G+V624w0j5r45NTbwLNMo6
        T6NzRKZtIenozgHnsxmx1EmFv2a3F9ZMTSytroy/XlT8nnHpysu8kbVsyGIgClG51RaaFh
        tYeuI18ip1a8FqWIEAm7DkHzzlwCuFg+xnzakpvNpkdJrVOaa2CGAVAUftKzAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=38u937fwI+dedrnZIykHKHbxdYzLzIUKpcUX1dAfXdw=;
        b=lYfKPWqq4rcPPTgJ0f25hz/DFP5uvORIW8N12pn5I9dGQHSLWoczbHolBGXEJSzLnVJ3L4
        81ygoox59GWTmDDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 15/38] x86/retbleed: Add X86_FEATURE_CALL_DEPTH
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:34 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel SKL CPUs fall back to other predictors when the RSB underflows. The
only microcode mitigation is IBRS which is insanely expensive. It comes
with performance drops of up to 30% depending on the workload.

A way less expensive, but nevertheless horrible mitigation is to track the
call depth in software and overeagerly fill the RSB when returns underflow
the software counter.

Provide a configuration symbol and a CPU misfeature bit.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig                         |   13 +++++++++++++
 arch/x86/include/asm/cpufeatures.h       |    1 +
 arch/x86/include/asm/disabled-features.h |    9 ++++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2498,6 +2498,19 @@ config CPU_UNRET_ENTRY
 	help
 	  Compile the kernel with support for the retbleed=unret mitigation.
 
+config CALL_DEPTH_TRACKING
+	bool "Mitigate RSB underflow with call depth tracking"
+	depends on CPU_SUP_INTEL && HAVE_CALL_THUNKS
+	select CALL_THUNKS
+	default y
+	help
+	  Compile the kernel with call depth tracking to mitigate the Intel
+	  SKL Return-Speculation-Buffer (RSB) underflow issue. The mitigation
+	  is off by default and needs to be enabled on the kernel command line
+	  via the retbleed=stuff option. For non-affected systems the overhead
+	  of this option is marginal as the call depth tracking is using
+	  run-time generated call thunks and call patching.
+
 config CPU_IBPB_ENTRY
 	bool "Enable IBPB on kernel entry"
 	depends on CPU_SUP_AMD
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -302,6 +302,7 @@
 #define X86_FEATURE_RETPOLINE_LFENCE	(11*32+13) /* "" Use LFENCE for Spectre variant 2 */
 #define X86_FEATURE_RETHUNK		(11*32+14) /* "" Use REturn THUNK */
 #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */
+#define X86_FEATURE_CALL_DEPTH		(11*32+16) /* "" Call depth tracking for RSB stuffing */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -69,6 +69,12 @@
 # define DISABLE_UNRET		(1 << (X86_FEATURE_UNRET & 31))
 #endif
 
+#ifdef CONFIG_CALL_DEPTH_TRACKING
+# define DISABLE_CALL_DEPTH_TRACKING	0
+#else
+# define DISABLE_CALL_DEPTH_TRACKING	(1 << (X86_FEATURE_CALL_DEPTH & 31))
+#endif
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 # define DISABLE_ENQCMD		0
 #else
@@ -101,7 +107,8 @@
 #define DISABLED_MASK8	(DISABLE_TDX_GUEST)
 #define DISABLED_MASK9	(DISABLE_SGX)
 #define DISABLED_MASK10	0
-#define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET)
+#define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
+			 DISABLE_CALL_DEPTH_TRACKING)
 #define DISABLED_MASK12	0
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0

