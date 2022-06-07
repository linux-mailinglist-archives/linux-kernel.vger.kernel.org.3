Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FEE53FE5A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243555AbiFGMIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243441AbiFGMH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:07:56 -0400
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F918A305
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:07:44 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="75590270"
X-IronPort-AV: E=Sophos;i="5.91,283,1647270000"; 
   d="scan'208";a="75590270"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 07 Jun 2022 21:07:41 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id E57B4D63B8;
        Tue,  7 Jun 2022 21:07:40 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1C6D5BF4BA;
        Tue,  7 Jun 2022 21:07:40 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id D44CA40080208;
        Tue,  7 Jun 2022 21:07:39 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rafael@kernel.org, lenb@kernel.org,
        gregkh@linuxfoundation.org, mchehab+huawei@kernel.org,
        eugenis@google.com, tony.luck@intel.com, pcc@google.com,
        peterz@infradead.org, marcos@orca.pet, marcan@marcan.st,
        linus.walleij@linaro.org, nicolas.ferre@microchip.com,
        conor.dooley@microchip.com, arnd@arndb.de, ast@kernel.org,
        peter.chen@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v5 3/6] arm64: Create cache sysfs directory without ACPI PPTT for hardware prefetch control
Date:   Tue,  7 Jun 2022 21:05:27 +0900
Message-Id: <20220607120530.2447112-4-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a cache sysfs directory without ACPI PPTT if the CPU model is
A64FX and CONFIG_ALLOW_INCOMPLETE_CACHE_SYSFS is true. Currentry,
CONFIG_ALLOW_INCOMPLETE_CACHE_SYSFS is set only when
CONFIG_A64FX_HWPF_CONTROL is enabled.

Hardware prefetch control driver need cache sysfs directory and cache
level/type information. In ARM processor, these information can be
obtained from the register even without PPTT.

This patch set the cpu_map_populated to true if the machine doesn't
have PPTT. It use only the level/type information obtained from
CLIDR_EL1, and don't use CCSIDR information.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 arch/arm64/kernel/cacheinfo.c | 27 +++++++++++++++++++++++++++
 drivers/acpi/pptt.c           | 18 ++++++++++++++++++
 include/linux/acpi.h          |  5 +++++
 include/linux/cacheinfo.h     | 10 ++++++++++
 4 files changed, 60 insertions(+)

diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index 587543c6c51c..3b337a425acb 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -43,6 +43,30 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 	this_leaf->type = type;
 }
 
+static const struct midr_range allow_list[] = {
+	MIDR_ALL_VERSIONS(MIDR_FUJITSU_A64FX),
+};
+
+/*
+ * This function works only for FUJITSU A64FX processor.
+ * If CONFIG_ALLOW_INCOMPLETE_CACHE_SYSFS is not defined, do nothing.
+ *
+ * Hardware prefetch functions need cache sysfs directory and cache
+ * level/type information. In ARM processor, these information can be
+ * obtained from registers even without PPTT. Therefore, we set the
+ * cpu_map_populated to true to create cache sysfs directory, if the
+ * machine doesn't have PPTT.
+ */
+static void allow_incomplete_cache_sysfs(struct cpu_cacheinfo *cpu_ci)
+{
+	if (!is_midr_in_range_list(read_cpuid_id(), allow_list))
+		return;
+
+	if (!acpi_disabled)
+		if (!acpi_has_pptt())
+			enable_cpu_map_populated(cpu_ci);
+}
+
 int init_cache_level(unsigned int cpu)
 {
 	unsigned int ctype, level, leaves, fw_level;
@@ -95,5 +119,8 @@ int populate_cache_leaves(unsigned int cpu)
 			ci_leaf_init(this_leaf++, type, level);
 		}
 	}
+
+	allow_incomplete_cache_sysfs(this_cpu_ci);
+
 	return 0;
 }
diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 701f61c01359..fcd7295b81d7 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -838,3 +838,21 @@ int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
 	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
 					  ACPI_PPTT_ACPI_IDENTICAL);
 }
+
+/**
+ * acpi_has_pptt() - Determine if ACPI has PPTT table or not
+ *
+ * Return: true if ACPI has PPTT, false if ACPI doesn't have PPTT.
+ */
+bool acpi_has_pptt(void)
+{
+	struct acpi_table_header *table;
+	acpi_status status;
+
+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	acpi_put_table(table);
+	return true;
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d7136d13aa44..9daea11edad7 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1391,6 +1391,7 @@ int find_acpi_cpu_topology_cluster(unsigned int cpu);
 int find_acpi_cpu_topology_package(unsigned int cpu);
 int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
 int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
+bool acpi_has_pptt(void);
 #else
 static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
 {
@@ -1416,6 +1417,10 @@ static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
 {
 	return -EINVAL;
 }
+static inline bool acpi_has_pptt(void)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_ACPI_PCC
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 4ff37cb763ae..71f89da6792b 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -99,6 +99,16 @@ static inline int acpi_find_last_cache_level(unsigned int cpu)
 int acpi_find_last_cache_level(unsigned int cpu);
 #endif
 
+#ifndef CONFIG_ALLOW_INCOMPLETE_CACHE_SYSFS
+#define enable_cpu_map_populated(cpu_ci)
+#else
+static inline void enable_cpu_map_populated(struct cpu_cacheinfo *cpu_ci)
+{
+	cpu_ci->cpu_map_populated = true;
+}
+#endif
+
+
 const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
 
 /*
-- 
2.27.0

