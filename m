Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F29B575B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiGOGL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiGOGLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:11:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997BE7AC00
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k13-20020a25240d000000b0066e32c61c25so3293156ybk.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=M+jjLcbVfGFpuFyPmYM6em2hR4mF4qVioAr2e7vX+Xw=;
        b=foYSq5L3M94ew4oJheHVCcZ2sd6WTh+axQJQ3f2I0/KjDrbsDlveUQa36a+4dMUW86
         oAr59yWp3/4fthJGLKbeqP3ToV625tQE1/Zl59UnW6ZgwRejfMF2CeiuIgAxnPKEdOua
         Wom/AcDe7Y1Vs7m9B9yUKDv3XbJABdFnmiRFcsEaHQF6hCWr4TvLrSsy0kbhYg0ecJCY
         1BkjPIw0aCv0o/w1YsTK46SYwcGHpjGTLHy7NN08z1pijZldSS4E9d/h1bdT4iLMAAvp
         BIW0nHEuzPtR74D0IBEy/L6c6MHoCmRGrZgKKOBHl0myQ+Dw11PmBzmEKNu6izs3iIbu
         yVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M+jjLcbVfGFpuFyPmYM6em2hR4mF4qVioAr2e7vX+Xw=;
        b=dXYA1J5VwysnmeT5sErbTfdVBWhKbPoIRFVamHq1f5ay1J1WiRYLmpsMdPX06hQtHA
         BUhby9yjtsatE0sO+CsNLPQXiG56/cbHYh/5Zvtye4CrNA5ZrWG6y5/Hv7KP+1cbLd8o
         d9MfNvk9qQa9EVyuox/z517bDIgCJme2ZGy5LjKzTEJbi5MaLqD4/sBIo39erRXkEqHj
         YQJghk9r1ULRsTwCIVm7k6bukfxg8zbge20jDJJDVeXDtvJy/MRyW7Va8augVKbkqlEI
         g8TbsVGQpzjhaqbH9zHcJ2q4H543/de1uX0LbshCW+ewhECexrBXZgY0N47WHdytLF6t
         qLkQ==
X-Gm-Message-State: AJIora9eFBNgckq0Avn71YmNaI0h/l4s4oag4lf55k0UkXvOTqPdpTOV
        KEEol+bzYpqA2dsEIPITotwCQgt0Yjp/xyaMGw==
X-Google-Smtp-Source: AGRyM1sHtVrkbrB5cwuR+qVJGCIV5+KLljaGjEU50/j14j8kkUywTaBTDzCv9+0MBKlLC2xgVIaPgUUyPSHW2bJDFQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f010:455b:62ce:19e])
 (user=kaleshsingh job=sendgmr) by 2002:a25:508a:0:b0:66e:570b:52da with SMTP
 id e132-20020a25508a000000b0066e570b52damr12381412ybb.464.1657865486862; Thu,
 14 Jul 2022 23:11:26 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:10:18 -0700
In-Reply-To: <20220715061027.1612149-1-kaleshsingh@google.com>
Message-Id: <20220715061027.1612149-10-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 09/18] KVM: arm64: Allocate shared pKVM hyp stacktrace buffers
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

In protected nVHE mode the host cannot directly access
hypervisor memory, so we will dump the hypervisor stacktrace
to a shared buffer with the host.

The minimum size do the buffer required, assuming the min frame
size of [x29, x30] (2 * sizeof(long)), is half the combined size of
the hypervisor and overflow stacks plus an additional entry to
delimit the end of the stacktrace.

The stacktrace buffers are used later in the seried to dump the
nVHE hypervisor stacktrace when using protected-mode.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/memory.h      | 7 +++++++
 arch/arm64/kvm/hyp/nvhe/stacktrace.c | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0af70d9abede..28a4893d4b84 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -113,6 +113,13 @@
 
 #define OVERFLOW_STACK_SIZE	SZ_4K
 
+/*
+ * With the minimum frame size of [x29, x30], exactly half the combined
+ * sizes of the hyp and overflow stacks is needed to save the unwinded
+ * stacktrace; plus an additional entry to delimit the end.
+ */
+#define NVHE_STACKTRACE_SIZE	((OVERFLOW_STACK_SIZE + PAGE_SIZE) / 2 + sizeof(long))
+
 /*
  * Alignment of kernel segments (e.g. .text, .data).
  *
diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
index a3d5b34e1249..69e65b457f1c 100644
--- a/arch/arm64/kvm/hyp/nvhe/stacktrace.c
+++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
@@ -9,3 +9,7 @@
 
 DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
 	__aligned(16);
+
+#ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
+DEFINE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)], pkvm_stacktrace);
+#endif /* CONFIG_PROTECTED_NVHE_STACKTRACE */
-- 
2.37.0.170.g444d1eabd0-goog

