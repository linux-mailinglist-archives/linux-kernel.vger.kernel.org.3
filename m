Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355DB539BB4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349458AbiFADc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349457AbiFADcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:32:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B3F255BD;
        Tue, 31 May 2022 20:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFJUUKoWEdMz7Owy1rp7rKoJBnpw4usAS0T8273cV5qaU7uPDLzhpaFJXMvBYUf1brWpwQRo20l/9yBCZiLt0rkOxgdszczVYpwpmnoe9t3nkhk2YzWF3l08ygNs5S5c7K+1i2nMpFakvVydUMcdgYZSVzOtWeqcsbGFnzmdOlC+7Dnjl7YSgaBrJDKORQkJflyT/Owde/pPREh/3prpGHS49fnSA1ulr/3a0mkpHCUqGBYAHRCQzAX1Op8DwO5dYvB4CPY51tuxchuE+R1ISDW2QPGkCy06qnqD7ixiJdXM16B9doTC+znpBtecxLRDhBdYiJVHnLylv6+jWd9Zgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDr3Aud2f3bEWRA5lYEAheLaXurwbvIRmVzaryhpqQQ=;
 b=Ik4f+c8lPCa32HkLttmlbbZsEs5ERYmqZXhMkdf3TGcMKZHoR+8Go4mkbgT1omzmCq1y/WfkENIvNaToRo9ifzrB6fJZPzF1DfcRZgCs5FVFZq/k/x4KM02a+IUU00bdjZ5swJHvFUgg/sypjrxLQRm8HEZ0HTT9T8CGAAeCiYRmdJEMbTzIlbR0eq1YWXm3aYAceDmtAKzIZeVgy3UIlGCkrW81Nczadv0uTxkDq1uhNuqe4iHXLqonmyMQ7rdj3TPqnZYqxVPyFT+Rjyp8l/N6Lqps7zd/IpQjRiVue4sV8Rsae+Pkbi0+5aF5c7Q0HyUxZ4eG6m7zulhJ/uokZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDr3Aud2f3bEWRA5lYEAheLaXurwbvIRmVzaryhpqQQ=;
 b=Mg1iva7gy/Ib6rj49SYnTs+vVheX7Kuyx2LPpmFvo8gblRtRcn00k8r57Ujjo3u/hqThMBijMp9p3dzNaAJNgd1k4n9dK51bsTFtNyA0+7KSZuZtMiw/FCS2CGrhy3XH6hx04jlCBaTtTsSce1rcG5FR7sJ71SgVrt33schw0ZY=
Received: from CO2PR05CA0054.namprd05.prod.outlook.com (2603:10b6:102:2::22)
 by BN8PR12MB3570.namprd12.prod.outlook.com (2603:10b6:408:4a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 03:32:17 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::8d) by CO2PR05CA0054.outlook.office365.com
 (2603:10b6:102:2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Wed, 1 Jun 2022 03:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 03:32:16 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 22:31:05 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>, <kan.liang@linux.intel.com>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <irogers@google.com>,
        <peterz@infradead.org>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v5 8/8] perf script ibs: Support new IBS bits in raw trace dump
Date:   Wed, 1 Jun 2022 08:56:08 +0530
Message-ID: <20220601032608.1034-9-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601032608.1034-1-ravi.bangoria@amd.com>
References: <20220601032608.1034-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb70098c-44d9-4f10-7da0-08da437f53c4
X-MS-TrafficTypeDiagnostic: BN8PR12MB3570:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3570F2ABD4C39FF81366F791E0DF9@BN8PR12MB3570.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4D8kvjawopgIu3E+9XJ/zSXe/fLyVyBwDTp4cG3hR5LOC/0hOt7zD+c7laXzXcP5YsK4cAGqwQRg9dIioGRAUp9tYbKphLZu8pl5jEplvWwrzuhUonLgAq5hyh4FHwde/slXMqbfGY3kcysjqtqePnJDwNS2mSgyt6a33ECyovBOeDDeCkyIDAnyJsxKPQAa4jUTKX5p3hdmHEiP7A9OPBIMoqAbgXB+AJanwOnVK+t9FDNz17/wHA8a6Kh941QK7ZrAFDu3U1lnwV0Ix4Eqt4aV4H1Qd0B3eh+yYkezf/AYAjOEfjy3opYSMBqes+6TYjhC1dZd9wYer1hiTBFvA2m1LQjcKclEiVII2OOFm7nf59R2TqPnAH50x9Vj8Il7yJ32ghrEyAGm/MxMcFj1EGGyPx6oQANVpPRFdBuNcj7hla6ym4IN3fnAzXkl7PVcVIgaq7gdl/4r8JGaLnLwIzhYL0Rj+UmStzXKAO8mDO98D7y9lLXr8ovn4fWgJ2ZwXQan7vDCQzBFWLpJ3vhiO8LAS2FP3LZ0iaD21ThNpLwML+TWyf10S8Z/xtFwv7HPSWX51szpVv5xK0/CtM3S8Jq3aqYuHrBGaTB/nYEaeqOrBabfNn6Vx6jrmwYQnU4TYz38dBUJzL9FdMFAQuOaHLV1c0FrSj0P6ZJGfRzjQttO6WIwCIhXnTV+1RA3VNFCrNBt7RIiKZRHGoVi5tbdRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(44832011)(36860700001)(7416002)(47076005)(82310400005)(81166007)(356005)(5660300002)(508600001)(8936002)(40460700003)(186003)(83380400001)(1076003)(16526019)(2906002)(26005)(426003)(336012)(86362001)(7696005)(2616005)(4326008)(8676002)(316002)(70206006)(70586007)(54906003)(110136005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 03:32:16.9765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb70098c-44d9-4f10-7da0-08da437f53c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3570
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

