Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076CF57C400
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiGUF6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiGUF6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:58:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D9A79ED0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:58:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x8-20020a5b0948000000b006707a126318so599881ybq.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4s5X/+YCEmbcnDUwCHy1+kT8bVMvMylr6BkPvcZOYaI=;
        b=Hn8tDDVc0jcMOfIfcL7Tu34q/rCTcA8rnhoPvX/kVCgOu3vXyuDDkfkT597nYfwbfp
         4ORIBESXdaMaeKjj+U19qYy2XGpQxAUT0bsM+BQretTXEB6PWKE9iqRxqc1HxgVvwTyv
         YBR+U/GgeyaOOAiDI2fE/vXex7Eo6fMwLqUJa27U4Yef2PWnHrh8LZbTHnOmpg67QL8D
         yTgQkqEUS92Ba6PkU2POCDZkstTHe5z/0JDT6Kxx7sbSgJ2m1J4lJv6xJ8MekVNKiZ6X
         koOKLyQNvI2jYg07OxqXuZRj5C4KdqD1MwZvvFWcWvHYVoKuh6/BK6s8uw6GYBwWV9KL
         0Brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4s5X/+YCEmbcnDUwCHy1+kT8bVMvMylr6BkPvcZOYaI=;
        b=Q+YFTQVCuveLsbGqg6+D3BVEksiKGHo3BXXia6siDjiW05gDc8zWbK7apgKfa/my01
         oE/HJDe1bkx807mNmXzXjKxE6QLPf6MPh3D3aRA59zjv6yiVKOOUITrcg3FrvqSdbaEN
         ZPa6s5//rMQ/fh91DxX7RW+tjVN0SDDe9j8mUzpxI0fS18uoC6LvY4jUdoG9fklbhKO6
         6oBSAqiqL5ZEXrSz/71xI9vIr+EMAXl+9KKZ4FyOvjo86SK92jVsTjnrm9kbsHoQ4YeX
         Lv1ZK96Alay7R0xa7CIzcNaaE7s/iROXZzIO1brQ1SMKgjbE/Ct1ZdrhwtsUOv4oBdg2
         BC0A==
X-Gm-Message-State: AJIora9mNcgb/VgttN6r/lkiDXCbPl1HWzB+RXk8j4HnfzlaLc/7AXrv
        wMVmEAaSjwukMqGFs65CfLdb6wxfPhd5S2qquw==
X-Google-Smtp-Source: AGRyM1vTsife9M3jC/RGyzsoBBcL6UKgtSGPhy1mwndXgmrgVzbFMS42En18APbAoAXWfT95Wu4YGZ+TT/Ki5Tnxxw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5a87:b61e:76b5:d1e0])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:282:b0:66e:26b0:8f16 with
 SMTP id v2-20020a056902028200b0066e26b08f16mr39101418ybh.469.1658383088431;
 Wed, 20 Jul 2022 22:58:08 -0700 (PDT)
Date:   Wed, 20 Jul 2022 22:57:25 -0700
In-Reply-To: <20220721055728.718573-1-kaleshsingh@google.com>
Message-Id: <20220721055728.718573-15-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v5 14/17] KVM: arm64: Implement protected nVHE hyp stack unwinder
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

Implements the common framework necessary for unwind() to work in
the protected nVHE context:
   - on_accessible_stack()
   - on_overflow_stack()
   - unwind_next()

Protected nVHE unwind() is used to unwind and save the hyp stack
addresses to the shared stacktrace buffer. The host reads the
entries in this buffer, symbolizes and dumps the stacktrace (later
patch in the series).

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/stacktrace/common.h |  2 ++
 arch/arm64/include/asm/stacktrace/nvhe.h   | 34 ++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
index be7920ba70b0..73fd9e143c4a 100644
--- a/arch/arm64/include/asm/stacktrace/common.h
+++ b/arch/arm64/include/asm/stacktrace/common.h
@@ -34,6 +34,7 @@ enum stack_type {
 	STACK_TYPE_OVERFLOW,
 	STACK_TYPE_SDEI_NORMAL,
 	STACK_TYPE_SDEI_CRITICAL,
+	STACK_TYPE_HYP,
 	__NR_STACK_TYPES
 };
 
@@ -186,6 +187,7 @@ static inline int unwind_next_common(struct unwind_state *state,
 	 *
 	 * TASK -> IRQ -> OVERFLOW -> SDEI_NORMAL
 	 * TASK -> SDEI_NORMAL -> SDEI_CRITICAL -> OVERFLOW
+	 * HYP -> OVERFLOW
 	 *
 	 * ... but the nesting itself is strict. Once we transition from one
 	 * stack to another, it's never valid to unwind back to that first
diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
index 8f02803a005f..c3688e717136 100644
--- a/arch/arm64/include/asm/stacktrace/nvhe.h
+++ b/arch/arm64/include/asm/stacktrace/nvhe.h
@@ -39,10 +39,19 @@ static inline void kvm_nvhe_unwind_init(struct unwind_state *state,
 	state->pc = pc;
 }
 
+static inline bool on_hyp_stack(unsigned long sp, unsigned long size,
+				struct stack_info *info);
+
 static inline bool on_accessible_stack(const struct task_struct *tsk,
 				       unsigned long sp, unsigned long size,
 				       struct stack_info *info)
 {
+	if (on_accessible_stack_common(tsk, sp, size, info))
+		return true;
+
+	if (on_hyp_stack(sp, size, info))
+		return true;
+
 	return false;
 }
 
@@ -60,12 +69,27 @@ DECLARE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
 				     struct stack_info *info)
 {
-	return false;
+	unsigned long low = (unsigned long)this_cpu_ptr(overflow_stack);
+	unsigned long high = low + OVERFLOW_STACK_SIZE;
+
+	return on_stack(sp, size, low, high, STACK_TYPE_OVERFLOW, info);
+}
+
+static inline bool on_hyp_stack(unsigned long sp, unsigned long size,
+				struct stack_info *info)
+{
+	struct kvm_nvhe_init_params *params = this_cpu_ptr(&kvm_init_params);
+	unsigned long high = params->stack_hyp_va;
+	unsigned long low = high - PAGE_SIZE;
+
+	return on_stack(sp, size, low, high, STACK_TYPE_HYP, info);
 }
 
 static inline int notrace unwind_next(struct unwind_state *state)
 {
-	return 0;
+	struct stack_info info;
+
+	return unwind_next_common(state, &info, NULL);
 }
 NOKPROBE_SYMBOL(unwind_next);
 #else	/* !CONFIG_PROTECTED_NVHE_STACKTRACE */
@@ -75,6 +99,12 @@ static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
 	return false;
 }
 
+static inline bool on_hyp_stack(unsigned long sp, unsigned long size,
+				struct stack_info *info)
+{
+	return false;
+}
+
 static inline int notrace unwind_next(struct unwind_state *state)
 {
 	return 0;
-- 
2.37.0.170.g444d1eabd0-goog

