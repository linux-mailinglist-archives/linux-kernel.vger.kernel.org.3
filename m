Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114F15198F3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345980AbiEDH4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345874AbiEDHz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:55:56 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDFA18E31;
        Wed,  4 May 2022 00:52:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5049741E64;
        Wed,  4 May 2022 07:52:14 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states
Date:   Wed,  4 May 2022 16:51:52 +0900
Message-Id: <20220504075153.185208-4-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504075153.185208-1-marcan@marcan.st>
References: <20220504075153.185208-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver implements CPU frequency scaling for Apple Silicon SoCs,
including M1 (t8103) and M1 Max/Pro/Ultra (t600x).

Each CPU cluster has its own register set, and frequency management is
fully automated by the hardware; the driver only has to write one
register. There is boost frequency support, but the hardware will only
allow their use if only a subset of cores in a cluster are in
non-deep-idle. Since we don't support deep idle yet, these frequencies
are not achievable, but the driver supports them. They will remain
disabled in the device tree until deep idle is implemented, to avoid
confusing users.

This driver does not yet implement the memory controller performance
state tuning that usually accompanies higher CPU p-states. This will be
done in a future patch.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/cpufreq/Kconfig.arm          |   9 +
 drivers/cpufreq/Makefile             |   1 +
 drivers/cpufreq/apple-soc-cpufreq.c  | 330 +++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
 4 files changed, 342 insertions(+)
 create mode 100644 drivers/cpufreq/apple-soc-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 954749afb5fe..9a020a0bd9c4 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -41,6 +41,15 @@ config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
 	  To compile this driver as a module, choose M here: the
 	  module will be called sun50i-cpufreq-nvmem.
 
+config ARM_APPLE_SOC_CPUFREQ
+	tristate "Apple Silicon SoC CPUFreq support"
+	depends on ARCH_APPLE || COMPILE_TEST
+	select PM_OPP
+	default ARCH_APPLE
+	help
+	  This adds the CPUFreq driver for Apple Silicon machines
+	  (e.g. Apple M1).
+
 config ARM_ARMADA_37XX_CPUFREQ
 	tristate "Armada 37xx CPUFreq support"
 	depends on ARCH_MVEBU && CPUFREQ_DT
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 285de70af877..c0da6f2f6cd5 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_X86_AMD_FREQ_SENSITIVITY)	+= amd_freq_sensitivity.o
 
 ##################################################################################
 # ARM SoC drivers
+obj-$(CONFIG_ARM_APPLE_SOC_CPUFREQ)	+= apple-soc-cpufreq.o
 obj-$(CONFIG_ARM_ARMADA_37XX_CPUFREQ)	+= armada-37xx-cpufreq.o
 obj-$(CONFIG_ARM_ARMADA_8K_CPUFREQ)	+= armada-8k-cpufreq.o
 obj-$(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ)	+= brcmstb-avs-cpufreq.o
diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
new file mode 100644
index 000000000000..191eaae71744
--- /dev/null
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Apple SoC CPU cluster performance state driver
+ *
+ * Copyright The Asahi Linux Contributors
+ *
+ * Based on scpi-cpufreq.c
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+
+#define APPLE_DVFS_CMD			0x20
+#define APPLE_DVFS_CMD_BUSY		BIT(31)
+#define APPLE_DVFS_CMD_SET		BIT(25)
+#define APPLE_DVFS_CMD_PS2		GENMASK(15, 12)
+#define APPLE_DVFS_CMD_PS1		GENMASK(3, 0)
+
+/* Same timebase as CPU counter (24MHz) */
+#define APPLE_DVFS_LAST_CHG_TIME	0x38
+
+#define APPLE_DVFS_STATUS		0x50
+#define APPLE_DVFS_STATUS_CUR_PS	GENMASK(7, 4)
+#define APPLE_DVFS_STATUS_TGT_PS	GENMASK(3, 0)
+
+/*
+ * Div is +1, base clock is 12MHz on existing SoCs.
+ * For documentation purposes. We use the OPP table to
+ * get the frequency.
+ */
+#define APPLE_DVFS_PLL_STATUS		0xc0
+#define APPLE_DVFS_PLL_FACTOR		0xc8
+#define APPLE_DVFS_PLL_FACTOR_MULT	GENMASK(31, 16)
+#define APPLE_DVFS_PLL_FACTOR_DIV	GENMASK(15, 0)
+
+struct apple_cpu_priv {
+	struct device *cpu_dev;
+	void __iomem *reg_base;
+};
+
+struct apple_soc_cpufreq_priv {
+	struct device *dev;
+	void __iomem *reg_base;
+};
+
+#define APPLE_DVFS_TRANSITION_TIMEOUT 100
+
+static struct cpufreq_driver apple_soc_cpufreq_driver;
+
+static unsigned int apple_soc_cpufreq_get_rate(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
+	struct apple_cpu_priv *priv = policy->driver_data;
+	u64 reg = readq_relaxed(priv->reg_base + APPLE_DVFS_STATUS);
+	unsigned int pstate = FIELD_GET(APPLE_DVFS_STATUS_CUR_PS, reg);
+	unsigned int i;
+
+	for (i = 0; policy->freq_table[i].frequency != CPUFREQ_TABLE_END; i++)
+		if (policy->freq_table[i].driver_data == pstate)
+			return policy->freq_table[i].frequency;
+
+	dev_err(priv->cpu_dev, "could not find frequency for pstate %d\n",
+		pstate);
+	return 0;
+}
+
+static int apple_soc_cpufreq_set_target(struct cpufreq_policy *policy,
+					unsigned int index)
+{
+	struct apple_cpu_priv *priv = policy->driver_data;
+	unsigned int pstate = policy->freq_table[index].driver_data;
+	u64 reg;
+
+	if (readq_poll_timeout_atomic(priv->reg_base + APPLE_DVFS_CMD, reg,
+				      !(reg & APPLE_DVFS_CMD_BUSY), 2,
+				      APPLE_DVFS_TRANSITION_TIMEOUT)) {
+		return -EIO;
+	}
+
+	reg &= ~(APPLE_DVFS_CMD_PS1 | APPLE_DVFS_CMD_PS2);
+	reg |= FIELD_PREP(APPLE_DVFS_CMD_PS1, pstate);
+	reg |= FIELD_PREP(APPLE_DVFS_CMD_PS2, pstate);
+	reg |= APPLE_DVFS_CMD_SET;
+
+	writeq_relaxed(reg, priv->reg_base + APPLE_DVFS_CMD);
+
+	return 0;
+}
+
+static unsigned int apple_soc_cpufreq_fast_switch(struct cpufreq_policy *policy,
+						  unsigned int target_freq)
+{
+	if (apple_soc_cpufreq_set_target(policy, policy->cached_resolved_idx) < 0)
+		return 0;
+
+	return policy->freq_table[policy->cached_resolved_idx].frequency;
+}
+
+static int apple_soc_cpufreq_find_cluster(struct cpufreq_policy *policy,
+					  void __iomem **reg_base)
+{
+	struct of_phandle_args args;
+	struct device_node *cpu_np;
+	char name[32];
+	int cpu, ret;
+	int index;
+
+	cpu_np = of_cpu_device_node_get(policy->cpu);
+	if (!cpu_np)
+		return -EINVAL;
+
+	ret = of_parse_phandle_with_args(cpu_np, "apple,freq-domain",
+					 "#freq-domain-cells", 0, &args);
+	of_node_put(cpu_np);
+	if (ret)
+		return ret;
+
+	index = args.args[0];
+
+	snprintf(name, sizeof(name), "cluster%d", index);
+	ret = of_property_match_string(args.np, "reg-names", name);
+	if (ret < 0)
+		return ret;
+
+	*reg_base = of_iomap(args.np, ret);
+	if (IS_ERR(*reg_base))
+		return PTR_ERR(*reg_base);
+
+	for_each_possible_cpu(cpu) {
+		cpu_np = of_cpu_device_node_get(cpu);
+		if (!cpu_np)
+			continue;
+
+		ret = of_parse_phandle_with_args(cpu_np, "apple,freq-domain",
+						 "#freq-domain-cells", 0, &args);
+		of_node_put(cpu_np);
+		if (ret < 0)
+			continue;
+
+		if (index == args.args[0])
+			cpumask_set_cpu(cpu, policy->cpus);
+	}
+
+	return 0;
+}
+
+static struct freq_attr *apple_soc_cpufreq_hw_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+	NULL,
+};
+
+static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
+{
+	int ret, i;
+	unsigned int transition_latency;
+	void __iomem *reg_base;
+	struct device *cpu_dev;
+	struct apple_cpu_priv *priv;
+	struct cpufreq_frequency_table *freq_table;
+
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		pr_err("failed to get cpu%d device\n", policy->cpu);
+		return -ENODEV;
+	}
+
+	ret = dev_pm_opp_of_add_table(cpu_dev);
+	if (ret < 0) {
+		dev_err(cpu_dev, "%s: failed to add OPP table: %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = apple_soc_cpufreq_find_cluster(policy, &reg_base);
+	if (ret) {
+		dev_err(cpu_dev, "%s: failed to get cluster info: %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
+	if (ret) {
+		dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n", __func__, ret);
+		goto out_iounmap;
+	}
+
+	ret = dev_pm_opp_get_opp_count(cpu_dev);
+	if (ret <= 0) {
+		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
+		ret = -EPROBE_DEFER;
+		goto out_free_opp;
+	}
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto out_free_opp;
+	}
+
+	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
+	if (ret) {
+		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
+		goto out_free_priv;
+	}
+
+	/* Get OPP levels (p-state indexes) and stash them in driver_data */
+	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
+		unsigned long rate = freq_table[i].frequency * 1000;
+		struct dev_pm_opp *opp = dev_pm_opp_find_freq_floor(cpu_dev, &rate);
+
+		if (IS_ERR(opp)) {
+			ret = PTR_ERR(opp);
+			goto out_free_cpufreq_table;
+		}
+		freq_table[i].driver_data = dev_pm_opp_get_level(opp);
+		dev_pm_opp_put(opp);
+	}
+
+	priv->cpu_dev = cpu_dev;
+	priv->reg_base = reg_base;
+	policy->driver_data = priv;
+	policy->freq_table = freq_table;
+
+	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
+	if (!transition_latency)
+		transition_latency = CPUFREQ_ETERNAL;
+
+	policy->cpuinfo.transition_latency = transition_latency;
+	policy->dvfs_possible_from_any_cpu = true;
+	policy->fast_switch_possible = true;
+
+	if (policy_has_boost_freq(policy)) {
+		ret = cpufreq_enable_boost_support();
+		if (ret) {
+			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
+		} else {
+			apple_soc_cpufreq_hw_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
+			apple_soc_cpufreq_driver.boost_enabled = true;
+		}
+	}
+
+	return 0;
+
+out_free_cpufreq_table:
+	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
+out_free_priv:
+	kfree(priv);
+out_free_opp:
+	dev_pm_opp_remove_all_dynamic(cpu_dev);
+out_iounmap:
+	iounmap(reg_base);
+	return ret;
+}
+
+static int apple_soc_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	struct apple_cpu_priv *priv = policy->driver_data;
+
+	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
+	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
+	iounmap(priv->reg_base);
+	kfree(priv);
+
+	return 0;
+}
+
+static struct cpufreq_driver apple_soc_cpufreq_driver = {
+	.name		= "apple-cpufreq",
+	.flags		= CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+			  CPUFREQ_NEED_INITIAL_FREQ_CHECK | CPUFREQ_IS_COOLING_DEV,
+	.verify		= cpufreq_generic_frequency_table_verify,
+	.attr		= cpufreq_generic_attr,
+	.get		= apple_soc_cpufreq_get_rate,
+	.init		= apple_soc_cpufreq_init,
+	.exit		= apple_soc_cpufreq_exit,
+	.target_index	= apple_soc_cpufreq_set_target,
+	.fast_switch	= apple_soc_cpufreq_fast_switch,
+	.register_em	= cpufreq_register_em_with_opp,
+	.attr		= apple_soc_cpufreq_hw_attr,
+};
+
+static int apple_soc_cpufreq_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = cpufreq_register_driver(&apple_soc_cpufreq_driver);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "registering cpufreq failed\n");
+
+	return 0;
+}
+
+static int apple_soc_cpufreq_remove(struct platform_device *pdev)
+{
+	cpufreq_unregister_driver(&apple_soc_cpufreq_driver);
+
+	return 0;
+}
+
+static const struct of_device_id apple_soc_cpufreq_of_match[] = {
+	{ .compatible = "apple,soc-cpufreq" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, apple_soc_cpufreq_of_match);
+
+static struct platform_driver apple_soc_cpufreq_plat_driver = {
+	.probe		= apple_soc_cpufreq_probe,
+	.remove		= apple_soc_cpufreq_remove,
+	.driver = {
+		.name	= "apple-soc-cpufreq",
+		.of_match_table = apple_soc_cpufreq_of_match,
+	},
+};
+module_platform_driver(apple_soc_cpufreq_plat_driver);
+
+MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
+MODULE_DESCRIPTION("Apple SoC CPU cluster DVFS driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 96de1536e1cb..2cb54206a4ae 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -103,6 +103,8 @@ static const struct of_device_id allowlist[] __initconst = {
 static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "allwinner,sun50i-h6", },
 
+	{ .compatible = "apple,arm-platform", },
+
 	{ .compatible = "arm,vexpress", },
 
 	{ .compatible = "calxeda,highbank", },
-- 
2.35.1

