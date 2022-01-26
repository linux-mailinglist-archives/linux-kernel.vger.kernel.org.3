Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0A749C8FB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240940AbiAZLpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240929AbiAZLpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:45:44 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D1DC061749
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:45:43 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id k17so4622203plk.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hvSeXnubnZbVlSRdpnf4lkyRXXkWbWEQEXNvpq2BRsk=;
        b=ZvfnFLEwyqvBazto6B2CDL0iBCgmMfsBvLtXPhsowx4bAySqH3HaTPR72Gi466bD9s
         Zp945Gi7FPgqaZisMi+k1ncWwCZ5LZOUbwLR+rAgJYehtaTaQGMDXK8gTnfrQm+7mNMw
         UIN73mREI/fzD+BnZ0aIL44qZFzPhrQHKQ3JALhd16A1UbDEEKKsANje0NTlJqisf/x+
         KcVm94HreWC47nbxGYua+F548oOAlRlZBUu1ni+5HI+0ghl2sgCWg0aUIsN1t79Dt9qu
         44rwvEyYdtu9jxXj40p2+wAu0paRrBQ7Cmryk8kiWMmcz52S/iwPuQ1LPycRgaOZTK1Z
         6M+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hvSeXnubnZbVlSRdpnf4lkyRXXkWbWEQEXNvpq2BRsk=;
        b=m/JuQ+39D0ck9FKtQGO4YNWDWZmUPCWi0yxK14WWy9STXKqIQH575QXyuyzdvkE4QA
         4z70UrySmQQ6TVZFn64Mp9WMBx+q7PluqboKmBVSm9JGpYmeGuVcudx419QDQH0unPKN
         tTRjPMEVh4ZoFdxNDbpLzySRHuPWnsmxwt1rcyPA4I7OP3UBJPlaVt2awfM2lw56YVB7
         mIUFAYzF/bJuyhgDCO6PUL0E7hMa6/+zteoQ0F+2LkIaTY31QEJzyA89+spc0snjKnn2
         p1kxFvHpUdhRYiBOMZFikNlmmxN989oIM7KPl9HYqH0oBIUJwWPSAtHQzxHJOmmvX4hb
         xNpQ==
X-Gm-Message-State: AOAM532L4bUoKI8s3+sXdfw4I+YdpVnftYEndJ7nXGmc+fwyOR2B8UmZ
        icRNTcZIY4I35iWAyuAbSOlGhw==
X-Google-Smtp-Source: ABdhPJwC7iVQEwyE185Ixqk/dpPe1tHaFUHT7xdhVZu9sOzQGk6+QLkROYEGKw5QQoEmLwK7NKEVRA==
X-Received: by 2002:a17:90a:e601:: with SMTP id j1mr8319420pjy.69.1643197543266;
        Wed, 26 Jan 2022 03:45:43 -0800 (PST)
Received: from localhost.localdomain ([122.167.221.23])
        by smtp.gmail.com with ESMTPSA id nn2sm2994976pjb.35.2022.01.26.03.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 03:45:42 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc:     Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvm-riscv@lists.infradead.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v10 5/8] cpuidle: Factor-out power domain related code from PSCI domain driver
Date:   Wed, 26 Jan 2022 17:14:49 +0530
Message-Id: <20220126114452.692512-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126114452.692512-1-apatel@ventanamicro.com>
References: <20220126114452.692512-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup.patel@wdc.com>

