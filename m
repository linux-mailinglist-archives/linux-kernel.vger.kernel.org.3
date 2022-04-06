Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042A24F5EC7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiDFNAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiDFM63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:58:29 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C73310FADF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1TIWjCH9iLAoWGL6cC066JmLZym1X2Wccalj/3cuqS5Kc18J0j7egHKs5GahqcIH7njTSr/2f8Ngv1GMwSElvpl2M+F+6wypiH5NJ/IsnUUPjz0izfh8kIpEt6awRlKfmpP0TO42UrhOEYMQMSLX6gpIjEfbDI5t4fqNjaiSrl4MvqO23fB0y16qZL7adMmcMQLliRyM1REbMkTjY6zLuH0n3QlrKeIw9sCV892dluuog4E4lFoV8iyth7rBCo+E3o8a34KtHyIi9t1BjvwoglWjF6PDuFBsYFTKlnUvazZAlbczdTqrO/d3ir9/mYTU+FY+khiCU0TwVle75k25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ST8KbV98AMko2q33WnfOiaMU315u2L//VB4PmVKpbgk=;
 b=Oc8Xh1j2wa2mg7hbr/+qC+T6bhVJf31574gWhK6NyaHWljILrKPxosUBKn0WuaHjd5n+FoGxKcUfhJsDEmIg3Ex64PUlKCETvysHLj0HDXODPLAU+eGQHk6wjL2zZGr5NkdmR4R01eTkQMLFQIwH6fjukk83IjcrT3icXQEfhUZQCi/5/UXI1L1aORmjlSfj4JTBfRI1Dz3kdMUcOcxAkwtqV6Xmfh1tTQTh17ndWfqELDGdqeP7NBj8DGKUfkZ9QBy4Z4WYkWEkklMB5blQ2qaIojc0jQ+oO4klIT10n0SKmlkyQJPn0P/gA0qjOgopXjfMlM+nHyh+Uu8P6//xqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ST8KbV98AMko2q33WnfOiaMU315u2L//VB4PmVKpbgk=;
 b=QYOE9e3QaCf5uLq6aKFu/vPLIXAgM0tQ/uPA7KOY03QApHAdYpY578Q6v1HIajHF0niV24uFtJy0XRsUXesaubmdF6fTbrvWD4p1NaBsddHLB+voeslQWV9Iv89qMGBkHdRKAEj7gp4qLlwS1tNXOjx5xSu8d0sGHIVmoACRrcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3243.apcprd06.prod.outlook.com (2603:1096:100:35::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 09:18:21 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5144.019; Wed, 6 Apr 2022
 09:18:21 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     wangqing <11112896@bbktel.com>, Wang Qing <wangqing@vivo.com>
Subject: [PATCH] arch_topology: support parsing cache topology from DT
Date:   Wed,  6 Apr 2022 02:18:00 -0700
Message-Id: <1649236680-4340-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0063.jpnprd01.prod.outlook.com
 (2603:1096:405:2::27) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 093e6a28-d6bd-4ba2-0d88-08da17ae6535
X-MS-TrafficTypeDiagnostic: SL2PR06MB3243:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB3243D50B6C5B3490881CB767BDE79@SL2PR06MB3243.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kGo9FzPMnK8U2CbklaYQbwraxY4rpTK6svyeLMvuSIzLxSeQubPVG5ofjYR85J36/N2BDFQHm+CFp27kfJ+8ald/QD5N0vJBKXMNgYPOPKrsWd3XJ2zkBU5KjelV/zjcIR083+oZ0MXCXUPKN4fAwewkgPUoHY+/3RvBQvVdQ3MbfIx5ePUYalmhhccQIwqoEpuD4L6bsfCm0QyzBOdz2RJSEG+1wbxp9ivDHkbfT209uHQ/aDb6wNVA3aIbUgYhPyGkCE+62hTk+Z4fPMzoJ9eYU55AiX3RAVkDlGZo7KYVc1zEBjo/UhIAN3wgHE7kjX4SDZcDMxZOO9xZXbslLUsH7pfueCl+IBBpwr/Snf77lbUucRdR5Li9CayRpMujZ/Ph1yiIL429WpMLK+2/oi+lKsDmjarUY2MmxKP3Eu/op88Pt7NqKIm9092laQglnLPByad7KpykPL11O3y4HGOiJY2M8BsyglAQh79rqMh1r1pYN6u2Z9q9JgIxe0cgZxi4ZoF+9kcNFB7KKbF+EKATY8DqAR8phHg7Uz81YLI/0c/iM/m1g2iCt5hES5oxslzVGmZJeHbYFEd0P1CLVGTUIxejTXjU9cZsjbstKjirC+E6qqouYt/b0kPBKWiziaO8KiiozQqsMf9V16+TPQ0OlHOgHBfTSVx+jq/FbiUzlzx/vgK7jlOYmRAeMuFizylCK1nuHJi2dus7xrpouw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(6486002)(26005)(186003)(8676002)(66556008)(4326008)(36756003)(66946007)(107886003)(110136005)(508600001)(316002)(2616005)(54906003)(8936002)(6512007)(6506007)(86362001)(2906002)(83380400001)(38350700002)(38100700002)(52116002)(5660300002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RSwTJp1+GLGZJP6eTaeFde9lE/7u+3pNLATvBMp0dTQdFcDWqtsIzV6FK6yZ?=
 =?us-ascii?Q?Y8qJFIiplwmkx8J5JOhnnbme5fNtnsRl6UuqtQnt7jLuUwY2KPDIX2gAg7Kw?=
 =?us-ascii?Q?jQGPbE4CKcKBZuqg99KYgHawiiMSsyZ/D/w1unvAcbiTffVf92dl5K97wdkE?=
 =?us-ascii?Q?OCupteV84d/3z3FxKRZrvBRkajeVJpAEGpwKCajgSmL+pK4QFnVIyvxWGUxv?=
 =?us-ascii?Q?cK8KGUKfcEplQEtDK+lK9OSlaJ4flEBFQhw44huY4RV1sQ689uPCjdQeKDnj?=
 =?us-ascii?Q?NvFctlZEPUWMc/ffHvWFtABajSnwMe4OxWr+okHO/i7QRO7b9pQSsf/J4zZB?=
 =?us-ascii?Q?pAmF+FctYNbDdlam0wVl9WwLoyIQStADXcOSsHeZ6ijz82g5lqB+Y1rQviTm?=
 =?us-ascii?Q?e4pfyNNq4sS5nCoINv0IzJNLHhihChylFxbdLOcsltuaKwSZ0ME8huINXRwt?=
 =?us-ascii?Q?fgEYWPv0LHqlIxSeplYtGN3tpwzuLey4Nx6UTg3unW1iM33dMDJ/tRDB8bCM?=
 =?us-ascii?Q?mS1oWpF3jV19nQ9fqghxwZo9dtpjW+UsBPcidjQ5wxAtJwVapihielp6ujpu?=
 =?us-ascii?Q?tfPCLjEoedgMiMCAcELMWxxFmDMF1H3D2PD3XYH++gBiuWypTGmagNbYyLzv?=
 =?us-ascii?Q?+6HEIv9EVj1Nddn+FyiSUsuNC7u7/kMD5wMBuABUHwLZBQ/CyAApwSxzH2zO?=
 =?us-ascii?Q?PfHmpgfcVmF7i9SfSnjXp68k0Nfe6J3LkH7h7P3UcvEKVILDw6EV8ZN3+/KU?=
 =?us-ascii?Q?5uNqtk6lxA8VEhILAo463Oa8EmMiJzlEuMBIuQX5T8D81zUXc5vG5m5ddLCO?=
 =?us-ascii?Q?yrN2AQPplixarrJV8gHZyDSvLHdNCjejLBfI4LX7XwcBjZcA/bPmY7iEq/bu?=
 =?us-ascii?Q?ySfoCFyb+6U/GkJ3xVskdj7ho8f8VpZLBGbme+9OlnPwzu68jZjQ9IYqZD9D?=
 =?us-ascii?Q?B8rosxYja7OWyO8zZ9RwGAFBnAYs5woebQzuCRCevNw0b884D/hf6FIF2Vkg?=
 =?us-ascii?Q?+Sovnyr56YV1yv62fHBhsIBVxTvrRXS+QsgmPhnzN83zH21feVcVK6SbJVFq?=
 =?us-ascii?Q?lSaR34zXRg0EeSqoOJNTUqK9g55t4KVH1WuDjFiJEXlxwzejo3ysLlSXl0bR?=
 =?us-ascii?Q?7g6y5jTVNZf4EMNHRwVLUXl9fsV35lOIleUV0IzOfcOENmEcRs1pSVu8Usqy?=
 =?us-ascii?Q?djYCVHvAk9QIvBMpPX9BeST7WPjnwVn4zuXvBJcQO8SMfWaee8qX1gIc4y8F?=
 =?us-ascii?Q?34e6qD7bEYLaii1PtUteBs7VQ20n6L/3aJQ5QYp0lm9zTy1OoYtRs+IhDApe?=
 =?us-ascii?Q?ggBkdY8Uy78ZkMdPlQhvqHSquhsTR3QaKzLJ/YXWJU6tpTECA5FkQ7Utbt5y?=
 =?us-ascii?Q?EX1CZR286AWm3p4XQY2Hti/Eb7ev/HvxVXGD9Zs0GwmCn9Ppb4YGUF6yDL5Y?=
 =?us-ascii?Q?RZCD5HJMfMpq4oi86BIJY5ddr4EJxT5X7OX0zj3ndkOWHlEsoZEPD7mv86Jh?=
 =?us-ascii?Q?CvR5rmePgSGdf4gDPdvs7HDylEOkYAWuoNy6KwU7meh7k9yu2rwdQgjXlpmG?=
 =?us-ascii?Q?Hr1i+it50we5cVlqYiFoTObU0FEBTLqocqlqpb6CokVyqTwVmJ4Dh418tJwV?=
 =?us-ascii?Q?yBt5Hfpwyn/RKvwF3sHYEpjo7hVy7CfgeEuoBtwE6riVukjCWHcUY+vNrHBg?=
 =?us-ascii?Q?YX8wA90UZseLWjXcWpqHkw/vDGatEAeyXk3q+S1oVa2Sc9t4e/SHqMbtAJKD?=
 =?us-ascii?Q?0Jbzghodyg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093e6a28-d6bd-4ba2-0d88-08da17ae6535
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 09:18:21.7320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYXgnx8x9Jml0wMt+0rHPgefIv17l7XRAQJ2q/vHeEVrLfH9ylOFRKNxXB2PlD+3ifmb9t5qelawQq7P7pcbIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3243
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wangqing <11112896@bbktel.com>

When ACPI is not enabled, we can parse cache topolopy from DT:
*		cpu0: cpu@000 {
*			next-level-cache = <&L2_1>;
*			L2_1: l2-cache {
* 				compatible = "cache";
*				next-level-cache = <&L3_1>;
* 			};
*			L3_1: l3-cache {
* 				compatible = "cache";
* 			};
*		};
*
*		cpu1: cpu@001 {
*			next-level-cache = <&L2_1>;
*		};
*		cpu2: cpu@002 {
*			L2_2: l2-cache {
* 				compatible = "cache";
*				next-level-cache = <&L3_1>;
*			};
*		};
*
*		cpu3: cpu@003 {
*			next-level-cache = <&L2_2>;
*		};
cache_topology hold the pointer describing "next-level-cache", 
it can describe the cache topology of every level.

Expand the use of llc_sibling when ACPI is not enabled.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/base/arch_topology.c  | 63 +++++++++++++++++++++++++++++++++--
 include/linux/arch_topology.h |  3 ++
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1d6636ebaac5..d633184429f2 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -647,6 +647,64 @@ static int __init parse_dt_topology(void)
 }
 #endif
 
+/*
+ * cpu cache topology table
+ */
+#define MAX_CACHE_LEVEL 7
+struct device_node *cache_topology[NR_CPUS][MAX_CACHE_LEVEL];
+
+void init_cpu_cache_topology(void)
+{
+	struct device_node *node_cpu, *node_cache;
+	int cpu;
+	int level = 0;
+
+	for_each_possible_cpu(cpu) {
+		node_cpu = of_get_cpu_node(cpu, NULL);
+		if (!node_cpu)
+			continue;
+
+		level = 0;
+		node_cache = node_cpu;
+		while (level < MAX_CACHE_LEVEL) {
+			node_cache = of_parse_phandle(node_cache, "next-level-cache", 0);
+			if (!node_cache)
+				break;
+
+			cache_topology[cpu][level++] = node_cache;
+		}
+		of_node_put(node_cpu);
+	}
+}
+
+bool cpu_share_llc(int cpu1, int cpu2)
+{
+	int cache_level;
+
+	for (cache_level = MAX_CACHE_LEVEL - 1; cache_level > 0; cache_level--) {
+		if (!cache_topology[cpu1][cache_level])
+			continue;
+
+		if (cache_topology[cpu1][cache_level] == cache_topology[cpu2][cache_level])
+			return true;
+
+		return false;
+	}
+
+	return false;
+}
+
+bool cpu_share_l2c(int cpu1, int cpu2)
+{
+	if (!cache_topology[cpu1][0])
+		return false;
+
+	if (cache_topology[cpu1][0] == cache_topology[cpu2][0])
+		return true;
+
+	return false;
+}
+
 /*
  * cpu topology table
  */
@@ -662,7 +720,7 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
 		/* not numa in package, lets use the package siblings */
 		core_mask = &cpu_topology[cpu].core_sibling;
 	}
