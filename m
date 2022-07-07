Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF5A56A735
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 17:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiGGPnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 11:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbiGGPnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 11:43:11 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A5B2C673
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 08:43:10 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id t4-20020a1c7704000000b003a2cfaeca37so729391wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cUG17wB24XJemhJjvkGQJpANFVsR/f5pjYaHJTYznQ0=;
        b=ow45Q6eYfDUgDGx4H/u1jeG2mPMw/5k4P9Sum+FPEd2U5MTm0bOnM0k45eaNZrTFkL
         K2OJCsB0Ja6VeaHt12s7WBnq4lgUms1kBIFQDFLZ7rT3Eo1Kp24i7WYDkkZj2FdoO3lQ
         thLSnyGGgAZDKjtHDZCkBPXL5fxgpPm9o6tPtWAXzE9aOVx85CnD2rQ0l+NkG7gAZQuY
         pOprXcj0w2TKdHhaC/KRe6PcqFk73B+uSMYtJz6zEixgTAbbL16Zqbnh5jWupChAHyOA
         Egvw5Qcrb4vi9HcXCgAYDHxg6zlxu0Xam0y2YbiAJjX+WD8ij/3Js0Gx3wxuwD+WrrOi
         sjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cUG17wB24XJemhJjvkGQJpANFVsR/f5pjYaHJTYznQ0=;
        b=BS4b+t6UwzBV6ykWCti+wi5mTQyNJfjcF7Hln7UsGItPPj5yazB8qMlsvM1rckD0jj
         GeJFiBev6uNTNlDu0KMqIRn0Nqx6AYHb1Rb/eCGEvnFeJSjbp/CUEoJc+avhKosTXvdt
         M2oZUIc3UK8wlRZE0FwGHHI5ZD4GH/if6bTYCjMOHCTtEu3U3zmdPUcvtq72gC41xLNx
         8D5eD9TozfHRGWUx5u7SpuofnU1/GC40iukSYOWQRCjVEE8sl2ankgU8aucMD4CzPJFd
         sbDo0l2llstI9ZSUrhtyB0VU+KNGP7Y6q4xf8wndDGmDkH+Ywvhy5Bv9VI9QfTHmE5kt
         +9TA==
X-Gm-Message-State: AJIora8vxaLt8RzG37SfB53OCPTdbFuggzyVHnahlUtcdwezTwYe5PIS
        3d5fXYFjxPR2rmyfvtcNu3aM6MNyr8DsbUzbBQE=
X-Google-Smtp-Source: AGRyM1us13/4iz3UffPQ1aaJwfWPgv+CLWeLrjQDkLcItUy4DUalkCFBA3i3fmA/whhws1GeElZf8F75nnW0dFFW2dk=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:a02:b0:39d:bdf8:a4f4 with
 SMTP id z2-20020a05600c0a0200b0039dbdf8a4f4mr5359549wmp.201.1657208588912;
 Thu, 07 Jul 2022 08:43:08 -0700 (PDT)
Date:   Thu,  7 Jul 2022 15:42:27 +0000
In-Reply-To: <20220707154226.1478674-1-sebastianene@google.com>
Message-Id: <20220707154226.1478674-3-sebastianene@google.com>
Mime-Version: 1.0
References: <20220707154226.1478674-1-sebastianene@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v10 2/2] misc: Add a mechanism to detect stalls on guest vCPUs
From:   Sebastian Ene <sebastianene@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, vdonnefort@google.com,
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
thread affinity to be able to account for lost time on a per vCPU.

This part of the driver is the 'frontend' which is reponsible for
delivering the periodic 'pet' events, configuring the virtual peripheral
and listening for cpu hotplug events. The other part of the driver is
an emulated MMIO device which is part of the KVM virtual machine
monitor and this part accounts for lost time by looking at the
/proc/{}/task/{}/stat entries.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 drivers/misc/Kconfig               |  14 ++
 drivers/misc/Makefile              |   1 +
 drivers/misc/vcpu_stall_detector.c | 209 +++++++++++++++++++++++++++++
 3 files changed, 224 insertions(+)
 create mode 100644 drivers/misc/vcpu_stall_detector.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 41d2bb0ae23a..d5b7610459f7 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -483,6 +483,20 @@ config OPEN_DICE
 
 	  If unsure, say N.
 
