Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3B750A1CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389004AbiDUOOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389093AbiDUOOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:14:01 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C88A3BBD1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:10:51 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g9so4725900pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GvPI5O7bc6LGIykxFdqKLQ/TYyAeta3g92krnAeVAuA=;
        b=LGWfT3TK3DeviWkajBNJhZgzCGZRdpR9GaR5Ev83VxnJ1tfR2Qyz7mR7k5z2oc0zVa
         GnGuboKEr02q4LBg3uVHhR4DKUxzg3km6pQwsxSBVcXoSOtpWoBGX0t4UC9EVly3sq+H
         NYqHZjM2V7KYQNFZRRP0CWoMra3J89piNMsZycSpIB2SeQfMjw3iuI3Zl6Bhcdx0oeKn
         nEGg2LwDCA5hm2M9TP5hrgda7lIKs4nJtf1MGrXljvwg14l15ecRLG6Bw5GODjduKFAM
         8I4a+J5e+Y6TkZuFOzJ0xEn1aVZzsS6fsVgEvrb2HdmSn9n2rXedntnihkB1cWsSYpOY
         nGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GvPI5O7bc6LGIykxFdqKLQ/TYyAeta3g92krnAeVAuA=;
        b=QvfuuSrklimmbhIvvF4UcqayiH1LI41XxhEjByk3D0fH32jeBuaRwicDdBpKyPhytS
         QL92m3T2zMxZG27y+BXo5P47JnZ0+AKNjPs57LwVg1JbaRMy6aKxOq+bzvXhKN7KP3d9
         P8cbNydkJm7zil5ETQuZ8YV2TDq3L9z+QVjDxsqIHHidETzoRT0+/G5QspUxshRYifL3
         oZO7JESR9OV0VwsagC/gJGLFO5F0kizTE4euU1u1qkDGEODuZfCyQthDSHM+JX4ql/ZI
         CsD670pWBq9ut0+tTWAjRtwgTAqJMfiEqPqO6YGGhneIexZ7YrYsGPl2DPZyH0X94Nua
         YPpg==
X-Gm-Message-State: AOAM531TXB61IqYUUzYZHlE6uLTiaka37CHiSxIPY5ZWt2g+AX4VNmtO
        z98qh8ess7vf/KaZHSovYqYSbQv/y4Q=
X-Google-Smtp-Source: ABdhPJzG4wScVdh4bCGcVi1HfKVqMqladVHf9o0jjUXDi545xRY+BTS4LT+OQP8eymwuLM9hinXoCg==
X-Received: by 2002:a63:2a45:0:b0:3a9:f71e:a63d with SMTP id q66-20020a632a45000000b003a9f71ea63dmr18379206pgq.69.1650550250943;
        Thu, 21 Apr 2022 07:10:50 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a001a4a00b004f7c76f29c3sm24462527pfv.24.2022.04.21.07.10.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 07:10:50 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [PATCH V6 6/8] x86/entry: Convert SWAPGS to swapgs and remove the definition of SWAPGS
Date:   Thu, 21 Apr 2022 22:10:53 +0800
Message-Id: <20220421141055.316239-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220421141055.316239-1-jiangshanlai@gmail.com>
References: <20220421141055.316239-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

XENPV doesn't use swapgs_restore_regs_and_return_to_usermode(),
error_entry() and entry_SYSENTER_compat().

Change the PV-compatible SWAPGS to the ASM instruction swapgs in these
functions.

Also remove the definition of SWAPGS since there is no user of the
SWAPGS anymore.

Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S        | 6 +++---
 arch/x86/entry/entry_64_compat.S | 2 +-
 arch/x86/include/asm/irqflags.h  | 8 --------
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 062aa9d95961..312186612f4e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1019,7 +1019,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * We entered from user mode or we're pretending to have entered
 	 * from user mode due to an IRET fault.
 	 */
-	SWAPGS
+	swapgs
 	FENCE_SWAPGS_USER_ENTRY
 	/* We have user CR3.  Change to kernel CR3. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
@@ -1051,7 +1051,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * gsbase and proceed.  We'll fix up the exception and land in
 	 * .Lgs_change's error handler with kernel gsbase.
 	 */
-	SWAPGS
+	swapgs
 
 	/*
 	 * Issue an LFENCE to prevent GS speculation, regardless of whether it is a
@@ -1072,7 +1072,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * We came from an IRET to user mode, so we have user
 	 * gsbase and CR3.  Switch to kernel gsbase and CR3:
 	 */
-	SWAPGS
+	swapgs
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 4fdb007cddbd..c5aeb0819707 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -50,7 +50,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
 	UNWIND_HINT_EMPTY
 	ENDBR
 	/* Interrupts are off on entry. */
-	SWAPGS
+	swapgs
 
 	pushq	%rax
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 111104d1c2cd..7793e52d6237 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -137,14 +137,6 @@ static __always_inline void arch_local_irq_restore(unsigned long flags)
 	if (!arch_irqs_disabled_flags(flags))
 		arch_local_irq_enable();
 }
-#else
-#ifdef CONFIG_X86_64
-#ifdef CONFIG_XEN_PV
-#define SWAPGS	ALTERNATIVE "swapgs", "", X86_FEATURE_XENPV
-#else
-#define SWAPGS	swapgs
-#endif
-#endif
 #endif /* !__ASSEMBLY__ */
 
 #endif
-- 
2.19.1.6.gb485710b

