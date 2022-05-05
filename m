Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F01851BA9E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241976AbiEEIjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350229AbiEEIj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:39:26 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2124.outbound.protection.outlook.com [40.107.117.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF661A076
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:35:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exJHlVFgra6OUHLuYsRXLQ+Mc/0qHkkkfax9dDr9E6jGo8FIwB0FSdG1f3WHv8GRACvVvD8GLbbnYqUWq/mE2XJ+S4CDP/vv+FpcepkaSBFEZtLwHRRDqfHjlFK0mA0Opl9QMgbYDQ1frg4MxKtYr2ED3bB27wQyDDAGfL2DF4pnRluwdAAcLW694b527xF4lTdwdzlaKjj1Y+bhzuILz8LEn7nqE2zwJ3/krgXQmJmVzbLW3+g4293+s1zYFnbyPFpgO/kIBwpiWHBQlbVt7RMwEq9BunhgT1JXcAxwM/1KK3KnXYl97taFWZhQ5pWcrhuxloRY13Ik4pQW+kUPLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMHqWD2TvvkqLK+Lfzb/Tkg0L6KCHXPM0GuwDhKWNmg=;
 b=fuixx2sz6BP8e7uck45j2r4AYp1BDlNwJtPANgG+uZPsmVpeolswx0lalKTKHPyEbkt2UcBHl2EaGJzyr2ylAdIciOOloip4Mw6Ofzul+pbi0Kju2v69Idd478RbIsXgSCBc/nl5KNICeXKykv2aG05ryQRRYlbS8wcnD8UQbRS8h0ZOJPXd6H07U07wAQ+F2yuXDlDjDjoJOowkUdhNRouc8Kos34hYQfDX7ZochyqePBUj9Vu4FkT0FOnT/yZIaSlihAbS39BOjOa8tAeNaP08kcb/5gRBTOsVibQipNDhUo4r/yn4579R+8B1Pau3UY/VLLXkLQVpf9iOpuqTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMHqWD2TvvkqLK+Lfzb/Tkg0L6KCHXPM0GuwDhKWNmg=;
 b=gaZRBtYfuN5jQ80XAnsXW80fy4FSaBVSFDvuqxPCKUAyRkfmzIUr2quWChyrJ2esv2cZh/aTce/LrdmmRQdecJaCd/rooCqjg2aAZ5MAifWDYphk4zsoduMQ9JP663ihcAKGdVmEKWmB6OMi+GjqTw5zUCUUrxaMbC70FHYN4qk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by TYZPR06MB4046.apcprd06.prod.outlook.com (2603:1096:400:26::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Thu, 5 May
 2022 08:35:44 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 08:35:44 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] arch_topology: support parsing cluster_id from DT
Date:   Thu,  5 May 2022 01:35:34 -0700
Message-Id: <1651739735-51884-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0065.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::29) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec0e82dc-4bf3-49cf-8c9e-08da2e723eea
X-MS-TrafficTypeDiagnostic: TYZPR06MB4046:EE_
X-Microsoft-Antispam-PRVS: <TYZPR06MB40464D78246F9DCEBA8D4C3ABDC29@TYZPR06MB4046.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9FOdXvh/QviXRKxRn4DLf4fb48GYRhbFF4QcyiOp+bvgtEDh0oQPar4cS8eVH1eIxKzSLX14Vy9LgvNcnxCVlise6pgqlKzcUR/Hyc7YYjyQuVN/3hFsIc+tm3OmBF7sj3uNILQQ/+TIq8xSRc9tpyUfNboLCJ3aGELZwz5hhQw6lDvSgiUHlCLWIKkNr1xVh9fF4Uyp6/tD9gezEvEHxU3FS/HRMu2S1qLcJlDIGdo0z37LeN8ZfHenV8hYZmJQc2AsPen/5o+mf8+7b0IIzQcopYBm1UheSEKMv20buctpIYGGur1ywc+/jdsAY4nkpIMeU7u2B9JnukrXuK03JA96Y4tD1HShMoJO7URT6cEdSgpmfOu5Vo1aMlTFK5qFv34dfH6E7iwsS4v5nJ/0InYGwuPlNAlRH/3Hphc2XLcZo+MJPnyOxSkCwGT24/e0gaL/24TVqaXBZ+0u93h/lQod0vwqEC4kGGt5///pEl+3+XBnIOPRBzBrJlV6j+JmtqSd68azI2ljTcQNDYfiEP10APuPJ3nn3HzuF5a3QuZuHa7CVw65MDztVLptUyXu3cIrUfQbcrEsbjJiUmI/llcXe4jYcrni1OWbq66loF1nCYcvdcWk1oIGAIH90pSUwHnpHcXYczpVP+ZmfRSLeArS0F2BBpmRcLEER7YJrWPm+Mk/eh1I3oV/o9zhC1VztT8qJTYMazsq5MLHb/HGbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(8936002)(36756003)(83380400001)(66476007)(66556008)(5660300002)(66946007)(4326008)(38100700002)(107886003)(2616005)(38350700002)(186003)(8676002)(6486002)(110136005)(316002)(86362001)(508600001)(6512007)(26005)(6506007)(6666004)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t1UtK3Xo8BLosQwWn/6vHn9V+t54MfSwqKjW9ux8YAoyfPcq+NMXoSkcCsW+?=
 =?us-ascii?Q?s/TrLQFNxDVJWW6M0X1TdMFWYqRRryXEmm9L6HM/P+od1p/+sPQE0aUiULqe?=
 =?us-ascii?Q?gYxXbL73H914SpSQ8p49X05991VZUDwV1sAe0Gt0fcnq5RwIUa5IE5Sgc4QT?=
 =?us-ascii?Q?JKfP9Zk/+rqFsEfRItzuf4oZr2PMnKjMdYH/ijVODbkHHeQUdob9gnXrDjaf?=
 =?us-ascii?Q?F4SyxWF0xGk9AxyqNUT/qF0tkVZOFo9v0qwGjGTExoW4PfDnRjMY512dq6zG?=
 =?us-ascii?Q?MfD+h4SQSZW7GDXHvzsk9ORKTNi1GQo8/EyoYT75Oxyciwh7puxLBfN7Jpub?=
 =?us-ascii?Q?LZEugZ3HdC1KzgNVTjwiMee5CwY95LvkLP0LAhm3ak4J1GP03PWJ1KCsGIsf?=
 =?us-ascii?Q?/jc4CwTQSNYVoFrtqMhHdUurwI+0WwQI1BAR/sw5Jjzp+uhg+7CN1jJwDgDm?=
 =?us-ascii?Q?wolJYMcYU89peI0bRftil4si/Z9PjxHoCOuia47Ir7YEobBxC53vv9rVmnSq?=
 =?us-ascii?Q?rLJdKgCqk+OhmEqINAJANIvDiuxmJDjpKe3XJFBQvIZj63fSte5nCXAUqFgP?=
 =?us-ascii?Q?OlScUcNBmD0y91SdCPkJbTaxcTNbb+4YHf6NPImMBJ/Y+1sZUzYqdiY2NSgP?=
 =?us-ascii?Q?g4+mGBeOTG1pfR+20wL9Y9gMNtD+Gg59lAiM4wrwop85yEuCOs2n9eBno25I?=
 =?us-ascii?Q?g4VAZyty81I7dqR8LgXZmOyIEAHbqJ/kW7n0iaJL0Fx33g6mjWeeCGZGsQ4M?=
 =?us-ascii?Q?XgJyXt0wedl7qI/M+9QoJ57XghMNt1JQvJb+npOFd50LLQ2Qw7IR+kL96MHp?=
 =?us-ascii?Q?fdLTJdAxEQ7JDTGnKGJkVModThKqEF0E9q9aHgoE+epQWx1ARzJgOWOVs1K4?=
 =?us-ascii?Q?geki/FZG5eR97a1pOhnSyDijc06J+JisnW0NdgPVndlpQUYlFRGJipzCV/f+?=
 =?us-ascii?Q?Rivy5KZ717cZp1jGaxD+XZ51QV78W0BxwrTmBeUYu8rkX64/v9TIM2vqXint?=
 =?us-ascii?Q?TPCf9A6wlj6Eyd8z4023Fb8F0LG1yulGoObvVpFe1b9XQdfH9cGV0WR8C9Tm?=
 =?us-ascii?Q?v1Shgt8fGJrYD9ik5QMlao9PPFHGuUldruMKtmhr7P/kQRXXesUmJnFDvfC5?=
 =?us-ascii?Q?NzPNfxkX943AsuOmnQBe/8joccRjE6H9GFpqvUh4pOtLeCD757EbsxST5nkl?=
 =?us-ascii?Q?M0FURK/R/kMgEbABPrW7drLQIXxvu/9vsSH6d9QJZB3YUk/VoZg4ZP/GFLza?=
 =?us-ascii?Q?hp3R783UWFqpaWe4sJnGBtXVHXBe7b7Au1Oe+3ZoL0auvL36xTFvL6Y13Xc8?=
 =?us-ascii?Q?ValG3piDQCz0sIRTrSs5PPCBF67Dehzod5qazIyOqK7CHpX71WncEfWwwm2k?=
 =?us-ascii?Q?ufV8/pummCA0+l/pRDicA9nmX1ewY5d4eZmHLAeWPTdq5H2CXfwPckvN8lyt?=
 =?us-ascii?Q?GRbCkWyIQFHpXurlhIALiL07svQfLlaaAoSVndnlc3dhqSGQSWhwe2/dUNlw?=
 =?us-ascii?Q?3n6ZFrvmBNJXkT3eJd5+6ZVDCNWot2QWd56Ty6s8NwuyEpgBczZjyD2YmzqW?=
 =?us-ascii?Q?3bk7gn5/RCfYtpIyF1aAv99/gLXTMVdXN8QFxsYrTko1Z7/OcGcN62yZzLfh?=
 =?us-ascii?Q?z6i6p/kzZ8c16UXgsQTg81eVJF6yKzKE6lMTv07N5b1mtI162TU8zs/ykx1t?=
 =?us-ascii?Q?iPkk6n1Dm4hxgzC1X34UDSv7sMwH3VgmvSG06aOiOe444Dj21nugeEo0s3tv?=
 =?us-ascii?Q?qaVEyTNdmQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0e82dc-4bf3-49cf-8c9e-08da2e723eea
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 08:35:44.5085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7/0Qd9NiOjUvxGqQAIx82AoNFFQw9LDFJfcHMmy/NXdHFz1wOJW4RPnBAGGaNGx36BBs5NuG/Wcl/2OXNBtEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4046
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Use nested cluster structures in DT to support describing multi-level
cluster topologies.

