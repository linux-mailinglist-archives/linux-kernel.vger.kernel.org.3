Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0264B1839
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344944AbiBJWcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:32:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242808AbiBJWcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:32:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5C8BD9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:32:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a12-20020a056902056c00b0061dc0f2a94aso15016846ybt.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gl08/uxFVlmi2wSTq5+9dUe3B/HwzYiRuJoJTn+segs=;
        b=BdC/fKhWAhUYwCbX8kX1FDzZtTY9aXZLZxD44qMz+MrqHmpo9XxkQ1C7btl4i+KBVV
         2Ttqt8x0eMP9PuQygYLTj0RxfbJGpXIFw5IZjpN/3or4BSXmsMctd17EhXpz9MgID3jO
         Q70qwhcGZZ8Q9ILF3wfH79Moln9rfUCDFOmkxEJ40b7+4WFJRQmCmCZl6Gv+hi3LgMGZ
         WQJEhU9pRiMZ2Kl2UcNgWBheBv/L/Q+B9jAavghoGDh76uwwOd+etdfMAMGK2thVbD7W
         cLh1JCBDeH/t5HCTavnLVT+ygkAhzWIOeOoVs5j7GDPwte7Qo8aRpEKtRHBfxq58hsKf
         RM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gl08/uxFVlmi2wSTq5+9dUe3B/HwzYiRuJoJTn+segs=;
        b=31wiwnQWRBo1c39kavC4QDAvVDuomhn/Ombe37Vvd8OylIR5bdB9mbufxUEqQpc5DB
         2jsMc+eUVlkKwhf8OBgVjvAnMZjE3IvkcWhjps/K3WRK6HJ1h3kr1LWZXOs8KTjabjTC
         AZwBUJJ5+FG0A6R0pR+JjlqmyBC3FJGkC+P6M1IePglCFyjJfJSZvej03TgGV9OrT6Y1
         +1UyHfGrUtPl2fL2LsWgwGjv1myowgWYvvbp2fXDGLnJPf6+SSbSHF2X6vimW/5cfkrD
         mErwi3ArR+xLEEu/cyMwxoZuNlOta0tJNRPfH0i85KvzlZ4zuxmvSLYyxkE3kzYDroj7
         92xQ==
X-Gm-Message-State: AOAM5300KV1Ds8eD2PuAZArypgpFboHv8KnPCxRmpKkU/QAQKYQPbITM
        8DyomU2MOrCkp935M7/fyPXIxOHX
X-Google-Smtp-Source: ABdhPJzsflLFTtrCxYLYUbOG68XKxeYHkfS3xyNJorZcxmlFdOO6bvUPqjcNKP1xFAdasYI3UiPhTZ8wNQ==
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:2f6e:60d0:d1d5:6d5b])
 (user=morbo job=sendgmr) by 2002:a25:3285:: with SMTP id y127mr9242337yby.205.1644532334603;
 Thu, 10 Feb 2022 14:32:14 -0800 (PST)
Date:   Thu, 10 Feb 2022 14:31:34 -0800
In-Reply-To: <20220204005742.1222997-1-morbo@google.com>
Message-Id: <20220210223134.233757-1-morbo@google.com>
Mime-Version: 1.0
References: <20220204005742.1222997-1-morbo@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v4] x86: use builtins to read eflags
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

However, using builtins is beneficial in general, because it removes the
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

There is no change to GCC's output:

Original code:

        # __raw_save_flags
        pushf ; pop %r13        # flags

New code:

        pushfq
        popq    %r13    # _23

Signed-off-by: Bill Wendling <morbo@google.com>
---
v4: - Clang now no longer generates stack frames when using these builtins.
    - Corrected misspellings.
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
index 87761396e8cc..f31a035f3c6a 100644
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
2.35.1.265.g69c8d7142f-goog

