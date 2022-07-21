Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EC857C3E8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiGUF5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiGUF5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:57:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DD679691
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:57:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v1-20020a259d81000000b0066ec7dff8feso570239ybp.18
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BrC0iFUi7vnhcT+nMUoOxg3oXGqYAC5+3i/gvJsLlbw=;
        b=SBHl0MnAKRFV5/9Cx0u9IGW1uKO26lo5LpMs/VKqDXqZhOUXW2q5KRdxO6ttiP3nDu
         0Ss8X8zAd7TS0qW4woYj8Mjk96gW1L50N3DM2DUASrIbtpsq92qGZVMoMSgieuWz2Wrm
         8cjfA/1BLtzpfvEgXZVCWeoF4ywAgZq0n8dt5kaCexB/mncyP9CD+WPCJYmygQFLEL33
         Rubo2DNaZC9AKNomceQdKYajP5aPFZijnBFtGYU96f6i9aM5TaiflC0BGzgKuEnV2cn4
         FN+Y5kmROrmAnRggZj9Vx3Lfcde7qoDWA9mly3RVHb6AJq54+dMsmrBrkvmtidf8Lt14
         BxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BrC0iFUi7vnhcT+nMUoOxg3oXGqYAC5+3i/gvJsLlbw=;
        b=UjBiwyCKdxbVRSdAxWJ3w8O2Dt+RmRfF+StkSVdZY5raFW85wIO2GdBshJp825U5dT
         sTf/1UP+/reu7L/+6LYQwXi9RVRth4ygtdrF7tUiB53086SVu0fBN/0cO8okw9f6pHGT
         vZqDOE2l0mQjAcT9+lEQQNsOP47dAxeZS02IslaPVenaq1Xo+DIYqM41yl2x2mgZWAj+
         6XFGEwZ1xoafcSuSYh4klbky/EGdiR3bLDzu4GQKGQBNnbKMdAy59F9vqZWTyVB030ai
         s328j9M8lUMHrPHMe+pBNX/K+H4rm2Z1+9AaWXX8faQfPETlOfe90gA6CU/Fhtk9ZWNx
         diFg==
X-Gm-Message-State: AJIora8Vx6Qsjo2efkhl8Fjh9nNa83gv9s+j43D4TP9w2mi47M6wHihK
        vFWrn6G08Cd3xitbpDyTTdQCI82umo15cRjmWw==
X-Google-Smtp-Source: AGRyM1s6dEnzSM/TjATo5XryVR3TbDiGD8oaFkh/6JrgATgoBXNgg6oZxo446DCtWSijqKIcoJISLrUkRSBrVKoaaQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5a87:b61e:76b5:d1e0])
 (user=kaleshsingh job=sendgmr) by 2002:a81:4e04:0:b0:31e:5782:ed76 with SMTP
 id c4-20020a814e04000000b0031e5782ed76mr13240666ywb.183.1658383063172; Wed,
 20 Jul 2022 22:57:43 -0700 (PDT)
Date:   Wed, 20 Jul 2022 22:57:15 -0700
In-Reply-To: <20220721055728.718573-1-kaleshsingh@google.com>
Message-Id: <20220721055728.718573-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v5 04/17] arm64: stacktrace: Handle frame pointer from
 different address spaces
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

The unwinder code is made reusable so that it can be used to
unwind various types of stacks. One usecase is unwinding the
nVHE hyp stack from the host (EL1) in non-protected mode. This
means that the unwinder must be able to translate HYP stack
addresses to kernel addresses.

Add a callback (stack_trace_translate_fp_fn) to allow specifying
the translation function.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v5:
  - Fix typo in commit text, per Fuad
  - Update unwind_next_common() to not have side effects on failure, per Fuad
  - Use regular comment instead of doc comments, per Fuad

 arch/arm64/include/asm/stacktrace/common.h | 29 +++++++++++++++++++---
 arch/arm64/kernel/stacktrace.c             |  2 +-
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
index 0c5cbfdb56b5..e89c8c39858d 100644
--- a/arch/arm64/include/asm/stacktrace/common.h
+++ b/arch/arm64/include/asm/stacktrace/common.h
@@ -124,11 +124,25 @@ static inline void unwind_init_common(struct unwind_state *state,
 	state->prev_type = STACK_TYPE_UNKNOWN;
 }
 
+/*
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
+
 static inline int unwind_next_common(struct unwind_state *state,
-				     struct stack_info *info)
+				     struct stack_info *info,
+				     stack_trace_translate_fp_fn translate_fp)
 {
+	unsigned long fp = state->fp, kern_fp = fp;
 	struct task_struct *tsk = state->task;
-	unsigned long fp = state->fp;
 
 	if (fp & 0x7)
 		return -EINVAL;
@@ -139,6 +153,13 @@ static inline int unwind_next_common(struct unwind_state *state,
 	if (test_bit(info->type, state->stacks_done))
 		return -EINVAL;
 
+	/*
+	 * If fp is not from the current address space perform the necessary
+	 * translation before dereferencing it to get the next fp.
+	 */
+	if (translate_fp && !translate_fp(&kern_fp, info->type))
+		return -EINVAL;
+
 	/*
 	 * As stacks grow downward, any valid record on the same stack must be
 	 * at a strictly higher address than the prior record.
@@ -163,8 +184,8 @@ static inline int unwind_next_common(struct unwind_state *state,
 	 * Record this frame record's values and location. The prev_fp and
 	 * prev_type are only meaningful to the next unwind_next() invocation.
 	 */
-	state->fp = READ_ONCE(*(unsigned long *)(fp));
-	state->pc = READ_ONCE(*(unsigned long *)(fp + 8));
+	state->fp = READ_ONCE(*(unsigned long *)(kern_fp));
+	state->pc = READ_ONCE(*(unsigned long *)(kern_fp + 8));
 	state->prev_fp = fp;
 	state->prev_type = info->type;
 
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

