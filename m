Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF8B577265
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiGPXUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbiGPXTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:19:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AAF25585
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:18:21 -0700 (PDT)
Message-ID: <20220716230954.957997370@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LlS7WcBzrKcFWrbZQU5y98/DeyvCwTJOWzMBgWM/naQ=;
        b=2hfUTazQRr066bAX5raUP9gbSJmxMwdj7QKWxfZAuqgqZCxohzxSVqI2IICyuiW0NGQgeN
        v6+gydnZcWlmVWA6B+Bpzz3Oy9cj0YSDIt9NEskcXBwb/mpEVfpDmRcqWZfTJn4VoHP3E5
        TFTk/6SjxpGf6vrkbx3ZhOrqzfQpHYr9gZhH1Masy8dirFHRvdfYzgzMcQoC2bnODxzQ+Y
        6Fz2OaD+gdqDTlnAYXxSFW0ENqsEtbyhJr1KE0KKhGV0PnXeunOvnX5nfIw1UlXmUxCysO
        HKm1Fmpe6CsdgJB4m/E5rQbfl9PZn4iY2uccN/tISljhmjzbKVAZ4vEvYZhM7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LlS7WcBzrKcFWrbZQU5y98/DeyvCwTJOWzMBgWM/naQ=;
        b=cmTN5WRV36zThjlAigj/rQupHTAWHCf31mQk9irjEnTBZqFHWnR3Q1YuiN7jgLPfhz0gYD
        Mx5nC5IxuV5uG0BA==
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
Subject: [patch 38/38] x86/retbleed: Add call depth tracking mitigation
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:18:11 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fully secure mitigation for RSB underflow on Intel SKL CPUs is IBRS,
which inflicts up to 30% penalty for pathological syscall heavy work loads.

Software based call depth tracking and RSB refill is not perfect, but
reduces the attack surface massively. The penalty for the pathological case
is about 8% which is still annoying but definitely more palatable than IBRS.

Add a retbleed=stuff command line option to enable the call depth tracking
and software refill of the RSB.

This gives admins a choice. IBeeRS are safe and cause headaches, call depth
tracking is considered to be s(t)ufficiently safe.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/bugs.c |   32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -784,6 +784,7 @@ enum retbleed_mitigation {
 	RETBLEED_MITIGATION_IBPB,
 	RETBLEED_MITIGATION_IBRS,
 	RETBLEED_MITIGATION_EIBRS,
+	RETBLEED_MITIGATION_STUFF,
 };
 
 enum retbleed_mitigation_cmd {
@@ -791,6 +792,7 @@ enum retbleed_mitigation_cmd {
 	RETBLEED_CMD_AUTO,
 	RETBLEED_CMD_UNRET,
 	RETBLEED_CMD_IBPB,
+	RETBLEED_CMD_STUFF,
 };
 
 const char * const retbleed_strings[] = {
@@ -799,6 +801,7 @@ const char * const retbleed_strings[] =
 	[RETBLEED_MITIGATION_IBPB]	= "Mitigation: IBPB",
 	[RETBLEED_MITIGATION_IBRS]	= "Mitigation: IBRS",
 	[RETBLEED_MITIGATION_EIBRS]	= "Mitigation: Enhanced IBRS",
+	[RETBLEED_MITIGATION_STUFF]	= "Mitigation: Stuffing",
 };
 
 static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
@@ -828,6 +831,8 @@ static int __init retbleed_parse_cmdline
 			retbleed_cmd = RETBLEED_CMD_UNRET;
 		} else if (!strcmp(str, "ibpb")) {
 			retbleed_cmd = RETBLEED_CMD_IBPB;
+		} else if (!strcmp(str, "stuff")) {
+			retbleed_cmd = RETBLEED_CMD_STUFF;
 		} else if (!strcmp(str, "nosmt")) {
 			retbleed_nosmt = true;
 		} else {
@@ -876,6 +881,21 @@ static void __init retbleed_select_mitig
 		}
 		break;
 
+	case RETBLEED_CMD_STUFF:
+		if (IS_ENABLED(CONFIG_CALL_DEPTH_TRACKING) &&
+		    spectre_v2_enabled == SPECTRE_V2_RETPOLINE) {
+			retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
+
+		} else {
+			if (IS_ENABLED(CONFIG_CALL_DEPTH_TRACKING))
+				pr_err("WARNING: retbleed=stuff depends on spectre_v2=retpoline\n");
+			else
+				pr_err("WARNING: kernel not compiled with CALL_DEPTH_TRACKING.\n");
+
+			goto do_cmd_auto;
+		}
+		break;
+
 do_cmd_auto:
 	case RETBLEED_CMD_AUTO:
 	default:
@@ -913,6 +933,12 @@ static void __init retbleed_select_mitig
 		mitigate_smt = true;
 		break;
 
+	case RETBLEED_MITIGATION_STUFF:
+		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
+		setup_force_cpu_cap(X86_FEATURE_CALL_DEPTH);
+		x86_set_skl_return_thunk();
+		break;
+
 	default:
 		break;
 	}
@@ -923,7 +949,7 @@ static void __init retbleed_select_mitig
 
 	/*
 	 * Let IBRS trump all on Intel without affecting the effects of the
-	 * retbleed= cmdline option.
+	 * retbleed= cmdline option except for call depth based stuffing
 	 */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
 		switch (spectre_v2_enabled) {
@@ -936,7 +962,8 @@ static void __init retbleed_select_mitig
 			retbleed_mitigation = RETBLEED_MITIGATION_EIBRS;
 			break;
 		default:
-			pr_err(RETBLEED_INTEL_MSG);
+			if (retbleed_mitigation != RETBLEED_MITIGATION_STUFF)
+				pr_err(RETBLEED_INTEL_MSG);
 		}
 	}
 
@@ -1361,6 +1388,7 @@ static void __init spectre_v2_select_mit
 		if (IS_ENABLED(CONFIG_CPU_IBRS_ENTRY) &&
 		    boot_cpu_has_bug(X86_BUG_RETBLEED) &&
 		    retbleed_cmd != RETBLEED_CMD_OFF &&
+		    retbleed_cmd != RETBLEED_CMD_STUFF &&
 		    boot_cpu_has(X86_FEATURE_IBRS) &&
 		    boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
 			mode = SPECTRE_V2_IBRS;

