Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48A2578B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbiGRT4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbiGRTzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:55:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE90A2E9C5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:55:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658174149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yRkr9UwC+lB25qp1u1NCqDonwbQ2o0Jt76E3z+tWvPA=;
        b=f09p4gtaLpG4FJTDu8UImaW3T5lvYsjwh73p2TPlsd1YCV+1gfkWWcihSGL4PavoIsIxKg
        SpsAs1/viKR+QjjKopCqo4O1iQGVZv4PsRMtuUWuD7RVfmTBSagh/xtWV94i62Ime1al0F
        ebGD3URxoA4EcfTMAU1m7sccNExdcqitnEQ3ddWLnoxrFB7BC+6RJP0DfkGLkeoRJp2YpJ
        ai/etHkO14wAujhBh6G9lreaMuCjyOWZe+GX1MyCPO6qTAsaOZSCKPx4FClxW2+JVgottQ
        eIgTP5Ygk3BEVWb13vftU4wJOG0AzLfipcklBZG3Jx1f8xMNZFTiK/cbXZJH0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658174149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yRkr9UwC+lB25qp1u1NCqDonwbQ2o0Jt76E3z+tWvPA=;
        b=reZ5sePYWGOIBJcZuH+YP7KmX4FgiFHR5+AKd7AwfQzVj4NHjCpItpI03K+NJ+8HssZsJw
        otGjbRLvEnw4bsDg==
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
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
In-Reply-To: <20220716230344.239749011@linutronix.de>
References: <20220716230344.239749011@linutronix.de>
Date:   Mon, 18 Jul 2022 21:55:48 +0200
Message-ID: <87r12iurej.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17 2022 at 01:17, Thomas Gleixner wrote:
> For 4 RET pathes randomized with randomize_kstack_offset=y and RSP bit 3, 6, 5:
>
>           	  	IBRS       stuff	 stuff(pad)    confuse
>   microbench:	       	+37.20%	   +18.46%	 +15.47%       +7.46%	 
>   sockperf 14   bytes: 	-23.76%	   -19.26% 	 -14.31%      -16.80%
>   sockperf 1472 bytes: 	-22.51%	   -18.40% 	 -12.25%      -15.95%
>
> So for the more randomized variant sockperf tanks and is already slower
> than stuffing with thunks in the compiler provided padding space.
>
> I send out a patch in reply to this series which implements that variant,
> but there needs to be input from the security researchers how protective
> this is. If we could get away with 2 RET pathes (perhaps multiple instances
> with different bits), that would be amazing.

Here is goes.
---

Subject: x86/retbleed: Add confusion mitigation
From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 15 Jul 2022 11:41:05 +0200

- NOT FOR INCLUSION -

Experimental option to confuse the return path by randomization.

The following command line options enable this:

    retbleed=confuse  	   	   4 return pathes
    retbleed=confuse,4  	   4 return pathes
    retbleed=confuse,3 	   	   3 return pathes
    retbleed=confuse,2  	   2 return pathes

This need scrunity by security researchers.

Not-Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig                     |   12 ++++++
 arch/x86/include/asm/nospec-branch.h |   23 +++++++++++
 arch/x86/kernel/cpu/bugs.c           |   41 +++++++++++++++++++++
 arch/x86/lib/retpoline.S             |   68 +++++++++++++++++++++++++++++++++++
 include/linux/randomize_kstack.h     |    6 +++
 kernel/entry/common.c                |    3 +
 6 files changed, 153 insertions(+)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2538,6 +2538,18 @@ config CALL_THUNKS_DEBUG
 	  Only enable this, when you are debugging call thunks as this
 	  creates a noticable runtime overhead. If unsure say N.
 
+config RETURN_CONFUSION
+	bool "Mitigate RSB underflow with return confusion"
+	depends on CPU_SUP_INTEL && RETHUNK && RANDOMIZE_KSTACK_OFFSET
+	default y
+	help
+	  Compile the kernel with return path confusion to mitigate the
+	  Intel SKL Return-Speculation-Buffer (RSB) underflow issue. The
+	  mitigation is off by default and needs to be enabled on the
+	  kernel command line via the retbleed=confuse option. For
+	  non-affected systems the overhead of this option is marginal as
+	  the return thunk jumps are patched to direct ret instructions.
+
 config CPU_IBPB_ENTRY
 	bool "Enable IBPB on kernel entry"
 	depends on CPU_SUP_AMD
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -312,6 +312,29 @@ static inline void x86_set_skl_return_th
 
 #endif
 
