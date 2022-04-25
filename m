Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B315850D873
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 06:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241095AbiDYEsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 00:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241098AbiDYEsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 00:48:03 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2048.outbound.protection.outlook.com [40.107.100.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF596259;
        Sun, 24 Apr 2022 21:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQELafaSDBDCxW3tOJ1aN0/kXShPhn2SgZq1/rzqu1n7ITGGWXJZgF3WCY1LkW7iiarLlh8INiKQr5IXmpxTSSUmt76VBeBmyNQDIIYvun1iimIcAR29RZoAGEYacSPcMYDNENeHRdhMJFjy6QsQTY/qNnEpvRk2WhQGV7wYZxCs+GBBx85LPoTRy5Mhzu5dJqI2uRH1jMiQ6KiFPIufBbL8iJsP0fcCkkE38uIuE5IUWppV0eX3WiZD01XslalMxVmp4JKkq6pgTDi1fRNijKJZAmmyKqNl7gFgYeL35510IebVaUBXGKxjEQUd11jqbJ29qlewnZZXtExHoRq/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXrhnNVglxfntHCruD8syJju9Ckj5uNZp0L84Avh4RU=;
 b=ME9HvNyWkr/2eBw9LYAt6qRYyCWcv7jgu6Y01z5jsGe6HhgYmkZuI13Z5lp2MPDLcWzA2quWZj43KCGozv2f2ICTx0OFFwkqn/Sgtp2ZKDBxSPj7508I4bm+xyXwzSP3DyklP+oTlXH9OJoTsmr6yKvhgbF4EwzwRgp/3eLjYf00Sls04xh4CxScxQzkpOGY9jRArnJpIfiWFQORhocOsBmMpZARJ5dRCvBblNjccc6mv2+7i5rewb8Ck0mnwyXUMtNxZcGeWHbexS9l885JxusDCUN8Z4DijuAXz5FjFyoFyjSSq1AsxDF/eZNXKsneePK66ATG89X3gYsUPvTvBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXrhnNVglxfntHCruD8syJju9Ckj5uNZp0L84Avh4RU=;
 b=Zu/rmyOMM1XzgtQu4/pCPpEeNE/JUCmRChqSGjA5ru57JTvwmEXlkMhhGBm7O7gEk5YkFJEaCIxyvWEPGEI1U7gdaADxNdjfZSZvrb0JhNfwzZ16fRwW8R4OcWw9ow2MoxKofym4txDEx06PWopCNvVk6VAEXyH4tuwosTyZMGU=
Received: from BN9P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::23)
 by DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 04:44:48 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::5b) by BN9P220CA0018.outlook.office365.com
 (2603:10b6:408:13e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Mon, 25 Apr 2022 04:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 04:44:47 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 24 Apr
 2022 23:44:40 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <irogers@google.com>,
        <yao.jin@linux.intel.com>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <rrichter@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH 5/6] perf/tool/amd/ibs: Support new IBS bits in raw trace dump
