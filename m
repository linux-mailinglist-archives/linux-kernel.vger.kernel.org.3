Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA1E530822
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 05:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355749AbiEWDlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 23:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355653AbiEWDlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 23:41:17 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B5C5FC3;
        Sun, 22 May 2022 20:41:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrTaiKLAfiN45QVJj4GWjK+nSbJlEb4qf5SSICYramUFc/XyqefxNil+cCgPzSo8O+hCpjR+VvcPuQjd5Q3sBKei8IqC/Asoum6u/DI4zhEf92/uxdibqVw4qobg9J73XPemwlvYusLCjgA9q2mZZv34mmFH5ME+lrX8wFl8N21+FJW1RoMvoaY0EBYtOunMSm8hhVVpuPJE2lbFM5VuBzSBXsQA9z/qygEkgY54tQG/mGNZD9NBGt2qvyvZnZWt9X0DT47hS/yZggWGI/uJx6fJ6s4v5YcLUHPIY6CIB3BxIYHPaXM0MOpOuTgyFIsdl0ye3Boq67LHgm2xJC+Vkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDr3Aud2f3bEWRA5lYEAheLaXurwbvIRmVzaryhpqQQ=;
 b=JzK6vmz2knkVr2YzYhowFmP6GyHbzphZrM5GF0ekmspaelvc9l0wDgTlu4JzwM6MAxGERAo5rDOibINWXPLjbWKClfym8UFlgJFfTI7A99TqIfT7jkfjiUwvQfJ6fRxOiYzEd/h5jfCoK18zl7LSfkiFG5wq1JzGo3ICrMgqHWg92QXwaY432jPBiDDUeHA0mau9fIy1e/7F3RC14cVt5oDHcHRzIYZJmnc14/o0jj/c88jpDQ5mJ2Tw83vEAryXt00BPYbLdkTN6hyfc13Ky5D8J1lv4sJqwkrvEtkvFKJJFxCsvJqI/4uWsw872RV+sg2IMSPneLJCaiAqxs+w1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDr3Aud2f3bEWRA5lYEAheLaXurwbvIRmVzaryhpqQQ=;
 b=135cfCdwAm4pEyb/p3IKuiCh7gpSjf/KtcsUTVb6HC4hUSl5W1W9iZHItl5cOL1UqQU+YYSvPZ/o4otgxYEEUkmB5L5CDX6UR2k88KpUhTRBGBWhg4fRyoXcCstUAH8LMJ5A2UHUXgnd1YPQa3wXtfi16//Ysvn7aweUDUGny3w=
Received: from DS7PR05CA0040.namprd05.prod.outlook.com (2603:10b6:8:2f::33) by
 DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.17; Mon, 23 May 2022 03:41:06 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::aa) by DS7PR05CA0040.outlook.office365.com
 (2603:10b6:8:2f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.7 via Frontend
 Transport; Mon, 23 May 2022 03:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 03:41:06 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 22 May
 2022 22:40:54 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <irogers@google.com>,
        <peterz@infradead.org>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v4 5/5] perf script ibs: Support new IBS bits in raw trace dump
Date:   Mon, 23 May 2022 09:09:45 +0530
Message-ID: <20220523033945.1612-6-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523033945.1612-1-ravi.bangoria@amd.com>
References: <20220523033945.1612-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e2999bf-9541-4981-6912-08da3c6e11a0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3547:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB35477047B4F7C6AEF380A242E0D49@DM6PR12MB3547.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRK9CMSeMseUVOya9rHINbSyoUVFlbuTF1avmqqI2Tvf4oMG90GEm6LsiPuJaFmYo84mxl7jagIMj2xxvKjtGdomOWrXrDdFzzRRUwhkK2wDL+Yr01FnzsxhFiIKYvVKRRi2yP+pCWzatkBXfi+0bUjZSCclwewxUKAu4Mx1ncVEJ8VWPvXlScEtG+AWoK4K+h2l3L/w0iAWL+60t3uNWo9wn4CVmXwbgUt5JTh0GeW8RoNZQjY5+0g5Ae1XuBAWQsQShJcI0KYzpK1HfSD54rxRb/3AyAjRfcvdIRzRq428FBPYFPXQFGH+tSR0bLfZsVuAPW+J4e2MGUd8ERWM/63GiZ0wzeQisTJgrGueSfTc1m63HhMqVu8hrvL+wroBg5CWuwfa+eg7AailfTWX2ZbKTBrz2VUwAt07FG9kKcBkcCBNtwEz0GV4Zh4ZwzADP6lfzEC4sSKrLsnJXC7PtJFCsvYq3GgQDTkX7oQ4e7N8nw64bDsVF6dud150tEx50Lqm3RzMiF3ItSAJAhIvxYdhCxgRK/e7TMBNRjYJ6u+5VK+7bkf6gep1V4ONzokCVgd9scpfozqZDz6JtAgay6KeAkgbvylI5aE0+5UJAe3ojyeQW1H23TYZACXiFWiD64ikkshMw98lQ1qM4YWz1rB63UBLgUrir7hES1con4n5smImIzr81g8SvM6hjNr/CbQo8n7K7L1OfCbag0h8BA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70586007)(70206006)(47076005)(7696005)(54906003)(8676002)(6916009)(83380400001)(508600001)(356005)(1076003)(426003)(16526019)(26005)(4326008)(186003)(40460700003)(336012)(86362001)(81166007)(36756003)(82310400005)(36860700001)(2616005)(7416002)(44832011)(2906002)(316002)(8936002)(6666004)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 03:41:06.5203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2999bf-9541-4981-6912-08da3c6e11a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3547
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interpret Additional set of IBS register bits while doing
perf report/script raw dump.

