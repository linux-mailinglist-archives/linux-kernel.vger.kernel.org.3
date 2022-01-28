Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908E249FE2A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350177AbiA1QgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350078AbiA1QgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:36:16 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C59C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:36:16 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c2so4837039wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+bYImjRjTWNep/cOZZmI5ERgtlrCtBnQFFuQ+RCujyw=;
        b=BuuXC5yxN4n9+z313nFuaVUDsjZ+K0x17XHumzXLAejfLBsb2uboSeHqFNldZgglb/
         +kwzp7bR/kiamsPmS0DZIaqFvapuOO8eNQPrq0slPyji06ZV3hcMMICeoURU6wWn5YG4
         SvsS4IwwjrEppYbHU8xY7Iv7ynd1TgZn9rskFwqvBd0rBDH9xNQB0Sv2wLkRQ1utKUZL
         E56Hrj+hTFRiI7c9yuegTBm5ZGCWGUV8lJNPTm+gbyUyc+WgQh9Aqy7VS6CeRUGMKTbe
         RrESoUDE0wD1HI49q2xBXUwrPnfWCuj+chl2Y0c7foWkYQ/XFEVdfadaZ3vosS0x9DWa
         Nugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+bYImjRjTWNep/cOZZmI5ERgtlrCtBnQFFuQ+RCujyw=;
        b=mVyEKqWqqic8kVH6kEHAo5EIpXHduAlEdVNcnPFme0OHO7qYpaamQxbt1+uMGr64Nv
         CAdm6m2GBKxY0UvAZNB+a666P0YXj1tmDh+NUdoyD4ihvzXordCx89aSo5uK3Cxbk2Pr
         aYEB9K3J/UzHkaQP1IlXm2P8oFlBVM/yI0uPjvwmoh4okFVdTQlXTIUuOdGYPCeJKZc3
         lZzzoMcLn0DEgeGNcy74UpJsPnGWBl0WNkdh5wbkfQkgT90+ji3tdtOQUo2xTshYkle8
         j4pURUf1PfFPq5GVRXXSgyCw+ZuQPa0kW/+7XkqpT7bsQjLGUcb6hWqOfwqygx0yCODi
         mZqQ==
X-Gm-Message-State: AOAM533sOIhTQIplBuQbZumdzfBsFytfGbkQQ22lvsGftoXKnw/SZKGp
        gAzx5dPVTRR3BU0TCJcGiA9bqA==
X-Google-Smtp-Source: ABdhPJxT1AHWCo1tvuXmMkacT6nIIv/QTAiSIhMM5jhoGOXc8B+7GQkcxelVDpM7lBonUOGEdGzRqw==
X-Received: by 2002:a1c:4386:: with SMTP id q128mr7996680wma.9.1643387774791;
        Fri, 28 Jan 2022 08:36:14 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:f39:b962:8b8e:9851])
        by smtp.gmail.com with ESMTPSA id m6sm5734745wrw.54.2022.01.28.08.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 08:36:14 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     heiko@sntech.de, robh@kernel.org, lukasz.luba@arm.com,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Chanwoo Choi <cwchoi00@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: [PATCH v8 4/5] powercap/drivers/dtpm: Add dtpm devfreq with energy model support
Date:   Fri, 28 Jan 2022 17:35:36 +0100
Message-Id: <20220128163537.212248-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128163537.212248-1-daniel.lezcano@linaro.org>
References: <20220128163537.212248-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the dtpm supports the CPUs via cpufreq and the energy
model. This change provides the same for the device which supports
devfreq.

Each device supporting devfreq and having an energy model can be added
to the hierarchy.

The concept is the same as the cpufreq DTPM support: the QoS is used
to aggregate the requests and the energy model gives the value of the
instantaneous power consumption ponderated by the load of the device.

Cc: Chanwoo Choi <cwchoi00@gmail.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/Kconfig        |   7 ++
 drivers/powercap/Makefile       |   1 +
 drivers/powercap/dtpm_devfreq.c | 203 ++++++++++++++++++++++++++++++++
 drivers/powercap/dtpm_subsys.h  |   4 +
 4 files changed, 215 insertions(+)
 create mode 100644 drivers/powercap/dtpm_devfreq.c

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index b1ca339957e3..515e3ceb3393 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -57,4 +57,11 @@ config DTPM_CPU
 	help
 	  This enables support for CPU power limitation based on
 	  energy model.
