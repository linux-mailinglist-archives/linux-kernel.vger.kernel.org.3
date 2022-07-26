Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D06580E05
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbiGZHkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbiGZHin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:38:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4458CE61
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f46b4759bso9791497b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kL7jS2TEgfQABS/KABalQqubKEd+bS4PTw3OsgUmZrg=;
        b=J9LlcMs4kVl5Jw7qgJTzTVfwP5zRI1SRtnFCZ3KUg847ET+lDBzps4QPRrt7QF7/Ks
         xKq7LVs7tkEhFsKhBHqbpvefr6T7tgS96BykDlhtcK2A654oU74O77GoXM85LKr2zv7L
         BvGEAiGlvkxvl7cCjh/9fvLea6FoUmnPKuR/JoLvKMPSe+Tjr4avfVymE3VSL2Rgpy+E
         KDH/TPvXhSmO5fPs8LEiUE2W6ShIs6W5zYRVei7zZB5A7wh6165l6SX9QLewO0iT+iww
         9QLYk9i77CFCRiaAW71AInn6lyy+wNhBpEcxgvjKVY+YfZuk19SXuheN4itHR3CuRIzk
         rO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kL7jS2TEgfQABS/KABalQqubKEd+bS4PTw3OsgUmZrg=;
        b=BIbp5bj+bpumwrLIQitsYQGc21UhCDT6DSdD9t29zKNKN4k0UhZz2Ahqub1ucPGRdT
         s7l581r6i6DOEgb3sP73nE61nrIr1wF1wiQp642DGKpq6X0vX0i+Mk/0sAmJg6JRS8zR
         Kns9jNQbaNPBi7Paha8M5PDnF2vVEO94HI0WyEgwAGHlLrEWCCqNx01ACKMKfto/tLMd
         JWW5tIYd618I/Uewm0Z3mQ9jwpGrYyAztg0pbwYbejNt2Scdp62IqflSe16fV16RwjeT
         VmGw+ATqIFcURfpFq5gNv2fCHX2yNENRUNt6EVBIvQgo+7Pki4LucFnQ6t4Cce6/D6vI
         NiOg==
X-Gm-Message-State: AJIora+grl2T7wArDVx/u/8QTuUu8Yko8pqdOm3phs87EKm5dYuEpNHs
        wh1C4WOiQSvgawt6hB6WNm9ZPBNgREMbG85V9g==
X-Google-Smtp-Source: AGRyM1saaVsEuZn7ZnRBCM6GpPqB26BLjzUSPJbF2c+S3D5RHjCzUgbqIv/13TpNkFfjwqhEHzjPbXseN9GPJLOPcQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:4f77:3b64:736a:394e])
 (user=kaleshsingh job=sendgmr) by 2002:a25:264b:0:b0:66e:cc95:50e with SMTP
 id m72-20020a25264b000000b0066ecc95050emr12499491ybm.173.1658821102498; Tue,
 26 Jul 2022 00:38:22 -0700 (PDT)
Date:   Tue, 26 Jul 2022 00:37:44 -0700
In-Reply-To: <20220726073750.3219117-1-kaleshsingh@google.com>
Message-Id: <20220726073750.3219117-12-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220726073750.3219117-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v6 11/17] KVM: arm64: Introduce hyp_dump_backtrace()
From:   Kalesh Singh <kaleshsingh@google.com>
To:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, tabba@google.com,
        oliver.upton@linux.dev
Cc:     will@kernel.org, qperret@google.com, kaleshsingh@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, wangkefeng.wang@huawei.com,
        elver@google.com, keirf@google.com, yuzenghui@huawei.com,
        ardb@kernel.org, oupton@google.com,
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

In non-protected nVHE mode, unwinds and dumps the hypervisor backtrace
from EL1. This is possible beacause the host can directly access the
hypervisor stack pages in non-protected mode.

The nVHE backtrace is dumped on hyp_panic(), before panicking the host.

[  101.498183] kvm [377]: nVHE call trace:
[  101.498363] kvm [377]:  [<ffff8000090a6570>] __kvm_nvhe_hyp_panic+0xac/0xf8
[  101.499045] kvm [377]:  [<ffff8000090a65cc>] __kvm_nvhe_hyp_panic_bad_stack+0x10/0x10
[  101.499498] kvm [377]:  [<ffff8000090a61e4>] __kvm_nvhe_recursive_death+0x24/0x34
. . .
[  101.524929] kvm [377]:  [<ffff8000090a61e4>] __kvm_nvhe_recursive_death+0x24/0x34
[  101.525062] kvm [377]:  [<ffff8000090a61e4>] __kvm_nvhe_recursive_death+0x24/0x34
[  101.525195] kvm [377]:  [<ffff8000090a5de4>] __kvm_nvhe___kvm_vcpu_run+0x30/0x40c
[  101.525333] kvm [377]:  [<ffff8000090a8b64>] __kvm_nvhe_handle___kvm_vcpu_run+0x30/0x48
[  101.525468] kvm [377]:  [<ffff8000090a88b8>] __kvm_nvhe_handle_trap+0xc4/0x128
[  101.525602] kvm [377]:  [<ffff8000090a7864>] __kvm_nvhe___host_exit+0x64/0x64
[  101.525745] kvm [377]: ---[ end nVHE call trace ]---

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v6:
  - Fix some typos in commit text and comments, per Fuad
  - Remove kvm_nvhe_print_backtrace_entry(), per Oliver
  - To make nVHE call trace delimiters consistent between protected and
    non-protected mode, factor it out into helpers, per Oliver
  - Change end delimiter to more match that of arm64 stacktrace
    (---[ end nVHE call trace ]---), per Oliver

