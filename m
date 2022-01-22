Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AD64969ED
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 04:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiAVDzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 22:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiAVDzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 22:55:01 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0BDC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 19:55:01 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d12-20020a17090a628c00b001b4f47e2f51so12197038pjj.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 19:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rstih+bCUvI8qAsoOEFphlMMvh1FNlDra3LljL6dx4g=;
        b=b8Np5CfAwmYacAM1cntSktfj9EngIXuFis1GJEPT0s34kMoc3CunPKJvPpOX4KVjIO
         kpNpdKnqFPdScyqiamWBmaaN1v+BBcmYxzh6kqr4gaKW2Ok21LOUl4zNyfEwetj+KaOt
         s81tuSNgNAm8AY/ajc8jPF24UgAX5XYtapmovhqGG7lQGIeuqmld3SaPAvVIVqA2zrxh
         T0UBafQkfkEG+5NSwY6rPD3Luk7cQhlmeiT7EnN2UCUHuhrTQU6WU75TGNm+82VZlym9
         2BBeaL5vf4iNqdOHDVWrUvhZiuavIQqHcuRdSzKcrMw4DF8cL1GJTOLyekbpO8qhXa95
         fSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rstih+bCUvI8qAsoOEFphlMMvh1FNlDra3LljL6dx4g=;
        b=H4o/Az/p9cSCbacnQ9nJY9VrXSuxVyVS5xRRHho0hNtXMr/RB7GQITVqu81RvkTAxl
         +7bmeu1j212Dy8GLsk+/F7lNsq7T0cgoSz2KllPlVDny98YYuNr+o/jA0/x1Jm0QvjK7
         Ndvtm7YTtBKJ+wRnda+BJAuT9qPWcn/mePIEjISpJBvNhSFr0TaP8iKq7OrqgEvlLEpJ
         vjjtTogncAG9hcXV/hlAmzOALHM6BNRE2R/mPtI06laBksb34mE+d38BGgs/i28CyhI1
         Il61frbLWcxpsXlKxQKXmIdtiBizofUrxigiT8GmLx+4LjNbwAy1pBUhNZk0kuBDbxO6
         Y4ww==
X-Gm-Message-State: AOAM532Bs+YAr5dozRtzRfqTYSK5si8ks1plX4PUqfLM9nPn+NP72bYO
        6zFvm9uI1PQhjrtf5TKAZoo=
X-Google-Smtp-Source: ABdhPJwVyZbUIgjV0k63poA6oysZewo8wDokaLYLS/DJqHD4243wcBR59+RF6I/B5WkBMBGSAbFoDQ==
X-Received: by 2002:a17:90a:6782:: with SMTP id o2mr3624424pjj.116.1642823700061;
        Fri, 21 Jan 2022 19:55:00 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a1sm667255pjm.1.2022.01.21.19.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 19:54:59 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] soc: bcm: brcmstb: Added support for PSCI system suspend operations
Date:   Fri, 21 Jan 2022 19:54:20 -0800
Message-Id: <20220122035421.4086618-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122035421.4086618-1-f.fainelli@gmail.com>
References: <20220122035421.4086618-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Broadcom STB system suspend operations which
leverage the standard PSCI functions and uses the
psci_cpu_suspend_enter() operation to power off the system with or
without retention ("echo standby > /sys/power/state").

The system reset path also supports a special "powercycle" mode which
signals to the ARM Trusted Firmware that an external PMIC chip must
force the SoC into a power cycle.

As much as possible extensions were built using the SIP namespace rather
than the standard PSCI namespace, however compatibility with the
standard PSCI implementation is retained when CONFIG_BRCMSTB_PM is not
selected.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/Kconfig           |   4 +-
 drivers/soc/bcm/brcmstb/pm/Makefile       |   1 +
 drivers/soc/bcm/brcmstb/pm/pm-psci.c      | 315 ++++++++++++++++++++++
 include/linux/soc/brcmstb/brcmstb-smccc.h |  84 ++++++
 4 files changed, 402 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soc/bcm/brcmstb/pm/pm-psci.c
 create mode 100644 include/linux/soc/brcmstb/brcmstb-smccc.h

