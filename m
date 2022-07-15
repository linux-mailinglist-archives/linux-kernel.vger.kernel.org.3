Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DE4575B62
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiGOGMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiGOGLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:11:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5943B7B369
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31cbe6ad44fso33981457b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1fym5n3n0oRia5NvSUClhii6veVXNj9gblE/7wpke9c=;
        b=dc7YhQhB+Ip1RaWbAyXQxBj3/khXBkxGpkdHu1EkyjdG2Ntq0zGnQ7CI0vvsM5LoR7
         bOTy4YLobXsT1AI1ayobnaGn/U0oTuEsFJSaTZsf2SCqTuOq+dIW6cVLIxFgWB6yIgPP
         r1DS4gW5k/bjt5YkQKMECX5jYmBr8RBTdc4GxWb58awYhSWlNu2Q+r8O7bLGjuJh1CjS
         mjuFNlu6jjHmjla41cuWn3LyCeBjEnrvudkvWECk8mENYuC32iG1BnIHI1/gj9SbNJ6r
         vx96pOp6wqrGrASAADA9JpN5jp6DvbjDu9dI2PS2fMoqyh8HmLeAtNjThZMK1jc4pgPF
         LP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1fym5n3n0oRia5NvSUClhii6veVXNj9gblE/7wpke9c=;
        b=qN546sErosX7AG+sWJpQf2yn9KdkQTNgPoSZwcM5pGzbUb0hK6/6NnnXrljU30CCwI
         gpwkBZdnwibtbZ4dPr47buPEQQG7URXHfNfHqXNW6p6YgG1c3pIiTznca3ICYCRQM6qm
         j3OaclpbK+0QxoEpO6rABxzY8QsD2BKE2+rzIchUIYI8FpJegzufgFYzrKXgVYw1S7dk
         ThDtiqng/gow2ZUc6OEDDj85h7WGNwMC61Yd0fLdFGVkGZpV/PhX1cOi4YJwLFhPb+ME
         LahAfrHEGTMLmsg7Uku1AKqgt6mQXf4Vs3MtObjN1KswkoxTKxm8XvGMj9y/PY2nzPIQ
         wwJw==
X-Gm-Message-State: AJIora8hcSBiVp8Ablv3XJVKZ87hT5XI0eOVVDjbSxtw+WvDJW96eMTG
        JxtyuIveYVPG8XeCMNPy9BbC7qZeOIOdLuDvPw==
X-Google-Smtp-Source: AGRyM1u3qCw7t29vwofSuUW09s1Js0/b0NPwzvR/BwAcuU954cXttzvHa6Ek2lTeefUCsd1b3z2MavlgW2KJP5IGmg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f010:455b:62ce:19e])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:14f:0:b0:66a:bbd9:e502 with SMTP
 id c15-20020a5b014f000000b0066abbd9e502mr13149371ybp.278.1657865497089; Thu,
 14 Jul 2022 23:11:37 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:10:22 -0700
In-Reply-To: <20220715061027.1612149-1-kaleshsingh@google.com>
Message-Id: <20220715061027.1612149-14-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 13/18] KVM: arm64: Prepare non-protected nVHE hypervisor stacktrace
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

In non-protected nVHE mode (non-pKVM) the host can directly access
hypervisor memory; and unwinding of the hypervisor stacktrace is
done from EL1 to save on memory for shared buffers.

To unwind the hypervisor stack from EL1 the host needs to know the
starting point for the unwind and information that will allow it to
translate hypervisor stack addresses to the corresponding kernel
addresses. This patch sets up this book keeping. It is made use of
later in the series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/kvm_asm.h         | 16 ++++++++++++++++
 arch/arm64/include/asm/stacktrace/nvhe.h |  4 ++++
 arch/arm64/kvm/hyp/nvhe/stacktrace.c     | 24 ++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 2e277f2ed671..0ae9d12c2b5a 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -176,6 +176,22 @@ struct kvm_nvhe_init_params {
 	unsigned long vtcr;
 };
 
+/**
+ * Used by the host in EL1 to dump the nVHE hypervisor backtrace on
+ * hyp_panic() in non-protected mode.
+ *
+ * @stack_base:                 hyp VA of the hyp_stack base.
+ * @overflow_stack_base:        hyp VA of the hyp_overflow_stack base.
+ * @fp:                         hyp FP where the backtrace begins.
+ * @pc:                         hyp PC where the backtrace begins.
+ */
+struct kvm_nvhe_stacktrace_info {
+	unsigned long stack_base;
+	unsigned long overflow_stack_base;
+	unsigned long fp;
+	unsigned long pc;
+};
+
 /* Translate a kernel address @ptr into its equivalent linear mapping */
 #define kvm_ksym_ref(ptr)						\
 	({								\
diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
index 456a6ae08433..1aadfd8d7ac9 100644
--- a/arch/arm64/include/asm/stacktrace/nvhe.h
+++ b/arch/arm64/include/asm/stacktrace/nvhe.h
@@ -19,6 +19,7 @@
 #ifndef __ASM_STACKTRACE_NVHE_H
 #define __ASM_STACKTRACE_NVHE_H
 
+#include <asm/kvm_asm.h>
 #include <asm/stacktrace/common.h>
 
 /**
@@ -49,6 +50,9 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
  */
 #ifdef __KVM_NVHE_HYPERVISOR__
 
+DECLARE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack);
+DECLARE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
+
 extern void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc);
 
 #ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
index 832a536e440f..315eb41c37a2 100644
--- a/arch/arm64/kvm/hyp/nvhe/stacktrace.c
+++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
@@ -9,6 +9,28 @@
 DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
 	__aligned(16);
 
+DEFINE_PER_CPU(struct kvm_nvhe_stacktrace_info, kvm_stacktrace_info);
+
+/**
+ * hyp_prepare_backtrace - Prepare non-protected nVHE backtrace.
+ *
+ * @fp : frame pointer at which to start the unwinding.
+ * @pc : program counter at which to start the unwinding.
+ *
+ * Save the information needed by the host to unwind the non-protected
+ * nVHE hypervisor stack in EL1.
+ */
+static void hyp_prepare_backtrace(unsigned long fp, unsigned long pc)
+{
+	struct kvm_nvhe_stacktrace_info *stacktrace_info = this_cpu_ptr(&kvm_stacktrace_info);
+	struct kvm_nvhe_init_params *params = this_cpu_ptr(&kvm_init_params);
+
+	stacktrace_info->stack_base = (unsigned long)(params->stack_hyp_va - PAGE_SIZE);
+	stacktrace_info->overflow_stack_base = (unsigned long)this_cpu_ptr(overflow_stack);
+	stacktrace_info->fp = fp;
+	stacktrace_info->pc = pc;
+}
+
 #ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
 DEFINE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)], pkvm_stacktrace);
 
@@ -81,4 +103,6 @@ void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc)
 {
 	if (is_protected_kvm_enabled())
 		pkvm_save_backtrace(fp, pc);
+	else
+		hyp_prepare_backtrace(fp, pc);
 }
-- 
2.37.0.170.g444d1eabd0-goog

