Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3304A91CD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356343AbiBDA5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 19:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbiBDA5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:57:51 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53015C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 16:57:51 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a88-20020a25a1e1000000b00615c588ab22so9711282ybi.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 16:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1AAgfaFCn4Q/G5C0Wk6e2sKuKz1QEQmvxvJQx3MfWP4=;
        b=hEAbRl5ZDxJCiDNHkRzo/kfUhjnU3E43u0pltUAJiO81qU8GC7jGCcUqO3JvC0LfYG
         sWd5tVX/wfoW8pdqsd63kZRV87Rc8z4WCQFnc3rXqGbxxbl23oRkj0UIsQsF1vS2HBVD
         IoEnYcDcTpp27vum0aSPkWFnLk0PL5B+tjCkRc43cgidM5VeOtSKEpZ3me3YYv4IWULE
         DZ1/Gz/BgIpBrpFMtpBOs6YEBJAKIiRf9sOmP3aUfG+TTm34G5/1iXXvQCS/hIa+seXj
         iEcCUXiax5gRlswuad1PvOhLxOvpSEvFNyRM5jMF6mPSbuOraG9uMVUx+tfbCibB5tiQ
         5NRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1AAgfaFCn4Q/G5C0Wk6e2sKuKz1QEQmvxvJQx3MfWP4=;
        b=RJZwcWJz2qqYJbQK69U5YCH2Df5XUxTBLSR2MxlFbaMYZ6GeqOUUMtjj4vct/0JqJL
         B8dCXuj+Ygl4bVtaNnoZiiPiIyzJlGF2M+ykAkf/zFMuHOkFpG8dvaj6sLy12hiqX/aX
         1mtxxmkiQAMLYBk/Ks7UFRK9wdRztLz2fDhS8M4b/FTB7nRKnZ45sRASsG4a4DUFXmo9
         xDW+tHQcTR/tqDr655iffkFEfMIMQ1g4TXae9hu2SEucBge7/bVA7zkMD9sclNgFEDHY
         xg+bP9r0OomxaJT5HTTIgpm3PnA29+C44rWLdu1k807yVJxQ5LJqCbHrnTzN9UpSZKx6
         6ylw==
X-Gm-Message-State: AOAM530EpQsWZgoVr8enXwrjaXYeV5xef1KxyDr+IuQHgGoyNE87FL2A
        kFaF/skS/bNGO/ynwZAC9ShCaSdK
X-Google-Smtp-Source: ABdhPJwH8LAmI4OsxnFxSC7ic6V69EvrB179vihRyydzNi5v/S7BpOgueZNTSI5K9U2DuX9IUni5Y4r0jw==
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:e2a5:b92b:16d1:6c85])
 (user=morbo job=sendgmr) by 2002:a25:7188:: with SMTP id m130mr730885ybc.149.1643936270495;
 Thu, 03 Feb 2022 16:57:50 -0800 (PST)
Date:   Thu,  3 Feb 2022 16:57:42 -0800
In-Reply-To: <20211229021258.176670-1-morbo@google.com>
Message-Id: <20220204005742.1222997-1-morbo@google.com>
Mime-Version: 1.0
References: <20211229021258.176670-1-morbo@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v3] x86: use builtins to read eflags
From:   Bill Wendling <morbo@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, llvm@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC and Clang both have builtins to read and write the EFLAGS register.
This allows the compiler to determine the best way to generate this
code, which can improve code generation.

This issue arose due to Clang's issue with the "=rm" constraint.  Clang
chooses to be conservative in these situations, and so uses memory
instead of registers. This is a known issue, which is currently being
addressed.

However, using builtins is benefiical in general, because it removes the
burden of determining what's the way to read the flags register from the
programmer and places it on to the compiler, which has the information
needed to make that decision. Indeed, this piece of code has had several
changes over the years, some of which were pinging back and forth to
determine the correct constraints to use.

With this change, Clang generates better code:

Original code:
        movq    $0, -48(%rbp)
        #APP
        # __raw_save_flags
        pushfq
        popq    -48(%rbp)
        #NO_APP
        movq    -48(%rbp), %rbx

New code:
        pushfq
        popq    %rbx
        #APP

Note that the stack slot in the original code is no longer needed in the
new code, saving a small amount of stack space.

There is no change to GCC's ouput:

Original code:

        # __raw_save_flags
        pushf ; pop %r13        # flags

New code:

	pushfq
        popq    %r13    # _23

Signed-off-by: Bill Wendling <morbo@google.com>
---
v3: - Add blurb indicating that GCC's output hasn't changed.
v2: - Kept the original function to retain the out-of-line symbol.
    - Improved the commit message.
    - Note that I couldn't use Nick's suggestion of

        return IS_ENABLED(CONFIG_X86_64) ? ...

      because Clang complains about using __builtin_ia32_readeflags_u32 in
      64-bit mode.
---
 arch/x86/include/asm/irqflags.h | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 87761396e8cc0..f31a035f3c6a9 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -19,20 +19,11 @@
 extern inline unsigned long native_save_fl(void);
 extern __always_inline unsigned long native_save_fl(void)
 {
-	unsigned long flags;
-
-	/*
-	 * "=rm" is safe here, because "pop" adjusts the stack before
-	 * it evaluates its effective address -- this is part of the
-	 * documented behavior of the "pop" instruction.
-	 */
-	asm volatile("# __raw_save_flags\n\t"
-		     "pushf ; pop %0"
-		     : "=rm" (flags)
-		     : /* no input */
-		     : "memory");
-
-	return flags;
+#ifdef CONFIG_X86_64
+	return __builtin_ia32_readeflags_u64();
+#else
+	return __builtin_ia32_readeflags_u32();
+#endif
 }
 
 static __always_inline void native_irq_disable(void)
-- 
2.35.0.263.gb82422642f-goog

