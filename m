Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186B34F484F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379867AbiDEVf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447357AbiDEPqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:46:20 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72920985AE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:21:16 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id x17-20020adfbb51000000b002060ff71a3bso1390836wrg.22
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Hszu94VumpRyr0badDtcfvajy1SNOqO2jgDbf5Z0Nps=;
        b=qY0N8pmWaAFou+ddSatPmLwRkgrEK8HfEjjNY9XwuXpbTrYXjHbBKu4R4yRmUmBXRm
         iEP9ODp0DEXN5VfZiCQOXvgkE2NkUBBQzTaSLWBcc5/u6Jw+JQ3ljnwcet/XJTW2xw2z
         2iQnrtyxQaDF08KV8U42xehWTIXuLFn1p3LOroreAxq89OlfsUbRiT8xi/bmBh/b6hkc
         WjM9buKc1uEAGnlXsbNj8BtvgMWqnfpId0YpPeEGpl+tHSEXXlD7ZdOD78KkKNNbYsD0
         5BR5mVpn0Xf3flXizQKT0kycGyAWpumWsd2Mzg0T4UVtHZYzHVP6vP6qFp2QlFQ1pj1B
         aO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Hszu94VumpRyr0badDtcfvajy1SNOqO2jgDbf5Z0Nps=;
        b=E9qo6fHd4ox3dzLmRmrtqv9FmfxfySVtXGUyWoOI1Ly+frnuDAxQXl8qJHg57RPAfx
         JyIFdKlbrTPjyXfEYJewNU2P3uYIKQoF82BPK5/b4pcNcD8yDHjoCgDstUY6K0b9bBKg
         IdoZbkGBr9iIzXBRnJqJvG0SPQ5g+mlnSa5vJ6DCu2iOsZDD+Qq1gR6HiZXSuSCkJIpj
         Iear24awd08Q0YDEWeaaOTvur4FfY7fDPX5NDoguhvQNvgBQYRvpEUjWY7H8amGWpPvA
         IQ6jL6FSwZaWeuwjbIiaf3ooXcgCtBXzp5qAbn/2wn+1hGdxOatiBSk73I/N0aJ3CJDh
         cXXQ==
X-Gm-Message-State: AOAM532RnBccuFpzzzeCHKUps3vR40VopwKyCw2cV0HGYn1roSByEqc+
        bmTnicPRl5S/7XGMcnS2EZGG4NFwmbVh7rc5wT4=
X-Google-Smtp-Source: ABdhPJwRBdDJvU4AC+1Sku8Povz+T97wxBKdUdU/7yJd6akYPxtZjUzFK5tch5XSP182VdIbxVKZJvPCXzLBBmxmQ7I=
X-Received: from sene.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:27c4])
 (user=sebastianene job=sendgmr) by 2002:a7b:c5d0:0:b0:355:482a:6f44 with SMTP
 id n16-20020a7bc5d0000000b00355482a6f44mr3294190wmk.58.1649168474859; Tue, 05
 Apr 2022 07:21:14 -0700 (PDT)
Date:   Tue,  5 Apr 2022 14:19:55 +0000
In-Reply-To: <20220405141954.1489782-1-sebastianene@google.com>
Message-Id: <20220405141954.1489782-3-sebastianene@google.com>
Mime-Version: 1.0
References: <20220405141954.1489782-1-sebastianene@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH 2/2] watchdog: Add a mechanism to detect stalls on guest vCPUs
From:   Sebastian Ene <sebastianene@google.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, will@kernel.org,
        qperret@google.com, maz@kernel.org,
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

This patch adds support for a virtual watchdog which relies on the
per-cpu hrtimers to pet at regular intervals.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 drivers/watchdog/Kconfig  |   8 ++
 drivers/watchdog/Makefile |   1 +
 drivers/watchdog/vm-wdt.c | 215 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 224 insertions(+)
 create mode 100644 drivers/watchdog/vm-wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 01ce3f41cc21..3304d128484e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -351,6 +351,14 @@ config SL28CPLD_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called sl28cpld_wdt.
 
+config VM_WATCHDOG
+	tristate "Virtual Machine Watchdog"
+	select LOCKUP_DETECTOR
+	help
+	  Detect CPU locks on the virtual machine.
+	  To compile this driver as a module, choose M here: the
+	  module will be called vm-wdt.
+
 # ALPHA Architecture
 
 # ARM Architecture
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 071a2e50be98..73206cbc3835 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -227,3 +227,4 @@ obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
 obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
 obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
 obj-$(CONFIG_SL28CPLD_WATCHDOG) += sl28cpld_wdt.o
+obj-$(CONFIG_VM_WATCHDOG) += vm-wdt.o
diff --git a/drivers/watchdog/vm-wdt.c b/drivers/watchdog/vm-wdt.c
new file mode 100644
index 000000000000..ea4351754645
--- /dev/null
+++ b/drivers/watchdog/vm-wdt.c
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
2.35.1.1094.g7c7d902a7c-goog