Date:   Mon, 25 Apr 2022 10:13:22 +0530
Message-ID: <20220425044323.2830-6-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425044323.2830-1-ravi.bangoria@amd.com>
References: <20220425044323.2830-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d4d01d1-1d60-420b-5993-08da267653c5
X-MS-TrafficTypeDiagnostic: DS7PR12MB5815:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5815833A139663AE10E55A34E0F89@DS7PR12MB5815.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qDAZ8ax0onNTLEGLzM768+KDXCSgdW/lIZ/bRBEX1BLjaEAxxIW5Km1mYuM674+EHcaNqH63fuXvYfBdJl7BQ6Zyc6TcrxucyhR5/JhsB1H77uKddVsSoNKIgluZaI1Yl4M7AnGWfggmd6W4hyHFGVUU7acMOjH/UF3pw91ZeQs5Nq0QGrjXxHYoaA5yh1/iw4QaPn8J304blIrvuKYUZDQ2TNcwRv3QolDYCGs2Cubha184cPnXikimZ23k1OGcdvc/amWSI7I6bkr4IEUFE79AdkYUJV9qrwaKl3fB4Jlg1UBuJdHSZ+dat3FiHNKOAaizcHGs1k2pEGEgxI0PRIG01SUUvxf8I/s6BwR9oic9sSXw6TLikP2jdlo3/ZUhOv3+BqQ31VWmRlgSeFq0iKl0rgEF5ZUCgnP2uVcfBZN4zy+589dUvDgeTdc200+Wbf8DI0epqdoeZqVczYwV9BJp8fNf8Aq9guzavv4ow8EUFrSOh0k0mt5mgQQoezQeOb3lIhAFyy/dxpmnhLKXB+vBte50gb8w5wmr/o41IR88A6R5T/C4NmKzzF061lbelm2Y+nvDzGKU4wt7SNToqOUIoLHSxvMvyf0L4u6a41Z27sPxMW2Br/I06xCZ3zc/zWFL8Eaka0q3gR8MWnf1NtNEFQWNEU554lADxp9JVRFDAbaMku+EM6BPz2bQLrVos7MMDCGT16LOEi8bjQCIyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(426003)(356005)(16526019)(83380400001)(508600001)(47076005)(336012)(81166007)(86362001)(1076003)(186003)(110136005)(36756003)(5660300002)(8936002)(7416002)(44832011)(2906002)(54906003)(7696005)(26005)(4326008)(2616005)(70586007)(70206006)(8676002)(36860700001)(40460700003)(316002)(6666004)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 04:44:47.9004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4d01d1-1d60-420b-5993-08da267653c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBS support has been enhanced with two new features in upcoming uarch:
1. DataSrc extension and 2. L3 miss filtering. Additional set of bits
has been introduced in IBS registers to exploit these features.
Interpret those bits while doing perf report/script raw dump.

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
 arch/x86/include/asm/amd-ibs.h       | 16 ++++---
 tools/arch/x86/include/asm/amd-ibs.h | 16 ++++---
 tools/perf/util/amd-sample-raw.c     | 68 ++++++++++++++++++++++++----
 3 files changed, 80 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
index 46e1df45efc0..f55c299554a8 100644
--- a/arch/x86/include/asm/amd-ibs.h
+++ b/arch/x86/include/asm/amd-ibs.h
@@ -29,7 +29,10 @@ union ibs_fetch_ctl {
 			rand_en:1,	/* 57: random tagging enable */
 			fetch_l2_miss:1,/* 58: L2 miss for sampled fetch
 					 *      (needs IbsFetchComp) */
-			reserved:5;	/* 59-63: reserved */
+			l3_miss_only:1,	/* 59: Collect L3 miss samples only */
+			fetch_oc_miss:1,/* 60: Op cache miss for the sampled fetch */
+			fetch_l3_miss:1,/* 61: L3 cache miss for the sampled fetch */
+			reserved:2;	/* 62-63: reserved */
 	};
 };
 
@@ -38,14 +41,14 @@ union ibs_op_ctl {
 	__u64 val;
 	struct {
 		__u64	opmaxcnt:16,	/* 0-15: periodic op max. count */
-			reserved0:1,	/* 16: reserved */
+			l3_miss_only:1,	/* 16: Collect L3 miss samples only */
 			op_en:1,	/* 17: op sampling enable */
 			op_val:1,	/* 18: op sample valid */
 			cnt_ctl:1,	/* 19: periodic op counter control */
 			opmaxcnt_ext:7,	/* 20-26: upper 7 bits of periodic op maximum count */
-			reserved1:5,	/* 27-31: reserved */
+			reserved0:5,	/* 27-31: reserved */
 			opcurcnt:27,	/* 32-58: periodic op counter current count */
-			reserved2:5;	/* 59-63: reserved */
+			reserved1:5;	/* 59-63: reserved */
 	};
 };
 
