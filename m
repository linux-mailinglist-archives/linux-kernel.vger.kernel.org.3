Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B545522E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243964AbiEKIch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243731AbiEKIbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:31:46 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEEC3B3C2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso4278931pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=/ojtaq0pVTISiVB+t5H7Gtqn9qT+yiZRc8EYMYytpr0=;
        b=D1p70MhwIuPllZCRHztQBSDqpmMGP0lmYpciM3ZdGEM0H1RHycrby4c4kHVhvjsScp
         1pJu9uzHt+ntZZ48Tm2pMH+pl9nSJnNIrjC+ItTs+LCxOIPu67a1PmsiqShdXZOXbN8g
         2k9IFwmsVcRFPyrMP+n6R4fpoDl3EHpGz+RUlTzgA1/FX+7EHILH9y/uyJ0mUzVw9QD6
         aIa0CqGiGgaL1P08hjhMI8dJJCbBj3TlSAYAX8Wr//UToiMDl6aACJ4pEhsMGtsJ1HJI
         gh0kfq5WriFOuyj2z/MOOAKzgWbF1AFF/mYR/GvcQAW5CWbxygEtEyO3EVPgviT/uI4J
         pdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/ojtaq0pVTISiVB+t5H7Gtqn9qT+yiZRc8EYMYytpr0=;
        b=t3lO9nDN3Ys0GJL6QFwwTImJZAY55N0MDKeVe5U61NhQDRWQO0wbbNWjJiYhYC9GHA
         MZ0/DBDz1qO4Ao3/ARe/XFcpkZBC7zhiweDZqF78xwEweNdr8FrrAkTCPKjRcDVEW0+J
         JveiF8fBwCtpEbINjWKQ/MTqMvOY1QnGCARXl+xVmFJaeJ1XBZ/CH77f6C1nudAwyClG
         EwW8LwSf/j1HfVeEW44sc+AulsuWEc9NICO5kG4uehQgKZDmFhuKXoPTtvXX03d7mjuZ
         53FgUQKv1IzBmNsEJOKGsNxM4yf1zFWce8kif96ihOvSvKET42lCWKLbUXdRNghrWp7W
         w5zQ==
X-Gm-Message-State: AOAM53156YJs+Mn1nEkBSPAjlePG1R3XwBzVQUaw53BCYYKvi2rJqR/O
        0ydCrWkez2FrjcDbTrRJbU1+/g==
X-Google-Smtp-Source: ABdhPJyBwuSNtM5/ptBpzBtWQ0GULx0806sbKBjU++Ipvid80IN1LkB54oBCdLtT6xip2SfKgAaWuQ==
X-Received: by 2002:a17:902:da8b:b0:15e:aba7:43fe with SMTP id j11-20020a170902da8b00b0015eaba743femr24282811plx.9.1652257900729;
        Wed, 11 May 2022 01:31:40 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7900a000000b0050dc7628170sm1020202pfo.74.2022.05.11.01.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 01:31:40 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
Subject: [PATCH v10 07/16] riscv: Add vector struct and assembler definitions
Date:   Wed, 11 May 2022 08:31:17 +0000
Message-Id: <fb2d3a118a4e2d657ee2b345c81f9c437d013773.1652257230.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1652257230.git.greentime.hu@sifive.com>
References: <cover.1652257230.git.greentime.hu@sifive.com>
In-Reply-To: <cover.1652257230.git.greentime.hu@sifive.com>
References: <cover.1652257230.git.greentime.hu@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vector state context struct in struct thread and asm-offsets.c
definitions.

The vector registers will be saved in datap pointer of __riscv_v_state. It
will be dynamically allocated in kernel space. It will be put right after
the __riscv_v_state data structure in user space.

Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/processor.h   |  1 +
 arch/riscv/include/uapi/asm/ptrace.h | 17 +++++++++++++++++
 arch/riscv/kernel/asm-offsets.c      |  6 ++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 0749924d9e55..91f1c318328e 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -35,6 +35,7 @@ struct thread_struct {
 	unsigned long s[12];	/* s[0]: frame pointer */
 	struct __riscv_d_ext_state fstate;
 	unsigned long bad_cause;
+	struct __riscv_v_state vstate;
 };
 
 /* Whitelist the fstate from the task_struct for hardened usercopy */
diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index 882547f6bd5c..6ee1ca2edfa7 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -77,6 +77,23 @@ union __riscv_fp_state {
 	struct __riscv_q_ext_state q;
 };
 
+struct __riscv_v_state {
+	unsigned long vstart;
+	unsigned long vl;
+	unsigned long vtype;
+	unsigned long vcsr;
+	void *datap;
+	/*
+	 * In signal handler, datap will be set a correct user stack offset
+	 * and vector registers will be copied to the address of datap
+	 * pointer.
+	 *
+	 * In ptrace syscall, datap will be set to zero and the vector
+	 * registers will be copied to the address right after this
+	 * structure.
+	 */
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _UAPI_ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index df9444397908..37e3e6a8d877 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -75,6 +75,12 @@ void asm_offsets(void)
 	OFFSET(TSK_STACK_CANARY, task_struct, stack_canary);
 #endif
 
+	OFFSET(RISCV_V_STATE_VSTART, __riscv_v_state, vstart);
+	OFFSET(RISCV_V_STATE_VL, __riscv_v_state, vl);
+	OFFSET(RISCV_V_STATE_VTYPE, __riscv_v_state, vtype);
+	OFFSET(RISCV_V_STATE_VCSR, __riscv_v_state, vcsr);
+	OFFSET(RISCV_V_STATE_DATAP, __riscv_v_state, datap);
+
 	DEFINE(PT_SIZE, sizeof(struct pt_regs));
 	OFFSET(PT_EPC, pt_regs, epc);
 	OFFSET(PT_RA, pt_regs, ra);
-- 
2.17.1

