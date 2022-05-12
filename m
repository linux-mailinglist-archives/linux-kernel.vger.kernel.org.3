Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11AD524E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354319AbiELNVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354183AbiELNVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:21:51 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6A93ED02
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:21:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiQGz/I+WL8L1f0LWwwZvMLgzG9CYcpB5IDUIiFmxUxUmp2XM/C6ptUsdW1t0UgqHWli5wn7cQj6jzUfyKN3f5dO9YrSKKfsqsFQZ/LPgCRNLeCKN12bPOIQ3mDY3O6TYeMBtULXxL34ZDSbi0zGDRr/noIcVS9hHsFLVCXus/L1IUG6xGMY8orJIPztFo0IIi7a+P5Lntor5FCsJCu1WQEv/ogARAXjexDK1WRikw5GlVUTnS17Q+3FV5SYIIZgWYa5a9QS0+ub7MdMYPieAlhRYvR13grznkfEzrI51njpcpKGwu4naT8cWx2bU3P/VgheP4cjJ2nKdp0MhAj3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaLaxdhkuAMyCDEYTBdGqki0gSAV9PnKiCntZ7HQNdM=;
 b=OyKtMr0x5rWFjcXb7ywdLytnM0PyRXtXdt4fiQs3er1TJPnOjhRHzhetrPFwbnsendlc0nMLYYHmpM0Fns+x+NVu1h3f/33JjvVTFQv0bv/RmgbK1rxW6IkDIjy186z9VSWcy+41m4vcPV0+9IxEFLay7pAicDFIbAaGqeYip11ryFstuEmOmeIvJ1mCQi5jM+oTMDPi/hNn6gsexoGXMUjqyQgro463ZpTXGtlrfC60vWLdYtH8B8QZuxG2H8DvGpuSPHFHDldBGuByXZ1dlqmUylIyPqZ8Fqj6Uool+UotNzxGTz7YUAlvLLr06PHw/imnHROT/rFkdw/WMlynTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaLaxdhkuAMyCDEYTBdGqki0gSAV9PnKiCntZ7HQNdM=;
 b=PZQkHpNqf8iDWK4UcY2CYw6cohcutdl3+C25nwPqGRbK4rR/gM56JKYDXM0iDXZRtLmj0KgtBwGCtse5aVvKsfcDiqVYGvX7+qJx2RCLzObWKOxLVZnGZJ4dEPw6IxTr1L68vJrjy138APEMKLODcQysn/ToqkKTZ6TDyuESEc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by HK0PR06MB2145.apcprd06.prod.outlook.com (2603:1096:203:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 13:21:45 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::d161:735a:f459:c6b0]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::d161:735a:f459:c6b0%7]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 13:21:45 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     dietmar.eggemann@arm.com, Wang Qing <wangqing@vivo.com>
Subject: [PATCH V3] arch_topology: support parsing cluster_id from DT
Date:   Thu, 12 May 2022 06:21:32 -0700
Message-Id: <1652361692-13196-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR03CA0005.apcprd03.prod.outlook.com
 (2603:1096:404:14::17) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7609e97a-eb9b-4837-9a21-08da341a5c70
