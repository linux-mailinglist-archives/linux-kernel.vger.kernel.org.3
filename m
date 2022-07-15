Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491F3575B61
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiGOGNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiGOGMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:12:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF187B79E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b129-20020a25e487000000b0066e1c52ac55so3292348ybh.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pCrsAtrXdQrqKS3eeA8f9GflhdYZQyxHWES6iqq1HQQ=;
        b=jI4zAPvvQ77ZuvgrkrRIHZRkBl0VSF8QUgVCY/1ZnqdCg0pQyYf0UuEwHeiROiTaAy
         FSHAtwwXH951A9lpReSW3weDPL7qdYwHOOctZaeKlz/8zfmGCk6fRs1Evv5wtDjJbTBx
         cksIRahdwMwL9F3qJGyjQ997TNOhcHp+H114RtKstCa99riB9yoL6l7Y4CeCyWMV/92L
         JuWSurazgujBJNjwdTmMGq62lprxYhEAOKVMr/bVOZY31Ft4VD0s5Xyn5gfq130hJGt6
         vwzQ9VHOvkWYELkKQ1Ph3gdjt7xURPyOBYcL0IdT2MaGg5DiSqXxP2wCEE8xSsVaHn7d
         DJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pCrsAtrXdQrqKS3eeA8f9GflhdYZQyxHWES6iqq1HQQ=;
        b=ctGN5hLFIrmaj0v1tqSCRYN48LtTcjTr08x72VMr8OV7XpbV1aaahZ7ajiBzWy612A
         2s1Iq3AZ6x+HHX1qI9X0aXUxezvKgkvwcv3oHBlkET4DDI+SMOeN/y8ni0jdL/kQ6p9x
         gv9GX2D6WQLF5lL9+ZmqmbV5Wecx+1PuJHxvCiAoUmTwBLXdHpoLwM8NJeh8VSRtKS//
         QKhUtA3lwUZI1viN3Q6v1R32vo7d7KmM0VmjcxUGVeeQSmEt4pSJefAbd5qEcCjNJfrS
         9y2YvGUJELk/AKROju+FdObN+rByhfC3df9NyPYcaU3TZoHEUMNVwsL5ocDXPyaf1ljH
         qXgg==
X-Gm-Message-State: AJIora/YRnhK/qFkMtwPCORQHZ02PVAzUWiGtKrahgCnCym44vQPXLgv
        OveaQ57YtQ+Q3jpUEqgtd6VqWIVLf+4EENrybA==
X-Google-Smtp-Source: AGRyM1tEqC2CS+wqI7vtsUSjZ6J4A5D2uthRIAUasSZuLlJSGC81kXJwJZFzwd7qYeFr+qoAbrl5Z8/6YFdrJhWx1A==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f010:455b:62ce:19e])
 (user=kaleshsingh job=sendgmr) by 2002:a81:503:0:b0:317:c5d5:16fe with SMTP
 id 3-20020a810503000000b00317c5d516femr13830160ywf.231.1657865506980; Thu, 14
 Jul 2022 23:11:46 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:10:26 -0700
In-Reply-To: <20220715061027.1612149-1-kaleshsingh@google.com>
Message-Id: <20220715061027.1612149-18-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 17/18] KVM: arm64: Introduce hyp_dump_backtrace()
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

In non-protected nVHE mode, unwinds and dumps the hypervisor backtrace
from EL1. This is possible beacuase the host can directly access the
hypervisor stack pages in non-proteced mode.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/stacktrace/nvhe.h | 64 +++++++++++++++++++++---
 1 file changed, 56 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
index ec1a4ee21c21..c322ac95b256 100644
--- a/arch/arm64/include/asm/stacktrace/nvhe.h
+++ b/arch/arm64/include/asm/stacktrace/nvhe.h
@@ -190,6 +190,56 @@ static int notrace unwind_next(struct unwind_state *state)
 }
 NOKPROBE_SYMBOL(unwind_next);
 
