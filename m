Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE19850278A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351834AbiDOJo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351815AbiDOJow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:44:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA62AC042;
        Fri, 15 Apr 2022 02:42:23 -0700 (PDT)
Date:   Fri, 15 Apr 2022 09:42:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650015742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OaWHcjI5jzSN+btLdV7n53XabIHh5QmAWpRah4D530Q=;
        b=TYCS/5tQUUepLaVDvKZBUm5an8Vfd7DOBIfbCHVTotatqJMg/qiE4SfQ+nluZbeTaZnqKx
        guOyhfUSEZj6UJTJCcIIwRZI6q+dV0dAK0j5NsdtdmzKn5XAtin6vC0+nNJ3UMZDLthgbd
        pel0OPj3i/hpG21NicDED6/IfMuKLHjthk749Vk6qrozwN/+jVkTs26BueMtS9HJw+kJOx
        J+fD/oIg+pZ48W+TEtunpY/aeWeVU1+OwsmmIq3v4I+GKBE5Cq/wlinE3MpTuBwX4LREa8
        XnjTW7m+8RFC1CUTcMErO9dCwGxzpuQZ2hSBO0RKKzzXIabOCZWAL9kPAVxtNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650015742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OaWHcjI5jzSN+btLdV7n53XabIHh5QmAWpRah4D530Q=;
        b=kgJ7GxorN7KCcZ8OppF3/DUR/xqUGeZAN/MJe1Qrt2rgA/SoxLHrPgOX/Kq7kJsSh6DSFo
        8yuDEywmtT0htnCw==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] ELF: Remove elf_core_copy_kernel_regs()
Cc:     Brian Gerst <brgerst@gmail.com>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220325153953.162643-3-brgerst@gmail.com>
References: <20220325153953.162643-3-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <165001574130.4207.13922320216714992747.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     9554e908fb5d02e48a681d1eca180225bf109e83
Gitweb:        https://git.kernel.org/tip/9554e908fb5d02e48a681d1eca180225bf109e83
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 25 Mar 2022 11:39:51 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 14 Apr 2022 14:08:26 +02:00

ELF: Remove elf_core_copy_kernel_regs()

x86-32 was the last architecture that implemented separate user and
kernel registers.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20220325153953.162643-3-brgerst@gmail.com
---
 arch/powerpc/kernel/fadump.c               |  2 +-
 arch/powerpc/platforms/powernv/opal-core.c |  2 +-
 include/linux/elfcore.h                    |  9 ---------
 kernel/kexec_core.c                        |  2 +-
 4 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 65562c4..4c09c66 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -752,7 +752,7 @@ u32 *__init fadump_regs_to_elf_notes(u32 *buf, struct pt_regs *regs)
 	 * FIXME: How do i get PID? Do I really need it?
 	 * prstatus.pr_pid = ????
 	 */
-	elf_core_copy_kernel_regs(&prstatus.pr_reg, regs);
+	elf_core_copy_regs(&prstatus.pr_reg, regs);
 	buf = append_elf_note(buf, CRASH_CORE_NOTE_NAME, NT_PRSTATUS,
 			      &prstatus, sizeof(prstatus));
 	return buf;
diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
index b97bc17..adcb1a1 100644
--- a/arch/powerpc/platforms/powernv/opal-core.c
+++ b/arch/powerpc/platforms/powernv/opal-core.c
@@ -112,7 +112,7 @@ static void __init fill_prstatus(struct elf_prstatus *prstatus, int pir,
 			  struct pt_regs *regs)
 {
 	memset(prstatus, 0, sizeof(struct elf_prstatus));
-	elf_core_copy_kernel_regs(&(prstatus->pr_reg), regs);
+	elf_core_copy_regs(&(prstatus->pr_reg), regs);
 
 	/*
 	 * Overload PID with PIR value.
diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
index f8e206e..346a8b5 100644
--- a/include/linux/elfcore.h
+++ b/include/linux/elfcore.h
@@ -84,15 +84,6 @@ static inline void elf_core_copy_regs(elf_gregset_t *elfregs, struct pt_regs *re
 #endif
 }
 
-static inline void elf_core_copy_kernel_regs(elf_gregset_t *elfregs, struct pt_regs *regs)
-{
-#ifdef ELF_CORE_COPY_KERNEL_REGS
-	ELF_CORE_COPY_KERNEL_REGS((*elfregs), regs);
-#else
-	elf_core_copy_regs(elfregs, regs);
-#endif
-}
-
 static inline int elf_core_copy_task_regs(struct task_struct *t, elf_gregset_t* elfregs)
 {
 #if defined (ELF_CORE_COPY_TASK_REGS)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 68480f7..be4b54c 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1078,7 +1078,7 @@ void crash_save_cpu(struct pt_regs *regs, int cpu)
 		return;
 	memset(&prstatus, 0, sizeof(prstatus));
 	prstatus.common.pr_pid = current->pid;
-	elf_core_copy_kernel_regs(&prstatus.pr_reg, regs);
+	elf_core_copy_regs(&prstatus.pr_reg, regs);
 	buf = append_elf_note(buf, KEXEC_CORE_NOTE_NAME, NT_PRSTATUS,
 			      &prstatus, sizeof(prstatus));
 	final_note(buf);
