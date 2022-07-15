Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA305575B39
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiGOGKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiGOGKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:10:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98223DBD2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:10:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31c972f5f84so33607597b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/Ia+O9M0Pz2+/05x4XoBRaUcJqadaj8Ww7ydsZGTIyc=;
        b=AsFH83JSc75pqQLjhwbkNC5eEmbVMfMhBpPhg7rjc25BQstmijhQMgTA+PPbxJYlqN
         QPVHh8kifhnzc58ChmI3fgEyNUKltfrMrL+ztxu2EOY7NCdrkHxnV8NMvG/wC3CD+uXU
         dAxvUDRaBJDjKtmTWDjl5DPdd+gPLE/+RiY4lPMa2oGT1tRuMwcgcIPgFOqRKpNBMp9d
         Khxf6sFE2z9CYuQWyepW9GSGfVixtwjnqotLqhBTyVuYzQxt7DIX7fontQfVBdI7aFon
         MuJbSY7lOoXOx555VBK2EWAbxAa10joar+VP9GpSz11xwuxaKieYJDSmFvWw+Kh7aS+7
         lQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/Ia+O9M0Pz2+/05x4XoBRaUcJqadaj8Ww7ydsZGTIyc=;
        b=IL9pj2braW+3We8haBl6qLMHLZn6wdw5DUJ+RIUFCNPaYAzHcvSKeElQUoAJxBh+qM
         BRz4/CbBk3gNCkLBOopJ2bNEg1dtkXkRZv7WnvcK8eCNjRQWd0cH+c+l/kX8dCxq5Yxi
         K0td37XCJPSCrJagwqhSojwt4aefuBjY2qk7noa4DfTy4wMxrHyv/aCDlx+6+bDLeD5h
         q0onp2IXRa51V353r/ClvGe9rV8GoVOxbnLMzNtg6CUkUWJCFnyl13xL6A6MH7RZg2kJ
         NLzp35idvUC+fmBowM0cbFVokMl/U2G9c3E42OUmEQtZnOQ/2qvwKJMVFuVOCJV/5mbT
         6mZQ==
X-Gm-Message-State: AJIora8lm9HJyfBY42uwIQgb/ls8By0FrLd4HHFvyfoC0ah3EdkPnSM/
        u4NfZMNHEVeczUeQArMgNPF3Mpe8kKPTFXxOUQ==
X-Google-Smtp-Source: AGRyM1vQf/Bx1CweucDNGXThIQceIJF3jerLq31SSlQ4DRKoZzzVX77BCd9Mi+GQ+qVz+MEqdkAvXKVOyWEjNha+Qg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f010:455b:62ce:19e])
 (user=kaleshsingh job=sendgmr) by 2002:a0d:f647:0:b0:31d:17cc:3337 with SMTP
 id g68-20020a0df647000000b0031d17cc3337mr14046493ywf.100.1657865438690; Thu,
 14 Jul 2022 23:10:38 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:10:11 -0700
In-Reply-To: <20220715061027.1612149-1-kaleshsingh@google.com>
Message-Id: <20220715061027.1612149-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 02/18] arm64: stacktrace: Factor out on_accessible_stack_common()
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move common on_accessible_stack checks to stacktrace/common.h. This is
used in the implementation of the nVHE hypervisor unwinder later in
this series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/stacktrace.h        |  8 ++------
 arch/arm64/include/asm/stacktrace/common.h | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 79f455b37c84..a4f8b84fb459 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -56,7 +56,6 @@ static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
 			struct stack_info *info) { return false; }
 #endif
 
-
 /*
  * We can only safely access per-cpu stacks from current in a non-preemptible
  * context.
@@ -65,8 +64,8 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
 				       unsigned long sp, unsigned long size,
 				       struct stack_info *info)
 {
-	if (info)
-		info->type = STACK_TYPE_UNKNOWN;
+	if (on_accessible_stack_common(tsk, sp, size, info))
+		return true;
 
 	if (on_task_stack(tsk, sp, size, info))
 		return true;
@@ -74,12 +73,9 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
 		return false;
 	if (on_irq_stack(sp, size, info))
 		return true;
-	if (on_overflow_stack(sp, size, info))
-		return true;
 	if (on_sdei_stack(sp, size, info))
 		return true;
 
 	return false;
 }
-
 #endif	/* __ASM_STACKTRACE_H */
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

