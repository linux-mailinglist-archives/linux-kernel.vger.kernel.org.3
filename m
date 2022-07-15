Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66EE575B59
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiGOGNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiGOGMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:12:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335B47B797
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31c9f68d48cso33858607b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I1SuK+mlx4+9ePe7Z4q/Ds8UD0oS6ojhAZGxfH2qnag=;
        b=JdLDNIjxjl26urcQRjobE7lTFwccfK46WtRp+G7+hkl3xjEvwMw68U/MYBXubciMxG
         BUImcs+xTk3eLMzI43bui6vTXiNnZu8GyF+VhTxsBvMu84qLdmtpNmydEJC1khQOQ50Z
         iSxrEYA8fXN/craiygC6fAoFdYfU1OKsRY4QkJxHDjnzj3AKTL1loj3883Xiz45eqNE8
         NzpjLCCYzvSug/99Xx/FJEKg7xSZx78LuAbSVSyhjyyMngJSswROraDCbOLtuRtJsQPS
         5wF5vbQpcK4Ay7pfQPwg7dQgjrZm2O+7wGs5DLCMznbnRwd0oZO0Z5vhLoDnd0cxM7iy
         pjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I1SuK+mlx4+9ePe7Z4q/Ds8UD0oS6ojhAZGxfH2qnag=;
        b=g1l8b1R13boUtiuSBMV9EUgmdK8+0UIwRC3zWlchyCDHO2CJUHHNt/JmJ5Ifa+lUd/
         7wWYQVshzHTMybZPhjUVYfyBLq/pMfrAT+xw4npy+QMyseQbGxsPjY6Z9tpM5GHDU54r
         Zv21aSDDWue67/TSx/qPQhwbojufHucZ2Wy2V/8BnzHxFdcNZBaT8Pq4hkGMuwLtUKps
         2bQe9hPoubf70NdXDhVRzCpYPTqYlyoZu9NE6FRUSbKsZgOXeLN37EXuP+7/gEARXVkQ
         KU4vqFt+rmOr0Jn3klVBuip5FDd/cnBZUzipzJ/LUjqYdXp4vtWHtPvYWkaOhfYZZ8L5
         vnAw==
X-Gm-Message-State: AJIora80b1J0Rq7e3edZ37gzdeOar9glQ31pzec4TCJGov6nM4fsmOQp
        b1wExDlANcrrFC/vbMxta7IrZ2Qdf9631cK/LA==
X-Google-Smtp-Source: AGRyM1vfpvfXbao8rDt6oOq5i85WSVodppQ11DSfR0dlAxIEEuKVDbQoAxSVRuw8vhTAwf/zAn7NyXoNXMOZ7LmHhA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f010:455b:62ce:19e])
 (user=kaleshsingh job=sendgmr) by 2002:a25:1c04:0:b0:660:1ffc:fb9 with SMTP
 id c4-20020a251c04000000b006601ffc0fb9mr12710440ybc.431.1657865504408; Thu,
 14 Jul 2022 23:11:44 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:10:25 -0700
In-Reply-To: <20220715061027.1612149-1-kaleshsingh@google.com>
Message-Id: <20220715061027.1612149-17-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 16/18] KVM: arm64: Introduce pkvm_dump_backtrace()
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

Dumps the pKVM hypervisor backtrace from EL1 by reading the unwinded
addresses from the shared stacktrace buffer.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/stacktrace/nvhe.h | 49 ++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
index c3f94b10f8f0..ec1a4ee21c21 100644
--- a/arch/arm64/include/asm/stacktrace/nvhe.h
+++ b/arch/arm64/include/asm/stacktrace/nvhe.h
@@ -190,5 +190,54 @@ static int notrace unwind_next(struct unwind_state *state)
 }
 NOKPROBE_SYMBOL(unwind_next);
 
+#ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
+DECLARE_KVM_NVHE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)], pkvm_stacktrace);
+
+/**
+ * pkvm_dump_backtrace - Dump the protected nVHE HYP backtrace.
+ *
+ * @hyp_offset: hypervisor offset, used for address translation.
+ *
+ * Dumping of the pKVM HYP backtrace is done by reading the
+ * stack addresses from the shared stacktrace buffer, since the
+ * host cannot direclty access hyperviosr memory in protected
+ * mode.
+ */
+static inline void pkvm_dump_backtrace(unsigned long hyp_offset)
+{
+	unsigned long *stacktrace_pos;
+	unsigned long va_mask, pc;
+
+	stacktrace_pos = (unsigned long *)this_cpu_ptr_nvhe_sym(pkvm_stacktrace);
+	va_mask = GENMASK_ULL(vabits_actual - 1, 0);
+
+	kvm_err("Protected nVHE HYP call trace:\n");
+
+	/* The stack trace is terminated by a null entry */
+	for (; *stacktrace_pos; stacktrace_pos++) {
+		/* Mask tags and convert to kern addr */
+		pc = (*stacktrace_pos & va_mask) + hyp_offset;
+		kvm_err(" [<%016lx>] %pB\n", pc, (void *)pc);
+	}
+
+	kvm_err("---- End of Protected nVHE HYP call trace ----\n");
+}
+#else	/* !CONFIG_PROTECTED_NVHE_STACKTRACE */
+static inline void pkvm_dump_backtrace(unsigned long hyp_offset)
+{
+	kvm_err("Cannot dump pKVM nVHE stacktrace: !CONFIG_PROTECTED_NVHE_STACKTRACE\n");
+}
+#endif /* CONFIG_PROTECTED_NVHE_STACKTRACE */
+
+/**
+ * kvm_nvhe_dump_backtrace - Dump KVM nVHE hypervisor backtrace.
+ *
+ * @hyp_offset: hypervisor offset, used for address translation.
+ */
+static inline void kvm_nvhe_dump_backtrace(unsigned long hyp_offset)
+{
+	if (is_protected_kvm_enabled())
+		pkvm_dump_backtrace(hyp_offset);
+}
 #endif	/* __KVM_NVHE_HYPERVISOR__ */
 #endif	/* __ASM_STACKTRACE_NVHE_H */
-- 
2.37.0.170.g444d1eabd0-goog

