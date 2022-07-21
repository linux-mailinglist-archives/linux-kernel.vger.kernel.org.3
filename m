Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4566F57C3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiGUF5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiGUF5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:57:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF07978DDE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:57:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31e559f6840so6702657b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iuiJRZjPzVH9NFZXc2I6eZu6HPWoG6DIfc9zwIk6fqU=;
        b=Ub0rmGKgsPw/uAZ4GGpi1VBT46ThpqEdpr2mq5eMvygSt80XqgB/W48o9TC1s3+qQS
         v7DHcG2nDxfhoyg2sVyhfTK1tZgdAmY8h3XLPAHmTVUmOr+REfo2lm37KSYFn0DZJkoo
         fAPXgIdDJaieSrl96TjbUmS0Apzy9/IwJS8MSzDEGhlEf7kVwIHmY/AvMqDSAb+r/3un
         HTJoGcKhknLgg8DBNTgbWSM0ot1aggOfhqWLlmPxSAmrPvtDYz+yzz9CQiaZcUjI8f8z
         +PfBftcQ+q2R/jPuE6SyZ1Jp8dLREhbSOn5/T3iKFcDQF9YB2nUogVbKGT7n3tY7Yb+f
         IBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iuiJRZjPzVH9NFZXc2I6eZu6HPWoG6DIfc9zwIk6fqU=;
        b=zToMhLTMLQheVQnZssmWREa7QYoAQppCGpg5TBnW2wzgvGKAwo9yHsSf15qZCT8Ajs
         nybrPYLKTCpdhLupw0x01juo0NOsbguLVEi3CgJf+QpKnFkk9uRsNUecxt32zqCvMvkj
         I4DKxlqMnnN4cXivlRxjm1+2KeLm0/cqOD3PGNrwPCXryNP1rrzx/WrUDEbTzHpH7sXj
         3EMC+7j0iIL6GxbtjAyuqOWSFKMNDrM9Vj8FKKrizeOfyFl9U112OSEeX9MZQNcRlo9F
         xNtUehIL/3G9kw7IJMVKzj67tUHZkxzDs7D2eW0JVLXGfsk/yl/anFY5cjWaYo8OzsGd
         G8Lw==
X-Gm-Message-State: AJIora9RpiBjYZzBQs3wscgYu700s12CDzqgSjPtB4IrFra/uxypVPZZ
        75yxYCFgZBJ/ckmhHJOY5BEjdr2YP34QigxqIg==
X-Google-Smtp-Source: AGRyM1vGT8w8+qyglCyqqsexhhFl2xh/RNXpV9KZJmAlMvxnjkqvinTizqBBiGxZFk68SWeE0uI4FjmfcyDRZ1sZmg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5a87:b61e:76b5:d1e0])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:114d:b0:66d:9fa6:4bd4 with
 SMTP id p13-20020a056902114d00b0066d9fa64bd4mr37315370ybu.362.1658383058157;
 Wed, 20 Jul 2022 22:57:38 -0700 (PDT)
Date:   Wed, 20 Jul 2022 22:57:13 -0700
In-Reply-To: <20220721055728.718573-1-kaleshsingh@google.com>
Message-Id: <20220721055728.718573-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v5 02/17] arm64: stacktrace: Factor out on_accessible_stack_common()
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move common on_accessible_stack checks to stacktrace/common.h. This is
used in the implementation of the nVHE hypervisor unwinder later in
this series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---

Changes in v5:
  - Add Reviewed-by tags from Mark Brown and Fuad
  - Remove random whitespace change, per Mark Brown

 arch/arm64/include/asm/stacktrace.h        |  6 ++----
 arch/arm64/include/asm/stacktrace/common.h | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 79f455b37c84..43f4b4a6d383 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -65,8 +65,8 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
 				       unsigned long sp, unsigned long size,
 				       struct stack_info *info)
 {
-	if (info)
-		info->type = STACK_TYPE_UNKNOWN;
+	if (on_accessible_stack_common(tsk, sp, size, info))
+		return true;
 
 	if (on_task_stack(tsk, sp, size, info))
 		return true;
@@ -74,8 +74,6 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
 		return false;
 	if (on_irq_stack(sp, size, info))
 		return true;
-	if (on_overflow_stack(sp, size, info))
-		return true;
 	if (on_sdei_stack(sp, size, info))
 		return true;
 
diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
index 64ae4f6b06fe..f58b786460d3 100644
--- a/arch/arm64/include/asm/stacktrace/common.h
+++ b/arch/arm64/include/asm/stacktrace/common.h
@@ -62,6 +62,9 @@ struct unwind_state {
 	struct task_struct *task;
 };
 
+static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
+				     struct stack_info *info);
+
 static inline bool on_stack(unsigned long sp, unsigned long size,
 			    unsigned long low, unsigned long high,
 			    enum stack_type type, struct stack_info *info)
@@ -80,6 +83,21 @@ static inline bool on_stack(unsigned long sp, unsigned long size,
 	return true;
 }
 
+static inline bool on_accessible_stack_common(const struct task_struct *tsk,
+					      unsigned long sp,
+					      unsigned long size,
+					      struct stack_info *info)
+{
+	if (info)
+		info->type = STACK_TYPE_UNKNOWN;
+
+	/*
+	 * Both the kernel and nvhe hypervisor make use of
+	 * an overflow_stack
+	 */
+	return on_overflow_stack(sp, size, info);
+}
+
 static inline void unwind_init_common(struct unwind_state *state,
 				      struct task_struct *task)
 {
-- 
2.37.0.170.g444d1eabd0-goog

