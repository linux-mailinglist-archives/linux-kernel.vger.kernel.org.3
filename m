Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2439F522D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242960AbiEKH11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242940AbiEKH1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:27:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB783CA5A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:27:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso1287779pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EK03M+puSu84y4LA2tpR63LGf6pYpcixQrSXDU5WY9M=;
        b=XAqq6Vy677zzwsOLR9heaBfHSiYJe2gOzNQQ8+f8Jzs3ePCqpPjy3DXDNGUg/D3E+y
         8AkX4EnxmxrMT9D5Rb9TTqaNrb97ZTLl+4pDgOvrYEes8fqaLI7LjIUdjnFXMOHuXRGJ
         d8ANWQyWBnbZk7uEGOZnIVHP+/yqwIfFwIvS7vtm0lbGNPWgYb/uaOj1EIPWi3cTEmrc
         0B5BQs6Ky91uwVf81cfPp6wSXFCzUUBxbnt/4mfG2z519sABIlo04X2OA3iXGchmCANl
         T7FDPM1OazmIwU3GBHv2pRV7EowhxsW7ybaneHES2aGhu69zuZR3KWVzNhPDVXKU294z
         Bgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EK03M+puSu84y4LA2tpR63LGf6pYpcixQrSXDU5WY9M=;
        b=pSQQb/og9xo4UD09oDUB7pHSUt940iSjjrrNsJFqjT9/W+Jcy2A3UdGLS7Tw0n577O
         /j4iz+6h1dIrz7RH6LaFAsOHnG2C2OEC93EMnmi9twkrX9cFJv25ETSwlCUrjjvvcR2l
         swqkHjKIL+9lFbhdP7dFOpfN2srmeVbgkbeZVR+JkrYGVbC54AEMhtadRM4fRfuuRyLK
         8zZgtP9hlSWnJol/CPQPEU9NvGsYPreBekVnVAl16MsOayTHZNCZuYPSkBujUa/gubeq
         hivFD84hsHA6KQkdjwcr+65uue0408iM2omhz6SiehXArai/soWbrG05vgI44wgkRGaI
         wt/g==
X-Gm-Message-State: AOAM5319AXJc7YdXitYLrSBBTFtL6q0WF9BWGDWkVEgrWYMgng+dFr2r
        oGqubkZdeieXVBNA++RjiE/P4hnBSJw=
X-Google-Smtp-Source: ABdhPJy+S8UjM/NrSA0lu4NnbybJQGh/8pHGRrtf0KqkDZcoHERomd3uPoA8dO0uqFfyRkozbrPpcw==
X-Received: by 2002:a17:902:d58b:b0:15f:16f9:abe4 with SMTP id k11-20020a170902d58b00b0015f16f9abe4mr11352905plh.83.1652254031691;
        Wed, 11 May 2022 00:27:11 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id r13-20020a170902ea4d00b0015e8d4eb1e5sm962306plg.47.2022.05.11.00.27.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 May 2022 00:27:11 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH 2/7] x86/entry: Move PTI_USER_* to arch/x86/include/asm/processor-flags.h
Date:   Wed, 11 May 2022 15:27:42 +0800
Message-Id: <20220511072747.3960-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220511072747.3960-1-jiangshanlai@gmail.com>
References: <20220511072747.3960-1-jiangshanlai@gmail.com>
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

These constants will be also used in C file.

Move them to arch/x86/include/asm/processor-flags.h which already has
a kin X86_CR3_PTI_PCID_USER_BIT defined in it.

Remove PTI_PGTABLE_SWITCH_BIT and replace it with PTI_USER_PGTABLE_BIT
since they are the same in meaning and value.