+#ifdef CONFIG_RETURN_CONFUSION
+extern void __x86_return_confused_skl2(void);
+extern void __x86_return_confused_skl3(void);
+extern void __x86_return_confused_skl4(void);
+
+static inline void x86_set_skl_confused_return_thunk(int which)
+{
+	switch (which) {
+	case 2:
+		x86_return_thunk = &__x86_return_confused_skl2;
+		break;
+	case 3:
+		x86_return_thunk = &__x86_return_confused_skl3;
+		break;
+	case 4:
+		x86_return_thunk = &__x86_return_confused_skl4;
+		break;
+	}
+}
+#else
+static inline void x86_set_skl_confused_return_thunk(void) { }
+#endif
+
 #ifdef CONFIG_RETPOLINE
 
 #define GEN(reg) \
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/nospec.h>
 #include <linux/prctl.h>
+#include <linux/randomize_kstack.h>
 #include <linux/sched/smt.h>
 #include <linux/pgtable.h>
 #include <linux/bpf.h>
@@ -785,6 +786,7 @@ enum retbleed_mitigation {
 	RETBLEED_MITIGATION_IBRS,
 	RETBLEED_MITIGATION_EIBRS,
 	RETBLEED_MITIGATION_STUFF,
+	RETBLEED_MITIGATION_CONFUSE,
 };
 
 enum retbleed_mitigation_cmd {
@@ -793,6 +795,7 @@ enum retbleed_mitigation_cmd {
 	RETBLEED_CMD_UNRET,
 	RETBLEED_CMD_IBPB,
 	RETBLEED_CMD_STUFF,
+	RETBLEED_CMD_CONFUSE,
 };
 
 const char * const retbleed_strings[] = {
@@ -802,6 +805,7 @@ const char * const retbleed_strings[] =
 	[RETBLEED_MITIGATION_IBRS]	= "Mitigation: IBRS",
 	[RETBLEED_MITIGATION_EIBRS]	= "Mitigation: Enhanced IBRS",
 	[RETBLEED_MITIGATION_STUFF]	= "Mitigation: Stuffing",
+	[RETBLEED_MITIGATION_CONFUSE]	= "Mitigation: Return confusion",
 };
 
 static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
@@ -810,6 +814,7 @@ static enum retbleed_mitigation_cmd retb
 	RETBLEED_CMD_AUTO;
 
 static int __ro_after_init retbleed_nosmt = false;
+static int __ro_after_init rethunk_confuse_skl = 4;
 
 static int __init retbleed_parse_cmdline(char *str)
 {
@@ -833,8 +838,19 @@ static int __init retbleed_parse_cmdline
 			retbleed_cmd = RETBLEED_CMD_IBPB;
 		} else if (!strcmp(str, "stuff")) {
 			retbleed_cmd = RETBLEED_CMD_STUFF;
+		} else if (!strcmp(str, "confuse")) {
+			retbleed_cmd = RETBLEED_CMD_CONFUSE;
 		} else if (!strcmp(str, "nosmt")) {
 			retbleed_nosmt = true;
+		} else if (retbleed_cmd == RETBLEED_CMD_CONFUSE &&
+			   !kstrtouint(str, 10, &rethunk_confuse_skl)) {
+
+			if (rethunk_confuse_skl < 2 ||
+			    rethunk_confuse_skl > 4) {
+				pr_err("Ignoring out-of-bound stuff count (%d).",
+				       rethunk_confuse_skl);
+				rethunk_confuse_skl = 4;
+			}
 		} else {
 			pr_err("Ignoring unknown retbleed option (%s).", str);
 		}
@@ -896,6 +912,25 @@ static void __init retbleed_select_mitig
 		}
 		break;
 
