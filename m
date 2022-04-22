Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A985E50B9F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448594AbiDVOXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448649AbiDVOXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:23:11 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C8F48E53
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:20:18 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id y11-20020a7bc18b000000b0038eac019fc0so3795823wmi.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dog+vroB+oUrwQ0X22Zl8MMNzdFUuRAaUXhtZm0NBNE=;
        b=LdtzVGqvEisHV6UNxQ4C9u6ty/Ny89cdxZzTrzQiMPZBHGYVuQqRSjb2OIQ4TTL/1E
         zCEdlPdrLCMGBGOiQQU3/C9Uqb+aD7WskIrAxxW76FWRvLJYg1n3ggyDOeSpMgUoGwxg
         aHLGzijrbMc9PqQxQZfDbc9xVApLRXikVCd5QyBvkkQ7dNWdYNh+31aIgAaIVosWxTcg
         vSQXNqYlsimmU5EpbYDUL0rjqT7qHDefnEOXkFhDmtx8TYpw84OvDHxpvnIa+jYRxYhY
         jqwwtU9xLxL9825A+Og5DCdFO/IEQNrccQadplsInVRZ7nfDUA9wH+DoyOiZEX3T9TWf
         2VRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dog+vroB+oUrwQ0X22Zl8MMNzdFUuRAaUXhtZm0NBNE=;
        b=NAsFu1oe+LryKa7bki5+1PFGnVnCT02ZXnaocO/XvOyWMleL/kuvT1UPLLTRHFdIVQ
         jXwr7XBm1GiHGIsbFGdLMPWEEsUI5l8ntRZAnMZIPs5DPWREEvv42Gtxju4qYq7IcLV+
         ghfK5jEoPLukjRxTNPqKTp6yEn2Fua1aWhs9wI7/lhyPmyeRFN1T/UPtNeSZS/U+6fS8
         +gH+waDqadJN9dU4UcGJ4rUiTPv/aMDy3rLtDCG2EfaN++rofarnVX99ItynFX0hx2GI
         O20Fd6e+nmWBY7U6L7yxxi+SNJTvX6P6BQzT6C1SbbOmHa6C1s0OeiCt4pNGq32u4WZP
         9cdg==
X-Gm-Message-State: AOAM531DOTZqCQXBnwPdX//46IHDb/5wVxon9eNyJLtjUpareiF8P3Yw
        CwfUQQqiQiHRrOt1ZzkB3stewQBkGucVfAf++Tg=
X-Google-Smtp-Source: ABdhPJwlC/Vm1dYtdajJnBr53VZKxrH4isoAT7nYGDkYal+4ZbeoOrzUh9Uw9sGDOwtqpE9Zcx2v160I6lQSjw8v8q8=
X-Received: from sene.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:27c4])
 (user=sebastianene job=sendgmr) by 2002:a1c:acc4:0:b0:392:9dd4:fbcc with SMTP
 id v187-20020a1cacc4000000b003929dd4fbccmr4313905wme.78.1650637216654; Fri,
 22 Apr 2022 07:20:16 -0700 (PDT)
Date:   Fri, 22 Apr 2022 14:19:50 +0000
In-Reply-To: <20220422141949.3456505-1-sebastianene@google.com>
Message-Id: <20220422141949.3456505-3-sebastianene@google.com>
Mime-Version: 1.0
References: <20220422141949.3456505-1-sebastianene@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH  v2 2/2] misc: Add a mechanism to detect stalls on guest vCPUs
From:   Sebastian Ene <sebastianene@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, qperret@google.com,
        Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for a virtual watchdog which relies on the
per-cpu hrtimers to pet at regular intervals.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 drivers/misc/Kconfig  |   8 ++
 drivers/misc/Makefile |   1 +
 drivers/misc/vm-wdt.c | 215 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 224 insertions(+)
 create mode 100644 drivers/misc/vm-wdt.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 2b9572a6d114..0e710149ff95 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -493,6 +493,14 @@ config OPEN_DICE
 
 	  If unsure, say N.
 
