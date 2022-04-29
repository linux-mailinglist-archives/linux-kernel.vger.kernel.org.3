Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE983514445
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355760AbiD2Iep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355757AbiD2Ief (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:34:35 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985D63CFE6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:31:16 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id l7-20020adfbd87000000b0020ac0a4d23dso2808201wrh.17
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RP91vYhqIYHQnNu9QWAoHufJJOi6siSzhw8cxqCyxIg=;
        b=i9xn73+F3K7Eg9KFVxUMimtm55paJB9OTA5vsPfJwjHb7E3mYKYLvUnap8odvXi1tG
         /a6MPb1khVYtAVsFxIkF7v9hRLnm0wuzVGDdp+qB5/oqR6IIVkkQNCMM3a7RwIyXOhDY
         aTzwzOSBjtVwg0+rfwftRx+1uUTJOZ8w84T9yKE2TcqLVbPFvRfx3xb3snO7FkC3EDaa
         Y6B7683clv0A7YXe2oM4ExsT0HCbwz8+0PcQSZNpV+UHRegpt2cWBtVzUq3aSU222K4m
         i4qVxu0Ba8+z6gWddKIu3TY9LAxnTz09Zucayjr4JhFhnWKKcB3l/NR6xqnoMNNrlm30
         pSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RP91vYhqIYHQnNu9QWAoHufJJOi6siSzhw8cxqCyxIg=;
        b=TA8We+ft78ogATTGnJeDFsuFdju/tcEQpmLwU3tiTUbFcKz/Rp+ohYjKNHUWlqxvB2
         J80kBIcfjyTVWX8nugY9Dyl1U1fwYubgM/0Nawzuw4JvJ5aNKXmXhvjFYr3hBJCr6GeG
         1W6PX8ZQhS2kHYdhkiZAlSZUrUtqVJkRF/aVad8oTO0M6FvHHYPH2OzwEOz+GkXW48y3
         4pVjg+p2lWgfVTcc/Y7l2Ar6llaSA0W6bqhxjlYCMgYXdw/sQeO4JALMLWBpBTaXhI7h
         U9JdT9hVXstdhCtFsaiP2DmgU2IvScXAmcCkdBnKkbxeodyjRct6wNK1VQ2oCVtBtV/T
         PULg==
X-Gm-Message-State: AOAM533yBZOPEWZgzvaebhCmozCzfCrLMS3REjfVFfn5udpKqTnfTi92
        hTqWuICZ6Csbh00zw+SQMMtIv8RgFDai9Ax6dVc=
X-Google-Smtp-Source: ABdhPJwKylHY2CDeOBiVHq3yxum76ZiO+gXreTWpdxJLE6SOpksOtqt92dz9/4WFoK/VAHMzxZm07hAzIMkscAhz+4c=
X-Received: from sene.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:27c4])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:a44:b0:38e:3ce3:3148 with
 SMTP id c4-20020a05600c0a4400b0038e3ce33148mr2118690wmq.26.1651221075269;
 Fri, 29 Apr 2022 01:31:15 -0700 (PDT)
Date:   Fri, 29 Apr 2022 08:30:33 +0000
In-Reply-To: <20220429083030.3241640-1-sebastianene@google.com>
Message-Id: <20220429083030.3241640-3-sebastianene@google.com>
Mime-Version: 1.0
References: <20220429083030.3241640-1-sebastianene@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v4 2/2] misc: Add a mechanism to detect stalls on guest vCPUs
From:   Sebastian Ene <sebastianene@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, qperret@google.com,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Ene <sebastianene@google.com>
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

This driver creates per-cpu hrtimers which are required to do the
periodic 'pet' operation. On a conventional watchdog-core driver, the
userspace is responsible for delivering the 'pet' events by writing to
the particular /dev/watchdogN node. In this case we require a strong
thread affinity to be able to account for lost time on a per vCPU.

This part of the driver is the 'frontend' which is reponsible for
delivering the periodic 'pet' events, configuring the virtual peripheral
and listening for cpu hotplug events. The other part of the driver
handles the peripheral emulation and this part accounts for lost time by
looking at the /proc/{}/task/{}/stat entries and is located here:
https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 drivers/misc/Kconfig       |  12 +++
 drivers/misc/Makefile      |   1 +
 drivers/misc/vm-watchdog.c | 206 +++++++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+)
 create mode 100644 drivers/misc/vm-watchdog.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 2b9572a6d114..26c3a99e269c 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -493,6 +493,18 @@ config OPEN_DICE
 
 	  If unsure, say N.
 
+config VM_WATCHDOG
+	tristate "Virtual Machine Watchdog"
+	select LOCKUP_DETECTOR
+	help
+	  Detect CPU locks on the virtual machine. This driver relies on the
+	  hrtimers which are CPU-binded to do the 'pet' operation. When a vCPU
+	  has to do a 'pet', it exits the guest through MMIO write and the
+	  backend driver takes into account the lost ticks for this particular
+	  CPU.
+	  To compile this driver as a module, choose M here: the
+	  module will be called vm-wdt.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 2ec634354cf5..9ea562d0c98b 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -59,3 +59,4 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
 obj-$(CONFIG_UID_SYS_STATS)	+= uid_sys_stats.o
 obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
+obj-$(CONFIG_VM_WATCHDOG)	+= vm-watchdog.o
\ No newline at end of file
diff --git a/drivers/misc/vm-watchdog.c b/drivers/misc/vm-watchdog.c
new file mode 100644
index 000000000000..1d344e9a84a8
--- /dev/null
+++ b/drivers/misc/vm-watchdog.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Virtual watchdog driver.
+//  Copyright (C) Google, 2022
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
+	struct vm_wdt_s *cpu_wdt = arg;
+	struct hrtimer *hrtimer = &cpu_wdt->per_cpu_hrtimer;
+
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
+	struct vm_wdt_s *cpu_wdt = arg;
+	struct hrtimer *hrtimer = &cpu_wdt->per_cpu_hrtimer;
+
+	hrtimer_cancel(hrtimer);
+
+	/* Disable the watchdog */
+	vmwdt_reg_write(cpu_wdt, VMWDT_REG_STATUS, 0);
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
+	if (of_property_read_u32(dev->dev.of_node, "clock-frequency",
+				 &wdt_clock))
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
+		dev_warn(&dev->dev, "failed to install cpu hotplug");
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
+		.name           = KBUILD_MODNAME,
+		.of_match_table = vmwdt_of_match,
+	},
+};
+
+module_platform_driver(vmwdt_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sebastian Ene <sebastianene@google.com>");
+MODULE_DESCRIPTION("Virtual watchdog driver");
-- 
2.36.0.464.gb9c8b46e94-goog

