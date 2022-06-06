Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7416453EC39
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbiFFOow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239996AbiFFOot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:44:49 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CF050E1E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:44:48 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 7so12281320pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FSeMlanFh2svXxaNRkwpD5s2Jt4O19S77leAuNHNOlo=;
        b=WyES++Ws5th4dbIFtc9TyfPnVGRjm9A3RdjviwsyL5TUR4voWiPOI22jrHtE09OkBU
         DB+COkkoaryb+TiQZ8xREwMtrGSURLJrFyTgtXUQNFZbZEfpjsjkbjPa7D+NWdMxrza/
         q2pkY393zj9G0k1PphbRqD9U+mf+3uki0YsQb5R7CEi/eJI80836tIn1Kxg75f2WpIpv
         WyzJ1dSJac/oaOmhRLav/5soBFC4jFYdf0CeMxQiIJMUAStPMaDy91HC527UWwZ0HU1J
         QKpTvnc7W4mtU/KWP8N23cUBky5PJ7zCEIMhwYdA42u1+Dh5du2Oct1oi2XEIvyWxO8R
         ofRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FSeMlanFh2svXxaNRkwpD5s2Jt4O19S77leAuNHNOlo=;
        b=hAXLJoN6hOjiAZDhY5YJdJIqWv0nYBprnppsTLSRsD2K5ALDAa7nNRyVS8AW9mT7K8
         Ii28Bt6SJly4W5Xo/uE1naGqukqU7ZqJr23ftpl/hqwcxNtPahYP8hFOyjAkkkWZaoPo
         iideA0rQ2kRhr1T01l44qKxhNFFpEn01YbZp+O5NQPCMRrrUqRymlB803duOexDn4nZ0
         WPIv6ih+EA17in0Ya5RHSnIYol+JaPpFL4RxB2t5hnbOJVaMF2EGXkXfvxtwok49JnxT
         vFNAKxGERKn+3ibN/1UvzgjXVOPxqTFv9rzqrsEjEXbFumaetvRh6QNSHLY4Up6pWuM5
         Md1g==
X-Gm-Message-State: AOAM532/okrTXmj11rr4DXFwfRaS1cnnEOSlsORWNafPzpNXkojm8Us1
        A26C4YRnr7jdGcVNDpqR6lr81RQN+Mo=
X-Google-Smtp-Source: ABdhPJyhjn8JL5F/rkrJLtDcxn01B4M7DGyI+z+JnIQ91v9wV1926Nh2e1nU3mcEEbgLJbfF5Sg9MA==
X-Received: by 2002:a05:6a00:1488:b0:51b:e7a2:9181 with SMTP id v8-20020a056a00148800b0051be7a29181mr16324623pfu.31.1654526687214;
        Mon, 06 Jun 2022 07:44:47 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id r10-20020a170902ea4a00b00163e459be9asm3624550plg.136.2022.06.06.07.44.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2022 07:44:46 -0700 (PDT)
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
Subject: [PATCH V3 5/7] x86/entry: Add the C verion of SWITCH_TO_KERNEL_CR3 as switch_to_kernel_cr3()
Date:   Mon,  6 Jun 2022 22:45:07 +0800
Message-Id: <20220606144509.617611-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220606144509.617611-1-jiangshanlai@gmail.com>
References: <20220606144509.617611-1-jiangshanlai@gmail.com>
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

