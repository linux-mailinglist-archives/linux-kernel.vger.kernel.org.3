Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B26592F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiHOMr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiHOMrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:47:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0B61145A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:47:54 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so11656873pjz.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=lCEAvY10+NuD3nI71zP5xZdZUHWOv7uZzVeE6q+OzUA=;
        b=zPNKrPGThoSz9nzB7BMJM3FLXCRHMT4l03DnKDthKSIhRGG5sO3ndDWsBeeniTJrEg
         AFFh9QurWm2n/DsGpGftrkBlsD94ljaY9VIMNoSgLkohJ4kPbphzWc1IjWGwDBeqkB6y
         Ndt2kWxLMWVb6eyXLl2t5MbqRkvvQ9kFXKQraDTAZh+jTFCjq3vLRiGWloc0WT4CNmEx
         lyyu1/U3N09i4wsrrHBZIKuC8OV1VvhaMRpfgNRv5cAQkh52kvjooHMKm3B+js7X7Fwf
         zGkUV3NFx79YGjLwaH3qcTchhdSLUyALvu3/rTRk22DuNLwXyJu2od8XeV5DZtKVcKKQ
         FbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=lCEAvY10+NuD3nI71zP5xZdZUHWOv7uZzVeE6q+OzUA=;
        b=rIiWcVdTHIJ1g43b8eJ6xPmjNWLLl9/RCYtbq5mhpnrbaG//VNKhajPssDHhU9TeZk
         FUCH8iSPzsJA2fV4Uu9fENiLxd8gUmcb0z6vG4QdqfiY22fDJWvCgmVMYlfUvdTojl1C
         3YeCuHGVl5UIDeYDoIM80NMH36NJ8KZ0hJh2sHbduJ4K2bDI/MCV7K9CMAJ2Hml21Ozo
         OJtk+4klDw5SX4NV1FVIOKmrrWzrZjB918Li1tELu+6OfzPsHQu75B3JTBjcjzkUzOA7
         GZNoFqAJMUJmeQU6Oa6VvF6D8fqii+EjCSDsjeRI47VlWebmigvOOHHE1kXm/5gOiaB0
         AHAw==
X-Gm-Message-State: ACgBeo3e4yMxAWLgi4QFk9Pje8HbOL9rnL7gPr8gAymOTxU2ARd8+MMW
        ZLpnhrBtm6UDCH3ZkZnFREnI2A==
X-Google-Smtp-Source: AA6agR7596dP9ozLOori/oTF1oBmmRkZ74q2exd52NU8fWNgECFrpZb78p9fsG4PL1fBGlQf46wrfQ==
X-Received: by 2002:a17:902:f813:b0:170:8d35:8470 with SMTP id ix19-20020a170902f81300b001708d358470mr16864661plb.156.1660567673784;
        Mon, 15 Aug 2022 05:47:53 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b0016eecdf8978sm6976713plg.106.2022.08.15.05.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 05:47:53 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     will@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3] arm64: run softirqs on the per-CPU IRQ stack
Date:   Mon, 15 Aug 2022 20:47:39 +0800
Message-Id: <20220815124739.15948-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
v2: https://lore.kernel.org/lkml/20220802065325.39740-1-zhengqi.arch@bytedance.com/
v1: https://lore.kernel.org/lkml/20220708094950.41944-1-zhengqi.arch@bytedance.com/
RFC: https://lore.kernel.org/lkml/20220707110511.52129-1-zhengqi.arch@bytedance.com/

Changelog in v2 -> v3:
 - rebase onto the v6.0-rc1

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
index 571cc234d0b3..ee92f5887cf6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -230,6 +230,7 @@ config ARM64
 	select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
 	select TRACE_IRQFLAGS_SUPPORT
 	select TRACE_IRQFLAGS_NMI_SUPPORT
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

