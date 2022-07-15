Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A850575B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiGOGLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiGOGLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:11:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124D273912
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k13-20020a056902024d00b0066fa7f50b97so3284703ybs.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l1XnM4q3x1ewVUNvHs0HuWFtRu/IpcbYPtIh1O0D3HY=;
        b=HAos/OmCJvgcvlVr+l4rgZ529Zy9AgZUmxRT5wAwy49nbAxCFX1OoZOy/MbJm5YfaI
         MRjaNeuCZinL0cnj7NX8XMcpCfHHUqWQbv0RAohFcbRY1T4dBE3coMErpa8THr3j468g
         2Mni4CUr/d6Yiy2Xf8toN4vxOmJ8Zi7NDsSuV9FH7qDcmxJowgkg5gzsyeIOlz9g3CCJ
         +cjX93wr1FiRJEKVcXe5xqj+sIUGsei1iANx4eYiKCQ/VZ1DqzZW87VQZnOwwT+6vm2L
         NAve5p5YpRJ6utTnsbjjTignNi4kvQ9AH/UAD2WaDja1b7TkTUFdfYo7/bXdsqoyTW8F
         JnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l1XnM4q3x1ewVUNvHs0HuWFtRu/IpcbYPtIh1O0D3HY=;
        b=w4ITrVBNpfwlAFj1GM5Rb/wysymzLITA4Q6UQpp9jAw7utvPn3U9tgWdiLIW0p6YFH
         K0T1AanXyw2C/8UATw4AhEpxBJyLdSkZV/Sv5VvfzUNeZy6eqf56Ekz0/5l322Y8MyCc
         g8GL3+QgWyUeW0/vfxQCXnPUhqs0i3JcidYwYlqK+z9IYSzzgQxcl+kThkxWWUife5Rr
         T9KbdeOdPiEAVPrJJQGF6G5BNbmz93qUMnyf2B0L/Wq8WG5tgzYBKCqmlP6UzW3R5wgN
         RqxcICOdGxhH5j/P5UoCmX7Rfsv+u7zsyxScxNDG7UdmEvCWyvqsjfuOd374IgJcxxFI
         +X8g==
X-Gm-Message-State: AJIora/vq75VdP6fNuZ4jqid6km22fTcHZkElR7hHG7EoZudS3ZXK0eG
        SM2aZ6+PtDNsGQ0F/7NfMK8HIYLmecNuTOBviA==
X-Google-Smtp-Source: AGRyM1sFpdc9SV33p7szlsb0+to9mu3jgVu9zuERuzC22gv4CQEQSvN6S0V0TElCV8Mv01JeqbR8z7tOfs91AebCxA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f010:455b:62ce:19e])
 (user=kaleshsingh job=sendgmr) by 2002:a25:d18b:0:b0:66f:3536:c35a with SMTP
 id i133-20020a25d18b000000b0066f3536c35amr12561943ybg.546.1657865479300; Thu,
 14 Jul 2022 23:11:19 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:10:16 -0700
In-Reply-To: <20220715061027.1612149-1-kaleshsingh@google.com>
Message-Id: <20220715061027.1612149-8-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 07/18] KVM: arm64: On stack overflow switch to hyp overflow_stack
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

On hyp stack overflow switch to 16-byte aligned secondary stack.
This provides us stack space to better handle overflows; and is
used in a subsequent patch to dump the hypervisor stacktrace.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile     |  2 +-
 arch/arm64/kvm/hyp/nvhe/host.S       |  9 ++-------
 arch/arm64/kvm/hyp/nvhe/stacktrace.c | 11 +++++++++++
 3 files changed, 14 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/stacktrace.c

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index f9fe4dc21b1f..524e7dad5739 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -14,7 +14,7 @@ lib-objs := $(addprefix ../../../lib/, $(lib-objs))
 
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
 	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o page_alloc.o \
-	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o
+	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o stacktrace.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
 obj-$(CONFIG_DEBUG_LIST) += list_debug.o
diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index ea6a397b64a6..b6c0188c4b35 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -177,13 +177,8 @@ SYM_FUNC_END(__host_hvc)
 	b	hyp_panic
 
 .L__hyp_sp_overflow\@:
-	/*
-	 * Reset SP to the top of the stack, to allow handling the hyp_panic.
-	 * This corrupts the stack but is ok, since we won't be attempting
-	 * any unwinding here.
-	 */
-	ldr_this_cpu	x0, kvm_init_params + NVHE_INIT_STACK_HYP_VA, x1
-	mov	sp, x0
+	/* Switch to the overflow stack */
+	adr_this_cpu sp, overflow_stack + OVERFLOW_STACK_SIZE, x0
 
 	b	hyp_panic_bad_stack
 	ASM_BUG()
diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
new file mode 100644
index 000000000000..a3d5b34e1249
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KVM nVHE hypervisor stack tracing support.
+ *
+ * Copyright (C) 2022 Google LLC
+ */
+#include <asm/memory.h>
+#include <asm/percpu.h>
+
+DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
+	__aligned(16);
-- 
2.37.0.170.g444d1eabd0-goog