Changes in v5:
  - Move code out from nvhe.h header to handle_exit.c, per Marc
  - Fix stacktrace symbolization when CONFIG_RAMDOMIZE_BASE is enabled,
    per Fuad
  - Use regular comments instead of doc comments, per Fuad

 arch/arm64/include/asm/stacktrace/nvhe.h | 17 ++++++
 arch/arm64/kvm/handle_exit.c             | 69 ++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
index 21082fd4a0b7..170fe7459f7c 100644
--- a/arch/arm64/include/asm/stacktrace/nvhe.h
+++ b/arch/arm64/include/asm/stacktrace/nvhe.h
@@ -16,6 +16,23 @@
 
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
 static inline bool on_hyp_stack(unsigned long sp, unsigned long size,
 				struct stack_info *info);
 
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index f66c0142b335..e83e6f735100 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -17,6 +17,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
 #include <asm/debug-monitors.h>
+#include <asm/stacktrace/nvhe.h>
 #include <asm/traps.h>
 
 #include <kvm/arm_hypercalls.h>
@@ -318,6 +319,71 @@ void handle_exit_early(struct kvm_vcpu *vcpu, int exception_index)
 		kvm_handle_guest_serror(vcpu, kvm_vcpu_get_esr(vcpu));
 }
 
+/*
+ * kvm_nvhe_dump_backtrace_entry - Symbolize and print an nVHE backtrace entry
+ *
+ * @arg    : the hypervisor offset, used for address translation
+ * @where  : the program counter corresponding to the stack frame
+ */
+static bool kvm_nvhe_dump_backtrace_entry(void *arg, unsigned long where)
+{
+	unsigned long va_mask = GENMASK_ULL(vabits_actual - 1, 0);
+	unsigned long hyp_offset = (unsigned long)arg;
+
+	/* Mask tags and convert to kern addr */
+	where = (where & va_mask) + hyp_offset;
+	kvm_err(" [<%016lx>] %pB\n", where, (void *)(where + kaslr_offset()));
+
+	return true;
+}
+
+static inline void kvm_nvhe_dump_backtrace_start(void)
+{
+	kvm_err("nVHE call trace:\n");
+}
+
+static inline void kvm_nvhe_dump_backtrace_end(void)
+{
+	kvm_err("---[ end nVHE call trace ]---\n");
+}
+
+/*
+ * hyp_dump_backtrace - Dump the non-protected nVHE backtrace.
+ *
+ * @hyp_offset: hypervisor offset, used for address translation.
+ *
+ * The host can directly access HYP stack pages in non-protected
+ * mode, so the unwinding is done directly from EL1. This removes
+ * the need for shared buffers between host and hypervisor for
+ * the stacktrace.
+ */
+static void hyp_dump_backtrace(unsigned long hyp_offset)
+{
+	struct kvm_nvhe_stacktrace_info *stacktrace_info;
+	struct unwind_state state;
+
+	stacktrace_info = this_cpu_ptr_nvhe_sym(kvm_stacktrace_info);
+
+	kvm_nvhe_unwind_init(&state, stacktrace_info->fp, stacktrace_info->pc);
+
+	kvm_nvhe_dump_backtrace_start();
+	unwind(&state, kvm_nvhe_dump_backtrace_entry, (void *)hyp_offset);
+	kvm_nvhe_dump_backtrace_end();
+}
+
+/*
+ * kvm_nvhe_dump_backtrace - Dump KVM nVHE hypervisor backtrace.
+ *
+ * @hyp_offset: hypervisor offset, used for address translation.
+ */
+static void kvm_nvhe_dump_backtrace(unsigned long hyp_offset)
+{
+	if (is_protected_kvm_enabled())
+		return;
+	else
+		hyp_dump_backtrace(hyp_offset);
+}
+
 void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
 					      u64 elr_virt, u64 elr_phys,
 					      u64 par, uintptr_t vcpu,
@@ -353,6 +419,9 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
 				(void *)panic_addr);
 	}
 
+	/* Dump the nVHE hypervisor backtrace */
+	kvm_nvhe_dump_backtrace(hyp_offset);
+
 	/*
 	 * Hyp has panicked and we're going to handle that by panicking the
 	 * kernel. The kernel offset will be revealed in the panic so we're
-- 
2.37.1.359.gd136c6c3e2-goog

