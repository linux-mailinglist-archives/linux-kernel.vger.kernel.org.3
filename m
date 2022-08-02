Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CD058774B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 08:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiHBGxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 02:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiHBGxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 02:53:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43816491C8
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 23:53:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so702296pjz.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 23:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=uVFoLxQ6dMayohS3JHhDfe5iy+WrdfwvAxJQ06r4ODg=;
        b=xgH/Pm2Vq7i1xxAqCs0FiuBWEln7VQz8Mthw8a5mgC/b96Dpl/iGsVG5qf/IlnjGCx
         3E8gpHm7laW2IZ2DSrKNi008izQaxPCz6pFvauX5MR5Hh5rgtgIUVQHhgooSpUjRLOIt
         NN0H9OwLhzBkSgFArjxFA5YKPVzTBVJXIep6q4+xmrm0HgXJgWuE6xFgqpfwhE5qBNzX
         rZrSbru+D8Ho2GNPHfscScz2RwhgIa0gbF5C+M3J/PT7tgpRdNhfK+9NYgvT/nGVXgxS
         5z4ajg+2CDUDDrnQ/3U43uY+hN2UtNFdn0DkqF7YFj+VLGyfbYIcYnKC4Ice89pa1GE7
         nWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=uVFoLxQ6dMayohS3JHhDfe5iy+WrdfwvAxJQ06r4ODg=;
        b=Jx+HkRp/lZltYEmdXJO4wofsKDeyx6CTzYDI2EyVoUZkK45CIKraQC6qUBGlk/IUN+
         4WjWpejTyaqZ+smCLKtXjcSNJcHdU7y8n+NEJ/qN80dNeG4uZ4oNJbXR9+aBWQhxwXDd
         gyqcrTKOdgJCF7956ZS48NecWJStjbo3fjkRnhSOpjQTPVFDmxdd5LHsr5RZnX8Jwkzh
         25ecmfT72rQWD6Pqxh1yPAv4+ASYF+ThVMCPjtfYm1GfgtSPiDmeSbz7RL17+3VBSFoJ
         fpb7+qO7ftg4jwH+yXC6cwMMmAj+VmaFL4yKskbwNfrLW+qTS/hvWVikXqbXiD5TUVGo
         Oriw==
X-Gm-Message-State: ACgBeo269ymVP8KDim8Tgno2uBCQ9Do+qVZNrKwTkWgLhN7+HOqspvXo
        NleC/KnITVuffmHvVVoh0oGFow==
X-Google-Smtp-Source: AA6agR49NL9qaHjMgzqU4n2JYSNt1BQhiTLN5q0K/x8eg2GJigMZYgcN0OEqv/0rRIO0OMkhEyZuMg==
X-Received: by 2002:a17:903:248:b0:168:cf03:eefe with SMTP id j8-20020a170903024800b00168cf03eefemr19889308plh.124.1659423214750;
        Mon, 01 Aug 2022 23:53:34 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id 18-20020a621912000000b0052ac5e304d0sm10198168pfz.179.2022.08.01.23.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 23:53:34 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     will@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2] arm64: run softirqs on the per-CPU IRQ stack
Date:   Tue,  2 Aug 2022 14:53:25 +0800
Message-Id: <20220802065325.39740-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently arm64 supports per-CPU IRQ stack, but softirqs
are still handled in the task context.

Since any call to local_bh_enable() at any level in the task's
call stack may trigger a softirq processing run, which could
potentially cause a task stack overflow if the combined stack
footprints exceed the stack's size, let's run these softirqs
on the IRQ stack as well.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Will Deacon <will@kernel.org>
---
v1: https://lore.kernel.org/lkml/20220708094950.41944-1-zhengqi.arch@bytedance.com/
RFC: https://lore.kernel.org/lkml/20220707110511.52129-1-zhengqi.arch@bytedance.com/

Changelog in v1 -> v2:
 - temporarily discard [PATCH v1 2/2] to allow this patch to be merged first
 - rebase onto the v5.19
 - collect Reviewed-by and Acked-by

Changelog in RFC -> v1:
 - fix conflicts with commit f2c5092190f2 ("arch/*: Disable softirq stacks on PREEMPT_RT.")

 arch/arm64/Kconfig      |  1 +
 arch/arm64/kernel/irq.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1652a9800ebe..90f1ab403724 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -226,6 +226,7 @@ config ARM64
 	select THREAD_INFO_IN_TASK
 	select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
 	select TRACE_IRQFLAGS_SUPPORT
+	select HAVE_SOFTIRQ_ON_OWN_STACK
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index bda49430c9ea..c36ad20a52f3 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -22,6 +22,7 @@
 #include <linux/vmalloc.h>
 #include <asm/daifflags.h>
 #include <asm/vmap_stack.h>
+#include <asm/exception.h>
 
 /* Only access this in an NMI enter/exit */
 DEFINE_PER_CPU(struct nmi_ctx, nmi_contexts);
@@ -71,6 +72,18 @@ static void init_irq_stacks(void)
 }
 #endif
 
+#ifndef CONFIG_PREEMPT_RT
+static void ____do_softirq(struct pt_regs *regs)
+{
+	__do_softirq();
+}
+
+void do_softirq_own_stack(void)
+{
+	call_on_irq_stack(NULL, ____do_softirq);
+}
+#endif
+
 static void default_handle_irq(struct pt_regs *regs)
 {
 	panic("IRQ taken without a root IRQ handler\n");
-- 
2.20.1

