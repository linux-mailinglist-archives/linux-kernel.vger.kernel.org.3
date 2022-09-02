Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F615AB383
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbiIBO3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236799AbiIBO1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6950D168A0C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=klBRHEqDjEufBDz1HodoVZDCOLPcY0MzIEhSN35NGf8=; b=jauH8ValwyKlVKBNReLFguAuBv
        afxlG/tU7/ttnV6OE2ewYvzBbkHqQNHNeNuI4R3Act8qMFbbhDFtY2cTIQ7EP5qIb5VlvlmhLTWkU
        Gw3f339kLAJlqhrQ+5eGnFAqY4yj8sEWgFnMp0rFHTEwKEHTDuNU0qfq8Di3IPg7OYwTVPSKJddWt
        nM9XXnOoKE/4DBTxiP7kthkmKREayKds8YTtTrkQgZ6jEcKWPJ9xAIywtl2IC9KNQgqb55Vs9lKks
        oMmDlmxa/ShS9lgUmE/bhZxsQAuVhvGOIv2bpEuLFjEY6CNEnFyJ9703wmJVgnan0j7NDDuL2U3Rr
        bnyRQ9jA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77N-008g8N-1S; Fri, 02 Sep 2022 13:53:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 36B57302A31;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 371632B8EF7FE; Fri,  2 Sep 2022 15:53:53 +0200 (CEST)
Message-ID: <20220902130950.514617734@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:07:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 40/59] x86/retbleed: Add X86_FEATURE_CALL_DEPTH
References: <20220902130625.217071627@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Intel SKL CPUs fall back to other predictors when the RSB underflows. The
only microcode mitigation is IBRS which is insanely expensive. It comes
with performance drops of up to 30% depending on the workload.

A way less expensive, but nevertheless horrible mitigation is to track the
call depth in software and overeagerly fill the RSB when returns underflow
the software counter.

Provide a configuration symbol and a CPU misfeature bit.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig                         |   19 +++++++++++++++++++
 arch/x86/include/asm/cpufeatures.h       |    1 +
 arch/x86/include/asm/disabled-features.h |    9 ++++++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2501,6 +2501,25 @@ config CPU_UNRET_ENTRY
 	help
 	  Compile the kernel with support for the retbleed=unret mitigation.
 
+config CALL_DEPTH_TRACKING
+	bool "Mitigate RSB underflow with call depth tracking"
+	depends on CPU_SUP_INTEL && HAVE_CALL_THUNKS
+	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
+	select CALL_THUNKS
+	default y
+	help
+	  Compile the kernel with call depth tracking to mitigate the Intel
+	  SKL Return-Speculation-Buffer (RSB) underflow issue. The
+	  mitigation is off by default and needs to be enabled on the
+	  kernel command line via the retbleed=stuff option. For
+	  non-affected systems the overhead of this option is marginal as
+	  the call depth tracking is using run-time generated call thunks
+	  in a compiler generated padding area and call patching. This
+	  increases text size by ~5%. For non affected systems this space
+	  is unused. On affected SKL systems this results in a significant
+	  performance gain over the IBRS mitigation.
+
+
 config CPU_IBPB_ENTRY
 	bool "Enable IBPB on kernel entry"
 	depends on CPU_SUP_AMD && X86_64
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -304,6 +304,7 @@
 #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
+#define X86_FEATURE_CALL_DEPTH		(11*32+18) /* "" Call depth tracking for RSB stuffing */
 
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


