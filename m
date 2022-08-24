Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5C459FFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbiHXQnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239087AbiHXQn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:43:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549271AF36;
        Wed, 24 Aug 2022 09:43:24 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9859329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9859:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED6861EC06C1;
        Wed, 24 Aug 2022 18:43:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661359399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gGxXDwbKEJ0yko3Vb9vrS3rjtdtk6tHV0mhI9adXULo=;
        b=CcbQXShNX9wumDLPtpetSXFC5InAy7LlherUDUSrIX8ak3G4pCbWEu0HcOShG2J2PNMb0i
        b6uHXUhxY7laybG3Iojr6qyRdqYgVtvV3JIODBqsqdR/D1d+fgTeSGEo5Gp+uaJPwDAt58
        Q0ewBx6MuAYN0GAK4cGByjk5G2SF1yM=
Date:   Wed, 24 Aug 2022 18:43:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, Michael Matz <matz@suse.de>,
        linux-toolchains@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2] x86/sev: Mark snp_abort() noreturn
Message-ID: <YwZVIgjM5CR0taHN@zn.tnic>
References: <20220824152420.20547-1-bp@alien8.de>
 <YwZF8pvWHqFYQOVB@worktop.programming.kicks-ass.net>
 <YwZIaJIr4Zmpaams@zn.tnic>
 <YwZO4iYumjhxv73h@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwZO4iYumjhxv73h@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 06:16:34PM +0200, Peter Zijlstra wrote:
> If only there would be a trace of it left in the ELF file...

Ah, there's that.

---
From: Borislav Petkov <bp@suse.de>

Mark both the function prototype and definition as noreturn in order to
prevent the compiler from doing transformations which confuse objtool
like so:

  vmlinux.o: warning: objtool: sme_enable+0x71: unreachable instruction

This triggers with gcc-12.

Add it and sev_es_terminate() to the objtool noreturn tracking array
too. Sort it while at it.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/sev.h |  2 +-
 arch/x86/kernel/sev.c      |  2 +-
 tools/objtool/check.c      | 34 ++++++++++++++++++----------------
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 4a23e52fe0ee..ebc271bb6d8e 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -195,7 +195,7 @@ void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
-void snp_abort(void);
+void __init __noreturn snp_abort(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 4f84c3f11af5..a428c62330d3 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2112,7 +2112,7 @@ bool __init snp_init(struct boot_params *bp)
 	return true;
 }
 
-void __init snp_abort(void)
+void __init __noreturn snp_abort(void)
 {
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0cec74da7ffe..ad51689dfb41 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -162,32 +162,34 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 
 	/*
 	 * Unfortunately these have to be hard coded because the noreturn
-	 * attribute isn't provided in ELF data.
+	 * attribute isn't provided in ELF data. Keep 'em sorted.
 	 */
 	static const char * const global_noreturns[] = {
+		"__invalid_creds",
+		"__module_put_and_kthread_exit",
+		"__reiserfs_panic",
 		"__stack_chk_fail",
-		"panic",
+		"__ubsan_handle_builtin_unreachable",
+		"cpu_bringup_and_idle",
+		"cpu_startup_entry",
 		"do_exit",
+		"do_group_exit",
 		"do_task_dead",
-		"kthread_exit",
-		"make_task_dead",
-		"__module_put_and_kthread_exit",
+		"ex_handler_msr_mce",
+		"fortify_panic",
 		"kthread_complete_and_exit",
-		"__reiserfs_panic",
+		"kthread_exit",
+		"kunit_try_catch_throw",
 		"lbug_with_loc",
-		"fortify_panic",
-		"usercopy_abort",
 		"machine_real_restart",
+		"make_task_dead",
+		"panic",
 		"rewind_stack_and_make_dead",
-		"kunit_try_catch_throw",
-		"xen_start_kernel",
-		"cpu_bringup_and_idle",
-		"do_group_exit",
+		"sev_es_terminate",
+		"snp_abort",
 		"stop_this_cpu",
-		"__invalid_creds",
-		"cpu_startup_entry",
-		"__ubsan_handle_builtin_unreachable",
-		"ex_handler_msr_mce",
+		"usercopy_abort",
+		"xen_start_kernel",
 	};
 
 	if (!func)
-- 
2.35.1



-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
