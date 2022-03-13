Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C884D7310
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 06:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiCMF4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 00:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiCMF4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 00:56:48 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12705C84A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 21:55:40 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d10-20020a17090a7bca00b001c5ed9a196bso706156pjl.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 21:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sFlYEAQckeRXon3Gb7dVboi70GiJgP07IOxKz1DUs5s=;
        b=pMOwCnvI12AKaRkWveBPimdXWZxUhOX8XXJtN07f7lfryegGQwbpP3kRdQIqw3UkEZ
         qdo+Nydo02HpHPQXtpV45dD+K0eSWI5WcSY37yGEfZBKpWyzkgw+OQImfr0XtqA/Krn+
         CTS65jz+XcKKtXJqn/q+VnfPnuAGRYc4gXzSLVwXHWE4nBz9n/A0amBHeRo3f0QgJazX
         k1OOQBD0UWQsUBbyyBkiz8z5Y3k/xD+8MIpKNg4FH2rx3rM2rXDYFc+dXjZ4sqHUXVS2
         vk0wx3tf3A1p11mcM505dNm4DvuIamZmTgo9mPfEplwX3nE3ZyBQLIo2i9W3XqTZJW2q
         9GZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sFlYEAQckeRXon3Gb7dVboi70GiJgP07IOxKz1DUs5s=;
        b=r8sMCEs5BhMxvBYxX/KITMZIoELvc7oj9U1fOqpnvnbfZ30cZqpb9nHgSLzHlxqSdM
         M6A8qByAf54l9Z4lAjDik1xj+ZKwlIgoiYKSuo8vzkmcbtoff6JHMZGABPbWE2yxSrzL
         oCIrtM71BxdJYZ1nzlkaZR5iKOu0i49VfnQDiYw2MgPw3HqhII4HaqRur2U1CfUDm/Wa
         YF4dgmbb4XeGQoQgRcDCVF8BgXJG3qSF6Ca8mGlMEOfG75t7tX/B1CAogprxebyQT9T4
         mG4PHvudISO8tOw69kifaSxd+3rUiNXH960WF8ej5qJENZDZW/Ec+udvYdbG3CzKkCCW
         WLOQ==
X-Gm-Message-State: AOAM530NATbZWlQA2CW2+n4AUEKFWpSBGF5GbW3qFustZNpGwozWt7uO
        +Wq3Tk3cmEskliF03MX9kEGWjA==
X-Google-Smtp-Source: ABdhPJxUaUZin7PI0oBHosSTs9vG81M1zq0t61rGjZDIiMfNvkfMZqCkbD4AYgfObTnqMDsnqleqWA==
X-Received: by 2002:a17:902:c94e:b0:151:a988:f3dd with SMTP id i14-20020a170902c94e00b00151a988f3ddmr18308247pla.142.1647150940242;
        Sat, 12 Mar 2022 21:55:40 -0800 (PST)
Received: from localhost.localdomain (104.225.159.237.16clouds.com. [104.225.159.237])
        by smtp.gmail.com with ESMTPSA id m11-20020a056a00080b00b004f75d5f9b5csm14792447pfk.26.2022.03.12.21.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 21:55:39 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 3/3] arch_topology: Scale CPU capacity if without CPU raw capacity
Date:   Sun, 13 Mar 2022 13:55:12 +0800
Message-Id: <20220313055512.248571-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220313055512.248571-1-leo.yan@linaro.org>
References: <20220313055512.248571-1-leo.yan@linaro.org>
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

Unlike a typical Arm big.LITTLE architecture, some Arm systems (like
Qualcomm SoC msm8996 and msm8939) have two clusters, all CPUs in two
clusters have the same micro architecture, but some CPUs are "fast" and
other are "slow".  On this kind platform, all CPUs have the same raw CPU
capacity but "fast" CPUs have higher maximum frequency than "slow" ones.

Let's see an example, there have two clusters and every cluster have 4
CPUs, every CPU has the same raw CPU capacity.  The cluster 0 has the
maximum frequency 1497.6MHz and the cluster 1 has the maximum frequency
1113.6MHz, if don't specify "capacity-dmips-mhz" in DT, the we will
get below result:

  # cat /sys/devices/system/cpu/cpu*/cpu_capacity
  1024
  1024
  1024
  1024
  1024
  1024
  1024
  1024

If "capacity-dmips-mhz" property is not specified for CPU nodes, the
kernel will fallback to default capacity value SCHED_CAPACITY_SCALE
(1024).  Though CPUs in different clusters have different maximum
frequencies, kernel skips to scale CPU capacity so that every CPU
capacity is always SCHED_CAPACITY_SCALE (1024).

This patch is to scale CPU capacity even though "capacity-dmips-mhz"
property is not specified in DT.  If "capacity-dmips-mhz" property is
absent in DT binding, the array "raw_capacity" is not allocated so we
rollback to use SCHED_CAPACITY_SCALE as raw CPU capacity and proceed
to scale CPU capacity based on maximum frequency.

After apply this patch, we can get below result for up elaborated
platform:

  # cat /sys/devices/system/cpu/cpu*/cpu_capacity
  1024
  1024
  1024
  1024
  761
  761
  761
  761

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/base/arch_topology.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 0687576e880b..ef1fa2e417ea 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -267,20 +267,25 @@ void topology_normalize_cpu_scale(void)
 {
 	u64 capacity;
 	u64 capacity_scale;
+	u32 raw_cpu_capacity;
 	int cpu;
 
-	if (!raw_capacity)
+	if (cap_parsing_failed)
 		return;
 
 	capacity_scale = 1;
 	for_each_possible_cpu(cpu) {
-		capacity = raw_capacity[cpu] * per_cpu(freq_factor, cpu);
+		raw_cpu_capacity =
+			raw_capacity ? raw_capacity[cpu] : SCHED_CAPACITY_SCALE;
+		capacity = raw_cpu_capacity * per_cpu(freq_factor, cpu);
 		capacity_scale = max(capacity, capacity_scale);
 	}
 
 	pr_debug("cpu_capacity: capacity_scale=%llu\n", capacity_scale);
 	for_each_possible_cpu(cpu) {
-		capacity = raw_capacity[cpu] * per_cpu(freq_factor, cpu);
+		raw_cpu_capacity =
+			raw_capacity ? raw_capacity[cpu] : SCHED_CAPACITY_SCALE;
+		capacity = raw_cpu_capacity * per_cpu(freq_factor, cpu);
 		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
 			capacity_scale);
 		topology_set_cpu_scale(cpu, capacity);
@@ -373,7 +378,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	struct cpufreq_policy *policy = data;
 	int cpu;
 
-	if (!raw_capacity)
+	if (cap_parsing_failed)
 		return 0;
 
 	if (val != CPUFREQ_CREATE_POLICY)
@@ -412,7 +417,7 @@ static int __init register_cpufreq_notifier(void)
 	 * until we have the necessary code to parse the cpu capacity, so
 	 * skip registering cpufreq notifier.
 	 */
-	if (!acpi_disabled || !raw_capacity)
+	if (!acpi_disabled || cap_parsing_failed)
 		return -EINVAL;
 
 	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL))
-- 
2.25.1

