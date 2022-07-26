Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC2D580E04
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238223AbiGZHkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiGZHin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:38:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD65C2C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v19-20020a252f13000000b0067174f085e9so558938ybv.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=9m8IvwBOrk2IG7YkQAmQznPKKCvMCFPD8HJb+zFgtK8=;
        b=VhKEEavk6g8DUisEYJ5fAHdMTvKq1n+wB7+56Ad5f4Tt+AZAOv7GuRys7Kgb+3+KOG
         p03FaqATet8gRqAPFppMF9Kfbj/aDmzrkJudV1qME6MnQKWKFtW9pdbRTtwAn+OYEWy9
         B7NVUpEbguxv4nUZgDaWFKufpopj+7xZULmeUF3mYeIBkoglfz3pXlVJNkApttUvBYbv
         rf6vSs4cE7BLt6NNMWawOgPLMDkK1hTQ1GT2YS9ZHmApphd+I6th/NhszMgZ5+elz7pb
         C/8gi3GqQXgiVyNuV4OmLVw58XuRoDb52Hqoazg89l/+gnlHqCoQ8xlq2Oe6EZ9y9f0p
         VBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=9m8IvwBOrk2IG7YkQAmQznPKKCvMCFPD8HJb+zFgtK8=;
        b=gd0LQlp4FS4RvpGcFaLfv5eOtn63y93L8YAyBwZjt2zkdpGtY2qSlljlsXiY7TjDLC
         KT0WvamwlDbikhOQVDat42+5eCNMPouHa8ZcWDrJXkovQdm8fEX+3aAJsNRJxbWUjPTH
         40Aa4l6gt+SU5Q+fDI8zNHmH2zHym7uhLOG9KE29r7rrCtU+8AgMCY7VMVYACferoiZ3
         NEQjHnRkzNLJNpIVarlmh897BIhoFoRjoAw/Wp8SZZiAFEfyO7dbIkKqek0NTQISy6h2
         pQeBjj7ZYq7fS4J8mXIRThm5JTo1YOHcUJB9TIjr0jEvd3xtbigtOo1onoBYTF21ptph
         8sig==
X-Gm-Message-State: AJIora+uTgTrdS/KfhRyuxZGxgOoFhoE6Bgg4sus3mmjqsssKXPJLlNM
        O/BgO8YpG9jWw/t/YEcrabKs6YI0+4jxLva1jA==
X-Google-Smtp-Source: AGRyM1tZibhQ2sQ3XGV5gsfb456P6K4Ka3kCr7dAdskf5tEREIiKvgCRKyyCGjYAT/M3AHlYk45u/sv5vdP+iu+2/Q==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:4f77:3b64:736a:394e])
 (user=kaleshsingh job=sendgmr) by 2002:a25:d6cc:0:b0:671:6e7e:d5d9 with SMTP
 id n195-20020a25d6cc000000b006716e7ed5d9mr1909023ybg.14.1658821097301; Tue,
 26 Jul 2022 00:38:17 -0700 (PDT)
Date:   Tue, 26 Jul 2022 00:37:42 -0700
In-Reply-To: <20220726073750.3219117-1-kaleshsingh@google.com>
Message-Id: <20220726073750.3219117-10-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220726073750.3219117-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v6 09/17] KVM: arm64: Prepare non-protected nVHE hypervisor stacktrace
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
Content-Transfer-Encoding: quoted-printable
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
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
---

Changes in v6:
  - Add Fuad=E2=80=99s Reviewed-by and Tested-by tags

Changes in v5:
  - Use regular comments instead of doc comments, per Fuad

 arch/arm64/include/asm/kvm_asm.h     | 16 +++++++++++
 arch/arm64/kvm/hyp/nvhe/stacktrace.c | 41 ++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/switch.c     |  6 ++++
 3 files changed, 63 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_=
asm.h
index 2e277f2ed671..53035763e48e 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -176,6 +176,22 @@ struct kvm_nvhe_init_params {
 	unsigned long vtcr;
 };
=20
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
diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe=
/stacktrace.c
index a3d5b34e1249..b8a280aa026a 100644
--- a/arch/arm64/kvm/hyp/nvhe/stacktrace.c
+++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
@@ -4,8 +4,49 @@
  *
  * Copyright (C) 2022 Google LLC
  */
+#include <asm/kvm_asm.h>
+#include <asm/kvm_hyp.h>
 #include <asm/memory.h>
 #include <asm/percpu.h>
=20
 DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_=
stack)
 	__aligned(16);
+
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
+	struct kvm_nvhe_stacktrace_info *stacktrace_info =3D this_cpu_ptr(&kvm_st=
acktrace_info);
+	struct kvm_nvhe_init_params *params =3D this_cpu_ptr(&kvm_init_params);
+
+	stacktrace_info->stack_base =3D (unsigned long)(params->stack_hyp_va - PA=
GE_SIZE);
+	stacktrace_info->overflow_stack_base =3D (unsigned long)this_cpu_ptr(over=
flow_stack);
+	stacktrace_info->fp =3D fp;
+	stacktrace_info->pc =3D pc;
+}
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
+		return;
+	else
+		hyp_prepare_backtrace(fp, pc);
+}
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/swi=
tch.c
index 6db801db8f27..64e13445d0d9 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -34,6 +34,8 @@ DEFINE_PER_CPU(struct kvm_host_data, kvm_host_data);
 DEFINE_PER_CPU(struct kvm_cpu_context, kvm_hyp_ctxt);
 DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
=20
+extern void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc)=
;
+
 static void __activate_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val;
@@ -375,6 +377,10 @@ asmlinkage void __noreturn hyp_panic(void)
 		__sysreg_restore_state_nvhe(host_ctxt);
 	}
=20
+	/* Prepare to dump kvm nvhe hyp stacktrace */
+	kvm_nvhe_prepare_backtrace((unsigned long)__builtin_frame_address(0),
+				   _THIS_IP_);
+
 	__hyp_do_panic(host_ctxt, spsr, elr, par);
 	unreachable();
 }
--=20
2.37.1.359.gd136c6c3e2-goog

