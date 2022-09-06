Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562FF5AEF21
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbiIFPmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbiIFPiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:38:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81CBEC7439;
        Tue,  6 Sep 2022 07:48:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7CB91A32;
        Tue,  6 Sep 2022 07:24:34 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D10923F7B4;
        Tue,  6 Sep 2022 07:24:25 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        dan.carpenter@oracle.com, lukasz.luba@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 1/3] powercap: arm_scmi: Add SCMI Powercap based driver
Date:   Tue,  6 Sep 2022 15:23:35 +0100
Message-Id: <20220906142337.1697569-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220906142337.1697569-1-cristian.marussi@arm.com>
References: <20220906142337.1697569-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a powercap driver that, using the ARM SCMI Protocol to query the SCMI
platform firmware for the list of existing Powercap domains, registers all
of such discovered domains under the new 'arm-scmi' powercap control type.

A new simple powercap zone and constraint is registered for all the SCMI
powercap zones that are found.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v1 --> v2
- using clamp_t() to simplify normalizations
- cleanup style in block of var declarations
- refactor scale conversions code
- add MAINTAINER entry
- refactored normalizations and added dev_dbg
vOLD --> v1
- fix _init cleaning up powerctrl zone on failure
- removed uneeded casting
- simplified normalization helpers
---
 MAINTAINERS                          |   1 +
 drivers/powercap/Kconfig             |  13 +
 drivers/powercap/Makefile            |   1 +
 drivers/powercap/arm_scmi_powercap.c | 508 +++++++++++++++++++++++++++
 4 files changed, 523 insertions(+)
 create mode 100644 drivers/powercap/arm_scmi_powercap.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d7f64dc0efe..c3bfc7c5aa91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19737,6 +19737,7 @@ F:	drivers/clk/clk-sc[mp]i.c
 F:	drivers/cpufreq/sc[mp]i-cpufreq.c
 F:	drivers/firmware/arm_scmi/
 F:	drivers/firmware/arm_scpi.c
+F:	drivers/powercap/arm_scmi_powercap.c
 F:	drivers/regulator/scmi-regulator.c
 F:	drivers/reset/reset-scmi.c
 F:	include/linux/sc[mp]i_protocol.h
diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index 515e3ceb3393..90d33cd1b670 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -44,6 +44,19 @@ config IDLE_INJECT
 	  synchronously on a set of specified CPUs or alternatively
 	  on a per CPU basis.
 
+config ARM_SCMI_POWERCAP
+	tristate "ARM SCMI Powercap driver"
+	depends on ARM_SCMI_PROTOCOL
+	help
+	  This enables support for the ARM Powercap based on ARM SCMI
+	  Powercap protocol.
+
+	  ARM SCMI Powercap protocol allows power limits to be enforced
+	  and monitored against the SCMI Powercap domains advertised as
+	  available by the SCMI platform firmware.
+
+	  When compiled as module it will be called arm_scmi_powercap.ko.
+
 config DTPM
 	bool "Power capping for Dynamic Thermal Power Management (EXPERIMENTAL)"
 	depends on OF
diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
index 494617cdad88..4474201b4aa7 100644
--- a/drivers/powercap/Makefile
+++ b/drivers/powercap/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_POWERCAP)	+= powercap_sys.o
 obj-$(CONFIG_INTEL_RAPL_CORE) += intel_rapl_common.o
 obj-$(CONFIG_INTEL_RAPL) += intel_rapl_msr.o
 obj-$(CONFIG_IDLE_INJECT) += idle_inject.o
