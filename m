Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8FD533A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbiEYJoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241814AbiEYJoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:44:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22E5101F4;
        Wed, 25 May 2022 02:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsHMzJVpOEyVr3kbTczaVsOEymDANCZaOoQgcqZ6D2R4PTszyWSEFDL/860YSFY8q8utuUBgvY50oN61Te8bbOVnY7qPGFqbLoq0AkcV+fxvENNSoFfh+pSQ+ESayLTJA1uhRDNtXehdLTZJDIVht56GyWJ94AUW2utv0aDywb+1PgwAkIjzpp7DJyoxd/J5x7rMvRc4JLmmZIJk0qH+QJ/tZyxnnVVFKlahAVitoxAhY0qW6QrIQ4P6YPdiLdsU6PVdXnLvVN8fgIEuCR/C9KirwQ2CX7OhlAUin1n5ohjABGaU5N25WT2yobPI57IjJURW6jbRpJbTmkMIeqaCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jChmi6CcSH8tCq0UnJ4wCywxwZ6gh/v3lJ/t2HccLto=;
 b=TQo3ztMf0NvnFCWrUwqOnCM+YTZ3UEVS101UckRQGWkhMIZ/v0n7zhrmS8yYGNY9cJ43Npp0cFm16zSTl38h2eBNZvA+NznWGhUovs+0+EwXdb7fgnx+/uknz9SxcKc6A4WmA2HM3Vwc/iKS1L3jaS3lqeJb58rpdBgf2U8J+jD/6zM98A4UTiKQkqEaYEpUvw+vVdx9Jx6oT/OVA1wiOOmBCHHb8x//LJaX8GmMy4nWdpRyslxZfV5FEQXxNYNRlajmBexZ/DHSYZF6xZdQKx5Xm4EikUDgWrX8RRZTG/404uZleNn4Fr4uPFxI1OK5rPKBRnLECuCqzg5/G1n5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jChmi6CcSH8tCq0UnJ4wCywxwZ6gh/v3lJ/t2HccLto=;
 b=H7vTCbsSFcRufKXFH7PqkHx3/4Xk76683j0iuwkQhiyg/6NR7hX6S2rPYRfVW3ep4imA8nstW4Mo28yaHMYF1pQdgJ8PnCt267/4aZ38Ot/+LP6bOvDmlrN2n94QyEzqb5sorvQmc52UM9tBp+WGZpE0H78U2lB46m/bw88tK0E=
Received: from MW4PR03CA0128.namprd03.prod.outlook.com (2603:10b6:303:8c::13)
 by BL0PR12MB4721.namprd12.prod.outlook.com (2603:10b6:208:8e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Wed, 25 May
 2022 09:44:01 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::cc) by MW4PR03CA0128.outlook.office365.com
 (2603:10b6:303:8c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Wed, 25 May 2022 09:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 09:44:00 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 04:43:46 -0500
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
Subject: [PATCH 10/13] perf mem/c2c: Set PERF_SAMPLE_WEIGHT for LOAD_STORE events
Date:   Wed, 25 May 2022 15:09:35 +0530
Message-ID: <20220525093938.4101-11-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c8ef51e9-8251-4bb0-67ad-08da3e331895
X-MS-TrafficTypeDiagnostic: BL0PR12MB4721:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4721CDB13055E4FBFE0D7707E0D69@BL0PR12MB4721.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1zWU6qfckdOSJ6c6CjFkPXJR6BVXGYZtQ3/prd5GHwvaHuJ4eoZ2IgizvVMA6ydKq2HrRKcf0QRJ9qFDLOXluydgs12f1WNUtEoKOgGXtDYuVgRrN+3Bd+PzDDZ68FdlA2U/x44Y6xPMba9MU6Tbo7lFmfQssnZghNTp0qb49rcZvmm++kwsuhb8l7WMQi0+6cF8Gmm3Va5vhlcSuembqFHBlaazPjGNKJpl9xu33nRaH4smorH9qNjb6A8alMRaw/x7KWEJZtwtUw3GU2i4UOy3i/8g22OPNMWAoGkZ3LXOpWp3xp+vB8LmvFrKPNFjaT41vArVxUVm09XxdEMsJXWhLR6m8CgT88fLZU0ID7uqs8PeKhNG/lblQCIhODSEvA+isqjvhzPoeg6yu3EMtG5xrMh20W4Act7SZQHxEjZI9dREKnTc5OAR++TMBFbuDQPrCvvtheK8DlQWlldqmw/LEgaToTuCVNjXzs2mcXf2YddTIpJ9ueO9uVilZYlmIwpRJml4HVrYpth0Ydd19Y2PF7nUHea2CTQbYcZaJcOd/lBJOo9MSog2yr6T7fA4O55HOqkuQ6CJNMN067GHEUUlJYdjzMF9WZu50ZK/AgwUgNUhRXorTQWcxAt/zI4L5PkQzYptuJ8XawkDJQMT1GublrG+g+FAsnaTBYZcTm9kTCbrmDSBHJldsAtUY20O3vtEUsZMJBgMGuuytNsFPH2S0ce/EI9EAM2ZJvuw29X9zXkoD+GWVMaPwwCKsNNg
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(4326008)(356005)(8676002)(7696005)(316002)(110136005)(1076003)(16526019)(70586007)(186003)(82310400005)(70206006)(36860700001)(40460700003)(54906003)(8936002)(81166007)(44832011)(6666004)(2906002)(86362001)(508600001)(47076005)(336012)(426003)(26005)(7416002)(2616005)(5660300002)(16393002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 09:44:00.1014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ef51e9-8251-4bb0-67ad-08da3e331895
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4721
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently perf sets PERF_SAMPLE_WEIGHT flag only for mem load events.
Set it for combined load-store event as well which will enable recording
of load latency by default on arch that does not support independent
mem load event.

Also document missing -W in perf-record man page.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/Documentation/perf-record.txt | 1 +
 tools/perf/builtin-c2c.c                 | 1 +
 tools/perf/builtin-mem.c                 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 465be4e62a17..c85faaa1635f 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -397,6 +397,7 @@ is enabled for all the sampling events. The sampled branch type is the same for
 The various filters must be specified as a comma separated list: --branch-filter any_ret,u,k
 Note that this feature may not be available on all processors.
 
+-W::
 --weight::
 Enable weightened sampling. An additional weight is recorded per sample and can be
 displayed with the weight and local_weight sort keys.  This currently works for TSX
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index fbbed434014f..d39b0c12e1f6 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2966,6 +2966,7 @@ static int perf_c2c__record(int argc, const char **argv)
 		 */
 		if (e->tag) {
 			e->record = true;
+			rec_argv[i++] = "-W";
 		} else {
 			e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
 			e->record = true;
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 9e435fd23503..f7dd8216de72 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -122,6 +122,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	    (mem->operation & MEM_OPERATION_LOAD) &&
 	    (mem->operation & MEM_OPERATION_STORE)) {
 		e->record = true;
+		rec_argv[i++] = "-W";
 	} else {
 		if (mem->operation & MEM_OPERATION_LOAD) {
 			e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
-- 
2.31.1

