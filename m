Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D8A575B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiGOGLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiGOGLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:11:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675AD735BF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31d17879672so33587447b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ljHAEgANsvWTLcKZTghLQsxafFQVS9WVjokuyjxdCqc=;
        b=npQk7T0JhUPj5VT7xjkRtVg6CsVxkDj8rBq/BUUyI4Mi+9igHEZ+1DmO7myypfhwxT
         cw3ncKxhY6jXPVtDsozwj2HOUj/M3EooszZ6TtifjL6+sUis8T+X77PHgZ1e+BuKKtm6
         ZFhXKSU46ZE+lIRgcQ8sY/2hsNJ8CYO9VvxG4xu3jpHGtK+mBk59HwIGe/xxrVkzfQ6H
         owbBwOiGVNo7n6i2hwzOmUUwJlrVcVjwzZN07JzLdLOSEckpSrizh3Ga1kefRYD9H75X
         XOF4FyXw2I5DDCrv8yO5+INrCFE7sPZcJXpG4do24oD8+GKiJ1nf2uKkhEvs4blSyMMu
         mDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ljHAEgANsvWTLcKZTghLQsxafFQVS9WVjokuyjxdCqc=;
        b=n808iKtgUhHqKBg7BCfy7QebDytkaHIRkx7kkr+hSDbJdKpuuDKrd4LAIEnH1xxNlL
         MRt5IIUfg1qv5BkoRLgiguecau3X/wHMYUcVhrewlBOtd3GWzWNyFTGWDYCtKNhiYySk
         Ygg9+Ab4qmd3KAtAG68gsBPiH8q7KtYqhyj6qDdc5MlyvrkaRLP/1DNyAdCkT+V4i31F
         cyddLDy+4KObzQRM90hPS+mX11tn1fL2rUyLwjrSmpY9zH/2pitX38Rwe4VkIZm0Bisr
         3uxPU+Nigzi99deKyZvn02OJ+9um+RsmohmHqPyrLkpQVQLFnyZbJTL6X1N3RsN+Voq4
         oxRg==
X-Gm-Message-State: AJIora+QtfXNBaKof5eE0ETOaPRbSJOFQXw/+HxyIwQjSuhZNY6bTG34
        +zHfsAFnGdrMmDXuzLYOL0vTaHUnAgLHQKIFUg==
X-Google-Smtp-Source: AGRyM1vsLnzedBXRLas9Bpb1/ODNueblglUHt+pB7oPmdXRtm9qObq99zCFBzoa8bIquQbhpT+0pCRDt34Y3LdmTkw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f010:455b:62ce:19e])
 (user=kaleshsingh job=sendgmr) by 2002:a25:7ac6:0:b0:66f:d07e:23f5 with SMTP
 id v189-20020a257ac6000000b0066fd07e23f5mr5892519ybc.110.1657865459665; Thu,
 14 Jul 2022 23:10:59 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:10:12 -0700
In-Reply-To: <20220715061027.1612149-1-kaleshsingh@google.com>
Message-Id: <20220715061027.1612149-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 03/18] arm64: stacktrace: Factor out unwind_next_common()
From:   Kalesh Singh <kaleshsingh@google.com>
To:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com
Cc:     will@kernel.org, qperret@google.com, tabba@google.com,
        kaleshsingh@google.com, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, andreyknvl@gmail.com,
        russell.king@oracle.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, drjones@redhat.com,
        wangkefeng.wang@huawei.com, elver@google.com, keirf@google.com,
        yuzenghui@huawei.com, ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move common unwind_next logic to stacktrace/common.h. This allows
reusing the code in the implementation the nVHE hypervisor stack
unwinder, later in this series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/stacktrace/common.h | 50 ++++++++++++++++++++++
 arch/arm64/kernel/stacktrace.c             | 41 ++----------------
 2 files changed, 54 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
index f58b786460d3..0c5cbfdb56b5 100644
--- a/arch/arm64/include/asm/stacktrace/common.h
+++ b/arch/arm64/include/asm/stacktrace/common.h
@@ -65,6 +65,10 @@ struct unwind_state {
 static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
 				     struct stack_info *info);
 
