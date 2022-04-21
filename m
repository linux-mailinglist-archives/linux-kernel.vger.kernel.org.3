Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722FD50A377
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389890AbiDUO7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389889AbiDUO7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:59:15 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2130.outbound.protection.outlook.com [40.107.255.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B8143392
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZdoS5unFcFKHMne+S3Yt6rGbjFTYhXktlyga76df0MigXMdVSDzVln02qmCrPCkEXcHt9K2GKtAodb7sA124CkHyzFF62e7v14y3eiXJCzDf6Lr/d+SmxTV9ylKOAwGhEII7FVbtTZ6YQac4JHU+/MAyOizSEQIrnvVAmh3Qzdp2kJ6mAiJbx4aVHIkZLjLfZvVsWQS6FLUCS6LvV7GJPSTbjeqh2b5su7N/DXy9v50cbOrV8Ev0nqFoIi2ctvKE2em0w3gP+5bKuzoHGo3X6xq4sFbN+XU+6Bm5xNtlA7VzmPZkUyt05nRo7KCMjE5VAtZoBOCH2+G4p9OSSY8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lG7GujFQ3G2m6t6zFmUVTK6QBc7XZFqnRgjwNENWCUI=;
 b=LG77RayVxJqrQQr0CN2E2Xls7NWPPA88ausbJlfnXiw7IWCiq1bGGjC4gNJLidtOTWooF7F6kn2tpiyA0EV8DcXPG6BypILcCLxfUa7Gu1+dB+ZdWYVGt0BilwGd3PPpZTVm9KxchlEjA5OeOvI+R50U2C8dYVCI0lA3ozo7KjlT6xEkzsi4xfn2uGQCzFN94vQrB93Ri2qlV28g3tDacLlb5DrsTjIL7lqX8XmfExRqVsOPlDoS7ULuq66QsIX2VtiEul2kVsDbegyR5eT3qrp0kfsyvdsPOi0ScGUZZuuuzrhyPqivju6ybxNz0ZKmlvBdm8i8rZh7OYbo8KpX5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG7GujFQ3G2m6t6zFmUVTK6QBc7XZFqnRgjwNENWCUI=;
 b=Ly6357oaOI4XHNw1bV7fn4hVgVM3eA3WbQOdOh8PSvgUNegiPZ9HfwFjtUOgJI087sxd1RZzwaI0dM3aQTP/6oWLJCbkn+hVAvmKSxqys8ydHdV0Qpfb3nryT1WomemGTur3VQ2KkbFCQpIDwVtK6t3/LeYnlDJnWnJY9MYm6Iw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by KL1PR0601MB4308.apcprd06.prod.outlook.com (2603:1096:820:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 14:56:22 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 14:56:22 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH 1/2] arch_topology: support for describing cache topology from DT
Date:   Thu, 21 Apr 2022 07:55:57 -0700
Message-Id: <1650552960-60165-2-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650552960-60165-1-git-send-email-wangqing@vivo.com>
References: <1650552960-60165-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:404:56::17) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e098ae7-9425-4fde-9901-08da23a71980
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4308:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB4308FCFFA9FAC28548D034C8BDF49@KL1PR0601MB4308.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXWuqiXzwQSAHnADQQXOVJPnNFo+DFShzWw0oLj3OwEbT1/RP2iAFkjFgAgwITIzk42kOMah+qDJx//swCHjQmcM99yH3VcF8ELYP/tXxdAkS6PN5hbdVotyxcXCx0GCK8JUqgM0wjlLAaN9p6bmKIqUfQ6YCHh03tWrddrIZ859zSzfzX3164T+0cJ5q6UUL3X504t++cni4DlAzWnordMOMl9nvdUC90+l6XhOaSYjYcDEnoyeICkDNsOlZK6imp9TxBrkpko8MLOH5AnpH1WJKpTLazreIArwYR/dEIfTRgAVKWyCAacvImrHYPN2LQGhAGzq74+IJcIPC0qz8o4NsKAmCwUQqE/VSIOoIsQtuIccYMl1+IfvWTEq2oHOX0+ZcJbYcINnU3MPbingDcoasDX8th1nCMnRh/MyBuN/eF7l9Y0ZIhwYxrN3EqUga3JN+Y9DohV6REsfuAtlBrM0h0LfHqe3yCt5YsY1qTTksgNjB4+NnlHOPC3JEVxcf5iVVAQ2eZyev+q2DOylkCUJ6fq3R/eMqIj6eUz4F9Fk6tr4DSvRsZPLTXI4ZyBCJtgDgvVCwPW9/c7p5v5Lcw6G+i8dlOrczZIVZliOwXi1zybC420E/CfGdY8l34duagz+DC4X+MOAAZGjTEMOvR0fUccGhJdrElI/SNjbDsiZPhqx/1dd16ATePxVvglqL/c7F+zD2yDmc+TC7KW8vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(38100700002)(38350700002)(8936002)(508600001)(26005)(86362001)(316002)(110136005)(52116002)(107886003)(4326008)(186003)(66556008)(36756003)(83380400001)(6506007)(66946007)(6512007)(2906002)(5660300002)(66476007)(2616005)(6666004)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9EnqdZPGUcV3ZoDeiHLmJyu5Cnx8zmoWq/SDcXZx1L5RkpjMlj1+36GtSIUE?=
 =?us-ascii?Q?E1V+3SB/WgxevEs9Kw7ek1cz9QJJfqAghEpMHIsEKq5TE0SFUpUqNrgxWcO/?=
 =?us-ascii?Q?OKhB+X9CbEe9yLdzSU+sTh+RB1wbMvKjaQ5liP/E6QEfW8T7qQbyYM20+PM7?=
 =?us-ascii?Q?3fna0AA006uulskif9IGlUAjZPeOosEwNTytiPKhmU96FsnslfogeaAuteMi?=
 =?us-ascii?Q?HlNnEJLc1kHje1I+xHY4M0H4OVkFtzxS9BKi2I9YqnWJE/KK7fmnEkuQlZLt?=
 =?us-ascii?Q?Q8DkK7wnrd05C2fxecn3RuO5vd415WKoWHs7urG5i939xwYFt5SJ1npkUazj?=
 =?us-ascii?Q?MDEch9Dp0WeL+IowWsURGqH0yK2Oqog5FrkTXeoZrFvBT7mB8lvZEnmXMpDJ?=
 =?us-ascii?Q?bm3oXIvLe9lpUL4WdUi2z5dvUrll3L+ah54hP8m8qf6EkeWQdPcon4zY2lh7?=
 =?us-ascii?Q?f416UHguJc/I4DmKbIPQuE/SNyoyWHKPSNTb/55edQJdhVzkCLQuFjpxV3r9?=
 =?us-ascii?Q?367DPfg1eYdUyBPwJvT6BJnEsFlShtkCAfKTCfuBaQtgBkFd90GJBAT8DpTO?=
 =?us-ascii?Q?bzbZKt2MaSop/OyKvYt5Ui6x3M7boEkLQB7zEG33yDDl3iq+/8qqW8JLSDx5?=
 =?us-ascii?Q?Nc+rvFDyJ0VyVPyNlZ5xL9974Ke9sipAz2XbBc23q47RWbNxnTqFkt4WhtDK?=
 =?us-ascii?Q?oJfBUe+ditGtdj7ftr++URXSNmCQbD6Qoqr3/j3i5h+DpPYQveNX/eq71ehF?=
 =?us-ascii?Q?fIFE1KY/T68BiQfhOhnrM08m1tHb3/Ry4RlsFOPy1TmxPDV4k/369vwW93Ol?=
 =?us-ascii?Q?cYCsOJ5x2W+7Opny4u9aILK8B6CNugVmYQq69XzIU7KJPuC875ONfn8CYKzD?=
 =?us-ascii?Q?+YYsxbUiH/7nIonQ2RC5IxYhQbrxekaweNo1VbWllQfcMu6SYx1yKeIyQW+5?=
 =?us-ascii?Q?4QLBOX6w0g5fkiMPs/r/nMOiB1CXRqZZ9p806hCeA4P8lfVFFagp3Q2jDDhd?=
 =?us-ascii?Q?BlIldnBizt59CLLzP2YYlejgODtHrtncF/HWOeSzTKafTnBPswy0eVf19+3Y?=
 =?us-ascii?Q?QiifVfryXQMHm+9Q3lr4SD/7QfULGS9AbB58w2vjozp4UghdnosJ+CPC/P8f?=
 =?us-ascii?Q?OkpHfT+ZKNRvcPJ12I9xFXa+m3tjdNtEkmTWEbn3kaQ4Dt2PXPP6HJUL+cL8?=
 =?us-ascii?Q?/FdyqHUfF3lXv9FGRkDbxg4pUmtn4YDgqbwwj0g6HGN4GZ9uDGSuD1dIMY4a?=
 =?us-ascii?Q?z8SULdhGi6UMe65BV908TsG7ZwTsXSsGcArkmpBB3SnQRvfPB2ybyo51qU0P?=
 =?us-ascii?Q?0T7uQxPpASoQn8hOgo8WTCDY9fQrKqT6OE5TDWxWrd5NNs25DotsTOzA3aFe?=
 =?us-ascii?Q?Ztpi6zn1A4fzwbIUg4L0Nhk+RkZX4hs5Uw0kTlZJB/s+62O0bZJ+EoKL8Hnz?=
 =?us-ascii?Q?3nsRD198B4e/MChJFQR6rSctyFJOhzpFHk9MnoWYplYTlFcBnq+1XtLrU+Cu?=
 =?us-ascii?Q?vcYlYO5SEg5nz4WakF6yvUPuOTKeJoo5WcO7lpp+CNNT4X1qzomAXGoJDFdY?=
 =?us-ascii?Q?Xh0w8TNWdpwypUYD3BgZiMZCIY2KdXtowFeJO0bcTWqooCIXR/B5CVHjvgFq?=
 =?us-ascii?Q?C/2zccxDmDaGfou4TmcVRvxJNDoM8SGKIW4hYxsPCT37bqGqfg4QYWXJxGNs?=
 =?us-ascii?Q?DLf3kBISzWUT83ClI/3pHlXRlLoDpt2nRZtK0CKnLmeftfF89sRNFej0CJYT?=
 =?us-ascii?Q?S1P7uVnDQA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e098ae7-9425-4fde-9901-08da23a71980
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 14:56:22.2433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUaaUybHOrKuh0oVHZAqdJPjaFX1yAbAGhrXjr8K6MMP8CHLfZYWxE7VJlBBILe0KWR+exhn/UIX60i2vdnMjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4308
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

