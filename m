Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E177E57C3F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiGUF6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiGUF57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:57:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCDC79ED8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:57:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q75-20020a25d94e000000b00670834a0102so583547ybg.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yeyBTJJsTvi5Lbtf8j5GkDXpafK17xLid75yLfJdvNQ=;
        b=dWueVy4mpzAlbp9vxBRXeJMd0tOrV6DgI5a2e6BASoaxnz2I5NxUAY8AkTgRGmCsVg
         f8XsURQmmttj+5uIMsstpaW4L1YpnR+xueEWxP8tl4iVbAFyNc8PIafqD5mLoYfqD7Ho
         pnv/c3XtqJhRETItrsayIOkmYAHQ+qaDb+c3j3c+u3ja5nMOcFF6Fzcob7sVHui35WkC
         4VGeUs4GQkHIbx3TjkCEthiZik8f2nFDWYDSn0Hf/OTdq97Vyi85fPhnMfb1IVu+49uu
         uOxiS7tqX1KUacYvZ6fjhWwmwIIFicdAdaRM3bgDywnoMhKGH1RXI9725m++3/YQlnPn
         DQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yeyBTJJsTvi5Lbtf8j5GkDXpafK17xLid75yLfJdvNQ=;
        b=PxzfDdLUJ2XzeCsRf+v18+HLergcthIpwGKE1Ql4AEg0l4dPyfWFoq4XbWRdzuYGiP
         equxrAcPM5Aor6FIKMl9FQuG5l9e7vH3ycyYZITNqAKSHGbDbtepSP/UQg7P49xXxdpA
         iOJKp8BhshLzG/LR1RNjrsfWVSUYUGYJ1qcvuK0qFI8LCVwjV8b2X17XKybC3SCLlZha
         gDMe8s6CFWEk78zVAR/OpCzB5YhYfpV+tbL27g3Is+yGjD4apAiGBth+W/q1v9A0QYcb
         C/kORqna7dgwITudvt1UEQhTCLSnjg+q1IM0CsX8JtjOWAOnx4UrHREldDlKsAtAk2UW
         3Smg==
X-Gm-Message-State: AJIora8o91aPgnSovZhwNYAYHLbdf5rDv4/uunV84dIyxR+rByl4jWa+
        CQB9BTd1Fy3LysEtGwB0e5gcenYk+3rjhxT27A==
X-Google-Smtp-Source: AGRyM1vMDEeYTxMSnumL6MvPEWUwBYRfyhLjpam3+BcX4vkhcXktAspjirIUgqM+LOZb4VluKzDtrI8VdjNV2nHveQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5a87:b61e:76b5:d1e0])
 (user=kaleshsingh job=sendgmr) by 2002:a25:4cb:0:b0:670:7c80:609b with SMTP
 id 194-20020a2504cb000000b006707c80609bmr12459399ybe.620.1658383070821; Wed,
 20 Jul 2022 22:57:50 -0700 (PDT)
Date:   Wed, 20 Jul 2022 22:57:18 -0700
In-Reply-To: <20220721055728.718573-1-kaleshsingh@google.com>
Message-Id: <20220721055728.718573-8-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v5 07/17] KVM: arm64: On stack overflow switch to hyp overflow_stack
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

On hyp stack overflow switch to 16-byte aligned secondary stack.
This provides us stack space to better handle overflows; and is
used in a subsequent patch to dump the hypervisor stacktrace.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
---

Changes in v5:
  - Add Reviewed-by tag from Fuad

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

