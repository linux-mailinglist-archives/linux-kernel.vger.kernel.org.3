Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E135529FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344581AbiEQKqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343594AbiEQKpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:45:15 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E487D45063
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:45:13 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k30so11458389wrd.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i/m+NNWu2JHnuPHL4+y0AU2AuVhAajCRwsy8obi59CI=;
        b=a55lv+v9G1iGQh3SC5UoT1eu8lm5LE9geHZ1wKPD16zHwyTs5maCCpHYMZYGuMli8k
         eqS6chlNU4Z093iBZ2QJVLl63s0XzlHqXGgmIPi2Ol1JH12uFeN3HWSEyWDTXkPLQP0t
         U+E4UW82ubzGsmy//4Vq/3PomdWwGPMdaVNO0TRKUAIBiRjmknjN1f6JGCHbn20fBIUP
         GcUja2mM57TRJa6/hb2mi+jSWOIg6MnVqjQEFgLtyx1lInrl+i2E0XnIK+3S7HNKTJoJ
         0xS1VFjS8raKKifAaVtHroF6U+Tgm61sPsDz137jRT3JMirvR/cf//XWiTHLWop5ZwCX
         yLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i/m+NNWu2JHnuPHL4+y0AU2AuVhAajCRwsy8obi59CI=;
        b=nlQpCnFDE0Y9H/bj+gKhyhY/BMrvZh5wCZUV4D6gpuUl6NJUvFbGehPQI+rwgyqNQF
         uRNihnurrHnwqqOP4HmTQO2MTSHY31DZGAmC/uYuK8ezHyFxEN6kyFGmLrcCiS+gt7Ke
         v4PqKyYh2SxjkFn6Ai0vGCqAM0MrUy6oolXDdctEghPAJOqUsKHR7UQue/MPT/IwHyol
         /Ubx5dlI61An5SjrVRSTDqV/xwBijOyLIrgXLy28+WdnLNUk5bM6c0AsvzG5fE3S1II9
         RkrSOlVVNnvYj41SqirkDmSNK1K9Dsb6YaKmW2n4EpL+ZT95tAfKAPPjZekqwLAHaXZy
         InGQ==
X-Gm-Message-State: AOAM532SCCkwJEmUH72oi1NMDm6rnncRXXPV6wQRJzA0gTxznYj1TTC4
        Pu4pgKayqSAFi8KucLvSZdo=
X-Google-Smtp-Source: ABdhPJykxA/wZQx/LJ70b1lvIii1f5r3I+B9eGeKN/b+bphmV/WRsgPRqg1XaQ9KhAkrKT2W68T/hQ==
X-Received: by 2002:a05:6000:144f:b0:20c:6090:3040 with SMTP id v15-20020a056000144f00b0020c60903040mr17412026wrx.479.1652784312414;
        Tue, 17 May 2022 03:45:12 -0700 (PDT)
Received: from octofox.metropolis ([178.134.210.144])
        by smtp.gmail.com with ESMTPSA id r5-20020adfbb05000000b0020d00174eabsm8612218wrg.94.2022.05.17.03.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 03:45:12 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 3/3] xtensa: improve call0 ABI probing
Date:   Tue, 17 May 2022 03:44:58 -0700
Message-Id: <20220517104458.257799-4-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517104458.257799-1-jcmvbkbc@gmail.com>
References: <20220517104458.257799-1-jcmvbkbc@gmail.com>
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
index 2b75b252b626..f97d43a8d13d 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -317,6 +317,18 @@ static bool check_div0(struct pt_regs *regs)
 
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

