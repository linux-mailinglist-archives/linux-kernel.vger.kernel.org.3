Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD8052B753
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiERJej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbiERJeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:34:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AF5CB042C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:34:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90D0C1063;
        Wed, 18 May 2022 02:34:06 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DDDBB3F66F;
        Wed, 18 May 2022 02:34:04 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 7/8] of: base: add support to get the device node for the CPU's last level cache
Date:   Wed, 18 May 2022 10:33:24 +0100
Message-Id: <20220518093325.2070336-8-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220518093325.2070336-1-sudeep.holla@arm.com>
References: <20220518093325.2070336-1-sudeep.holla@arm.com>
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

It is useful to have helper function just to get the pointer to the device
node of the last level cache for a given logical cpu. It can be used as
unique firmware identifier for the last level cache.

This is useful to obtain the cpumask/cpumap of all the CPUs sharing the last
level cache using the device node pointer as unique identifier for the last
level cache.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/of/base.c  | 33 +++++++++++++++++++++++++--------
 include/linux/of.h |  1 +
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index d4f98c8469ed..0b6a8c3f9a85 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2072,17 +2072,17 @@ struct device_node *of_find_next_cache_node(const struct device_node *np)
 }
 
 /**
- * of_find_last_cache_level - Find the level at which the last cache is
- * 		present for the given logical cpu
+ * of_find_last_level_cache_node - Find the device node at which the last
+ *		cache is present for the given logical cpu
  *
- * @cpu: cpu number(logical index) for which the last cache level is needed
+ * @cpu: cpu number(logical index) for which the last cache level's device
+ * node is needed
  *
- * Return: The the level at which the last cache is present. It is exactly
- * same as  the total number of cache levels for the given logical cpu.
+ * Return: The device node corresponding to the last cache for the  given
+ * logical cpu
  */
-int of_find_last_cache_level(unsigned int cpu)
+struct device_node *of_find_last_level_cache_node(unsigned int cpu)
 {
-	u32 cache_level = 0;
 	struct device_node *prev = NULL, *np = of_cpu_device_node_get(cpu);
 
 	while (np) {
@@ -2091,7 +2091,24 @@ int of_find_last_cache_level(unsigned int cpu)
 		np = of_find_next_cache_node(np);
 	}
 
-	of_property_read_u32(prev, "cache-level", &cache_level);
+	return prev;
+}
+
+/**
+ * of_find_last_cache_level - Find the level at which the last cache is
+ *		present for the given logical cpu
+ *
+ * @cpu: cpu number(logical index) for which the last cache level is needed
+ *
+ * Return: The level at which the last cache is present. It is exactly
+ * same as  the total number of cache levels for the given logical cpu.
+ */
+int of_find_last_cache_level(unsigned int cpu)
+{
+	u32 cache_level = 0;
+	struct device_node *np = of_find_last_level_cache_node(cpu);
+
+	of_property_read_u32(np, "cache-level", &cache_level);
 
 	return cache_level;
 }
diff --git a/include/linux/of.h b/include/linux/of.h
index 04971e85fbc9..ca0384cf08a3 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -297,6 +297,7 @@ extern struct device_node *of_get_child_by_name(const struct device_node *node,
 
 /* cache lookup */
 extern struct device_node *of_find_next_cache_node(const struct device_node *);
+extern struct device_node *of_find_last_level_cache_node(unsigned int cpu);
 extern int of_find_last_cache_level(unsigned int cpu);
 extern struct device_node *of_find_node_with_property(
 	struct device_node *from, const char *prop_name);
-- 
2.36.1