X-MS-TrafficTypeDiagnostic: HK0PR06MB2145:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB214576D67D121D165C646425BDCB9@HK0PR06MB2145.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vkm0Z2KN+YbwSaTE/542/E7rovlcK4pyVwVupoXm7hVd3I1dwGGzY9VLSMfaOEvkWm4QOlnlTsx3PyCGP7T+pFff0R+IGe6Jchw4Ou5AGkriI/RYAB7wCtIOqzZHKpLlU3FAjRVlBDaFkGvfkxjGaFPrxPUCVbRCbviw9gW4+s3hbZpba1PPj+CGw+pX0gDVhI3IogN70g/yrLZiv+QI8IJAis7aa7LEEUzZux0j4dvnFeN7/eblNKt2E8v6OTGWcTO8cdPoPPHcm/wBFTBLhQA13277a0xjv424yUD9OmG106adXYisbP0qz2YWAOGiu/A89pxddgM6A83UFKrvG8WxDfkS1EUKdO+3l9fAHvw0Zjg1EUNDmBWryXD15n7Fj54jS6TEk1Soj8yvj0ehgEZOd50YLWxtvdrK27CS5W/NN15FgThROIben9Z+UZc+ECbzuLNs9ZhP7HL6P1hDNj/9ytiG+2dvvVaRNr8zdJCEJEIiEj5S62LLLF4WBYumarORsK0/C7SVzgqTHKQzfIBcFHF1yOeoLjbJ3dgcEi3qPqfB1WvMALjS/QMHVzwTd7JWDrQMm4Zcz5u7RHPpgsnDvTyl56Bn8HO07xRe6zkaX82ELEXASB2r+Dn+QrmaGWiXKeBzAsIQdQ/AQ4JkGf337Bb/NN/c1a67PQ0cRllB7URETtGzs5MEHpfUiwobv6fzHKyucbXA44jSE1apyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(6506007)(316002)(52116002)(36756003)(6666004)(86362001)(38350700002)(38100700002)(26005)(6486002)(66946007)(83380400001)(2616005)(8676002)(2906002)(66476007)(4326008)(6512007)(66556008)(508600001)(5660300002)(8936002)(186003)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGs3T3A2TmhUZ01YSUNWMjlscXlEM2RSSG0xL3JXbHlvRWtqMzZ6ZWsyYzhv?=
 =?utf-8?B?cmY4a2p4S1dlc2N5NU1na1JJSnZMVldYZ0tUTXFTVjVUSmZzdFpZMGV0d212?=
 =?utf-8?B?ZGxCcXE4ZzgxaEpvUmpVcExySHI4MnJRMTRabkdyRlQxcHdST0NCdTVrd3lV?=
 =?utf-8?B?d09VUHcrZ1Z5V0lCcTIxZlpZTU83RytaTHVJYkhNT2h0SHNPRUpEN1FFN2JU?=
 =?utf-8?B?ZGtVMHNIRzFEWFpHd0NvdkhReUVUSnRYLzlETTRrb29kdjcwa3RzQjFBYjN6?=
 =?utf-8?B?aTRYUk55YkZMcUhhL3ducjFyc0NiQ3N0dEUvN1lGMVVOZW9WTmxORlg0RVdO?=
 =?utf-8?B?ZEZiQTVNY21QczFwMzdobDJxdlEzRTAydjZDVU9ZQVpsM3YvazJiZnovcmFi?=
 =?utf-8?B?MVZhVXpjNU4rNlk3MDI4cVN5NnZMTjk4ZWJ5VyswSHFDS0kwMmVsSElUZHVh?=
 =?utf-8?B?bjhja1VDSjdKR2RqSWpHNDFkZHRFRit1RDZIK1Q0NGRXSTV1VjA3dXRZN0lE?=
 =?utf-8?B?Ykl6dUFYWG5GdUIzRXAwWHJ4aGFHL2g4VFR2bVJyUXB5TTBkWlpmZndYeUhU?=
 =?utf-8?B?dUlwVmd3MWlHUVQvSXppWUpHUE94MzZIdENXR2dsZC95aG51bTlKZjl6NXow?=
 =?utf-8?B?M1M4TVp3RWJvS3VZVjFJd3c1QjR0emR6Mnh3YzdDK3BNbWt6MWVMdmxWcjBK?=
 =?utf-8?B?eS9ad1U5VllaTnhLcXFrT25KMStaSk03eVJEczlRU2FtMzRUKzQ2alRwM0Jq?=
 =?utf-8?B?M3FNczUxaFhaQmJwMDhDSTgwR05wOUY1SHJWVzFSQjVqQUhZcjZxU1llNzNv?=
 =?utf-8?B?N2lRVTYxQVlIdlRUQURXRzFGNjNMTUp6Qnk2VHJ0dXFoWkE0KzZXZUtBbW0w?=
 =?utf-8?B?dllhUUh2dURZQi9TUnZodk5SbzhQa0lxc3NkSmxjVUZoZWVzblpmbVQ2T1hn?=
 =?utf-8?B?bUFtcXNGS1N5RDM3eVVnMG1td1FEVmFybjRDUkxKVDUrMTlMeE96RTFmdk1G?=
 =?utf-8?B?T1Vhckd4Nyt1T2toTks4U2lzMjVrYXh0YTl3OS84NXpESnlUeWNBYi9sZXRW?=
 =?utf-8?B?a0doYUxhbzl0Q1RTdXVuQlpoOS9wSlpZZzV6a2d5bkh2QnRRNUYyenJ5aElp?=
 =?utf-8?B?emR4cnpZUHc2MlBkaDBjM3k0RGZTS3cvcTVEZXU4Ly9CMjRwSmdRdnlpVUtt?=
 =?utf-8?B?b29kUFlGS1AySE1LOUhsTVJHRE05YTRnSWNJTVBaOHkvTWhFTXgwbEJFdFZ6?=
 =?utf-8?B?WEhnOU9zejBhY2VsS2VOY2hSeWNnRHJJRnpqKzdqZTJRbnUzeS9PUEtnODhj?=
 =?utf-8?B?YTcyN1FydFByK2NFYmsyOHh2aEJoM1Z3MTF2NlYyVUc3SXdRRjBVekw5UmVa?=
 =?utf-8?B?VFZyNkY4VlEzT2p0TXI2aU1CNU9mdFhxSTNPdUpkYkI5bEVtRitmalZ1RHVV?=
 =?utf-8?B?RzIzNzBzVk82RkcyelBIMlUxSWkzNGFrWDIwc2xvUXZBWWlkZFdTMDU0aUtV?=
 =?utf-8?B?RlArYUNRL0RMTlEzLzNwbWx3K2NIUnpZV29SbUtNRERRZHlXdWlIMmt3OHBh?=
 =?utf-8?B?UkJ6aWxwMmg4VVpHV252SnpTYTJlN1VCWnVPRGtKRDVLdkRGaktQeHdMNTg3?=
 =?utf-8?B?djBJcngrSURZakhNWFpxWk10eWRvOXFZMHRGSGg3RXI3V25BUTE1T2JrOTZY?=
 =?utf-8?B?T1dySmRDVEhtRHp1cWJpTmlVSzNjWGRPYWFUTGNwSGtiaUlldGxJNTVGSkZQ?=
 =?utf-8?B?YVNmU3p3U1RPLzR0ZjJubHNhOHZkQnhtbTFjQlhCUy9GZXdxMmRWdm93Q0ww?=
 =?utf-8?B?Y2k4TzNidzBDMWlnejlxdlhBalQ4QllKZkgwQ2tYVzRMdE84MTRWS0RvTVlk?=
 =?utf-8?B?eDlOODFWdVpOMFNzR2daWGFzUlloZ2VvVkZ2VHF5NWRCLzcrZGFPdis4Wk5Y?=
 =?utf-8?B?TU80a1NldjBYU3hMbU5oV0ZoNFlVMmEva2IxTC9laEEvRGgyRFNVS0N6WDZ4?=
 =?utf-8?B?S2w2MjU2d0pTaTdEL3dObU9YZHh2a0xBM1pQSVJtVGJkUG05UGhHZVY5cTRm?=
 =?utf-8?B?WldXUXF0czhBTzFjWG1OME9NbjZRdG9oUlZGVEZxYWJOZGZqQURQMEMxVm1V?=
 =?utf-8?B?L3BXWC9LdFlSNmxSa1NxUmhadEhQbExWVllpWDBqMVBiREszY2ZTWUVoWEw4?=
 =?utf-8?B?LzRsTWZBYUtOUWhnZnk3TGVNOUxIeVQvNFZGZ2pidzNuN0p6b1ArdHIwSW1J?=
 =?utf-8?B?OVljY1YybkdDOGFUWUlVQU9hcGN3a2w2TjhnZTBJbG9iL3prUy9aRTRqNVI5?=
 =?utf-8?B?cGdIVXlDNnBGcldrL1RBWGU2T2xKeFFzbWdaYjFLYkFJWTg3cWpJZz09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7609e97a-eb9b-4837-9a21-08da341a5c70
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 13:21:45.2898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DVMfN63plOWb12xowtpHh9g7PSckdJMbyF8ee14gXLPtagndUJi1eVuuhhwfBrnG2+gOl8Om83Il7qcV871NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2145
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

