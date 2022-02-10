Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173754B05CC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 06:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbiBJFuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 00:50:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiBJFuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 00:50:25 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6294410FD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 21:50:27 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so7450463pjl.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 21:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OtWwAgOtAe4D9GgVae0thKZfJlP6oFxQeQXK4rT/p2g=;
        b=mpvzlkh15vWsDQDPqVespvAUorDjv4P0sXqAc43zuY+p/gP1hjsGsumlseXedX5pv0
         nD34zA7BaDB8xRV05FF+GrTx2SsucaTtpPcJaJVMfdjOLhb/MuvDOcClLikACX0k/kh9
         MfVC1TAYC1ZWtaNp7F9URyQsfu8Lyxs6FKdvb3QvBhfH9pdoEu+aQ2IiPvQKwdQO1YrG
         T3K9CqUIfBVIsoXlZAL68OMChaNNhwqULFJxxqzbBEfgKPRfp2d0rLWrBoCafCseUggG
         UCIKPCCXLeD8tAu91hP/yLuhLgBKxD+9tmr5+n5hdv6jgz80NH3w8Sg1epBMSp7RzBmN
         MQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OtWwAgOtAe4D9GgVae0thKZfJlP6oFxQeQXK4rT/p2g=;
        b=l/f2KGnydOPqGmttqmXqTLrFA58LKW7ddnfutN/6D9CiorKrg72lAeLw17ZVBgkRLa
         F0OkF1nqeDuKiyAiocjfxeop5GUgRrOT/HRiZp4cwOyG50rn/CZhTj8KOnrDy6xjWwKW
         OefNxV3M23m3UC2abogK0O/vUzeiXHUpxmvmtSV12Q7KEToE0FUyPmZmNVybUYJ/F1pv
         dV9nwanFPIJrH+lk72a5DhEufFoja++0YibNmjeRlO+36nqBPDrHlsvSqCCObX6zGm3r
         uv7zEEpDSUjrmTq6/auU1DVKilvCLA9CSyLyXXC5cZgXJWT7gJBiOoetiCoWWCp0NLzA
         L7eg==
X-Gm-Message-State: AOAM531I9cqlOzt345T7MFc4TYGdk8fBuN3cJDzd9HVFgSPK8rSTxDle
        D0JsWi8Pvv+c+YGSVK4+IDyW1g==
X-Google-Smtp-Source: ABdhPJzqRRDvFDR4H4MEd+k7XfQs6k0bUDJ5/jafY6LedNgN4q2V6yM8zs8NkNapBPZlshIUFOqtJw==
X-Received: by 2002:a17:902:7083:: with SMTP id z3mr5916460plk.133.1644472226931;
        Wed, 09 Feb 2022 21:50:26 -0800 (PST)
Received: from localhost.localdomain ([122.179.114.46])
        by smtp.gmail.com with ESMTPSA id s32sm15192270pfw.80.2022.02.09.21.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 21:50:26 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc:     Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvm-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Subject: [PATCH v11 1/8] RISC-V: Enable CPU_IDLE drivers
Date:   Thu, 10 Feb 2022 11:19:40 +0530
Message-Id: <20220210054947.170134-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210054947.170134-1-apatel@ventanamicro.com>
References: <20220210054947.170134-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup.patel@wdc.com>

We force select CPU_PM and provide asm/cpuidle.h so that we can
use CPU IDLE drivers for Linux RISC-V kernel.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Signed-off-by: Anup Patel <apatel@vetanamicro.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig                |  7 +++++++
 arch/riscv/configs/defconfig      |  1 +
 arch/riscv/configs/rv32_defconfig |  1 +
 arch/riscv/include/asm/cpuidle.h  | 24 ++++++++++++++++++++++++
 arch/riscv/kernel/process.c       |  3 ++-
 5 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/cpuidle.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5adcbd9b5e88..76976d12b463 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -46,6 +46,7 @@ config RISCV
 	select CLONE_BACKWARDS
 	select CLINT_TIMER if !MMU
 	select COMMON_CLK
+	select CPU_PM if CPU_IDLE
 	select EDAC_SUPPORT
 	select GENERIC_ARCH_TOPOLOGY if SMP
 	select GENERIC_ATOMIC64 if !64BIT
@@ -547,4 +548,10 @@ source "kernel/power/Kconfig"
 
 endmenu
 
+menu "CPU Power Management"
+
+source "drivers/cpuidle/Kconfig"
+
+endmenu
+
 source "arch/riscv/kvm/Kconfig"
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index f120fcc43d0a..a5e0482a4969 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -20,6 +20,7 @@ CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
+CONFIG_CPU_IDLE=y
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
 CONFIG_JUMP_LABEL=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 8b56a7f1eb06..d1b87db54d68 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -20,6 +20,7 @@ CONFIG_SOC_VIRT=y
 CONFIG_ARCH_RV32I=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
+CONFIG_CPU_IDLE=y
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
 CONFIG_JUMP_LABEL=y
diff --git a/arch/riscv/include/asm/cpuidle.h b/arch/riscv/include/asm/cpuidle.h
new file mode 100644
index 000000000000..71fdc607d4bc
--- /dev/null
+++ b/arch/riscv/include/asm/cpuidle.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021 Allwinner Ltd
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ */
+
+#ifndef _ASM_RISCV_CPUIDLE_H
+#define _ASM_RISCV_CPUIDLE_H
+
+#include <asm/barrier.h>
+#include <asm/processor.h>
+
+static inline void cpu_do_idle(void)
+{
+	/*
+	 * Add mb() here to ensure that all
+	 * IO/MEM accesses are completed prior
+	 * to entering WFI.
+	 */
+	mb();
+	wait_for_interrupt();
+}
+
+#endif
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 03ac3aa611f5..504b496787aa 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -23,6 +23,7 @@
 #include <asm/string.h>
 #include <asm/switch_to.h>
 #include <asm/thread_info.h>
+#include <asm/cpuidle.h>
 
 register unsigned long gp_in_global __asm__("gp");
 
@@ -37,7 +38,7 @@ extern asmlinkage void ret_from_kernel_thread(void);
 
 void arch_cpu_idle(void)
 {
-	wait_for_interrupt();
+	cpu_do_idle();
 	raw_local_irq_enable();
 }
 
-- 
2.25.1

