Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B6953F059
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiFFUm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbiFFUm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:42:28 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BD51203FB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:38:49 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-fb6b4da1dfso2613921fac.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ysbTnxMyTI7DA06kRA/I/BJnOe40tZ93n6R0vsgYdKA=;
        b=iAVzH1ORlcaCwh4OShvMXQ6EwyCa/kxQR5eF6qaHNV8VRYUTO3ep/UT6gHTGZpsHhi
         5gU63AFMGcaBlP6wp6onSY9wwxD/zeNiE3Okdxat9X/aOdBloKhOWvpSM8W+1Qr/88v5
         wxOayY7yPjBG8JHtkf19qygXBfJ3P23cASLsTYGj/DN5pz09zb17sWlp+EV1qoeSUaK9
         zaOxt6ZjjN/prZStkvqIefHaOq0gRNDDLpKUwaZWVJ5Zv/waRVNaWHQ2cbQFRo4XspL5
         dVyXl76qvhHJkNVrSIVDknonSIYFsDv6+o7PLIPEW2h18CKHaeIx5v0WzN/AP4r2JRYT
         lEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ysbTnxMyTI7DA06kRA/I/BJnOe40tZ93n6R0vsgYdKA=;
        b=BYh/HQDeuS/MT272TSOKP1vSNfdyRgMo5tCQqUovHgHBuptrNl5Lpj2eaUnoisQ39C
         FqDu4XkcWAL3lXVjgY3vW1GRPl4FhnsCPrDIGnLLoR33/ODmThOJKZ4hk/U0z53ZGdqo
         Aohzhapsww69UqJvADPn3ROKhdWlVYuwvHOidOhrNctbXqXXA30KTlUWpTNlhof5rqfD
         5KTC/sjcG/iLi1Vr4DALSgNcYUcNR7WnXFI4o/HxeBagHChCpob5v7j3vrXUnJG8iUTA
         f6BQN9S+i9Qy4WJaWleiMNmx7UoJNq+jIsFWag3rk+sTzfcb9SAlMiL6v/FaJQymXMFp
         FQHg==
X-Gm-Message-State: AOAM530BADW/KjWgGfhpM8E+jfyGPlytB7YTwPEs2QQ/TES2ZOJZAou+
        cvH4Bbb+QodSonwVVzQ09V1RIYLZOQ==
X-Google-Smtp-Source: ABdhPJwkR5pQvQLCL8y/RAzGt3HAYuENym2fYuLb0KluX9h6YNsz+Op1ABJkU6ZxTBnPMSQnsZmoGw==
X-Received: by 2002:a05:6870:32d6:b0:fb:3d62:b5b7 with SMTP id r22-20020a05687032d600b000fb3d62b5b7mr6225967oac.285.1654547927945;
        Mon, 06 Jun 2022 13:38:47 -0700 (PDT)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id j22-20020a056808035600b0032e3cca8561sm4327188oie.21.2022.06.06.13.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:38:47 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 1/8] x86/signal: Remove sig parameter from frame setup functions
Date:   Mon,  6 Jun 2022 16:37:55 -0400
Message-Id: <20220606203802.158958-2-brgerst@gmail.com>
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

Passing the signal number as a seperate parameter is unnecessary, since
it is always ksig->sig.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/ia32/ia32_signal.c       | 12 ++++++------
 arch/x86/include/asm/fpu/signal.h |  4 ++--
 arch/x86/kernel/signal.c          | 23 +++++++++++------------
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index c9c3859322fa..390347ab92de 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -230,7 +230,7 @@ static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 	return (void __user *) sp;
 }
 
