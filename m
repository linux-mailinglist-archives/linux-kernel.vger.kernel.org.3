Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076E64AB668
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbiBGIPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244821AbiBGILJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:11:09 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D11CC043181;
        Mon,  7 Feb 2022 00:11:08 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id t4-20020a17090a510400b001b8c4a6cd5dso1382146pjh.5;
        Mon, 07 Feb 2022 00:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=tJgN6ObjRlhMw53PvowYY4iEyegOVrJ3AMYQ6grvdY4=;
        b=ldQIe6EreZOjeqnFx6oLhPtcwhuLtam4pk7scApN42kzuAgQcPCQqr6RpLtfuUMjH2
         RbfHeFVMv5IId1lb3RbI5TR97KyAu7BXlZPrhq34T6/a++uaoCBgvYSsn2BLjLUE/WME
         G8XzG81OD6PZrF3CTICf5+V+Mh4NWTp5p2xQQJhqzOv2KYF7sB11UabFUNw3ecfV5AUm
         92FWBjZ5MIBwCL5+ejnA72YVMemMZ8l5lwg9m4DBbPRwu5D2ZEvZOgN0qOq1UVfJbruq
         Tur5k1TAFViumBluJFxLhhP/E5rdnaRA6yJ4puYnmAF/EM8CUIMbJVq0MhQx30VaajkT
         Lvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tJgN6ObjRlhMw53PvowYY4iEyegOVrJ3AMYQ6grvdY4=;
        b=kcOaxNuc1VMatjVSXSq7hTXmjo2Yl7jDc+2q0qR/7UWCBY3QTctezrmfBSlcfSMmYI
         CLlHwuAy6pfLhRiROW2L1jvZFLBgz9Dq6TIhWDq17WjXgLZ0iZUF24Q3UBnXdiMtsJO/
         lD0cCqlBLTgM2qk1b+U4VUcgVNT6wl1u6kbhr/P/tZ7Rw14S0qQIW3hq9TOPfsHz+6SW
         Qim6IZFl5meZVqkiul9/jK2ux4+wsbFuTJBWQnz4K4hDeo2WIJVyPEvk6r4LyX4LynAd
         sGC5jvPdxhzv8lm3QdIzFONMwmaPju0WgOcT7wz+onuPxYxR8IjznbLDiidTCXnwl2ee
         q1qw==
X-Gm-Message-State: AOAM533aGeRZLAruRtreXdlPA5dkAzq6vQN62mK9VjL03JbQviCjYh1y
        XgeYgOMAy56/NXSbiRADOt4MGBwSFENJyA==
X-Google-Smtp-Source: ABdhPJxMKzDOHc259OFdHM9FFHRa/gM9gK9wbbVCxDHO9X1S52d3iKTAP7XSGxV2x/L5BC9TvwdgCg==
X-Received: by 2002:a17:90a:4291:: with SMTP id p17mr12579893pjg.126.1644221467833;
        Mon, 07 Feb 2022 00:11:07 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h6sm11774502pfk.110.2022.02.07.00.11.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Feb 2022 00:11:07 -0800 (PST)
From:   Edwin Chiu <edwinchiu0505tw@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        edwin.chiu@sunplus.com
Cc:     Edwin Chiu <edwinchiu0505tw@gmail.com>
Subject: [PATCH v4] cpuidle: sunplus: Create cpuidle driver for sunplus sp7021
Date:   Mon,  7 Feb 2022 16:11:15 +0800
Message-Id: <957d882222d218b62fe3fb7a069e2f7952afc5be.1644218105.git.edwinchiu0505tw@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1644218105.git.edwinchiu0505tw@gmail.com>
References: <cover.1644218105.git.edwinchiu0505tw@gmail.com>
In-Reply-To: <cover.1644218105.git.edwinchiu0505tw@gmail.com>
References: <cover.1644218105.git.edwinchiu0505tw@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create cpuidle driver for sunplus sp7021 chip

