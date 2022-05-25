Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E35533819
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242746AbiEYIPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbiEYIOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:14:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05F828215E
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:14:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A73FD1FB;
        Wed, 25 May 2022 01:14:42 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CC98F3F73D;
        Wed, 25 May 2022 01:14:40 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 05/16] cacheinfo: Allow early detection and population of cache attributes
Date:   Wed, 25 May 2022 09:14:05 +0100
Message-Id: <20220525081416.3306043-6-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525081416.3306043-5-sudeep.holla@arm.com>
References: <20220525081416.3306043-1-sudeep.holla@arm.com>
 <20220525081416.3306043-2-sudeep.holla@arm.com>
 <20220525081416.3306043-3-sudeep.holla@arm.com>
 <20220525081416.3306043-4-sudeep.holla@arm.com>
 <20220525081416.3306043-5-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architecture/platforms may need to setup cache properties very
early in the boot along with other cpu topologies so that all these
information can be used to build sched_domains which is used by the
scheduler.

Allow detect_cache_attributes to be called quite early during the boot.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/cacheinfo.c  | 45 ++++++++++++++++++++++++---------------
 include/linux/cacheinfo.h |  1 +
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index ed74db18468f..976142f3e81d 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -193,14 +193,8 @@ static int cache_setup_of_node(unsigned int cpu)
 {
 	struct device_node *np;
 	struct cacheinfo *this_leaf;
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	unsigned int index = 0;
 
-	/* skip if fw_token is already populated */
-	if (this_cpu_ci->info_list->fw_token) {
-		return 0;
-	}
-
 	np = of_cpu_device_node_get(cpu);
 	if (!np) {
 		pr_err("Failed to find cpu%d device node\n", cpu);
@@ -236,6 +230,18 @@ int __weak cache_setup_acpi(unsigned int cpu)
 
 unsigned int coherency_max_size;
 
+static int cache_setup_properties(unsigned int cpu)
+{
+	int ret = 0;
+
+	if (of_have_populated_dt())
+		ret = cache_setup_of_node(cpu);
+	else if (!acpi_disabled)
+		ret = cache_setup_acpi(cpu);
+
+	return ret;
+}
+
 static int cache_shared_cpu_map_setup(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
@@ -246,21 +252,21 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 	if (this_cpu_ci->cpu_map_populated)
 		return 0;
 
-	if (of_have_populated_dt())
-		ret = cache_setup_of_node(cpu);
-	else if (!acpi_disabled)
-		ret = cache_setup_acpi(cpu);
-
-	if (ret)
-		return ret;
+	/*
+	 * skip setting up cache properties if LLC is valid, just need
+	 * to update the shared cpu_map if the cache attributes were
+	 * populated early before all the cpus are brought online
+	 */
+	if (!last_level_cache_is_valid(cpu)) {
+		ret = cache_setup_properties(cpu);
+		if (ret)
+			return ret;
+	}
 
 	for (index = 0; index < cache_leaves(cpu); index++) {
 		unsigned int i;
 
 		this_leaf = per_cpu_cacheinfo_idx(cpu, index);
-		/* skip if shared_cpu_map is already populated */
-		if (!cpumask_empty(&this_leaf->shared_cpu_map))
-			continue;
 
 		cpumask_set_cpu(cpu, &this_leaf->shared_cpu_map);
 		for_each_online_cpu(i) {
@@ -330,10 +336,13 @@ int __weak populate_cache_leaves(unsigned int cpu)
 	return -ENOENT;
 }
 
-static int detect_cache_attributes(unsigned int cpu)
+int detect_cache_attributes(unsigned int cpu)
 {
 	int ret;
 
+	if (per_cpu_cacheinfo(cpu)) /* Already setup */
+		goto update_cpu_map;
+
 	if (init_cache_level(cpu) || !cache_leaves(cpu))
 		return -ENOENT;
 
@@ -349,6 +358,8 @@ static int detect_cache_attributes(unsigned int cpu)
 	ret = populate_cache_leaves(cpu);
 	if (ret)
 		goto free_ci;
+
+update_cpu_map:
 	/*
 	 * For systems using DT for cache hierarchy, fw_token
 	 * and shared_cpu_map will be set up here only if they are
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 7e429bc5c1a4..00b7a6ae8617 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -84,6 +84,7 @@ int populate_cache_leaves(unsigned int cpu);
 int cache_setup_acpi(unsigned int cpu);
 bool last_level_cache_is_valid(unsigned int cpu);
 bool last_level_cache_is_shared(unsigned int cpu_x, unsigned int cpu_y);
+int detect_cache_attributes(unsigned int cpu);
 #ifndef CONFIG_ACPI_PPTT
 /*
  * acpi_find_last_cache_level is only called on ACPI enabled
-- 
2.36.1

