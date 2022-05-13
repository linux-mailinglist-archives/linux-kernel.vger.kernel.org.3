Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A9D52665E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382161AbiEMPmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbiEMPmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:42:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C25BE21
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:42:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i19so16970163eja.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BOG74POVeYOfQY9afdarMF3mc0mDpcOp33/SYa9z2g4=;
        b=UvtK+9uXFFbJiEIXAG4TxrUr8xm6F/cK4VWAl7OwyGrIi1ROBFy+N+sMHRhWqU/+0l
         yF+0TlTr+37pRHCV1GZfzzUwxINR5QbfWpRTmdts4Wgy8shHcK9FbhtJ1RzR3iVucSL0
         n6V8aw+UkKpK9BTfh8StIyAROhsejouLG5tZtjr+OfJC9lJXuNnR/5b/tL15D5ILZ3rx
         DpOj28rwvrg5UAm22hgOu9DkHyY2Pg+P52OccmCs7q5rEOepc/VC8jGSliAbWwRkXvSB
         LyY3ZVscMyXr0i8VCorGvS1ygKBxlEjWNE4pws1Cex+q8oq3Fg6Z2wQJjX/dGzKEQIKk
         B+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BOG74POVeYOfQY9afdarMF3mc0mDpcOp33/SYa9z2g4=;
        b=oxPP3Q+zIUN00saHNQolQ7O2U4cWMpr8kSO5DjZlEb/hYPK8SCAwoM9yQTEIrbmrYc
         1PyUbHcyikXbyP07jteVJFPKO5wdDVYsRdcdMVSR2yphrdK6NKd/yXnPGXawaMEdO6ai
         pgMeWlciznNYM4RBuNe4fwOkrYMDFlOQRxFp9xWYncFT6nIkUnM/5CdWYtG8JmO8vu0g
         mxLzI2tiK9+K2LH17df3cZRRKGdP25wiUQLQcqsPabrUUQo/ys07qxDwvaeeR0ZeNIQd
         abY5ul55S4NoDEhqarObIpTKHC1/l1p48wwWV8z4XhlCwEJo+a1UemqgNKIQZdPuvTYV
         bZeQ==
X-Gm-Message-State: AOAM532hGmPyEosK+9ru4bqULcXbNbvRQmuu7rkv0WBzyTNCMsagmMic
        WWqUj+E7YrAJtLQTsqUqoj0=
X-Google-Smtp-Source: ABdhPJxAwjcDm4BtYfBQSGIif62BWIgQHDEoMLu0Ig7Opo7ZT8E5W9XSJ198+zmltv+r4FP2nkilfQ==
X-Received: by 2002:a17:906:4884:b0:6f3:a042:c1c6 with SMTP id v4-20020a170906488400b006f3a042c1c6mr4706002ejq.363.1652456523354;
        Fri, 13 May 2022 08:42:03 -0700 (PDT)
Received: from octofox.metropolis ([178.134.103.46])
        by smtp.gmail.com with ESMTPSA id h16-20020a1709066d9000b006f3ef214e73sm848313ejt.217.2022.05.13.08.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 08:42:03 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/2] xtensa: support artificial division by 0 exception
Date:   Fri, 13 May 2022 08:41:51 -0700
Message-Id: <20220513154151.4135905-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513154151.4135905-1-jcmvbkbc@gmail.com>
References: <20220513154151.4135905-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On xtensa cores wihout hardware division option division support
functions from libgcc react to division by 0 attempt by executing
illegal instruction followed by the characters 'DIV0'. Recognize this
pattern in illegal instruction exception handler and convert it to
division by 0.
When call0 userspace ABI support by probing is enabled instructions that
cause illegal instruction exception when PS.WOE is clear are retried
with PS.WOE set before calling c-level exception handler. Record user pc
where PS.WOE was set in the fast exception handler and clear PS.WOE in
the c-level exception handler if it was due to artificial division by 0.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/thread_info.h |  4 +++
 arch/xtensa/kernel/asm-offsets.c      |  3 ++
 arch/xtensa/kernel/entry.S            |  5 +++
 arch/xtensa/kernel/traps.c            | 45 +++++++++++++++++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/arch/xtensa/include/asm/thread_info.h b/arch/xtensa/include/asm/thread_info.h
