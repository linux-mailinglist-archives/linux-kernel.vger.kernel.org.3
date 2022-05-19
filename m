Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B7252D01D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbiESKF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbiESKFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:05:23 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F0A9C2DA;
        Thu, 19 May 2022 03:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrdofBs+XsSKjNMaOXI0P6lHpc0Qb88I7OGOAfU1yBzDVbhivI5QNVknnitt2MOgGZsdLIX/1qtXz7vYL/kfUSkFgL+LL5ACoViUU+qg75BBTLhDplDTDhbzEX+0TW+geZN9x57on2IDYhs1nUQ9urTevqASspwUyBIvK1CXNvDcbKqzRhr5iBsIEy/bvHOzpXX7j1G+ZA+wPwEjG3PKjBw54fZWvbByQh7cTyPgVrE36jWIv4Fh4gSUhjS4kwJvVwK225IuJOXZAEssLaVIIs+Rcn+vuvQ+jFoXX7CvxokKn7vhMbO1dQAjDYh8warAKMiPq0Dg5UOxgbMKg9op/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaf3HW/o/CxmEyfR+WtiJD5CGcdgyg1ZD7c3GTV/aEw=;
 b=cY1J1mhakbYfxGBPfjHMHhW+wkjxWzZs5Fr8tCcgLW32XTLYNcnXxCz3C+WWt3d9guaSMNrbL6FOYGrsStegAA35jEqKSs78gZ0PXtMgqFChIRr4YGMeZrrU/GV2WGrvrLVueRSN5CxBG10UMzHAW1fyQbLJXqlKA08xY4p6kFd9Bx0rvILXotmp9A/vLN8ePPHdcR1dqlPf33fUw/E+olhgPUKSkvI9ZncFTv/3bj4f6Ud/rqPFMgkAtytv9bOz7qrPACz1wI3WAftWcr0PjF0v298YIDS+zMLj4lvMQboCJAQUgYnLuQiLSCBl7rFwt1D+RT7JRgxhcMD91VpKsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaf3HW/o/CxmEyfR+WtiJD5CGcdgyg1ZD7c3GTV/aEw=;
 b=2iDTYbdmgl7PWQPIzepQSI2lownfAnyEDMtkTmN8+UIUKH1brLJiuc1yQBqz+EfViNdXAeKaE/8zNDDRtnEKSQ1e5ogcg75APQQx80Vwz1mU0u/8sgyULYwyvnqLFHzK4RIqzAL8a2yZetMCsErPb5Z1uWYG7CGa2tai4xuQg7Y=
Received: from DM6PR07CA0118.namprd07.prod.outlook.com (2603:10b6:5:330::31)
 by CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 10:05:20 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::2c) by DM6PR07CA0118.outlook.office365.com
 (2603:10b6:5:330::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Thu, 19 May 2022 10:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 10:05:20 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 05:05:13 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <pbonzini@redhat.com>, <jmattson@google.com>,
        <like.xu.linux@gmail.com>, <eranian@google.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 5/5] perf/x86/amd/uncore: Add PerfMonV2 RDPMC assignments
Date:   Thu, 19 May 2022 15:33:34 +0530
Message-ID: <1359379ef34da760f108b075ac138ab082caa3ba.1652954372.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652954372.git.sandipan.das@amd.com>
References: <cover.1652954372.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 843369f2-e746-4809-ff66-08da397f14f7
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5427014A6DBF47C67D3B0D6A8BD09@CO6PR12MB5427.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HlEymHUI1JvPw7GGNbSNtxHNFq0DUsdJBR1NngmykXOiVEXFuZ9tRDgJ+gblqaN9cCohlnJJd8xj6zCqr/iNnf2vXeLUIe2Whydn2gXGZX+3MCFnCz5Ggg/GK52Xgm0ZHOZGKMVihXiW1sV+ept1pXtcA9mb2tdQPlH0dvFedkVc6oQFl4dbaPB/EpnXbwIAL2gDG6hoOmRtVc4lgaW4f6FgV+fq9ZATerSoIRah+kfMs78rm8viPJZ1ALlaVGCfkFI5Elw0pFbB83PfYwhwdp7QLahXIU0sCgJ1PYl1WzkSzdb3SP6VhqoujRlvesWrCg+8tTVzX4KX+fkWPwYNUBontDJyuTCmKOUhkZn5UUPuhs6gygTQdPKcsMdRNjrxE8XSZQc6Pkkgs+pDRGh77m0OBlvyTfBFa6vxiij3OQjpiPXpQ+appPock+yy5mtFvvS6x6rgG8glHwTJxQYM+41NnZvSn97pNT18H1oct4nAA+mavoEi9D+1Oofec8AbBi/JuHyQZbQEV56Ck7A8dMQ2B1z/S87hdhg4x2OgTM8RXQVEOzupPINGPH/xdRERzlGaSfT2xORfe5Mqy8lBt5HjRKjNWnPJH02CU2kiF7ekx0pSVbSbEycyCpTJnuI/zTqFcbbmAI7FES/uJLFldcvBLLE4qqpKoqwm2vmrj1f962sz6Hl1qfQzJJ1sL6JLBAQLg2KgLrlNlusVpqK9OA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(5660300002)(86362001)(8936002)(82310400005)(2906002)(40460700003)(7416002)(110136005)(54906003)(44832011)(316002)(81166007)(4326008)(70586007)(70206006)(8676002)(356005)(47076005)(508600001)(6666004)(26005)(36860700001)(186003)(16526019)(7696005)(426003)(2616005)(83380400001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 10:05:20.0835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 843369f2-e746-4809-ff66-08da397f14f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current RDPMC assignment scheme maps four DF PMCs and
six L3 PMCs from index 6 to 15.

If AMD Performance Monitoring Version 2 (PerfMonV2) is
supported, there may be additional DF counters available
which are mapped starting from index 16 i.e. just after
the L3 counters. Update the RDPMC assignments accordingly.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index ff4238eff087..d568afc705d2 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -158,6 +158,16 @@ static int amd_uncore_add(struct perf_event *event, int flags)
 	hwc->event_base_rdpmc = uncore->rdpmc_base + hwc->idx;
 	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
+	/*
+	 * The first four DF counters are accessible via RDPMC index 6 to 9
+	 * followed by the L3 counters from index 10 to 15. For processors
+	 * with more than four DF counters, the DF RDPMC assignments become
+	 * discontiguous as the additional counters are accessible starting
+	 * from index 16.
+	 */
+	if (is_nb_event(event) && hwc->idx >= NUM_COUNTERS_NB)
+		hwc->event_base_rdpmc += NUM_COUNTERS_L3;
+
 	if (flags & PERF_EF_START)
 		amd_uncore_start(event, PERF_EF_RELOAD);
 
-- 
2.34.1

