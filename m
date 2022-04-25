Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71E050E219
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242198AbiDYNq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242191AbiDYNpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:45:44 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB7B4A3CF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:42:35 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id c125-20020a1c3583000000b0038e3f6e871aso6750208wma.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QDUkzkor6rIG/fum/ZEDdQx1WnuBoE/Wp/SxBYeFJMY=;
        b=Zd7TBBwmHLJV4pk8yXPo4BcyqlnwcEU+4+5iRdnCjDv4TtBGJCnoM7A0pqMEm7XDfe
         uh9CRKnSsA4xfsQvKZ8JC177PEGPoJdktdcExtcJ1HiFXZXaBJyBiahh1RYQmGIh/f/7
         vPJuqbIWx2d5ovYIqUWUEBJJ60yRbrHKQKynkR/1aFMbsEhLaCd/0dS6+fH5EL3HXzxA
         f29gwRM+djKCMYK9ZmhgSuCf+oinCEf9jqv+jSai8WkdNeNlnkiboUE8FcC97qwxdEzq
         MWhIujifCihz26KX4AZeG3z1v29W0JxIYmTrufjldgt/hmlpvWJXfQWtb033Gof9+m6V
         vPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QDUkzkor6rIG/fum/ZEDdQx1WnuBoE/Wp/SxBYeFJMY=;
        b=HtfEv51gk7/XheD7Dg2P3yTTUzM+LuH8312VwsKNu9Vulp9TWpjVUeGlvzEmv2CXli
         YI4KptGMCGygaAM2ZCF+mA7rvEbKpB9KYmz9o+c9tCt5XHXpCxUPvK0+ALCtVArA82JS
         afUTJPw2yrc2gDySYx0cZg5vGCenphODm8Y4H1RaU2+Mq7EVAxt9m7RIheVcWmJezYqX
         xDlt9gjG7j4/EQiZjT+StqVeAoxvuwpD7TMxo76q8/yi3i0iwIoXsz92rI2UhhEjCaX8
         DeVdYhxt3zG9UK7nOwV2Er1J2Kihw1lXJ1n4R3qmFAFBPKsizoZj0KNG8uKxXySj38UX
         5moA==
X-Gm-Message-State: AOAM5325pxXH2RnbzweUogly3y1EW3a+YJ9F23esscHRap4sLnIgFRmJ
        /99ASjiSemVCuXdUAegTH0fFF07xfqiltnfHZL8=
X-Google-Smtp-Source: ABdhPJx9+cCTjMDWkJ55eLyA4L1JsGnVW9FkRCc/bysbWyvvpCDnTEhIp7g5RwOMElR9R+YxdZ2drt5NiH4jlEc9Xvc=
X-Received: from sene.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:27c4])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:19c6:b0:392:88e2:7426 with
 SMTP id u6-20020a05600c19c600b0039288e27426mr16629002wmq.132.1650894153575;
 Mon, 25 Apr 2022 06:42:33 -0700 (PDT)
Date:   Mon, 25 Apr 2022 13:42:07 +0000
In-Reply-To: <20220425134204.149042-1-sebastianene@google.com>
Message-Id: <20220425134204.149042-3-sebastianene@google.com>
Mime-Version: 1.0
References: <20220425134204.149042-1-sebastianene@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 2/2] misc: Add a mechanism to detect stalls on guest vCPUs
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
 drivers/misc/Kconfig  |  12 +++
 drivers/misc/Makefile |   1 +
 drivers/misc/vm-wdt.c | 207 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+)
 create mode 100644 drivers/misc/vm-wdt.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 2b9572a6d114..71c173e3f064 100644
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
+	  has to do a 'pet', it exists the guest through MMIO write and the
+	  backend driver takes into account the lost ticks for this particular
+	  CPU.
+	  To compile this driver as a module, choose M here: the
+	  module will be called vm-wdt.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 2ec634354cf5..fa9d644da5db 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -59,3 +59,4 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
 obj-$(CONFIG_UID_SYS_STATS)	+= uid_sys_stats.o
 obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
+obj-$(CONFIG_VM_WATCHDOG)	+= vm-wdt.o
\ No newline at end of file
diff --git a/drivers/misc/vm-wdt.c b/drivers/misc/vm-wdt.c
new file mode 100644
index 000000000000..0c4df2fefbb9
--- /dev/null
+++ b/drivers/misc/vm-wdt.c
@@ -0,0 +1,207 @@
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
+#define DRV_NAME			"vm_wdt"
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
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