Signed-off-by: Edwin Chiu <edwinchiu0505tw@gmail.com>
---
Changes in v3
 - Rearrangement #include sequence
 - Change remark style to /*~*/
 - Align author email address to same as sob
 - Optimal code
Changes in v4
 - According Rob Herringrobh's comment
   There is no need for this binding.
   Just wanting a different driver is not a reason for a duplicate schema.
   So remove yaml file and submit driver again.

 MAINTAINERS                                   |   8 ++
 drivers/cpuidle/Kconfig.arm                   |   7 ++
 drivers/cpuidle/Makefile                      |   1 +
 drivers/cpuidle/cpuidle-sunplus.c             | 167 ++++++++++++++++++++++++++
 include/linux/platform_data/cpuidle-sunplus.h |  19 +++
 5 files changed, 202 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-sunplus.c
 create mode 100644 include/linux/platform_data/cpuidle-sunplus.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e0dca8f..a938a58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18252,6 +18252,14 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS CPUIDLE DRIVER
+M:	Edwin Chiu <edwinchiu0505tw@gmail.com>
+S:	Maintained
+F:	drivers/cpuidle/Kconfig.arm
+F:	drivers/cpuidle/Makefile
+F:	drivers/cpuidle/cpuidle-sunplus.c
+F:	include/linux/platform_data/cpuidle-sunplus.h
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 15d6c46..fd921c5 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -118,3 +118,10 @@ config ARM_QCOM_SPM_CPUIDLE
 	  The Subsystem Power Manager (SPM) controls low power modes for the
 	  CPU and L2 cores. It interface with various system drivers to put
 	  the cores in low power modes.
+
+config ARM_SUNPLUS_CPUIDLE
+	bool "CPU Idle Driver For SUNPLUS SoCs"
+	depends on !ARM64
+	select DT_IDLE_STATES
+	help
+	  Select this to enable cpuidle on SP7021 processors.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 26bbc5e..0a020d1 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle-psci.o
 obj-$(CONFIG_ARM_PSCI_CPUIDLE_DOMAIN)	+= cpuidle-psci-domain.o
 obj-$(CONFIG_ARM_TEGRA_CPUIDLE)		+= cpuidle-tegra.o
 obj-$(CONFIG_ARM_QCOM_SPM_CPUIDLE)	+= cpuidle-qcom-spm.o
+obj-$(CONFIG_ARM_SUNPLUS_CPUIDLE)		+= cpuidle-sunplus.o
 
 ###############################################################################
 # MIPS drivers