diff --git a/drivers/soc/bcm/brcmstb/Kconfig b/drivers/soc/bcm/brcmstb/Kconfig
index 38e476905d96..a2b31717096e 100644
--- a/drivers/soc/bcm/brcmstb/Kconfig
+++ b/drivers/soc/bcm/brcmstb/Kconfig
@@ -2,8 +2,8 @@
 if SOC_BRCMSTB
 
 config BRCMSTB_PM
-	bool "Support suspend/resume for STB platforms"
-	default y
+	tristate "Support suspend/resume for STB platforms"
+	default ARCH_BRCMSTB || BMIPS_GENERIC
 	depends on PM
 	depends on ARCH_BRCMSTB || BMIPS_GENERIC
 	select ARM_CPU_SUSPEND if ARM
diff --git a/drivers/soc/bcm/brcmstb/pm/Makefile b/drivers/soc/bcm/brcmstb/pm/Makefile
index 86004458260c..4ece53db8937 100644
--- a/drivers/soc/bcm/brcmstb/pm/Makefile
+++ b/drivers/soc/bcm/brcmstb/pm/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_BRCMSTB_PM)	+= pm-psci.o
 ifndef CONFIG_ARM_PSCI_FW
 obj-$(CONFIG_ARM)		+= s2-arm.o pm-arm.o
 AFLAGS_s2-arm.o			:= -march=armv7-a