Remove kernel_to_user_p4dp() and user_to_kernel_p4dp() since they
are using the removed PTI_PGTABLE_SWITCH_BIT and they have no caller.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/calling.h               | 10 ----------
 arch/x86/include/asm/pgtable.h         | 23 +++--------------------
 arch/x86/include/asm/processor-flags.h | 15 +++++++++++++++
 3 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index a97cc78ecb92..f0f60810aee7 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -142,16 +142,6 @@ For 32-bit we have the following conventions - kernel is built with
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 
-/*
- * PAGE_TABLE_ISOLATION PGDs are 8k.  Flip bit 12 to switch between the two
- * halves:
- */
-#define PTI_USER_PGTABLE_BIT		PAGE_SHIFT
-#define PTI_USER_PGTABLE_MASK		(1 << PTI_USER_PGTABLE_BIT)
-#define PTI_USER_PCID_BIT		X86_CR3_PTI_PCID_USER_BIT
-#define PTI_USER_PCID_MASK		(1 << PTI_USER_PCID_BIT)
-#define PTI_USER_PGTABLE_AND_PCID_MASK  (PTI_USER_PCID_MASK | PTI_USER_PGTABLE_MASK)
-
 .macro SET_NOFLUSH_BIT	reg:req
 	bts	$X86_CR3_PCID_NOFLUSH_BIT, \reg
 .endm
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 62ab07e24aef..19095f7a0840 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -5,6 +5,7 @@
 #include <linux/mem_encrypt.h>
 #include <asm/page.h>
 #include <asm/pgtable_types.h>
+#include <asm/processor-flags.h>
 
 /*
  * Macro to mark a page protection value as UC-
@@ -1191,14 +1192,6 @@ static inline bool pgdp_maps_userspace(void *__ptr)
 static inline int pgd_large(pgd_t pgd) { return 0; }
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
-/*
- * All top-level PAGE_TABLE_ISOLATION page tables are order-1 pages
- * (8k-aligned and 8k in size).  The kernel one is at the beginning 4k and
- * the user one is in the last 4k.  To switch between them, you
- * just need to flip the 12th bit in their addresses.
- */
-#define PTI_PGTABLE_SWITCH_BIT	PAGE_SHIFT
-
 /*
  * This generates better code than the inline assembly in
  * __set_bit().
@@ -1220,22 +1213,12 @@ static inline void *ptr_clear_bit(void *ptr, int bit)
 
 static inline pgd_t *kernel_to_user_pgdp(pgd_t *pgdp)
 {
-	return ptr_set_bit(pgdp, PTI_PGTABLE_SWITCH_BIT);
+	return ptr_set_bit(pgdp, PTI_USER_PGTABLE_BIT);
 }
 
 static inline pgd_t *user_to_kernel_pgdp(pgd_t *pgdp)
 {
-	return ptr_clear_bit(pgdp, PTI_PGTABLE_SWITCH_BIT);
-}
-
-static inline p4d_t *kernel_to_user_p4dp(p4d_t *p4dp)
-{
-	return ptr_set_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
-}
-
-static inline p4d_t *user_to_kernel_p4dp(p4d_t *p4dp)
-{
-	return ptr_clear_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
+	return ptr_clear_bit(pgdp, PTI_USER_PGTABLE_BIT);
 }
 #endif /* CONFIG_PAGE_TABLE_ISOLATION */
 
diff --git a/arch/x86/include/asm/processor-flags.h b/arch/x86/include/asm/processor-flags.h
index 02c2cbda4a74..4dd2fbbc861a 100644
--- a/arch/x86/include/asm/processor-flags.h
+++ b/arch/x86/include/asm/processor-flags.h
@@ -4,6 +4,7 @@
 
 #include <uapi/asm/processor-flags.h>
 #include <linux/mem_encrypt.h>
+#include <asm/page_types.h>
 
 #ifdef CONFIG_VM86
 #define X86_VM_MASK	X86_EFLAGS_VM
@@ -50,7 +51,21 @@
 #endif
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
+
 # define X86_CR3_PTI_PCID_USER_BIT	11
+
+#ifdef CONFIG_X86_64
+/*
+ * PAGE_TABLE_ISOLATION PGDs are 8k.  Flip bit 12 to switch between the two
+ * halves:
+ */
+#define PTI_USER_PGTABLE_BIT		PAGE_SHIFT
+#define PTI_USER_PGTABLE_MASK		(1 << PTI_USER_PGTABLE_BIT)
+#define PTI_USER_PCID_BIT		X86_CR3_PTI_PCID_USER_BIT
+#define PTI_USER_PCID_MASK		(1 << PTI_USER_PCID_BIT)
+#define PTI_USER_PGTABLE_AND_PCID_MASK  (PTI_USER_PCID_MASK | PTI_USER_PGTABLE_MASK)
+#endif
+
 #endif
 
 #endif /* _ASM_X86_PROCESSOR_FLAGS_H */
-- 
2.19.1.6.gb485710b

