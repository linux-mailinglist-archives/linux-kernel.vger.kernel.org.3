Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7475157E3CE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiGVPdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGVPdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:33:49 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44A862A4B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:33:47 -0700 (PDT)
Date:   Fri, 22 Jul 2022 15:33:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658504025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EHcXZ82EpsdLm7shozmycgnQXph3h61HLeaQXOxGK0A=;
        b=dN2nMS2MSke1JsnwdAqJhx64uCLm2GafTrgEywkEP32v5hJNrJnFBPr1srSb3hE6CEdEtD
        V5iuD/i20uj6VyBa4BPd97UdnMTWKCZMmB8Mn3mYdITs0C8XpzGKtE9w99eizMHaIu7d7g
        z0OsIHvDTbFK7neIPUQnKWmhLSbFZJ8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, tabba@google.com, will@kernel.org,
        qperret@google.com, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, drjones@redhat.com,
        wangkefeng.wang@huawei.com, elver@google.com, keirf@google.com,
        yuzenghui@huawei.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Subject: Re: [PATCH v5 12/17] KVM: arm64: Save protected-nVHE (pKVM) hyp
 stacktrace
Message-ID: <YtrDU9TRjNWCTPVg@google.com>
References: <20220721055728.718573-1-kaleshsingh@google.com>
 <20220721055728.718573-13-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721055728.718573-13-kaleshsingh@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalesh,

On Wed, Jul 20, 2022 at 10:57:23PM -0700, Kalesh Singh wrote:
> In protected nVHE mode, the host cannot access private owned hypervisor
> memory. Also the hypervisor aims to remains simple to reduce the attack
> surface and does not provide any printk support.
> 
> For the above reasons, the approach taken to provide hypervisor stacktraces
> in protected mode is:
>    1) Unwind and save the hyp stack addresses in EL2 to a shared buffer
>       with the host (done in this patch).
>    2) Delegate the dumping and symbolization of the addresses to the
>       host in EL1 (later patch in the series).
> 
> On hyp_panic(), the hypervisor prepares the stacktrace before returning to
> the host.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---

Tried reworking this a bit and here is what I arrived at, WDYT?
Untested, of course :)

--
Thanks,
Oliver

diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
index 3078501f8e22..05d7e03e0a8c 100644
--- a/arch/arm64/include/asm/stacktrace/nvhe.h
+++ b/arch/arm64/include/asm/stacktrace/nvhe.h
@@ -21,6 +21,23 @@
 
 #include <asm/stacktrace/common.h>
 
+/*
+ * kvm_nvhe_unwind_init - Start an unwind from the given nVHE HYP fp and pc
+ *
+ * @state : unwind_state to initialize
+ * @fp    : frame pointer at which to start the unwinding.
+ * @pc    : program counter at which to start the unwinding.
+ */
+static inline void kvm_nvhe_unwind_init(struct unwind_state *state,
+					unsigned long fp,
+					unsigned long pc)
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
diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
index 96c8b93320eb..644276fb02af 100644
--- a/arch/arm64/kvm/hyp/nvhe/stacktrace.c
+++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
@@ -11,4 +11,69 @@ DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
 
 #ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
 DEFINE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)], pkvm_stacktrace);
+
+/*
+ * pkvm_save_backtrace_entry - Saves a protected nVHE HYP stacktrace entry
+ *
+ * @arg    : the index of the entry in the stacktrace buffer
+ * @where  : the program counter corresponding to the stack frame
+ *
+ * Save the return address of a stack frame to the shared stacktrace buffer.
+ * The host can access this shared buffer from EL1 to dump the backtrace.
+ */
+static bool pkvm_save_backtrace_entry(void *arg, unsigned long where)
+{
+	unsigned long *stacktrace = this_cpu_ptr(pkvm_stacktrace);
+	int *idx = (int *)arg;
+
+	/*
+	 * Need 2 free slots: 1 for current entry and 1 for the
+	 * delimiter.
+	 */
+	if (*idx > ARRAY_SIZE(pkvm_stacktrace) - 2)
+		return false;
+
+	stacktrace[*idx] = where;
+	stacktrace[++*idx] = 0UL;
+
+	return true;
+}
+
+/*
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
+	struct unwind_state state;
+	int idx = 0;
+
+	kvm_nvhe_unwind_init(&state, fp, pc);
+
+	unwind(&state, pkvm_save_backtrace_entry, &idx);
+}
+#else /* !CONFIG_PROTECTED_NVHE_STACKTRACE */
+static void pkvm_save_backtrace(unsigned long fp, unsigned long pc)
+{
+}
 #endif /* CONFIG_PROTECTED_NVHE_STACKTRACE */
+
+/*
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
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 6db801db8f27..64e13445d0d9 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -34,6 +34,8 @@ DEFINE_PER_CPU(struct kvm_host_data, kvm_host_data);
 DEFINE_PER_CPU(struct kvm_cpu_context, kvm_hyp_ctxt);
 DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
 
+extern void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc);
+
 static void __activate_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val;
@@ -375,6 +377,10 @@ asmlinkage void __noreturn hyp_panic(void)
 		__sysreg_restore_state_nvhe(host_ctxt);
 	}
 
+	/* Prepare to dump kvm nvhe hyp stacktrace */
+	kvm_nvhe_prepare_backtrace((unsigned long)__builtin_frame_address(0),
+				   _THIS_IP_);
+
 	__hyp_do_panic(host_ctxt, spsr, elr, par);
 	unreachable();
 }
