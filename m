Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEA857B6E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbiGTM4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbiGTM4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:56:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DD93140FA;
        Wed, 20 Jul 2022 05:56:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5C3C15BF;
        Wed, 20 Jul 2022 05:56:04 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AFC883F70D;
        Wed, 20 Jul 2022 05:56:02 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        Guenter Roeck <linux@roeck-us.net>, linux-acpi@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Subject: [PATCH v3 2/3] ACPI: PPTT: Leave the table mapped for the runtime usage
Date:   Wed, 20 Jul 2022 13:55:39 +0100
Message-Id: <20220720-arch_topo_fixes-v3-2-43d696288e84@arm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220720-arch_topo_fixes-v3-0-43d696288e84@arm.com>
References: <20220720-arch_topo_fixes-v3-0-43d696288e84@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, everytime an information needs to be fetched from the PPTT,
the table is mapped via acpi_get_table() and unmapped after the use via
acpi_put_table() which is fine. However we do this at runtime especially
when the CPU is hotplugged out and plugged in back since we re-populate
the cache topology and other information.

However, with the support to fetch LLC information from the PPTT in the
cpuhotplug path which is executed in the atomic context, it is preferred
to avoid mapping and unmapping of the PPTT for every single use as the
acpi_get_table() might sleep waiting for a mutex.

In order to avoid the same, the table is needs to just mapped once on
the boot CPU and is never unmapped allowing it to be used at runtime
with out the hassle of mapping and unmapping the table.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

--

Hi Rafael,

Sorry to bother you again on this PPTT changes. Guenter reported an issue
with lockdep enabled in -next that include my cacheinfo/arch_topology changes
to utilise LLC from PPTT in the CPU hotplug path.

Please ack the change once you are happy so that I can get it merged with
other fixes via Greg's tree.

Regards,
Sudeep

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index dd3222a15c9c..c91342dcbcd6 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -533,21 +533,37 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
 	return -ENOENT;
 }
 
+
+static struct acpi_table_header *acpi_get_pptt(void)
+{
+	static struct acpi_table_header *pptt;
+	acpi_status status;
+
+	/*
+	 * PPTT will be used at runtime on every CPU hotplug in path, so we
+	 * don't need to call acpi_put_table() to release the table mapping.
+	 */
+	if (!pptt) {
+		status = acpi_get_table(ACPI_SIG_PPTT, 0, &pptt);
+		if (ACPI_FAILURE(status))
+			acpi_pptt_warn_missing();
+	}
+
+	return pptt;
+}
+
 static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
 {
 	struct acpi_table_header *table;
-	acpi_status status;
 	int retval;
 
-	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
-	if (ACPI_FAILURE(status)) {
-		acpi_pptt_warn_missing();
+	table = acpi_get_pptt();
+	if (!table)
 		return -ENOENT;
-	}
+
 	retval = topology_get_acpi_cpu_tag(table, cpu, level, flag);
 	pr_debug("Topology Setup ACPI CPU %d, level %d ret = %d\n",
 		 cpu, level, retval);
-	acpi_put_table(table);
 
 	return retval;
 }
@@ -568,16 +584,13 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
 static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
 {
 	struct acpi_table_header *table;
-	acpi_status status;
 	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
 	struct acpi_pptt_processor *cpu_node = NULL;
 	int ret = -ENOENT;
 
-	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
-	if (ACPI_FAILURE(status)) {
-		acpi_pptt_warn_missing();
-		return ret;
-	}
+	table = acpi_get_pptt();
+	if (!table)
+		return -ENOENT;
 
 	if (table->revision >= rev)
 		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
@@ -585,8 +598,6 @@ static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
 	if (cpu_node)
 		ret = (cpu_node->flags & flag) != 0;
 
-	acpi_put_table(table);
-
 	return ret;
 }
 
@@ -605,18 +616,15 @@ int acpi_find_last_cache_level(unsigned int cpu)
 	u32 acpi_cpu_id;
 	struct acpi_table_header *table;
 	int number_of_levels = 0;
-	acpi_status status;
+
+	table = acpi_get_pptt();
+	if (!table)
+		return -ENOENT;
 
 	pr_debug("Cache Setup find last level CPU=%d\n", cpu);
 
 	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
-	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
-	if (ACPI_FAILURE(status)) {
-		acpi_pptt_warn_missing();
-	} else {
-		number_of_levels = acpi_find_cache_levels(table, acpi_cpu_id);
-		acpi_put_table(table);
-	}
+	number_of_levels = acpi_find_cache_levels(table, acpi_cpu_id);
 	pr_debug("Cache Setup find last level level=%d\n", number_of_levels);
 
 	return number_of_levels;
@@ -638,20 +646,16 @@ int acpi_find_last_cache_level(unsigned int cpu)
 int cache_setup_acpi(unsigned int cpu)
 {
 	struct acpi_table_header *table;
-	acpi_status status;
-
-	pr_debug("Cache Setup ACPI CPU %d\n", cpu);
 
-	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
-	if (ACPI_FAILURE(status)) {
-		acpi_pptt_warn_missing();
+	table = acpi_get_pptt();
+	if (!table)
 		return -ENOENT;
-	}
+
+	pr_debug("Cache Setup ACPI CPU %d\n", cpu);
 
 	cache_setup_acpi_cpu(table, cpu);
-	acpi_put_table(table);
 
-	return status;
+	return 0;
 }
 
 /**
@@ -730,50 +734,38 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
 int find_acpi_cpu_topology_cluster(unsigned int cpu)
 {
 	struct acpi_table_header *table;
-	acpi_status status;
 	struct acpi_pptt_processor *cpu_node, *cluster_node;
 	u32 acpi_cpu_id;
 	int retval;
 	int is_thread;
 
-	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
-	if (ACPI_FAILURE(status)) {
-		acpi_pptt_warn_missing();
+	table = acpi_get_pptt();
+	if (!table)
 		return -ENOENT;
-	}
 
 	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
 	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
-	if (cpu_node == NULL || !cpu_node->parent) {
-		retval = -ENOENT;
-		goto put_table;
-	}
+	if (!cpu_node || !cpu_node->parent)
+		return -ENOENT;
 
 	is_thread = cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_IS_THREAD;
 	cluster_node = fetch_pptt_node(table, cpu_node->parent);
-	if (cluster_node == NULL) {
-		retval = -ENOENT;
-		goto put_table;
-	}
+	if (!cluster_node)
+		return -ENOENT;
+
 	if (is_thread) {
-		if (!cluster_node->parent) {
-			retval = -ENOENT;
-			goto put_table;
-		}
+		if (!cluster_node->parent)
+			return -ENOENT;
+
 		cluster_node = fetch_pptt_node(table, cluster_node->parent);
-		if (cluster_node == NULL) {
-			retval = -ENOENT;
-			goto put_table;
-		}
+		if (!cluster_node)
+			return -ENOENT;
 	}
 	if (cluster_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID)
 		retval = cluster_node->acpi_processor_id;
 	else
 		retval = ACPI_PTR_DIFF(cluster_node, table);
 
-put_table:
-	acpi_put_table(table);
-
 	return retval;
 }
 

-- 
b4 0.10.0-dev-54fef
