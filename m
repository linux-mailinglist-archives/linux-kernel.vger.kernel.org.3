Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EB747A4A8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 06:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhLTFhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 00:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbhLTFhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 00:37:33 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFF7C06173F;
        Sun, 19 Dec 2021 21:37:32 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id m1so6691365pfk.8;
        Sun, 19 Dec 2021 21:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/A4FxTGuXFwYz/xsUZ22sXeXxiNGABemQ9DKbnTDmTw=;
        b=dpGAbpvd53zkq4WoupKR689xs7nAz5NJUzjk62aO/jr+VD2H0O10IKRRF5s51aI0Ye
         CHYKf8gjabtUuAlcaYurruAi4qvYPEiXXHH4lsv6RzVhQ0GkcepNsqj2H5uTAbZrMoEa
         RtMPsA+7TdalIFsgBbifB7iq5x1N8PT5Yv0Q/VVF2OI0t5UYS/XZs9vBqtYAGWaleFfN
         nturIKgCqQeSTpODpy4H8wSTHRDvuMH6S3fGeFsU0/F8NsfXlihwJB0UjAc0l8/FweT8
         2LdGRMaPP94Tlg5JuDu/tcFL47l6/NdWdRw9PyjDT6dhVLrjpufMslw+YNavteNagUei
         rRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/A4FxTGuXFwYz/xsUZ22sXeXxiNGABemQ9DKbnTDmTw=;
        b=12Tq7lU3+SymvD6fysdKH2VuLcyiSJ54e0xx92rfwMP4HqFoi2y0BDgcuNnAKqduhw
         ealVIuXjuzuWxD7rA2S/0R0Ywotek2YXTsUtPDHlvCPUhbtQ/TKLj0IKsbtuZ2B0/zCn
         7yKcI1UbcbVR3SxcyHgC9wpn4coxNmhPzJgQKB3i8tMld//b5s0+gtPTRUnyHX1K/Sj1
         c157FEQmdOhFil396Goa+gPTSvi/xoESWep7/IvfAXOVcXfafbx0RWcty/U6OFUc1T9r
         +7tpQ/vU955B8bJ6RbRRjLkWuhP7laUBgnJ7QdtLFcN5cU1Xi3TzHNXDfefJUMa/fkRV
         Aymg==
X-Gm-Message-State: AOAM531gifbZDcS0tzzJKPVGPV51bG5HXOqZUq74tHvsnOluxZCHDFw5
        b7ATizqg/0lDCBnwf7jza3o=
X-Google-Smtp-Source: ABdhPJyyi+pgRGxbuMODVunil6Ewn3yDkmTV+Y+z08p4EJnMNtxuVX2C5TVb0yxql/1wwotw4/2UgQ==
X-Received: by 2002:a63:81c3:: with SMTP id t186mr13590212pgd.150.1639978652250;
        Sun, 19 Dec 2021 21:37:32 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id d3sm7491501pfv.192.2021.12.19.21.37.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Dec 2021 21:37:31 -0800 (PST)
From:   Edwin Chiu <edwinchiu0505tw@gmail.com>
To:     robh+dt@kernel.org, edwin.chiu@sunplus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org
Cc:     Edwin Chiu <edwinchiu0505tw@gmail.com>
Subject: [PATCH v2 2/2] cpuidle:sunplus:create cpuidle driver for sunplus sp7021
Date:   Mon, 20 Dec 2021 13:37:32 +0800
Message-Id: <6092f5f372851e2d6bf12b4b23209558038b9fda.1639971376.git.edwinchiu0505tw@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1639971376.git.edwinchiu0505tw@gmail.com>
References: <cover.1639971376.git.edwinchiu0505tw@gmail.com>
In-Reply-To: <cover.1639971376.git.edwinchiu0505tw@gmail.com>
References: <cover.1639971376.git.edwinchiu0505tw@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create cpuidle driver for sunplus sp7021 chip

Signed-off-by: Edwin Chiu <edwinchiu0505tw@gmail.com>
---
Changes in v2
 - Rearrangement #include sequence
 - Change // to /*~*/
 - Align author email address to same as sob

 MAINTAINERS                                   |   4 +
 drivers/cpuidle/Kconfig.arm                   |   7 +
 drivers/cpuidle/Makefile                      |   1 +
 drivers/cpuidle/cpuidle-sunplus.c             | 180 ++++++++++++++++++++++++++
 include/linux/platform_data/cpuidle-sunplus.h |  13 ++
 5 files changed, 205 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-sunplus.c
 create mode 100644 include/linux/platform_data/cpuidle-sunplus.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 41957c7..c5eab79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17949,6 +17949,10 @@ SUNPLUS CPUIDLE DRIVER
 M:	Edwin Chiu <edwinchiu0505tw@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
+F:	drivers/cpuidle/Kconfig.arm
+F:	drivers/cpuidle/Makefile
+F:	drivers/cpuidle/cpuidle-sunplus.c
+F:	include/linux/platform_data/cpuidle-sunplus.h
 
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 334f83e..ad9956c 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -117,3 +117,10 @@ config ARM_QCOM_SPM_CPUIDLE
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
index 0000000..88671e6
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-sunplus.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ARM/ARM64 generic CPU idle driver.
+ *
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
+static struct cpuidle_driver sp7021_idle_driver __initdata = {
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
+static const struct of_device_id sp7021_idle_state_match[] __initconst = {
+	{ .compatible = "arm,idle-state",
+		.data = sp7021_enter_idle_state },
+	{ },
+};
+
+/*
+ * arm_idle_init - Initializes arm cpuidle driver
+ *
+ * Initializes arm cpuidle driver for all CPUs, if any CPU fails
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
+	/*
+	 * Call arch CPU operations in order to initialize
+	 * idle states suspend back-end specific data
+	 */
+	for_each_possible_cpu(cpu) {
+		/*
+		 * Skip the cpuidle device initialization if the reported
+		 * failure is a HW misconfiguration/breakage (-ENXIO)
+		 */
+		if (ret == -ENXIO)
+			continue;
+
+		if (ret) {
+			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
+			goto out_fail;
+		}
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
index 0000000..d63efad
--- /dev/null
+++ b/include/linux/platform_data/cpuidle-sunplus.h
@@ -0,0 +1,13 @@
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
+extern int cpu_v7_do_idle(void);
+
+#endif
-- 
2.7.4