+config VCPU_STALL_DETECTOR
+	tristate "Guest vCPU stall detector"
+	select LOCKUP_DETECTOR
+	depends on OF && HAS_IOMEM
+	help
+	  When this driver is bound inside a KVM guest, it will
+	  periodically "pet" an MMIO stall detector device from each vCPU
+	  and allow the host to detect vCPU stalls.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called vcpu_stall_detector.
+
+	  If you do not intend to run this kernel as a guest, say N.
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
index 000000000000..692a03b1657a
--- /dev/null
+++ b/drivers/misc/vcpu_stall_detector.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
+#define VCPU_STALL_REG_STATUS		(0x00)
+#define VCPU_STALL_REG_LOAD_CNT		(0x04)
+#define VCPU_STALL_REG_CURRENT_CNT	(0x08)
+#define VCPU_STALL_REG_CLOCK_FREQ_HZ	(0x0C)
+#define VCPU_STALL_REG_LEN		(0x10)
+
+#define VCPU_STALL_DEFAULT_CLOCK_HZ	(10)
+#define VCPU_STALL_DEFAULT_TIMEOUT_SEC	(8)
+
+struct vcpu_stall_detect_config_s {
+	u32 clock_freq_hz;
+	u32 stall_timeout_sec;
+
+	void __iomem *membase;
+	struct platform_device *dev;
+	enum cpuhp_state hp_online;
+};
+
+struct vcpu_stall_priv_s {
+	struct hrtimer vcpu_hrtimer;
+	bool is_initialized;
+};
+
+/* The vcpu stall configuration structure which applies to all the CPUs */
+static struct vcpu_stall_detect_config_s vcpu_stall_config;
+
+#define vcpu_stall_reg_write(vcpu, reg, value)				\
+	writel_relaxed((value),						\
+		       (void __iomem *)(vcpu_stall_config.membase +	\
+		       (vcpu) * VCPU_STALL_REG_LEN + (reg)))
+
+
+static struct vcpu_stall_priv_s __percpu *vcpu_stall_detectors;
+
+static enum hrtimer_restart
+vcpu_stall_detect_timer_fn(struct hrtimer *hrtimer)
+{
+	u32 ticks, ping_timeout_ms;
+
+	/* Reload the stall detector counter register every
+	 * `ping_timeout_ms` to prevent the virtual device
+	 * from decrementing it to 0. The virtual device decrements this
+	 * register at 'clock_freq_hz' frequency.
+	 */
+	ticks = vcpu_stall_config.clock_freq_hz *
+		vcpu_stall_config.stall_timeout_sec;
+	vcpu_stall_reg_write(smp_processor_id(),
+			     VCPU_STALL_REG_LOAD_CNT, ticks);
+
+	ping_timeout_ms = vcpu_stall_config.stall_timeout_sec *
+			  MSEC_PER_SEC / 2;
+	hrtimer_forward_now(hrtimer,
+			    ms_to_ktime(ping_timeout_ms));
+
+	return HRTIMER_RESTART;
+}
+
+static int start_stall_detector_cpu(unsigned int cpu)
+{
+	u32 ticks, ping_timeout_ms;
+	struct vcpu_stall_priv_s *vcpu_stall_detector =
+		this_cpu_ptr(vcpu_stall_detectors);
+	struct hrtimer *vcpu_hrtimer = &vcpu_stall_detector->vcpu_hrtimer;
+
+	vcpu_stall_reg_write(cpu, VCPU_STALL_REG_CLOCK_FREQ_HZ,
+			     vcpu_stall_config.clock_freq_hz);
+
+	/* Compute the number of ticks required for the stall detector
+	 * counter register based on the internal clock frequency and the
+	 * timeout value given from the device tree.
+	 */
+	ticks = vcpu_stall_config.clock_freq_hz *
+		vcpu_stall_config.stall_timeout_sec;
+	vcpu_stall_reg_write(cpu, VCPU_STALL_REG_LOAD_CNT, ticks);
+
+	/* Enable the internal clock and start the stall detector */
+	vcpu_stall_reg_write(cpu, VCPU_STALL_REG_STATUS, 1);
+
+	/* Pet the stall detector at half of its expiration timeout
+	 * to prevent spurious resets.
+	 */
+	ping_timeout_ms = vcpu_stall_config.stall_timeout_sec *
+			  MSEC_PER_SEC / 2;
+
+	hrtimer_init(vcpu_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	vcpu_hrtimer->function = vcpu_stall_detect_timer_fn;
+	vcpu_stall_detector->is_initialized = true;
+
+	hrtimer_start(vcpu_hrtimer, ms_to_ktime(ping_timeout_ms),
+		      HRTIMER_MODE_REL_PINNED);
+
+	return 0;
+}
+
+static int stop_stall_detector_cpu(unsigned int cpu)
+{
+	struct vcpu_stall_priv_s *vcpu_stall_detector =
+		per_cpu_ptr(vcpu_stall_detectors, cpu);
+
+	if (!vcpu_stall_detector->is_initialized)
+		return 0;
+
+	/* Disable the stall detector for the current CPU */
+	hrtimer_cancel(&vcpu_stall_detector->vcpu_hrtimer);
+	vcpu_stall_reg_write(cpu, VCPU_STALL_REG_STATUS, 0);
+	vcpu_stall_detector->is_initialized = false;
+
+	return 0;
+}
+
+static int vcpu_stall_detect_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct resource *r;
+	void __iomem *membase;
+
+	vcpu_stall_detectors = devm_alloc_percpu(&pdev->dev,
+					  typeof(struct vcpu_stall_priv_s));
+	if (!vcpu_stall_detectors)
+		return -ENOMEM;
+
+	membase = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
+	if (IS_ERR(membase)) {
+		dev_err(&pdev->dev, "Failed to get memory resource\n");
+		return PTR_ERR(membase);
+	}
+
+	vcpu_stall_config.membase = membase;
+	if (of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+				 &vcpu_stall_config.clock_freq_hz)) {
+		vcpu_stall_config.clock_freq_hz =
+			VCPU_STALL_DEFAULT_CLOCK_HZ;
+	}
+
+	if (of_property_read_u32(pdev->dev.of_node, "timeout-sec",
+				 &vcpu_stall_config.stall_timeout_sec)) {
+		vcpu_stall_config.stall_timeout_sec =
+			VCPU_STALL_DEFAULT_TIMEOUT_SEC;
+	}
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				"virt/vcpu_stall_detector:online",
+				start_stall_detector_cpu,
+				stop_stall_detector_cpu);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to install cpu hotplug");
+		goto err;
+	}
+
+	vcpu_stall_config.hp_online = ret;
+	return 0;
+err:
+	return ret;
+}
+
+static int vcpu_stall_detect_remove(struct platform_device *pdev)
+{
+	int cpu;
+
+	cpuhp_remove_state(vcpu_stall_config.hp_online);
+
+	for_each_possible_cpu(cpu)
+		stop_stall_detector_cpu(cpu);
+
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
2.37.0.rc0.161.g10f37bed90-goog