+
+config DTPM_DEVFREQ
+	bool "Add device power capping based on the energy model"
+	depends on DTPM && ENERGY_MODEL
+	help
+	  This enables support for device power limitation based on
+	  energy model.
 endif
diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
index fabcf388a8d3..494617cdad88 100644
--- a/drivers/powercap/Makefile
+++ b/drivers/powercap/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_DTPM) += dtpm.o
 obj-$(CONFIG_DTPM_CPU) += dtpm_cpu.o
+obj-$(CONFIG_DTPM_DEVFREQ) += dtpm_devfreq.o
 obj-$(CONFIG_POWERCAP)	+= powercap_sys.o
 obj-$(CONFIG_INTEL_RAPL_CORE) += intel_rapl_common.o
 obj-$(CONFIG_INTEL_RAPL) += intel_rapl_msr.o
diff --git a/drivers/powercap/dtpm_devfreq.c b/drivers/powercap/dtpm_devfreq.c
new file mode 100644
index 000000000000..91276761a31d
--- /dev/null
+++ b/drivers/powercap/dtpm_devfreq.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2021 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * The devfreq device combined with the energy model and the load can
+ * give an estimation of the power consumption as well as limiting the
+ * power.
+ *
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cpumask.h>
+#include <linux/devfreq.h>
+#include <linux/dtpm.h>
+#include <linux/energy_model.h>
+#include <linux/of.h>
+#include <linux/pm_qos.h>
+#include <linux/slab.h>
+#include <linux/units.h>
+
+struct dtpm_devfreq {
+	struct dtpm dtpm;
+	struct dev_pm_qos_request qos_req;
+	struct devfreq *devfreq;
+};
+
+static struct dtpm_devfreq *to_dtpm_devfreq(struct dtpm *dtpm)
+{
+	return container_of(dtpm, struct dtpm_devfreq, dtpm);
+}
+
+static int update_pd_power_uw(struct dtpm *dtpm)
+{
+	struct dtpm_devfreq *dtpm_devfreq = to_dtpm_devfreq(dtpm);
+	struct devfreq *devfreq = dtpm_devfreq->devfreq;
+	struct device *dev = devfreq->dev.parent;
+	struct em_perf_domain *pd = em_pd_get(dev);
+
+	dtpm->power_min = pd->table[0].power;
+	dtpm->power_min *= MICROWATT_PER_MILLIWATT;
+
+	dtpm->power_max = pd->table[pd->nr_perf_states - 1].power;
+	dtpm->power_max *= MICROWATT_PER_MILLIWATT;
+
+	return 0;
+}
+
+static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
+{
+	struct dtpm_devfreq *dtpm_devfreq = to_dtpm_devfreq(dtpm);
+	struct devfreq *devfreq = dtpm_devfreq->devfreq;
+	struct device *dev = devfreq->dev.parent;
+	struct em_perf_domain *pd = em_pd_get(dev);
+	unsigned long freq;
+	u64 power;
+	int i;
+
+	for (i = 0; i < pd->nr_perf_states; i++) {
+
+		power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
+		if (power > power_limit)
+			break;
+	}
+
+	freq = pd->table[i - 1].frequency;
+
+	dev_pm_qos_update_request(&dtpm_devfreq->qos_req, freq);
+
+	power_limit = pd->table[i - 1].power * MICROWATT_PER_MILLIWATT;
+
+	return power_limit;
+}
+
+static void _normalize_load(struct devfreq_dev_status *status)
+{
+	if (status->total_time > 0xfffff) {
+		status->total_time >>= 10;
+		status->busy_time >>= 10;
+	}
+
+	status->busy_time <<= 10;
+	status->busy_time /= status->total_time ? : 1;
+
+	status->busy_time = status->busy_time ? : 1;
+	status->total_time = 1024;
+}
+
+static u64 get_pd_power_uw(struct dtpm *dtpm)
+{
+	struct dtpm_devfreq *dtpm_devfreq = to_dtpm_devfreq(dtpm);
+	struct devfreq *devfreq = dtpm_devfreq->devfreq;
+	struct device *dev = devfreq->dev.parent;
+	struct em_perf_domain *pd = em_pd_get(dev);
+	struct devfreq_dev_status status;
+	unsigned long freq;
+	u64 power;
+	int i;
+
+	mutex_lock(&devfreq->lock);
+	status = devfreq->last_status;
+	mutex_unlock(&devfreq->lock);
+
+	freq = DIV_ROUND_UP(status.current_frequency, HZ_PER_KHZ);
+	_normalize_load(&status);
+
+	for (i = 0; i < pd->nr_perf_states; i++) {
+
+		if (pd->table[i].frequency < freq)
+			continue;
+
+		power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
+		power *= status.busy_time;
+		power >>= 10;
+
+		return power;
+	}
+
+	return 0;
+}
+
+static void pd_release(struct dtpm *dtpm)
+{
+	struct dtpm_devfreq *dtpm_devfreq = to_dtpm_devfreq(dtpm);
+
+	if (dev_pm_qos_request_active(&dtpm_devfreq->qos_req))
+		dev_pm_qos_remove_request(&dtpm_devfreq->qos_req);
+
+	kfree(dtpm_devfreq);
+}
+
+static struct dtpm_ops dtpm_ops = {
+	.set_power_uw = set_pd_power_limit,
+	.get_power_uw = get_pd_power_uw,
+	.update_power_uw = update_pd_power_uw,
+	.release = pd_release,
+};
+
+static int __dtpm_devfreq_setup(struct devfreq *devfreq, struct dtpm *parent)
+{
+	struct device *dev = devfreq->dev.parent;
+	struct dtpm_devfreq *dtpm_devfreq;
+	struct em_perf_domain *pd;
+	int ret = -ENOMEM;
+
+	pd = em_pd_get(dev);
+	if (!pd) {
+		ret = dev_pm_opp_of_register_em(dev, NULL);
+		if (ret) {
+			pr_err("No energy model available for '%s'\n", dev_name(dev));
+			return -EINVAL;
+		}
+	}
+
+	dtpm_devfreq = kzalloc(sizeof(*dtpm_devfreq), GFP_KERNEL);
+	if (!dtpm_devfreq)
+		return -ENOMEM;
+
+	dtpm_init(&dtpm_devfreq->dtpm, &dtpm_ops);
+
+	dtpm_devfreq->devfreq = devfreq;
+
+	ret = dtpm_register(dev_name(dev), &dtpm_devfreq->dtpm, parent);
+	if (ret) {
+		pr_err("Failed to register '%s': %d\n", dev_name(dev), ret);
+		kfree(dtpm_devfreq);
+		return ret;
+	}
+
+	ret = dev_pm_qos_add_request(dev, &dtpm_devfreq->qos_req,
+				     DEV_PM_QOS_MAX_FREQUENCY,
+				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
+	if (ret) {
+		pr_err("Failed to add QoS request: %d\n", ret);
+		goto out_dtpm_unregister;
+	}
+
+	dtpm_update_power(&dtpm_devfreq->dtpm);
+
+	return 0;
+
+out_dtpm_unregister:
+	dtpm_unregister(&dtpm_devfreq->dtpm);
+
+	return ret;
+}
+
+static int dtpm_devfreq_setup(struct dtpm *dtpm, struct device_node *np)
+{
+	struct devfreq *devfreq;
+
+	devfreq = devfreq_get_devfreq_by_node(np);
+	if (IS_ERR(devfreq))
+		return 0;
+
+	return __dtpm_devfreq_setup(devfreq, dtpm);
+}
+
+struct dtpm_subsys_ops dtpm_devfreq_ops = {
+	.name = KBUILD_MODNAME,
+	.setup = dtpm_devfreq_setup,
+};
diff --git a/drivers/powercap/dtpm_subsys.h b/drivers/powercap/dtpm_subsys.h
index 2a3a2055f60e..db1712938a96 100644
--- a/drivers/powercap/dtpm_subsys.h
+++ b/drivers/powercap/dtpm_subsys.h
@@ -8,11 +8,15 @@
 #define ___DTPM_SUBSYS_H__
 
 extern struct dtpm_subsys_ops dtpm_cpu_ops;
+extern struct dtpm_subsys_ops dtpm_devfreq_ops;
 
 struct dtpm_subsys_ops *dtpm_subsys[] = {
 #ifdef CONFIG_DTPM_CPU
 	&dtpm_cpu_ops,
 #endif
+#ifdef CONFIG_DTPM_DEVFREQ
+	&dtpm_devfreq_ops,
+#endif
 };
 
 #endif
-- 
2.25.1

