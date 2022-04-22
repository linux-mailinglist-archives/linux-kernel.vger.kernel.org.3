Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA81A50B68F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447199AbiDVLzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447191AbiDVLy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:54:57 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2121.outbound.protection.outlook.com [40.107.215.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E985641A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 04:52:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYlZDSr76Y0RYcee4eKfE/oF8N8YcpNA7WZ00Lau9tcfZfSpvYawW3ygP8w9GhXf5fx92+AMSs/DQAAZTfxkbbAKKMjbjMtMss+nbaC7kj+Sz5zx0EByKeNoTVK3JBq9YZ6zq52QYzzwPY3Mzc2iKmLuC5q+CfLDUt3ZeKlcz5iGEYak/heNNGtRFmCUql96WYnq4kvex7L4sLrs9RJhdJqBxbidBY1cLhCVj8YNIQo/mfZcFrkt7zpBR+FcK9KEr5AthFymCBKfVbIevZlufFtcfl2MPQV8q95zI5EuCgJfloHRRnNm4cVOcz6wFeHNJM0msHpsEsDZOI/BOfF+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEh/N43wcd7+TXa1oLqICdwUmBYhS41l//LcqVrowRs=;
 b=mDEuS01iCc9Fx+Sx/4y0oqEtALMK65aefkKtAjOFK+zHa/ezg/6VihBWqAzEJSeINuXTTWw8gu0QC02bq2B3UbXTZQzXhh4Q3gfgwGSDt2XROmi5viWrinb55RuUQRKAR9H6lT+EoBORFYeDYjh02n7JNPPbL6R7N1iV9K1zBEFxvb/zYDXU4E/2kcwQDq8MPPWBDyy6dkO5cvNmTV97ceQjiP0547e9P/uikK5fcI1c4iIgb+5SfcaqNGDfpb2PMoOx7JdScy1K5L/SrZ6R698/fPWFrIzGjJBmryt+AV+bZCrzNHrYiJHBdFz39daXx3YCAsFi7iSEd0aLWBqgng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEh/N43wcd7+TXa1oLqICdwUmBYhS41l//LcqVrowRs=;
 b=mQKr5Xne/k9YZ3YyPGCW3hKOvWRqTwG5pWjrJpHZI4/LkO4RHOncSMo9RKKQTYlvyKYFssVlgVwTBDrxuqGuHcTsw6ZVLuD6tQiWUTTrujkcYtRl9J3nDLnbJPHRswbEZR1kYy3w98PbDKHDEITvh7pMnatBkd1/GHUXnNG28kM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SG2PR06MB3726.apcprd06.prod.outlook.com (2603:1096:4:d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 22 Apr
 2022 11:52:00 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 11:52:00 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        Wang Qing <wangqing@vivo.com>
Subject: [PATCH V2 1/2] arch_topology: support for parsing cache topology from DT
Date:   Fri, 22 Apr 2022 04:51:25 -0700
Message-Id: <1650628289-67716-2-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650628289-67716-1-git-send-email-wangqing@vivo.com>
References: <1650628289-67716-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:4:91::16) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9b041f7-210f-4763-5cdc-08da245682b8
X-MS-TrafficTypeDiagnostic: SG2PR06MB3726:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB3726237994E8B11D4C60AF9FBDF79@SG2PR06MB3726.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IjdHJJSG/0msW2x3zEyLnkTB5XMRn7exNE53byDXKjnJJ8Bfn5RMqmfeTGnQHVPUS26uYi/Y21NmdC//xHn4hLuMLSA9dEgqG9msbi2VuwVmE+cWunwdm9B5QdFhrBrY709ZfzijzndxpRhMmG11fpPgj/iWIzI+pECvy9cQICqiqWYDZ8FSHn0k57Sju9KQ8eiB+ycAYLKMPz2PogIoSfEC1mpWHb4dru27Hce/WUuLWZ7Et0QbMrfhFsOrFQRjvK7DTKA/g/orGSCaMJQEa9gFCmNHPdMYCzXwkcHu1DtlNGGCtMubVwrIxuQ0+OinatE7vAd3wDY/rru/ZI7pjJKQIRZImnXySlhoc4ASNFNJ+j1hko4nc+1wus+DYopjgbccYYIrx1cnqVGqRdegScCcIM19wTaCYu/2nsWcHJTIU5lNw3vMtI777TFcoHzrLvbd+1emjxQDKskLQhiifKCHMq8CIRBtYsdYkisQIifpN1eC7pb17bVdkwPeVVmzxkvnk+JkWONI6k525AQt4Y42QxcqwISrpxFPlWeQLO3OP4VDjw8061IXM1TBs334yGmtCC3u6AMq7fyTeeM5PGeNOEUEiAqXNLbUtp8rvDI4VgDglaOKUnNQ31AA0cGejbjc1IG0mmMOntMhAzfFlNLpPqJkV4pPwhmOWSeDY1T8YIf+RziqklOJx2KYI4Xra5tNrtbrKgxr20Cj8mzqug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(107886003)(66946007)(83380400001)(5660300002)(316002)(26005)(6666004)(6506007)(6512007)(6486002)(52116002)(508600001)(36756003)(66556008)(66476007)(86362001)(2616005)(110136005)(8936002)(8676002)(38100700002)(38350700002)(2906002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uKSUIAyTxsKdarHtMqKKQEf0IBjoGvsoAi8c2lx4OOixKlfIFDIi9UbDhZro?=
 =?us-ascii?Q?/wS0GHCycH2rDnHPcfP0Ij90lqRDFOjQf0PphJ+L0CGrXmKTbSk0ow/rCxbN?=
 =?us-ascii?Q?fy4W9hQNN5gDCyJdaV6GVXUAasUPE3y3KuXLWr1HhKP9YnDvwZYN2mXauJat?=
 =?us-ascii?Q?5EjYgfT4abfQujV/V538BO5asBiUJtKQ8hKnEE/+LvW2BMV3IapIInmuSRSy?=
 =?us-ascii?Q?S7gy+Qh36k7vcYIsivv5uwNnTIxkpshHgCEDrvC7PSVkN5hcj8XRVPGK5P1P?=
 =?us-ascii?Q?K5ZOhCbZRU5mu+/MVhZjjNVzjNTvU/mG+iht6hb3CKbZ1dZHdEMUQ/vvjCYq?=
 =?us-ascii?Q?WelDruJpC9cOBRkv9ob9X0uGE26OuoIi+UGBRX19mszsnXgXyXzkqnuxSXdP?=
 =?us-ascii?Q?0bCUs3L7UmyxTkzR95cqTFOFuOzP403ji6EcdeJLOHj0wxJJyGaW7RUz61P4?=
 =?us-ascii?Q?8gRR3mnRcoEOzj6JCEEk/P+omi3UWNwTV//wXbZFchZZnkdjX0l13cRuWJNY?=
 =?us-ascii?Q?WvyQJv9c/z0TItrcK4PH9kQn1WWCFqZ5u2miwMdCXczpJ1SawAmYNRptcVfS?=
 =?us-ascii?Q?EUkUdihV9Xp7PbAHd6aJLJjuKNrUXIFEvexN4Zda0J7uUBqfqlmhxJFxKavH?=
 =?us-ascii?Q?sQtj9Kc4wIDBd6udrzAzZO+M3DDjSAmznkvMtEPCP2c9QVAfGEYFcHyBUJSl?=
 =?us-ascii?Q?ICocipuNCu4TOgDH3Uaq3rPKjwnAeH6x8DkmT97+LQxZwlKGvG3//yyrxIE4?=
 =?us-ascii?Q?BGtF9T5YFKp6DIyDlM/v56hYHCBg5MswMM+laKr7v+QT5vjeuNdjQ9S8BUIf?=
 =?us-ascii?Q?99dk9H79M6CRv+wVmBkM+kLc8kjkXUOz8y4DG+xQ5rHXvfhc0ChENCEIv7MW?=
 =?us-ascii?Q?k7GVoBMRqmU2Mw5mUqxqwU28Z13WeSSJ4z5Eava/b/aCeJLbHGC5UH037ODG?=
 =?us-ascii?Q?S2AAimxRK/45izLSJYxB8b/3TlmLjUsHKvH3SQ0BQgFL2GjiyX2enc4j9Jfs?=
 =?us-ascii?Q?TrPmV2uJ5EKH08oCr9kXrSNgbttDiuxpB13TWIxMyC5OOf7ZV+7u8RsFBGGa?=
 =?us-ascii?Q?LLtCFwlRmv1ZmXahPFclHnErzFoQs5Z+BCQDY573z2UCezJY2sBDrj2zzaIm?=
 =?us-ascii?Q?WVa+svNvhTxYmiIxxZ1DUuqLDBM9b2jDjAKf7eWUbWK4OQ1U6T4IJOZmgYnz?=
 =?us-ascii?Q?ixic4cB2be1SBicvB/M5t+m5ZMj8BP+qDdsP6UlZcBOFBjDtF9Sn+uao0ZGm?=
 =?us-ascii?Q?bHPI47PNyzbRuuZImuS5dmqhFOfBcXuMRmedvkN27xBSpzX2KVve8ezt/Df+?=
 =?us-ascii?Q?+zSJNX+lr7Urufm13LukDvx4JJGQcKX3DPSgwgygl1Nh8KbB1kMgXkF8j2PP?=
 =?us-ascii?Q?dggtmJIc+7n2Ws9gWwFCtnfMw81ECorOyrhZ1vXXPJfyEnWSCS9GwjBliPUH?=
 =?us-ascii?Q?nI7G+Bo9RMEAD36BdkBHWhGDBlA2xysgayHp9xo4oTKoS0AGcSeF62dycc/N?=
 =?us-ascii?Q?Tv3SbpuYg8Mrz1q4jcjj2BntDMgdmI+FIpEq1myI2mawD68Wpu6DIE9ZaWCW?=
 =?us-ascii?Q?aGqrzz24rV/51UWyDY/U7U2xmQ5R4+kcrBFYEOF+9T7j3uQIBvEHij4QENOm?=
 =?us-ascii?Q?cpkVZNyfGuCu0kQMzU0kohiPG/JiMGYnIz2pkFFA9/JTBbzrQWz9oy70LcKU?=
 =?us-ascii?Q?QazpEWSTRjMQ3NDMkULQtcJymrs+UPjuLM8+3q2LQNmaAr8lBWYCjbY+Uj+n?=
 =?us-ascii?Q?ORxU+tMhz9HM0dEKXWoSw8vw6CWy2yA=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b041f7-210f-4763-5cdc-08da245682b8
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 11:52:00.7285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SA+UHYOF/7pkZn5FpAc8rS2St6JkgdsXCUVOq2OVx/TK4dtqazv0NPORav7G7Zu+KhEEEc5aDOTvou4PormZMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3726
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
cache_topology[] hold the pointer describing by "next-level-cache", 
which can describe the cache topology of every level.

MAX_CACHE_LEVEL is strictly corresponding to the cache level from L2.

V2:
make function name more sense

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
+static struct device_node *cache_topology[NR_CPUS][MAX_CACHE_LEVEL];
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
+ * find the largest subset of the shared cache in the range of cpu_mask
+ */
+void find_subset_of_share_cache(const struct cpumask *cpu_mask, int cpu,
+								 struct cpumask *sc_mask)
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
+		if (cpumask_subset(sc_mask, cpu_mask))
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
+void find_subset_of_share_cache(const struct cpumask *cpu_mask, int cpu,
+								 struct cpumask *sc_mask);
 #endif
 
 #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
-- 
2.7.4

