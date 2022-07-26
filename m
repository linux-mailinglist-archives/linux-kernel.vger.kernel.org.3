Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13676580E02
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiGZHkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238535AbiGZHiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:38:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA356636D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f3a3b8c17so21034767b3.23
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xzH/6M+SU0X5hOX4FZRvYLC0KzgDSzoTGm2ET8Rq+o0=;
        b=DETaP7rF9wWbO6Msex1IjbIPOs5qcFopnknde2KDuKfQtGfBHQQZeSttvtn1M31WnG
         YP9SmoTcjSiBVkQMa36IbuQEGimRV0R+nOmXct3SY4oULsKy7C54mnSHLgxbuyhdBcn5
         kc9VIPOtYstVwH+wHBNdY1bHzvfVqak5AfqO5t5aHq6xwBNPcc5ZWHhSUSXM+E5dhfkf
         Ig+GVFWSBaY3UZVU8Po82d30sbS/TuoWAuUoCDKCXCNT+IUA8CjzhJO0oTyEwNNyc6RG
         MBN6CwskgCB1Yhqk5Ni52rnn47r/JS90lh+HxJt3TannLGJVTmQaK1SXj7Iua9xSEMdz
         Suzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xzH/6M+SU0X5hOX4FZRvYLC0KzgDSzoTGm2ET8Rq+o0=;
        b=KfgLu4txL8GltzoO3+4yuN6W2mlpLPbe9SSNRTXW4qfxfFmy/wgTx2w7bHlOpWt4c7
         gowQFbbjp11jIkYStrpS7E+3bgpapzTl0DC6GyUsmd9aYEvEyTC8/QbaGoIHCgfxCiIn
         x8XwVhkk0fNn8/Mt99DUhEsMOoQpFHaxOA69m+zFoOeI29MhAw46vix4OeOYMCpGTAfd
         EnMtO/ixEWjWPKklxhBdah88b3x1vUMi1+jbSkTxSWwmZxZdiX9RDNHUYnby68Ct9DFb
         1aw1iwvCEk+LD+uvtXe+aSTdA/gDIpQiTYXEojXieHKM8dvvK6ru83menxBbj8KCDHJD
         nN6Q==
X-Gm-Message-State: AJIora+GKk+2Nd7n5Hz+KgGlIoISGENk2CM9vV7f9SL2CsXb4bDvehrw
        LRoIS4OfFdSHZKJ/iVIQoJi8mN/V/mr/493ldg==
X-Google-Smtp-Source: AGRyM1s9MRRJnFJpaGAtK6mRh1YvUHLp08b9Vp1bPDczimM0hZ7elFoj8DoT6FWrVuc+bm+K4KVS8zylnMHhGD9GeQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:4f77:3b64:736a:394e])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:f41:0:b0:671:6ce6:f71 with SMTP id
 y1-20020a5b0f41000000b006716ce60f71mr2391473ybr.506.1658821112045; Tue, 26
 Jul 2022 00:38:32 -0700 (PDT)
Date:   Tue, 26 Jul 2022 00:37:48 -0700
In-Reply-To: <20220726073750.3219117-1-kaleshsingh@google.com>
Message-Id: <20220726073750.3219117-16-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220726073750.3219117-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v6 15/17] KVM: arm64: Save protected-nVHE (pKVM) hyp stacktrace
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

In protected nVHE mode, the host cannot access private owned hypervisor
memory. Also the hypervisor aims to remains simple to reduce the attack
surface and does not provide any printk support.

For the above reasons, the approach taken to provide hypervisor stacktraces
in protected mode is:
   1) Unwind and save the hyp stack addresses in EL2 to a shared buffer
      with the host (done in this patch).
   2) Delegate the dumping and symbolization of the addresses to the
      host in EL1 (later patch in the series).

On hyp_panic(), the hypervisor prepares the stacktrace before returning to
the host.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v6:
  - Simplify pkvm_save_backtrace_entry() using array semantics instead
    of the pointer arithmetic, per Oliver.

Changes in v5:
  - Comment/clarify pkvm_save_backtrace_entry(), per Fuad
  - kvm_nvhe_unwind_init(), doesn't need to be always inline, make it
    inline instead to avoid linking issues, per Marc
  - Use regular comments instead of doc comments, per Fuad

 arch/arm64/kvm/hyp/nvhe/stacktrace.c | 55 +++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
index e2edda92a108..900324b7a08f 100644
--- a/arch/arm64/kvm/hyp/nvhe/stacktrace.c
+++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
@@ -35,7 +35,60 @@ static void hyp_prepare_backtrace(unsigned long fp, unsigned long pc)
 }
 
 #ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
+#include <asm/stacktrace/nvhe.h>
+
 DEFINE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)], pkvm_stacktrace);
+
+/*
+ * pkvm_save_backtrace_entry - Saves a protected nVHE HYP stacktrace entry
+ *
+ * @arg    : index of the entry in the stacktrace buffer
+ * @where  : the program counter corresponding to the stack frame
+ *
+ * Save the return address of a stack frame to the shared stacktrace buffer.
+ * The host can access this shared buffer from EL1 to dump the backtrace.
+ */
+static bool pkvm_save_backtrace_entry(void *arg, unsigned long where)
+{
+	unsigned long *stacktrace = this_cpu_ptr(pkvm_stacktrace);
+	int size = NVHE_STACKTRACE_SIZE / sizeof(long);
+	int *idx = (int *)arg;
+
+	/*
+	 * Need 2 free slots: 1 for current entry and 1 for the
+	 * delimiter.
+	 */
+	if (*idx > size - 2)
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
 
 /*
@@ -50,7 +103,7 @@ DEFINE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)], pkvm_stacktrac
 void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc)
 {
 	if (is_protected_kvm_enabled())
-		return;
+		pkvm_save_backtrace(fp, pc);
 	else
 		hyp_prepare_backtrace(fp, pc);
 }
-- 
2.37.1.359.gd136c6c3e2-goog

