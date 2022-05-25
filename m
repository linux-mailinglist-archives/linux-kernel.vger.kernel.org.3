Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFE353381A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbiEYIOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbiEYIOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:14:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 420697CDD3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:14:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3E361042;
        Wed, 25 May 2022 01:14:35 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 427F33F73D;
        Wed, 25 May 2022 01:14:34 -0700 (PDT)
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
Subject: [PATCH v3 02/16] cacheinfo: Add helper to access any cache index for a given CPU
Date:   Wed, 25 May 2022 09:14:02 +0100
Message-Id: <20220525081416.3306043-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525081416.3306043-2-sudeep.holla@arm.com>
References: <20220525081416.3306043-1-sudeep.holla@arm.com>
 <20220525081416.3306043-2-sudeep.holla@arm.com>
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

The cacheinfo for a given CPU at a given index is used at quite a few
places by fetching the base point for index 0 using the helper
per_cpu_cacheinfo(cpu) and offseting it by the required index.

Instead, add another helper to fetch the required pointer directly and
use it to simplify and improve readability.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/cacheinfo.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index b0bde272e2ae..c4547d8ac6f3 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -25,6 +25,8 @@ static DEFINE_PER_CPU(struct cpu_cacheinfo, ci_cpu_cacheinfo);
 #define ci_cacheinfo(cpu)	(&per_cpu(ci_cpu_cacheinfo, cpu))
 #define cache_leaves(cpu)	(ci_cacheinfo(cpu)->num_leaves)
 #define per_cpu_cacheinfo(cpu)	(ci_cacheinfo(cpu)->info_list)
+#define per_cpu_cacheinfo_idx(cpu, idx)		\
+				(per_cpu_cacheinfo(cpu) + (idx))
 
 struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu)
 {
@@ -172,7 +174,7 @@ static int cache_setup_of_node(unsigned int cpu)
 	}
 
 	while (index < cache_leaves(cpu)) {
-		this_leaf = this_cpu_ci->info_list + index;
+		this_leaf = per_cpu_cacheinfo_idx(cpu, index);
 		if (this_leaf->level != 1)
 			np = of_find_next_cache_node(np);
 		else
@@ -231,7 +233,7 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 	for (index = 0; index < cache_leaves(cpu); index++) {
 		unsigned int i;
 
-		this_leaf = this_cpu_ci->info_list + index;
+		this_leaf = per_cpu_cacheinfo_idx(cpu, index);
 		/* skip if shared_cpu_map is already populated */
 		if (!cpumask_empty(&this_leaf->shared_cpu_map))
 			continue;
@@ -242,7 +244,7 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 
 			if (i == cpu || !sib_cpu_ci->info_list)
 				continue;/* skip if itself or no cacheinfo */
-			sib_leaf = sib_cpu_ci->info_list + index;
+			sib_leaf = per_cpu_cacheinfo_idx(i, index);
 			if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
 				cpumask_set_cpu(cpu, &sib_leaf->shared_cpu_map);
 				cpumask_set_cpu(i, &this_leaf->shared_cpu_map);
@@ -258,12 +260,11 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 
 static void cache_shared_cpu_map_remove(unsigned int cpu)
 {
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *this_leaf, *sib_leaf;
 	unsigned int sibling, index;
 
 	for (index = 0; index < cache_leaves(cpu); index++) {
-		this_leaf = this_cpu_ci->info_list + index;
+		this_leaf = per_cpu_cacheinfo_idx(cpu, index);
 		for_each_cpu(sibling, &this_leaf->shared_cpu_map) {
 			struct cpu_cacheinfo *sib_cpu_ci;
 
@@ -609,7 +610,6 @@ static int cache_add_dev(unsigned int cpu)
 	int rc;
 	struct device *ci_dev, *parent;
 	struct cacheinfo *this_leaf;
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	const struct attribute_group **cache_groups;
 
 	rc = cpu_cache_sysfs_init(cpu);
@@ -618,7 +618,7 @@ static int cache_add_dev(unsigned int cpu)
 
 	parent = per_cpu_cache_dev(cpu);
 	for (i = 0; i < cache_leaves(cpu); i++) {
-		this_leaf = this_cpu_ci->info_list + i;
+		this_leaf = per_cpu_cacheinfo_idx(cpu, i);
 		if (this_leaf->disable_sysfs)
 			continue;
 		if (this_leaf->type == CACHE_TYPE_NOCACHE)
-- 
2.36.1