IBS op pmu ex:
  $ sudo ./perf record -c 130 -a -e ibs_op/l3missonly=1/ --raw-samples
  $ sudo ./perf report -D
  ...
  ibs_op_ctl:     0000004500070008 MaxCnt       128 L3MissOnly 1 En 1
        Val 1 CntCtl 0=cycles CurCnt        69
  ibs_op_data:    0000000000710002 CompToRetCtr     2 TagToRetCtr   113
        BrnRet 0  RipInvalid 0 BrnFuse 0 Microcode 0
  ibs_op_data2:   0000000000000002 CacheHitSt 0=M-state RmtNode 0
        DataSrc 2=A peer cache in a near CCX
  ibs_op_data3:   000000681d1700a1 LdOp 1 StOp 0 DcL1TlbMiss 0
        DcL2TlbMiss 0 DcL1TlbHit2M 0 DcL1TlbHit1G 1 DcL2TlbHit2M 0
        DcMiss 1 DcMisAcc 0 DcWcMemAcc 0 DcUcMemAcc 0 DcLockedOp 0
        DcMissNoMabAlloc 1 DcLinAddrValid 1 DcPhyAddrValid 1
        DcL2TlbHit1G 0 L2Miss 1 SwPf 0 OpMemWidth  8 bytes
        OpDcMissOpenMemReqs  7 DcMissLat   104 TlbRefillLat     0

IBS Fetch pmu ex:
  $ sudo ./perf record -c 130 -a -e ibs_fetch/l3missonly=1/ --raw-samples
  $ sudo ./perf report -D
  ...
  ibs_fetch_ctl:  3c1f00c700080008 MaxCnt     128 Cnt     128 Lat   199
        En 1 Val 1 Comp 1 IcMiss 1 PhyAddrValid        1 L1TlbPgSz 4KB
        L1TlbMiss 0 L2TlbMiss 0 RandEn 0 L2Miss 1 L3MissOnly 1
        FetchOcMiss 1 FetchL3Miss 1

