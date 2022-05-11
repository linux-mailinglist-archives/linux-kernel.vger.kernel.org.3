Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03C6522D47
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242724AbiEKH1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242910AbiEKH1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:27:05 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC6E3BF90
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:27:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so3215329pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cjE84FymrEK7bxD5XFoGhOeZrQEQrNAiUbfRS8xIEcU=;
        b=klbQJoWUooPPrElfPbe90DkbxVaCHOjQgHPdPkWZ9EL5GUtvOVe6OiRplW16LY4ZY5
         k8MgfzvLE5cVP4mK9AdasxgHCTaqOUw/FvRPM7VpBFMUygJKJVnPWeCx+sqTx4DSyR/j
         8A8/xgSnuVKWSqsp9caBimzpCSkf+IaINHQiUbMs+a67mGe/+A1Re38gsvN6Ds5ojn7A
         W8P3Pgz+HnapBe7IoINiyzlspoyskQng/glCIzer8vIwIOM0o0E7P+pRHSvgqMCJpbZx
         9bliRghw2MYr/GLeB+QvWR0C5QQKxPbBXCsbarHNF+aJj100F9bCh7YiAKauwvOL4SW5
         uqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cjE84FymrEK7bxD5XFoGhOeZrQEQrNAiUbfRS8xIEcU=;
        b=Gm7kXrcQnUaqiDX4HJ9YUOHf2hQXpyZCgSOyuhy/lV9z/F/jYV9OfgyWzJNbcne9W4
         C/25YA6VVSTHO1Wxvt+b4LUtwKrD8uC/9rpzkkdjmFRfFEW1FwGt9HmIrzmzD39pXa7f
         IzAtSAvp834a1szSCCxCvXtHVk1/thzD8Yosbrl41bmLcUsPuj6uFSwLJXwMDNdq0M10
         FNuwZ/Nm9L7N++qyjDrztSLufC1qmMQnY5ObhdWpf0VixnQYqBPokANMTTGKxP0Pgr3I
         rDLM0txXDbCZIagJfnXqn33u6OVyjYm6Qht80CLk2/L51AkLNRSH4JYzwvtGF0FcmVvO
         FHjw==
X-Gm-Message-State: AOAM530UIb8r8d4l6iuMLNMR7CZWL5yM06a6DnWqM3vP/g4geRRfPQQ7
        X8icROLK/CewIzjNF7SOsbdbqdD6gik=
X-Google-Smtp-Source: ABdhPJymHzix4/M1wBKJtK96BCPSuwsqFL3j3N0YLQI2kCeEPCOJtMNL++Qz+8/4vKgW26FlWsvwPQ==
X-Received: by 2002:a17:90b:3a86:b0:1dc:2343:2429 with SMTP id om6-20020a17090b3a8600b001dc23432429mr3918001pjb.206.1652254022944;
        Wed, 11 May 2022 00:27:02 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b001cd4989fee1sm3519825pjb.45.2022.05.11.00.27.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 May 2022 00:27:02 -0700 (PDT)
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
Subject: [PATCH 1/7] x86/entry: Introduce __entry_text for entry code written in C
Date:   Wed, 11 May 2022 15:27:41 +0800
Message-Id: <20220511072747.3960-2-jiangshanlai@gmail.com>
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
index 1c2c33ae1b37..8c7e81efe9bf 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -225,9 +225,11 @@ struct ftrace_likely_data {
 #endif
 
 /* Section for code which can't be instrumented at all */
-#define noinstr								\
-	noinline notrace __attribute((__section__(".noinstr.text")))	\
-	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
+#define __noinstr_section(section)				\
+	noinline notrace __section(section) __no_profile	\
+	__no_kcsan __no_sanitize_address __no_sanitize_coverage
+
+#define noinstr __noinstr_section(".noinstr.text")
 
 #endif /* __KERNEL__ */
 
-- 
2.19.1.6.gb485710b