+config VM_WATCHDOG
+	tristate "Virtual Machine Watchdog"
+	select LOCKUP_DETECTOR
+	help
+	  Detect CPU locks on the virtual machine.
+	  To compile this driver as a module, choose M here: the
+	  module will be called vm-wdt.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 2ec634354cf5..868e28d01b75 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -59,3 +59,4 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
 obj-$(CONFIG_UID_SYS_STATS)	+= uid_sys_stats.o
 obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
+obj-$(CONFIG_VM_WATCHDOG) += vm-wdt.o
\ No newline at end of file
diff --git a/drivers/misc/vm-wdt.c b/drivers/misc/vm-wdt.c
new file mode 100644
index 000000000000..ea4351754645
--- /dev/null
+++ b/drivers/misc/vm-wdt.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Virtual watchdog driver.
+//  Copyright (C) Google, 2022
+
+#define pr_fmt(fmt) "vm-watchdog: " fmt
+
+#include <linux/cpu.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/nmi.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/param.h>
+#include <linux/percpu.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define DRV_NAME			"vm_wdt"
+#define DRV_VERSION			"1.0"
+
+#define VMWDT_REG_STATUS		(0x00)
+#define VMWDT_REG_LOAD_CNT		(0x04)
+#define VMWDT_REG_CURRENT_CNT		(0x08)
+#define VMWDT_REG_CLOCK_FREQ_HZ		(0x0C)
+#define VMWDT_REG_LEN			(0x10)
+
+#define VMWDT_DEFAULT_CLOCK_HZ		(10)
+#define VMWDT_DEFAULT_TIMEOT_SEC	(8)
+
+struct vm_wdt_s {
+	void __iomem *membase;
+	u32 clock_freq;
+	u32 expiration_sec;
+	u32 ping_timeout_ms;
+	struct hrtimer per_cpu_hrtimer;
+	struct platform_device *dev;
+};
+
+#define vmwdt_reg_write(wdt, reg, value)	\
+	iowrite32((value), (wdt)->membase + (reg))
+#define vmwdt_reg_read(wdt, reg)		\
+	io32read((wdt)->membase + (reg))
+
+static struct platform_device *virt_dev;
+
+static enum hrtimer_restart vmwdt_timer_fn(struct hrtimer *hrtimer)
+{
+	struct vm_wdt_s *cpu_wdt;
+	u32 ticks;
+
+	cpu_wdt = container_of(hrtimer, struct vm_wdt_s, per_cpu_hrtimer);
+	ticks = cpu_wdt->clock_freq * cpu_wdt->expiration_sec;
+	vmwdt_reg_write(cpu_wdt, VMWDT_REG_LOAD_CNT, ticks);
+	hrtimer_forward_now(hrtimer, ms_to_ktime(cpu_wdt->ping_timeout_ms));
+
+	return HRTIMER_RESTART;
+}
+
+static void vmwdt_start(void *arg)
+{
+	u32 ticks;
+	int cpu = smp_processor_id();
+	struct vm_wdt_s *cpu_wdt = arg;
+	struct hrtimer *hrtimer = &cpu_wdt->per_cpu_hrtimer;
+
+	pr_info("cpu %u vmwdt start\n", cpu);
+	vmwdt_reg_write(cpu_wdt, VMWDT_REG_CLOCK_FREQ_HZ,
+			cpu_wdt->clock_freq);
+
+	/* Compute the number of ticks required for the watchdog counter
+	 * register based on the internal clock frequency and the watchdog
+	 * timeout given from the device tree.
+	 */
+	ticks = cpu_wdt->clock_freq * cpu_wdt->expiration_sec;
+	vmwdt_reg_write(cpu_wdt, VMWDT_REG_LOAD_CNT, ticks);
+
+	/* Enable the internal clock and start the watchdog */
+	vmwdt_reg_write(cpu_wdt, VMWDT_REG_STATUS, 1);
+
+	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer->function = vmwdt_timer_fn;
+	hrtimer_start(hrtimer, ms_to_ktime(cpu_wdt->ping_timeout_ms),
+		      HRTIMER_MODE_REL_PINNED);
+}
+
+static void vmwdt_stop(void *arg)
+{
+	int cpu = smp_processor_id();
+	struct vm_wdt_s *cpu_wdt = arg;
+	struct hrtimer *hrtimer = &cpu_wdt->per_cpu_hrtimer;
+
+	hrtimer_cancel(hrtimer);
+
+	/* Disable the watchdog */
+	vmwdt_reg_write(cpu_wdt, VMWDT_REG_STATUS, 0);
+	pr_info("cpu %d vmwdt stop\n", cpu);
+}
+
+static int start_watchdog_on_cpu(unsigned int cpu)
+{
+	struct vm_wdt_s *vm_wdt = platform_get_drvdata(virt_dev);
+
+	vmwdt_start(this_cpu_ptr(vm_wdt));
+	return 0;
+}
+
+static int stop_watchdog_on_cpu(unsigned int cpu)
+{
+	struct vm_wdt_s *vm_wdt = platform_get_drvdata(virt_dev);
+
+	vmwdt_stop(this_cpu_ptr(vm_wdt));
+	return 0;
+}
+
+static int vmwdt_probe(struct platform_device *dev)
+{
+	int cpu, ret, err;
+	void __iomem *membase;
+	struct resource *r;
+	struct vm_wdt_s *vm_wdt;
+	u32 wdt_clock, wdt_timeout_sec = 0;
+
+	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (r == NULL)
+		return -ENOENT;
+
+	vm_wdt = alloc_percpu(typeof(struct vm_wdt_s));
+	if (!vm_wdt)
+		return -ENOMEM;
+
+	membase = ioremap(r->start, resource_size(r));
+	if (!membase) {
+		ret = -ENXIO;
+		goto err_withmem;
+	}
+
+	virt_dev = dev;
+	platform_set_drvdata(dev, vm_wdt);
+	if (of_property_read_u32(dev->dev.of_node, "clock", &wdt_clock))
+		wdt_clock = VMWDT_DEFAULT_CLOCK_HZ;
+
+	if (of_property_read_u32(dev->dev.of_node, "timeout-sec",
+				 &wdt_timeout_sec))
+		wdt_timeout_sec = VMWDT_DEFAULT_TIMEOT_SEC;
+
+	for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask) {
+		struct vm_wdt_s *cpu_wdt = per_cpu_ptr(vm_wdt, cpu);
+
+		cpu_wdt->membase = membase + cpu * VMWDT_REG_LEN;
+		cpu_wdt->clock_freq = wdt_clock;
+		cpu_wdt->expiration_sec = wdt_timeout_sec;
+		cpu_wdt->ping_timeout_ms = wdt_timeout_sec * MSEC_PER_SEC / 2;
+		smp_call_function_single(cpu, vmwdt_start, cpu_wdt, true);
+	}
+
+	err = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					"virt/watchdog:online",
+					start_watchdog_on_cpu,
+					stop_watchdog_on_cpu);
+	if (err < 0) {
+		pr_warn("could not be initialized");
+		ret = err;
+		goto err_withmem;
+	}
+
+	return 0;
+
+err_withmem:
+	free_percpu(vm_wdt);
+	return ret;
+}
+
+static int vmwdt_remove(struct platform_device *dev)
+{
+	int cpu;
+	struct vm_wdt_s *vm_wdt = platform_get_drvdata(dev);
+
+	for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask) {
+		struct vm_wdt_s *cpu_wdt = per_cpu_ptr(vm_wdt, cpu);
+
+		smp_call_function_single(cpu, vmwdt_stop, cpu_wdt, true);
+	}
+
+	free_percpu(vm_wdt);
+	return 0;
+}
+
+static const struct of_device_id vmwdt_of_match[] = {
+	{ .compatible = "qemu,vm-watchdog", },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, vm_watchdog_of_match);
+
+static struct platform_driver vmwdt_driver = {
+	.probe  = vmwdt_probe,
+	.remove = vmwdt_remove,
+	.driver = {
+		.name           = DRV_NAME,
+		.of_match_table = vmwdt_of_match,
+	},
+};
+
+module_platform_driver(vmwdt_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sebastian Ene <sebastianene@google.com>");
+MODULE_DESCRIPTION("Virtual watchdog driver");
+MODULE_VERSION(DRV_VERSION);
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

