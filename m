Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4544CB595
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiCCDzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiCCDzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:55:31 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661D714560B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:54:47 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 132so3428534pga.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 19:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AOa0Ei1g6e4VlPBDw15RL007lSMOSrMvUzhJPGj9XAI=;
        b=eCXzMPrvm0QclKJ/8ESlhGV7ol/xxd0jxpeS+MvgphVnb3ojFQ+gK3KpzVzxxo+qxL
         bSwolL7L4dDMj29c6jcEc1th4JLA9CD7t1+M9csTffdIwf8P2wU9ny44rUGuPNQniOI1
         pnMvB/X0OUgGWfcOq34wjA3TelHnDUsNdSgJySjD8a/FFtMMAYcsRWDohcAX9uOVozdE
         QrdI+LUylMbE4ZX7ar5lagHtuezvvHoHZ3nhwbj9fTS2Y5BS9QJyh0TX3yGTc18iUKBh
         5WIINkssRb+sUqfobVqg4UU1pYTHt8iJmT0HEoIu94SMlrTbnDDdR9kGa4WLB7noP1qy
         HDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AOa0Ei1g6e4VlPBDw15RL007lSMOSrMvUzhJPGj9XAI=;
        b=TgAn55QtbGmYN3qiwxLri4Kmb38SYwr69B0grNlBBakp/GB66DJC6G0uaNInRMRDaH
         AGUkEi8n2hrcBEjmWavnzbHehO0R/+uoy7yA4Ov9J1T44VrP+B4qnbRlrt6JQsMS4A3z
         oI5wP2rr02JSTTD1Zj2iIAWYOwzoKG8ViI3EnhnmfnQbikakDQavXVC8o1GlaADj/sYz
         +HGcb2+yo8JPGkpzZNoUAbk+LslAW9gZJ3ifbYDKv4EQpau486SY1PQoZZj+yWZ5Rsoc
         KRPjj4YN1pXHUTqO0FdbetvDxWIcg17YqZj8g8zr/EtnAXm93pBkKlIpY6ComcYGAi83
         S3wg==
X-Gm-Message-State: AOAM531IOIQE/+IJyxH5VH1jmzttMjGKN8R4ctcPTI4UOP1aGdK4j8hr
        Lz5v1Ns+5vDJ5jr5VYLzRtCJt9z6Y1o=
X-Google-Smtp-Source: ABdhPJwuPPW+OW04xR5tRD6ZiwBqHBvxNWZMWDjet+tD/wstzrZ9p5WcmL5uWKiurXsOsVmlNtqIuQ==
X-Received: by 2002:a63:6b42:0:b0:37c:4e5c:a903 with SMTP id g63-20020a636b42000000b0037c4e5ca903mr2183734pgc.463.1646279686726;
        Wed, 02 Mar 2022 19:54:46 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090a450900b001b9b5ca299esm6563740pjg.54.2022.03.02.19.54.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Mar 2022 19:54:46 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [PATCH V2 7/7] x86/entry: Convert SWAPGS to swapgs and remove the definition of SWAPGS
Date:   Thu,  3 Mar 2022 11:54:34 +0800
Message-Id: <20220303035434.20471-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220303035434.20471-1-jiangshanlai@gmail.com>
References: <20220303035434.20471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

XENPV doesn't use swapgs_restore_regs_and_return_to_usermode(),
error_entry() and entry_SYSENTER_compat(), so the PV-awared SWAPGS in
them can be changed to swapgs.  There is no user of the SWAPGS anymore
after this change.

The INTERRUPT_RETURN in swapgs_restore_regs_and_return_to_usermode()
is also converted.

Cc: xen-devel@lists.xenproject.org
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S        | 10 +++++-----
 arch/x86/entry/entry_64_compat.S |  2 +-
 arch/x86/include/asm/irqflags.h  |  2 --
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 88b61f310289..d9c885400034 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -644,8 +644,8 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 
 	/* Restore RDI. */
 	popq	%rdi
-	SWAPGS
-	INTERRUPT_RETURN
+	swapgs
+	jmp	native_iret
 
 
 SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
@@ -1007,7 +1007,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * We entered from user mode or we're pretending to have entered
 	 * from user mode due to an IRET fault.
 	 */
-	SWAPGS
+	swapgs
 	FENCE_SWAPGS_USER_ENTRY
 	/* We have user CR3.  Change to kernel CR3. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
@@ -1039,7 +1039,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * gsbase and proceed.  We'll fix up the exception and land in
 	 * .Lgs_change's error handler with kernel gsbase.
 	 */
-	SWAPGS
+	swapgs
 
 	/*
 	 * Issue an LFENCE to prevent GS speculation, regardless of whether it is a
@@ -1060,7 +1060,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * We came from an IRET to user mode, so we have user
 	 * gsbase and CR3.  Switch to kernel gsbase and CR3:
 	 */
-	SWAPGS
+	swapgs
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index a4fcea0cab14..72e017c3941f 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -49,7 +49,7 @@
 SYM_CODE_START(entry_SYSENTER_compat)
 	UNWIND_HINT_EMPTY
 	/* Interrupts are off on entry. */
-	SWAPGS
+	swapgs
 
 	pushq	%rax
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 87761396e8cc..ac2e4cc47210 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -140,13 +140,11 @@ static __always_inline void arch_local_irq_restore(unsigned long flags)
 #else
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_XEN_PV
-#define SWAPGS	ALTERNATIVE "swapgs", "", X86_FEATURE_XENPV
 #define INTERRUPT_RETURN						\
 	ANNOTATE_RETPOLINE_SAFE;					\
 	ALTERNATIVE_TERNARY("jmp *paravirt_iret(%rip);",		\
 		X86_FEATURE_XENPV, "jmp xen_iret;", "jmp native_iret;")
 #else
-#define SWAPGS	swapgs
 #define INTERRUPT_RETURN	jmp native_iret
 #endif
 #endif
-- 
2.19.1.6.gb485710b

