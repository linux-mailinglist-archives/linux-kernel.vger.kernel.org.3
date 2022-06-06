Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B602553F05C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiFFUnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiFFUmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:42:47 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC247122959
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:38:53 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id x11-20020a4a800b000000b0041a5b6d7c42so2877945oof.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ffXa0Srpu9DUG1vR5Q2Yy9d85Kw9mLdPILu27FpkxDY=;
        b=PIUQ+iLu7lzRky4kxfFQyAkAzQG8t/ZxMGdARewq0AfvvwOIfUACOftWXw6JLRqzta
         ovkqGdhOaaC7OXmICULWuNsDwNVpAQjVSDmiSNBcyo0YnuJaFoVdqDQqZHJP/zJfFHlz
         UhmrX6t2ZLw9j6WCqF4kuuEM1ARneVZ5dWVYGIfM2Xjqwz8i3yWd6FVw2JsU0iVT6iCG
         Eazq+wGYTalQdbcowHFu+keOUVcLeL2dXpoj4efct6/yz4YN4NeLxHmyedGADbIAi8dT
         ybafNlI/J0uJjdpXIW2xfMnF8G7tpElR36Fl4dL5g0HMXUGKAHTwgiLkXr0mjpCCBJKR
         SANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ffXa0Srpu9DUG1vR5Q2Yy9d85Kw9mLdPILu27FpkxDY=;
        b=2KE1Dg8tQx7ldKy4+X3C1lTB6IbXBR80eY/KRP0ZDzSldO87IUyN6zvVrwLgcNYI0j
         g9y4xp0Iq/HlMfBkHegyB1y2E9mM1ZuHBH9eolZrW75K/4jmKnRJaq4YJamtWLwqT77Z
         1NRtobK+gFSTXRlWnaf3l+hA5usiCkXeH4QeJDgoFDjXEBSN9/wviLHXdNVz8GcUzXw1
         HoVHWoH6UqU76QmwHZWTDKLpSxRBE07AEFzn/7a8y2SUrgr2tvnOFr8VlNwR72rRqW18
         W9/KDCnvqJSsehG5kXl0ndkB0uJqED624hBwSpgkmk7JRInnzTjqkafmeTn2BuHo87LE
         LZoQ==
X-Gm-Message-State: AOAM530S/VMLe7UYVSXoHz43GKou1ZPKjt5kPLqcdaqIapdeETqdCvo4
        wPvKzw7eZynRh4h02G5hcLJeqHaj+Q==
X-Google-Smtp-Source: ABdhPJzFIdb/tmerI3hQmpnIL3gi5FSrZcMbhq86a4TB5s3AKiP+u4uGgt2JKuSEkthc0exRIOWthQ==
X-Received: by 2002:a4a:11c7:0:b0:41a:c989:659e with SMTP id 190-20020a4a11c7000000b0041ac989659emr10821998ooc.38.1654547932953;
        Mon, 06 Jun 2022 13:38:52 -0700 (PDT)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id j22-20020a056808035600b0032e3cca8561sm4327188oie.21.2022.06.06.13.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:38:52 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 5/8] x86/signal: Merge get_sigframe()
Date:   Mon,  6 Jun 2022 16:37:59 -0400
Message-Id: <20220606203802.158958-6-brgerst@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220606203802.158958-1-brgerst@gmail.com>
References: <20220606203802.158958-1-brgerst@gmail.com>
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

Adapt the native get_sigframe() function so that the compat signal code
can use it.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/ia32/ia32_signal.c        | 34 -------------
 arch/x86/include/asm/sighandling.h |  4 ++
 arch/x86/kernel/signal.c           | 80 ++++++++++++++----------------
 3 files changed, 42 insertions(+), 76 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index a78885e3e85d..e28421f53d44 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -196,40 +196,6 @@ do {									\
 		goto label;						\
 } while(0)
 
-/*
- * Determine which stack to use..
- */
-static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
-				 size_t frame_size,
-				 void __user **fpstate)
-{
-	unsigned long sp, fx_aligned, math_size;
-
-	/* Default to using normal stack */
-	sp = regs->sp;
-
-	/* This is the X/Open sanctioned signal stack switching.  */
-	if (ksig->ka.sa.sa_flags & SA_ONSTACK)
-		sp = sigsp(sp, ksig);
-	/* This is the legacy signal stack switching. */
-	else if (regs->ss != __USER_DS &&
-		!(ksig->ka.sa.sa_flags & SA_RESTORER) &&
-		 ksig->ka.sa.sa_restorer)
-		sp = (unsigned long) ksig->ka.sa.sa_restorer;
-
-	sp = fpu__alloc_mathframe(sp, 1, &fx_aligned, &math_size);
-	*fpstate = (struct _fpstate_32 __user *) sp;
-	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)fx_aligned,
-				      math_size))
-		return (void __user *) -1L;
-
-	sp -= frame_size;
-	/* Align the stack pointer according to the i386 ABI,
-	 * i.e. so that on function entry ((sp + 4) & 15) == 0. */
-	sp = ((sp + 4) & -16ul) - 4;
-	return (void __user *) sp;
-}
-
 int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
 	compat_sigset_t *set = (compat_sigset_t *) sigmask_to_save();
diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
index 65e667279e0f..c9e9784efe38 100644
--- a/arch/x86/include/asm/sighandling.h
+++ b/arch/x86/include/asm/sighandling.h
@@ -15,4 +15,8 @@
 
 void signal_fault(struct pt_regs *regs, void __user *frame, char *where);
 
