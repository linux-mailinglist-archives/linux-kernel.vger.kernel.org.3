Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402B551E7F4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446553AbiEGPFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389653AbiEGPFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:05:48 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A213042EEA;
        Sat,  7 May 2022 08:02:00 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id w5-20020a17090aaf8500b001d74c754128so13343968pjq.0;
        Sat, 07 May 2022 08:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A+DWEdwDqlMb78R/aQJstgkMoJc3JmE/4lQP46W0xY8=;
        b=L+FSgvEn30YwqopURbk+uD0gfmqtyUbdGAv602NZvR587agvKeqK/Rb1KgAjONAp1s
         bR3rkN862gp6FPFHiiOsJEEvnf4fTa0dem30YXt9s2SeQRPm3HGuTVVK5AH6Lkhg12xr
         7HZbcgjmiXjGgZjsGlHHCvYvDyh1cXxLXhGSyVwVbwSDZUvqDlxHYsqPM8vw84U7G4Yy
         ymhrw5iRy9FBSfMP6x3WqW9KDkJH3bY4paomryxJS94CwR7WBGvE3hamYyZ6UYCqcNbr
         PWzPGnXo1kA5hYv0nwV7qoEsgDOSSt5WhBPI7sLQDDfUGN0kgsQhg1brENCNiOLAJ8pK
         CdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A+DWEdwDqlMb78R/aQJstgkMoJc3JmE/4lQP46W0xY8=;
        b=z3dPGlIMvmlevEueIILcRsnzq/sBqDPXzOqJU5xzXUDRZdQGTVTN9KbHV/AqvpTzX/
         LzSUzM6gG6leH6sPWq0bUW47Unek16htXALeBYvUp/9669gif6DPLp3w78uk/dZ0NaWg
         u9kWY1Wtr+bmMKUIpUGcuS+0lwQdVFVKYeMaDmtVqtZLM68J4No0AICiAiP74Q6/TnGT
         K9oiGgFaW9C9HGbFZ692BS+iPXwPknRgKcYTDL6iq/EZLQNoKwOnpqM/D62wr1gN8yaN
         GAMZrUDm4zoqJ+iU8FNoBlMT39nxpDeJVh43KUlgb1XFsq3bSgZS8d9tjbUQswqDy8SH
         QtEA==
X-Gm-Message-State: AOAM532oEwCz/7l4b1Qi4z9PFqaWJT3vldR7crz8joF04BhmwnnkaCgf
        724cZ2Wig9OfdB1LrnSt84/PyDkbeIdbew==
X-Google-Smtp-Source: ABdhPJwNza0LXhjD67/Fq+yX5oVJzRbz3HxvSKLYA9gZ83mlKL9oDk/bjC8z43+kDidhMUYGVE6HJQ==
X-Received: by 2002:a17:903:1c5:b0:15e:a42b:7b4a with SMTP id e5-20020a17090301c500b0015ea42b7b4amr8558469plh.111.1651935719864;
        Sat, 07 May 2022 08:01:59 -0700 (PDT)
Received: from localhost.localdomain ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id v21-20020a170902ca9500b0015e8d4eb2a8sm3711007pld.242.2022.05.07.08.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 08:01:59 -0700 (PDT)
From:   Chanwoo Choi <cwchoi00@gmail.com>
X-Google-Original-From: Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, johnson.wang@mediatek.com,
        mka@chromium.org, jia-wei.chang@mediatek.com,
        andrew-sh.cheng@mediatek.com, hsinyi@chromium.org,
        sibis@codeaurora.org, saravanak@google.com,
        Saravana Kannan <skannan@codeaurora.org>
Subject: [PATCH v2 2/5] PM / devfreq: Add cpu based scaling support to passive governor
Date:   Sun,  8 May 2022 00:01:42 +0900
Message-Id: <20220507150145.531864-3-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507150145.531864-1-cw00.choi@samsung.com>
References: <20220507150145.531864-1-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <skannan@codeaurora.org>