Notice: the clusters describing in DT currently are not physical
boundaries, since changing "cluster" to "socket" is too involved and error
prone, this patch will not have any effect on one-level cluster topo, but
can support the mutil-level cluster topo to support CLUSTER_SCHED.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/base/arch_topology.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1d6636ebaac5..f2ea8113d619 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -491,7 +491,7 @@ static int __init get_cpu_for_node(struct device_node *node)
 }
 
 static int __init parse_core(struct device_node *core, int package_id,
-			     int core_id)
+			     int cluster_id, int core_id)
 {
 	char name[20];
 	bool leaf = true;
@@ -507,6 +507,7 @@ static int __init parse_core(struct device_node *core, int package_id,
 			cpu = get_cpu_for_node(t);
 			if (cpu >= 0) {
 				cpu_topology[cpu].package_id = package_id;
+				cpu_topology[cpu].cluster_id = cluster_id;
 				cpu_topology[cpu].core_id = core_id;
 				cpu_topology[cpu].thread_id = i;
 			} else if (cpu != -ENODEV) {
@@ -528,6 +529,7 @@ static int __init parse_core(struct device_node *core, int package_id,
 		}
 
 		cpu_topology[cpu].package_id = package_id;
+		cpu_topology[cpu].cluster_id = cluster_id;
 		cpu_topology[cpu].core_id = core_id;
 	} else if (leaf && cpu != -ENODEV) {
 		pr_err("%pOF: Can't get CPU for leaf core\n", core);
@@ -544,13 +546,15 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 	bool has_cores = false;
 	struct device_node *c;
 	static int package_id __initdata;
+	static int cluster_id __initdata;
 	int core_id = 0;
 	int i, ret;
 
 	/*
-	 * First check for child clusters; we currently ignore any
-	 * information about the nesting of clusters and present the
-	 * scheduler with a flat list of them.
+	 * nesting of clusters :
+	 * level 1:  package_id
+	 * level 2:  cluster_id
+	 * level 3+: ignore
 	 */
 	i = 0;
 	do {
@@ -559,6 +563,14 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 		if (c) {
 			leaf = false;
 			ret = parse_cluster(c, depth + 1);
+			if (depth == 0) {
+				package_id++;
+				cluster_id = 0;
+			} else if (depth == 1)
+				cluster_id++;
+			else
+				pr_err("Ignore nested clusters with more than two levels!\n");
+
 			of_node_put(c);
 			if (ret != 0)
 				return ret;
@@ -582,7 +594,7 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 			}
 
 			if (leaf) {
-				ret = parse_core(c, package_id, core_id++);
+				ret = parse_core(c, package_id, cluster_id, core_id++);
 			} else {
 				pr_err("%pOF: Non-leaf cluster with core %s\n",
 				       cluster, name);
@@ -599,9 +611,6 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 	if (leaf && !has_cores)
 		pr_warn("%pOF: empty cluster\n", cluster);
 
-	if (leaf)
-		package_id++;
-
 	return 0;
 }
 
-- 
2.7.4