When ACPI is not enabled, we can get cache topolopy from DT like:
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
*		...
*		};
cache_topology hold the pointer describing "next-level-cache", 
it can describe the cache topology of every level.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/base/arch_topology.c  | 47 ++++++++++++++++++++++++++++++++++-
 include/linux/arch_topology.h |  3 +++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1d6636ebaac5..46e84ce2ec0c 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -480,8 +480,10 @@ static int __init get_cpu_for_node(struct device_node *node)
 		return -1;
 
 	cpu = of_cpu_node_to_id(cpu_node);
-	if (cpu >= 0)
+	if (cpu >= 0) {
 		topology_parse_cpu_capacity(cpu_node, cpu);
+		topology_parse_cpu_caches(cpu_node, cpu);
+	}
 	else
 		pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
 			cpu_node, cpumask_pr_args(cpu_possible_mask));
@@ -647,6 +649,49 @@ static int __init parse_dt_topology(void)
 }
 #endif
 
+/*
+ * cpu cache topology table
+ */
+#define MAX_CACHE_LEVEL 7
+staic struct device_node *cache_topology[NR_CPUS][MAX_CACHE_LEVEL];
+
+void topology_parse_cpu_caches(struct device_node *cpu_node, int cpu)
+{
+	struct device_node *node_cache = cpu_node;
+	int level = 0;
+
+	while (level < MAX_CACHE_LEVEL) {
+		node_cache = of_parse_phandle(node_cache, "next-level-cache", 0);
+		if (!node_cache)
+			break;
+
+		cache_topology[cpu][level++] = node_cache;
+	}
+}
+
+/*
+ * find the maximum level shared cache under giving mask
+ */
+void find_max_sub_sc(const struct cpumask *giving_mask, int cpu,
+					  struct cpumask *sc_mask)
+{
+	int cache_level, cpu_id;
+
+	for (cache_level = MAX_CACHE_LEVEL - 1; cache_level >= 0; cache_level--) {
+		if (!cache_topology[cpu][cache_level])
+			continue;
+
+		cpumask_clear(sc_mask);
+		for (cpu_id = 0; cpu_id < NR_CPUS; cpu_id++) {
+			if (cache_topology[cpu][cache_level] == cache_topology[cpu_id][cache_level])
+				cpumask_set_cpu(cpu_id, sc_mask);
+		}
+
+		if (cpumask_subset(sc_mask, giving_mask))
+			break;
+	}
+}
+
 /*
  * cpu topology table
  */
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 58cbe18d825c..c6ed727e453c 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -93,6 +93,9 @@ void update_siblings_masks(unsigned int cpu);
 void remove_cpu_topology(unsigned int cpuid);
 void reset_cpu_topology(void);
 int parse_acpi_topology(void);
+void topology_parse_cpu_caches(struct device_node *cpu_node, int cpu);
+void find_max_sub_sc(const struct cpumask *giving_mask, int cpu,
+					  struct cpumask *sc_mask);
 #endif
 
 #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
-- 
2.27.0.windows.1