+	case RETBLEED_CMD_CONFUSE:
+		if (IS_ENABLED(CONFIG_RETURN_CONFUSION) &&
+		    spectre_v2_enabled == SPECTRE_V2_RETPOLINE &&
+		    random_kstack_offset_enabled()) {
+			retbleed_mitigation = RETBLEED_MITIGATION_CONFUSE;
+		} else {
+			if (IS_ENABLED(CONFIG_RETURN_CONFUSION) &&
+			    random_kstack_offset_enabled())
+				pr_err("WARNING: retbleed=confuse depends on randomize_kstack_offset=y\n");
+			else if (IS_ENABLED(CONFIG_RETURN_CONFUSION) &&
+				 spectre_v2_enabled != SPECTRE_V2_RETPOLINE)
+				pr_err("WARNING: retbleed=confuse depends on spectre_v2=retpoline\n");
+			else
+				pr_err("WARNING: kernel not compiled with RETURN_CONFUSION.\n");
+
+			goto do_cmd_auto;
+		}
+		break;
+
 do_cmd_auto:
 	case RETBLEED_CMD_AUTO:
 	default:
@@ -939,6 +974,11 @@ static void __init retbleed_select_mitig
 		x86_set_skl_return_thunk();
 		break;
 
+	case RETBLEED_MITIGATION_CONFUSE:
+		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
+		x86_set_skl_confused_return_thunk(rethunk_confuse_skl);
+		break;
+
 	default:
 		break;
 	}
@@ -1389,6 +1429,7 @@ static void __init spectre_v2_select_mit
 		    boot_cpu_has_bug(X86_BUG_RETBLEED) &&
 		    retbleed_cmd != RETBLEED_CMD_OFF &&
 		    retbleed_cmd != RETBLEED_CMD_STUFF &&
+		    retbleed_cmd != RETBLEED_CMD_CONFUSE &&
 		    boot_cpu_has(X86_FEATURE_IBRS) &&
 		    boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
 			mode = SPECTRE_V2_IBRS;
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -230,3 +230,71 @@ SYM_FUNC_START(__x86_return_skl)
 SYM_FUNC_END(__x86_return_skl)
 
 #endif /* CONFIG_CALL_DEPTH_TRACKING */
+
+#ifdef CONFIG_RETURN_CONFUSION
+	.align 64
+SYM_FUNC_START(__x86_return_confused_skl4)
+	ANNOTATE_NOENDBR
+	testq	$3, %rsp
+	jz	1f
+
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+1:
+	testq	$6, %rsp
+	jz	2f
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+2:
+	testq	$5, %rsp
+	jz	3f
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+3:
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+SYM_FUNC_END(__x86_return_confused_skl4)
+
+	.align 64
+SYM_FUNC_START(__x86_return_confused_skl3)
+	ANNOTATE_NOENDBR
+	testq	$3, %rsp
+	jz	1f
+
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+1:
+	testq	$6, %rsp
+	jz	2f
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+
+2:
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+SYM_FUNC_END(__x86_return_confused_skl3)
+
+	.align 64
+SYM_FUNC_START(__x86_return_confused_skl2)
+	ANNOTATE_NOENDBR
+	testq	$3, %rsp
+	jz	1f
+
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+1:
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+SYM_FUNC_END(__x86_return_confused_skl2)
+
+#endif /* CONFIG_RETURN_CONFUSION */
--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -84,9 +84,15 @@ DECLARE_PER_CPU(u32, kstack_offset);
 		raw_cpu_write(kstack_offset, offset);			\
 	}								\
 } while (0)
+
+#define random_kstack_offset_enabled()					\
+	static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
+				&randomize_kstack_offset)
+
 #else /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
 #define add_random_kstack_offset()		do { } while (0)
 #define choose_random_kstack_offset(rand)	do { } while (0)
+#define random_kstack_offset_enabled()		false
 #endif /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
 
 #endif
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -298,6 +298,7 @@ void syscall_exit_to_user_mode_work(stru
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 {
+	add_random_kstack_offset();
 	__enter_from_user_mode(regs);
 }
 
@@ -444,6 +445,8 @@ irqentry_state_t noinstr irqentry_nmi_en
 {
 	irqentry_state_t irq_state;
 
+	if (user_mode(regs))
+		add_random_kstack_offset();
 	irq_state.lockdep = lockdep_hardirqs_enabled();
 
 	__nmi_enter();