Many CPU architectures have caches that can scale independent of the
CPUs. Frequency scaling of the caches is necessary to make sure that the
cache is not a performance bottleneck that leads to poor performance and
power. The same idea applies for RAM/DDR.

To achieve this, this patch adds support for cpu based scaling to the
passive governor. This is accomplished by taking the current frequency
of each CPU frequency domain and then adjust the frequency of the cache
(or any devfreq device) based on the frequency of the CPUs. It listens
to CPU frequency transition notifiers to keep itself up to date on the
current CPU frequency.

To decide the frequency of the device, the governor does one of the
following:
* Derives the optimal devfreq device opp from required-opps property of
  the parent cpu opp_table.

* Scales the device frequency in proportion to the CPU frequency. So, if
  the CPUs are running at their max frequency, the device runs at its
  max frequency. If the CPUs are running at their min frequency, the
  device runs at its min frequency. It is interpolated for frequencies
  in between.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
[Sibi: Integrated cpu-freqmap governor into passive_governor]
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
[Chanwoo: Fix conflict with latest code and cleanup code]
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/governor.h         |  22 +++
 drivers/devfreq/governor_passive.c | 292 ++++++++++++++++++++++++++++-
 include/linux/devfreq.h            |  17 +-
 3 files changed, 320 insertions(+), 11 deletions(-)

diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index b0dbfee8bbf2..335c4a491254 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -47,6 +47,28 @@
 #define DEVFREQ_GOV_ATTR_POLLING_INTERVAL		BIT(0)
 #define DEVFREQ_GOV_ATTR_TIMER				BIT(1)
 
+/**
+ * struct devfreq_cpu_data - Hold the per-cpu data
+ * @dev:	reference to cpu device.
+ * @first_cpu:	the cpumask of the first cpu of a policy.
+ * @opp_table:	reference to cpu opp table.
+ * @cur_freq:	the current frequency of the cpu.
+ * @min_freq:	the min frequency of the cpu.
+ * @max_freq:	the max frequency of the cpu.
+ *
+ * This structure stores the required cpu_data of a cpu.
+ * This is auto-populated by the governor.
+ */
+struct devfreq_cpu_data {
+	struct device *dev;
+	unsigned int first_cpu;
+
+	struct opp_table *opp_table;
+	unsigned int cur_freq;
+	unsigned int min_freq;
+	unsigned int max_freq;
+};
+
 /**
  * struct devfreq_governor - Devfreq policy governor
  * @node:		list node - contains registered devfreq governors
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index fc09324a03e0..bfbe5604538d 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -8,11 +8,84 @@
  */
 
 #include <linux/module.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/devfreq.h>
 #include "governor.h"
 
