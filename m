Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEFC51F912
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbiEIJgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbiEIJPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:15:30 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EE01ED5AE
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:11:36 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id k35-20020a05600c1ca300b003946a9764baso5764809wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 02:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZD9kdQIM+CwsMzB+WVnVeIEy2ZkVhF9VUvPdvKJv1e0=;
        b=fJ4M+VOqbVM61DAJXLOTcjsNA+HUP8W1BL6oZkQapctBS2iB+D4l/b8vDNs/Oa5a6o
         EgOAA1LSDFk5zJziEk96Yv/qYZleffodvmCXowwDi0jlipDfCD8xgqQtvlGsmoR2egs5
         PQOQ8B6Q19mZFqn/Osaud20kD0nmmEXjGoenYvu8T0NxMaEhd73ytx9o5NcqrkZoDwVX
         Hb8rYwvCmtBPbX72MleSI4d+wE/fwULDR7A+JbC7yLG+RGHP1avaftlDdLHrt8NOCns2
         61WHZbBAjgJH+lZzYvE0eE6+XxI/TQWJH91y2SrJ2IIf9/7sQVYFqnmMHKOv2zLeOXMb
         8YOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZD9kdQIM+CwsMzB+WVnVeIEy2ZkVhF9VUvPdvKJv1e0=;
        b=DTHFPTmSOwvvOmLNTA0azojdW6+hElNVtMmW9jZg177i4FO19Zpb/iW7OxeJXPdaR/
         f2FJN47mgff8yoowPo6ovJFrqxXt2duHLd1+iR9VnLxlHQ/qmtFqxBSmYAjblnVVrPfV
         b+tdXrO9xcaPtvaBWtizhmNX8+aM44e65aKN8ovbece/533ytlu1K1hF1B29vH7OTDBB
         9KsF+k38Vl7crtcYhgvzlZh+ocYB7n7Ko3xwA4X7PHJMtwmyBrKNzjvUa34bjXamZmb6
         O3zPwRoLHmid9dMbURRtmwL23h9uP3pgXrjYdnerXkC4cFWl+R7G3BsBM7XqSfyDPy+h
         PmAw==
X-Gm-Message-State: AOAM531QdWbDBcvIzXWjOf4wAeANtM06UmqHwaBj9lgNjlACoKc0ZiI8
        aZXgStHOrq2vEbQHwL1H90g6Oy8KQowY3+bYnqA=
X-Google-Smtp-Source: ABdhPJzhFJyKTg32v3D8CN944iEcSBwPT1IBPzsL/n5uuA5hsFatEYoFGlh39HmUXV4WjP//mIty8RSarAkfePalg3g=
X-Received: from sene.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:27c4])
 (user=sebastianene job=sendgmr) by 2002:adf:ed86:0:b0:20a:db50:1b1b with SMTP
 id c6-20020adfed86000000b0020adb501b1bmr13418964wro.506.1652087494951; Mon,
 09 May 2022 02:11:34 -0700 (PDT)
Date:   Mon,  9 May 2022 09:11:05 +0000
In-Reply-To: <20220509091103.2220604-1-sebastianene@google.com>
Message-Id: <20220509091103.2220604-3-sebastianene@google.com>
Mime-Version: 1.0
References: <20220509091103.2220604-1-sebastianene@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH v5 2/2] misc: Add a mechanism to detect stalls on guest vCPUs
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver creates per-cpu hrtimers which are required to do the
periodic 'pet' operation. On a conventional watchdog-core driver, the
userspace is responsible for delivering the 'pet' events by writing to
the particular /dev/watchdogN node. In this case we require a strong
thread affinity to be able to account for lost time on a per vCPU and
because of this, the driver does not use the kernel API for watchdog devices.

This part of the driver is the 'frontend' which is reponsible for
delivering the periodic 'pet' events, configuring the virtual peripheral
and listening for cpu hotplug events. The other part of the driver
handles the peripheral emulation and this part accounts for lost time by
looking at the /proc/{}/task/{}/stat entries and is located here:
https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 drivers/misc/Kconfig               |  12 ++
 drivers/misc/Makefile              |   1 +
 drivers/misc/vcpu_stall_detector.c | 218 +++++++++++++++++++++++++++++
 3 files changed, 231 insertions(+)
 create mode 100644 drivers/misc/vcpu_stall_detector.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 41d2bb0ae23a..9b3cb5dfd5a7 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -483,6 +483,18 @@ config OPEN_DICE
 
 	  If unsure, say N.
 
