Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F3957C401
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiGUF6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiGUF6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:58:17 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB6D79EE0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:58:16 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31e89d6bea7so1694927b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eY5/lFgLy/e/q0JCyLsG7Dq+dlCTuLB6RCoRX5a1q0g=;
        b=WMRHbze1UjE98lLidYWgTOC6PORIneSd6GV0ozEhz9vPbd9YOdu7j9Ryu+HJ4trz/J
         QRckppVKgo+ATqknDecnbXMNFaAhNymsEFAFGzocktzNwndsSyA8oxc0WeCOA36n4faE
         U1eO1R/yW1qyJZeqwVMLBEK8wlOeB/MOLmcGmUwoFu/ejt8IPrrrznyRtzlK1kFucm0m
         2LbPQ5kNE19uG8EbRX2/P8uEWit1VVLXUxE+Qisf8tule0DtgZai7yq9seEfR65ZG1IB
         J/h8ACRHJmOzCd8nRGtwjzD2eprVrkcjZHDiDDazJAwK0BnFXAApBjz4lW8Mq335iydt
         YGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eY5/lFgLy/e/q0JCyLsG7Dq+dlCTuLB6RCoRX5a1q0g=;
        b=1jtE+DVR/D+0FjQb3SMc9f7JnjXX84Ceu6LfK3y5Ps7y2iSOX11cnnzi97sVMUOiLP
         2sfcYymu+Fyn1ZNv2r+ht4NxiEhsEzExAMIyA41Q2Q9NIB1ggMADHtcEYAkdJDqvAC3z
         P2ZLVbS8HBXk87h9mT4EfVIfvf8Dl/mOPMoFrTK/dYxe9Z2d5o8bb4weXtZORrmupgNa
         qVt9nT8NwWMaXuDg889BRCwITsZbecpoFEk65yZzw9ruO+NKlwg7UeqjFI2sgyrEsfI6
         tel0WqudlguaBTTtptiSqMySilpfht9zxr8nC+aIcbcewoqPUmUYz+vDHemH49G/2fil
         LHDw==
X-Gm-Message-State: AJIora+XQi3hS6tb7c4YJIH4NGQxyddNg/9O73rkMxwrL9ko95eQrZfR
        uk601kg59ahmM72tA3BnAvXeuDi5Qdo/YmevHw==
X-Google-Smtp-Source: AGRyM1sBVPLMJaPOkAoWmG3Bd9FIx/vNpGbpXpxi987HJ+/EiD9zA+WxndpdbIc+7PEG26Pc7JjNZnzchEWAgAKDFw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5a87:b61e:76b5:d1e0])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:3c4:b0:670:6a54:dbc2 with
 SMTP id g4-20020a05690203c400b006706a54dbc2mr13483925ybs.576.1658383095838;
 Wed, 20 Jul 2022 22:58:15 -0700 (PDT)
Date:   Wed, 20 Jul 2022 22:57:28 -0700
In-Reply-To: <20220721055728.718573-1-kaleshsingh@google.com>
Message-Id: <20220721055728.718573-18-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v5 17/17] KVM: arm64: Introduce hyp_dump_backtrace()
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

In non-protected nVHE mode, unwinds and dumps the hypervisor backtrace
from EL1. This is possible beacuase the host can directly access the
hypervisor stack pages in non-proteced mode.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v5:
  - Move code out from nvhe.h header to handle_exit.c, per Marc
  - Fix stacktrace symoblization when CONFIG_RAMDOMIZE_BASE is enabled,
    per Fuad
  - Use regular comments instead of doc comments, per Fuad

 arch/arm64/kvm/handle_exit.c | 65 +++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index ad568da5c7d7..432b6b26f4ad 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -17,6 +17,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
 #include <asm/debug-monitors.h>
+#include <asm/stacktrace/nvhe.h>
 #include <asm/traps.h>
 
 #include <kvm/arm_hypercalls.h>
@@ -318,6 +319,56 @@ void handle_exit_early(struct kvm_vcpu *vcpu, int exception_index)
 		kvm_handle_guest_serror(vcpu, kvm_vcpu_get_esr(vcpu));
 }
 
+/*
+ * kvm_nvhe_print_backtrace_entry - Symbolizes and prints the HYP stack address
+ */
+static void kvm_nvhe_print_backtrace_entry(unsigned long addr,
+						  unsigned long hyp_offset)
+{
+	unsigned long va_mask = GENMASK_ULL(vabits_actual - 1, 0);
+
+	/* Mask tags and convert to kern addr */
+	addr = (addr & va_mask) + hyp_offset;
+	kvm_err(" [<%016lx>] %pB\n", addr, (void *)(addr + kaslr_offset()));
+}
+
+/*
+ * hyp_dump_backtrace_entry - Dump an entry of the non-protected nVHE HYP stacktrace
+ *
+ * @arg    : the hypervisor offset, used for address translation
+ * @where  : the program counter corresponding to the stack frame
+ */
+static bool hyp_dump_backtrace_entry(void *arg, unsigned long where)
+{
+	kvm_nvhe_print_backtrace_entry(where, (unsigned long)arg);
+
+	return true;
+}
+
+/*
+ * hyp_dump_backtrace - Dump the non-proteced nVHE HYP backtrace.
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
+	kvm_err("Non-protected nVHE HYP call trace:\n");
+	unwind(&state, hyp_dump_backtrace_entry, (void *)hyp_offset);
+	kvm_err("---- End of Non-protected nVHE HYP call trace ----\n");
+}
+
 #ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
 DECLARE_KVM_NVHE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)],
 			 pkvm_stacktrace);
@@ -336,18 +387,12 @@ static void pkvm_dump_backtrace(unsigned long hyp_offset)
 {
 	unsigned long *stacktrace_entry
 		= (unsigned long *)this_cpu_ptr_nvhe_sym(pkvm_stacktrace);
-	unsigned long va_mask, pc;
-
-	va_mask = GENMASK_ULL(vabits_actual - 1, 0);
 
 	kvm_err("Protected nVHE HYP call trace:\n");
 
-	/* The stack trace is terminated by a null entry */
-	for (; *stacktrace_entry; stacktrace_entry++) {
-		/* Mask tags and convert to kern addr */
-		pc = (*stacktrace_entry & va_mask) + hyp_offset;
-		kvm_err(" [<%016lx>] %pB\n", pc, (void *)(pc + kaslr_offset()));
-	}
+	/* The saved stacktrace is terminated by a null entry */
+	for (; *stacktrace_entry; stacktrace_entry++)
+		kvm_nvhe_print_backtrace_entry(*stacktrace_entry, hyp_offset);
 
 	kvm_err("---- End of Protected nVHE HYP call trace ----\n");
 }
@@ -367,6 +412,8 @@ static void kvm_nvhe_dump_backtrace(unsigned long hyp_offset)
 {
 	if (is_protected_kvm_enabled())
 		pkvm_dump_backtrace(hyp_offset);
+	else
+		hyp_dump_backtrace(hyp_offset);
 }
 
 void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
-- 
2.37.0.170.g444d1eabd0-goog

