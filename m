Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF6A57C3FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiGUF62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiGUF6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:58:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E7679ECE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:58:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k64-20020a253d43000000b0067080eb57fdso588144yba.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z7mVY9an7BKlr+DFm/CycdkNTS81eX0sj7VPn5GOYs4=;
        b=dTsslHtfVleq+Z/6WWji/9BuS9+0br4q7QTZcxrUN5Y9B4rlzmrmN32Bb1B5qyJ/U1
         qBpAZGUG2A62Hm2QuQFjTCti5rbkdpDyTAybiwdN4xKtXHzcxrROPg9V11lvHuN/twya
         a2UyEZ/owQaKO0PtjZowc5DbISURjVIpDe8dEi2N7GQOpy9pYT8mVWsgs4N9nBbqUvg2
         QH9mu9bYGpxdDj8JIvDwQld9c2w0EwXo08sJjQ+RmLN2wX01jPqMQrv+STC/QoW3bpXx
         mjKRNDCEFZxF3BqOf/VxGO2RpXhB+AoiIXZzPCTbceBAr/YG5qiWLsDGLe0S/hvlsMvl
         oT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z7mVY9an7BKlr+DFm/CycdkNTS81eX0sj7VPn5GOYs4=;
        b=chtKqJQ5wfc1c9YFYQHo43xGjBwGE+TsGNSK3UcdX5gxnB6gK0xTNiSV2KyfCxWFu6
         iByvbBP7mSdSDUBTNiTTLYKWv676e4ily1aLMKa2kUE0lWAFv4Dbsy7xO/WBoGQWG3K+
         bblFEHaPSTIw46YjazA18qyY8cMZX2oeCSKZm+J1/FiCNr6b0ZbrcWfM2S6Wr9co9MH6
         Yn5BCffS9FmJGt4NxfYZ4YpY/KlsUL54EU1weXqJByGrO9mIV/5bl7bR3y1whgAoQUuL
         TrN22GOSW7xB2vDkilS7tCa52MomD1kEYWI1cjFkgvk2+9v7lT7qGVz9wP/AD3EJEm0i
         IPxg==
X-Gm-Message-State: AJIora+BASRfsa4zoTLDGWNuYxDkxQDRj9u8XxD+1RmQNvc4250/LVSf
        DrFdvwT05FWGl7g0fyHA07lPckLCPPDPrJQ+0g==
X-Google-Smtp-Source: AGRyM1t4hxWZlu80p3JVhXO15OVhTOsZC/c7QTwiHwbKpKmDeCswr0PSSvYfUF/aTjYWxM+ufbCB0TJqzm/vgw1mYQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5a87:b61e:76b5:d1e0])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:20a:b0:670:c563:9180 with
 SMTP id j10-20020a056902020a00b00670c5639180mr317132ybs.401.1658383085938;
 Wed, 20 Jul 2022 22:58:05 -0700 (PDT)
Date:   Wed, 20 Jul 2022 22:57:24 -0700
In-Reply-To: <20220721055728.718573-1-kaleshsingh@google.com>
Message-Id: <20220721055728.718573-14-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v5 13/17] KVM: arm64: Prepare non-protected nVHE hypervisor stacktrace
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

Changes in v5:
  - Use regular comments instead of doc comments, per Fuad

 arch/arm64/include/asm/kvm_asm.h         | 16 ++++++++++++++++
 arch/arm64/include/asm/stacktrace/nvhe.h |  4 ++++
 arch/arm64/kvm/hyp/nvhe/stacktrace.c     | 24 ++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 2e277f2ed671..53035763e48e 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -176,6 +176,22 @@ struct kvm_nvhe_init_params {
 	unsigned long vtcr;
 };
 
+/*
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
index 05d7e03e0a8c..8f02803a005f 100644
--- a/arch/arm64/include/asm/stacktrace/nvhe.h
+++ b/arch/arm64/include/asm/stacktrace/nvhe.h
@@ -19,6 +19,7 @@
 #ifndef __ASM_STACKTRACE_NVHE_H
 #define __ASM_STACKTRACE_NVHE_H
 
+#include <asm/kvm_asm.h>
 #include <asm/stacktrace/common.h>
 
 /*
@@ -52,6 +53,9 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
  * In protected mode, the unwinding is done by the hypervisor in EL2.
  */
 
+DECLARE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack);
+DECLARE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
+
 #ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
 static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
 				     struct stack_info *info)
diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
index 60461c033a04..cbd365f4f26a 100644
--- a/arch/arm64/kvm/hyp/nvhe/stacktrace.c
+++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
@@ -9,6 +9,28 @@
 DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
 	__aligned(16);
 
+DEFINE_PER_CPU(struct kvm_nvhe_stacktrace_info, kvm_stacktrace_info);
+
+/*
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
 
@@ -89,4 +111,6 @@ void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc)
 {
 	if (is_protected_kvm_enabled())
 		pkvm_save_backtrace(fp, pc);
+	else
+		hyp_prepare_backtrace(fp, pc);
 }
-- 
2.37.0.170.g444d1eabd0-goog

