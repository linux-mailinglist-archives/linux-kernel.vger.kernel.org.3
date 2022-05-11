Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509F1522D50
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242924AbiEKH2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242921AbiEKH15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:27:57 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82723AA63
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:27:56 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n8so1080282plh.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QCT2LbXITXaXg1IP5G0BZIj7t3pQnzQLCDE67J//+m0=;
        b=WCh8jTEBtYga4RnW8R0dDgoAWfGSj1X9VsFDHHrAs6qu9ulzVaT1ISO6sVdqMIfmV3
         ICH6fLUghmDrbvY3uNAjOBavJR2SM6RQ80chgPBLXXgVQuMOBKzFD1CXxiOT+JwaRxKr
         qflg/IBXD5QDI4tQsUethlRaBJkDGGafck0wyU3UhCFDhT83W/4/jlwlfTsXxSPRLYsn
         gASe50r/wpsC1I2KBfonRvghziY6U7W3h0+bB0FA6o8OqbnJuKLMNmnfa/wgFmkVxJwj
         Y1z7VEa8pmZ9KTa7EcdbFsEaAqQIiHk+7w+0FsmvT71nDSi5GrymkptDoddXk9+/cSjW
         mfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QCT2LbXITXaXg1IP5G0BZIj7t3pQnzQLCDE67J//+m0=;
        b=4dIvKfS38KvoBwY9obqaERy1XQoQS6kL/nlIY2z6evFvZoSa5grZedtP/Gcz88Twjk
         1iNykT02SOD/1a24vFWtuZM9Gld+OWw+LQvqgcGN8cqVoGn2EHOLlHKlBiyOso/1Gxpu
         vSHwqAKKpg84t2qqAmTQtlHdoFoLFAcZmtu9fgTOGCAY0i8iEGT+WpiSS6r7iskv695R
         9I5xOr/QntKdngSeiBX6vbSNYIW1BVN5zvGlolL5z89v9fg1aslJDBAvdPB0ysz23e4E
         gCTrqASNmnJdzpDpeeBjEzJILAaQJu9AFbrMIksN1rnbAm7V1RXytp3hhyDUxlV8wZHi
         SnXQ==
X-Gm-Message-State: AOAM533eOtbldLEr3XZp9/+u9bThy09ZxWD5JAPgxtWWSiQ0UOzyv3Mt
        bfscV3VmH1Nl8b9GPdh0ZLi7qIHBrfc=
X-Google-Smtp-Source: ABdhPJzQX7ce+QdzR67oV2Ue6B/1loxjFuPDBDFPk/rF8o9MvuobsIpNt+mmLM851ou9V6d6EaJekA==
X-Received: by 2002:a17:90a:ea18:b0:1da:4630:513d with SMTP id w24-20020a17090aea1800b001da4630513dmr3881405pjy.237.1652254076219;
        Wed, 11 May 2022 00:27:56 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id z5-20020aa785c5000000b0050dc76281ddsm837343pfn.183.2022.05.11.00.27.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 May 2022 00:27:55 -0700 (PDT)
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
Subject: [PATCH 5/7] x86/entry: Add the C verion of SWITCH_TO_KERNEL_CR3 as switch_to_kernel_cr3()
Date:   Wed, 11 May 2022 15:27:45 +0800
Message-Id: <20220511072747.3960-6-jiangshanlai@gmail.com>
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

Add the C version switch_to_kernel_cr3() which implements the macro
SWITCH_TO_KERNEL_CR3() in arch/x86/entry/calling.h.

No functional difference intended.

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

