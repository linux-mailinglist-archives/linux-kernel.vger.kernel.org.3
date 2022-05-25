Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFE1533A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbiEYJpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241348AbiEYJor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:44:47 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2076.outbound.protection.outlook.com [40.107.101.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C62FD35;
        Wed, 25 May 2022 02:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGwXzEIuSZRIUiCTZmYjGwX1uEHUXtCXadEOO53MlM7LrwYBSEKi6h5OjBSBS95k+EHf3tbGzWn/Y68v+uoxwUKufgVY6QdYvLSLxKuem1LhvStfil+o7MkZmjwDkyGYzDWA8o/xtaOObA1EzRlnGJR5iEajxIBxMuihPNCtmJw9UcLtgNsCfnqLQDcNC7KXU5MOXVVzuPt7KCwyoMfzTJKlNM/j9+M60kRa/g2MRCBFHblU356KKw8+CFBlSXLN9CqwE4tdC2aUn+y4t0lMo8RkSDvwfLHk8E7aTGYEnNyj/6X6AAMuXP+zV23N8eFjpREUWa9wwUnNguEYRXk7Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbvlHW0SmcPizpGbkDxSq1c/GhMxwfxf4uWB+qfxxaw=;
 b=MtngoxfQhUKrHGKFDnQlBsPu5QnKUhMULy3eTqqfv0Bx+gugnDxFx2SEX2oAQCqwnZiG0t4+QoaRWp3u/ObdYg8rea50cKqfT5SfRirI4LQy3s0UzRMz8aZxSOqvz+HXVJoK7gLT+Avypqlj7lBhDAMT/1MHgZnZDSVlaxsIQKG782n5AsNde7JO2lKpLaBSjKzy33GtbMcpD8ceX7W6yWFAxYQeRwETby84WONRdE9rAkdtLCqZcb6pG50CVIKWRhhcv8nvz/4hrWKwATNQYVe7tH1a4zvjZKdGqJ3H5J5Af7zbnHUaYVHIR6P/zlAOmde2qYTCO8QH57MbLblo4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbvlHW0SmcPizpGbkDxSq1c/GhMxwfxf4uWB+qfxxaw=;
 b=H6/IXNrRWUxAk2z8rMywsa2oqwfxeuS+GZsWS8Q0q4Q0B8ywbLxlUIfbe9v4m/3y7ivUf1p9fY+PDne/M5iBYQ6IlxwfZeqD4nWyrJ/27e8e6MW5wYIjmvKFON1eAg4EXCsR05F4wNR9PCn6aFUdTO4zbAoV6gk8BdVgAq+tYec=
Received: from MW4PR03CA0259.namprd03.prod.outlook.com (2603:10b6:303:b4::24)
 by BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:3b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Wed, 25 May
 2022 09:44:39 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::ac) by MW4PR03CA0259.outlook.office365.com
 (2603:10b6:303:b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 09:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 09:44:38 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 04:44:24 -0500
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
Subject: [PATCH 13/13] perf mem: Use more generic term for LFB
Date:   Wed, 25 May 2022 15:09:38 +0530
Message-ID: <20220525093938.4101-14-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525093938.4101-1-ravi.bangoria@amd.com>
References: <20220525093938.4101-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea413e6f-4036-471a-b775-08da3e332fb4
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_
X-Microsoft-Antispam-PRVS: <BL3PR12MB6380FA4C6A2947873613179AE0D69@BL3PR12MB6380.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fv6C2JBh+VvVsQgUBh3zyuXZYdmh+uWjhKxL6BDYwpAp9wDkKJNCUKAj4OM/5FsqyCmK+SBhdldZJIhP5ZU3TV6OlQetQQBhFHLl0c0cfWHC5YHG04bZmbfOdeuDtrBvXbH15dtiysS9zUxECl6OPM8z5XyQ+OQdxtk+f1e1juyW6FRgNr5dXolLHHAEXRadk1ia2FiTRQom1OyhHC9bTfHoqAC0Xhq9e1gzAL9hIYjr6ACLfziKCNH0XBMjGlTywMke5MYQFLDOaoO3U+dKZJovDS5XAtnFDzYbJ97AeBJgQ2IL7UDZRWnrq5L5hHP3VgamoSC8fvGgMm8nX67iEwz6S2T2GEd+smIETF9iNCLN3SLCZCpH/PEguq0tLPZQi4vrkSGIw7h61KWYKYD7BVMtmtOjH7c8+vlkoVov1kj0LZE29DQSk/pkTxSV2VZS3CMgng3Ph6DQffW638tHH7oX8T8d0izEPzOIFboTyhqLS7bBZ1YIspyxWDArs1sNTVG60UNmfUqexbMsD4bHL/HPe9DrEi/HZiF4KX3zRLWnbSAbDm7Z31gnJXFXyd8igxT1wY097JYaV2eMbGoemPBvBOtgtFH6gTxjXQmJgEmknfQITPwt8RpJgrDnX3X8J4SIKFjwN2d+SzVzB1UUPaAXxAeuPY69Z0qvuu+cIsV4mcHC+/tC0PBOLLDzZIWSnWTByvpwnXMW+ytpuBHPR9vfFwtFs911UWQBE7mtWhY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(82310400005)(5660300002)(8676002)(70586007)(40460700003)(83380400001)(86362001)(2616005)(16526019)(426003)(110136005)(47076005)(54906003)(8936002)(336012)(81166007)(7696005)(26005)(316002)(356005)(2906002)(44832011)(1076003)(70206006)(508600001)(36756003)(4326008)(36860700001)(7416002)(6666004)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 09:44:38.9098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea413e6f-4036-471a-b775-08da3e332fb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380
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
index 415d754fea8d..e3b8e174ceb4 100644
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

