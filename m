Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195D7575B57
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiGOGMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiGOGLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:11:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25B07B78B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:42 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31ce88f9ab8so33604427b3.16
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Yscefk8aqX/qdzK+Mn8nR6R0Ne1QrKgVF2VH9wy9A6w=;
        b=gv8BYhdodgL9+KafTVNOZjz5a9ojmWAVs0iVsXZHqPY5+FXfoUxXyL+7W//GXGAx1+
         GWhjgBEinl4Ot8YYyKKG/7Bk46KUu8Ok+8EKMIIoR9EidKiHtVQmXHelmZn9AWEcMea6
         f0CQVkWUuIxVTljmFpp1n+/TtD/gJbBTPESj736nhIIeHrxbpNyR6DM4lO7c99QH/HO/
         jaqtU/5X1c+nMAkIvMwWGQvkwHfMJ46xTmLmlNzvdZL8+Q7InCnnhZyvIKukmWSuvNET
         IRx7f6rM02ueatKa2ZXmKEvt5OTDqVrxZZaE4e9W4zkPuZyUJ8R/+ZFf4erB2GVZSL6m
         bgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Yscefk8aqX/qdzK+Mn8nR6R0Ne1QrKgVF2VH9wy9A6w=;
        b=fgKhOaz/mDNaTxRFy2eT/qvxcxnhG2NU93wGldTPwFJoi4zzyJbOb5I05wiX8SZFGd
         0n/HX35QgX2+UAKBmk1vm/lbgStAGbrpax1TGEtq4fP0q+JRHZpSjjOcnCzlDxNQfSt4
         y/ye3hliP97LsD+UnyieJ5ZT1HQx5VqEWUXvD7docAm3M9/GqxBwdRhvx8YeEPL7vdTH
         qCUboD1c4ucDL+XQALoKcolOlydN6Czfq0mD2XyZcC1B6snO5aYAshBH4UtFHhK/UJ4y
         jv34UGFUKoodVqGswFnAg4G/wS/2ISnYhqX9U78fjHp+ZP4QIJPMF+73AowhCmXX+H95
         M1Zw==
X-Gm-Message-State: AJIora9OaPHEHUxlNSOrC5dJurIpxdiyMFTo/3Vogs+LebfPcglu+m5f
        fL9VZVZfCJmH84mir5U1gpK6faHdQ3BEuRY87w==
X-Google-Smtp-Source: AGRyM1tRMPbG6Ei2Eu+kI5Lon9y9EMop8Zm7qoPDrJSeiS/nQi/8XRoWwEQLM653jgtPu4ikjQxVi7km3j09d4mA7g==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f010:455b:62ce:19e])
 (user=kaleshsingh job=sendgmr) by 2002:a0d:e243:0:b0:31c:9d96:8b1b with SMTP
 id l64-20020a0de243000000b0031c9d968b1bmr14189640ywe.222.1657865501975; Thu,
 14 Jul 2022 23:11:41 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:10:24 -0700
In-Reply-To: <20220715061027.1612149-1-kaleshsingh@google.com>
Message-Id: <20220715061027.1612149-16-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 15/18] KVM: arm64: Implement non-protected nVHE hyp stack unwinder
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

Implements the common framework necessary for unwind() to work
for non-protected nVHE mode:
    - on_accessible_stack()
    - on_overflow_stack()
    - unwind_next()

Non-protected nVHE unwind() is used to unwind and dump the hypervisor
stacktrace by the host in EL1

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/stacktrace/nvhe.h | 67 +++++++++++++++++++++++-
 arch/arm64/kvm/arm.c                     |  2 +-
 2 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
index c7c8ac889ec1..c3f94b10f8f0 100644
--- a/arch/arm64/include/asm/stacktrace/nvhe.h
+++ b/arch/arm64/include/asm/stacktrace/nvhe.h
@@ -115,15 +115,78 @@ NOKPROBE_SYMBOL(unwind_next);
  * Non-protected nVHE HYP stack unwinder
  */
 #else	/* !__KVM_NVHE_HYPERVISOR__ */
+DECLARE_KVM_NVHE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], overflow_stack);
+DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_stacktrace_info, kvm_stacktrace_info);
+DECLARE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+
+/**
+ * kvm_nvhe_stack_kern_va - Convert KVM nVHE HYP stack addresses to a kernel VAs
+ *
+ * The nVHE hypervisor stack is mapped in the flexible 'private' VA range, to
+ * allow for guard pages below the stack. Consequently, the fixed offset address
+ * translation macros won't work here.
+ *
+ * The kernel VA is calculated as an offset from the kernel VA of the hypervisor
+ * stack base.
+ *
+ * Returns true on success and updates @addr to its corresponding kernel VA;
+ * otherwise returns false.
+ */
+static inline bool kvm_nvhe_stack_kern_va(unsigned long *addr,
+					  enum stack_type type)
+{
+	struct kvm_nvhe_stacktrace_info *stacktrace_info;
+	unsigned long hyp_base, kern_base, hyp_offset;
+
+	stacktrace_info = this_cpu_ptr_nvhe_sym(kvm_stacktrace_info);
+
+	switch (type) {
+	case STACK_TYPE_HYP:
+		kern_base = (unsigned long)*this_cpu_ptr(&kvm_arm_hyp_stack_page);
+		hyp_base = (unsigned long)stacktrace_info->stack_base;
+		break;
+	case STACK_TYPE_OVERFLOW:
+		kern_base = (unsigned long)this_cpu_ptr_nvhe_sym(overflow_stack);
+		hyp_base = (unsigned long)stacktrace_info->overflow_stack_base;
+		break;
+	default:
+		return false;
+	}
+
+	hyp_offset = *addr - hyp_base;
+
+	*addr = kern_base + hyp_offset;
+
+	return true;
+}
+
 static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
 				     struct stack_info *info)
 {
-	return false;
+	struct kvm_nvhe_stacktrace_info *stacktrace_info
+				= this_cpu_ptr_nvhe_sym(kvm_stacktrace_info);
+	unsigned long low = (unsigned long)stacktrace_info->overflow_stack_base;
+	unsigned long high = low + OVERFLOW_STACK_SIZE;
+
+	return on_stack(sp, size, low, high, STACK_TYPE_OVERFLOW, info);
+}
+
+static inline bool on_hyp_stack(unsigned long sp, unsigned long size,
+				struct stack_info *info)
+{
+	struct kvm_nvhe_stacktrace_info *stacktrace_info
+				= this_cpu_ptr_nvhe_sym(kvm_stacktrace_info);
+	unsigned long low = (unsigned long)stacktrace_info->stack_base;
+	unsigned long high = low + PAGE_SIZE;
+
+	return on_stack(sp, size, low, high, STACK_TYPE_HYP, info);
 }
 
 static int notrace unwind_next(struct unwind_state *state)
 {
-	return 0;
+	struct stack_info info;
+
+	return unwind_next_common(state, &info, kvm_nvhe_stack_kern_va);
 }
 NOKPROBE_SYMBOL(unwind_next);
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index a0188144a122..6a64293108c5 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -49,7 +49,7 @@ DEFINE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
 
 DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
 
-static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
 DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
-- 
2.37.0.170.g444d1eabd0-goog