e.g.:
cpu-map {
        cluster0 {
                cluster0 {
                        core0 {
                                cpu = <&cpu0>;
                        };
                        core1 {
                                cpu = <&cpu1>;
                        };
                };
                cluster1 {
                        core0 {
                                cpu = <&cpu2>;
                        };
                        core1 {
                                cpu = <&cpu3>;
                        };
                };
        };
        cluster1 {
                core0 {
                        cpu = <&cpu4>;
                };
                core1 {
                        cpu = <&cpu5>;
                };
                core2 {
                        cpu = <&cpu6>;
                };
        };
        cluster2 {
                core0 {
                        cpu = <&cpu7>;
                };
        };
};

sched_domain will be parsed as:
CLS: [0,1] [2,3]
MC: [0,1,2,3] [4,5,6]
DIE: [0,1,2,3,4,5,6,7]

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
v3:
- After the change, there may be the same core_id under the same packet_id
- Add the handling of the above case
---
 drivers/base/arch_topology.c | 38 ++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1d6636ebaac5..5329c7a20afd 100644
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
+						 core_id++);
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
 
@@ -692,15 +702,17 @@ void update_siblings_masks(unsigned int cpuid)
 		if (cpuid_topo->package_id != cpu_topo->package_id)
 			continue;
 
-		if (cpuid_topo->cluster_id == cpu_topo->cluster_id &&
-		    cpuid_topo->cluster_id != -1) {
+		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
+		cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
+
+		if (cpuid_topo->cluster_id != -1 && cpu_topo->cluster_id != -1) {
+			if (cpuid_topo->cluster_id != cpu_topo->cluster_id)
+				continue;
+
 			cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
 			cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
 		}
 
-		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
-		cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
-
 		if (cpuid_topo->core_id != cpu_topo->core_id)
 			continue;
 
-- 
2.7.4

