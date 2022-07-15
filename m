Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DB9575B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiGOGLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiGOGLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:11:09 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50907538A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31d17879672so33588277b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Own2o6tbvKIuIfDt6RX1YCvxnzH3pv8ZlCIH8Z843R8=;
        b=gfo5C0kAFY/DhTYcpdsweNWRc6amIrJNxK2I6HRtQ1uRYwQkM+g/8EfbXv8Jei6Dy9
         Z3OVhzTJCmCJBhLoGzA9ZSot85i+TAuxQmWGFXx5Oxrac0FoumywLrg0LuCX2qshququ
         bohBvC4W75iypt1b+ihRn+heB0no3yJOzheWD8OObzEQnVAqJYoA8CKmaRG68INYPpM5
         05WxGrtJapF4xGy2z4Lb0aC8BzBtubmgLcikBRK4ApIBr+yIQuvngHlV0EgD66e1LJ+E
         AMUJAXWxOsxqa9IaVKLx/kLcperTi5N3cXEJav8qwYoRzXZO4chjjIzjRDp7i8keLZJQ
         37Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Own2o6tbvKIuIfDt6RX1YCvxnzH3pv8ZlCIH8Z843R8=;
        b=qcFMJ7ssS7WX3wB4XEJ7/GAG887/TC/vzvQ5k1DtWxmhgl+hAh0PLfV4ECL9XS8FRP
         AkB9RVYFPYaJZq8aWEs7DPa3Nau2AISKJE+y9lwRKS1F5wHcpCQwJmjY4F/WJF8W2qQg
         s3D7EWBuMq7nk785g7iJGHvp397fI4Cmm4clPm4jXFQpzCyRPp51EbHL9+Sm7o/TmRqv
         oi9vB/T72Jv79AnAm3fVZ+d7UK7G6OekzbhvxEFv0H1+M7d0xFIYITY0hyPNVGOTvRGU
         EhIsTORYSaUV6b79ZDQ4+xG+AhPQSdeUPvs13rDr8lhXOEl1Y/T+hlbTN60Dx4SfbAdy
         gOaA==
X-Gm-Message-State: AJIora9vMmqK3LLtBvZf2Ay23X+5Sl140LWrtjyYXKKUu3D+fHdGWDZF
        mCC27AGWCH82W2nO8uXEnsywZ38UOJzrIc6jTg==
X-Google-Smtp-Source: AGRyM1toginxWVu828tmbdDVi6RqxU4m5ogiI5wsF/cD/T/ASSWS9NG8+M6vpw5CwwLtUUF5ffU/O7fWHtDB+TCoLA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f010:455b:62ce:19e])
 (user=kaleshsingh job=sendgmr) by 2002:a0d:c547:0:b0:31b:d6fa:c05c with SMTP
 id h68-20020a0dc547000000b0031bd6fac05cmr14137326ywd.105.1657865463413; Thu,
 14 Jul 2022 23:11:03 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:10:13 -0700
In-Reply-To: <20220715061027.1612149-1-kaleshsingh@google.com>
Message-Id: <20220715061027.1612149-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 04/18] arm64: stacktrace: Handle frame pointer from
 different address spaces
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

The unwinder code is made reusable so that it can be used to
unwind various types of stacks. One usecase is unwinding the
nVHE hyp stack from the host (EL1) in non-protected mode. This
means that the unwinder must be able to tracnslate HYP stack
addresses to kernel addresses.

Add a callback (stack_trace_translate_fp_fn) to allow specifying
the translation function.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/stacktrace/common.h | 26 ++++++++++++++++++++--
 arch/arm64/kernel/stacktrace.c             |  2 +-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
index 0c5cbfdb56b5..5f5d74a286f3 100644
--- a/arch/arm64/include/asm/stacktrace/common.h
+++ b/arch/arm64/include/asm/stacktrace/common.h
@@ -123,9 +123,22 @@ static inline void unwind_init_common(struct unwind_state *state,
 	state->prev_fp = 0;
 	state->prev_type = STACK_TYPE_UNKNOWN;
 }
+/**
+ * stack_trace_translate_fp_fn() - Translates a non-kernel frame pointer to
+ * a kernel address.
+ *
+ * @fp:   the frame pointer to be updated to it's kernel address.
+ * @type: the stack type associated with frame pointer @fp
+ *
+ * Returns true and success and @fp is updated to the corresponding
+ * kernel virtual address; otherwise returns false.
+ */
+typedef bool (*stack_trace_translate_fp_fn)(unsigned long *fp,
+					    enum stack_type type);
 
 static inline int unwind_next_common(struct unwind_state *state,
-				     struct stack_info *info)
+				     struct stack_info *info,
+				     stack_trace_translate_fp_fn translate_fp)
 {
 	struct task_struct *tsk = state->task;
 	unsigned long fp = state->fp;
@@ -159,13 +172,22 @@ static inline int unwind_next_common(struct unwind_state *state,
 		__set_bit(state->prev_type, state->stacks_done);
 	}
 
+	/* Record fp as prev_fp before attempting to get the next fp */
+	state->prev_fp = fp;
+
+	/*
+	 * If fp is not from the current address space perform the necessary
+	 * translation before dereferencing it to get the next fp.
+	 */
+	if (translate_fp && !translate_fp(&fp, info->type))
+		return -EINVAL;
+
 	/*
 	 * Record this frame record's values and location. The prev_fp and
 	 * prev_type are only meaningful to the next unwind_next() invocation.
 	 */
 	state->fp = READ_ONCE(*(unsigned long *)(fp));
 	state->pc = READ_ONCE(*(unsigned long *)(fp + 8));
-	state->prev_fp = fp;
 	state->prev_type = info->type;
 
 	return 0;
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 834851939364..eef3cf6bf2d7 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -87,7 +87,7 @@ static int notrace unwind_next(struct unwind_state *state)
 	if (fp == (unsigned long)task_pt_regs(tsk)->stackframe)
 		return -ENOENT;
 
-	err = unwind_next_common(state, &info);
+	err = unwind_next_common(state, &info, NULL);
 	if (err)
 		return err;
 
-- 
2.37.0.170.g444d1eabd0-goog

