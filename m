Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5378A528522
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241023AbiEPNRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241306AbiEPNRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:17:03 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7069D24596
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:17:02 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q7so2992000plx.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jZmFtLhq9vgJsY5ZvagaghPeiw7jxmPgPePzPZmM8XU=;
        b=jFjBVxlpFTvfFJLCXo6/txw0+pGzSPh7KYZJLqbjH1nJx0D2pWAxclCbsJbAOALeWy
         ey4NE3CkBDrzT3YkCXNEA2ruu/Oxs2bl3jy5jXAqtCTdL7cd2hO1YblcMrfqTI0NmIts
         f5kTRHrnetbfvfbpGSzqOYcNG1RVutKa1PW9If2gy6qO9plyS41MM4QX2GhZgDTsDxld
         xXTurcC5tmBWdQO2aNB4y81nV7WSg9c8sOMJZoe6W6PdXNMX/m6EP06Wnls352go2VPu
         pNYcimlePpGexVPj96n/OMCR0fV15GA4qkdBQxJqs3w/DQXIfSll9Z9r+p5FkCzcy+6u
         Jq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jZmFtLhq9vgJsY5ZvagaghPeiw7jxmPgPePzPZmM8XU=;
        b=0JKXQ0vi1og7s8eeaqxehyvneQnwhyPrDMyw0urQAbLb9okMV5EN6cViJW5T96zFWC
         AQJOnMWLKQefEKDRlqE5q/SNw4Q7a5d/geZCbvtt7BHeDXYBeFji3RxnhWkxc89wUfcX
         B49BtxMlZp4ELaP1XrvrjcIMoZSNT7YR5g8s5AzuJne45glbVJDpnylJZ5K+RiV8IFuE
         ZJ+pxU5/0K9xzXlKWCVO2wxzQR4T44x3GUvqEN+qBY+fE1HBA93o/EsZAgT2D9CLCc+q
         ZClp5GzymeOgzxG4eP4xsenORhg/HCrqmQTwPZuymSMu8UQGyuFFN3DSSY70HDdhU8VG
         W/YQ==
X-Gm-Message-State: AOAM532E9e09FJyVjWbkwyK5dIXCaQ7Tyo2Ob79t5O++Txi9Im/Eq4Ep
        LqT6J/kY6c9SnYMYr7/yKQ/2FSfoeuU=
X-Google-Smtp-Source: ABdhPJy0NlFZsDxGG3uSQhrh6lT3zfuZnDqldMs9IzpBEwGV5Iop4UOrgNtU83wuKwZYvM8+15HaLQ==
X-Received: by 2002:a17:903:11d1:b0:151:9fb2:9858 with SMTP id q17-20020a17090311d100b001519fb29858mr17235691plh.136.1652707021633;
        Mon, 16 May 2022 06:17:01 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id n12-20020a17090aab8c00b001df4c27e5a5sm2359592pjq.35.2022.05.16.06.17.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 May 2022 06:17:01 -0700 (PDT)
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
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Marco Elver <elver@google.com>, Hao Luo <haoluo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH V2 1/7] x86/entry: Introduce __entry_text for entry code written in C
Date:   Mon, 16 May 2022 21:17:32 +0800
Message-Id: <20220516131739.521817-2-jiangshanlai@gmail.com>
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

Some entry code will be implemented in C files.
Introduce __entry_text to set them in .entry.text section.

The new __entry_text disables instrumentation like noinstr, so
__noinstr_section() is added for noinstr and the new __entry_text.

Note, entry code can not access to %gs before the %gs base is switched
to kernel %gs base, so stack protector can not be used on the C entry
code.  But __entry_text doesn't disable stack protector since some
compilers might not support function level granular attribute to
disable stack protector.  It will be disabled in C file level.

Cc: Borislav Petkov <bp@alien8.de>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/include/asm/idtentry.h | 3 +++
 include/linux/compiler_types.h  | 8 +++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 72184b0b2219..acc4c99f801c 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -13,6 +13,9 @@
 
 #include <asm/irq_stack.h>
 
+/* Entry code written in C. */
+#define __entry_text __noinstr_section(".entry.text")
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 1c2c33ae1b37..1d6580ccb081 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -225,9 +225,11 @@ struct ftrace_likely_data {
 #endif
 
 /* Section for code which can't be instrumented at all */
-#define noinstr								\
-	noinline notrace __attribute((__section__(".noinstr.text")))	\
-	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
+#define __noinstr_section(section)				\
+	noinline notrace __section(section) __no_kcsan		\
+	__no_sanitize_address __no_profile __no_sanitize_coverage
+
+#define noinstr __noinstr_section(".noinstr.text")
 
 #endif /* __KERNEL__ */
 
-- 
2.19.1.6.gb485710b

