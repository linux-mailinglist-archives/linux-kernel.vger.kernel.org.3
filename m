Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE534C968F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbiCAUWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238151AbiCAUWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:22:06 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD0090CC3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:19:20 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id x1-20020a25a001000000b0061c64ee0196so14954314ybh.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 12:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=quppVwnUISU7TfZLtg6Eh0xsh3Anim5A+SHrnN5PAxA=;
        b=dstVN1MG0E0Wku8bg7OZHwlYl3k4fRAAKqxkrgt8Wyp7epBtfrvC5hv1quH/9Nxvs2
         MSlQ/AOWpu+pPJKC86cmHaKW+E0reh+qnoole26UOR6eAoFO75K0hRQVvLdbfmkTHA9D
         Hy9H50V7MV+i+AnW5M8lnVTHHu+p82g8+9zC5RetGu8/Uw1Lq19TSsU55ReyJyWz3fka
         v/vCVcMLafmWmFuwHvsmtbyXW1SdYMxCvVmzJPp70mX82J/JOXVHtvy0yB6hnq0wpvv+
         04XI3/SXTg5dgpXRpo3kWpM7vTb90XnxZUI+Nhop0ZYgdi9OG/50ncr57BVMfzIZS2mo
         yj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=quppVwnUISU7TfZLtg6Eh0xsh3Anim5A+SHrnN5PAxA=;
        b=IFWbsbWBtGCxHVyovHizsgsrsarbXfmFQnrHY5aUaI3RsbSO1UATa2MwVNSQ7UH3F1
         ops8Y5uYIHL2qFrXv3cRp4uQmSVdtgdcuLRg5AuymdPDAGomRdHqI6CCKOZNzMdCvLhA
         CUWi5azXkUYD/xisJAhAblSSW9HJfWbd/c7QZvAWvZZU3Af4IGMrLNgCQPU0Qt4+usu+
         6tKJoXD9USndqgQiKq4p6g4Knzrh5bSOaRYO193Ein9CAKtzz8M9oH5oUZjUZ7oFOGv8
         0soVe7k998v5rGpMKVQKkMywogZejIsVB0DX/zLfFPaZfGHtucT2ibfAMw6Pj24vHxhu
         YoRg==
X-Gm-Message-State: AOAM533ZCBvxsPshQBtBynYdxYw5bDLgGIwd8DC8uWegP405mbLraNBa
        IXO2S5OBbfmLX7rtcmPwAgbJF8BT
X-Google-Smtp-Source: ABdhPJxtCLNF5JJSuT8VgsritX9QLI0GvaziYehWNNPfiFminjqnigQ3YH7WcOT/H+Y+EYLl27pvkcRi/g==
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:6982:9c91:c0de:5225])
 (user=morbo job=sendgmr) by 2002:a81:b288:0:b0:2d6:39d5:31a1 with SMTP id
 q130-20020a81b288000000b002d639d531a1mr26463549ywh.506.1646165955150; Tue, 01
 Mar 2022 12:19:15 -0800 (PST)
Date:   Tue,  1 Mar 2022 12:19:03 -0800
In-Reply-To: <20220210223134.233757-1-morbo@google.com>
Message-Id: <20220301201903.4113977-1-morbo@google.com>
Mime-Version: 1.0
References: <20220210223134.233757-1-morbo@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v5] x86: use builtins to read eflags
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
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This issue arose due to Clang's issue with the "=rm" constraint. Clang
chooses to be conservative in these situations and always uses memory
instead of registers, resulting in sub-optimal code. (This is a known
issue, which is currently being addressed.)

This function has gone through numerous changes over the years:

  - The original version of this function used the "=g" constraint,
    which has the following description:

      Any register, memory or immediate integer operand is allowed,
      except for registers that are not general registers.

  - This was changed to "=r" in commit f1f029c7bfbf ("x86: fix assembly
    constraints in native_save_fl()"), because someone noticed that:

      the offset of the flags variable from the stack pointer will
      change when the pushf is performed. gcc doesn't attempt to
      understand that fact, and address used for pop will still be the
      same. It will write to somewhere near flags on the stack but not
      actually into it and overwrite some other value.

  - However, commit f1f029c7bfbf ("x86: fix assembly constraints in
    native_save_fl()") was partially reverted in commit ab94fcf528d1
    ("x86: allow "=rm" in native_save_fl()"), because the original
    reporter of the issue was using a broken x86 simulator. The
    justification for this change was:

      "=rm" is allowed in this context, because "pop" is explicitly
      defined to adjust the stack pointer *before* it evaluates its
      effective address, if it has one.  Thus, we do end up writing to
      the correct address even if we use an on-stack memory argument.

Clang generates good code when the builtins are used. On one benchmark,
a hotspot in kmem_cache_free went from using 5.18% of cycles popping to
a memory address to 0.13% popping to a register. This benefit is
magnified given that this code is inlined in numerous places in the
kernel.

The builtins also help GCC. It allows GCC (and Clang) to reduce register
pressure and, consequently, register spills by rescheduling
instructions. It can't happen with instructions in inline assembly,
because compilers view inline assembly blocks as "black boxes," whose
instructions can't be rescheduled.

Another benefit of builtins over asm blocks is that compilers are able
to make more precise inlining decisions, since they no longer need to
rely on imprecise measures based on newline counts.

A trivial example demonstrates this code motion.

	void y(void);
	unsigned long x(void) {
		unsigned long v = __builtin_ia32_readeflags_u64();
		y();
		return v;
	}

GCC at -O1:
	pushq   %rbx
	pushfq
	popq    %rbx
	movl    $0, %eax
	call    y
	movq    %rbx, %rax
	popq    %rbx
	ret

GCC at -O2:
	pushq   %r12
	pushfq
	xorl    %eax, %eax
	popq    %r12
	call    y
	movq    %r12, %rax
	popq    %r12
	ret

Link: https://gist.github.com/nickdesaulniers/b4d0f6e26f8cbef0ae4c5352cfeaca67
Link: https://github.com/llvm/llvm-project/issues/20571
Link: https://gcc.gnu.org/onlinedocs/gcc/Simple-Constraints.html#Simple-Constraints
Link: https://godbolt.org/z/5n3Eov1xT
Signed-off-by: Bill Wendling <morbo@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
v5: - Incorporate Nick's suggestion to limit the change to Clang >= 14.0 and
      GCC.
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
 arch/x86/include/asm/irqflags.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 87761396e8cc..2eded855f6ab 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -19,6 +19,11 @@
 extern inline unsigned long native_save_fl(void);
 extern __always_inline unsigned long native_save_fl(void)
 {
+#if defined(CC_IS_CLANG) && defined(UNWINDER_ORC) && CLANG_VERSION < 140000
+	/*
+	 * Clang forced frame pointers via the builtins until Clang-14. Use
+	 * this as a fall-back until the minimum Clang version is >= 14.0.
+	 */
 	unsigned long flags;
 
 	/*
@@ -33,6 +38,11 @@ extern __always_inline unsigned long native_save_fl(void)
 		     : "memory");
 
 	return flags;
+#elif defined(CONFIG_X86_64)
+	return __builtin_ia32_readeflags_u64();
+#else
+	return __builtin_ia32_readeflags_u32();
+#endif
 }
 
 static __always_inline void native_irq_disable(void)
-- 
2.35.1.574.g5d30c73bfb-goog