diff --git a/drivers/soc/bcm/brcmstb/pm/pm-psci.c b/drivers/soc/bcm/brcmstb/pm/pm-psci.c
new file mode 100644
index 000000000000..7ba34d01c2fc
--- /dev/null
+++ b/drivers/soc/bcm/brcmstb/pm/pm-psci.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Broadcom STB PSCI based system wide PM support
+ *
+ * Copyright © 2018-2022 Broadcom
+ */
+
+#define pr_fmt(fmt) "brcmstb-pm-psci: " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/arm-smccc.h>
+#include <linux/panic_notifier.h>
+#include <linux/psci.h>
+#include <linux/suspend.h>
+#include <linux/soc/brcmstb/brcmstb.h>
+#include <linux/soc/brcmstb/brcmstb-smccc.h>
+#include <linux/reboot.h>
+#include <linux/kobject.h>
+
+#include <uapi/linux/psci.h>
+
+#include <asm/suspend.h>
+#include <asm/system_misc.h>
+
+#include "aon_defs.h"
+
+static psci_fn *invoke_psci_fn;
+static bool brcmstb_psci_system_reset2_supported;
+static bool brcmstb_psci_system_suspend_supported;
+static bool brcmstb_psci_cpu_retention = true;
+
+static int brcmstb_psci_integ_region(unsigned long function_id,
+				     unsigned long base,
+				     unsigned long size)
+{
+	unsigned long end;
+
+	if (!size)
+		return -EINVAL;
+
+	end = DIV_ROUND_UP(base + size, SIP_MIN_REGION_SIZE);
+	base /= SIP_MIN_REGION_SIZE;
+	size = end - base;
+
+	return invoke_psci_fn(function_id, base, size, 0);
+}
+
+static int __maybe_unused brcmstb_psci_integ_region_set(unsigned long base,
+							unsigned long size)
+{
+	return brcmstb_psci_integ_region(SIP_FUNC_INTEG_REGION_SET, base, size);
+}
+
+static int __maybe_unused brcmstb_psci_integ_region_del(unsigned long base,
+							unsigned long size)
+{
+	return brcmstb_psci_integ_region(SIP_FUNC_INTEG_REGION_DEL, base, size);
+}
+
+static int brcmstb_psci_integ_region_reset_all(void)
+{
+	return invoke_psci_fn(SIP_FUNC_INTEG_REGION_RESET_ALL, 0, 0, 0);
+}
+
+static int brcmstb_psci_sys_reset(struct notifier_block *nb,
+				  unsigned long action, void *data)
+{
+	const char *cmd = data;
+	/*
+	 * reset_type[31] = 0 (architectural)
+	 * reset_type[30:0] = 0 (SYSTEM_WARM_RESET)
+	 * cookie = 0 (ignored by the implementation)
+	 */
+	uint32_t reboot_type = 0;
+
+	if ((action == REBOOT_COLD || action == REBOOT_WARM ||
+	    action == REBOOT_SOFT) &&
+	    brcmstb_psci_system_reset2_supported) {
+		if (cmd && !strcmp(cmd, "powercycle"))
+			reboot_type = BIT(31) | 1;
+		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), reboot_type, 0, 0);
+	} else {
+		invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block brcmstb_psci_sys_reset_nb = {
+	.notifier_call	= brcmstb_psci_sys_reset,
+	.priority	= 128,
+};
+
+void brcmstb_psci_sys_poweroff(void)
+{
+	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
+}
+
+static int psci_features(u32 psci_func_id)
+{
+	u32 features_func_id;
+
+	switch (ARM_SMCCC_OWNER_NUM(psci_func_id)) {
+	case ARM_SMCCC_OWNER_SIP:
+		features_func_id = SIP_FUNC_PSCI_FEATURES;
+		break;
+	case ARM_SMCCC_OWNER_STANDARD:
+		features_func_id = PSCI_1_0_FN_PSCI_FEATURES;
+		break;
+	default:
+		return PSCI_RET_NOT_SUPPORTED;
+	}
+
+	return invoke_psci_fn(features_func_id, psci_func_id, 0, 0);
+}
+
+static int brcmstb_psci_enter(suspend_state_t state)
+{
+	/* Request a SYSTEM level power state with retention */
+	u32 pstate = 2 << PSCI_0_2_POWER_STATE_AFFL_SHIFT |
+		     !brcmstb_psci_cpu_retention << PSCI_0_2_POWER_STATE_TYPE_SHIFT;
+	int ret = -EINVAL;
+
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		ret = psci_cpu_suspend_enter(pstate);
+		break;
+	case PM_SUSPEND_MEM:
+		ret = brcmstb_psci_system_suspend_supported ?
+			 psci_system_suspend_enter(state) : -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int brcmstb_psci_valid(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		return true;
+	case PM_SUSPEND_MEM:
+		return brcmstb_psci_system_suspend_supported;
+	default:
+		return false;
+	}
+}
+
+static const struct platform_suspend_ops brcmstb_psci_ops = {
+	.enter	= brcmstb_psci_enter,
+	.valid	= brcmstb_psci_valid,
+};
+
+static int brcmstb_psci_panic_notify(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	int ret;
+
+	ret = invoke_psci_fn(SIP_FUNC_PANIC_NOTIFY, BRCMSTB_PANIC_MAGIC, 0, 0);
+	if (ret != PSCI_RET_SUCCESS)
+		return NOTIFY_BAD;
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block brcmstb_psci_nb = {
+	.notifier_call = brcmstb_psci_panic_notify,
+};
+
+static ssize_t brcmstb_psci_version_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buf)
+{
+	struct arm_smccc_res res = { };
+	u32 version;
+
+	if (invoke_psci_fn == __invoke_psci_fn_hvc)
+		arm_smccc_hvc(SIP_FUNC_PSCI_BRCMSTB_VERSION,
+			      0, 0, 0, 0, 0, 0, 0, &res);
+	else
+		arm_smccc_smc(SIP_FUNC_PSCI_BRCMSTB_VERSION,
+			      0, 0, 0, 0, 0, 0, 0, &res);
+
+	if (res.a0 != PSCI_RET_SUCCESS)
+		return -EOPNOTSUPP;
+
+	version = res.a1;
+
+	return sprintf(buf, "%d.%d.%d.%d\n",
+		       (version >> 24) & 0xff, (version >> 16) & 0xff,
+		       (version >> 8) & 0xff, version & 0xff);
+}
+
+static struct kobj_attribute brcmstb_psci_version_attr =
+	__ATTR(mon_version, 0400, brcmstb_psci_version_show, NULL);
+
+static ssize_t brcmstb_psci_cpu_retention_show(struct kobject *kobj,
+					       struct kobj_attribute *attr,
+					       char *buf)
+{
+	return sprintf(buf, "%d\n", brcmstb_psci_cpu_retention);
+}
+
+static ssize_t brcmstb_psci_cpu_retention_store(struct kobject *kobj,
+						struct kobj_attribute *attr,
+						const char *buf, size_t count)
+{
+	int ret, val;
+
+	ret = kstrtoint(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	brcmstb_psci_cpu_retention = !!val;
+
+	return count;
+}
+
+static struct kobj_attribute brcmstb_psci_cpu_retention_attr =
+	__ATTR(cpu_retention, 0644, brcmstb_psci_cpu_retention_show,
+	       brcmstb_psci_cpu_retention_store);
+
+static const struct attribute *brcmstb_psci_attributes[] = {
+	&brcmstb_psci_version_attr.attr,
+	&brcmstb_psci_cpu_retention_attr.attr,
+	NULL,
+};
+
+static int brcmstb_pm_psci_init(void)
+{
+	unsigned long funcs_id[] = {
+		PSCI_0_2_FN_SYSTEM_OFF,
+		SIP_FUNC_INTEG_REGION_SET,
+		SIP_FUNC_INTEG_REGION_DEL,
+		SIP_FUNC_INTEG_REGION_RESET_ALL,
+	};
+	struct arm_smccc_res res = { };
+	struct kobject *brcmstb_kobj;
+	unsigned int i;
+	int ret;
+
+	switch (arm_smccc_1_1_get_conduit()) {
+	case SMCCC_CONDUIT_HVC:
+		invoke_psci_fn = __invoke_psci_fn_hvc;
+		break;
+	case SMCCC_CONDUIT_SMC:
+		invoke_psci_fn = __invoke_psci_fn_smc;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Check the revision of monitor */
+	if (invoke_psci_fn == __invoke_psci_fn_hvc)
+		arm_smccc_hvc(SIP_SVC_REVISION,
+			      0, 0, 0, 0, 0, 0, 0, &res);
+	else
+		arm_smccc_smc(SIP_SVC_REVISION,
+			      0, 0, 0, 0, 0, 0, 0, &res);
+
+	/* Test for our supported features */
+	for (i = 0; i < ARRAY_SIZE(funcs_id); i++) {
+		ret = psci_features(funcs_id[i]);
+		if (ret == PSCI_RET_NOT_SUPPORTED) {
+			pr_err("Firmware does not support function 0x%lx\n",
+			       funcs_id[i]);
+			return -EOPNOTSUPP;
+		}
+	}
+
+	ret = psci_features(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2));
+	if (ret != PSCI_RET_NOT_SUPPORTED)
+		brcmstb_psci_system_reset2_supported = true;
+
+	ret = psci_features(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND));
+	if (ret != PSCI_RET_NOT_SUPPORTED)
+		brcmstb_psci_system_suspend_supported = true;
+
+	ret = brcmstb_psci_integ_region_reset_all();
+	if (ret != PSCI_RET_SUCCESS) {
+		pr_err("Error resetting all integrity checking regions\n");
+		return -EIO;
+	}
+
+	if (res.a0 == SIP_REVISION_MAJOR && res.a1 < SIP_REVISION_MINOR) {
+		pr_info("Firmware is too old! Please update\n");
+		return -EOPNOTSUPP;
+	}
+
+	brcmstb_kobj = kobject_create_and_add("brcmstb", firmware_kobj);
+	if (brcmstb_kobj) {
+		ret = sysfs_create_files(brcmstb_kobj, brcmstb_psci_attributes);
+		if (ret)
+			return ret;
+	}
+
+	pm_power_off = brcmstb_psci_sys_poweroff;
+	register_restart_handler(&brcmstb_psci_sys_reset_nb);
+	suspend_set_ops(&brcmstb_psci_ops);
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &brcmstb_psci_nb);
+
+	pr_info("Using PSCI based system PM (full featured)\n");
+
+	return 0;
+}
+module_init(brcmstb_pm_psci_init);
+
+MODULE_AUTHOR("Broadcom");
+MODULE_DESCRIPTION("Broadcom STB PM PSCI operations");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/soc/brcmstb/brcmstb-smccc.h b/include/linux/soc/brcmstb/brcmstb-smccc.h
new file mode 100644
index 000000000000..2863e894e1c7
--- /dev/null
+++ b/include/linux/soc/brcmstb/brcmstb-smccc.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BRCMSTB_SMCCC_H
+#define __BRCMSTB_SMCCC_H
+
+#include <linux/arm-smccc.h>
+#include <uapi/linux/psci.h>
+
+#ifdef CONFIG_64BIT
+#define PSCI_FN_NATIVE(version, name)   PSCI_##version##_FN64_##name
+#else
+#define PSCI_FN_NATIVE(version, name)   PSCI_##version##_FN_##name
+#endif
+
+/* Broadcom STB custom SIP function calls */
+#define SIP_FUNC_INTEG_REGION_SET	\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
+			   IS_ENABLED(CONFIG_64BIT), \
+			   ARM_SMCCC_OWNER_SIP, \
+			   0)
+#define SIP_FUNC_INTEG_REGION_DEL	\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
+			   IS_ENABLED(CONFIG_64BIT), \
+			   ARM_SMCCC_OWNER_SIP, \
+			   1)
+#define SIP_FUNC_INTEG_REGION_RESET_ALL	\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
+			   IS_ENABLED(CONFIG_64BIT), \
+			   ARM_SMCCC_OWNER_SIP, \
+			   2)
+#define SIP_FUNC_PANIC_NOTIFY		\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
+			   IS_ENABLED(CONFIG_64BIT), \
+			   ARM_SMCCC_OWNER_SIP, \
+			   3)
+#define SIP_FUNC_PSCI_FEATURES		\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
+			   IS_ENABLED(CONFIG_64BIT), \
+			   ARM_SMCCC_OWNER_SIP, \
+			   4)
+#define SIP_FUNC_PSCI_BRCMSTB_VERSION		\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
+			   IS_ENABLED(CONFIG_64BIT), \
+			   ARM_SMCCC_OWNER_SIP, \
+			   5)
+
+#define SIP_SVC_REVISION		\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
+			   IS_ENABLED(CONFIG_64BIT), \
+			   ARM_SMCCC_OWNER_SIP, \
+			   0xFF02)
+
+#define SIP_MIN_REGION_SIZE	4096
+#define SIP_REVISION_MAJOR	0
+#define SIP_REVISION_MINOR	2
+
+typedef unsigned long (psci_fn)(unsigned long, unsigned long,
+				unsigned long, unsigned long);
+
+static inline unsigned long __invoke_psci_fn_hvc(unsigned long function_id,
+						 unsigned long arg0,
+						 unsigned long arg1,
+						 unsigned long arg2)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_hvc(function_id, arg0, arg1, arg2, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+static inline unsigned long __invoke_psci_fn_smc(unsigned long function_id,
+						 unsigned long arg0,
+						 unsigned long arg1,
+						 unsigned long arg2)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(function_id, arg0, arg1, arg2, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+
+#endif /* __BRCMSTB_SMCCC_H */
-- 
2.25.1