The generic power domain related code in PSCI domain driver is largely
independent of PSCI and can be shared with RISC-V SBI domain driver
hence we factor-out this code into dt_idle_genpd.c and dt_idle_genpd.h.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                           |   7 +
 drivers/cpuidle/Kconfig               |   4 +
 drivers/cpuidle/Kconfig.arm           |   1 +
 drivers/cpuidle/Makefile              |   1 +
 drivers/cpuidle/cpuidle-psci-domain.c | 138 +-------------------
 drivers/cpuidle/cpuidle-psci.h        |  15 ++-
 drivers/cpuidle/dt_idle_genpd.c       | 178 ++++++++++++++++++++++++++
 drivers/cpuidle/dt_idle_genpd.h       |  50 ++++++++
 8 files changed, 259 insertions(+), 135 deletions(-)
 create mode 100644 drivers/cpuidle/dt_idle_genpd.c
 create mode 100644 drivers/cpuidle/dt_idle_genpd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..0c67ebe7f07e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5051,6 +5051,13 @@ S:	Supported
 F:	drivers/cpuidle/cpuidle-psci.h
 F:	drivers/cpuidle/cpuidle-psci-domain.c
 
+CPUIDLE DRIVER - DT IDLE PM DOMAIN
+M:	Ulf Hansson <ulf.hansson@linaro.org>
+L:	linux-pm@vger.kernel.org
+S:	Supported
+F:	drivers/cpuidle/dt_idle_genpd.c
+F:	drivers/cpuidle/dt_idle_genpd.h
+
 CRAMFS FILESYSTEM
 M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Maintained
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index c0aeedd66f02..f1afe7ab6b54 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -47,6 +47,10 @@ config CPU_IDLE_GOV_HALTPOLL
 config DT_IDLE_STATES
 	bool
 
+config DT_IDLE_GENPD
+	depends on PM_GENERIC_DOMAINS_OF
+	bool
+
 menu "ARM CPU Idle Drivers"
 depends on ARM || ARM64
 source "drivers/cpuidle/Kconfig.arm"
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 15d6c46c0a47..be7f512109f7 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -27,6 +27,7 @@ config ARM_PSCI_CPUIDLE_DOMAIN
 	bool "PSCI CPU idle Domain"
 	depends on ARM_PSCI_CPUIDLE
 	depends on PM_GENERIC_DOMAINS_OF
+	select DT_IDLE_GENPD
 	default y
 	help
 	  Select this to enable the PSCI based CPUidle driver to use PM domains,
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 26bbc5e74123..11a26cef279f 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -6,6 +6,7 @@
 obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
 obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 obj-$(CONFIG_DT_IDLE_STATES)		  += dt_idle_states.o
+obj-$(CONFIG_DT_IDLE_GENPD)		  += dt_idle_genpd.o
 obj-$(CONFIG_ARCH_HAS_CPU_RELAX)	  += poll_state.o
 obj-$(CONFIG_HALTPOLL_CPUIDLE)		  += cpuidle-haltpoll.o
 
diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index ff2c3f8e4668..755bbdfc5b82 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -47,73 +47,14 @@ static int psci_pd_power_off(struct generic_pm_domain *pd)
 	return 0;
 }
 