+static inline bool on_accessible_stack(const struct task_struct *tsk,
+				       unsigned long sp, unsigned long size,
+				       struct stack_info *info);
+
 static inline bool on_stack(unsigned long sp, unsigned long size,
 			    unsigned long low, unsigned long high,
 			    enum stack_type type, struct stack_info *info)
@@ -120,4 +124,50 @@ static inline void unwind_init_common(struct unwind_state *state,
 	state->prev_type = STACK_TYPE_UNKNOWN;
 }
 
+static inline int unwind_next_common(struct unwind_state *state,
+				     struct stack_info *info)
+{
+	struct task_struct *tsk = state->task;
+	unsigned long fp = state->fp;
+
+	if (fp & 0x7)
+		return -EINVAL;
+
+	if (!on_accessible_stack(tsk, fp, 16, info))
+		return -EINVAL;
+
+	if (test_bit(info->type, state->stacks_done))
+		return -EINVAL;
+
+	/*
+	 * As stacks grow downward, any valid record on the same stack must be
+	 * at a strictly higher address than the prior record.
+	 *
+	 * Stacks can nest in several valid orders, e.g.
+	 *
+	 * TASK -> IRQ -> OVERFLOW -> SDEI_NORMAL
+	 * TASK -> SDEI_NORMAL -> SDEI_CRITICAL -> OVERFLOW
+	 *
+	 * ... but the nesting itself is strict. Once we transition from one
+	 * stack to another, it's never valid to unwind back to that first
+	 * stack.
+	 */
+	if (info->type == state->prev_type) {
+		if (fp <= state->prev_fp)
+			return -EINVAL;
+	} else {
+		__set_bit(state->prev_type, state->stacks_done);
+	}
+
+	/*
+	 * Record this frame record's values and location. The prev_fp and
+	 * prev_type are only meaningful to the next unwind_next() invocation.
+	 */
+	state->fp = READ_ONCE(*(unsigned long *)(fp));
+	state->pc = READ_ONCE(*(unsigned long *)(fp + 8));
+	state->prev_fp = fp;
+	state->prev_type = info->type;
+
+	return 0;
+}
 #endif	/* __ASM_STACKTRACE_COMMON_H */
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 94a5dd2ab8fd..834851939364 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -81,48 +81,15 @@ static int notrace unwind_next(struct unwind_state *state)
 	struct task_struct *tsk = state->task;
 	unsigned long fp = state->fp;
 	struct stack_info info;
+	int err;
 
 	/* Final frame; nothing to unwind */
 	if (fp == (unsigned long)task_pt_regs(tsk)->stackframe)
 		return -ENOENT;
 
-	if (fp & 0x7)
-		return -EINVAL;
-
-	if (!on_accessible_stack(tsk, fp, 16, &info))
-		return -EINVAL;
-
-	if (test_bit(info.type, state->stacks_done))
-		return -EINVAL;
-
-	/*
-	 * As stacks grow downward, any valid record on the same stack must be
-	 * at a strictly higher address than the prior record.
-	 *
-	 * Stacks can nest in several valid orders, e.g.
-	 *
-	 * TASK -> IRQ -> OVERFLOW -> SDEI_NORMAL
-	 * TASK -> SDEI_NORMAL -> SDEI_CRITICAL -> OVERFLOW
-	 *
-	 * ... but the nesting itself is strict. Once we transition from one
-	 * stack to another, it's never valid to unwind back to that first
-	 * stack.
-	 */
-	if (info.type == state->prev_type) {
-		if (fp <= state->prev_fp)
-			return -EINVAL;
-	} else {
-		__set_bit(state->prev_type, state->stacks_done);
-	}
-
-	/*
-	 * Record this frame record's values and location. The prev_fp and
-	 * prev_type are only meaningful to the next unwind_next() invocation.
-	 */
-	state->fp = READ_ONCE(*(unsigned long *)(fp));
-	state->pc = READ_ONCE(*(unsigned long *)(fp + 8));
-	state->prev_fp = fp;
-	state->prev_type = info.type;
+	err = unwind_next_common(state, &info);
+	if (err)
+		return err;
 
 	state->pc = ptrauth_strip_insn_pac(state->pc);
 
-- 
2.37.0.170.g444d1eabd0-goog

