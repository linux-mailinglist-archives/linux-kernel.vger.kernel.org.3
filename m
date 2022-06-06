Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F8853EBE3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbiFFOoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239910AbiFFOof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:44:35 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0232C50074
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:44:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b135so12852471pfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OkYs0lk3nHyAZKJDGCn/29siMwWnrfKmu5gV1SS4NfQ=;
        b=M8NSMNiAVGRL+nc2mCIZaZ52gNNlHv8ElkKTH8jMWhW6xYbpoJqgWNTveOmWj+1VvN
         5Pxw/X7rDUCCWrK1Lwtx+GnHB4eRtniUw6zQyhdkyFaOYKRknod5kLfZ+gglaM1Jqkg5
         FSmzdu/P7mLn7MDh8T3Bma2ZSKZySHLfNnoJgHM/WCQHuIokrSAR+VlZ67ouch65D4B/
         5kfFTTUK7MEXauaF7F71rJUaVFpwnHYP1XJ4Z7bg2zcgWDcY7GccWB7cOvKbySi+pkQP
         Zut6wSD1y0/SOXFnEVM5ZZaBfmzs+UUGCCpXYJb1muBe/pAGDHdBMmWy+RQGMgsdRbgk
         xx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OkYs0lk3nHyAZKJDGCn/29siMwWnrfKmu5gV1SS4NfQ=;
        b=MawyNES1m55mgst1rIGJ4vnpGhr3083aFepyJ8iZ20AKeJcSKjEQkgLUJmSS3ou4Wy
         ljSxJnY801z8X/UkjMTsq9IRncMAa2Lfrd/sBm33bTO9z4nkj3fO4F43Vo7/VOM3zIZn
         BfHjzAhxDTXs3wsvquNuRzRw7oVLCmHQv6biw1hW+dSTsriU5fG35ZP1emfT6p8x7fPS
         7lQ+Rm32tUGXHRKXAggR2jhaYIHiMmtHz4IC6zTev2wRNpycci3bQ/PPsHcLIj7T4VfW
         Sz2xMeIkFzFv2HiuapDHDMAoJKKqN7v0Cq98h224yvPP0Ok2dfMI/o0MRLVYtW7yCPG5
         CspA==
X-Gm-Message-State: AOAM531HaaWNkJf5R9iqXvbrHqtQHhEixq0vKBuVYlJn9OdiMYtz86TA
        FZmkLl0oddDmg4WghLCjUGAfrcigy5Q=
X-Google-Smtp-Source: ABdhPJyRBekBNDNM20UyEIByz6XPcXR4ORScgmrN+JyQ3HZtrYfwDUB208Oyc/OPFI3sE8yVlbazDA==
X-Received: by 2002:a65:6d87:0:b0:3fd:a62e:dc0a with SMTP id bc7-20020a656d87000000b003fda62edc0amr6427969pgb.286.1654526673290;
        Mon, 06 Jun 2022 07:44:33 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id iw22-20020a170903045600b0015e8d4eb2afsm10666584plb.249.2022.06.06.07.44.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2022 07:44:32 -0700 (PDT)
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
Subject: [PATCH V3 2/7] x86/entry: Move PTI_USER_* to arch/x86/include/asm/processor-flags.h
Date:   Mon,  6 Jun 2022 22:45:04 +0800
Message-Id: <20220606144509.617611-3-jiangshanlai@gmail.com>
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

These constants will be also used in C file.

Move them to arch/x86/include/asm/processor-flags.h which already has
a kin X86_CR3_PTI_PCID_USER_BIT defined.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/calling.h               | 10 ----------
 arch/x86/include/asm/processor-flags.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 29b36e9e4e74..331a44994cc0 100644
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

