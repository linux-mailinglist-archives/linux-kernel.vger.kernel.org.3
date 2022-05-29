Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9A653721F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 20:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiE2SNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 14:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiE2SNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 14:13:46 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C994C703EB;
        Sun, 29 May 2022 11:13:43 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DD05722249;
        Sun, 29 May 2022 20:13:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1653848022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EysWfF5qeT/K60N+isMImxlnThFx/sfgBlMy+ORwwxM=;
        b=hMFaKIjr+amijehDh8+e3iiiUcT+64o3AWh6bUUMHCsy7hmNrVceUQtadCNY18+KlxVRDO
        Eyu+EBG5ik/SUjaDQJSiEECotnP7YX6qEGY2Qm/8NDcrKSaGI8c5bn62AlD5zImuUMChud
        DTcf/Vgo/r8uxyFOIqBlVH1f2RIAook=
From:   Michael Walle <michael@walle.cc>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH 2/2] arm64: cpuidle: remove generic cpuidle support
Date:   Sun, 29 May 2022 20:13:29 +0200
Message-Id: <20220529181329.2345722-3-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220529181329.2345722-1-michael@walle.cc>
References: <20220529181329.2345722-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 support of the generic ARM cpuidle driver was removed. This
let us remove all support code for it.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/include/asm/cpu_ops.h |  9 ---------
 arch/arm64/include/asm/cpuidle.h | 15 ---------------
 arch/arm64/kernel/cpuidle.c      | 29 -----------------------------
 3 files changed, 53 deletions(-)

diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
index e95c4df83911..a444c8915e88 100644
--- a/arch/arm64/include/asm/cpu_ops.h
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -31,11 +31,6 @@
  * @cpu_die:	Makes a cpu leave the kernel. Must not fail. Called from the
  *		cpu being killed.
  * @cpu_kill:  Ensures a cpu has left the kernel. Called from another cpu.
- * @cpu_init_idle: Reads any data necessary to initialize CPU idle states for
- *		   a proposed logical id.
- * @cpu_suspend: Suspends a cpu and saves the required context. May fail owing
- *               to wrong parameters or error conditions. Called from the
- *               CPU being suspended. Must be called with IRQs disabled.
  */
 struct cpu_operations {
 	const char	*name;
@@ -49,10 +44,6 @@ struct cpu_operations {
 	void		(*cpu_die)(unsigned int cpu);
 	int		(*cpu_kill)(unsigned int cpu);
 #endif
-#ifdef CONFIG_CPU_IDLE
-	int		(*cpu_init_idle)(unsigned int);
-	int		(*cpu_suspend)(unsigned long);
-#endif
 };
 
 int __init init_cpu_ops(int cpu);
diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpuidle.h
index 14a19d1141bd..2047713e097d 100644
--- a/arch/arm64/include/asm/cpuidle.h
+++ b/arch/arm64/include/asm/cpuidle.h
@@ -4,21 +4,6 @@
 
 #include <asm/proc-fns.h>
 
-#ifdef CONFIG_CPU_IDLE
-extern int arm_cpuidle_init(unsigned int cpu);
-extern int arm_cpuidle_suspend(int index);
-#else
-static inline int arm_cpuidle_init(unsigned int cpu)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline int arm_cpuidle_suspend(int index)
-{
-	return -EOPNOTSUPP;
-}
-#endif
-
 #ifdef CONFIG_ARM64_PSEUDO_NMI
 #include <asm/arch_gicv3.h>
 
diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index 3006f4324808..4150e308e99c 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -13,35 +13,6 @@
 #include <linux/of_device.h>
 #include <linux/psci.h>
 
-#include <asm/cpuidle.h>
-#include <asm/cpu_ops.h>
-
-int arm_cpuidle_init(unsigned int cpu)
-{
-	const struct cpu_operations *ops = get_cpu_ops(cpu);
-	int ret = -EOPNOTSUPP;
-
-	if (ops && ops->cpu_suspend && ops->cpu_init_idle)
-		ret = ops->cpu_init_idle(cpu);
-
-	return ret;
-}
-
-/**
- * arm_cpuidle_suspend() - function to enter a low-power idle state
- * @index: argument to pass to CPU suspend operations
- *
- * Return: 0 on success, -EOPNOTSUPP if CPU suspend hook not initialized, CPU
- * operations back-end error code otherwise.
- */
-int arm_cpuidle_suspend(int index)
-{
-	int cpu = smp_processor_id();
-	const struct cpu_operations *ops = get_cpu_ops(cpu);
-
-	return ops->cpu_suspend(index);
-}
-
 #ifdef CONFIG_ACPI
 
 #include <acpi/processor.h>
-- 
2.30.2