-static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
+#define HZ_PER_KHZ	1000
+
+static unsigned long get_target_freq_by_required_opp(struct device *p_dev,
+						struct opp_table *p_opp_table,
+						struct opp_table *opp_table,
+						unsigned long freq)
+{
+	struct dev_pm_opp *opp = NULL, *p_opp = NULL;
+
+	if (!p_dev || !p_opp_table || !opp_table || !freq)
+		return 0;
+
+	p_opp = devfreq_recommended_opp(p_dev, &freq, 0);
+	if (IS_ERR(p_opp))
+		return 0;
+
+	opp = dev_pm_opp_xlate_required_opp(p_opp_table, opp_table, p_opp);
+	dev_pm_opp_put(p_opp);
+
+	if (IS_ERR(opp))
+		return 0;
+
+	freq = dev_pm_opp_get_freq(opp);
+	dev_pm_opp_put(opp);
+
+	return freq;
+}
+
+static int get_target_freq_with_cpufreq(struct devfreq *devfreq,
+					unsigned long *target_freq)
+{
+	struct devfreq_passive_data *p_data =
+				(struct devfreq_passive_data *)devfreq->data;
+	struct devfreq_cpu_data *parent_cpu_data;
+	unsigned long cpu, cpu_cur, cpu_min, cpu_max, cpu_percent;
+	unsigned long dev_min, dev_max;
+	unsigned long freq = 0;
+
+	for_each_online_cpu(cpu) {
+		parent_cpu_data = p_data->parent_cpu_data[cpu];
+		if (!parent_cpu_data || parent_cpu_data->first_cpu != cpu)
+			continue;
+
+		/* Get target freq via required opps */
+		cpu_cur = parent_cpu_data->cur_freq * HZ_PER_KHZ;
+		freq = get_target_freq_by_required_opp(parent_cpu_data->dev,
+					parent_cpu_data->opp_table,
+					devfreq->opp_table, cpu_cur);
+		if (freq) {
+			*target_freq = max(freq, *target_freq);
+			continue;
+		}
+
+		/* Use interpolation if required opps is not available */
+		devfreq_get_freq_range(devfreq, &dev_min, &dev_max);
+
+		cpu_min = parent_cpu_data->min_freq;
+		cpu_max = parent_cpu_data->max_freq;
+		cpu_cur = parent_cpu_data->cur_freq;
+
+		cpu_percent = ((cpu_cur - cpu_min) * 100) / (cpu_max - cpu_min);
+		freq = dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);
+
+		*target_freq = max(freq, *target_freq);
+	}
+
+	return 0;
+}
+
+static int get_target_freq_with_devfreq(struct devfreq *devfreq,
 					unsigned long *freq)
 {
 	struct devfreq_passive_data *p_data
@@ -99,6 +172,181 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	return 0;
 }
 
