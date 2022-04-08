Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9508B4F919D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiDHJMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbiDHJKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:10:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB9811F7B5;
        Fri,  8 Apr 2022 02:08:49 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:08:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408927;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jQvFuxtBRASTBdvgHBEuGAFkdZphwrpbJMRYKR4aUVE=;
        b=0ieIiyGkbNDdYKk2uy1FiadUqBs9a8tq4IrRVed/pAi7aH38K9eDogOmanzwmEAhaFxy+w
        bzLk+xxS1PkqBGHUyXhuozj2nxI+RzdT1rOR92fTy3/SjYjf3oUPnlJBAXR+aekA3iyUXg
        siFi1tsHpqswrpee+2ihPC86b1knhQTMYegMEnGC6kddFKtwWpuTVt2eSULOu6sLNga//0
        h0IVtucT/Es19cworEskii2RzLAe9jFgFVNvRkGFKI/di4gTGciW7h/+ff3uWpGfaBtmmm
        uMtSMA/rRk9QxppVFx9YevikjlGmSdt1l7kT2DziATU3GSYsSZhBe9T9mu9cgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408927;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jQvFuxtBRASTBdvgHBEuGAFkdZphwrpbJMRYKR4aUVE=;
        b=gCHJgEfkd+xZMfWjGXlbd3mqdddSysRk5BSMgU3ygL+ZxAvZQNQqf9WBkKFIwW/hXmHPEv
        CMFH8hyH55bVccDA==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/compressed: Export and rename add_identity_map()
Cc:     Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-37-brijesh.singh@amd.com>
References: <20220307213356.2797205-37-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940892680.389.5129551490474108839.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     a9ee679b1f8c3803490ed2eeffb688aaee56583f
Gitweb:        https://git.kernel.org/tip/a9ee679b1f8c3803490ed2eeffb688aaee56583f
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Thu, 24 Feb 2022 10:56:16 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 Apr 2022 16:47:11 +02:00

x86/compressed: Export and rename add_identity_map()

SEV-specific code will need to add some additional mappings, but doing
this within ident_map_64.c requires some SEV-specific helpers to be
exported and some SEV-specific struct definitions to be pulled into
ident_map_64.c. Instead, export add_identity_map() so SEV-specific (and
other subsystem-specific) code can be better contained outside of
ident_map_64.c.

While at it, rename the function to kernel_add_identity_map(), similar
to the kernel_ident_mapping_init() function it relies upon.

No functional changes.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-37-brijesh.singh@amd.com
---
 arch/x86/boot/compressed/ident_map_64.c | 18 +++++++++---------
 arch/x86/boot/compressed/misc.h         |  1 +
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 613367e..99348ee 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -90,7 +90,7 @@ static struct x86_mapping_info mapping_info;
 /*
  * Adds the specified range to the identity mappings.
  */
-static void add_identity_map(unsigned long start, unsigned long end)
+void kernel_add_identity_map(unsigned long start, unsigned long end)
 {
 	int ret;
 
@@ -157,11 +157,11 @@ void initialize_identity_maps(void *rmode)
 	 * explicitly here in case the compressed kernel does not touch them,
 	 * or does not touch all the pages covering them.
 	 */
-	add_identity_map((unsigned long)_head, (unsigned long)_end);
+	kernel_add_identity_map((unsigned long)_head, (unsigned long)_end);
 	boot_params = rmode;
-	add_identity_map((unsigned long)boot_params, (unsigned long)(boot_params + 1));
+	kernel_add_identity_map((unsigned long)boot_params, (unsigned long)(boot_params + 1));
 	cmdline = get_cmd_line_ptr();
-	add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
+	kernel_add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
 
 	/* Load the new page-table. */
 	sev_verify_cbit(top_level_pgt);
@@ -246,10 +246,10 @@ static int set_clr_page_flags(struct x86_mapping_info *info,
 	 * It should already exist, but keep things generic.
 	 *
 	 * To map the page just read from it and fault it in if there is no
-	 * mapping yet. add_identity_map() can't be called here because that
-	 * would unconditionally map the address on PMD level, destroying any
-	 * PTE-level mappings that might already exist. Use assembly here so
-	 * the access won't be optimized away.
+	 * mapping yet. kernel_add_identity_map() can't be called here because
+	 * that would unconditionally map the address on PMD level, destroying
+	 * any PTE-level mappings that might already exist. Use assembly here
+	 * so the access won't be optimized away.
 	 */
 	asm volatile("mov %[address], %%r9"
 		     :: [address] "g" (*(unsigned long *)address)
@@ -363,5 +363,5 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 	 * Error code is sane - now identity map the 2M region around
 	 * the faulting address.
 	 */
-	add_identity_map(address, end);
+	kernel_add_identity_map(address, end);
 }
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index ba538af..aae2722 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -156,6 +156,7 @@ static inline int count_immovable_mem_regions(void) { return 0; }
 #ifdef CONFIG_X86_5LEVEL
 extern unsigned int __pgtable_l5_enabled, pgdir_shift, ptrs_per_p4d;
 #endif
+extern void kernel_add_identity_map(unsigned long start, unsigned long end);
 
 /* Used by PAGE_KERN* macros: */
 extern pteval_t __default_kernel_pte_mask;
