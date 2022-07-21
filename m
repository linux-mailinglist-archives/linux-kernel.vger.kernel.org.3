Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF90857C3FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiGUF6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiGUF6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:58:12 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C08079EEA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:58:11 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31cb93cadf2so6665937b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gR1/Z2EPI44f0egwGbpih9U0FfR3lyB8C+b1oQ7a3ho=;
        b=afa5tl3ErYehtuGRVn6Z2F3olzHm5mqok9Hqwl9tU/bS/EZvKNoimqQLe5oCqF/DMc
         TdBQTNmlNrru0i9aIep5zRlPuoHEjwccgz4Qgy87jnj5xkgYHR+W30Pr8KipWYI6LJe/
         JwvfS1kvj4dSVhZKIaHgofIjVXextnUms7EF/I0hZJtqp6bRCSsgSNsZvrl+NykLzrW1
         NCvGslXIrCznfDzAKgWB2mVXua6LAoU7aPHY2Kx2Our4OmdaDygrvEfqL0tqMqLYbbmK
         y5QbtzMDtm2Xy58L9Yy8pWaiIH22zGx35r4CZp5SCFxcx+InneYPmkR0G8Fd6lS+Z+wW
         lU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gR1/Z2EPI44f0egwGbpih9U0FfR3lyB8C+b1oQ7a3ho=;
        b=gZBlPgQv9hlcwNr2qTGhVy+UdyfkG1Ld0vvDXiAZSD8WXtfCuSUaTUg2OzLsYOp0IA
         mPiEOQxj5EOzaXT2Mel2Te81/sYm0fI/e5m2Z2ZB87jlOS0qUQbJnvUJsDc6YuICj1t5
         QWug/HRKtUPrrCQ5tjvyiwEF0vx4uxRH5WXDM/HnbbMHnBdYYTzZ/Rr5+RNGx8z8/6dR
         uz6rCc/r6VFJpCe/pz+HjxvKuGnDe7S+UCxfKo3Fp2zhxfgH3Bu6ARlYqKjFEqyuHlDO
         5MLl8Y+TsBj0/hiC7T5KkAPP09N2HRuJGVLfhm/m7+dgbJvcxKElJQWW6sKrGj9AwZLx
         LwdA==
X-Gm-Message-State: AJIora/5FDia3Jt+Sjki0Gc27JKs/iRF84K5bIq3EOk+VAmbPwZEm6UJ
        L5ypMwI4OOz7Q4ruGqoz7DpgidYkluDYfmYm1Q==
X-Google-Smtp-Source: AGRyM1sVq2WV+efPOaHv/EvfJltNWnGlGgRuoca8wHJKHuJymzfLurD1omQOCDXP5YKLf76jV42DjWRXPQaey+SEtQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5a87:b61e:76b5:d1e0])
 (user=kaleshsingh job=sendgmr) by 2002:a81:98d2:0:b0:31e:5d41:7a3e with SMTP
 id p201-20020a8198d2000000b0031e5d417a3emr11327128ywg.520.1658383090977; Wed,
 20 Jul 2022 22:58:10 -0700 (PDT)
Date:   Wed, 20 Jul 2022 22:57:26 -0700
In-Reply-To: <20220721055728.718573-1-kaleshsingh@google.com>
Message-Id: <20220721055728.718573-16-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v5 15/17] KVM: arm64: Implement non-protected nVHE hyp stack unwinder
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

Implements the common framework necessary for unwind() to work
for non-protected nVHE mode:
    - on_accessible_stack()
    - on_overflow_stack()
    - unwind_next()

Non-protected nVHE unwind() is used to unwind and dump the hypervisor
stacktrace by the host in EL1

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v5:
  - Use regular comments instead of doc comments, per Fuad

 arch/arm64/include/asm/stacktrace/nvhe.h | 67 +++++++++++++++++++++++-
 arch/arm64/kvm/arm.c                     |  2 +-
 2 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
index c3688e717136..7a6e761aa443 100644
--- a/arch/arm64/include/asm/stacktrace/nvhe.h
+++ b/arch/arm64/include/asm/stacktrace/nvhe.h
@@ -120,15 +120,78 @@ NOKPROBE_SYMBOL(unwind_next);
  * (by the host in EL1).
  */
 
+DECLARE_KVM_NVHE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], overflow_stack);
+DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_stacktrace_info, kvm_stacktrace_info);
+DECLARE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+
+/*
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
 
 static inline int notrace unwind_next(struct unwind_state *state)
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