+/**
+ * kvm_nvhe_print_backtrace_entry - Symbolizes and prints the HYP stack address
+ */
+static inline void kvm_nvhe_print_backtrace_entry(unsigned long addr,
+						  unsigned long hyp_offset)
+{
+	unsigned long va_mask = GENMASK_ULL(vabits_actual - 1, 0);
+
+	/* Mask tags and convert to kern addr */
+	addr = (addr & va_mask) + hyp_offset;
+	kvm_err(" [<%016lx>] %pB\n", addr, (void *)addr);
+}
+
+/**
+ * hyp_backtrace_entry - Dump an entry of the non-protected nVHE HYP stacktrace
+ *
+ * @arg    : the hypervisor offset, used for address translation
+ * @where  : the program counter corresponding to the stack frame
+ */
+static inline bool hyp_dump_backtrace_entry(void *arg, unsigned long where)
+{
+	kvm_nvhe_print_backtrace_entry(where, (unsigned long)arg);
+
+	return true;
+}
+
+/**
+ * hyp_dump_backtrace - Dump the non-proteced nVHE HYP backtrace.
+ *
+ * @hyp_offset: hypervisor offset, used for address translation.
+ *
+ * The host can directly access HYP stack pages in non-protected
+ * mode, so the unwinding is done directly from EL1. This removes
+ * the need for shared buffers between host and hypervisor for
+ * the stacktrace.
+ */
+static inline void hyp_dump_backtrace(unsigned long hyp_offset)
+{
+	struct kvm_nvhe_stacktrace_info *stacktrace_info;
+	struct unwind_state state;
+
+	stacktrace_info = this_cpu_ptr_nvhe_sym(kvm_stacktrace_info);
+
+	kvm_nvhe_unwind_init(&state, stacktrace_info->fp, stacktrace_info->pc);
+
+	kvm_err("Non-protected nVHE HYP call trace:\n");
+	unwind(&state, hyp_dump_backtrace_entry, (void *)hyp_offset);
+	kvm_err("---- End of Non-protected nVHE HYP call trace ----\n");
+}
+
 #ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
 DECLARE_KVM_NVHE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)], pkvm_stacktrace);
 
@@ -206,22 +256,18 @@ DECLARE_KVM_NVHE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)], pkvm
 static inline void pkvm_dump_backtrace(unsigned long hyp_offset)
 {
 	unsigned long *stacktrace_pos;
-	unsigned long va_mask, pc;
 
 	stacktrace_pos = (unsigned long *)this_cpu_ptr_nvhe_sym(pkvm_stacktrace);
-	va_mask = GENMASK_ULL(vabits_actual - 1, 0);
 
 	kvm_err("Protected nVHE HYP call trace:\n");
 
-	/* The stack trace is terminated by a null entry */
-	for (; *stacktrace_pos; stacktrace_pos++) {
-		/* Mask tags and convert to kern addr */
-		pc = (*stacktrace_pos & va_mask) + hyp_offset;
-		kvm_err(" [<%016lx>] %pB\n", pc, (void *)pc);
-	}
+	/* The saved stacktrace is terminated by a null entry */
+	for (; *stacktrace_pos; stacktrace_pos++)
+		kvm_nvhe_print_backtrace_entry(*stacktrace_pos, hyp_offset);
 
 	kvm_err("---- End of Protected nVHE HYP call trace ----\n");
 }
+
 #else	/* !CONFIG_PROTECTED_NVHE_STACKTRACE */
 static inline void pkvm_dump_backtrace(unsigned long hyp_offset)
 {
@@ -238,6 +284,8 @@ static inline void kvm_nvhe_dump_backtrace(unsigned long hyp_offset)
 {
 	if (is_protected_kvm_enabled())
 		pkvm_dump_backtrace(hyp_offset);
+	else
+		hyp_dump_backtrace(hyp_offset);
 }
 #endif	/* __KVM_NVHE_HYPERVISOR__ */
 #endif	/* __ASM_STACKTRACE_NVHE_H */
-- 
2.37.0.170.g444d1eabd0-goog

