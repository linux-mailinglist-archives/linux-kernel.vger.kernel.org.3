Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CB04DDCF2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbiCRPdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbiCRPcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:32:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88B5184631
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647617445; x=1679153445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MiHX6mAXe7Ut5goHg/MVZJZQy2HoE8tj7NOqZIWH6ss=;
  b=hRa7z0yuQBb3rfeS/cOx5ZnNwai6cZYgBm2zyHsrnbA8Ov6iBIRbU4Vw
   Lysj3LO/7DUoMwOwdTmMXNchHciLl4Oc4lG8ZbFkkd8qsA8OoF9dZ18OS
   8d0AspRhoQM4Cqqt1Qurrt67x5zSdsC/3kAKjttvIGZi88gWGKun2vnUZ
   oRJaJGBXDYfOGrrSXRTNLhuOV6u6ImTT/8wLuCpAIgiiT75sD9HOeAzxy
   SyVGTyLASX1hfOnDSSrLLlUmlfaOCH2ojjcdl9YL7HMwc9Af5VlTgaVnm
   EXhMONX08rB6LUlaY8s4OGfNcMGWCH8PCuu59k97UCGm7u48CEhmD8GNu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="320366506"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="320366506"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 08:30:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="599534226"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 18 Mar 2022 08:30:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E766A374; Fri, 18 Mar 2022 17:30:49 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCHv7 06/30] x86/traps: Refactor exc_general_protection()
Date:   Fri, 18 Mar 2022 18:30:24 +0300
Message-Id: <20220318153048.51177-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TDX brings a new exception -- Virtualization Exception (#VE). Handling
of #VE structurally very similar to handling #GP.

Extract two helpers from exc_general_protection() that can be reused for
handling #VE.

No functional changes.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/kernel/traps.c | 57 ++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 7ef00dee35be..bb02faf5a50c 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -611,13 +611,40 @@ static bool try_fixup_enqcmd_gp(void)
 #endif
 }
 
+static bool gp_try_fixup_and_notify(struct pt_regs *regs, int trapnr,
+				    unsigned long error_code, const char *str)
+{
+	if (fixup_exception(regs, trapnr, error_code, 0))
+		return true;
+
+	current->thread.error_code = error_code;
+	current->thread.trap_nr = trapnr;
+
+	/*
+	 * To be potentially processing a kprobe fault and to trust the result
+	 * from kprobe_running(), we have to be non-preemptible.
+	 */
+	if (!preemptible() && kprobe_running() &&
+	    kprobe_fault_handler(regs, trapnr))
+		return true;
+
+	return notify_die(DIE_GPF, str, regs, error_code, trapnr, SIGSEGV) == NOTIFY_STOP;
+}
+
+static void gp_user_force_sig_segv(struct pt_regs *regs, int trapnr,
+				   unsigned long error_code, const char *str)
+{
+	current->thread.error_code = error_code;
+	current->thread.trap_nr = trapnr;
+	show_signal(current, SIGSEGV, "", str, regs, error_code);
+	force_sig(SIGSEGV);
+}
+
 DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
 	enum kernel_gp_hint hint = GP_NO_HINT;
-	struct task_struct *tsk;
 	unsigned long gp_addr;
-	int ret;
 
 	if (user_mode(regs) && try_fixup_enqcmd_gp())
 		return;
@@ -636,40 +663,18 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		return;
 	}
 
-	tsk = current;
-
 	if (user_mode(regs)) {
 		if (fixup_iopl_exception(regs))
 			goto exit;
 
-		tsk->thread.error_code = error_code;
-		tsk->thread.trap_nr = X86_TRAP_GP;
-
 		if (fixup_vdso_exception(regs, X86_TRAP_GP, error_code, 0))
 			goto exit;
 
-		show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
-		force_sig(SIGSEGV);
+		gp_user_force_sig_segv(regs, X86_TRAP_GP, error_code, desc);
 		goto exit;
 	}
 
-	if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
-		goto exit;
-
-	tsk->thread.error_code = error_code;
-	tsk->thread.trap_nr = X86_TRAP_GP;
-
-	/*
-	 * To be potentially processing a kprobe fault and to trust the result
-	 * from kprobe_running(), we have to be non-preemptible.
-	 */
-	if (!preemptible() &&
-	    kprobe_running() &&
-	    kprobe_fault_handler(regs, X86_TRAP_GP))
-		goto exit;
-
-	ret = notify_die(DIE_GPF, desc, regs, error_code, X86_TRAP_GP, SIGSEGV);
-	if (ret == NOTIFY_STOP)
+	if (gp_try_fixup_and_notify(regs, X86_TRAP_GP, error_code, desc))
 		goto exit;
 
 	if (error_code)
-- 
2.34.1