+config VCPU_STALL_DETECTOR
+	tristate "VCPU stall detector"
+	select LOCKUP_DETECTOR
+	help
+	  Detect CPU locks on the virtual machine. This driver relies on the
+	  hrtimers which are CPU-binded to do the 'pet' operation. When a vCPU
+	  has to do a 'pet', it exits the guest through MMIO write and the
+	  backend driver takes into account the lost ticks for this particular
+	  CPU.
+	  To compile this driver as a module, choose M here: the
+	  module will be called vcpu_stall_detector.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 70e800e9127f..2be8542616dd 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
 obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
 obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
+obj-$(CONFIG_VCPU_STALL_DETECTOR)	+= vcpu_stall_detector.o
\ No newline at end of file
diff --git a/drivers/misc/vcpu_stall_detector.c b/drivers/misc/vcpu_stall_detector.c
new file mode 100644
index 000000000000..e36ee734f8b3
--- /dev/null
+++ b/drivers/misc/vcpu_stall_detector.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// VCPU stall detector.
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
+#define REG_STATUS		(0x00)
+#define REG_LOAD_CNT		(0x04)
+#define REG_CURRENT_CNT		(0x08)
+#define REG_CLOCK_FREQ_HZ	(0x0C)
+#define REG_LEN			(0x10)
+
+#define DEFAULT_CLOCK_HZ	(10)
+#define DEFAULT_TIMEOT_SEC	(8)
+
+struct vm_stall_detect_s {
+	void __iomem *membase;
+	u32 clock_freq;
+	u32 expiration_sec;
+	u32 ping_timeout_ms;
+	struct hrtimer per_cpu_hrtimer;
+	struct platform_device *dev;
+};
+
+#define vcpu_stall_detect_reg_write(stall_detect, reg, value)	\
+	iowrite32((value), (stall_detect)->membase + (reg))
+#define vcpu_stall_detect_reg_read(stall_detect, reg)		\
+	io32read((stall_detect)->membase + (reg))
+
+static struct platform_device *virt_dev;
+
+static enum hrtimer_restart
+vcpu_stall_detect_timer_fn(struct hrtimer *hrtimer)
+{
+	struct vm_stall_detect_s *cpu_stall_detect;
+	u32 ticks;
+
+	cpu_stall_detect = container_of(hrtimer, struct vm_stall_detect_s,
+					per_cpu_hrtimer);
+	ticks = cpu_stall_detect->clock_freq *
+		cpu_stall_detect->expiration_sec;
+	vcpu_stall_detect_reg_write(cpu_stall_detect, REG_LOAD_CNT, ticks);
+	hrtimer_forward_now(hrtimer,
+			    ms_to_ktime(cpu_stall_detect->ping_timeout_ms));
+
+	return HRTIMER_RESTART;
+}
+
+static void vcpu_stall_detect_start(void *arg)
+{
+	u32 ticks;
+	struct vm_stall_detect_s *cpu_stall_detect = arg;
+	struct hrtimer *hrtimer = &cpu_stall_detect->per_cpu_hrtimer;
+
+	vcpu_stall_detect_reg_write(cpu_stall_detect, REG_CLOCK_FREQ_HZ,
+			cpu_stall_detect->clock_freq);
+
+	/* Compute the number of ticks required for the stall detector counter
+	 * register based on the internal clock frequency and the timeout
+	 * value given from the device tree.
+	 */
+	ticks = cpu_stall_detect->clock_freq *
+		cpu_stall_detect->expiration_sec;
+	vcpu_stall_detect_reg_write(cpu_stall_detect, REG_LOAD_CNT, ticks);
+
+	/* Enable the internal clock and start the stall detector */
+	vcpu_stall_detect_reg_write(cpu_stall_detect, REG_STATUS, 1);
+
+	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer->function = vcpu_stall_detect_timer_fn;
+	hrtimer_start(hrtimer, ms_to_ktime(cpu_stall_detect->ping_timeout_ms),
+		      HRTIMER_MODE_REL_PINNED);
+}
+
+static void vcpu_stall_detect_stop(void *arg)
+{
+	struct vm_stall_detect_s *cpu_stall_detect = arg;
+	struct hrtimer *hrtimer = &cpu_stall_detect->per_cpu_hrtimer;
+
+	hrtimer_cancel(hrtimer);
+
+	/* Disable the stall detector */
+	vcpu_stall_detect_reg_write(cpu_stall_detect, REG_STATUS, 0);
+}
+
+static int start_stall_detector_on_cpu(unsigned int cpu)
+{
+	struct vm_stall_detect_s *vm_stall_detect;
+
+	vm_stall_detect = platform_get_drvdata(virt_dev);
+	vcpu_stall_detect_start(this_cpu_ptr(vm_stall_detect));
+	return 0;
+}
+
+static int stop_stall_detector_on_cpu(unsigned int cpu)
+{
+	struct vm_stall_detect_s *vm_stall_detect;
+
+	vm_stall_detect = platform_get_drvdata(virt_dev);
+	vcpu_stall_detect_stop(this_cpu_ptr(vm_stall_detect));
+	return 0;
+}
+
+static int vcpu_stall_detect_probe(struct platform_device *dev)
+{
+	int cpu, ret, err;
+	void __iomem *membase;
+	struct resource *r;
+	struct vm_stall_detect_s *vm_stall_detect;
+	u32 stall_detect_clock, stall_detect_timeout_sec = 0;
+
+	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (r == NULL)
+		return -ENOENT;
+
+	vm_stall_detect = alloc_percpu(typeof(struct vm_stall_detect_s));
+	if (!vm_stall_detect)
+		return -ENOMEM;
+
+	membase = ioremap(r->start, resource_size(r));
+	if (!membase) {
+		ret = -ENXIO;
+		goto err_withmem;
+	}
+
+	virt_dev = dev;
+	platform_set_drvdata(dev, vm_stall_detect);
+	if (of_property_read_u32(dev->dev.of_node, "clock-frequency",
+				 &stall_detect_clock))
+		stall_detect_clock = DEFAULT_CLOCK_HZ;
+
+	if (of_property_read_u32(dev->dev.of_node, "timeout-sec",
+				 &stall_detect_timeout_sec))
+		stall_detect_timeout_sec = DEFAULT_TIMEOT_SEC;
+
+	for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask) {
+		struct vm_stall_detect_s *cpu_stall_detect;
+
+		cpu_stall_detect = per_cpu_ptr(vm_stall_detect, cpu);
+		cpu_stall_detect->membase = membase + cpu * REG_LEN;
+		cpu_stall_detect->clock_freq = stall_detect_clock;
+		cpu_stall_detect->expiration_sec = stall_detect_timeout_sec;
+		cpu_stall_detect->ping_timeout_ms = stall_detect_timeout_sec *
+			MSEC_PER_SEC / 2;
+		smp_call_function_single(cpu, vcpu_stall_detect_start,
+					 cpu_stall_detect, true);
+	}
+
+	err = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					"virt/vcpu_stall_detector:online",
+					start_stall_detector_on_cpu,
+					stop_stall_detector_on_cpu);
+	if (err < 0) {
+		dev_warn(&dev->dev, "failed to install cpu hotplug");
+		ret = err;
+		goto err_withmem;
+	}
+
+	return 0;
+
+err_withmem:
+	free_percpu(vm_stall_detect);
+	return ret;
+}
+
+static int vcpu_stall_detect_remove(struct platform_device *dev)
+{
+	int cpu;
+	struct vm_stall_detect_s *vm_stall_detect = platform_get_drvdata(dev);
+
+	for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask) {
+		struct vm_stall_detect_s *cpu_stall_detect;
+
+		cpu_stall_detect = per_cpu_ptr(vm_stall_detect, cpu);
+		smp_call_function_single(cpu, vcpu_stall_detect_stop,
+					 cpu_stall_detect, true);
+	}
+
+	free_percpu(vm_stall_detect);
+	return 0;
+}
+
+static const struct of_device_id vcpu_stall_detect_of_match[] = {
+	{ .compatible = "qemu,vcpu-stall-detector", },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, vcpu_stall_detector_of_match);
+
+static struct platform_driver vcpu_stall_detect_driver = {
+	.probe  = vcpu_stall_detect_probe,
+	.remove = vcpu_stall_detect_remove,
+	.driver = {
+		.name           = KBUILD_MODNAME,
+		.of_match_table = vcpu_stall_detect_of_match,
+	},
+};
+
+module_platform_driver(vcpu_stall_detect_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sebastian Ene <sebastianene@google.com>");
+MODULE_DESCRIPTION("VCPU stall detector");
-- 
2.36.0.512.ge40c2bad7a-goog

