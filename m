Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6924E5576F1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiFWJqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiFWJqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:46:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D2349925
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:46:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6F2CA21CF6;
        Thu, 23 Jun 2022 09:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655977571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qOrZ3a0atU/z4XGkVjCM42/CYfuowe8zJtC3IRIryL4=;
        b=CY+aACXb8FTwdvlK2MD+8Ue/Ep+AuaiXD4J2b/dJwMFgM+Cr8HwRI0sA5M0QA78pAqdvsr
        3Wy5n6qTS4x9KZcf/S2ffLR4puT/FnYCgKNVJuftwlxmFmOANRIxWolPgpkpPWtaqQ+hho
        V/uuve6jQ8m5GFkEDaoknN9kv4J73Vk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B7CF133A6;
        Thu, 23 Jun 2022 09:46:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QPVlBWM2tGLmLwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 23 Jun 2022 09:46:11 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Beulich <jbeulich@suse.com>
Subject: [PATCH v2 1/3] x86/xen: use clear_bss() for Xen PV guests
Date:   Thu, 23 Jun 2022 11:46:06 +0200
Message-Id: <20220623094608.7294-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220623094608.7294-1-jgross@suse.com>
References: <20220623094608.7294-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of clearing the bss area in assembly code, use the clear_bss()
function.

This requires to pass the start_info address as parameter to
xen_start_kernel() in order to avoid the xen_start_info being zeroed
again.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
---
 arch/x86/include/asm/setup.h |  3 +++
 arch/x86/kernel/head64.c     |  2 +-
 arch/x86/xen/enlighten_pv.c  |  8 ++++++--
 arch/x86/xen/xen-head.S      | 10 +---------
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index f8b9ee97a891..f37cbff7354c 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -120,6 +120,9 @@ void *extend_brk(size_t size, size_t align);
 	static char __brk_##name[size]
 
 extern void probe_roms(void);
+
+void clear_bss(void);
+
 #ifdef __i386__
 
 asmlinkage void __init i386_start_kernel(void);
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index bd4a34100ed0..e7e233209a8c 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -426,7 +426,7 @@ void __init do_early_exception(struct pt_regs *regs, int trapnr)
 
 /* Don't add a printk in there. printk relies on the PDA which is not initialized 
    yet. */
-static void __init clear_bss(void)
+void __init clear_bss(void)
 {
 	memset(__bss_start, 0,
 	       (unsigned long) __bss_stop - (unsigned long) __bss_start);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index e3297b15701c..70fb2ea85e90 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1183,15 +1183,19 @@ static void __init xen_domu_set_legacy_features(void)
 extern void early_xen_iret_patch(void);
 
 /* First C function to be called on Xen boot */
-asmlinkage __visible void __init xen_start_kernel(void)
+asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
 {
 	struct physdev_set_iopl set_iopl;
 	unsigned long initrd_start = 0;
 	int rc;
 
-	if (!xen_start_info)
+	if (!si)
 		return;
 
+	clear_bss();
+
+	xen_start_info = si;
+
 	__text_gen_insn(&early_xen_iret_patch,
 			JMP32_INSN_OPCODE, &early_xen_iret_patch, &xen_iret,
 			JMP32_INSN_SIZE);
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 3a2cd93bf059..13af6fe453e3 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -48,15 +48,6 @@ SYM_CODE_START(startup_xen)
 	ANNOTATE_NOENDBR
 	cld
 
-	/* Clear .bss */
-	xor %eax,%eax
-	mov $__bss_start, %rdi
-	mov $__bss_stop, %rcx
-	sub %rdi, %rcx
-	shr $3, %rcx
-	rep stosq
-
-	mov %rsi, xen_start_info
 	mov initial_stack(%rip), %rsp
 
 	/* Set up %gs.
@@ -71,6 +62,7 @@ SYM_CODE_START(startup_xen)
 	cdq
 	wrmsr
 
+	mov	%rsi, %rdi
 	call xen_start_kernel
 SYM_CODE_END(startup_xen)
 	__FINIT
-- 
2.35.3

