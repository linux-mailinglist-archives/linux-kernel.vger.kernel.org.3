Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A6F57C3F8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiGUF6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiGUF6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:58:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27C279EED
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:57:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb7d137101so6650067b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/uwhBcl2d0wd6dxTVJiUUqJSQ7KfqpT1oTO144kMEdg=;
        b=BWqTOdX0ZIZ5zMm9VbYz1xMo06XHQHmhBqBdZFqXLyASFYZjsNE0fFUJrAsotKVH2h
         XJ7hnW52HME2xg7ReZn6rVjK2osnE0jb/K5QlqNipgjkKtb2cl59Qo9j03gCasGmJ1Dz
         juzPZNdDyUki1Nl7gMr8C8xcc3zmItqQLlBdzUKbzgx6Z9BCZggI7WpumSn2X8NpsikN
         Al4RWHWjPLmEgPPSEw4HJe4fxQeNejE3gTySW3+FilDGT5zBLX4fkZKiY/WCg2vsjjZI
         20fJzOdm9yjBIiPMnknkrQIGVupnOa68FqKEeobAjDieK1E+aWmxh3/BRiXSRfNAKWLp
         etqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/uwhBcl2d0wd6dxTVJiUUqJSQ7KfqpT1oTO144kMEdg=;
        b=sj4kZCRYNb1lWIfjkvLFf5MZg5CpIKAMm3xeB8F2mN5OjqHUBR73B4Jtp5emFDvZ7p
         0WCGJrgECt9txpvGf9MlYYr8GYGg1Ql//d8/03FJ1F+Tv6h4dB+VaiTIhrY6iMKAjQCu
         VmWh+9sXhIyUn+2TSijgMhp4iRa3KvNXiB8aEQ/uC7biDWmvxqbTkJ0RsTXCTkK2IJ1n
         rfdABFSdeH/yHGXNtwwPxWs3JOWFq/Mm1aXulDbnOCNut7XvkDFyrl3Ta/Q5sEfH9Rx4
         AaHV06mf2BC+x2iI4Y+LdBEx8aIzZ7zBrJI5LneiHIADidYoNpWu/IriaN0A3/gwBpVl
         GOpA==
X-Gm-Message-State: AJIora+OGojG5wFqnb0EeonLs/4HSx8RMhxXRV3t/tvOI0jF58o+KFZb
        meorjFlEuWccrJ1WWJ++tgPr8g7jWeNgdpI3Jw==
X-Google-Smtp-Source: AGRyM1uyhPISg+ylS606kbQmjVcPYblSh0zIWTy2KDjhJBy7OL6s9V2L9bR+SAwwb9z1QoXAfY2vMc1gsnfMDuOPFg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5a87:b61e:76b5:d1e0])
 (user=kaleshsingh job=sendgmr) by 2002:a0d:d8ce:0:b0:31e:545c:7343 with SMTP
 id a197-20020a0dd8ce000000b0031e545c7343mr14812233ywe.29.1658383078088; Wed,
 20 Jul 2022 22:57:58 -0700 (PDT)
Date:   Wed, 20 Jul 2022 22:57:21 -0700
In-Reply-To: <20220721055728.718573-1-kaleshsingh@google.com>
Message-Id: <20220721055728.718573-11-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v5 10/17] KVM: arm64: Stub implementation of pKVM HYP stack unwinder
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

Add some stub implementations of protected nVHE stack unwinder, for
building. These are implemented later in this series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v5:
  - Mark unwind_next() as inline, per Marc

 arch/arm64/include/asm/stacktrace/nvhe.h | 59 ++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/stacktrace.c     |  3 +-
 2 files changed, 60 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/include/asm/stacktrace/nvhe.h

diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
new file mode 100644
index 000000000000..80d71932afff
--- /dev/null
+++ b/arch/arm64/include/asm/stacktrace/nvhe.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * KVM nVHE hypervisor stack tracing support.
+ *
+ * The unwinder implementation depends on the nVHE mode:
+ *
+ *   1) pKVM (protected nVHE) mode - the host cannot directly access
+ *      the HYP memory. The stack is unwinded in EL2 and dumped to a shared
+ *      buffer where the host can read and print the stacktrace.
+ *
+ * Copyright (C) 2022 Google LLC
+ */
+#ifndef __ASM_STACKTRACE_NVHE_H
+#define __ASM_STACKTRACE_NVHE_H
+
+#include <asm/stacktrace/common.h>
+
+static inline bool on_accessible_stack(const struct task_struct *tsk,
+				       unsigned long sp, unsigned long size,
+				       struct stack_info *info)
+{
+	return false;
+}
+
+#ifdef __KVM_NVHE_HYPERVISOR__
+/*
+ * Protected nVHE HYP stack unwinder
+ *
+ * In protected mode, the unwinding is done by the hypervisor in EL2.
+ */
+
+#ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
+static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
+				     struct stack_info *info)
+{
+	return false;
+}
+
+static inline int notrace unwind_next(struct unwind_state *state)
+{
+	return 0;
+}
+NOKPROBE_SYMBOL(unwind_next);
+#else	/* !CONFIG_PROTECTED_NVHE_STACKTRACE */
+static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
+				     struct stack_info *info)
+{
+	return false;
+}
+
+static inline int notrace unwind_next(struct unwind_state *state)
+{
+	return 0;
+}
+NOKPROBE_SYMBOL(unwind_next);
+#endif	/* CONFIG_PROTECTED_NVHE_STACKTRACE */
+
+#endif	/* __KVM_NVHE_HYPERVISOR__ */
+#endif	/* __ASM_STACKTRACE_NVHE_H */
diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
index 69e65b457f1c..96c8b93320eb 100644
--- a/arch/arm64/kvm/hyp/nvhe/stacktrace.c
+++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
@@ -4,8 +4,7 @@
  *
  * Copyright (C) 2022 Google LLC
  */
-#include <asm/memory.h>
-#include <asm/percpu.h>
+#include <asm/stacktrace/nvhe.h>
 
 DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
 	__aligned(16);
-- 
2.37.0.170.g444d1eabd0-goog