+static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
+					   unsigned long *freq)
+{
+	struct devfreq_passive_data *p_data =
+				(struct devfreq_passive_data *)devfreq->data;
+	int ret;
+
+	if (!p_data)
+		return -EINVAL;
+
+	/*
+	 * If the devfreq device with passive governor has the specific method
+	 * to determine the next frequency, should use the get_target_freq()
+	 * of struct devfreq_passive_data.
+	 */
+	if (p_data->get_target_freq)
+		return p_data->get_target_freq(devfreq, freq);
+
+	switch (p_data->parent_type) {
+	case DEVFREQ_PARENT_DEV:
+		ret = get_target_freq_with_devfreq(devfreq, freq);
+		break;
+	case CPUFREQ_PARENT_DEV:
+		ret = get_target_freq_with_cpufreq(devfreq, freq);
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(&devfreq->dev, "Invalid parent type\n");
+		break;
+	}
+
+	return ret;
+}
+
+static int cpufreq_passive_notifier_call(struct notifier_block *nb,
+					 unsigned long event, void *ptr)
+{
+	struct devfreq_passive_data *p_data =
+			container_of(nb, struct devfreq_passive_data, nb);
+	struct devfreq *devfreq = (struct devfreq *)p_data->this;
+	struct devfreq_cpu_data *parent_cpu_data;
+	struct cpufreq_freqs *freqs = ptr;
+	unsigned int cur_freq;
+	int ret;
+
+	if (event != CPUFREQ_POSTCHANGE || !freqs ||
+		!p_data->parent_cpu_data[freqs->policy->cpu])
+		return 0;
+
+	parent_cpu_data = p_data->parent_cpu_data[freqs->policy->cpu];
+	if (parent_cpu_data->cur_freq == freqs->new)
+		return 0;
+
+	cur_freq = parent_cpu_data->cur_freq;
+	parent_cpu_data->cur_freq = freqs->new;
+
+	mutex_lock(&devfreq->lock);
+	ret = devfreq_update_target(devfreq, freqs->new);
+	mutex_unlock(&devfreq->lock);
+	if (ret) {
+		parent_cpu_data->cur_freq = cur_freq;
+		dev_err(&devfreq->dev, "failed to update the frequency.\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
+{
+	struct devfreq_passive_data *p_data
+			= (struct devfreq_passive_data *)devfreq->data;
+	struct devfreq_cpu_data *parent_cpu_data;
+	int cpu, ret;
+
+	if (p_data->nb.notifier_call) {
+		ret = cpufreq_unregister_notifier(&p_data->nb,
+					CPUFREQ_TRANSITION_NOTIFIER);
+		if (ret < 0)
+			return ret;
+	}
+
+	for_each_possible_cpu(cpu) {
+		parent_cpu_data = p_data->parent_cpu_data[cpu];
+		if (!parent_cpu_data)
+			continue;
+
+		if (parent_cpu_data->opp_table)
+			dev_pm_opp_put_opp_table(parent_cpu_data->opp_table);
+		kfree(parent_cpu_data);
+	}
+
+	return 0;
+}
+
+static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
+{
+	struct devfreq_passive_data *p_data
+			= (struct devfreq_passive_data *)devfreq->data;
+	struct device *dev = devfreq->dev.parent;
+	struct opp_table *opp_table = NULL;
+	struct devfreq_cpu_data *parent_cpu_data;
+	struct cpufreq_policy *policy;
+	struct device *cpu_dev;
+	unsigned int cpu;
+	int ret;
+
+	p_data->nb.notifier_call = cpufreq_passive_notifier_call;
+	ret = cpufreq_register_notifier(&p_data->nb, CPUFREQ_TRANSITION_NOTIFIER);
+	if (ret) {
+		dev_err(dev, "failed to register cpufreq notifier\n");
+		p_data->nb.notifier_call = NULL;
+		goto err;
+	}
+
+	for_each_possible_cpu(cpu) {
+		if (p_data->parent_cpu_data[cpu])
+			continue;
+
+		policy = cpufreq_cpu_get(cpu);
+		if (!policy) {
+			ret = -EPROBE_DEFER;
+			goto err;
+		}
+
+		parent_cpu_data = kzalloc(sizeof(*parent_cpu_data),
+						GFP_KERNEL);
+		if (!parent_cpu_data) {
+			ret = -ENOMEM;
+			goto err_put_policy;
+		}
+
+		cpu_dev = get_cpu_device(cpu);
+		if (!cpu_dev) {
+			dev_err(dev, "failed to get cpu device\n");
+			ret = -ENODEV;
+			goto err_free_cpu_data;
+		}
+
+		opp_table = dev_pm_opp_get_opp_table(cpu_dev);
+		if (IS_ERR(opp_table)) {
+			dev_err(dev, "failed to get opp_table of cpu%d\n", cpu);
+			ret = PTR_ERR(opp_table);
+			goto err_free_cpu_data;
+		}
+
+		parent_cpu_data->dev = cpu_dev;
+		parent_cpu_data->opp_table = opp_table;
+		parent_cpu_data->first_cpu = cpumask_first(policy->related_cpus);
+		parent_cpu_data->cur_freq = policy->cur;
+		parent_cpu_data->min_freq = policy->cpuinfo.min_freq;
+		parent_cpu_data->max_freq = policy->cpuinfo.max_freq;
+
+		p_data->parent_cpu_data[cpu] = parent_cpu_data;
+		cpufreq_cpu_put(policy);
+	}
+
+	mutex_lock(&devfreq->lock);
+	ret = devfreq_update_target(devfreq, 0L);
+	mutex_unlock(&devfreq->lock);
+	if (ret)
+		dev_err(dev, "failed to update the frequency\n");
+
+	return ret;
+
+err_free_cpu_data:
+	kfree(parent_cpu_data);
+err_put_policy:
+	cpufreq_cpu_put(policy);
+err:
+	WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
+
+	return ret;
+}
+
 static int devfreq_passive_notifier_call(struct notifier_block *nb,
 				unsigned long event, void *ptr)
 {
@@ -131,16 +379,39 @@ static int devfreq_passive_notifier_call(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static int devfreq_passive_unregister_notifier(struct devfreq *devfreq)
+{
+	struct devfreq_passive_data *p_data
+			= (struct devfreq_passive_data *)devfreq->data;
+	struct devfreq *parent = (struct devfreq *)p_data->parent;
+	struct notifier_block *nb = &p_data->nb;
+
+	return devfreq_unregister_notifier(parent, nb, DEVFREQ_TRANSITION_NOTIFIER);
+}
+
+static int devfreq_passive_register_notifier(struct devfreq *devfreq)
+{
+	struct devfreq_passive_data *p_data
+			= (struct devfreq_passive_data *)devfreq->data;
+	struct devfreq *parent = (struct devfreq *)p_data->parent;
+	struct notifier_block *nb = &p_data->nb;
+
+	nb->notifier_call = devfreq_passive_notifier_call;
+	return devfreq_register_notifier(parent, nb, DEVFREQ_TRANSITION_NOTIFIER);
+}
+
 static int devfreq_passive_event_handler(struct devfreq *devfreq,
 				unsigned int event, void *data)
 {
 	struct devfreq_passive_data *p_data
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq *parent = (struct devfreq *)p_data->parent;
-	struct notifier_block *nb = &p_data->nb;
-	int ret = 0;
+	int ret = -EINVAL;
+
+	if (!p_data)
+		return -EINVAL;
 
-	if (!parent)
+	if (p_data->parent_type == DEVFREQ_PARENT_DEV && !parent)
 		return -EPROBE_DEFER;
 
 	switch (event) {
@@ -148,13 +419,16 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 		if (!p_data->this)
 			p_data->this = devfreq;
 
-		nb->notifier_call = devfreq_passive_notifier_call;
-		ret = devfreq_register_notifier(parent, nb,
-					DEVFREQ_TRANSITION_NOTIFIER);
+		if (p_data->parent_type == DEVFREQ_PARENT_DEV)
+			ret = devfreq_passive_register_notifier(devfreq);
+		else if (p_data->parent_type == CPUFREQ_PARENT_DEV)
+			ret = cpufreq_passive_register_notifier(devfreq);
 		break;
 	case DEVFREQ_GOV_STOP:
-		WARN_ON(devfreq_unregister_notifier(parent, nb,
-					DEVFREQ_TRANSITION_NOTIFIER));
+		if (p_data->parent_type == DEVFREQ_PARENT_DEV)
+			WARN_ON(devfreq_passive_unregister_notifier(devfreq));
+		else if (p_data->parent_type == CPUFREQ_PARENT_DEV)
+			WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
 		break;
 	default:
 		break;
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 142474b4af96..ccebb5c84d62 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -38,6 +38,7 @@ enum devfreq_timer {
 
 struct devfreq;
 struct devfreq_governor;
+struct devfreq_cpu_data;
 struct thermal_cooling_device;
 
 /**
@@ -288,6 +289,11 @@ struct devfreq_simple_ondemand_data {
 #endif
 
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
+enum devfreq_parent_dev_type {
+	DEVFREQ_PARENT_DEV,
+	CPUFREQ_PARENT_DEV,
+};
+
 /**
  * struct devfreq_passive_data - ``void *data`` fed to struct devfreq
  *	and devfreq_add_device
@@ -299,8 +305,11 @@ struct devfreq_simple_ondemand_data {
  *			using governors except for passive governor.
  *			If the devfreq device has the specific method to decide
  *			the next frequency, should use this callback.
- * @this:	the devfreq instance of own device.
- * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
+ + * @parent_type	parent type of the device.
+ + * @this:		the devfreq instance of own device.
+ + * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER or
+ *			CPUFREQ_TRANSITION_NOTIFIER list.
+ + * @cpu_data:		the state min/max/current frequency of all online cpu's
  *
  * The devfreq_passive_data have to set the devfreq instance of parent
  * device with governors except for the passive governor. But, don't need to
@@ -314,9 +323,13 @@ struct devfreq_passive_data {
 	/* Optional callback to decide the next frequency of passvice device */
 	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
 
+	/* Should set the type of parent device */
+	enum devfreq_parent_dev_type parent_type;
+
 	/* For passive governor's internal use. Don't need to set them */
 	struct devfreq *this;
 	struct notifier_block nb;
+	struct devfreq_cpu_data *parent_cpu_data[NR_CPUS];
 };
 #endif
 
-- 
2.25.1

