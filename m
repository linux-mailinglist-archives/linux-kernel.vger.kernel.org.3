Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E34457C3FE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiGUF6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiGUF6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:58:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42DF79EED
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:58:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v1-20020a259d81000000b0066ec7dff8feso570981ybp.18
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=POF5DiWqY8exBmivz0rKj4swn88HJpD6BS/y4rmGEUs=;
        b=iNF3/wKiZxQkHHbeWmrDPvF2lTugngVT8l6YAy7ij5cPY90sHRbAuAte+7t0gXkHM8
         Nn10K9x+jyiPRlfMiH8Kme8pJx4iK86w/tvNiOBAB1RJwhX9HgF7aG5TgxWlxjs/+aC8
         JmrWVdRF1+4cai70BJHNbLhfq+tLYGoZ6LLzkBFW+Nr9qdq5HvnnSMO3BS2WFS59TMNg
         LZGWa/1Ri7/0xL/cgFTo4eKFiFrQxY3DxKk8iLGThqSBtt9m+qrvIc1e+4lqd4jVScfj
         zAqxL3KDqT2/e+X/RiSP6BCUWHdY0bJGvcENptvBCIFJV6C4TR6EHm0MT+/+Kbjg1Kil
         auXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=POF5DiWqY8exBmivz0rKj4swn88HJpD6BS/y4rmGEUs=;
        b=jCr47pzVJIm1nulvy20mucoUG/E64rzUoX8fogTdHtopchSEHAoEB8X9r5JBGEUuY2
         qyVEYTVZOXTZHwxdvVTGO5UDhE+71YwDVPuc4M8eSjNxF+jIDkZvLyx5AdTn9ov+vb46
         RwNGTorfOqC2M858pOv0rkFaYGBIZ6bsjRX271hIG+fHPwNnpAhCBvoCED52xLCxfiBk
         LSRasfUulHh0AjzUo/5K2xdEjkYwunVkAlbtDwGqHuYgZZ5m3FFtYmm0vLUi4r3RmyVo
         bwx9wf8tOoUb270fo5YGvDoMkG7fJ8lL0/bTUsISH5LoMJte3ZH2zwBOMI+DDXquqJcD
         XB+A==
X-Gm-Message-State: AJIora/Z8WijRGLsw5dbsFC7ZwEHGjwj3n4BfkldMEyGlDMhatrVMb4Q
        Iyg/dfqA9AKuC76guBAyvdpdfNuaSunuC9vXOQ==
X-Google-Smtp-Source: AGRyM1s1aoVE6pG6u4uUcd7EnheOT1wFEk50XabWGsXZv3DmsYR0UuXWQPe2QHeoCAY/ooJghIm8SbcDhywackPmqQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5a87:b61e:76b5:d1e0])
 (user=kaleshsingh job=sendgmr) by 2002:a25:d614:0:b0:670:9ea2:e6c1 with SMTP
 id n20-20020a25d614000000b006709ea2e6c1mr4776973ybg.379.1658383093469; Wed,
 20 Jul 2022 22:58:13 -0700 (PDT)
Date:   Wed, 20 Jul 2022 22:57:27 -0700
In-Reply-To: <20220721055728.718573-1-kaleshsingh@google.com>
Message-Id: <20220721055728.718573-17-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v5 16/17] KVM: arm64: Introduce pkvm_dump_backtrace()
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

Dumps the pKVM hypervisor backtrace from EL1 by reading the unwinded
addresses from the shared stacktrace buffer.

The nVHE hyp backtrace is dumped on hyp_panic(), before panicking the
host.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v5:
  - Move code out from nvhe.h header to handle_exit.c, per Marc
  - Fix stacktrace symoblization when CONFIG_RAMDOMIZE_BASE is enabled,
    per Fuad
  - Use regular comments instead of doc comments, per Fuad

 arch/arm64/kvm/handle_exit.c | 54 ++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index f66c0142b335..ad568da5c7d7 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -318,6 +318,57 @@ void handle_exit_early(struct kvm_vcpu *vcpu, int exception_index)
 		kvm_handle_guest_serror(vcpu, kvm_vcpu_get_esr(vcpu));
 }
 
+#ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
+DECLARE_KVM_NVHE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)],
+			 pkvm_stacktrace);
+
+/*
+ * pkvm_dump_backtrace - Dump the protected nVHE HYP backtrace.
+ *
+ * @hyp_offset: hypervisor offset, used for address translation.
+ *
+ * Dumping of the pKVM HYP backtrace is done by reading the
+ * stack addresses from the shared stacktrace buffer, since the
+ * host cannot direclty access hyperviosr memory in protected
+ * mode.
+ */
+static void pkvm_dump_backtrace(unsigned long hyp_offset)
+{
+	unsigned long *stacktrace_entry
+		= (unsigned long *)this_cpu_ptr_nvhe_sym(pkvm_stacktrace);
+	unsigned long va_mask, pc;
+
+	va_mask = GENMASK_ULL(vabits_actual - 1, 0);
+
+	kvm_err("Protected nVHE HYP call trace:\n");
+
+	/* The stack trace is terminated by a null entry */
+	for (; *stacktrace_entry; stacktrace_entry++) {
+		/* Mask tags and convert to kern addr */
+		pc = (*stacktrace_entry & va_mask) + hyp_offset;
+		kvm_err(" [<%016lx>] %pB\n", pc, (void *)(pc + kaslr_offset()));
+	}
+
+	kvm_err("---- End of Protected nVHE HYP call trace ----\n");
+}
+#else	/* !CONFIG_PROTECTED_NVHE_STACKTRACE */
+static void pkvm_dump_backtrace(unsigned long hyp_offset)
+{
+	kvm_err("Cannot dump pKVM nVHE stacktrace: !CONFIG_PROTECTED_NVHE_STACKTRACE\n");
+}
+#endif /* CONFIG_PROTECTED_NVHE_STACKTRACE */
+
+/*
+ * kvm_nvhe_dump_backtrace - Dump KVM nVHE hypervisor backtrace.
+ *
+ * @hyp_offset: hypervisor offset, used for address translation.
+ */
+static void kvm_nvhe_dump_backtrace(unsigned long hyp_offset)
+{
+	if (is_protected_kvm_enabled())
+		pkvm_dump_backtrace(hyp_offset);
+}
+
 void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
 					      u64 elr_virt, u64 elr_phys,
 					      u64 par, uintptr_t vcpu,
@@ -353,6 +404,9 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
 				(void *)panic_addr);
 	}
 
+	/* Dump the nVHE hypervisor backtrace */
+	kvm_nvhe_dump_backtrace(hyp_offset);
+
 	/*
 	 * Hyp has panicked and we're going to handle that by panicking the
 	 * kernel. The kernel offset will be revealed in the panic so we're
-- 
2.37.0.170.g444d1eabd0-goog

