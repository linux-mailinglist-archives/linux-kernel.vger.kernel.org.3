Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE4253F05E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbiFFUn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiFFUmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:42:32 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FA5EC3D1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:38:50 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id l81so5810859oif.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BwpkThbvkxh/rjj/lCthjYx3mlhn8/KzxxJnXGD2OHA=;
        b=SSL2Z3v0Q1/TXhdjCDgZ4r07nHHBFwDQFsnuo4DgZJktdlDD5Jk5RSO+k/ok+uEfmz
         bX+DI5w0K+oBd/Zr94iY4dj0FpxC6AcEEBbTtM12T/I+7JJvVaDIb7DkFuFfL0wRYbi7
         lcVH2Q1nH+6H1jnm2Bc1WatfBs9oJb5ts0z7s7iRiyaY7XWuLpgzk6NRYjn3Da3L0ggt
         Q/M9HVnVErPthbUocj1GOeePJ/cvm+ghPl13tfQbyrU8ssJXsdGY+SUbBdwM0LOlNgAG
         V5JGhT0tP1T46DMAJRdk9zm+gJIwTkSX08MUbad6FMdrDSYADPOZJYfzjESCtvqH3W1U
         248A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BwpkThbvkxh/rjj/lCthjYx3mlhn8/KzxxJnXGD2OHA=;
        b=bjARY/UT3n2fxzlstFANDiUDUByfCmFsf8D6z6Ud9dYUei8z+NxQEqtfAn0JwxpN0V
         E8Qn2NJmin6Mka2/YaYiHkwdZTkzU4cnSPVvngpL1f+EdgeI4npeVrrp9feJ9iJ4UGD1
         2NlEbClfsmA0hzJCuFX4MHX7tsuYTD2iQxKadTymSeoSjJaK4MoxnKY+g0ZcZB5/O+04
         Zm3WULajRQEk25rHtM5KQXZvGM5xz4cvGSpDLIs6yPwYWEduv83RySflwMCFqUqDjjgK
         bURGd+CWoGpRZwFjbt2iZ0bB8ufc//vJqIY5NOnMG6GMOH/tAx7UrlLi1gu7jMWmlAV6
         Nt3Q==
X-Gm-Message-State: AOAM531C47TbF/FzkLAyhwXJ/UpiJiaJAEG9oIrNDZVdmqR+Vqg48K5k
        rQurEln7KwHiG3nZpokDaoQKkaWgMA==
X-Google-Smtp-Source: ABdhPJzxUopmRGqTGnu9FwlgxPrvrrjfQPsdkdjIYjuQQUCjkJ3F3QyV84qIUEZWPStsuVVyfxZQRA==
X-Received: by 2002:a05:6808:170a:b0:2fa:7168:392b with SMTP id bc10-20020a056808170a00b002fa7168392bmr31019896oib.84.1654547929133;
        Mon, 06 Jun 2022 13:38:49 -0700 (PDT)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id j22-20020a056808035600b0032e3cca8561sm4327188oie.21.2022.06.06.13.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:38:48 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 2/8] x86/signal: Remove sigset_t parameter from frame setup functions
Date:   Mon,  6 Jun 2022 16:37:56 -0400
Message-Id: <20220606203802.158958-3-brgerst@gmail.com>
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

Push down the call to sigmask_to_save() into the frame setup functions.
This removes the use of compat_sigset_t outside of the compat code.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/ia32/ia32_signal.c       |  8 ++++----
 arch/x86/include/asm/fpu/signal.h |  6 ++----
 arch/x86/include/asm/signal.h     |  5 -----
 arch/x86/kernel/signal.c          | 28 ++++++++++++----------------
 4 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 390347ab92de..b67e27685d46 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -230,9 +230,9 @@ static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 	return (void __user *) sp;
 }
 
-int ia32_setup_frame(struct ksignal *ksig,
-		     compat_sigset_t *set, struct pt_regs *regs)
+int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
+	compat_sigset_t *set = (compat_sigset_t *) sigmask_to_save();
 	struct sigframe_ia32 __user *frame;
 	void __user *restorer;
 	void __user *fp = NULL;
@@ -296,9 +296,9 @@ int ia32_setup_frame(struct ksignal *ksig,
 	return -EFAULT;
 }
 
