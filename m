Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24CC54E049
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376962AbiFPLxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359638AbiFPLxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:53:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C104BFC5;
        Thu, 16 Jun 2022 04:53:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WX1tkJ77MFyO3AbGUn1vDmA2VzWDClfDZWr93tUeRXlCCaQtH5ROGi2il9KL6GIIHFoD5TNDRD2uXaVH6uAM9qV2UTVqDHQ0fTmPxg2wXewFL/MBgH9Vy26SrHpuoN8jr3HnKoJYvNUjn42mLAoGZ/dXkWxNWZ7cYMOY9MUU/BoIpVeUHbDP+dmuBDjxJqeZlyz08WJ0u+kjiPmpoPLTWKCb2gzzNgXDTV82TkwrJEIzeoZk/KPGdVZaSuCQ43DVE8dILfRIAxRBjIpz/pEvWPOA9hi+4abEtqx4ebJStQ0f5OAbljvH2/VNWNDsD9+3VC+JzdNPGVM5x2kcLZzFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHF6GhsDGu0DVoN+r0XRwSsGyhPdEwh9QBHC7+i2xwI=;
 b=lsEh1N5/VDOLpDbmCta4ePH/ebmK29xvgS8MZRIk8pGNqARUF8+jtyy2D9ZVUdyZelB85CO25sU9vv1zN/lAczEfy/NEwQZ+xzxgDzxpSnHmlb8svwFvRseRs4BqTwJ+eS8URauZbqxCTnwYZFHQGcOr/iNaZ3rFhgrRgwnd7nWLczKr9sg5KKRGRmhD+3cwY47F7iwXixF7HWSy3Oq+qaQQs339hq5zkbeFKqCJQG44QPDn/2N4Rh4rOsLX2SBGXTnQW6KyoAJhNQm54xQdlG6UaIoqPKRMWTVg5wv5lqd7agdLFzCrr2Gn9wb66lZJQ0knuDABM6Z/2fKOZajY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHF6GhsDGu0DVoN+r0XRwSsGyhPdEwh9QBHC7+i2xwI=;
 b=4V4zhJxI9Phfas3vW/vIcigt+LedXTI6bm3GX7ORfFrePOMofmPjTO4eBCcnr1w+BKgW7Vq6IFhAXhLYXFPNIohI2S+tArBLYGr0d/zGzN76cgjbfotW3zPoMkHXa4BnyRpBU4Ts00MDBN5TvH0UbLbq5bB+DYenypUdFtdC4Vs=
Received: from MW2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:907::35) by
 MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Thu, 16 Jun 2022 11:53:38 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::6b) by MW2PR16CA0022.outlook.office365.com
 (2603:10b6:907::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22 via Frontend
 Transport; Thu, 16 Jun 2022 11:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 11:53:37 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 06:52:55 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <eranian@google.com>, <irogers@google.com>, <jmario@redhat.com>,
        <leo.yan@linaro.org>, <alisaidi@amazon.com>, <ak@linux.intel.com>,
        <kan.liang@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2 13/14] perf mem: Use more generic term for LFB
Date:   Thu, 16 Jun 2022 17:22:06 +0530
Message-ID: <20220616115207.1143-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616115207.1143-1-ravi.bangoria@amd.com>
References: <20220616113638.900-1-ravi.bangoria@amd.com>
 <20220616115207.1143-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fc193ff-f8c3-4872-8186-08da4f8ed986
X-MS-TrafficTypeDiagnostic: MW3PR12MB4348:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4348D229D7290A9CDBEBAB05E0AC9@MW3PR12MB4348.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2p8YrM1mW75olWgN8x6I1j+/ADAyu/qlfwl9S6OmS6SZVH3a/m7rQZK02s7RfGVDKEZs8u1Q8Gul8IuYh6fcBvyu2AfCXkVvdx3I7tM1u+wE4laPdnqCL/y1NLskFZdnwb0zCF5JFO3TyUODL7UGOg4NUVoasPb8eWLQ+HfYyt5HolEynQD4qkF6xzhEcqlKtKBTm18z3T8PVvVGwadYWNP2PlrKIZ2OOlPC9nXhRfyjf96MEKWtKaVds2TaiU99y8pczHXWhj0383mxnA0W5+MmwGgZxEcLsd7Xq1p26/KcYTSlIpnmTUWq4Uy84hkaTEvUQ9JSBmsghtISjsRTWboIK87xWAtdW/F0vpFDxi5cE/gtG/NlSHmvIN8/lKyjKIuKtme1IXZ9UiSHgnFzdX2xExy/kgLj3APQSeUCrXjbBNPg5CElTQ6EZ618rMxMmdnX+dTFVjs58r6C57xlXqQoRigP+rCyGG+X+UXNQzBW9n7CyETMNHt0eNtKjCH6weUcnU34si/aFrKVsCQPbx4yXD4RT1FOQnzOuk9mE0RundJW/0IGNg7f4TBIO68FtWthwaY36hYX+nn5X9ZDEJLZ/VIV96d4m5V+S/SuWW4JlzjGmGdJe3zH0wO/2YD+ve3YYy8mV2fxkPj6BFDFwNWncN48eacYR/615s9CDRl3hTgJJgnbsG8YI4i35bwj3G1RSVcIhlFqkLAwlMzn5DmY1KMxzn97Ep2sHFYFPdk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(6666004)(336012)(426003)(47076005)(1076003)(186003)(16526019)(7696005)(86362001)(26005)(2616005)(36860700001)(81166007)(83380400001)(356005)(8676002)(8936002)(7416002)(5660300002)(44832011)(36756003)(4326008)(82310400005)(2906002)(40460700003)(110136005)(316002)(54906003)(70586007)(70206006)(508600001)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 11:53:37.7580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc193ff-f8c3-4872-8186-08da4f8ed986
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A hw component to track outstanding L1 Data Cache misses is called
LFB (Line Fill Buffer) on Intel and Arm. However similar component
exists on other arch with different names, for ex, it's called MAB
(Miss Address Buffer) on AMD. Replace LFB with generic name "Cache
Fill Buffer".

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/mem-events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 91db7a0e2da6..eaa8efcf255b 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -282,7 +282,7 @@ static const char * const mem_lvl[] = {
 	"HIT",
 	"MISS",
 	"L1",
-	"LFB",
+	"Cache Fill Buffer",
 	"L2",
 	"L3",
 	"Local RAM",
@@ -298,7 +298,7 @@ static const char * const mem_lvlnum[] = {
 	[PERF_MEM_LVLNUM_EXTN_MEM] = "Ext Mem",
 	[PERF_MEM_LVLNUM_IO] = "I/O",
 	[PERF_MEM_LVLNUM_ANY_CACHE] = "Any cache",
-	[PERF_MEM_LVLNUM_LFB] = "LFB",
+	[PERF_MEM_LVLNUM_LFB] = "Cache Fill Buffer",
 	[PERF_MEM_LVLNUM_RAM] = "RAM",
 	[PERF_MEM_LVLNUM_PMEM] = "PMEM",
 	[PERF_MEM_LVLNUM_NA] = "N/A",
-- 
2.31.1

