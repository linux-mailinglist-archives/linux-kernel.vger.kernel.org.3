Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB89457C3FD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiGUF6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiGUF6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:58:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889D079ECF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:58:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31cb93cadf2so6663457b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nCSrSlEZfmkYkOyHMY9qhudKEgt1DEv4mdp7iaevl2w=;
        b=Y/BckGi3KCbT4iTn1vHoKO+iIoWVzxgW89Wp+bOCHdv6z7DbV4KkriSzgVPMZM6mWf
         t3Np8DXW4dxPpv1lZ5ZyzliMfc/WzlVRbViT1axXnESIU//dO2Ysbj6tQOaoZ9haMLzM
         9b/3MYA906Tt2nrxQ7kX5DGCsmAD8wAnpTJjIGSrmH1tdShxTdRcuYbTXYHCmYUuh7fz
         AWiZn7q8TwP9i1Aif5D8zObMsZHYtY96eTqOEQlPJ0Veyv6fV8OH2lqzlNq4raV87REf
         kf/8wbZvR0pUDOd2o2Tzm/0YdmklhPmQ7GhOaf+HJLSF1Xt6QydN+Dsd7+7qD1ZygSMt
         jTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nCSrSlEZfmkYkOyHMY9qhudKEgt1DEv4mdp7iaevl2w=;
        b=k81AEK0Xz85ko0KIDqOOoUFof4DPaGd0B1fj1vaHgL+59/0xnaJnB1zcfVlbdFRP6Z
         /jUv1iAJf2AKBTDJfcLnsMPol6UVXCb9AR+uZaiOGh1zreCOLxiUqZsmNCEaJp6LUy1r
         oGTOzv+XiFe1e0lgZFJ8qDzLY7BWrwZPflpcWwOprW8Clal5SIJ7G0gEWDzg6HSGpsPT
         sXyABW3POqLExYEmjTPuZjO2y8evo2j5N7li8Cmj+Oy6EgEnoN6dSBjuVEh1LmqEEMHo
         WTzg4D7/3z16I/itSnNCUwEaJC8zHLch8PwzpAxuhglcASG5aFvcfr9qmJuvxQlYq5qh
         iIPw==
X-Gm-Message-State: AJIora/ZOpIukLKKg1Sgwse17HE175Df6Gx2+2Dv8/oAekQmgJJTMEO5
        kdRWQ8/TP/DxJiD35MKxTAs86wzVQWBsVoRmWQ==
X-Google-Smtp-Source: AGRyM1uVWbefCZQE+IW0YShATcxYbZ1HKKXbblRtksHLoReZ4Hx2UeN/4FbZ98rwLnifcfwg5BzwKCYVTc0NlvD1nQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5a87:b61e:76b5:d1e0])
 (user=kaleshsingh job=sendgmr) by 2002:a0d:c587:0:b0:31e:8bab:394d with SMTP
 id h129-20020a0dc587000000b0031e8bab394dmr182248ywd.107.1658383080824; Wed,
 20 Jul 2022 22:58:00 -0700 (PDT)
Date:   Wed, 20 Jul 2022 22:57:22 -0700
In-Reply-To: <20220721055728.718573-1-kaleshsingh@google.com>
Message-Id: <20220721055728.718573-12-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v5 11/17] KVM: arm64: Stub implementation of non-protected
 nVHE HYP stack unwinder
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

Add stub implementations of non-protected nVHE stack unwinder, for
building. These are implemented later in this series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v5:
  - Mark unwind_next() as inline, per Marc
  - Comment !__KVM_NVHE_HYPERVISOR__ unwinder path, per Marc

 arch/arm64/include/asm/stacktrace/nvhe.h | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
index 80d71932afff..3078501f8e22 100644
--- a/arch/arm64/include/asm/stacktrace/nvhe.h
+++ b/arch/arm64/include/asm/stacktrace/nvhe.h
@@ -8,6 +8,12 @@
  *      the HYP memory. The stack is unwinded in EL2 and dumped to a shared
  *      buffer where the host can read and print the stacktrace.
  *
+ *   2) Non-protected nVHE mode - the host can directly access the
+ *      HYP stack pages and unwind the HYP stack in EL1. This saves having
+ *      to allocate shared buffers for the host to read the unwinded
+ *      stacktrace.
+ *
+ *
  * Copyright (C) 2022 Google LLC
  */
 #ifndef __ASM_STACKTRACE_NVHE_H
@@ -55,5 +61,25 @@ static inline int notrace unwind_next(struct unwind_state *state)
 NOKPROBE_SYMBOL(unwind_next);
 #endif	/* CONFIG_PROTECTED_NVHE_STACKTRACE */
 
+#else	/* !__KVM_NVHE_HYPERVISOR__ */
+/*
+ * Conventional (non-protected) nVHE HYP stack unwinder
+ *
+ * In non-protected mode, the unwinding is done from kernel proper context
+ * (by the host in EL1).
+ */
+
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
+
 #endif	/* __KVM_NVHE_HYPERVISOR__ */
 #endif	/* __ASM_STACKTRACE_NVHE_H */
-- 
2.37.0.170.g444d1eabd0-goog

