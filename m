Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEC554DE29
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359793AbiFPJ2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiFPJ2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:28:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA3212754
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:28:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g132-20020a25db8a000000b00668a2ef6a95so587978ybf.22
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NQnwQSvwb7NdseNmySN9QdeFEDDFwFKxk+b3Dnot5BA=;
        b=MGmIXHBfIi+fxx0MT+7aJuQaTaUkGeyGw9qcec4HJgEXa3u/oXtstbWaCafXAa7BcF
         kqEHZawiRDbnX0+3euUo4o8iN3Zg7S0KQMA249ZRk9YuEz2KcImUozOKAGcHEuvi8Z2r
         SvN9WeMwUwMeedyejqWzw2wwuY7NkCrUPmqUZWgGOdbYzEmbp43kItbiehEhUr3XmMIQ
         NN5uapHzYw+LSZzpFzo0BjJhx4IYMLYg7bLUCj79KJcyv62GJMRNArE5YpOXym1WiW5b
         Q5k0cEKumom+yDXxUlfF2hOc6s2L+EPZ1SpuHY7pDf7WJErhdcuZfmKsqHBAfp5DJf7g
         sHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NQnwQSvwb7NdseNmySN9QdeFEDDFwFKxk+b3Dnot5BA=;
        b=zL0V7avzOEyon1cwMqVHUYQa0aaya+Po1DL8NTT2Ay74QApX/UI23ghiIi3yux/hNz
         MJxrJX2ZjM99QRxuj56E5YPdT4gYQiZBV4cuOXEeORRtROmaaqeMwKK9hlIseoV0S07V
         J2QSXVAwNXwraAyRiNNtHY0DUaNIjCt/kuH5lybSsRCkL5rOSKBmwSHmr/Yid9m33EJJ
         hEuWt+YOLYwKAsEKWL/IfWOUX6tVjVshTvLu4sNZKnUC+jCvPfQKoGaHpUFxy5+GUtZk
         4Iab7nZmOTcGphSpv5el9fsCB0/WF0ggQx5l+LuwCZ7cOcJf6lpXD4f+tA0L1zbCntlN
         rQRg==
X-Gm-Message-State: AJIora8HaJRjl5TZBh9AnKYLDHHEbIk8eIvy1lLXkLEJNbQNalI+fYgZ
        AbefkXe9UgN+9hLuw5nZRpDa8x3DYrWJ7SFbCoo=
X-Google-Smtp-Source: AGRyM1tasORmk5TtoLDYVmZuymc7yszknBZR4DwQYfi0WJN4Ot9tX6pCRNSvvDrKXipkBvy9yAGrC//sKMjbQ2SN0/c=
X-Received: from sene.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:27c4])
 (user=sebastianene job=sendgmr) by 2002:a81:9102:0:b0:317:4e12:7a5b with SMTP
 id i2-20020a819102000000b003174e127a5bmr4506816ywg.262.1655371684399; Thu, 16
 Jun 2022 02:28:04 -0700 (PDT)
Date:   Thu, 16 Jun 2022 09:27:39 +0000
In-Reply-To: <20220616092737.1713667-1-sebastianene@google.com>
Message-Id: <20220616092737.1713667-3-sebastianene@google.com>
Mime-Version: 1.0
References: <20220616092737.1713667-1-sebastianene@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v6 2/2] misc: Add a mechanism to detect stalls on guest vCPUs
From:   Sebastian Ene <sebastianene@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, vdonnefort@google.com,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Ene <sebastianene@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 drivers/misc/Kconfig               |  12 ++
 drivers/misc/Makefile              |   1 +
 drivers/misc/vcpu_stall_detector.c | 222 +++++++++++++++++++++++++++++
 3 files changed, 235 insertions(+)
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
index 000000000000..8b33f04a9719
--- /dev/null
+++ b/drivers/misc/vcpu_stall_detector.c
@@ -0,0 +1,222 @@
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
+	struct vm_stall_detect_s __percpu *vm_stall_detect;
+
+	vm_stall_detect = (struct vm_stall_detect_s __percpu *)
+		platform_get_drvdata(virt_dev);
+	vcpu_stall_detect_start(this_cpu_ptr(vm_stall_detect));
+	return 0;
+}
+
+static int stop_stall_detector_on_cpu(unsigned int cpu)
+{
+	struct vm_stall_detect_s __percpu *vm_stall_detect;
+
+	vm_stall_detect = (struct vm_stall_detect_s __percpu *)
+		platform_get_drvdata(virt_dev);
+	vcpu_stall_detect_stop(this_cpu_ptr(vm_stall_detect));
+	return 0;
+}
+
+static int vcpu_stall_detect_probe(struct platform_device *dev)
+{
+	int cpu, ret, err;
+	void __iomem *membase;
+	struct resource *r;
+	struct vm_stall_detect_s __percpu *vm_stall_detect;
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
+	struct vm_stall_detect_s __percpu *vm_stall_detect;
+
+	vm_stall_detect = (struct vm_stall_detect_s __percpu *)
+		platform_get_drvdata(dev);
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
+MODULE_DEVICE_TABLE(of, vcpu_stall_detect_of_match);
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
2.36.1.476.g0c4daa206d-goog