With the DataSrc extensions, the source of data can be decoded among:
 - Local L3 or other L1/L2 in CCX.
 - A peer cache in a near CCX.
 - Data returned from DRAM.
 - A peer cache in a far CCX.
 - DRAM address map with "long latency" bit set.
 - Data returned from MMIO/Config/PCI/APIC.
 - Extension Memory (S-Link, GenZ, etc - identified by the CS target
    and/or address map at DF's choice).
 - Peer Agent Memory.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/amd-sample-raw.c | 64 +++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
index 3b623ea6ee7e..238305868644 100644
--- a/tools/perf/util/amd-sample-raw.c
+++ b/tools/perf/util/amd-sample-raw.c
@@ -18,6 +18,7 @@
 #include "pmu-events/pmu-events.h"
 
 static u32 cpu_family, cpu_model, ibs_fetch_type, ibs_op_type;
+static bool zen4_ibs_extensions;
 
 static void pr_ibs_fetch_ctl(union ibs_fetch_ctl reg)
 {
@@ -39,6 +40,7 @@ static void pr_ibs_fetch_ctl(union ibs_fetch_ctl reg)
 	};
 	const char *ic_miss_str = NULL;
 	const char *l1tlb_pgsz_str = NULL;
+	char l3_miss_str[sizeof(" L3MissOnly _ FetchOcMiss _ FetchL3Miss _")] = "";
 
 	if (cpu_family == 0x19 && cpu_model < 0x10) {
 		/*
@@ -53,12 +55,19 @@ static void pr_ibs_fetch_ctl(union ibs_fetch_ctl reg)
 		ic_miss_str = ic_miss_strs[reg.ic_miss];
 	}
 
+	if (zen4_ibs_extensions) {
+		snprintf(l3_miss_str, sizeof(l3_miss_str),
+			 " L3MissOnly %d FetchOcMiss %d FetchL3Miss %d",
+			 reg.l3_miss_only, reg.fetch_oc_miss, reg.fetch_l3_miss);
+	}
+
 	printf("ibs_fetch_ctl:\t%016llx MaxCnt %7d Cnt %7d Lat %5d En %d Val %d Comp %d%s "
-	       "PhyAddrValid %d%s L1TlbMiss %d L2TlbMiss %d RandEn %d%s\n",
+		"PhyAddrValid %d%s L1TlbMiss %d L2TlbMiss %d RandEn %d%s%s\n",
 		reg.val, reg.fetch_maxcnt << 4, reg.fetch_cnt << 4, reg.fetch_lat,
 		reg.fetch_en, reg.fetch_val, reg.fetch_comp, ic_miss_str ? : "",
 		reg.phy_addr_valid, l1tlb_pgsz_str ? : "", reg.l1tlb_miss, reg.l2tlb_miss,
-		reg.rand_en, reg.fetch_comp ? (reg.fetch_l2_miss ? " L2Miss 1" : " L2Miss 0") : "");
+		reg.rand_en, reg.fetch_comp ? (reg.fetch_l2_miss ? " L2Miss 1" : " L2Miss 0") : "",
+		l3_miss_str);
 }
 
 static void pr_ic_ibs_extd_ctl(union ic_ibs_extd_ctl reg)
@@ -68,9 +77,15 @@ static void pr_ic_ibs_extd_ctl(union ic_ibs_extd_ctl reg)
 
 static void pr_ibs_op_ctl(union ibs_op_ctl reg)
 {
-	printf("ibs_op_ctl:\t%016llx MaxCnt %9d En %d Val %d CntCtl %d=%s CurCnt %9d\n",
-	       reg.val, ((reg.opmaxcnt_ext << 16) | reg.opmaxcnt) << 4, reg.op_en, reg.op_val,
-	       reg.cnt_ctl, reg.cnt_ctl ? "uOps" : "cycles", reg.opcurcnt);
+	char l3_miss_only[sizeof(" L3MissOnly _")] = "";
+
+	if (zen4_ibs_extensions)
+		snprintf(l3_miss_only, sizeof(l3_miss_only), " L3MissOnly %d", reg.l3_miss_only);
+
+	printf("ibs_op_ctl:\t%016llx MaxCnt %9d%s En %d Val %d CntCtl %d=%s CurCnt %9d\n",
+		reg.val, ((reg.opmaxcnt_ext << 16) | reg.opmaxcnt) << 4, l3_miss_only,
+		reg.op_en, reg.op_val, reg.cnt_ctl,
+		reg.cnt_ctl ? "uOps" : "cycles", reg.opcurcnt);
 }
 
 static void pr_ibs_op_data(union ibs_op_data reg)
@@ -84,7 +99,34 @@ static void pr_ibs_op_data(union ibs_op_data reg)
 		reg.op_brn_ret, reg.op_rip_invalid, reg.op_brn_fuse, reg.op_microcode);
 }
 
-static void pr_ibs_op_data2(union ibs_op_data2 reg)
+static void pr_ibs_op_data2_extended(union ibs_op_data2 reg)
+{
+	static const char * const data_src_str[] = {
+		"",
+		" DataSrc 1=Local L3 or other L1/L2 in CCX",
+		" DataSrc 2=A peer cache in a near CCX",
+		" DataSrc 3=Data returned from DRAM",
+		" DataSrc 4=(reserved)",
+		" DataSrc 5=A peer cache in a far CCX",
+		" DataSrc 6=DRAM address map with \"long latency\" bit set",
+		" DataSrc 7=Data returned from MMIO/Config/PCI/APIC",
+		" DataSrc 8=Extension Memory (S-Link, GenZ, etc)",
+		" DataSrc 9=(reserved)",
+		" DataSrc 10=(reserved)",
+		" DataSrc 11=(reserved)",
+		" DataSrc 12=Peer Agent Memory",
+		/* 13 to 31 are reserved. Avoid printing them. */
+	};
+	int data_src = (reg.data_src_hi << 3) | reg.data_src_lo;
+
+	printf("ibs_op_data2:\t%016llx %sRmtNode %d%s\n", reg.val,
+		(data_src == 1 || data_src == 2 || data_src == 5) ?
+			(reg.cache_hit_st ? "CacheHitSt 1=O-State " : "CacheHitSt 0=M-state ") : "",
+		reg.rmt_node,
+		data_src < (int)ARRAY_SIZE(data_src_str) ? data_src_str[data_src] : "");
+}
+
+static void pr_ibs_op_data2_default(union ibs_op_data2 reg)
 {
 	static const char * const data_src_str[] = {
 		"",
@@ -103,6 +145,13 @@ static void pr_ibs_op_data2(union ibs_op_data2 reg)
 	       reg.rmt_node, data_src_str[reg.data_src_lo]);
 }
 
+static void pr_ibs_op_data2(union ibs_op_data2 reg)
+{
+	if (zen4_ibs_extensions)
+		return pr_ibs_op_data2_extended(reg);
+	pr_ibs_op_data2_default(reg);
+}
+
 static void pr_ibs_op_data3(union ibs_op_data3 reg)
 {
 	char l2_miss_str[sizeof(" L2Miss _")] = "";
@@ -279,6 +328,9 @@ bool evlist__has_amd_ibs(struct evlist *evlist)
 		pmu_mapping += strlen(pmu_mapping) + 1 /* '\0' */;
 	}
 
+	if (perf_env__find_pmu_cap(env, "ibs_op", "zen4_ibs_extensions"))
+		zen4_ibs_extensions = 1;
+
 	if (ibs_fetch_type || ibs_op_type) {
 		if (!cpu_family)
 			parse_cpuid(env);
-- 
2.31.1