-static int psci_pd_parse_state_nodes(struct genpd_power_state *states,
-				     int state_count)
-{
-	int i, ret;
-	u32 psci_state, *psci_state_buf;
-
-	for (i = 0; i < state_count; i++) {
-		ret = psci_dt_parse_state_node(to_of_node(states[i].fwnode),
-					&psci_state);
-		if (ret)
-			goto free_state;
-
-		psci_state_buf = kmalloc(sizeof(u32), GFP_KERNEL);
-		if (!psci_state_buf) {
-			ret = -ENOMEM;
-			goto free_state;
-		}
-		*psci_state_buf = psci_state;
-		states[i].data = psci_state_buf;
-	}
-
-	return 0;
-
-free_state:
-	i--;
-	for (; i >= 0; i--)
-		kfree(states[i].data);
-	return ret;
-}
-
-static int psci_pd_parse_states(struct device_node *np,
-			struct genpd_power_state **states, int *state_count)
-{
-	int ret;
-
-	/* Parse the domain idle states. */
-	ret = of_genpd_parse_idle_states(np, states, state_count);
-	if (ret)
-		return ret;
-
-	/* Fill out the PSCI specifics for each found state. */
-	ret = psci_pd_parse_state_nodes(*states, *state_count);
-	if (ret)
-		kfree(*states);
-
-	return ret;
-}
-
-static void psci_pd_free_states(struct genpd_power_state *states,
-				unsigned int state_count)
-{
-	int i;
-
-	for (i = 0; i < state_count; i++)
-		kfree(states[i].data);
-	kfree(states);
-}
-
 static int psci_pd_init(struct device_node *np, bool use_osi)
 {
 	struct generic_pm_domain *pd;
 	struct psci_pd_provider *pd_provider;
 	struct dev_power_governor *pd_gov;
-	struct genpd_power_state *states = NULL;
 	int ret = -ENOMEM, state_count = 0;
 
-	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	pd = dt_idle_pd_alloc(np, psci_dt_parse_state_node);
 	if (!pd)
 		goto out;
 
@@ -121,22 +62,6 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 	if (!pd_provider)
 		goto free_pd;
 
-	pd->name = kasprintf(GFP_KERNEL, "%pOF", np);
-	if (!pd->name)
-		goto free_pd_prov;
-
-	/*
-	 * Parse the domain idle states and let genpd manage the state selection
-	 * for those being compatible with "domain-idle-state".
-	 */
-	ret = psci_pd_parse_states(np, &states, &state_count);
-	if (ret)
-		goto free_name;
-
-	pd->free_states = psci_pd_free_states;
-	pd->name = kbasename(pd->name);
-	pd->states = states;
-	pd->state_count = state_count;
 	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
 
 	/* Allow power off when OSI has been successfully enabled. */
@@ -149,10 +74,8 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 	pd_gov = state_count > 0 ? &pm_domain_cpu_gov : NULL;
 
 	ret = pm_genpd_init(pd, pd_gov, false);
-	if (ret) {
-		psci_pd_free_states(states, state_count);
-		goto free_name;
-	}
+	if (ret)
+		goto free_pd_prov;
 
 	ret = of_genpd_add_provider_simple(np, pd);
 	if (ret)
@@ -166,12 +89,10 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 
 remove_pd:
 	pm_genpd_remove(pd);
-free_name:
-	kfree(pd->name);
 free_pd_prov:
 	kfree(pd_provider);
 free_pd:
-	kfree(pd);
+	dt_idle_pd_free(pd);
 out:
 	pr_err("failed to init PM domain ret=%d %pOF\n", ret, np);
 	return ret;
@@ -195,30 +116,6 @@ static void psci_pd_remove(void)
 	}
 }
 
