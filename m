Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C1F4B04B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 05:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiBJE7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 23:59:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiBJE66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 23:58:58 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EC31F6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 20:59:00 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id d18-20020a9d51d2000000b005a09728a8c2so3028062oth.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 20:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rEjmJFMNh9IQm8dtWbQTvDdM437tEa4s5NElVG565pw=;
        b=OwrqedecyktT/3v6gq7Esl+6hdKaH7VQnsE4eqS1IFppKK9mFc0eFQVDgRMMGCVV4p
         qrcQb8XJRo1NIwMtyyuzs2Rrg0K+wLd6z/rZahX/F2Pz/AaX58OFXz6vjQ+9/xwSub5W
         qSINAbwFA1Jk1ww1d1QXZoeEyLCYYZVVuiRYleFb3n4kGVoFc83652O+aPz/GSRiCQKO
         y4vERDNn7rRWn0fiMTRUNJvZv6k9wnD5sZETIz4O0wg0QbfLbDjtteT6DfexE+rAY2+y
         G2oln+nAJ8qiOUEeRwrdeW7FI9cNSa9akwBSQ1b6EPC/v4p3R9My6xdQQ2dJbIAhIOR/
         CfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rEjmJFMNh9IQm8dtWbQTvDdM437tEa4s5NElVG565pw=;
        b=dkspg+DGBfbYlXKSVevAg0umBT73Y6e9K1a4y92+QymMm9hzGebNrt+VLhxjReofEL
         J6Px1JduSF84HJ8MJBdg3TEaiGwgvhaqpyfxowB4gN6fo1AL1h3MCWFEQnSxAR9KuZhS
         eQzwnDUhKOTPt0nJNd2whR2e+FqEehv63LMotNNldYnljzO4KQAcqniCT829nd4bFD8K
         9/ATMC1CYG6+VJtJO9qCMlTm5t0fayyaFIDoUKB2kFAf1phGMUUo4H/B/i5ywxLfJSOn
         gaarcozY7yAUdCiPNaQoL6xY5jZ0jaNW7Ev1lH9En2ryrLYsniZe+bjMyqIq7iiuISPN
         CWgw==
X-Gm-Message-State: AOAM531WN7KrgHzBDOd97oRazyXdfOQ0ZtzQCO0HJhOsyby7qMHeKRkF
        0RABQX6u/NRkJqPvD000FGyYPvCFc5gMTg==
X-Google-Smtp-Source: ABdhPJxrwfdfPFCNzFRaI1TLvD5ToWqehkssypEQUuRp9LRC9ggZ8kzc5P2CeIZ7uOI/KmDXzscNtA==
X-Received: by 2002:a05:6830:4c9:: with SMTP id s9mr2389657otd.12.1644469139953;
        Wed, 09 Feb 2022 20:58:59 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id t13sm2453201oai.37.2022.02.09.20.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 20:58:59 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: qcom-hw: Add support for per-core-dcvs
Date:   Wed,  9 Feb 2022 21:01:17 -0800
Message-Id: <20220210050117.747569-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OSM and EPSS hardware controls the frequency of each cluster in the
system based on requests from the OS and various limiting factors, such
as input from LMH.

In most systems the vote from the OS is done using a single register per
cluster, but some systems are configured to instead take one request per
core.  In this configuration a set of consecutive registers are used for
the OS to request the frequency of each of the cores within the cluster.
The information is then aggregated in the hardware and the frequency for
the cluster is determined.

As the current implementation ends up only requesting a frequency for
the first core in each cluster and only the vote of non-idle cores are
considered it's often the case that the cluster will be clocked (much)
lower than expected.

It's possible that there are benefits of performing the per-core
requests from the OS, but more investigation of the outcome is needed
before introducing such support. As such this patch extends the request
for the cluster to be written to all the cores.

The weight of the policy's related_cpus is used to determine how many
cores, and hence consecutive registers, each cluster has.

The OS is not permitted to disable the per-core dcvs feature.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 05f3d7876e44..8d2b65c782e6 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -28,6 +28,7 @@
 
 struct qcom_cpufreq_soc_data {
 	u32 reg_enable;
+	u32 reg_dcvs_ctrl;
 	u32 reg_freq_lut;
 	u32 reg_volt_lut;
 	u32 reg_current_vote;
@@ -50,6 +51,8 @@ struct qcom_cpufreq_data {
 	bool cancel_throttle;
 	struct delayed_work throttle_work;
 	struct cpufreq_policy *policy;
+
+	bool per_core_dcvs;
 };
 
 static unsigned long cpu_hw_rate, xo_rate;
@@ -102,9 +105,14 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 	struct qcom_cpufreq_data *data = policy->driver_data;
 	const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
 	unsigned long freq = policy->freq_table[index].frequency;
+	unsigned int i;
 
 	writel_relaxed(index, data->base + soc_data->reg_perf_state);
 
+	if (data->per_core_dcvs)
+		for (i = 1; i < cpumask_weight(policy->related_cpus); i++)
+			writel_relaxed(index, data->base + soc_data->reg_perf_state + i * 4);
+
 	if (icc_scaling_enabled)
 		qcom_cpufreq_set_bw(policy, freq);
 
@@ -137,10 +145,15 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 	struct qcom_cpufreq_data *data = policy->driver_data;
 	const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
 	unsigned int index;
+	unsigned int i;
 
 	index = policy->cached_resolved_idx;
 	writel_relaxed(index, data->base + soc_data->reg_perf_state);
 
+	if (data->per_core_dcvs)
+		for (i = 1; i < cpumask_weight(policy->related_cpus); i++)
+			writel_relaxed(index, data->base + soc_data->reg_perf_state + i * 4);
+
 	return policy->freq_table[index].frequency;
 }
 
@@ -342,6 +355,7 @@ static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
 
 static const struct qcom_cpufreq_soc_data qcom_soc_data = {
 	.reg_enable = 0x0,
+	.reg_dcvs_ctrl = 0xbc,
 	.reg_freq_lut = 0x110,
 	.reg_volt_lut = 0x114,
 	.reg_current_vote = 0x704,
@@ -351,6 +365,7 @@ static const struct qcom_cpufreq_soc_data qcom_soc_data = {
 
 static const struct qcom_cpufreq_soc_data epss_soc_data = {
 	.reg_enable = 0x0,
+	.reg_dcvs_ctrl = 0xb0,
 	.reg_freq_lut = 0x100,
 	.reg_volt_lut = 0x200,
 	.reg_perf_state = 0x320,
@@ -481,6 +496,9 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		goto error;
 	}
 
+	if (readl_relaxed(base + data->soc_data->reg_dcvs_ctrl) & 0x1)
+		data->per_core_dcvs = true;
+
 	qcom_get_related_cpus(index, policy->cpus);
 	if (!cpumask_weight(policy->cpus)) {
 		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
-- 
2.33.1