-int ia32_setup_frame(int sig, struct ksignal *ksig,
+int ia32_setup_frame(struct ksignal *ksig,
 		     compat_sigset_t *set, struct pt_regs *regs)
 {
 	struct sigframe_ia32 __user *frame;
@@ -264,7 +264,7 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
-	unsafe_put_user(sig, &frame->sig, Efault);
+	unsafe_put_user(ksig->sig, &frame->sig, Efault);
 	unsafe_put_sigcontext32(&frame->sc, fp, regs, set, Efault);
 	unsafe_put_user(set->sig[1], &frame->extramask[0], Efault);
 	unsafe_put_user(ptr_to_compat(restorer), &frame->pretcode, Efault);
@@ -280,7 +280,7 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 	regs->ip = (unsigned long) ksig->ka.sa.sa_handler;
 
 	/* Make -mregparm=3 work */
-	regs->ax = sig;
+	regs->ax = ksig->sig;
 	regs->dx = 0;
 	regs->cx = 0;
 
@@ -296,7 +296,7 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 	return -EFAULT;
 }
 
-int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
+int ia32_setup_rt_frame(struct ksignal *ksig,
 			compat_sigset_t *set, struct pt_regs *regs)
 {
 	struct rt_sigframe_ia32 __user *frame;
@@ -321,7 +321,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
-	unsafe_put_user(sig, &frame->sig, Efault);
+	unsafe_put_user(ksig->sig, &frame->sig, Efault);
 	unsafe_put_user(ptr_to_compat(&frame->info), &frame->pinfo, Efault);
 	unsafe_put_user(ptr_to_compat(&frame->uc), &frame->puc, Efault);
 
@@ -357,7 +357,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	regs->ip = (unsigned long) ksig->ka.sa.sa_handler;
 
 	/* Make -mregparm=3 work */
-	regs->ax = sig;
+	regs->ax = ksig->sig;
 	regs->dx = (unsigned long) &frame->info;
 	regs->cx = (unsigned long) &frame->uc;
 
diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index e1c9df9102a5..08826ad0254d 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -14,9 +14,9 @@
 # include <uapi/asm/sigcontext.h>
 # include <asm/user32.h>
 struct ksignal;
-int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
+int ia32_setup_rt_frame(struct ksignal *ksig,
 			compat_sigset_t *set, struct pt_regs *regs);
-int ia32_setup_frame(int sig, struct ksignal *ksig,
+int ia32_setup_frame(struct ksignal *ksig,
 		     compat_sigset_t *set, struct pt_regs *regs);
 #else
 # define user_i387_ia32_struct	user_i387_struct
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 9c7265b524c7..40b1373bb70b 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -324,7 +324,7 @@ static const struct {
 };
 
 static int
-__setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
+__setup_frame(struct ksignal *ksig, sigset_t *set,
 	      struct pt_regs *regs)
 {
 	struct sigframe __user *frame;
@@ -336,7 +336,7 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
-	unsafe_put_user(sig, &frame->sig, Efault);
+	unsafe_put_user(ksig->sig, &frame->sig, Efault);
 	unsafe_put_sigcontext(&frame->sc, fp, regs, set, Efault);
 	unsafe_put_user(set->sig[1], &frame->extramask[0], Efault);
 	if (current->mm->context.vdso)
@@ -363,7 +363,7 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	/* Set up registers for signal handler */
 	regs->sp = (unsigned long)frame;
 	regs->ip = (unsigned long)ksig->ka.sa.sa_handler;
-	regs->ax = (unsigned long)sig;
+	regs->ax = (unsigned long)ksig->sig;
 	regs->dx = 0;
 	regs->cx = 0;
 
@@ -379,7 +379,7 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	return -EFAULT;
 }
 
-static int __setup_rt_frame(int sig, struct ksignal *ksig,
+static int __setup_rt_frame(struct ksignal *ksig,
 			    sigset_t *set, struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
@@ -391,7 +391,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
-	unsafe_put_user(sig, &frame->sig, Efault);
+	unsafe_put_user(ksig->sig, &frame->sig, Efault);
 	unsafe_put_user(&frame->info, &frame->pinfo, Efault);
 	unsafe_put_user(&frame->uc, &frame->puc, Efault);
 
@@ -428,7 +428,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	/* Set up registers for signal handler */
 	regs->sp = (unsigned long)frame;
 	regs->ip = (unsigned long)ksig->ka.sa.sa_handler;
-	regs->ax = (unsigned long)sig;
+	regs->ax = (unsigned long)ksig->sig;
 	regs->dx = (unsigned long)&frame->info;
 	regs->cx = (unsigned long)&frame->uc;
 
@@ -458,7 +458,7 @@ static unsigned long frame_uc_flags(struct pt_regs *regs)
 	return flags;
 }
 
-static int __setup_rt_frame(int sig, struct ksignal *ksig,
+static int __setup_rt_frame(struct ksignal *ksig,
 			    sigset_t *set, struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
@@ -493,7 +493,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	}
 
 	/* Set up registers for signal handler */
-	regs->di = sig;
+	regs->di = ksig->sig;
 	/* In case the signal handler was declared without prototypes */
 	regs->ax = 0;
 
@@ -763,7 +763,6 @@ static inline int is_x32_frame(struct ksignal *ksig)
 static int
 setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
-	int usig = ksig->sig;
 	sigset_t *set = sigmask_to_save();
 	compat_sigset_t *cset = (compat_sigset_t *) set;
 
@@ -773,13 +772,13 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	/* Set up the stack frame */
 	if (is_ia32_frame(ksig)) {
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO)
-			return ia32_setup_rt_frame(usig, ksig, cset, regs);
+			return ia32_setup_rt_frame(ksig, cset, regs);
 		else
-			return ia32_setup_frame(usig, ksig, cset, regs);
+			return ia32_setup_frame(ksig, cset, regs);
 	} else if (is_x32_frame(ksig)) {
 		return x32_setup_rt_frame(ksig, cset, regs);
 	} else {
-		return __setup_rt_frame(ksig->sig, ksig, set, regs);
+		return __setup_rt_frame(ksig, set, regs);
 	}
 }
 
-- 
2.35.3

