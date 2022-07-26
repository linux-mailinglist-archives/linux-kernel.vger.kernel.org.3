Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28529580E08
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbiGZHk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238465AbiGZHin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:38:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6521DE60
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s6-20020a25c206000000b0066ebb148de6so10489904ybf.15
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=C05IvefY3yHCSicvywO05OO7/p0cJlxJJw9NBtAG/BI=;
        b=ob0fpBg8on7i2VT4Z634POHg6172v4VbWQBgZgfbUIfl3zaaqjd2K1fDRy9359PVjb
         4x4V7vuhKpQ2qxl2xXXTkZqOksr1K6xehND+jYxPnqLLL4sGxuAYqcaGIzzLq/EQSV32
         4XNIGl6pZxohnm3t8lNmwRsOcAm+H3FZRMvxLWyeW3uMAZF7pf3Q9GP2Fa1ueJk0x2Ux
         tpQPP6PzohSzZi9bbBhmNzb8WpHg8N43FnQ4ZwhcEcbQtltUBDAKI3HhFKP5hQT3YEVu
         PlAzKvYGDWLsYcb3P4TPbRyvpZgZMXxlQitgwIycWRd++/l8WatzmXjknkpPNNNxUIfh
         JyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=C05IvefY3yHCSicvywO05OO7/p0cJlxJJw9NBtAG/BI=;
        b=3T7H1oZz5n43JDm4hfSfAMwYzNchj3rSSdBoF4bd2xMe1Ge8/bomTv3KxMBL4UG3nS
         b+g9EJy45HeVt/arwEFznlXn74XXpiWqDpODmqusKjy+sj222okV18Xckmm3ufxs9RVt
         uPaQMu1Zo3bJSzCFn42ebxV5Z/d+LwuzsvTrA6DGv4OCn1O7BR0Nras9wGpfrfkMWsbM
         zFcu+S6GOVZa4txMAGaRhba0DLxzmkmhJNV3gFP6IOOp9DxvtQ6BHnvjQp9X4Uv/Vf78
         nwxfD5P+UH+Lljct6ktvlqbKtUt1fRId0sMtjxffse5JyA0Rx/e7Yob2TLPYWLUZyI+T
         Yg3A==
X-Gm-Message-State: AJIora+mI3gbyx5ksIzcj4aOIxMqXD0IuTZQlsinOrF7z5D/suZMSP/J
        rpfMGodHnvduW8CBZKyNWsHHyBO4f7dxnET1yg==
X-Google-Smtp-Source: AGRyM1s6pLQ/wRx5BpTGjEP9aAkuHSQDACPu3UJRYg3QKP09PzT9y5R0O/ZIhB0UfRXFksJMnzxnUqHKNhS8Z1k5qQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:4f77:3b64:736a:394e])
 (user=kaleshsingh job=sendgmr) by 2002:a25:50c5:0:b0:670:394a:a2a with SMTP
 id e188-20020a2550c5000000b00670394a0a2amr12895264ybb.294.1658821099711; Tue,
 26 Jul 2022 00:38:19 -0700 (PDT)
Date:   Tue, 26 Jul 2022 00:37:43 -0700
In-Reply-To: <20220726073750.3219117-1-kaleshsingh@google.com>
Message-Id: <20220726073750.3219117-11-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220726073750.3219117-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v6 10/17] KVM: arm64: Implement non-protected nVHE hyp stack unwinder
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

Implements the common framework necessary for unwind() to work
for non-protected nVHE mode:
    - on_accessible_stack()
    - on_overflow_stack()
    - unwind_next()

Non-protected nVHE unwind() is used to unwind and dump the hypervisor
stacktrace by the host in EL1

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
---

Changes in v6:
  - Add Fuad=E2=80=99s Reviewed-by and Tested-by tags

Changes in v5:
  - Use regular comments instead of doc comments, per Fuad

 arch/arm64/include/asm/stacktrace/common.h |  2 +
 arch/arm64/include/asm/stacktrace/nvhe.h   | 76 +++++++++++++++++++++-
 arch/arm64/kvm/arm.c                       |  2 +-
 3 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/includ=
e/asm/stacktrace/common.h
index 45474b383630..3ebb69ea374a 100644
--- a/arch/arm64/include/asm/stacktrace/common.h
+++ b/arch/arm64/include/asm/stacktrace/common.h
@@ -34,6 +34,7 @@ enum stack_type {
 	STACK_TYPE_OVERFLOW,
 	STACK_TYPE_SDEI_NORMAL,
 	STACK_TYPE_SDEI_CRITICAL,
+	STACK_TYPE_HYP,
 	__NR_STACK_TYPES
 };
