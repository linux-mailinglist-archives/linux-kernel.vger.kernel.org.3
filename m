Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150CE53E89E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbiFFOoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239823AbiFFOo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:44:29 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC235000A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:44:28 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w13-20020a17090a780d00b001e8961b355dso853770pjk.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J0AjupS423IcVxPOF8+Ias71Zs7GJnxkL456RKcGoI4=;
        b=N96+7PHU+aEx81sVHh6CFec/XmlIA4EYXB8GPuNvzQ3gFS/MAzcwvGBdtU9oazZzf1
         lccNpukP/evxop0gpJssxdVvPC9+FW3LTlYWGsH0ZPzP4xGQiXDrpiLlqt5sZPtK9mJk
         r+w//DfnS8SM51tMbLkhxRwk8EhRSh+VRG1O9xhKZTW9x2qn94N0BV6ITq9sez5z/lXi
         D/HPH7EYhHxDwrEJKezy3M74vUGaidaXI2jrhgRQsnCcYLYG9riapBkGIOY7vVb5R2t1
         zDeszG5J/d4BvkgNfviauw+gb5lqRwwimAwuG3WEpYeNHRVmitVkhiurdWJbqqmemRRw
         utcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J0AjupS423IcVxPOF8+Ias71Zs7GJnxkL456RKcGoI4=;
        b=T3qd5RkctF9zHaRVjrvThSOkmqRfRTJJ7l+DLDAPcIu6p/jDFgNGbX/KYt+QucBG7z
         Q6MNHxkR5ZJiWWqWQOWRBqMdKWGBi0c6hXc7EoF4JmpchYii/LKggYOIZKrdz/HYA8Zf
         qtuc0+5bCCaQe8bL5ohsOYSWmM1JcGPQlulypvtmUEwXy6JG0tTHghTXM2QQ+a1lYJcV
         WQZ9iYcbcYHu/aT5VCyXjESNqNwZGfYc7mdW4jz9AT3J7pKayTjZbxqsgX2aigwWM7Pa
         Cf68GH0ssJhrFQzaq85BP6BUJ8Q9wdN4EoF3LGA+nGwgPlc5KLCmmd2ToZ+Q0Q7ClmcD
         Wbvg==
X-Gm-Message-State: AOAM530rWY/BYPCYq8JZlpIJUnfACmXG4iBaVoZVjKML2POBzeIlLngA
        eaLLIqEIc2WP0XJlgMpEdWKvqVHe3Pw=
X-Google-Smtp-Source: ABdhPJz/kDVaaM5WXkqM1kL/NfpKznIoYnd07CGUfIgO5QKGW1t3iSzuXEPbI6rpwgXQTiSC4PlQ/A==
X-Received: by 2002:a17:90a:9f04:b0:1e3:2d77:3eae with SMTP id n4-20020a17090a9f0400b001e32d773eaemr38454049pjp.243.1654526667932;
        Mon, 06 Jun 2022 07:44:27 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902eb8e00b001615f64aaabsm6200271plg.244.2022.06.06.07.44.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2022 07:44:27 -0700 (PDT)
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
        Sean Christopherson <seanjc@google.com>,
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
Subject: [PATCH V3 1/7] x86/entry: Introduce __entry_text for entry code written in C
Date:   Mon,  6 Jun 2022 22:45:03 +0800
Message-Id: <20220606144509.617611-2-jiangshanlai@gmail.com>
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
index d08dfcb0ac68..bd9d9d19dc9b 100644
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

