Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790E956D7AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiGKIRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiGKIRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:17:38 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3218D1EAF0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:17:36 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id g7-20020a056402424700b0043ac55ccf15so2844137edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+GHfMLDFK8bfwJGB626YxLWW3h2mbaU76LOieZsYGqo=;
        b=d+48pRZc/2vAvI1ReeyEbhj/CeO6Ktx8KPLAgeleJDQrCeSngvO0YGzieybIQE7cKq
         3DZU+xJaDTI88sDdC10mkpscxos8tAkbg3doMgFTESPa4T75YBhYR5re/kvxuQW5/dEW
         TGLGUSCY2/gmgDUs5K5zaxjZAKLhS8vMOEw+HAsRmjpP2nW8XYI93NHYqZlysJz6iG9j
         3RC6l5rMqVDDy5Wl6MYCVj9ku++0+yJAtJtEolXSTrpT4Wlgzey+ibMNIC2v85pJB8fK
         40aPhc0cEpKalxZxtBIk4kH9fRmfQbELg1wuugPPXirvX0ciZeyu2M3ONQ1iYIwshPA/
         bmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+GHfMLDFK8bfwJGB626YxLWW3h2mbaU76LOieZsYGqo=;
        b=vm5WHg8Qc89WdhCH+2op3tnHtecyqQmbZoZXGKruwup5It8W8ej2jZSFcot9tF1pNe
         DSmGvCuuScb7Q4FZK1Z2NVW2SOocMpIDLx1ttOx1uggcz8K/8SGTtrOxQ4HHnBKAVk96
         RtPuvpogaDTnGheQdR0bbRkyuajiVp87n6/IGgfon0jkahXlCE+EvQs0L/wQVV/SvpcV
         WcJ/EGv8EiXt6XWDHyg0QeVB3LhkqsNwQ+QpFUe37QTRKFL/T9ifqt9IpqcwlgGMmwb+
         yY4NNk2SFi8m8DnIoaOTP6sBhm23nnWnltQwYCo1RlU1c8BbfefipQaWJRuAd9sBys+T
         75Dw==
X-Gm-Message-State: AJIora8kML8xa0IuwNtNWkQ41DbHG0Mlqvw3vxy5y4AX2aJD7VnxKVUp
        Hfr2uJOXpsF+7qLP7FHmlVOtcgBmUCy2eQ8bcs0=
X-Google-Smtp-Source: AGRyM1snNObffPrl9v9sV8MAEz5bioqpHlW73G8umtinzQ+Kud6iNV1MhXmbaetiUtVKaVtK7azKZyYu9JvXWzaV8NM=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a17:907:2722:b0:72b:6d79:1a46 with
 SMTP id d2-20020a170907272200b0072b6d791a46mr37077ejl.713.1657527454693; Mon,
 11 Jul 2022 01:17:34 -0700 (PDT)
Date:   Mon, 11 Jul 2022 08:17:20 +0000
In-Reply-To: <20220711081720.2870509-1-sebastianene@google.com>
Message-Id: <20220711081720.2870509-3-sebastianene@google.com>
Mime-Version: 1.0
References: <20220711081720.2870509-1-sebastianene@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v12 2/2] misc: Add a mechanism to detect stalls on guest vCPUs
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 drivers/misc/Kconfig               |  13 ++
 drivers/misc/Makefile              |   1 +
 drivers/misc/vcpu_stall_detector.c | 223 +++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+)
 create mode 100644 drivers/misc/vcpu_stall_detector.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 41d2bb0ae23a..94e9fb4cdd76 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -483,6 +483,19 @@ config OPEN_DICE
 
 	  If unsure, say N.
 
+config VCPU_STALL_DETECTOR
+	tristate "Guest vCPU stall detector"
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
index 000000000000..53b5506080e1
--- /dev/null
+++ b/drivers/misc/vcpu_stall_detector.c
@@ -0,0 +1,223 @@
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
+#define VCPU_STALL_MAX_CLOCK_HZ		(100)
+#define VCPU_STALL_DEFAULT_TIMEOUT_SEC	(8)
+#define VCPU_STALL_MAX_TIMEOUT_SEC	(600)
+
+struct vcpu_stall_detect_config {
+	u32 clock_freq_hz;
+	u32 stall_timeout_sec;
+
+	void __iomem *membase;
+	struct platform_device *dev;
+	enum cpuhp_state hp_online;
+};
+
+struct vcpu_stall_priv {
+	struct hrtimer vcpu_hrtimer;
+	bool is_initialized;
+};
+
+/* The vcpu stall configuration structure which applies to all the CPUs */
+static struct vcpu_stall_detect_config vcpu_stall_config;
+
+#define vcpu_stall_reg_write(vcpu, reg, value)				\
+	writel_relaxed((value),						\
+		       (void __iomem *)(vcpu_stall_config.membase +	\
+		       (vcpu) * VCPU_STALL_REG_LEN + (reg)))
+
+
+static struct vcpu_stall_priv __percpu *vcpu_stall_detectors;
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
+	struct vcpu_stall_priv *vcpu_stall_detector =
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
+	struct vcpu_stall_priv *vcpu_stall_detector =
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
+	u32 clock_freq_hz = VCPU_STALL_DEFAULT_CLOCK_HZ;
+	u32 stall_timeout_sec = VCPU_STALL_DEFAULT_TIMEOUT_SEC;
+	struct device_node *np = pdev->dev.of_node;
+
+	vcpu_stall_detectors = devm_alloc_percpu(&pdev->dev,
+						 typeof(struct vcpu_stall_priv));
+	if (!vcpu_stall_detectors)
+		return -ENOMEM;
+
+	membase = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
+	if (IS_ERR(membase)) {
+		dev_err(&pdev->dev, "Failed to get memory resource\n");
+		return PTR_ERR(membase);
+	}
+
+	if (!of_property_read_u32(np, "clock-frequency", &clock_freq_hz)) {
+		if (!(clock_freq_hz > 0 &&
+		      clock_freq_hz < VCPU_STALL_MAX_CLOCK_HZ)) {
+			dev_warn(&pdev->dev, "clk out of range\n");
+			clock_freq_hz = VCPU_STALL_DEFAULT_CLOCK_HZ;
+		}
+	}
+
+	if (!of_property_read_u32(np, "timeout-sec", &stall_timeout_sec)) {
+		if (!(stall_timeout_sec > 0 &&
+		      stall_timeout_sec < VCPU_STALL_MAX_TIMEOUT_SEC)) {
+			dev_warn(&pdev->dev, "stall timeout out of range\n");
+			stall_timeout_sec = VCPU_STALL_DEFAULT_TIMEOUT_SEC;
+		}
+	}
+
+	vcpu_stall_config = (struct vcpu_stall_detect_config) {
+		.membase		= membase,
+		.clock_freq_hz		= clock_freq_hz,
+		.stall_timeout_sec	= stall_timeout_sec
+	};
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

