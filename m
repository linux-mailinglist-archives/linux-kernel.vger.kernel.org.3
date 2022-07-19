Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6682157A760
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbiGSTpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGSTpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:45:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EA410561;
        Tue, 19 Jul 2022 12:45:52 -0700 (PDT)
Date:   Tue, 19 Jul 2022 19:45:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658259950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v86lNOMXT+qnBXt4ajD1CLg52zHOaF9md9zyGeIe9XM=;
        b=VsMhWq3Ps6EBfbjPi/II8R9e70pXWfVMZDHcjsI32G2MbTaN7acmkvWPqu/jOKNyqiu2e5
        ovqLIDYq2JuLZfLB0GPKgoZUGzc16CYiJ7cSl+grbQmEcMkZ32Q7lnagdvhwmQ0Aa5G3lO
        gNGX+yviHXtvPokaGE9UZjpWXuGU6Npf/60ZI/2whHvHCXmcFcql6b04GQXlWPldN/YFAA
        g2k9dfrrsteLAKqAkb04IX9aB+uFYOLJcW5PQJ7K+ulrHWa/JdaCq5iq2qQFkfqMVRFgDW
        +W1oP+D3dTUxYLcnV5EJ5aKvgOkOnDAAdXTaJKayaYZGHqXvXLC/ogxfptjUhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658259950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v86lNOMXT+qnBXt4ajD1CLg52zHOaF9md9zyGeIe9XM=;
        b=v6bdQY1mm8uzs2KNegYj1FGnR86ogeR6F1rmqQQY8awU6p5tK8/StgwVCcfgcpV/0zBhzF
        U5M3g2HTU+yxKkCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/amd: Use IBPB for firmware calls
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220715194550.793957-1-cascardo@canonical.com>
References: <20220715194550.793957-1-cascardo@canonical.com>
MIME-Version: 1.0
Message-ID: <165825994959.15455.8862315853452355619.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     28a99e95f55c61855983d36a88c05c178d966bb7
Gitweb:        https://git.kernel.org/tip/28a99e95f55c61855983d36a88c05c178d966bb7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 18 Jul 2022 13:41:37 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 18 Jul 2022 15:38:09 +02:00

x86/amd: Use IBPB for firmware calls

On AMD IBRS does not prevent Retbleed; as such use IBPB before a
firmware call to flush the branch history state.

And because in order to do an EFI call, the kernel maps a whole lot of
the kernel page table into the EFI page table, do an IBPB just in case
in order to prevent the scenario of poisoning the BTB and causing an EFI
call using the unprotected RET there.

  [ bp: Massage. ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220715194550.793957-1-cascardo@canonical.com
---
 arch/x86/include/asm/cpufeatures.h   |  1 +
 arch/x86/include/asm/nospec-branch.h |  2 ++
 arch/x86/kernel/cpu/bugs.c           | 11 ++++++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 00f5227..a77b915 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -302,6 +302,7 @@
 #define X86_FEATURE_RETPOLINE_LFENCE	(11*32+13) /* "" Use LFENCE for Spectre variant 2 */
 #define X86_FEATURE_RETHUNK		(11*32+14) /* "" Use REturn THUNK */
 #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */
+#define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 10a3bfc..38a3e86 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -297,6 +297,8 @@ do {									\
 	alternative_msr_write(MSR_IA32_SPEC_CTRL,			\
 			      spec_ctrl_current() | SPEC_CTRL_IBRS,	\
 			      X86_FEATURE_USE_IBRS_FW);			\
+	alternative_msr_write(MSR_IA32_PRED_CMD, PRED_CMD_IBPB,		\
+			      X86_FEATURE_USE_IBPB_FW);			\
 } while (0)
 
 #define firmware_restrict_branch_speculation_end()			\
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index aa34f90..78c9082 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1516,7 +1516,16 @@ static void __init spectre_v2_select_mitigation(void)
 	 * the CPU supports Enhanced IBRS, kernel might un-intentionally not
 	 * enable IBRS around firmware calls.
 	 */
-	if (boot_cpu_has(X86_FEATURE_IBRS) && !spectre_v2_in_ibrs_mode(mode)) {
+	if (boot_cpu_has_bug(X86_BUG_RETBLEED) &&
+	    (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	     boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)) {
+
+		if (retbleed_cmd != RETBLEED_CMD_IBPB) {
+			setup_force_cpu_cap(X86_FEATURE_USE_IBPB_FW);
+			pr_info("Enabling Speculation Barrier for firmware calls\n");
+		}
+
+	} else if (boot_cpu_has(X86_FEATURE_IBRS) && !spectre_v2_in_ibrs_mode(mode)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
 		pr_info("Enabling Restricted Speculation for firmware calls\n");
 	}
