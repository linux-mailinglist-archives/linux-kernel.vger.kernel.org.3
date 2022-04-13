Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8BC4FFF46
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiDMTaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238342AbiDMTal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:30:41 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AEF73070
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:28:19 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649878095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k1Ti9WI7kQjXH/LtbtJpqTp8bomGV2aI21uzEA+/hgk=;
        b=nykjmmr0sgX45Kb38uAO4roxOKHuFvGqKVhaS7htTLEqnKboJlyPfvkJ7xqMlLAFN7fzbn
        3YYgvkl0RZ4Ec+gP9PtkVsgLLXTl5jPx7gAw4RlzgAdUTBNII6VaYVnmBXQoYKlKY9XQnv
        1JRuxhqmlIdwpkIELUxCGbVISHZ0MR8=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v3 1/3] arm64, scs: expose irq_shadow_call_stack_ptr
Date:   Wed, 13 Apr 2022 21:26:44 +0200
Message-Id: <cef39a8fe1d7783d1b6dfce5eff83c08e75577eb.1649877511.git.andreyknvl@google.com>
In-Reply-To: <cover.1649877511.git.andreyknvl@google.com>
References: <cover.1649877511.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

When a hardirq happens, the Shadow Call Stack (SCS) pointer is switched
to a per-hardirq one, which is stored in irq_shadow_call_stack_ptr per-CPU.

Collecting stack traces based on SCS in hardirqs requires access to
irq_shadow_call_stack_ptr.

Expose irq_shadow_call_stack_ptr in arch/arm64/include/asm/scs.h.

For symmetry, move sdei_shadow_call_stack_normal_ptr and
sdei_shadow_call_stack_critical_ptr declarations there too.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/scs.h | 10 +++++++++-
 arch/arm64/kernel/irq.c      |  4 +---
 arch/arm64/kernel/sdei.c     |  3 ---
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
index 8297bccf0784..9d9ac04014f1 100644
--- a/arch/arm64/include/asm/scs.h
+++ b/arch/arm64/include/asm/scs.h
@@ -24,6 +24,14 @@
 	.endm
 #endif /* CONFIG_SHADOW_CALL_STACK */
 
-#endif /* __ASSEMBLY __ */
+#else /* __ASSEMBLY__ */
+
+#include <linux/percpu.h>
+
+DECLARE_PER_CPU(unsigned long *, irq_shadow_call_stack_ptr);
+DECLARE_PER_CPU(unsigned long *, sdei_shadow_call_stack_normal_ptr);
+DECLARE_PER_CPU(unsigned long *, sdei_shadow_call_stack_critical_ptr);
+
+#endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_SCS_H */
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index bda49430c9ea..9d85c82f0b1c 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -21,6 +21,7 @@
 #include <linux/seq_file.h>
 #include <linux/vmalloc.h>
 #include <asm/daifflags.h>
+#include <asm/scs.h>
 #include <asm/vmap_stack.h>
 
 /* Only access this in an NMI enter/exit */
@@ -28,9 +29,6 @@ DEFINE_PER_CPU(struct nmi_ctx, nmi_contexts);
 
 DEFINE_PER_CPU(unsigned long *, irq_stack_ptr);
 
-
-DECLARE_PER_CPU(unsigned long *, irq_shadow_call_stack_ptr);
-
 #ifdef CONFIG_SHADOW_CALL_STACK
 DEFINE_PER_CPU(unsigned long *, irq_shadow_call_stack_ptr);
 #endif
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index d20620a1c51a..882f88ce8d4d 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -39,9 +39,6 @@ DEFINE_PER_CPU(unsigned long *, sdei_stack_normal_ptr);
 DEFINE_PER_CPU(unsigned long *, sdei_stack_critical_ptr);
 #endif
 
-DECLARE_PER_CPU(unsigned long *, sdei_shadow_call_stack_normal_ptr);
-DECLARE_PER_CPU(unsigned long *, sdei_shadow_call_stack_critical_ptr);
-
 #ifdef CONFIG_SHADOW_CALL_STACK
 DEFINE_PER_CPU(unsigned long *, sdei_shadow_call_stack_normal_ptr);
 DEFINE_PER_CPU(unsigned long *, sdei_shadow_call_stack_critical_ptr);
-- 
2.25.1

