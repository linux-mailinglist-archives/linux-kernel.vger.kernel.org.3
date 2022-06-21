Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA61F553A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346495AbiFUTVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353270AbiFUTU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:20:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9D031163
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:20:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8F571688;
        Tue, 21 Jun 2022 12:20:56 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A1F9C3F792;
        Tue, 21 Jun 2022 12:20:54 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Gavin Shan <gshan@redhat.com>
Subject: [PATCH v4 05/20] cacheinfo: Add support to check if last level cache(LLC) is valid or shared
Date:   Tue, 21 Jun 2022 20:20:19 +0100
Message-Id: <20220621192034.3332546-6-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621192034.3332546-1-sudeep.holla@arm.com>
References: <20220621192034.3332546-1-sudeep.holla@arm.com>
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

It is useful to have helper to check if the given two CPUs share last level
cache. We can do that check by comparing fw_token or by comparing the cache
ID. Currently we check just for fw_token as the cache ID is optional.

This helper can be used to build the llc_sibling during arch specific
topology parsing and feeding information to the sched_domains. This also
helps to get rid of llc_id in the CPU topology as it is sort of duplicate
information.

Also add helper to check if the llc information in cacheinfo is valid or not.

Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/cacheinfo.c  | 26 ++++++++++++++++++++++++++
 include/linux/cacheinfo.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 2cea9201f31c..fdc1baa342f1 100644
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
+	return !!llc->fw_token;
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