-static int psci_pd_init_topology(struct device_node *np)
-{
-	struct device_node *node;
-	struct of_phandle_args child, parent;
-	int ret;
-
-	for_each_child_of_node(np, node) {
-		if (of_parse_phandle_with_args(node, "power-domains",
-					"#power-domain-cells", 0, &parent))
-			continue;
-
-		child.np = node;
-		child.args_count = 0;
-		ret = of_genpd_add_subdomain(&parent, &child);
-		of_node_put(parent.np);
-		if (ret) {
-			of_node_put(node);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
 static bool psci_pd_try_set_osi_mode(void)
 {
 	int ret;
@@ -282,7 +179,7 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 		goto no_pd;
 
 	/* Link genpd masters/subdomains to model the CPU topology. */
-	ret = psci_pd_init_topology(np);
+	ret = dt_idle_pd_init_topology(np);
 	if (ret)
 		goto remove_pd;
 
@@ -314,28 +211,3 @@ static int __init psci_idle_init_domains(void)
 	return platform_driver_register(&psci_cpuidle_domain_driver);
 }
 subsys_initcall(psci_idle_init_domains);
-
-struct device *psci_dt_attach_cpu(int cpu)
-{
-	struct device *dev;
-
-	dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), "psci");
-	if (IS_ERR_OR_NULL(dev))
-		return dev;
-
-	pm_runtime_irq_safe(dev);
-	if (cpu_online(cpu))
-		pm_runtime_get_sync(dev);
-
-	dev_pm_syscore_device(dev, true);
-
-	return dev;
-}
-
-void psci_dt_detach_cpu(struct device *dev)
-{
-	if (IS_ERR_OR_NULL(dev))
-		return;
-
-	dev_pm_domain_detach(dev, false);
-}
diff --git a/drivers/cpuidle/cpuidle-psci.h b/drivers/cpuidle/cpuidle-psci.h
index d8e925e84c27..4e132640ed64 100644
--- a/drivers/cpuidle/cpuidle-psci.h
+++ b/drivers/cpuidle/cpuidle-psci.h
@@ -10,8 +10,19 @@ void psci_set_domain_state(u32 state);
 int psci_dt_parse_state_node(struct device_node *np, u32 *state);
 
 #ifdef CONFIG_ARM_PSCI_CPUIDLE_DOMAIN
-struct device *psci_dt_attach_cpu(int cpu);
-void psci_dt_detach_cpu(struct device *dev);
+
+#include "dt_idle_genpd.h"
+
+static inline struct device *psci_dt_attach_cpu(int cpu)
+{
+	return dt_idle_attach_cpu(cpu, "psci");
+}
+
+static inline void psci_dt_detach_cpu(struct device *dev)
+{
+	dt_idle_detach_cpu(dev);
+}
+
 #else
 static inline struct device *psci_dt_attach_cpu(int cpu) { return NULL; }
 static inline void psci_dt_detach_cpu(struct device *dev) { }
diff --git a/drivers/cpuidle/dt_idle_genpd.c b/drivers/cpuidle/dt_idle_genpd.c
new file mode 100644
index 000000000000..b37165514d4e
--- /dev/null
+++ b/drivers/cpuidle/dt_idle_genpd.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PM domains for CPUs via genpd.
+ *
+ * Copyright (C) 2019 Linaro Ltd.
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ * Copyright (c) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (c) 2022 Ventana Micro Systems Inc.
+ */
+
+#define pr_fmt(fmt) "dt-idle-genpd: " fmt
+
+#include <linux/cpu.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "dt_idle_genpd.h"
+
+static int pd_parse_state_nodes(
+			int (*parse_state)(struct device_node *, u32 *),
+			struct genpd_power_state *states, int state_count)
+{
+	int i, ret;
+	u32 state, *state_buf;
+
+	for (i = 0; i < state_count; i++) {
+		ret = parse_state(to_of_node(states[i].fwnode), &state);
+		if (ret)
+			goto free_state;
+
+		state_buf = kmalloc(sizeof(u32), GFP_KERNEL);
+		if (!state_buf) {
+			ret = -ENOMEM;
+			goto free_state;
+		}
+		*state_buf = state;
+		states[i].data = state_buf;
+	}
+
+	return 0;
+
+free_state:
+	i--;
+	for (; i >= 0; i--)
+		kfree(states[i].data);
+	return ret;
+}
+
+static int pd_parse_states(struct device_node *np,
+			   int (*parse_state)(struct device_node *, u32 *),
+			   struct genpd_power_state **states,
+			   int *state_count)
+{
+	int ret;
+
+	/* Parse the domain idle states. */
+	ret = of_genpd_parse_idle_states(np, states, state_count);
+	if (ret)
+		return ret;
+
+	/* Fill out the dt specifics for each found state. */
+	ret = pd_parse_state_nodes(parse_state, *states, *state_count);
+	if (ret)
+		kfree(*states);
+
+	return ret;
+}
+
+static void pd_free_states(struct genpd_power_state *states,
+			    unsigned int state_count)
+{
+	int i;
+
+	for (i = 0; i < state_count; i++)
+		kfree(states[i].data);
+	kfree(states);
+}
+
+void dt_idle_pd_free(struct generic_pm_domain *pd)
+{
+	pd_free_states(pd->states, pd->state_count);
+	kfree(pd->name);
+	kfree(pd);
+}
+
+struct generic_pm_domain *dt_idle_pd_alloc(struct device_node *np,
+			int (*parse_state)(struct device_node *, u32 *))
+{
+	struct generic_pm_domain *pd;
+	struct genpd_power_state *states = NULL;
+	int ret, state_count = 0;
+
+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		goto out;
+
+	pd->name = kasprintf(GFP_KERNEL, "%pOF", np);
+	if (!pd->name)
+		goto free_pd;
+
+	/*
+	 * Parse the domain idle states and let genpd manage the state selection
+	 * for those being compatible with "domain-idle-state".
+	 */
+	ret = pd_parse_states(np, parse_state, &states, &state_count);
+	if (ret)
+		goto free_name;
+
+	pd->free_states = pd_free_states;
+	pd->name = kbasename(pd->name);
+	pd->states = states;
+	pd->state_count = state_count;
+
+	pr_debug("alloc PM domain %s\n", pd->name);
+	return pd;
+
+free_name:
+	kfree(pd->name);
+free_pd:
+	kfree(pd);
+out:
+	pr_err("failed to alloc PM domain %pOF\n", np);
+	return NULL;
+}
+
+int dt_idle_pd_init_topology(struct device_node *np)
+{
+	struct device_node *node;
+	struct of_phandle_args child, parent;
+	int ret;
+
+	for_each_child_of_node(np, node) {
+		if (of_parse_phandle_with_args(node, "power-domains",
+					"#power-domain-cells", 0, &parent))
+			continue;
+
+		child.np = node;
+		child.args_count = 0;
+		ret = of_genpd_add_subdomain(&parent, &child);
+		of_node_put(parent.np);
+		if (ret) {
+			of_node_put(node);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+struct device *dt_idle_attach_cpu(int cpu, const char *name)
+{
+	struct device *dev;
+
+	dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), name);
+	if (IS_ERR_OR_NULL(dev))
+		return dev;
+
+	pm_runtime_irq_safe(dev);
+	if (cpu_online(cpu))
+		pm_runtime_get_sync(dev);
+
+	dev_pm_syscore_device(dev, true);
+
+	return dev;
+}
+
+void dt_idle_detach_cpu(struct device *dev)
+{
+	if (IS_ERR_OR_NULL(dev))
+		return;
+
+	dev_pm_domain_detach(dev, false);
+}
diff --git a/drivers/cpuidle/dt_idle_genpd.h b/drivers/cpuidle/dt_idle_genpd.h
new file mode 100644
index 000000000000..a95483d08a02
--- /dev/null
+++ b/drivers/cpuidle/dt_idle_genpd.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_IDLE_GENPD
+#define __DT_IDLE_GENPD
+
+struct device_node;
+struct generic_pm_domain;
+
+#ifdef CONFIG_DT_IDLE_GENPD
+
+void dt_idle_pd_free(struct generic_pm_domain *pd);
+
+struct generic_pm_domain *dt_idle_pd_alloc(struct device_node *np,
+			int (*parse_state)(struct device_node *, u32 *));
+
+int dt_idle_pd_init_topology(struct device_node *np);
+
+struct device *dt_idle_attach_cpu(int cpu, const char *name);
+
+void dt_idle_detach_cpu(struct device *dev);
+
+#else
+
+static inline void dt_idle_pd_free(struct generic_pm_domain *pd)
+{
+}
+
+static inline struct generic_pm_domain *dt_idle_pd_alloc(
+			struct device_node *np,
+			int (*parse_state)(struct device_node *, u32 *))
+{
+	return NULL;
+}
+
+static inline int dt_idle_pd_init_topology(struct device_node *np)
+{
+	return 0;
+}
+
+static inline struct device *dt_idle_attach_cpu(int cpu, const char *name)
+{
+	return NULL;
+}
+
+static inline void dt_idle_detach_cpu(struct device *dev)
+{
+}
+
+#endif
+
+#endif
-- 
2.25.1

