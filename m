Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E212533818
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240320AbiEYIPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbiEYIOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:14:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB93E81998
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:14:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CC4423A;
        Wed, 25 May 2022 01:14:40 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 85AE33F73D;
        Wed, 25 May 2022 01:14:38 -0700 (PDT)
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
Subject: [PATCH v3 04/16] cacheinfo: Add support to check if last level cache(LLC) is valid or shared
Date:   Wed, 25 May 2022 09:14:04 +0100
Message-Id: <20220525081416.3306043-5-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525081416.3306043-4-sudeep.holla@arm.com>
References: <20220525081416.3306043-1-sudeep.holla@arm.com>
 <20220525081416.3306043-2-sudeep.holla@arm.com>
 <20220525081416.3306043-3-sudeep.holla@arm.com>
 <20220525081416.3306043-4-sudeep.holla@arm.com>
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

It is useful to have helper to check if the given two CPUs share last level
cache. We can do that check by comparing fw_token or by comparing the cache
ID. Currently we check just for fw_token as the cache ID is optional.

This helper can be used to build the llc_sibling during arch specific
topology parsing and feeding information to the sched_domains. This also
helps to get rid of llc_id in the CPU topology as it is sort of duplicate
information.

Also add helper to check if the llc information in cacheinfo is valid or not.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/cacheinfo.c  | 26 ++++++++++++++++++++++++++
 include/linux/cacheinfo.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 417e1ebf5525..ed74db18468f 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -47,6 +47,32 @@ static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 	return sib_leaf->fw_token == this_leaf->fw_token;
 }
 
+bool last_level_cache_is_valid(unsigned int cpu)
+{
+	struct cacheinfo *llc;
+
+	if (!cache_leaves(cpu))
+		return false;
+
+	llc = per_cpu_cacheinfo_idx(cpu, cache_leaves(cpu) - 1);
+
+	return llc->fw_token;
+}
+
+bool last_level_cache_is_shared(unsigned int cpu_x, unsigned int cpu_y)
+{
+	struct cacheinfo *llc_x, *llc_y;
+
+	if (!last_level_cache_is_valid(cpu_x) ||
+	    !last_level_cache_is_valid(cpu_y))
+		return false;
+
+	llc_x = per_cpu_cacheinfo_idx(cpu_x, cache_leaves(cpu_x) - 1);
+	llc_y = per_cpu_cacheinfo_idx(cpu_y, cache_leaves(cpu_y) - 1);
+
+	return cache_leaves_are_shared(llc_x, llc_y);
+}
+
 #ifdef CONFIG_OF
 /* OF properties to query for a given cache type */
 struct cache_type_info {
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 4ff37cb763ae..7e429bc5c1a4 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -82,6 +82,8 @@ struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
 int init_cache_level(unsigned int cpu);
 int populate_cache_leaves(unsigned int cpu);
 int cache_setup_acpi(unsigned int cpu);
+bool last_level_cache_is_valid(unsigned int cpu);
+bool last_level_cache_is_shared(unsigned int cpu_x, unsigned int cpu_y);
 #ifndef CONFIG_ACPI_PPTT
 /*
  * acpi_find_last_cache_level is only called on ACPI enabled
-- 
2.36.1