-int ia32_setup_rt_frame(struct ksignal *ksig,
-			compat_sigset_t *set, struct pt_regs *regs)
+int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
+	compat_sigset_t *set = (compat_sigset_t *) sigmask_to_save();
 	struct rt_sigframe_ia32 __user *frame;
 	void __user *restorer;
 	void __user *fp = NULL;
diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 08826ad0254d..2f255aca5622 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -14,10 +14,8 @@
 # include <uapi/asm/sigcontext.h>
 # include <asm/user32.h>
 struct ksignal;
-int ia32_setup_rt_frame(struct ksignal *ksig,
-			compat_sigset_t *set, struct pt_regs *regs);
-int ia32_setup_frame(struct ksignal *ksig,
-		     compat_sigset_t *set, struct pt_regs *regs);
+int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
+int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs);
 #else
 # define user_i387_ia32_struct	user_i387_struct
 # define user32_fxsr_struct	user_fxsr_struct
diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index 2dfb5fea13af..4a4043ca6493 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -28,11 +28,6 @@ typedef struct {
 #define SA_IA32_ABI	0x02000000u
 #define SA_X32_ABI	0x01000000u
 
-#ifndef CONFIG_COMPAT
-#define compat_sigset_t compat_sigset_t
-typedef sigset_t compat_sigset_t;
-#endif
-
 #endif /* __ASSEMBLY__ */
 #include <uapi/asm/signal.h>
 #ifndef __ASSEMBLY__
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 40b1373bb70b..489a0859afd2 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -324,9 +324,9 @@ static const struct {
 };
 
 static int
-__setup_frame(struct ksignal *ksig, sigset_t *set,
-	      struct pt_regs *regs)
+__setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
+	sigset_t *set = sigmask_to_save();
 	struct sigframe __user *frame;
 	void __user *restorer;
 	void __user *fp = NULL;
@@ -379,9 +379,9 @@ __setup_frame(struct ksignal *ksig, sigset_t *set,
 	return -EFAULT;
 }
 
-static int __setup_rt_frame(struct ksignal *ksig,
-			    sigset_t *set, struct pt_regs *regs)
+static int __setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
+	sigset_t *set = sigmask_to_save();
 	struct rt_sigframe __user *frame;
 	void __user *restorer;
 	void __user *fp = NULL;
@@ -458,9 +458,9 @@ static unsigned long frame_uc_flags(struct pt_regs *regs)
 	return flags;
 }
 
-static int __setup_rt_frame(struct ksignal *ksig,
-			    sigset_t *set, struct pt_regs *regs)
+static int __setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
+	sigset_t *set = sigmask_to_save();
 	struct rt_sigframe __user *frame;
 	void __user *fp = NULL;
 	unsigned long uc_flags;
@@ -560,11 +560,10 @@ int copy_siginfo_to_user32(struct compat_siginfo __user *to,
 }
 #endif /* CONFIG_X86_X32_ABI */
 
-static int x32_setup_rt_frame(struct ksignal *ksig,
-			      compat_sigset_t *set,
-			      struct pt_regs *regs)
+static int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
 #ifdef CONFIG_X86_X32_ABI
+	compat_sigset_t *set = (compat_sigset_t *) sigmask_to_save();
 	struct rt_sigframe_x32 __user *frame;
 	unsigned long uc_flags;
 	void __user *restorer;
@@ -763,22 +762,19 @@ static inline int is_x32_frame(struct ksignal *ksig)
 static int
 setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
-	sigset_t *set = sigmask_to_save();
-	compat_sigset_t *cset = (compat_sigset_t *) set;
-
 	/* Perform fixup for the pre-signal frame. */
 	rseq_signal_deliver(ksig, regs);
 
 	/* Set up the stack frame */
 	if (is_ia32_frame(ksig)) {
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO)
-			return ia32_setup_rt_frame(ksig, cset, regs);
+			return ia32_setup_rt_frame(ksig, regs);
 		else
-			return ia32_setup_frame(ksig, cset, regs);
+			return ia32_setup_frame(ksig, regs);
 	} else if (is_x32_frame(ksig)) {
-		return x32_setup_rt_frame(ksig, cset, regs);
+		return x32_setup_rt_frame(ksig, regs);
 	} else {
-		return __setup_rt_frame(ksig, set, regs);
+		return __setup_rt_frame(ksig, regs);
 	}
 }
 
-- 
2.35.3

