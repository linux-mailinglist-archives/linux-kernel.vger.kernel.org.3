Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4572A526E84
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiENDfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 23:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiENDe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 23:34:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5389B95DCE
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 20:34:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a5so9786411wrp.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 20:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AvxCAVhEBFSALzFW5QU4eqtsfJ+K74cWo1IjNe8gKhU=;
        b=hhjaEh4q933w6AuKifPXLtD2S7TfCNdCj8QpH8AO9IxW5szpex5NDjVkBj7Rnfup8Y
         kPiGnYL2/ahfl9LkZjZc2Scb28RQpXCFJjj9hcSbwaEoV3xlvXxPDdnzC91OTJbsBmmX
         eYuJqs2MR2qvuvb84xdzKd0tWp51YGkHRcCsAtiX7DBDg5WjIEwlQBLZc5f8cBRDXcdP
         jG+nLWhoeNXCrZ/xcYN/BMPl8kB5NPX+vy78YnAfiSZhQbXG9LvLdI+N1TBEQGvW00Q5
         6PmOcdeC8zQ0PWsQ78nCQA11C1oy6OXj+mLTgE4oVQz+CjxwbcKnglv3TzQu4kynXVfE
         JQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AvxCAVhEBFSALzFW5QU4eqtsfJ+K74cWo1IjNe8gKhU=;
        b=JPeAooJRCNWYwMOKAUA3Ko7wVM3hY6hvi1qsKfJ2qM6owH27wFynwV75SmG4Zoakp2
         x6+O4h3aP9Jdz4MLcg3b0rnTpwjmUOz//VVhCM0hOoxDceFjZ3PKBIYMMFz/OzhGnixQ
         rQ9oaROui13JeFB3E2G1jFpjm4jB29LPCRXwX/CUqTaAUM0684IK0TDx77TqVsvuwu5E
         jzbe2qQF4Jnsag5Dr8XRdSUG3hV8wID1Ui6pdOMZOLb5+BrCGKblEMGV19vYUFjtp57x
         SenLGfRGxLwsUHDhnV7ur74IjtOqpRKA6e4auGPu9mtxzfjB//qo8IxbZWpSdhjGMDh0
         IQ5w==
X-Gm-Message-State: AOAM532rKCyPznUwvdrwiDdxnUwB/QdaCpCB1Z9loqxN26mEOP0rIkAA
        uLz7C87D38kBykfh2TfM1K4=
X-Google-Smtp-Source: ABdhPJwfMSYLdMz16J88+j7WK3C7LzuI8Xgae1g0LeGemd94qEf2RxkJ/dd5rCMRDloHLwtJFZjppg==
X-Received: by 2002:a05:6000:81c:b0:20c:d4e7:400d with SMTP id bt28-20020a056000081c00b0020cd4e7400dmr6032737wrb.459.1652499296894;
        Fri, 13 May 2022 20:34:56 -0700 (PDT)
Received: from octofox.metropolis ([178.134.103.46])
        by smtp.gmail.com with ESMTPSA id h1-20020adfaa81000000b0020c66310845sm3542638wrc.55.2022.05.13.20.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 20:34:56 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 3/3] xtensa: improve call0 ABI probing
Date:   Fri, 13 May 2022 20:34:37 -0700
Message-Id: <20220514033437.4182899-4-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220514033437.4182899-1-jcmvbkbc@gmail.com>
References: <20220514033437.4182899-1-jcmvbkbc@gmail.com>
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

When call0 userspace ABI support by probing is enabled instructions that
cause illegal instruction exception when PS.WOE is clear are retried
with PS.WOE set before calling c-level exception handler. Record user pc
at which PS.WOE was set in the fast exception handler and clear PS.WOE
in the c-level exception handler if we get there from the same address.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:

- split ABI probing improvement from the artificial division by 0

 arch/xtensa/include/asm/thread_info.h |  4 ++++
 arch/xtensa/kernel/asm-offsets.c      |  3 +++
 arch/xtensa/kernel/entry.S            |  5 +++++
 arch/xtensa/kernel/traps.c            | 12 ++++++++++++
 4 files changed, 24 insertions(+)

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
index 47445b2d4217..21c2c30baf69 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -324,6 +324,18 @@ static int check_div0(struct pt_regs *regs)
 
 static void do_illegal_instruction(struct pt_regs *regs)
 {
+#ifdef CONFIG_USER_ABI_CALL0_PROBE
+	/*
+	 * When call0 application encounters an illegal instruction fast
+	 * exception handler will attempt to set PS.WOE and retry failing
+	 * instruction.
+	 * If we get here we know that that instruction is also illegal
+	 * with PS.WOE set, so it's not related to the windowed option
+	 * hence PS.WOE may be cleared.
+	 */
+	if (regs->pc == current_thread_info()->ps_woe_fix_addr)
+		regs->ps &= ~PS_WOE_MASK;
+#endif
 	if (check_div0(regs)) {
 		do_div0(regs);
 		return;
-- 
2.30.2