+obj-$(CONFIG_ARM_SCMI_POWERCAP) += arm_scmi_powercap.o
diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
new file mode 100644
index 000000000000..a91438867f8c
--- /dev/null
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -0,0 +1,508 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SCMI Powercap support.
+ *
+ * Copyright (C) 2022 ARM Ltd.
+ */
+
+#include <linux/device.h>
+#include <linux/math.h>
+#include <linux/limits.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/powercap.h>
+#include <linux/scmi_protocol.h>
+
+#define to_scmi_powercap_zone(z)		\
+	container_of(z, struct scmi_powercap_zone, zone)
+
+static const struct scmi_powercap_proto_ops *powercap_ops;
+
+struct scmi_powercap_zone {
+	unsigned int height;
+	struct device *dev;
+	struct scmi_protocol_handle *ph;
+	const struct scmi_powercap_info *info;
+	struct scmi_powercap_zone *spzones;
+	struct powercap_zone zone;
+	struct list_head node;
+};
+
+struct scmi_powercap_root {
+	unsigned int num_zones;
+	struct scmi_powercap_zone *spzones;
+	struct list_head *registered_zones;
+};
+
+static struct powercap_control_type *scmi_top_pcntrl;
+
+static int scmi_powercap_zone_release(struct powercap_zone *pz)
+{
+	return 0;
+}
+
+static int scmi_powercap_get_max_power_range_uw(struct powercap_zone *pz,
+						u64 *max_power_range_uw)
+{
+	*max_power_range_uw = U32_MAX;
+	return 0;
+}
+
+static int scmi_powercap_get_power_uw(struct powercap_zone *pz,
+				      u64 *power_uw)
+{
+	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
+	u32 avg_power, pai;
+	int ret;
+
+	if (!spz->info->powercap_monitoring)
+		return -EINVAL;
+
+	ret = powercap_ops->measurements_get(spz->ph, spz->info->id, &avg_power,
+					     &pai);
+	if (ret)
+		return ret;
+
+	*power_uw = avg_power;
+	if (spz->info->powercap_scale_mw)
+		*power_uw *= 1000;
+
+	return 0;
+}
+
+static const struct powercap_zone_ops zone_ops = {
+	.get_max_power_range_uw = scmi_powercap_get_max_power_range_uw,
+	.get_power_uw = scmi_powercap_get_power_uw,
+	.release = scmi_powercap_zone_release,
+};
+
+static void scmi_powercap_normalize_cap(const struct scmi_powercap_zone *spz,
+					u64 power_limit_uw, u32 *norm)
+{
+	bool scale_mw = spz->info->powercap_scale_mw;
+	u64 val;
+
+	val = scale_mw ? DIV_ROUND_UP_ULL(power_limit_uw, 1000) : power_limit_uw;
+	/*
+	 * This cast is lossless since here @req_power is certain to be within
+	 * the range [min_power_cap, max_power_cap] whose bounds are assured to
+	 * be two unsigned 32bits quantities.
+	 */
+	*norm = clamp_t(u32, val, spz->info->min_power_cap,
+			spz->info->max_power_cap);
+	*norm = rounddown(*norm, spz->info->power_cap_step);
+
+	val = (scale_mw) ? *norm * 1000 : *norm;
+	if (power_limit_uw != val)
+		dev_dbg(spz->dev,
+			"Normalized %s:CAP - requested:%llu - normalized:%llu\n",
+			spz->info->name, power_limit_uw, val);
+}
+
+static int scmi_powercap_set_power_limit_uw(struct powercap_zone *pz, int cid,
+					    u64 power_uw)
+{
+	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
+	u32 norm_power;
+
+	if (!spz->info->powercap_cap_config)
+		return -EINVAL;
+
+	scmi_powercap_normalize_cap(spz, power_uw, &norm_power);
+
+	return powercap_ops->cap_set(spz->ph, spz->info->id, norm_power, false);
+}
+
+static int scmi_powercap_get_power_limit_uw(struct powercap_zone *pz, int cid,
+					    u64 *power_limit_uw)
+{
+	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
+	u32 power;
+	int ret;
+
+	ret = powercap_ops->cap_get(spz->ph, spz->info->id, &power);
+	if (ret)
+		return ret;
+
+	*power_limit_uw = power;
+	if (spz->info->powercap_scale_mw)
+		*power_limit_uw *= 1000;
+
+	return 0;
+}
+
+static void scmi_powercap_normalize_time(const struct scmi_powercap_zone *spz,
+					 u64 time_us, u32 *norm)
+{
+	/*
+	 * This cast is lossless since here @time_us is certain to be within the
+	 * range [min_pai, max_pai] whose bounds are assured to be two unsigned
+	 * 32bits quantities.
+	 */
+	*norm = clamp_t(u32, time_us, spz->info->min_pai, spz->info->max_pai);
+	*norm = rounddown(*norm, spz->info->pai_step);
+
+	if (time_us != *norm)
+		dev_dbg(spz->dev,
+			"Normalized %s:PAI - requested:%llu - normalized:%u\n",
+			spz->info->name, time_us, *norm);
+}
+
+static int scmi_powercap_set_time_window_us(struct powercap_zone *pz, int cid,
+					    u64 time_window_us)
+{
+	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
+	u32 norm_pai;
+
+	if (!spz->info->powercap_pai_config)
+		return -EINVAL;
+
+	scmi_powercap_normalize_time(spz, time_window_us, &norm_pai);
+
+	return powercap_ops->pai_set(spz->ph, spz->info->id, norm_pai);
+}
+
+static int scmi_powercap_get_time_window_us(struct powercap_zone *pz, int cid,
+					    u64 *time_window_us)
+{
+	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
+	int ret;
+	u32 pai;
+
+	ret = powercap_ops->pai_get(spz->ph, spz->info->id, &pai);
+	if (ret)
+		return ret;
+
+	*time_window_us = pai;
+
+	return 0;
+}
+
+static int scmi_powercap_get_max_power_uw(struct powercap_zone *pz, int cid,
+					  u64 *max_power_uw)
+{
+	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
+
+	*max_power_uw = spz->info->max_power_cap;
+	if (spz->info->powercap_scale_mw)
+		*max_power_uw *= 1000;
+
+	return 0;
+}
+
+static int scmi_powercap_get_min_power_uw(struct powercap_zone *pz, int cid,
+					  u64 *min_power_uw)
+{
+	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
+
+	*min_power_uw = spz->info->min_power_cap;
+	if (spz->info->powercap_scale_mw)
+		*min_power_uw *= 1000;
+
+	return 0;
+}
+
+static int scmi_powercap_get_max_time_window_us(struct powercap_zone *pz,
+						int cid, u64 *time_window_us)
+{
+	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
+
+	*time_window_us = spz->info->max_pai;
+
+	return 0;
+}
+
+static int scmi_powercap_get_min_time_window_us(struct powercap_zone *pz,
+						int cid, u64 *time_window_us)
+{
+	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
+
+	*time_window_us = (u64)spz->info->min_pai;
+
+	return 0;
+}
+
+static const char *scmi_powercap_get_name(struct powercap_zone *pz, int cid)
+{
+	return "SCMI power-cap";
+}
+
+static const struct powercap_zone_constraint_ops constraint_ops  = {
+	.set_power_limit_uw = scmi_powercap_set_power_limit_uw,
+	.get_power_limit_uw = scmi_powercap_get_power_limit_uw,
+	.set_time_window_us = scmi_powercap_set_time_window_us,
+	.get_time_window_us = scmi_powercap_get_time_window_us,
+	.get_max_power_uw = scmi_powercap_get_max_power_uw,
+	.get_min_power_uw = scmi_powercap_get_min_power_uw,
+	.get_max_time_window_us = scmi_powercap_get_max_time_window_us,
+	.get_min_time_window_us = scmi_powercap_get_min_time_window_us,
+	.get_name = scmi_powercap_get_name,
+};
+
+static void scmi_powercap_unregister_all_zones(struct scmi_powercap_root *pr)
+{
+	int i;
+
+	/* Un-register children zones first starting from the leaves */
+	for (i = pr->num_zones - 1; i >= 0; i--) {
+		if (!list_empty(&pr->registered_zones[i])) {
+			struct scmi_powercap_zone *spz;
+
+			list_for_each_entry(spz, &pr->registered_zones[i], node)
+				powercap_unregister_zone(scmi_top_pcntrl,
+							 &spz->zone);
+		}
+	}
+}
+
+static inline bool
+scmi_powercap_is_zone_registered(struct scmi_powercap_zone *spz)
+{
+	return !list_empty(&spz->node);
+}
+
+static inline unsigned int
+scmi_powercap_get_zone_height(struct scmi_powercap_zone *spz)
+{
+	if (spz->info->parent_id == SCMI_POWERCAP_ROOT_ZONE_ID)
+		return 0;
+
+	return spz->spzones[spz->info->parent_id].height + 1;
+}
+
+static inline struct scmi_powercap_zone *
+scmi_powercap_get_parent_zone(struct scmi_powercap_zone *spz)
+{
+	if (spz->info->parent_id == SCMI_POWERCAP_ROOT_ZONE_ID)
+		return NULL;
+
+	return &spz->spzones[spz->info->parent_id];
+}
+
+/**
+ * scmi_powercap_register_zone  - Register an SCMI powercap zone recursively
+ *
+ * @pr: A reference to the root powercap zones descriptors
+ * @spz: A reference to the SCMI powercap zone to register
+ *
+ * When registering SCMI powercap zones with the powercap framework we should
+ * take care to always register zones starting from the root ones and to
+ * deregister starting from the leaves.
+ *
+ * Unfortunately we cannot assume that the array of available SCMI powercap
+ * zones provided by the SCMI platform firmware is built to comply with such
+ * requirement.
+ *
+ * This function, given an SCMI powercap zone to register, takes care to walk
+ * the SCMI powercap zones tree up to the root looking recursively for
+ * unregistered parent zones before registering the provided zone; at the same
+ * time each registered zone height in such a tree is accounted for and each
+ * zone, once registered, is stored in the @registered_zones array that is
+ * indexed by zone height: this way will be trivial, at unregister time, to walk
+ * the @registered_zones array backward and unregister all the zones starting
+ * from the leaves, removing children zones before parents.
+ *
+ * While doing this, we prune away any zone marked as invalid (like the ones
+ * sporting an SCMI abstract power scale) as long as they are positioned as
+ * leaves in the SCMI powercap zones hierarchy: any non-leaf invalid zone causes
+ * the entire process to fail since we cannot assume the correctness of an SCMI
+ * powercap zones hierarchy if some of the internal nodes are missing.
+ *
+ * Note that the array of SCMI powercap zones as returned by the SCMI platform
+ * is known to be sane, i.e. zones relationships have been validated at the
+ * protocol layer.
+ *
+ * Return: 0 on Success
+ */
+static int scmi_powercap_register_zone(struct scmi_powercap_root *pr,
+				       struct scmi_powercap_zone *spz)
+{
+	int ret = 0;
+	struct scmi_powercap_zone *parent;
+
+	if (!spz->info)
+		return ret;
+
+	parent = scmi_powercap_get_parent_zone(spz);
+	if (parent && !scmi_powercap_is_zone_registered(parent)) {
+		/*
+		 * Bail out if a parent domain was marked as unsupported:
+		 * only domains participating as leaves can be skipped.
+		 */
+		if (!parent->info)
+			return -ENODEV;
+
+		ret = scmi_powercap_register_zone(pr, parent);
+		if (ret)
+			return ret;
+	}
+
+	if (!scmi_powercap_is_zone_registered(spz)) {
+		struct powercap_zone *z;
+
+		z = powercap_register_zone(&spz->zone,
+					   scmi_top_pcntrl,
+					   spz->info->name,
+					   parent ? &parent->zone : NULL,
+					   &zone_ops, 1, &constraint_ops);
+		if (!IS_ERR(z)) {
+			spz->height = scmi_powercap_get_zone_height(spz);
+			list_add(&spz->node,
+				 &pr->registered_zones[spz->height]);
+			dev_dbg(spz->dev,
+				"Registered node %s - parent %s - height:%d\n",
+				spz->info->name,
+				parent ? parent->info->name : "ROOT",
+				spz->height);
+			ret = 0;
+		} else {
+			ret = PTR_ERR(z);
+			dev_err(spz->dev,
+				"Error registering node:%s - parent:%s - h:%d - ret:%d\n",
+				 spz->info->name,
+				 parent ? parent->info->name : "ROOT",
+				 spz->height, ret);
+		}
+	}
+
+	return ret;
+}
+
+static int scmi_powercap_probe(struct scmi_device *sdev)
+{
+	int ret, i;
+	struct scmi_powercap_root *pr;
+	struct scmi_powercap_zone *spz;
+	struct scmi_protocol_handle *ph;
+	struct device *dev = &sdev->dev;
+
+	if (!sdev->handle)
+		return -ENODEV;
+
+	powercap_ops = sdev->handle->devm_protocol_get(sdev,
+						       SCMI_PROTOCOL_POWERCAP,
+						       &ph);
+	if (IS_ERR(powercap_ops))
+		return PTR_ERR(powercap_ops);
+
+	pr = devm_kzalloc(dev, sizeof(*pr), GFP_KERNEL);
+	if (!pr)
+		return -ENOMEM;
+
+	pr->num_zones = powercap_ops->num_domains_get(ph);
+	if (pr->num_zones < 0) {
+		dev_err(dev, "number of powercap domains not found\n");
+		return pr->num_zones;
+	}
+
+	pr->spzones = devm_kcalloc(dev, pr->num_zones,
+				   sizeof(*pr->spzones), GFP_KERNEL);
+	if (!pr->spzones)
+		return -ENOMEM;
+
+	/* Allocate for worst possible scenario of maximum tree height. */
+	pr->registered_zones = devm_kcalloc(dev, pr->num_zones,
+					    sizeof(*pr->registered_zones),
+					    GFP_KERNEL);
+	if (!pr->registered_zones)
+		return -ENOMEM;
+
+	for (i = 0, spz = pr->spzones; i < pr->num_zones; i++, spz++) {
+		/*
+		 * Powercap domains are validate by the protocol layer, i.e.
+		 * when only non-NULL domains are returned here, whose
+		 * parent_id is assured to point to another valid domain.
+		 */
+		spz->info = powercap_ops->info_get(ph, i);
+
+		spz->dev = dev;
+		spz->ph = ph;
+		spz->spzones = pr->spzones;
+		INIT_LIST_HEAD(&spz->node);
+		INIT_LIST_HEAD(&pr->registered_zones[i]);
+
+		/*
+		 * Forcibly skip powercap domains using an abstract scale.
+		 * Note that only leaves domains can be skipped, so this could
+		 * lead later to a global failure.
+		 */
+		if (!spz->info->powercap_scale_uw &&
+		    !spz->info->powercap_scale_mw) {
+			dev_warn(dev,
+				 "Abstract power scale not supported. Skip %s.\n",
+				 spz->info->name);
+			spz->info = NULL;
+			continue;
+		}
+	}
+
+	/*
+	 * Scan array of retrieved SCMI powercap domains and register them
+	 * recursively starting from the root domains.
+	 */
+	for (i = 0, spz = pr->spzones; i < pr->num_zones; i++, spz++) {
+		ret = scmi_powercap_register_zone(pr, spz);
+		if (ret) {
+			dev_err(dev,
+				"Failed to register powercap zone %s - ret:%d\n",
+				spz->info->name, ret);
+			scmi_powercap_unregister_all_zones(pr);
+			return ret;
+		}
+	}
+
+	dev_set_drvdata(dev, pr);
+
+	dev_info(dev, "Registered %d SCMI Powercap domains !\n", pr->num_zones);
+
+	return ret;
+}
+
+static void scmi_powercap_remove(struct scmi_device *sdev)
+{
+	struct device *dev = &sdev->dev;
+	struct scmi_powercap_root *pr = dev_get_drvdata(dev);
+
+	scmi_powercap_unregister_all_zones(pr);
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_POWERCAP, "powercap" },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_powercap_driver = {
+	.name = "scmi-powercap",
+	.probe = scmi_powercap_probe,
+	.remove = scmi_powercap_remove,
+	.id_table = scmi_id_table,
+};
+
+static int __init scmi_powercap_init(void)
+{
+	int ret;
+
+	scmi_top_pcntrl = powercap_register_control_type(NULL, "arm-scmi", NULL);
+	if (!scmi_top_pcntrl)
+		return -ENODEV;
+
+	ret = scmi_register(&scmi_powercap_driver);
+	if (ret)
+		powercap_unregister_control_type(scmi_top_pcntrl);
+
+	return ret;
+}
+module_init(scmi_powercap_init);
+
+static void __exit scmi_powercap_exit(void)
+{
+	scmi_unregister(&scmi_powercap_driver);
+
+	powercap_unregister_control_type(scmi_top_pcntrl);
+}
+module_exit(scmi_powercap_exit);
+
+MODULE_AUTHOR("Cristian Marussi <cristian.marussi@arm.com>");
+MODULE_DESCRIPTION("ARM SCMI Powercap driver");
+MODULE_LICENSE("GPL");
-- 
2.32.0

