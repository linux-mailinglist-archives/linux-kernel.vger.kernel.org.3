Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62AA575B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiGOGMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGOGLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:11:47 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDEB7AC2D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31d3f067919so33710307b3.23
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Re0lyq5fdLMfXjdX0x8O/EyKsShey1DPNrXl83M7ib4=;
        b=HJIzfLUePWb4mdMt5PQiB2FXqWysXIomBQwWmZmU4WV/QUZbp4L9o9VFKSwOJZifTZ
         Fa6IQbg+cMKv/7h9KJH2UcxrcTFfMTgmjaYMPU0KzatCgfcvq9kQCjl1mCU5KlP2UZvf
         saRXkT4Vpy7oTR0HAdiDDzqWQMS48FOJSp9QhUQNl4JGkHfW+2NCOJZCmji58ttWfn1x
         SowNG0vi9kC6tGLLFApmgH3fS6+ugyOaFaW5AYdpvJmFjuofxYo9juDxrUY5GGOH6GWX
         TK67Y6CrAXSsgi0VARxmXTim/P0MFuM9aFY5sRAknI9mcAvSqGV9gdOD4phpS9MBGRLP
         UbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Re0lyq5fdLMfXjdX0x8O/EyKsShey1DPNrXl83M7ib4=;
        b=cno7G0CNIXqVjaf6c+ZkNgitH4P7Z/kISJpPTKtI/8zRdvZUJXa1/iksDkmiqU2rX4
         U/O1kZBFxsRSzSvsRaSWFY9pv4bM71oDyeOZLwi3i9Hq7+33VWgsZ8p5TtyLkaaJa3Vs
         gYceeGH9zWRA1//Awc/lYi5RUlbYh8kSJlvAlaX2HGzwGMGBRt7qzYBXpddqhcg3hV/O
         Wv49hF/tTagY4pg81EgbRT6bMQQCWDSnIBntzx4hmo4Jcop2F7nb4+vr9Bp+U4FOuJ1L
         yA8zBkpRd1ITxxqr9HDw7qnGuiJHmdVd8R0clfZq7ZBiUhW+KspndY5Q+BRMIJWj7Q2E
         jarA==
X-Gm-Message-State: AJIora99QaYSL2L+5alhebQfKaHgS8VfNZ5rhvknW9raY9xNw1ZyvH7U
        2M6f/UkU/LUYaZ9jGXa3JrnZk19g00txPnYhfA==
X-Google-Smtp-Source: AGRyM1sW1Rib3u02KM7AZyrfjLA2iwFLsV4nlOryhWe/xB4UcHZVdSrw+Q6l4PSjRDA2LJVX/SPqSYka+ic+lQq4/w==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f010:455b:62ce:19e])
 (user=kaleshsingh job=sendgmr) by 2002:a0d:d747:0:b0:31c:8947:7851 with SMTP
 id z68-20020a0dd747000000b0031c89477851mr14136383ywd.142.1657865494699; Thu,
 14 Jul 2022 23:11:34 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:10:21 -0700
In-Reply-To: <20220715061027.1612149-1-kaleshsingh@google.com>
Message-Id: <20220715061027.1612149-13-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 12/18] KVM: arm64: Save protected-nVHE (pKVM) hyp stacktrace
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

In protected nVHE mode, the host cannot access private owned hypervisor
memory. Also the hypervisor aims to remains simple to reduce the attack
surface and does not provide any printk support.

For the above reasons, the approach taken to provide hypervisor stacktraces
in protected mode is:
   1) Unwind and save the hyp stack addresses in EL2 to a shared buffer
      with the host (done in this patch).
   2) Delegate the dumping and symbolization of the addresses to the
      host in EL1 (later patch in the series).

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/stacktrace/nvhe.h | 18 ++++++
 arch/arm64/kvm/hyp/nvhe/stacktrace.c     | 70 ++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
index 36cf7858ddd8..456a6ae08433 100644
--- a/arch/arm64/include/asm/stacktrace/nvhe.h
+++ b/arch/arm64/include/asm/stacktrace/nvhe.h
@@ -21,6 +21,22 @@
 
 #include <asm/stacktrace/common.h>
 