=20
@@ -186,6 +187,7 @@ static inline int unwind_next_common(struct unwind_stat=
e *state,
 	 *
 	 * TASK -> IRQ -> OVERFLOW -> SDEI_NORMAL
 	 * TASK -> SDEI_NORMAL -> SDEI_CRITICAL -> OVERFLOW
+	 * HYP -> OVERFLOW
 	 *
 	 * ... but the nesting itself is strict. Once we transition from one
 	 * stack to another, it's never valid to unwind back to that first
diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/=
asm/stacktrace/nvhe.h
index 1192ae0f80c1..21082fd4a0b7 100644
--- a/arch/arm64/include/asm/stacktrace/nvhe.h
+++ b/arch/arm64/include/asm/stacktrace/nvhe.h
@@ -16,10 +16,19 @@
=20
 #include <asm/stacktrace/common.h>
=20
+static inline bool on_hyp_stack(unsigned long sp, unsigned long size,
+				struct stack_info *info);
+
 static inline bool on_accessible_stack(const struct task_struct *tsk,
 				       unsigned long sp, unsigned long size,
 				       struct stack_info *info)
 {
+	if (on_accessible_stack_common(tsk, sp, size, info))
+		return true;
+
+	if (on_hyp_stack(sp, size, info))
+		return true;
+
 	return false;
 }
=20
@@ -31,15 +40,78 @@ static inline bool on_accessible_stack(const struct tas=
k_struct *tsk,
  * (by the host in EL1).
  */
=20
+DECLARE_KVM_NVHE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],=
 overflow_stack);
+DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_stacktrace_info, kvm_stacktrace_i=
nfo);
+DECLARE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+
+/*
+ * kvm_nvhe_stack_kern_va - Convert KVM nVHE HYP stack addresses to a kern=
el VAs
+ *
+ * The nVHE hypervisor stack is mapped in the flexible 'private' VA range,=
 to
+ * allow for guard pages below the stack. Consequently, the fixed offset a=
ddress
+ * translation macros won't work here.
+ *
+ * The kernel VA is calculated as an offset from the kernel VA of the hype=
rvisor
+ * stack base.
+ *
+ * Returns true on success and updates @addr to its corresponding kernel V=
A;
+ * otherwise returns false.
+ */
+static inline bool kvm_nvhe_stack_kern_va(unsigned long *addr,
+					  enum stack_type type)
+{
+	struct kvm_nvhe_stacktrace_info *stacktrace_info;
+	unsigned long hyp_base, kern_base, hyp_offset;
+
+	stacktrace_info =3D this_cpu_ptr_nvhe_sym(kvm_stacktrace_info);
+
+	switch (type) {
+	case STACK_TYPE_HYP:
+		kern_base =3D (unsigned long)*this_cpu_ptr(&kvm_arm_hyp_stack_page);
+		hyp_base =3D (unsigned long)stacktrace_info->stack_base;
+		break;
+	case STACK_TYPE_OVERFLOW:
+		kern_base =3D (unsigned long)this_cpu_ptr_nvhe_sym(overflow_stack);
+		hyp_base =3D (unsigned long)stacktrace_info->overflow_stack_base;
+		break;
+	default:
+		return false;
+	}
+
+	hyp_offset =3D *addr - hyp_base;
+
+	*addr =3D kern_base + hyp_offset;
+
+	return true;
+}
+
 static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
 				     struct stack_info *info)
 {
-	return false;
+	struct kvm_nvhe_stacktrace_info *stacktrace_info
+				=3D this_cpu_ptr_nvhe_sym(kvm_stacktrace_info);
+	unsigned long low =3D (unsigned long)stacktrace_info->overflow_stack_base=
;
+	unsigned long high =3D low + OVERFLOW_STACK_SIZE;
+
+	return on_stack(sp, size, low, high, STACK_TYPE_OVERFLOW, info);
+}
+
+static inline bool on_hyp_stack(unsigned long sp, unsigned long size,
+				struct stack_info *info)
+{
+	struct kvm_nvhe_stacktrace_info *stacktrace_info
+				=3D this_cpu_ptr_nvhe_sym(kvm_stacktrace_info);
+	unsigned long low =3D (unsigned long)stacktrace_info->stack_base;
+	unsigned long high =3D low + PAGE_SIZE;
+
+	return on_stack(sp, size, low, high, STACK_TYPE_HYP, info);
 }
=20
 static inline int notrace unwind_next(struct unwind_state *state)
 {
-	return 0;
+	struct stack_info info;
+
+	return unwind_next_common(state, &info, kvm_nvhe_stack_kern_va);
 }
 NOKPROBE_SYMBOL(unwind_next);
=20
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index a0188144a122..6a64293108c5 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -49,7 +49,7 @@ DEFINE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
=20
 DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
=20
-static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
 DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
=20
--=20
2.37.1.359.gd136c6c3e2-goog

