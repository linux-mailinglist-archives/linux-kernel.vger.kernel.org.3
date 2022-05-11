Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44149522FFD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiEKJyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240212AbiEKJx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:53:59 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D144B980A5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQdQL+Pd2wDNdmChV33vmCSzDLfEFcefo6pYgh7U58QVR3grV2D0fJPiS+SqrPuuTcgu2XEJcwkIZymQ9K4t9Qmq1cmhW5V2nhQ1j53Q5HI6oqfLx1Aasrp8Dv1Bmu0GfDEzFYk6bAWzjQa581nQZHiOZKI2a0Gy8N/nFvnEeIpjVy2mRJfWUQX2wHcBQDxsAPaENkA81eb5M4EAjJYpeRN8s7ytNtZjlyYaC+n9s4TzLQvi/0w0hgruHd1sRwlPJt+qWvaPucaVzy6vQoV2mqqOfYfWDVGDwQJ6Cgbxv9LbE0aBwXGBJYuOYhzz4g409CXQaDqCatCcmI7MfPrPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLtXT9SCTVmzi96bkdfExuyyesAaFwu+K31iHfzHb4I=;
 b=SeBUR54N/X1IFmgy1gHQ4Xt0GCwm+e/nmBG+MM4Sk/Z7LarHfONFvtHG6yyxhSS0DRZ/idpuZS8LoMppkDImS29jwWAPkFhD/MENavPHMNU3wz4sqTjhD6iAqE2A0eHFHiOgIWLveKP98xvvQLF07sKvwHh3mXDI6xlJaB/Bf4FJI4e6Xn17llJ6Vr7Bim5KvSWxQDxGbks30iKhVVOa37nEuPSYDyNKZTvnL0tXNkOh4TNah4lw2Mpb62rFkiw3YpLzATJKNpjDWO3RJh117IBLhXiWrpMljpTejcmzU9aoWG39uAiL1htoa+XgVofpd7J+PAPVhvXH+by+sQDXxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLtXT9SCTVmzi96bkdfExuyyesAaFwu+K31iHfzHb4I=;
 b=c22aBfFvDKEs4Yc8FrurBz4ACNS+Y6A232yBqRrgOpiDUroRKwcGo+4N/B0XEkU19wD7GTRnORyJVVrjJgdxD/v++cC2g1B4o5kl7L7QnwHyOBqaMFuFMtN88wU3OY9k7CuDS9ileflLGSuG59Gh3cishGhYG4CSqoWhItDN524=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PS2PR06MB3528.apcprd06.prod.outlook.com (2603:1096:300:67::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 09:53:31 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 09:53:31 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     dietmar.eggemann@arm.com, Wang Qing <wangqing@vivo.com>
Subject: [PATCH V2] arch_topology: support parsing cluster_id from DT
Date:   Wed, 11 May 2022 02:52:56 -0700
Message-Id: <1652262776-3056-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0002.apcprd03.prod.outlook.com
 (2603:1096:404:14::14) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb7d537b-b734-4fc0-cbde-08da33341b20
X-MS-TrafficTypeDiagnostic: PS2PR06MB3528:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB3528D8EFC66A282B901264EDBDC89@PS2PR06MB3528.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H59ZYi1pcvSEMx8d1mY9d+aL6t6sLaHB52IM729uVfD61qT0yuaVNysRPnaLMondIEZTN0tm7YLX6qLi8vgEQk4p9pnE9ypjRhOl7TER6LxmEFCD8DgtA8uyjWt4znS6lw0DDUoYs29DNe45PtALFJB+kIzhv2CVQ8aFORTttQ9cHTPgzvBmKKSnYgKXWmjSt28eTkdcS8IqpXvhxRnCdcz9MEY1iMyXCyT1ChrRBg6OOEAPQtCt/0vmvklV51PnyGMRJTUK4CWmHnOyfTUsQdVUe7fk2SA1PwpffduZLc2TijhIzTGeShpSPG6KvaREZJyvNdrwyESzj6SjJ3GzHMCr0jrpzOB8nySmeriktiJqPgrAaUvDOxfm63tq4HfsOPBz3YW7VWTGfguXXUlVq9g5LlCweVmjpFa82f10sMu5aQefvO6J1hli92DAkcVzC1PMNVYdR+wlyu+W3F/r+kgjXeqrOdB7TVaCXmj8R+vXcd2Aeoyr2ZP8J8rijWhNclrnowAweUrGR4N35h+wKxQVOjzlB/TInCLtraCnVxYiA3cT58b28PG1QCDhx0mdZTqgRABZdfEH2nMUkeGh3voWtwm1E/Ixc+aCtutSE6RlvhHWyrp/8CcZsYGEGtMJXeP62y+A1Z/E1g8GC90kPy5H2nkuAJDTAUz5ngYanY2pyU9xPH0Jktkqpx6QXmFuefUO9A/17qeDrC6XTB4nsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(508600001)(4326008)(66556008)(66946007)(6486002)(52116002)(107886003)(83380400001)(8936002)(66476007)(6506007)(186003)(36756003)(38100700002)(316002)(38350700002)(2616005)(5660300002)(6512007)(2906002)(110136005)(6666004)(26005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ZxHmwidXHJBKBUdCgMTCV9whrgYaV6i6mByQWj3WG9nLVZeHpNfhLu6XUJo?=
 =?us-ascii?Q?vktOxjJ1SQ/n87+17D5p9M/GBuEPQTUG0izfBVd/DXJrAUabOU+Dxl7wItjp?=
 =?us-ascii?Q?sGeeOzYUVTQaqDeGeBKY0JHeNC955U0t7eboAOB1u+6jmkE6mL2j5+Ef2Exi?=
 =?us-ascii?Q?ZGlY0J7PWzuJ+isGIQKkN2BY0povZnW3dgxGr5VldzqvVAMz4NH1OsqJNvIq?=
 =?us-ascii?Q?nJJCjGsV/GNIPMhCGfHE0jR1B/fJgHimBbUi9sfr+shBWd6w8Y+Ak9Pf4qo9?=
 =?us-ascii?Q?kNmlk2PHkiL/JXjIAH8UFeZNC/Mwy/RyysrXwjkSokJeia9wTv+67xK9gv/l?=
 =?us-ascii?Q?uAp5qv2jDi8aXASnd2RvZEw0r2XbW6l3KdqDCJ3hEka4LhSMat1YFHmuzmLQ?=
 =?us-ascii?Q?kbcNLoaZzpTdoNlJOlGK+2Eb81MT5FpHshTs/dp0S9q6Y/+ktWdXMJG0fvjz?=
 =?us-ascii?Q?UHnhjdZ1fFdNZA3HaAURpSBEOqbbKByppnCBeOrZ9e26but94aw8IVFL7wOz?=
 =?us-ascii?Q?ALcq5CPXXd782sQqLopU+2TFgzCvdPlA9s46/hS/S7tViQuwGp+dljHdE8Ck?=
 =?us-ascii?Q?zC6miPlDhFxIRlEtESarzXYArVH5sCQnCPulhMpMDSvpTVCLrVoj4K2tOSSO?=
 =?us-ascii?Q?oNG12G4Iw18Q7VgmC7uoLxLBLH9eV19u0RDJwhRYI2kUgHSz4V0Xn7Sh+Jwm?=
 =?us-ascii?Q?RZ7las9mzWirt0BVpFreUpUJaYJADxG70jjEVGed+3i+fWcwKCFpTduTP7DG?=
 =?us-ascii?Q?5ftMVndeum2pP0tksNIYnUbaEoGXjjZq67qPvtDaMj7Deovl9qQKudLKzxIh?=
 =?us-ascii?Q?tsU9TKJA0Ct/9pII6uYViinHeFlCihyL0mOADb+q//sujhN8HNCe6cGgeeUi?=
 =?us-ascii?Q?wxrB1hJPoRHk5RaPlS/CbuUrRy76s1AT7OKaFy/rAtxsysbR9L3tz0Hwgb+j?=
 =?us-ascii?Q?NGOeRZ7X8h15eLCX35k/HxitvyLr+WwEnUtvFkY6Ubf2NMJggwwDiYZRAgms?=
 =?us-ascii?Q?KODmKVqdXo0o5Cr2VR0gy6zN9WP09518zMo3CUNbJsFH7GUfcSZA7uUVrug6?=
 =?us-ascii?Q?DN+qtwHcNizUiVfirmmwkJ/pkbv6B6bT1XaOQ9LqNDsUBUw7/6+W3PNleMdi?=
 =?us-ascii?Q?p91YkRUag9g0r9Ysy8g8wmP/Q5gH9kcdNqiGuGSlL8czSo6D6T12npdO+DyM?=
 =?us-ascii?Q?6YL2RnJ8VBDV1FglSDT9+jGsGTxIcqWNDqYsZY8iQkwyFmXzxyVyv6NSjDWU?=
 =?us-ascii?Q?Tk3rcjRnBgU660mhMUraDSBzGABod+YTtm+PzBiUdnWCtWzZPt20cVKmuChn?=
 =?us-ascii?Q?s7fJ5h2IRn9KvyMYgRdqXJorxezjRkj9te+rqqIoAe+0GO56FTydDcuq3h49?=
 =?us-ascii?Q?gugvomm8B9xnL7IpqkXQB5GudejqoaQOhKEJBcqZMCW5lOo7yHtE91NVQT5t?=
 =?us-ascii?Q?biLECd5lQ4UHvU1ceFvkX2DYfpZ6hnCjx9i0dpYtHoQ0o1KYxDwjGq67Aoje?=
 =?us-ascii?Q?tcmdW8U/o1QzJhgG2JCUvbVMoapnQUD6sBHGNY3qn4RmDGCfp74KH0MJ8Xow?=
 =?us-ascii?Q?BoXCG3mrHwRGCLVwf6tMUbIgjZYg3ut16W0i3bIWMlQrbYewcnwE/DpxErZv?=
 =?us-ascii?Q?8dxsoYtfd9ZQf5T4wXjZaoHRVES7wL7CwoNiFjtRyQMpvcncmfa2ItpcDAQ4?=
 =?us-ascii?Q?YdRucunbnIK3s00eIuUsgUqSzw6iKwYtc8fggfU8v7IHPHW58vq5pLcsTfEO?=
 =?us-ascii?Q?zGW1O9mNCA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7d537b-b734-4fc0-cbde-08da33341b20
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 09:53:31.5296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vvry7CVkz64ILYWeyKC/EuPdZ7uK0G223+PuQWpDLXcv1/lHbKk9UYuPWIW0LvrGKccq9RuZEcY81FM8hsokTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3528
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
cluster topologies and increase the parsing of nested cluster.

Notice: the clusters describing in DT currently are not physical
boundaries, since changing "cluster" to "socket" is too involved and error
prone, this patch will not have any effect on one-level cluster topo, but
can support the mutil-level cluster topo to support CLUSTER_SCHED.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/base/arch_topology.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1d6636ebaac5..5a407cff0ab1 100644
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
@@ -582,7 +594,8 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 			}
 
 			if (leaf) {
-				ret = parse_core(c, package_id, core_id++);
+				ret = parse_core(c, package_id, (depth == 2)?cluster_id : -1,
+					       core_id++);
 			} else {
 				pr_err("%pOF: Non-leaf cluster with core %s\n",
 				       cluster, name);
@@ -599,9 +612,6 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 	if (leaf && !has_cores)
 		pr_warn("%pOF: empty cluster\n", cluster);
 
-	if (leaf)
-		package_id++;
-
 	return 0;
 }
 
-- 
2.7.4

