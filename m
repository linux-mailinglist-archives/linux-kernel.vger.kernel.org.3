Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8277C528523
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243798AbiEPNRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243733AbiEPNRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:17:08 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9C324595
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:17:07 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 202so14042090pgc.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EGwJvdx17QQnoYP69Pr2C9PuIA0fCg3Px0T/9mdBCv4=;
        b=Sa/AVjaJl2CVdPszAmhuAcV6Mbr8GE/PU96pQtUg/45ECD7xZOOycZUec+JP53+ZSK
         BiLVmf9tWXJUKBCn6Y4nfbsLs6zqCclJaeurHB3WwZAqQ6CP0ut+8CW5iZlfg18H8CNl
         0zndtNZTvH33J1UGPxBUoupht6P5COVr5yqjVa+9ySiAJ3lRhgwpR6I1GC9AHRV8qsH3
         PmI42q7EWuEud2ryZmi424LzgHEPuHn5lM0EdAjsqgnc+kV6LURWvpPRfNRPBfhsRZOL
         o3hc1nOS7QpB4vjBU+QCLNtE+v0AmGoGmI0eioBkhne9tDrhkrpPpZO6Pl5z8FU2Lv2d
         YsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGwJvdx17QQnoYP69Pr2C9PuIA0fCg3Px0T/9mdBCv4=;
        b=0AP2vnt9Gi0hIaf3aPa/5e9sQDe/sCe+L873DaMHu+R0qzyLhXDmJy3e8gccof/p3r
         DgVXQ+qF4K4SR4OhlbnmpUaeQNDJy9+NkLHu4zN8HYV1ndFbXBLk+jub3oKoZX5MnDUW
         hNBnOIZMrtHbyWBQ3qLU5qDrNFqt0mMZ6b9ND+avm4iGciqEHFgd1jIVcggaCkmhhQRR
         GF4vDNaq559JXffH+EuJnXGVigyQqU6Q0rxyM8Bzm8iQXmlLKY+cCaGBxI61nIbusmho
         02ClCso7wxkVSbGtoQcB4A6QXlJYtZ1W1iy7FgYBTwPqRD675zRTqryQeJaK+F/DReSL
         CTKA==
X-Gm-Message-State: AOAM530tsuFEkvoIYYuv17sSePsuPfma7KI0Ujm7CqxFbtHciDgE4j//
        6UH7RN7fxXiqvHbiFEOR+v3tsXxqljk=
X-Google-Smtp-Source: ABdhPJySgi8QBRUrwpM/EHUre4li9fld8uaNY0ZYrkfOf9flWdptIN6jPc1mzar4cffxt9AYpzHR8g==
X-Received: by 2002:a63:f959:0:b0:3da:ed42:5f7c with SMTP id q25-20020a63f959000000b003daed425f7cmr15331306pgk.361.1652707026802;
        Mon, 16 May 2022 06:17:06 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id cu8-20020a056a00448800b0050dc76281b3sm6935816pfb.141.2022.05.16.06.17.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 May 2022 06:17:06 -0700 (PDT)
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
Subject: [PATCH V2 2/7] x86/entry: Move PTI_USER_* to arch/x86/include/asm/processor-flags.h
Date:   Mon, 16 May 2022 21:17:33 +0800
Message-Id: <20220516131739.521817-3-jiangshanlai@gmail.com>
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

These constants will be also used in C file.

Move them to arch/x86/include/asm/processor-flags.h which already has
a kin X86_CR3_PTI_PCID_USER_BIT defined.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/calling.h               | 10 ----------
 arch/x86/include/asm/processor-flags.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 10 deletions(-)

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