+/**
+ * kvm_nvhe_unwind_init - Start an unwind from the given nVHE HYP fp and pc
+ *
+ * @fp : frame pointer at which to start the unwinding.
+ * @pc : program counter at which to start the unwinding.
+ */
+static __always_inline void kvm_nvhe_unwind_init(struct unwind_state *state,
+						 unsigned long fp,
+						 unsigned long pc)
+{
+	unwind_init_common(state, NULL);
+
+	state->fp = fp;
+	state->pc = pc;
+}
+
 static inline bool on_accessible_stack(const struct task_struct *tsk,
 				       unsigned long sp, unsigned long size,
 				       struct stack_info *info)
@@ -33,6 +49,8 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
  */
 #ifdef __KVM_NVHE_HYPERVISOR__
 
+extern void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc);
+
 #ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
 static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
 				     struct stack_info *info)
diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
index 96c8b93320eb..832a536e440f 100644
--- a/arch/arm64/kvm/hyp/nvhe/stacktrace.c
+++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
@@ -11,4 +11,74 @@ DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
 
 #ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
 DEFINE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)], pkvm_stacktrace);
+
+/**
+ * pkvm_save_backtrace_entry - Saves a protected nVHE HYP stacktrace entry
+ *
+ * @arg    : the position of the entry in the stacktrace buffer
+ * @where  : the program counter corresponding to the stack frame
+ *
+ * Save the return address of a stack frame to the shared stacktrace buffer.
+ * The host can access this shared buffer from EL1 to dump the backtrace.
+ */
+static bool pkvm_save_backtrace_entry(void *arg, unsigned long where)
+{
+	unsigned long **stacktrace_pos = (unsigned long **)arg;
+	unsigned long stacktrace_start, stacktrace_end;
+
+	stacktrace_start = (unsigned long)this_cpu_ptr(pkvm_stacktrace);
+	stacktrace_end = stacktrace_start + NVHE_STACKTRACE_SIZE - (2 * sizeof(long));
+
+	if ((unsigned long) *stacktrace_pos > stacktrace_end)
+		return false;
+
+	/* Save the entry to the current pos in stacktrace buffer */
+	**stacktrace_pos = where;
+
+	/* A zero entry delimits the end of the stacktrace. */
+	*(*stacktrace_pos + 1) = 0UL;
+
+	/* Increment the current pos */
+	++*stacktrace_pos;
+
+	return true;
+}
+
+/**
+ * pkvm_save_backtrace - Saves the protected nVHE HYP stacktrace
+ *
+ * @fp : frame pointer at which to start the unwinding.
+ * @pc : program counter at which to start the unwinding.
+ *
+ * Save the unwinded stack addresses to the shared stacktrace buffer.
+ * The host can access this shared buffer from EL1 to dump the backtrace.
+ */
+static void pkvm_save_backtrace(unsigned long fp, unsigned long pc)
+{
+	void *stacktrace_start = (void *)this_cpu_ptr(pkvm_stacktrace);
+	struct unwind_state state;
+
+	kvm_nvhe_unwind_init(&state, fp, pc);
+
+	unwind(&state, pkvm_save_backtrace_entry, &stacktrace_start);
+}
+#else /* !CONFIG_PROTECTED_NVHE_STACKTRACE */
+static void pkvm_save_backtrace(unsigned long fp, unsigned long pc)
+{
+}
 #endif /* CONFIG_PROTECTED_NVHE_STACKTRACE */
+
+/**
+ * kvm_nvhe_prepare_backtrace - prepare to dump the nVHE backtrace
+ *
+ * @fp : frame pointer at which to start the unwinding.
+ * @pc : program counter at which to start the unwinding.
+ *
+ * Saves the information needed by the host to dump the nVHE hypervisor
+ * backtrace.
+ */
+void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc)
+{
+	if (is_protected_kvm_enabled())
+		pkvm_save_backtrace(fp, pc);
+}
-- 
2.37.0.170.g444d1eabd0-goog

