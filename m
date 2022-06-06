Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F6553F061
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiFFUnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbiFFUms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:42:48 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB041122B6C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:38:54 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id q11so5934396oih.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MjojrqCS6xuxZg5uh79IanvQVrJGjYSajetX/zMk8e0=;
        b=CyCxT5CceEiDwirzG5qf3Az/veov1N3xQFxd+GDt5IeT6iXLElSuuJiVfLgT0IH+bQ
         sePYEi9fuWmV4kN01dV49Mzcq72MvZPPzVTDOxFRvOPYVxmc3piQ1KAvTYzzgjLDC2bn
         yxW7w96cbKcD+tg2oUfzWi9exLkmI8Nm55adKYpL4h6CIi5GVmE1077zh36ZGnGdw3+8
         mxWJTnk+Gb6fC+cBYkrVOh+JwXFj4APDuUWg+5wDgFzxOXax7P4jo00om8Ch8rxgwIvx
         tKwbXmqNcbRjYnPCLUfzEy3ZbFdQNTjwehaHQMKLjR7u/XghCI1493zfPyicVlIlibba
         3cUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MjojrqCS6xuxZg5uh79IanvQVrJGjYSajetX/zMk8e0=;
        b=0wwR88+C8EALD2biq7U0g7371il+/pwMZmTzw97epawRAJc8jVULGrYSX6vtzGInGu
         m3MihlEhUS1ud8YwOWDiyMJHJVfqTcL6ykenqYwL5zEq98hYKCJ0EAO9R2JG/lWvjFy7
         myknGpMfPEf1v6OjWiFDs+MdwenbOpMoVHOetdPCzVjyVUztMlCk8fnyOhjn93Ng0LBB
         q80eRXVsfE6RDhdpJJgvz9vRZRBADbuP6Q3AdMWpXHEq2g7vR39Z1wK2BqgDcZUHxofA
         Q3nYngn2La1jNQTPsV+oCCw96eDEfd6Q7L2pyTLcte2YrmSCo9sIcBl1m/rWuNtap5ys
         x81A==
X-Gm-Message-State: AOAM532DHyqfrKeE3NUxHp0tykZVHnI8dK0yvz+XibRMTa6oB6g2Wc4Q
        ek9mtfmSHnuz2YI7oYZJrW4+8BXWXg==
X-Google-Smtp-Source: ABdhPJzAQsD3jKRw5cnBZKKBmNFoGEUDVWEOICCfydL1u8jgpnmV5AIKp3vx1gXsE3b6VNt2lFTThA==
X-Received: by 2002:a05:6808:f91:b0:32b:5c6f:4cce with SMTP id o17-20020a0568080f9100b0032b5c6f4ccemr15325454oiw.274.1654547934113;
        Mon, 06 Jun 2022 13:38:54 -0700 (PDT)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id j22-20020a056808035600b0032e3cca8561sm4327188oie.21.2022.06.06.13.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:38:53 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 6/8] x86/signal: Add ABI prefixes to frame setup functions
Date:   Mon,  6 Jun 2022 16:38:00 -0400
Message-Id: <20220606203802.158958-7-brgerst@gmail.com>
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

Add ABI prefixes to the frame setup functions that didn't already have
them.  To avoid compiler warnings and prepare for moving these functions
to separate files, make them non-static.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/fpu/signal.h  |  5 -----
 arch/x86/include/asm/sighandling.h |  5 +++++
 arch/x86/kernel/signal.c           | 18 +++++++-----------
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 2f255aca5622..611fa41711af 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -13,14 +13,9 @@
 #ifdef CONFIG_X86_64
 # include <uapi/asm/sigcontext.h>
 # include <asm/user32.h>
-struct ksignal;
-int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
-int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs);
 #else
 # define user_i387_ia32_struct	user_i387_struct
 # define user32_fxsr_struct	user_fxsr_struct
-# define ia32_setup_frame	__setup_frame
-# define ia32_setup_rt_frame	__setup_rt_frame
 #endif
 
 extern void convert_from_fxsr(struct user_i387_ia32_struct *env,
diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
index c9e9784efe38..e770c4fc47f4 100644
--- a/arch/x86/include/asm/sighandling.h
+++ b/arch/x86/include/asm/sighandling.h
@@ -19,4 +19,9 @@ void __user *
 get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 	     void __user **fpstate);
 
+int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs);
+int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
+int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
+int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
+
 #endif /* _ASM_X86_SIGHANDLING_H */
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 890ca0523570..0511e050d24a 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -336,8 +336,7 @@ static const struct {
 	0
 };
 
-static int
-__setup_frame(struct ksignal *ksig, struct pt_regs *regs)
+int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
 	sigset_t *set = sigmask_to_save();
 	struct sigframe __user *frame;
@@ -392,7 +391,7 @@ __setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 	return -EFAULT;
 }
 
-static int __setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
 	sigset_t *set = sigmask_to_save();
 	struct rt_sigframe __user *frame;
@@ -471,7 +470,7 @@ static unsigned long frame_uc_flags(struct pt_regs *regs)
 	return flags;
 }
 
-static int __setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
 	sigset_t *set = sigmask_to_save();
 	struct rt_sigframe __user *frame;
@@ -571,11 +570,9 @@ int copy_siginfo_to_user32(struct compat_siginfo __user *to,
 		return x32_copy_siginfo_to_user(to, from);
 	return __copy_siginfo_to_user32(to, from);
 }
-#endif /* CONFIG_X86_X32_ABI */
 
-static int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
-#ifdef CONFIG_X86_X32_ABI
 	compat_sigset_t *set = (compat_sigset_t *) sigmask_to_save();
 	struct rt_sigframe_x32 __user *frame;
 	unsigned long uc_flags;
@@ -622,15 +619,14 @@ static int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 
 	regs->cs = __USER_CS;
 	regs->ss = __USER_DS;
-#endif	/* CONFIG_X86_X32_ABI */
 
 	return 0;
-#ifdef CONFIG_X86_X32_ABI
+
 Efault:
 	user_access_end();
 	return -EFAULT;
-#endif
 }
+#endif /* CONFIG_X86_X32_ABI */
 
 /*
  * Do a signal return; undo the signal stack.
@@ -770,7 +766,7 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	} else if (is_x32_frame(ksig)) {
 		return x32_setup_rt_frame(ksig, regs);
 	} else {
-		return __setup_rt_frame(ksig, regs);
+		return x64_setup_rt_frame(ksig, regs);
 	}
 }
 
-- 
2.35.3