index 52974317a6b6..326db1c1d5d8 100644
--- a/arch/xtensa/include/asm/thread_info.h
+++ b/arch/xtensa/include/asm/thread_info.h
@@ -56,6 +56,10 @@ struct thread_info {
 	/* result of the most recent exclusive store */
 	unsigned long		atomctl8;
 #endif
+#ifdef CONFIG_USER_ABI_CALL0_PROBE
+	/* Address where PS.WOE was enabled by the ABI probing code */
+	unsigned long		ps_woe_fix_addr;
+#endif
 
 	/*
 	 * If i-th bit is set then coprocessor state is loaded into the
diff --git a/arch/xtensa/kernel/asm-offsets.c b/arch/xtensa/kernel/asm-offsets.c
index 9a1db6ffcbf4..da38de20ae59 100644
--- a/arch/xtensa/kernel/asm-offsets.c
+++ b/arch/xtensa/kernel/asm-offsets.c
@@ -88,6 +88,9 @@ int main(void)
 	OFFSET(TI_STSTUS, thread_info, status);
 	OFFSET(TI_CPU, thread_info, cpu);
 	OFFSET(TI_PRE_COUNT, thread_info, preempt_count);
+#ifdef CONFIG_USER_ABI_CALL0_PROBE
+	OFFSET(TI_PS_WOE_FIX_ADDR, thread_info, ps_woe_fix_addr);
+#endif
 
 	/* struct thread_info (offset from start_struct) */
 	DEFINE(THREAD_RA, offsetof (struct task_struct, thread.ra));
diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 3224b4ceca34..e3eae648ba2e 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -1056,6 +1056,11 @@ ENTRY(fast_illegal_instruction_user)
 	movi	a3, PS_WOE_MASK
 	or	a0, a0, a3
 	wsr	a0, ps
+#ifdef CONFIG_USER_ABI_CALL0_PROBE
+	GET_THREAD_INFO(a3, a2)
+	rsr	a0, epc1
+	s32i	a0, a3, TI_PS_WOE_FIX_ADDR
+#endif
 	l32i	a3, a2, PT_AREG3
 	l32i	a0, a2, PT_AREG0
 	rsr	a2, depc
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 7c7c4c7b33bb..d45dfa10be73 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -293,12 +293,57 @@ static void do_interrupt(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
+static int check_div0(struct pt_regs *regs)
+{
+#if !XCHAL_HAVE_DIV32
+	u8 buf[7];
+	void *p;
+	static const u8 pattern1[] = {0, 0, 0, 'D', 'I', 'V', '0'};
+#if defined(__XTENSA_EB__)
+	static const u8 pattern2[] = {0xd6, 0x0f, 'D', 'I', 'V', '0'};
+#elif defined(__XTENSA_EL__)
+	static const u8 pattern2[] = {0x6d, 0xf0, 'D', 'I', 'V', '0'};
+#else
+#error Unsupported Xtensa endianness
+#endif
+
+	if (user_mode(regs)) {
+		if (copy_from_user(buf, (void __user *)regs->pc, 7))
+			return 0;
+		p = buf;
+	} else {
+		p = (void *)regs->pc;
+	}
+
+	return memcmp(p, pattern1, sizeof(pattern1)) == 0 ||
+		memcmp(p, pattern2, sizeof(pattern2)) == 0;
+#else
+	return 0;
+#endif
+}
+
 /*
  * Illegal instruction. Fatal if in kernel space.
  */
 
 static void do_illegal_instruction(struct pt_regs *regs)
 {
+	if (check_div0(regs)) {
+#ifdef CONFIG_USER_ABI_CALL0_PROBE
+		/*
+		 * When call0 application generates artificial division by 0
+		 * exception fast illegal instruction exception handler will
+		 * attempt to set PS.WOE and retry failing instruction.
+		 * We know that that illegal instruction was not related to
+		 * windowed option so we clear PS.WOE here.
+		 */
+		if (regs->pc == current_thread_info()->ps_woe_fix_addr)
+			regs->ps &= ~PS_WOE_MASK;
+#endif
+		do_div0(regs);
+		return;
+	}
+
 	__die_if_kernel("Illegal instruction in kernel", regs, SIGKILL);
 
 	/* If in user mode, send SIGILL signal to current process. */
-- 
2.30.2

