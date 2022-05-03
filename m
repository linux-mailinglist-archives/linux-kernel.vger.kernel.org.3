Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A91517C35
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 05:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiECDYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 23:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiECDYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 23:24:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3863B55A
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 20:21:13 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so1123918pju.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 20:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lB48jYFG9Z5zUm2kKQoJTg5qAQTn/y96aJT2/yNcQUo=;
        b=bNwc2L9/9lr/9BjYkGR2Q/bEyjWI5kUABXvSyOEuHiYHzhi8mnh7RrrM0nDQoXJRSI
         VGDhsSxCpigoGwHMi1/p3+ncjKt+EEvzeqUlpnmbuCsLb2010lHLrLWNOvuwzZCMuntl
         +KRYINwRtFPi9n2O1pff7fsgmUUZHVWtOQm7UgswTykaN23k3KE8+bEgnLgOBqrlVh9a
         IXV3y93EL9xfBOlQsjMY9GzeswiVa1YxeSHMDcE/CU81N+KV2AMgCQFoyy9EREJS1/BI
         u//VJdn2ySPmuxQEOzN0mkxcPJ6P9eMWekFdDaIyf9CHwbpluE3rD2bVCRQMSUIGS5am
         wb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lB48jYFG9Z5zUm2kKQoJTg5qAQTn/y96aJT2/yNcQUo=;
        b=pQheTeV89fuFdLI6f3x9o9W8vwHoTFZiSdLyAAxdvBBojlGxeZS8QOzD4+zUspmrKI
         tp+1S2Xawcm5dh9AgzwS1k30xiTipyvuGeSn9TCQOPVTuvmTAZhwRa9O5aCKyeYVAg/s
         0zjJtwI47/nsyc8miiAoqgStJRsf9fXqQNXYnbxAkTOWCf2I6raiXo+hgjDX5qoemNKP
         9O4TbnGo8s1ZSsdxTnTDIUJVnOX5/ZJXgnJz0WE41v0AGsxM7LjIidRUuqrT0yONNMQK
         Dr9iXhau6FCEC8I/eVjYvV3Tf6EUMWnGGJs75zzPLGsMVqBasNNRpHQPo4UjVQY+lxVk
         c01A==
X-Gm-Message-State: AOAM5335fbLoXTrLZPOeUma6yWz4kQvRjibFTEpKY2Eq3id8vpFRBZVO
        LIXrtckitv4nw19pqKb6UIJkAonxxSw=
X-Google-Smtp-Source: ABdhPJxXP1AAmaNEXnDBeCM5tlwV8bGPaeAYGTaENQQgjK6iIb7xqWExvBqa3WUNtjWAIs73YFSHVg==
X-Received: by 2002:a17:90b:4c85:b0:1dc:5778:5344 with SMTP id my5-20020a17090b4c8500b001dc57785344mr2579726pjb.8.1651548072270;
        Mon, 02 May 2022 20:21:12 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id p12-20020a634f4c000000b003c14af50620sm11959455pgl.56.2022.05.02.20.21.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2022 20:21:11 -0700 (PDT)
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
Subject: [PATCH V7 6/6] x86/entry: Convert SWAPGS to swapgs and remove the definition of SWAPGS
Date:   Tue,  3 May 2022 11:21:07 +0800
Message-Id: <20220503032107.680190-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220503032107.680190-1-jiangshanlai@gmail.com>
References: <20220503032107.680190-1-jiangshanlai@gmail.com>
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
error_entry() and the code between entry_SYSENTER_compat() and
entry_SYSENTER_compat_after_hwframe.

Change the PV-compatible SWAPGS to the ASM instruction swapgs in these
places.

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

