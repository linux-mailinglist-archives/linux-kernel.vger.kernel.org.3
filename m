Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9DB575B54
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiGOGMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiGOGLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:11:53 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A577B37F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31c9d560435so33857057b3.21
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Aen+FkdIlH4p9Bga5nOuPk26qtzTJbITGhY4IEaQl1E=;
        b=Kl/Wb7az0Dpk964K/t53obqM+aCIu3rAPB8Mi4lFae6KU/yHzI081j9LkXEZvLEs5F
         MPJViYowMIzNBQddAvvw7Po85N97ikHIUNw2aCqDw4i0AXDa82B4v1KEU83z8qseqlST
         HTZXzVTx3cEKvN3jrQAGdDnMKiiAgo4UkwjXsn09TeVUtUfosl4u4YQzK7dAc35q0KiF
         K6rSEFoTr7QPg89dMkQWTWdYZMsZfSwVCROcIJWnD/ArXlt2GsZXHYJeqHpcyX2uz6SL
         H7qz9XZxaBwBvC2Fh/vPGLAMM6u3TCdO9kkrMhmIrKu0QEl1nu32DcC3LA/cIr2Y6+19
         rXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Aen+FkdIlH4p9Bga5nOuPk26qtzTJbITGhY4IEaQl1E=;
        b=3NIRdWc8n652g6gZS1ixRpjQU7SuEF/9D/PVxTFLw1GUddoUvlQjs2x6UT4LLpzVBH
         jMA8Z9QZEjdEcIfxaRHTVu8y+eY+1H2YFyRVBusrFz6rIEx63dC+mMHQhYDwanpasvnv
         xHVEjtQFjZ7wCQbS1dqkckFONbc6YdZaO0XCTkEmenncetKCsta/oRyHuXXdieB5d0to
         MObjwssVoT+uRZtZrHpxJX25/GJ3idzX+jkFB9I+U8HicVI8KPWl22bWOwCVVAy25hdC
         5ZqhmxUfdEjFwucZ7y6jHibn6SpKYDkBlg349fpz/majZbQ8P/mu/47rbxA7k62ipkZH
         vYbQ==
X-Gm-Message-State: AJIora8kBevadBJ62QOHjFswD2nNm/TbXwXoXQBTOCIQcCcmwjcjb68x
        +x6caKa9CHnQPuQnAT+/B949VDL0G/3f50JurA==
X-Google-Smtp-Source: AGRyM1u/PT8LdM4OlzT2z2Ts/bIUkpNGqVgHGqY8xhTai+zpsROBqKpKpWbwRpuEkJh/W1ny4LwrRcq2gKzotGoM5Q==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f010:455b:62ce:19e])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:849:0:b0:66e:a027:3c with SMTP id
 v9-20020a5b0849000000b0066ea027003cmr11796208ybq.208.1657865499596; Thu, 14
 Jul 2022 23:11:39 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:10:23 -0700
In-Reply-To: <20220715061027.1612149-1-kaleshsingh@google.com>
Message-Id: <20220715061027.1612149-15-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 14/18] KVM: arm64: Implement protected nVHE hyp stack unwinder
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
index b362086f4c70..cf442e67dccd 100644
--- a/arch/arm64/include/asm/stacktrace/common.h
+++ b/arch/arm64/include/asm/stacktrace/common.h
@@ -27,6 +27,7 @@ enum stack_type {
 	STACK_TYPE_OVERFLOW,
 	STACK_TYPE_SDEI_NORMAL,
 	STACK_TYPE_SDEI_CRITICAL,
+	STACK_TYPE_HYP,
 	__NR_STACK_TYPES
 };
 
@@ -171,6 +172,7 @@ static inline int unwind_next_common(struct unwind_state *state,
 	 *
 	 * TASK -> IRQ -> OVERFLOW -> SDEI_NORMAL
 	 * TASK -> SDEI_NORMAL -> SDEI_CRITICAL -> OVERFLOW
+	 * HYP -> OVERFLOW
 	 *
 	 * ... but the nesting itself is strict. Once we transition from one
 	 * stack to another, it's never valid to unwind back to that first
diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
index 1aadfd8d7ac9..c7c8ac889ec1 100644
--- a/arch/arm64/include/asm/stacktrace/nvhe.h
+++ b/arch/arm64/include/asm/stacktrace/nvhe.h
@@ -38,10 +38,19 @@ static __always_inline void kvm_nvhe_unwind_init(struct unwind_state *state,
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
 
@@ -59,12 +68,27 @@ extern void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc);
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
 
 static int notrace unwind_next(struct unwind_state *state)
 {
-	return 0;
+	struct stack_info info;
+
+	return unwind_next_common(state, &info, NULL);
 }
 NOKPROBE_SYMBOL(unwind_next);
 #else	/* !CONFIG_PROTECTED_NVHE_STACKTRACE */
@@ -74,6 +98,12 @@ static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
 	return false;
 }
 
+static inline bool on_hyp_stack(unsigned long sp, unsigned long size,
+				struct stack_info *info)
+{
+	return false;
+}
+
 static int notrace unwind_next(struct unwind_state *state)
 {
 	return 0;
-- 
2.37.0.170.g444d1eabd0-goog

