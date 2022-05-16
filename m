Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D90B528527
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243778AbiEPNRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243796AbiEPNRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:17:21 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01A52529B
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:17:20 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t11-20020a17090a6a0b00b001df6f318a8bso1253845pjj.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FSeMlanFh2svXxaNRkwpD5s2Jt4O19S77leAuNHNOlo=;
        b=f5bpF3JgDxt953UNKD7px9h21rVHMzamUxSzdhuN+W5C3vs/DafoFQLV2eCR4gml3C
         SY0T1kPjdmclW0ZLySYYdws0f4oCIs9wH3olszqyO7jfj5rt/XGVkV4jpg/uQK3Tk8SO
         Y+quy7MLrfa7JseKtmQ0KArxfT2wgHF+yObcsJ2DetEcGj8nyi7IIXnTr1xm3KZbQrvF
         TdLQ0FQnnSx/5tHQx7sMGyVJmUZt6wVITKvawFvVjC2iL0dIcQiCzcxewzMMIY2sPjV2
         4HX/N8+qoi/Pnx/Z4tthJDMNXQeNNNHyEJfQ3fA5lIJEAcvzsI1bt18UHNDXsYf1uwlt
         3B3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FSeMlanFh2svXxaNRkwpD5s2Jt4O19S77leAuNHNOlo=;
        b=Wjem9v6jcn/ZjKylkym0mN2SRjQlllM07che1zwLPNCnD0VKKzxn/1z/mne+4SKI3H
         78LioS+86RE00SjCQoRq4ZHc93nZHMVI+Ve16+Pqe6GcoLkGRbLl9Dv5GckpsAJONsdS
         hdIhrL3gLtAYKrX3iN8j4KtRSM90jcjjKNKfafv9FkIdc1y99ietuYq9k1xJ0czMj7A3
         31LPc4rmF6BopVebfxGPE1oSBjbTaRY6AUrRzltT9qQhJMspfPTunmtPi58PSMwaK10w
         4Y0uMi/dR4u4FPS5TRhogyyoSRB1FTHEXoKYB9fjICDS1vbZ5TMY3spvel2sqlngQGVv
         IRSQ==
X-Gm-Message-State: AOAM531ik0P9s9/Ic/VT+0/0biby1VOh2+8PKv6KMq+1kXbG3Si9DpQM
        +BPqA5ZlyeDEDM2zgQMMnOPr8KdsBvc=
X-Google-Smtp-Source: ABdhPJwOiUymlP+QbQi0YPbdKtc/CtinLbNUGq0oCm+dASSQuAb/kkZiUa6GSMl7RHPrLcE8faIhEQ==
X-Received: by 2002:a17:902:9a4c:b0:156:6735:b438 with SMTP id x12-20020a1709029a4c00b001566735b438mr17862669plv.46.1652707039909;
        Mon, 16 May 2022 06:17:19 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id h17-20020a62b411000000b0050df474e4d2sm6807753pfn.218.2022.05.16.06.17.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 May 2022 06:17:19 -0700 (PDT)
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
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 5/7] x86/entry: Add the C verion of SWITCH_TO_KERNEL_CR3 as switch_to_kernel_cr3()
Date:   Mon, 16 May 2022 21:17:36 +0800
Message-Id: <20220516131739.521817-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220516131739.521817-1-jiangshanlai@gmail.com>
References: <20220516131739.521817-1-jiangshanlai@gmail.com>
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

Add the C version switch_to_kernel_cr3() which implements the macro
SWITCH_TO_KERNEL_CR3() in arch/x86/entry/calling.h.

No functional difference intended.

Note:
The compiler generates "AND $0xe7,%ah" (3 bytes) for the code
"cr3 = user_cr3 & ~PTI_USER_PGTABLE_AND_PCID_MASK" while the ASM code in
SWITCH_TO_KERNEL_CR3() results "AND $0xffffffffffffe7ff,%rax" (6 bytes).

The compiler generates lengthier code for "cr3 |= X86_CR3_PCID_NOFLUSH"
because it uses "MOVABS+OR" (13 bytes) rather than a single
"BTS" (5 bytes).

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry64.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index ace73861c2a0..bd77cc8373ce 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -12,3 +12,27 @@
  * is the PTI user CR3 or both.
  */
 #include <asm/traps.h>
+
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+static __always_inline void pti_switch_to_kernel_cr3(unsigned long user_cr3)
+{
+	/*
+	 * Clear PCID and "PAGE_TABLE_ISOLATION bit", point CR3
+	 * at kernel pagetables:
+	 */
+	unsigned long cr3 = user_cr3 & ~PTI_USER_PGTABLE_AND_PCID_MASK;
+
+	if (static_cpu_has(X86_FEATURE_PCID))
+		cr3 |= X86_CR3_PCID_NOFLUSH;
+
+	native_write_cr3(cr3);
+}
+
+static __always_inline void switch_to_kernel_cr3(void)
+{
+	if (static_cpu_has(X86_FEATURE_PTI))
+		pti_switch_to_kernel_cr3(__native_read_cr3());
+}
+#else
+static __always_inline void switch_to_kernel_cr3(void) {}
+#endif
-- 
2.19.1.6.gb485710b

