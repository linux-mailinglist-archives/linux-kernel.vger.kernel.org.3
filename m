Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C291575B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiGOGMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiGOGLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:11:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9C575387
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:30 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31c95f27403so33483477b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XgQpVRIZ/+rgJJYIXD5u7GGidNPh5ehm0t/PGc8qxk4=;
        b=KIHmo/pFQxPEIfafDaLCTvF0a7EDE8nMQQXsRPJRrevGR3G5T02SGJqczYQwFMh3ZD
         S/Mo2JRunG4K5QfkTmv39O6d0aPoe54uL7UFThYBPTrE9ktG8ha/V72h8G/iIXiVYeU0
         ai+yxL/3VpBtP32KoMJUaGknijL0zeAZhx81eaFZibT0M7zAo7VFUWGw3jhnFFrHt88D
         XeOwA7YKrOUvs+ecvZNS1RSl8Rn+s8uHO6WELw5UJbkTUdlcQbKBIsZDrRgcNZb6UF+Q
         E1JZUQiUj6FUphFlGMzjl6HBBRywechF6Ry6KSIoVwvIBwBQKX3kIHEj/DFZyAREiTAg
         LvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XgQpVRIZ/+rgJJYIXD5u7GGidNPh5ehm0t/PGc8qxk4=;
        b=qrSidXWQu08ThlKnboFAb2vlVF5p2yuDvEing4rl3oknircvVgCvzdhIpyyXJK9lOg
         gDB7DHY68NO9mp/dkGdDz/VMy6m9dKnvWTWDLxJhjOImNoLAJlF7AuMHkIVSeq6K/leZ
         2eKNn4wM3rHSvedw/6MwJ1EEjOEbKRRM0bqdbvXwpDuj2wkee2f1L9Dmf43ziKHpl7wC
         7J1DTowk74HdzqV8Abj3InKeyL0uWauu4wwYQ8IOFmodvk1xqMapDJNn1Yd4b7BCeURx
         cow9/TdBtvm7HZg13gOTyeo6JLlOl+JO40OyksvEvVm++cmL8mJBVPxuh4yGEUc/tKGU
         TBew==
X-Gm-Message-State: AJIora+jLS8yuMVgdaeem9UU9rL48rhziCMwncAc+MAjRPoC90DFfHU0
        gt1lqMjD6DYJb0jtSkFEQfjqth/QIUEgQbHGTg==
X-Google-Smtp-Source: AGRyM1s5cymxF5/2M5vXFAclyed+75vWvwbMa/H/SxWfjgxHei8pGcmW11dtGoK7T5A2HhMEXreSpy82wKmWy2XaFg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f010:455b:62ce:19e])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:282:b0:66e:26b0:8f16 with
 SMTP id v2-20020a056902028200b0066e26b08f16mr12192829ybh.469.1657865489758;
 Thu, 14 Jul 2022 23:11:29 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:10:19 -0700
In-Reply-To: <20220715061027.1612149-1-kaleshsingh@google.com>
Message-Id: <20220715061027.1612149-11-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 10/18] KVM: arm64: Stub implementation of pKVM HYP stack unwinder
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

Add some stub implementations of protected nVHE stack unwinder, for
building. These are implemented later in this series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/stacktrace/nvhe.h | 57 ++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/stacktrace.c     |  3 +-
 2 files changed, 58 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/include/asm/stacktrace/nvhe.h

diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
new file mode 100644
index 000000000000..1eac4e57f2ae
--- /dev/null
+++ b/arch/arm64/include/asm/stacktrace/nvhe.h
@@ -0,0 +1,57 @@
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
+/*
+ * Protected nVHE HYP stack unwinder
+ */
+#ifdef __KVM_NVHE_HYPERVISOR__
+
+#ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
+static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
+				     struct stack_info *info)
+{
+	return false;
+}
+
+static int notrace unwind_next(struct unwind_state *state)
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
+static int notrace unwind_next(struct unwind_state *state)
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

