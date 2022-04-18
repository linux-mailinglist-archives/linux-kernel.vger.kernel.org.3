Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14AD505D51
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346850AbiDRRPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344650AbiDRRPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:15:08 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87EE21244
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:12:27 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s137so19973846pgs.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZcVLSMeauHEXtyp9AxODJlBHCvOIwedUfh2n14tYNhg=;
        b=Kh069mCyQDD1Y5M3hVm1c19pBzUk9OtdZt0beL1xQQMGBPnr7ybJCSEYJeHYnzabIJ
         ZSJS2x+gJvZaYOeD7cReTdfPPVd1g8iV6edzOH/l41QgdemSRI8S6HNZ71OY0zlUU50H
         g3XTxdXlAaSv9pNa+/+HIMOcxUEWmsF30Ya2b0duly5ISRC6uZOiMVob7SgezA92nwFS
         lD3DzVmRr42rvwbkZYIJHIrcgmrappui2yjI6ppCsEzt3NMpzvJGvDWinCJUMCk3Mr/y
         PGtsX4KL297rQjfAq6h5+29aJEoqRoQfLAkpcBoTe971eAPoF/2qIGiZlBp4FdH6Y2OI
         ByXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZcVLSMeauHEXtyp9AxODJlBHCvOIwedUfh2n14tYNhg=;
        b=5/D5ZqkjZtR9jpxnwxNm8ptaWZt/xCNdZgvw42v8KVeblD1HemWfBzhSdURy6ElHy6
         2kCkS70X+5oK6gZLBmtYBaci5qane9BCkwK2ANkpFfLWOR0471Tu595Yl5QRiNRT5U8D
         Woqq9x7srQGZEc2e7tGUBC4JrTfLY3EYtth7BNbQOMQ2vAMn3lVFwsIgIVkff1XMm+WV
         wuiJAiyNVICYOyeKacmMCCSGX0d/f2lKj9lxcskbI4Yoh+Hb5mqnrJK0xBbpoOnJxYW0
         QtNyLapN5sQIt14A3GszdfV6JPPdGyYAZM5O2lPSgwyYjgdoPlY2Ss07CJUDXw1lH8Ly
         pikA==
X-Gm-Message-State: AOAM530jR6Xc4SGn6/QrTdr0eAUK7HJskP0hFxPxMFvACJ/yNAhTCjFe
        JlfLBnSwbGfSj6SAOzrDrUcIOyNKN0A=
X-Google-Smtp-Source: ABdhPJywZ8F7/klptc0K5IM/nCi5QCWKkMLD3NHglOQ/IGD3XB4+QiafjpYCENkVMSsIfCs8jBnfGA==
X-Received: by 2002:a63:e557:0:b0:39d:2965:a7f0 with SMTP id z23-20020a63e557000000b0039d2965a7f0mr10964189pgj.158.1650301947223;
        Mon, 18 Apr 2022 10:12:27 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:3f09:380c:8f11:5a8a])
        by smtp.gmail.com with ESMTPSA id e16-20020a63ee10000000b0039d1c7e80bcsm13637138pgi.75.2022.04.18.10.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:12:26 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/5] xtensa: move trace_hardirqs_off call back to entry.S
Date:   Mon, 18 Apr 2022 10:12:02 -0700
Message-Id: <20220418171205.2413168-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220418171205.2413168-1-jcmvbkbc@gmail.com>
References: <20220418171205.2413168-1-jcmvbkbc@gmail.com>
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

Context tracking call must be done after hardirq tracking call,
otherwise lockdep_assert_irqs_disabled called from rcu_eqs_exit gives
a warning. To avoid context tracking logic duplication for IRQ/exception
entry paths move trace_hardirqs_off call back to common entry code.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/entry.S | 19 +++++++++++++------
 arch/xtensa/kernel/traps.c | 11 ++---------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 3c0b1aac7aba..c85597a734aa 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -424,7 +424,6 @@ KABI_W	or	a3, a3, a0
 	moveqz	a3, a0, a2		# a3 = LOCKLEVEL iff interrupt
 KABI_W	movi	a2, PS_WOE_MASK
 KABI_W	or	a3, a3, a2
-	rsr	a2, exccause
 #endif
 
 	/* restore return address (or 0 if return to userspace) */
@@ -451,19 +450,27 @@ KABI_W	or	a3, a3, a2
 
 	save_xtregs_opt a1 a3 a4 a5 a6 a7 PT_XTREGS_OPT
 	
+#ifdef CONFIG_TRACE_IRQFLAGS
+	rsr		abi_tmp0, ps
+	extui		abi_tmp0, abi_tmp0, PS_INTLEVEL_SHIFT, PS_INTLEVEL_WIDTH
+	beqz		abi_tmp0, 1f
+	abi_call	trace_hardirqs_off
+1:
+#endif
+
 	/* Go to second-level dispatcher. Set up parameters to pass to the
 	 * exception handler and call the exception handler.
 	 */
 
-	rsr	a4, excsave1
-	addx4	a4, a2, a4
-	l32i	a4, a4, EXC_TABLE_DEFAULT		# load handler
-	mov	abi_arg1, a2			# pass EXCCAUSE
+	l32i	abi_arg1, a1, PT_EXCCAUSE	# pass EXCCAUSE
+	rsr	abi_tmp0, excsave1
+	addx4	abi_tmp0, abi_arg1, abi_tmp0
+	l32i	abi_tmp0, abi_tmp0, EXC_TABLE_DEFAULT	# load handler
 	mov	abi_arg0, a1			# pass stack frame
 
 	/* Call the second-level handler */
 
-	abi_callx	a4
+	abi_callx	abi_tmp0
 
 	/* Jump here for exception exit */
 	.global common_exception_return
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 82ced7b25b77..515719c7e750 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -242,12 +242,8 @@ DEFINE_PER_CPU(unsigned long, nmi_count);
 
 void do_nmi(struct pt_regs *regs)
 {
-	struct pt_regs *old_regs;
+	struct pt_regs *old_regs = set_irq_regs(regs);
 
-	if ((regs->ps & PS_INTLEVEL_MASK) < LOCKLEVEL)
-		trace_hardirqs_off();
-
-	old_regs = set_irq_regs(regs);
 	nmi_enter();
 	++*this_cpu_ptr(&nmi_count);
 	check_valid_nmi();
@@ -269,12 +265,9 @@ void do_interrupt(struct pt_regs *regs)
 		XCHAL_INTLEVEL6_MASK,
 		XCHAL_INTLEVEL7_MASK,
 	};
-	struct pt_regs *old_regs;
+	struct pt_regs *old_regs = set_irq_regs(regs);
 	unsigned unhandled = ~0u;
 
-	trace_hardirqs_off();
-
-	old_regs = set_irq_regs(regs);
 	irq_enter();
 
 	for (;;) {
-- 
2.30.2