-	if (cpu_topology[cpu].llc_id != -1) {
+	if (cpu_topology[cpu].llc_id != -1 || cache_topology[cpu][0]) {
 		if (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
 			core_mask = &cpu_topology[cpu].llc_sibling;
 	}
@@ -684,7 +742,8 @@ void update_siblings_masks(unsigned int cpuid)
 	for_each_online_cpu(cpu) {
 		cpu_topo = &cpu_topology[cpu];
 
-		if (cpuid_topo->llc_id == cpu_topo->llc_id) {
+		if ((cpuid_topo->llc_id != -1 && cpuid_topo->llc_id == cpu_topo->llc_id)
+			|| (cpuid_topo->llc_id == -1 && cpu_share_llc(cpu, cpuid))) {
 			cpumask_set_cpu(cpu, &cpuid_topo->llc_sibling);
 			cpumask_set_cpu(cpuid, &cpu_topo->llc_sibling);
 		}
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 58cbe18d825c..df670d5fc03b 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -86,6 +86,7 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
 #define topology_cluster_cpumask(cpu)	(&cpu_topology[cpu].cluster_sibling)
 #define topology_llc_cpumask(cpu)	(&cpu_topology[cpu].llc_sibling)
 void init_cpu_topology(void);
+void init_cpu_cache_topology(void);
 void store_cpu_topology(unsigned int cpuid);
 const struct cpumask *cpu_coregroup_mask(int cpu);
 const struct cpumask *cpu_clustergroup_mask(int cpu);
@@ -93,6 +94,8 @@ void update_siblings_masks(unsigned int cpu);
 void remove_cpu_topology(unsigned int cpuid);
 void reset_cpu_topology(void);
 int parse_acpi_topology(void);
+bool cpu_share_llc(int cpu1, int cpu2);
+bool cpu_share_l2c(int cpu1, int cpu2);
 #endif
 
 #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
-- 
2.27.0.windows.1

