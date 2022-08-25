Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7685A12E0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241700AbiHYOBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiHYOBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:01:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE6B19033;
        Thu, 25 Aug 2022 07:01:29 -0700 (PDT)
Date:   Thu, 25 Aug 2022 14:01:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661436087;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eovjzwcvdUvFZ3zDujG/9uL0DmNL5HqE1TDIBYenQdA=;
        b=LNNve4U0Ylh8kd8hsdJ8UfhoXgqZYq4VJ5PgovVWZKPiLgQsGJo1Raabp+6vtJSqd2CPNB
        ShP1HznAt+ycn9rYg8jnuOjiutw3OTbhMURbAImKtAD3KOyZ8X/uNFFm2NeuUaq7MDBBxl
        JGeEN7DKaYsg2yS90fDhZvx+pneuCZSagsfzBgNlQk9cEeZvtvOZ70EhpeoH6vSGDPi86Z
        wbBay1RsbTLCLex8FrLTw4coYTjj2SykQ6/gbVWRX3otkU50oXKLv4mxLh0Bu7aot1XEMu
        U5x5yZSxHdEk6j0Bz/4cjtohKKT+mQxrda6v5ms1n5zt5QivIfLCM6YkAOTdug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661436087;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eovjzwcvdUvFZ3zDujG/9uL0DmNL5HqE1TDIBYenQdA=;
        b=PT0M1NE5IC+pQixFBlfhfVwordgcmk0EswHyKHTMrcVs0Zzyzt/Be321INYKwY2iN/x6KE
        hCsLH+R54/zEq4BA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Mark snp_abort() noreturn
Cc:     Michael Matz <matz@suse.de>, Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220824152420.20547-1-bp@alien8.de>
References: <20220824152420.20547-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <166143608669.401.14403984449767044288.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c93c296fff6b369a7115916145047c8a3db6e27f
Gitweb:        https://git.kernel.org/tip/c93c296fff6b369a7115916145047c8a3db6e27f
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 24 Aug 2022 17:13:26 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 25 Aug 2022 15:54:03 +02:00

x86/sev: Mark snp_abort() noreturn

Mark both the function prototype and definition as noreturn in order to
prevent the compiler from doing transformations which confuse objtool
like so:

  vmlinux.o: warning: objtool: sme_enable+0x71: unreachable instruction

This triggers with gcc-12.

Add it and sev_es_terminate() to the objtool noreturn tracking array
too. Sort it while at it.

Suggested-by: Michael Matz <matz@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220824152420.20547-1-bp@alien8.de
---
 arch/x86/include/asm/sev.h |  2 +-
 arch/x86/kernel/sev.c      |  2 +-
 tools/objtool/check.c      | 34 ++++++++++++++++++----------------
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 4a23e52..ebc271b 100644
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
index 4f84c3f..a428c62 100644
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
index 0cec74d..ad51689 100644
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
