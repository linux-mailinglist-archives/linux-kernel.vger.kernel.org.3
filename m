Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E064CA806
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242971AbiCBO3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242946AbiCBO25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:28:57 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5186634BB8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646231288; x=1677767288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QLnCzUeJtYo9oJ+vYtjXG6GkXRsExBKMsty2nQQ4Gik=;
  b=byVmaV5z4nFGmURbnmzRqXk0sgcGp4wNyxU/nNuKHcA5A3pLQcop9G+V
   JBiQ0RG90Xhtzr2PklaQSRuTr6wAkFIqvpdO29zOHTBaAdj2DBV1wre52
   8DP1YJsSf3HJhgZ4yi2ej2W6pV7JQw7BkbxUUnn1vSmLm4TaLoo5RTXMk
   lN3/LWYwvbWnqWKO6Wke5nibclm+lbCPPx42gigBVRCxbP9haYF1PHeQY
   A5aPRgDIirSDre8do0j6114Sf7VoOqCsX7LQD8JmYVBl8l+gS81KGphqV
   IwC6solzzQq4RrBIGUDPQtMuETK8ayDwNG0IDkcTBPlE0b3Xkv923eJOl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="240824337"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="240824337"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 06:28:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="551270221"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 02 Mar 2022 06:28:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 14505284; Wed,  2 Mar 2022 16:28:12 +0200 (EET)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 06/30] x86/traps: Refactor exc_general_protection()
Date:   Wed,  2 Mar 2022 17:27:42 +0300
Message-Id: <20220302142806.51844-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/traps.c | 57 ++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 7ef00dee35be..733b6490523c 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -611,13 +611,43 @@ static bool try_fixup_enqcmd_gp(void)
 #endif
 }
 
+static bool gp_try_fixup_and_notify(struct pt_regs *regs, int trapnr,
+				    unsigned long error_code, const char *str)
+{
+	int ret;
+
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
+	ret = notify_die(DIE_GPF, str, regs, error_code, trapnr, SIGSEGV);
+	return ret == NOTIFY_STOP;
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
@@ -636,40 +666,21 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
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
 
 	if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
 		goto exit;
 
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