diff --git a/drivers/cpuidle/cpuidle-sunplus.c b/drivers/cpuidle/cpuidle-sunplus.c
new file mode 100644
index 0000000..0e7bf43
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-sunplus.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2011-2014, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2014,2015, Linaro Ltd.
+ *
+ * SAW power controller driver
+ */
+#define pr_fmt(fmt) "CPUidle arm: " fmt
+
+#include <asm/suspend.h>
+#include <linux/cpu_cooling.h>
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/cpu_pm.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/platform_data/cpuidle-sunplus.h>
+
+#include "dt_idle_states.h"
+
+static int sp7021_wfi_finisher(unsigned long flags)
+{
+	cpu_v7_do_idle();   /* idle to WFI */
+
+	return -1;
+}
+
+static int sp7021_enter_idle_state(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int idx)
+{
+	int ret;
+
+  /* if idx=0, call cpu_do_idle() */
+	if (!idx) {
+		cpu_v7_do_idle();
+		return idx;
+	}
+
+	/* if idx>0, call cpu_suspend() */
+	ret = cpu_pm_enter();
+	if (!ret) {
+	/*
+	 * Pass idle state index to cpuidle_suspend which in turn
+	 * will call the CPU ops suspend protocol with idle index as a
+	 * parameter.
+	 */
+		ret = cpu_suspend(idx, sp7021_wfi_finisher);
+	}
+	cpu_pm_exit();
+
+	return ret ? -1:idx;
+}
+
+static struct cpuidle_driver sp7021_idle_driver = {
+	.name = "sp7021_idle",
+	.owner = THIS_MODULE,
+	/*
+	 * State at index 0 is standby wfi and considered standard
+	 * on all ARM platforms. If in some platforms simple wfi
+	 * can't be used as "state 0", DT bindings must be implemented
+	 * to work around this issue and allow installing a special
+	 * handler for idle state index 0.
+	 */
+	.states[0] = {
+		.enter                  = sp7021_enter_idle_state,
+		.exit_latency           = 1,
+		.target_residency       = 1,
+		.power_usage		= UINT_MAX,
+		.name                   = "WFI",
+		.desc                   = "ARM WFI",
+	}
+};
+
+static const struct of_device_id sp7021_idle_state_match[] = {
+	{ .compatible = "sunplus,sp7021-idle-state",
+		.data = sp7021_enter_idle_state },
+	{ },
+};
+
+/*
+ * sp7021_idle_init - Initializes sp7021 cpuidle driver
+ *
+ * Initializes sp7021 cpuidle driver for all CPUs, if any CPU fails
+ * to register cpuidle driver then rollback to cancel all CPUs
+ * registration.
+ */
+static int __init sp7021_idle_init(void)
+{
+	int cpu, ret;
+	struct cpuidle_driver *drv;
+	struct cpuidle_device *dev;
+
+	drv = kmemdup(&sp7021_idle_driver, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	drv->cpumask = (struct cpumask *)cpumask_of(cpu);
+	/*
+	 * Initialize idle states data, starting at index 1.  This
+	 * driver is DT only, if no DT idle states are detected (ret
+	 * == 0) let the driver initialization fail accordingly since
+	 * there is no reason to initialize the idle driver if only
+	 * wfi is supported.
+	 */
+	ret = dt_init_idle_driver(drv, sp7021_idle_state_match, 1);
+	if (ret <= 0)
+		return ret ? : -ENODEV;
+
+	ret = cpuidle_register_driver(drv);
+	if (ret) {
+		pr_err("Failed to register cpuidle driver\n");
+		return ret;
+	}
+
+	for_each_possible_cpu(cpu) {
+		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+		if (!dev) {
+			ret = -ENOMEM;
+			goto out_fail;
+		}
+		dev->cpu = cpu;
+
+		ret = cpuidle_register_device(dev);
+		if (ret) {
+			pr_err("Failed to register cpuidle device for CPU %d\n", cpu);
+			kfree(dev);
+			goto out_fail;
+		}
+	}
+
+	return 0;
+
+out_fail:
+	while (--cpu >= 0) {
+		dev = per_cpu(cpuidle_devices, cpu);
+		cpuidle_unregister_device(dev);
+		kfree(dev);
+	}
+	cpuidle_unregister_driver(drv);
+
+	return ret;
+}
+
+static int __init idle_init(void)
+{
+	int ret;
+
+	if (of_machine_is_compatible("sunplus,sp7021-achip")) {
+		sp7021_idle_init();
+		ret = 0;
+	}	else
+		ret = -1;
+
+	if (ret) {
+		pr_err("failed to cpuidle init\n");
+		return ret;
+	}
+
+	return ret;
+}
+device_initcall(idle_init);
+
+MODULE_AUTHOR("Edwin Chiu <edwinchiu0505tw@gmail.com>");
+MODULE_DESCRIPTION("Sunplus sp7021 cpuidle driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_data/cpuidle-sunplus.h b/include/linux/platform_data/cpuidle-sunplus.h
new file mode 100644
index 0000000..bf87682
--- /dev/null
+++ b/include/linux/platform_data/cpuidle-sunplus.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __CPUIDLE_SP7021_H
+#define __CPUIDLE_SP7021_H
+
+struct cpuidle_sp7021_data {
+	int (*cpu23_powerdown)(void);
+	void (*pre_enter_aftr)(void);
+	void (*post_enter_aftr)(void);
+};
+
+extern int cpu_v7_do_idle(void);
+
+#endif
-- 
2.7.4