@@ -71,11 +74,12 @@ union ibs_op_data {
 union ibs_op_data2 {
 	__u64 val;
 	struct {
-		__u64	data_src:3,	/* 0-2: data source */
+		__u64	data_src_lo:3,	/* 0-2: data source low */
 			reserved0:1,	/* 3: reserved */
 			rmt_node:1,	/* 4: destination node */
 			cache_hit_st:1,	/* 5: cache hit state */
-			reserved1:57;	/* 5-63: reserved */
+			data_src_hi:2,	/* 6-7: data source high */
+			reserved1:56;	/* 8-63: reserved */
 	};
 };
 
diff --git a/tools/arch/x86/include/asm/amd-ibs.h b/tools/arch/x86/include/asm/amd-ibs.h
index 174e7d83fcbd..94b75721c3c8 100644
--- a/tools/arch/x86/include/asm/amd-ibs.h
+++ b/tools/arch/x86/include/asm/amd-ibs.h
@@ -29,7 +29,10 @@ union ibs_fetch_ctl {
 			rand_en:1,	/* 57: random tagging enable */
 			fetch_l2_miss:1,/* 58: L2 miss for sampled fetch
 					 *      (needs IbsFetchComp) */
-			reserved:5;	/* 59-63: reserved */
+			l3_miss_only:1,	/* 59: Collect L3 miss samples only */
+			fetch_oc_miss:1,/* 60: Op cache miss for the sampled fetch */
+			fetch_l3_miss:1,/* 61: L3 cache miss for the sampled fetch */
+			reserved:2;	/* 62-63: reserved */
 	};
 };
 
@@ -38,14 +41,14 @@ union ibs_op_ctl {
 	__u64 val;
 	struct {
 		__u64	opmaxcnt:16,	/* 0-15: periodic op max. count */
-			reserved0:1,	/* 16: reserved */
+			l3_miss_only:1,	/* 16: Collect L3 miss samples only */
 			op_en:1,	/* 17: op sampling enable */
 			op_val:1,	/* 18: op sample valid */
 			cnt_ctl:1,	/* 19: periodic op counter control */
 			opmaxcnt_ext:7,	/* 20-26: upper 7 bits of periodic op maximum count */
-			reserved1:5,	/* 27-31: reserved */
+			reserved0:5,	/* 27-31: reserved */
 			opcurcnt:27,	/* 32-58: periodic op counter current count */
-			reserved2:5;	/* 59-63: reserved */
+			reserved1:5;	/* 59-63: reserved */
 	};
 };
 
@@ -71,11 +74,12 @@ union ibs_op_data {
 union ibs_op_data2 {
 	__u64 val;
 	struct {
-		__u64	data_src:3,	/* 0-2: data source */
+		__u64	data_src_lo:3,	/* 0-2: data source low */
 			reserved0:1,	/* 3: reserved */
 			rmt_node:1,	/* 4: destination node */
 			cache_hit_st:1,	/* 5: cache hit state */
-			reserved1:57;	/* 5-63: reserved */
+			data_src_hi:2,	/* 6-7: data source high */
+			reserved1:56;	/* 8-63: reserved */
 	};
 };
 
diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
index d19d765195c5..8635385b5b34 100644
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
@@ -98,9 +140,16 @@ static void pr_ibs_op_data2(union ibs_op_data2 reg)
 	};
 
 	printf("ibs_op_data2:\t%016llx %sRmtNode %d%s\n", reg.val,
-	       reg.data_src == 2 ? (reg.cache_hit_st ? "CacheHitSt 1=O-State "
+	       reg.data_src_lo == 2 ? (reg.cache_hit_st ? "CacheHitSt 1=O-State "
 						     : "CacheHitSt 0=M-state ") : "",
-	       reg.rmt_node, data_src_str[reg.data_src]);
+	       reg.rmt_node, data_src_str[reg.data_src_lo]);
+}
+
+static void pr_ibs_op_data2(union ibs_op_data2 reg)
+{
+	if (zen4_ibs_extensions)
+		return pr_ibs_op_data2_extended(reg);
+	pr_ibs_op_data2_default(reg);
 }
 
 static void pr_ibs_op_data3(union ibs_op_data3 reg)
@@ -279,6 +328,9 @@ bool evlist__has_amd_ibs(struct evlist *evlist)
 		pmu_mapping += strlen(pmu_mapping) + 1 /* '\0' */;
 	}
 
+	if (perf_env__find_pmu_cap(env, 0, "ibs_op", "zen4_ibs_extensions"))
+		zen4_ibs_extensions = 1;
+
 	if (ibs_fetch_type || ibs_op_type) {
 		if (!cpu_family)
 			parse_cpuid(env);
-- 
2.27.0

