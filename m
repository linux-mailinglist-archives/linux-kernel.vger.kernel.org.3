Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2E2580DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiGZHjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiGZHil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:38:41 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623912B602
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2eb7d137101so105387007b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5LzygoxYBmX52V1I8A5Hvt/OcxOdlEMYc0Y930yUiBQ=;
        b=lxba6zPS8bNj3T4SQ4NgtR3spXvbVhLqKPcx1Hc782Lm9/xnxi+CiSSlzu4yrB+6Ob
         +nmlTtMJekStORm3jx3MPu7T8RpB2I3EFhmAMg67K2+TOyWtvgD8ceXd2DZEz98cp+tB
         AHbCkifdg/jPtMKpNDl63zHG7jkWkO4I6Mrp++lQyYGmqJhbb8+2J+8O3jJTXddAXJze
         hzHbAAZxokWC+22wtYsQGG0iXfr3iYegpLoWC3Za44kxt61yZtjlHL5W74mLLRp4HBVo
         2PURIJR3vLCK3lvSW66LOdSgAoZIvwAkopq9F1Qr9I8F1VaYKVLQYLvCnqkmvISyVhlB
         8OpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5LzygoxYBmX52V1I8A5Hvt/OcxOdlEMYc0Y930yUiBQ=;
        b=KJyJI3dwYje/4yqNuUEJY9Li7QZZ2TAMNNU8LjPpPnCqgOQjIh/GQX4jKThfS/e5oI
         lJKa6negX7uHdo69Dh+bGPAqsb+bs/1xX1v+OoyhovzwhVWO3uD8lNjH5lzesMfGkss9
         GiH7hieMfrrQXOWo2gGmel3HP0DRaPuu6hfquFrOjg11yWIsBFqjeQuZ/3DnVpJFa+ji
         OvNIz6XhWVhZf7X90NkzkGhd1kOvb4R1TExp0uemvPZRZUWzDjZ5uedhgOsATU981ljL
         ORv+vlhiObExNv3znSv8nusRIOK7pagMTrbpYfhAWViJ9hR6/glu87a96TWheBlywy6J
         +w7A==
X-Gm-Message-State: AJIora+bRe7gILKptgmvZEYrud5FpSkt1bkN/5UK6YGVCy7ypLtk/dcW
        ny7qofdCc/ZQ4hdCOwRa/sXdDpVeQzUUQqS12g==
X-Google-Smtp-Source: AGRyM1vLCGxSpACfvit1h9qHAotszBcN5RiBC0/VBQZAO/C3DHxhNjsQIs2RUsZ7LNGl/jujBDMD9xrWPH2wZ/0Q7A==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:4f77:3b64:736a:394e])
 (user=kaleshsingh job=sendgmr) by 2002:a25:4c9:0:b0:671:6f60:eed8 with SMTP
 id 192-20020a2504c9000000b006716f60eed8mr1683033ybe.243.1658821082719; Tue,
 26 Jul 2022 00:38:02 -0700 (PDT)
Date:   Tue, 26 Jul 2022 00:37:36 -0700
In-Reply-To: <20220726073750.3219117-1-kaleshsingh@google.com>
Message-Id: <20220726073750.3219117-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220726073750.3219117-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v6 03/17] arm64: stacktrace: Factor out unwind_next_common()
From:   Kalesh Singh <kaleshsingh@google.com>
To:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, tabba@google.com,
        oliver.upton@linux.dev
Cc:     will@kernel.org, qperret@google.com, kaleshsingh@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, wangkefeng.wang@huawei.com,
        elver@google.com, keirf@google.com, yuzenghui@huawei.com,
        ardb@kernel.org, oupton@google.com,
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
Tested-by: Fuad Tabba <tabba@google.com>
---

Changes in v6:
  - Add Fuad's Tested-by tag

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
2.37.1.359.gd136c6c3e2-goog

