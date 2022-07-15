Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380B9575B64
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiGOGMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiGOGLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:11:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2848A7AC25
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31cd7ade3d6so33641027b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pdXpYKuqyR2DHzDWiSA/Dd/3H8f/+4y3eqxbGuoz/60=;
        b=gp6IjzjWFE3s0WtgA0THeafhzeLINBoTb4eGy+4W8aaFNoxZGpirTqTbF7xS7KhCzj
         OVC8u1Xggk4rJ2ga+Wxi7y0dgfaIeUU+LMQoFu/+H7H+mlWBFwOT27y1BRMRuvtMW5R4
         pVF8Cx6BwHK6zf2mOwZUcifIN8RN7l4IwyBz+61P/BGjzHPmAB9M3XiuGqYcRBXGdbXH
         BElQjhQyhxgPGo68MBibokAEwadcmfzTU1Lj/BdgsDBc+DztJoAWW58GWeJ20WqVMh8O
         rgX5cS9g2fnYvRIvmsWqNAPvhAYBDXXTguTNxYfjxXB/QkGPr3P6VD692wFY19Irjf4t
         4ImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pdXpYKuqyR2DHzDWiSA/Dd/3H8f/+4y3eqxbGuoz/60=;
        b=IiIjIME8yn4e7Mxrvjub71+EziGvSUS9PkZCxW8YaLiSetA+wKXcBc/CWOmDYC9ZnB
         EIRdkJrszTfqas0IyzaKjDupUXb7Hx59cDunTGbFAQ5VfBdKTN3K0PN6XpWy+2fScgDD
         tDoqcuOEjxDSPYg1sePBdFSxtGeIgxDvpBSV8pFfVH5YKn1L0zyRVujKkWlUMnPvDkUj
         bAEjWAIpZpNlzdlFN2XumjS2mUfDDArwo6Ocmb3X7LG95IHug9S9Sg1elCgg048ef3pJ
         fJXc1JzyICoNTR+oWtpqMf4Qtk0hF7T8dDAUgM8qg1nFBGYXtb32DYAKzedH5mDDazpZ
         b2Kw==
X-Gm-Message-State: AJIora8HfpwVeD1kQlWCDrqAOnMma0DZ8rE5Yf+sjQ/575BeYVAgrBFD
        vTdRtnz1pEmiQMNE5AZMQ0Q2/6QhsxJqufCplw==
X-Google-Smtp-Source: AGRyM1s2qvo/C+AGMgSJ1bzfSnL2AH2SuaK0GUmYhlafsScdZesEOiN19TLlmgYAcKErdGUxpKCqLcIEPcdbEiO29Q==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f010:455b:62ce:19e])
 (user=kaleshsingh job=sendgmr) by 2002:a25:2303:0:b0:66f:d3d:45a with SMTP id
 j3-20020a252303000000b0066f0d3d045amr11516072ybj.606.1657865492453; Thu, 14
 Jul 2022 23:11:32 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:10:20 -0700
In-Reply-To: <20220715061027.1612149-1-kaleshsingh@google.com>
Message-Id: <20220715061027.1612149-12-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 11/18] KVM: arm64: Stub implementation of non-protected
 nVHE HYP stack unwinder
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

Add stub implementations of non-protected nVHE stack unwinder, for
building. These are implemented later in this series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/stacktrace/nvhe.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
index 1eac4e57f2ae..36cf7858ddd8 100644
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
@@ -53,5 +59,21 @@ static int notrace unwind_next(struct unwind_state *state)
 NOKPROBE_SYMBOL(unwind_next);
 #endif	/* CONFIG_PROTECTED_NVHE_STACKTRACE */
 
+/*
+ * Non-protected nVHE HYP stack unwinder
+ */
+#else	/* !__KVM_NVHE_HYPERVISOR__ */
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
+
 #endif	/* __KVM_NVHE_HYPERVISOR__ */
 #endif	/* __ASM_STACKTRACE_NVHE_H */
-- 
2.37.0.170.g444d1eabd0-goog

