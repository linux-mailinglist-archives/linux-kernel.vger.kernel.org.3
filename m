Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D3457C3E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiGUF5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiGUF5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:57:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1955E79ECE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:57:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v1-20020a259d81000000b0066ec7dff8feso570172ybp.18
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hybHHJpNkr5qvVF2psrpE5ezfSg01aH1BSluCT+EV4I=;
        b=Gy3GT+AejE5lIqh2FM7HDqKdxCV2+m38IsmUpjEKK1QJmEoelcLR1wNLUpjwR0PQkT
         B/On8ku5ir8YgBuuIXV0lnVfrOyHsaNGO/oL7BybSdER3FWejp7+Df8wxKW/R20ChgQO
         0tgF+VaCWq69D/tqUhWzHS7NsjR7+BjUQboxtxC/mIamoEzuietAqDCS5WNaPh0NI1a7
         mrsgfg+J61pDYkEnH16ghZeVk38xPbU9JFqu4U396jprd1MwcgriPzJJOiokg7xUfE+x
         Rz6bdZ0FG+eKIe2YdXgj6+0uRXCSoNKy9bpzXtHHvJX1XzmnGuI3NqMkai5ZBhjlyTO5
         9Dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hybHHJpNkr5qvVF2psrpE5ezfSg01aH1BSluCT+EV4I=;
        b=gBWX4+5gRcQnhvP640vIcoeUnQwuAJ7qFPAfK8+AXpuL+yalYRX3T6taAjGyjH8kIe
         vvz0sDtczbAU2HNj+oiQt6ZVOU0F68se22nt9tkZb+U56tVyIs9jy3KvE3OXuPwQ70y1
         vqKe1hqsZR/bvCqUoOyE/6u87iWKFx+NcE4FaKzxca9ih71uzMzjOxSYQaveAr86vCsd
         CmImWXGWhcl8i/MaT5FNs/S3g20Ve+UCKOT98NaugIwZXjh5CabcpTQJA7mwmEJBxgwP
         g3yG6dzNh5kHLiDLuI+b1rPs1rAUi6gpl4+KBbj93iGrkIS80IzapBWVvR4UamYm1xci
         axUQ==
X-Gm-Message-State: AJIora9azlPIICcT3ykBVUhmEt7g5ix7uj/ckIqArFBF74PyVMcIpw2O
        8fpkaCYWhaiLyVIke9V99+Nz3jBZUCBZ3xTGxQ==
X-Google-Smtp-Source: AGRyM1t7p5bQOsZ7cBIoy5YIYG4Vty+5ObB0xcGW4MddH7Fc9hMYX+1F2OdOwVc+nCl0IjFDFNgEYMiRjLwrtJHNPw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5a87:b61e:76b5:d1e0])
 (user=kaleshsingh job=sendgmr) by 2002:a25:d117:0:b0:670:7e79:e104 with SMTP
 id i23-20020a25d117000000b006707e79e104mr11309346ybg.528.1658383060543; Wed,
 20 Jul 2022 22:57:40 -0700 (PDT)
Date:   Wed, 20 Jul 2022 22:57:14 -0700
In-Reply-To: <20220721055728.718573-1-kaleshsingh@google.com>
Message-Id: <20220721055728.718573-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v5 03/17] arm64: stacktrace: Factor out unwind_next_common()
From:   Kalesh Singh <kaleshsingh@google.com>
To:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, tabba@google.com
Cc:     will@kernel.org, qperret@google.com, kaleshsingh@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, drjones@redhat.com,
        wangkefeng.wang@huawei.com, elver@google.com, keirf@google.com,
        yuzenghui@huawei.com, ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move common unwind_next logic to stacktrace/common.h. This allows
reusing the code in the implementation the nVHE hypervisor stack
unwinder, later in this series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---

Changes in v5:
  - Add Reviewed-by tags from Mark Brown and Fuad

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

