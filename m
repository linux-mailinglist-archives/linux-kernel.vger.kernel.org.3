Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CA153381B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbiEYIO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbiEYIOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:14:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6093B7CDD3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:14:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 225A51FB;
        Wed, 25 May 2022 01:14:38 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 474293F73D;
        Wed, 25 May 2022 01:14:36 -0700 (PDT)
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
Subject: [PATCH v3 03/16] cacheinfo: Move cache_leaves_are_shared out of CONFIG_OF
Date:   Wed, 25 May 2022 09:14:03 +0100
Message-Id: <20220525081416.3306043-4-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525081416.3306043-3-sudeep.holla@arm.com>
References: <20220525081416.3306043-1-sudeep.holla@arm.com>
 <20220525081416.3306043-2-sudeep.holla@arm.com>
 <20220525081416.3306043-3-sudeep.holla@arm.com>
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

cache_leaves_are_shared is already used even with ACPI and PPTT. It checks
if the cache leaves are the shared based on fw_token pointer. However it is
defined conditionally only if CONFIG_OF is enabled which is wrong.

Move the function cache_leaves_are_shared out of CONFIG_OF and keep it
generic. It also handles the case where both OF and ACPI is not defined.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/cacheinfo.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index c4547d8ac6f3..417e1ebf5525 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -33,13 +33,21 @@ struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu)
 	return ci_cacheinfo(cpu);
 }
 
-#ifdef CONFIG_OF
 static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 					   struct cacheinfo *sib_leaf)
 {
+	/*
+	 * For non DT/ACPI systems, assume unique level 1 caches,
+	 * system-wide shared caches for all other levels. This will be used
+	 * only if arch specific code has not populated shared_cpu_map
+	 */
+	if (!IS_ENABLED(CONFIG_OF) && !(IS_ENABLED(CONFIG_ACPI)))
+		return !(this_leaf->level == 1);
+
 	return sib_leaf->fw_token == this_leaf->fw_token;
 }
 
+#ifdef CONFIG_OF
 /* OF properties to query for a given cache type */
 struct cache_type_info {
 	const char *size_prop;
@@ -193,16 +201,6 @@ static int cache_setup_of_node(unsigned int cpu)
 }
 #else
 static inline int cache_setup_of_node(unsigned int cpu) { return 0; }
-static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
-					   struct cacheinfo *sib_leaf)
-{
-	/*
-	 * For non-DT/ACPI systems, assume unique level 1 caches, system-wide
-	 * shared caches for all other levels. This will be used only if
-	 * arch specific code has not populated shared_cpu_map
-	 */
-	return !(this_leaf->level == 1);
-}
 #endif
 
 int __weak cache_setup_acpi(unsigned int cpu)
-- 
2.36.1

