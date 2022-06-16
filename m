Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C1D54E048
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376951AbiFPLxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376264AbiFPLxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:53:06 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C439920BFE;
        Thu, 16 Jun 2022 04:53:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjN3EVaR/7KddYdHMFETJ1YzgE9hK3LI2dXe/jUU5ba6ZWBIlHBBtmhohdPgFloGABcsMEUH9z7ZyzGMonJl3BBHF3PCu/9ZeJG71Rg4KrcMvSydGnrJOtQJF3B/G6dIn/vCZNsbxssm/4S2Psz6s2MKfO4aakJkJuKI5AHKDjsE7PHl6iqLAa36cfvC2LkRwM9zOYAV2Ue3UknFVSxmEend9xrUfeVV4+mPrack9/w8I3if3i3D2BQask3DkAxI7u9HRxPnAhrFYmDx2F1nlNAejQqArgRGPPez9CPkIoUkRXoZOuFRc8NvS436qwS28ESTLT+YttdqHLEjrx/0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ALr2NNyXlftcsI3pykDR0VgCopBEfWvIBzsn78c5Lo=;
 b=UX/9vY1BEMKUkFKutocsk/o7ideJ04omo0Xi+UmrJNkviVai5jWrWtDdiJ+yv7evqZ0hHtVp24cPygXBef09hL8G3YdBF8CKUmQbypmetHSzAMrLfPYLf3nGfIknkMZRGfMA5BgXi+L3EL+QYRec9JO+km6XP8Dg75ZuuwwwXdHsWVu/MCLBG4oaiUEvHzL2f6lIeNRXy1RfnpcRM6ktviUvib4CF24AHvmH2FoZLjU3/uivOWvY3KDKh2eTtwTT95OkqDB6JT4g0DidiVBVFuCGQAMbObwhzOrdvMBBdY3IMx25spHFtEluTJXVJ7ZQ1XiaVfA+vPekKGjR0KcPhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ALr2NNyXlftcsI3pykDR0VgCopBEfWvIBzsn78c5Lo=;
 b=IE8VPLAYZpT49exP6lePZr2YgIXBTEk7japYIDyhkntybExEiohmRutL3kOC8VCrVzr32JDSNNDG51IDuejVX90S1uzisP9s+JXaXBvsmlutGDNOttuRq4g0CMEgBZhmfKNnNF0lvmvbSMCuToegEEKW8phVAvTh+sDBk22omB0=
Received: from MW4PR04CA0215.namprd04.prod.outlook.com (2603:10b6:303:87::10)
 by BN8PR12MB2995.namprd12.prod.outlook.com (2603:10b6:408:41::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 11:52:58 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::47) by MW4PR04CA0215.outlook.office365.com
 (2603:10b6:303:87::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Thu, 16 Jun 2022 11:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 11:52:57 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 06:52:44 -0500
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
Subject: [PATCH v2 12/14] perf mem/c2c: Avoid printing empty lines for unsupported events
Date:   Thu, 16 Jun 2022 17:22:05 +0530
Message-ID: <20220616115207.1143-3-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3c70109b-2252-449a-37cd-08da4f8ec17d
X-MS-TrafficTypeDiagnostic: BN8PR12MB2995:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2995F9F93B9E55726C0C7F3FE0AC9@BN8PR12MB2995.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NElhUlsfqGl8YJWOBYMlBF12RVHpTDe5qq6zrhl23ZX4R8NSCjf+rEFA6lqarqn/5Pu2EoEA/eC4IJD+1AXG0MV5kzusvGUvO/FP2KmUt3djBrydzTDQplmWk3O3fsba+AXNYBisjongkvfhB9amf+ifDOx4jwETZAx8/bp/sJGOy/jqXH7hB/7wDlgM0UmLwF4mq4dgBrIHX6F9obmwmpZOFCZbtmpoycUopdUTdGXcyTSdsa5L8pN0HIxoIJb6E5YKvqKeNhP1hWSpkcU6gnKQtgnRowyUUzQ4bzg+1FZ2NHprfV8Fb93CjT96e/7jmWu6WETKb3JQoqXBTwPbAOWKUMoa6Or08caTSGipYHfwEeKLE+2qtT4ClUEz48+JFw7AS2Yxf2eTLfiiHm2Kr0vRbdtrhQ/mNrM4wFk6bEevP5P+6CpuCXjsQ5tl0dIrTtiSNd4drfxXWmKcmektPvMwwa0Xj0FcyNBtNcO1XzgUL3vLFvq18jn+hgXUZHpe1cRz8Uf9N41FciL4WDsOqslBZIVI2PL2Vhz6UOwu12GxIqn2B492uxvOdCjrmeC2AGfnO6igCOeuFEQEHWeJRmbaBnT3nU35kLtPi3gwGJCStnvEjba7yUygGqjk8sC133QjGKJdn91beXgoq22v2Z2FbV/1H5Gph398X+AijifFtW2p62pU1JilP3ZsALhhqm6Hp8jIdrUvaz/VWkcbSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(8676002)(4326008)(6666004)(16526019)(316002)(70586007)(186003)(70206006)(508600001)(2616005)(1076003)(54906003)(83380400001)(82310400005)(36756003)(336012)(8936002)(2906002)(47076005)(426003)(356005)(44832011)(5660300002)(7416002)(110136005)(7696005)(26005)(86362001)(81166007)(36860700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 11:52:57.4787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c70109b-2252-449a-37cd-08da4f8ec17d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2995
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf mem and c2c can be used with 3 different events: load, store and
combined load-store. Some architectures might support only partial set
of events in which case, perf prints empty line for unsupported events.
Avoid that.

Ex, AMD Zen cpus supports only combined load-store event and does not
support individual load store events.

Before patch:
  $ ./perf mem record -e list
  
  
  mem-ldst     : available

After patch:
  $ ./perf mem record -e list
  mem-ldst     : available

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/mem-events.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 4a55cdd51bba..91db7a0e2da6 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -156,11 +156,12 @@ void perf_mem_events__list(void)
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 		struct perf_mem_event *e = perf_mem_events__ptr(j);
 
-		fprintf(stderr, "%-13s%-*s%s\n",
-			e->tag ?: "",
-			verbose > 0 ? 25 : 0,
-			verbose > 0 ? perf_mem_events__name(j, NULL) : "",
-			e->supported ? ": available" : "");
+		fprintf(stderr, "%-*s%-*s%s",
+			e->tag ? 13 : 0,
+			e->tag ? : "",
+			e->tag && verbose > 0 ? 25 : 0,
+			e->tag && verbose > 0 ? perf_mem_events__name(j, NULL) : "",
+			e->supported ? ": available\n" : "");
 	}
 }
 
-- 
2.31.1

