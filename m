Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BDE565209
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbiGDKSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbiGDKRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:17:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B08CE030
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:16:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30ED5D6E;
        Mon,  4 Jul 2022 03:16:59 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0613B3F792;
        Mon,  4 Jul 2022 03:16:56 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, conor.dooley@microchip.com,
        valentina.fernandezalanis@microchip.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6 21/21] ACPI: Remove the unused find_acpi_cpu_cache_topology()
Date:   Mon,  4 Jul 2022 11:16:05 +0100
Message-Id: <20220704101605.1318280-22-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220704101605.1318280-1-sudeep.holla@arm.com>
References: <20220704101605.1318280-1-sudeep.holla@arm.com>
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

The sole user of this find_acpi_cpu_cache_topology() was arm64 topology
which is now consolidated into the generic arch_topology without the need
of this function.

Drop the unused function find_acpi_cpu_cache_topology().

Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/pptt.c  | 37 -------------------------------------
 include/linux/acpi.h |  5 -----
 2 files changed, 42 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 763f021d45e6..dd3222a15c9c 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -691,43 +691,6 @@ int find_acpi_cpu_topology(unsigned int cpu, int level)
 	return find_acpi_cpu_topology_tag(cpu, level, 0);
 }
 
-/**
- * find_acpi_cpu_cache_topology() - Determine a unique cache topology value
- * @cpu: Kernel logical CPU number
- * @level: The cache level for which we would like a unique ID
- *
- * Determine a unique ID for each unified cache in the system
- *
- * Return: -ENOENT if the PPTT doesn't exist, or the CPU cannot be found.
- * Otherwise returns a value which represents a unique topological feature.
- */
-int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
-{
-	struct acpi_table_header *table;
-	struct acpi_pptt_cache *found_cache;
-	acpi_status status;
-	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
-	struct acpi_pptt_processor *cpu_node = NULL;
-	int ret = -1;
-
-	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
-	if (ACPI_FAILURE(status)) {
-		acpi_pptt_warn_missing();
-		return -ENOENT;
-	}
-
-	found_cache = acpi_find_cache_node(table, acpi_cpu_id,
-					   CACHE_TYPE_UNIFIED,
-					   level,
-					   &cpu_node);
-	if (found_cache)
-		ret = ACPI_PTR_DIFF(cpu_node, table);
-
-	acpi_put_table(table);
-
-	return ret;
-}
-
 /**
  * find_acpi_cpu_topology_package() - Determine a unique CPU package value
  * @cpu: Kernel logical CPU number
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4f82a5bc6d98..7b96a8bff6d2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1429,7 +1429,6 @@ int find_acpi_cpu_topology(unsigned int cpu, int level);
 int find_acpi_cpu_topology_cluster(unsigned int cpu);
 int find_acpi_cpu_topology_package(unsigned int cpu);
 int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
-int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
 #else
 static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
 {
@@ -1451,10 +1450,6 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
 {
 	return -EINVAL;
 }
-static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
-{
-	return -EINVAL;
-}
 #endif
 
 #ifdef CONFIG_ACPI_PCC
-- 
2.37.0