+void __user *
+get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
+	     void __user **fpstate);
+
 #endif /* _ASM_X86_SIGHANDLING_H */
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 489a0859afd2..890ca0523570 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -48,6 +48,23 @@
 #include <asm/sigframe.h>
 #include <asm/signal.h>
 
+static inline int is_ia32_compat_frame(struct ksignal *ksig)
+{
+	return IS_ENABLED(CONFIG_IA32_EMULATION) &&
+		ksig->ka.sa.sa_flags & SA_IA32_ABI;
+}
+
+static inline int is_ia32_frame(struct ksignal *ksig)
+{
+	return IS_ENABLED(CONFIG_X86_32) || is_ia32_compat_frame(ksig);
+}
+
+static inline int is_x32_frame(struct ksignal *ksig)
+{
+	return IS_ENABLED(CONFIG_X86_X32_ABI) &&
+		ksig->ka.sa.sa_flags & SA_X32_ABI;
+}
+
 #ifdef CONFIG_X86_64
 /*
  * If regs->ss will cause an IRET fault, change it.  Otherwise leave it
@@ -223,24 +240,12 @@ do {									\
 /*
  * Determine which stack to use..
  */
-static unsigned long align_sigframe(unsigned long sp)
-{
-#ifdef CONFIG_X86_32
-	/*
-	 * Align the stack pointer according to the i386 ABI,
-	 * i.e. so that on function entry ((sp + 4) & 15) == 0.
-	 */
-	sp = ((sp + 4) & -FRAME_ALIGNMENT) - 4;
-#else /* !CONFIG_X86_32 */
-	sp = round_down(sp, FRAME_ALIGNMENT) - 8;
-#endif
-	return sp;
-}
-
-static void __user *
-get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
+void __user *
+get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 	     void __user **fpstate)
 {
+	struct k_sigaction *ka = &ksig->ka;
+	int ia32_frame = is_ia32_frame(ksig);
 	/* Default to using normal stack */
 	bool nested_altstack = on_sig_stack(regs->sp);
 	bool entering_altstack = false;
@@ -249,7 +254,7 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 	unsigned long buf_fx = 0;
 
 	/* redzone */
-	if (IS_ENABLED(CONFIG_X86_64))
+	if (!ia32_frame)
 		sp -= 128;
 
 	/* This is the X/Open sanctioned signal stack switching.  */
@@ -263,7 +268,7 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 			sp = current->sas_ss_sp + current->sas_ss_size;
 			entering_altstack = true;
 		}
-	} else if (IS_ENABLED(CONFIG_X86_32) &&
+	} else if (ia32_frame &&
 		   !nested_altstack &&
 		   regs->ss != __USER_DS &&
 		   !(ka->sa.sa_flags & SA_RESTORER) &&
@@ -273,11 +278,19 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 		entering_altstack = true;
 	}
 
-	sp = fpu__alloc_mathframe(sp, IS_ENABLED(CONFIG_X86_32),
-				  &buf_fx, &math_size);
+	sp = fpu__alloc_mathframe(sp, ia32_frame, &buf_fx, &math_size);
 	*fpstate = (void __user *)sp;
 
-	sp = align_sigframe(sp - frame_size);
+	sp -= frame_size;
+
+	if (ia32_frame)
+		/*
+		 * Align the stack pointer according to the i386 ABI,
+		 * i.e. so that on function entry ((sp + 4) & 15) == 0.
+		 */
+		sp = ((sp + 4) & -FRAME_ALIGNMENT) - 4;
+	else
+		sp = round_down(sp, FRAME_ALIGNMENT) - 8;
 
 	/*
 	 * If we are on the alternate signal stack and would overflow it, don't.
@@ -331,7 +344,7 @@ __setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 	void __user *restorer;
 	void __user *fp = NULL;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fp);
+	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
 
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
@@ -386,7 +399,7 @@ static int __setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	void __user *restorer;
 	void __user *fp = NULL;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fp);
+	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
 
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
@@ -469,7 +482,7 @@ static int __setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
 		return -EFAULT;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(struct rt_sigframe), &fp);
+	frame = get_sigframe(ksig, regs, sizeof(struct rt_sigframe), &fp);
 	uc_flags = frame_uc_flags(regs);
 
 	if (!user_access_begin(frame, sizeof(*frame)))
@@ -572,7 +585,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
 		return -EFAULT;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fp);
+	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
 
 	uc_flags = frame_uc_flags(regs);
 
@@ -742,23 +755,6 @@ unsigned long get_sigframe_size(void)
 	return max_frame_size;
 }
 
-static inline int is_ia32_compat_frame(struct ksignal *ksig)
-{
-	return IS_ENABLED(CONFIG_IA32_EMULATION) &&
-		ksig->ka.sa.sa_flags & SA_IA32_ABI;
-}
-
-static inline int is_ia32_frame(struct ksignal *ksig)
-{
-	return IS_ENABLED(CONFIG_X86_32) || is_ia32_compat_frame(ksig);
-}
-
-static inline int is_x32_frame(struct ksignal *ksig)
-{
-	return IS_ENABLED(CONFIG_X86_X32_ABI) &&
-		ksig->ka.sa.sa_flags & SA_X32_ABI;
-}
-
 static int
 setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
-- 
2.35.3

