Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0BB533A31
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240985AbiEYJpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241590AbiEYJol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:44:41 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA07990CC8;
        Wed, 25 May 2022 02:44:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSEZDLZYQA2vPFiFaoOcUcgvyudU241WydqCrMsF623abRyElrw2S/I5O4AWacFVZewLRwU7Tazh4S5uKf3GtpnkN8+tWL5Z0Kb9NcrT80sLW1oNRf4YZpp6r/fUzYmn3BOjX79cHYsCPyqRFF0Kxb43vN3NOckuLCtrbsd6qKd4WMvVHTLO8bPOfNGEuhbsFcIvXNTLOtdl6C3/MrULXLWxuUN5O+AmXvWaID1+cbD4n0UrPVDJEyWPjLrT5ioVH9VLOaSh8AGQUO+2aSBqgJjclQdK9B17FM7xBQn95J71RinZYNoPVnxbdvDkoPjs9153/Z1Yj2Q4DHWZXpIIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJVvGBv9OgF3SluIg+Dyr53H8Xhx67A4orAgfeI99q8=;
 b=dDUtlJUOn6r+TtnxBbQ7advycPWaLdzNbMBcrr4R7BUONxHT4lMr8N2yFgw02aLWjTFGfvO6K8LTTUAY3Syikdf1k6wJAo/LDmqzSQtjPu1xRBb2SKcKQnlzPy+HYh34ljWfp8qbg1NFFPVzwZUeVywIs5lv25teh+YZXBYEbCXF/cB9f5DvHvkkSM2fFrIi3Dly70qxvR7BhkbGUDvYtW+d6hh/KfwE9n1bWv8wzt8Ic+TB2WityQF15davwGJfBXyMb13HIx41czhHwhtrO+yzhOHe99Fyrx5KzCISxBYUSPf5I5wIfrKA0jDeuTDsUTddgyMNsaMjsxTv7n7r/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJVvGBv9OgF3SluIg+Dyr53H8Xhx67A4orAgfeI99q8=;
 b=oBfFjT96qhFzfOQ+/m9tcb/yUiTKkhTCZU+Bd1zaqmdQLbunuRVpnInMBmWMwUtTlQpul2RxgvPNTvR3DnDcdIT+r9/s6mwQljrEP0dz7DW19qnzxwwJ0lGTg+3MdKKtwY9exReQfeAWCCzZ7nyKDH6zE4QW/UN74VtcGZ/0Tj0=
Received: from MWHPR14CA0022.namprd14.prod.outlook.com (2603:10b6:300:ae::32)
 by DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Wed, 25 May
 2022 09:44:30 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::b6) by MWHPR14CA0022.outlook.office365.com
 (2603:10b6:300:ae::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 09:44:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 09:44:29 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 04:44:12 -0500
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
Subject: [PATCH 12/13] perf mem/c2c: Avoid printing empty lines for unsupported events
Date:   Wed, 25 May 2022 15:09:37 +0530
Message-ID: <20220525093938.4101-13-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4313e6b9-4f77-42ad-8345-08da3e332a10
X-MS-TrafficTypeDiagnostic: DM8PR12MB5429:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB5429C61C1F2B5F2E49AC666EE0D69@DM8PR12MB5429.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAPR+Hba1oFRoLNC1QJB4TeF3MMmpX8vEKWzB+t7WUTs04gm/EXwaLU2Udacwnt73ZNR0ecpeNBEpPZMOx/pWoNcZOhOqzJwxoo4AqdmF+iPtqA3zPac55FdIBgms/CpZKW4YeXDDRm9nmh7fDOtzA5tDLh4UC63/MU9oJNgNlVS6aoye4SN10OlAIGn084K2GqelxRsO/X3H/6z6AazVHz8TixuijGC1T/q2Br5xeLCJsdyG3Zy9GJLCPOg1bzb+HLu1Ep5E99GfHcNse+SxELruOTdzappOx8oqc0Xtb8H1ltYqTKvqcZQOVodF9IW+NTmW2MAj+OB7RWrPkm1Jamiamn+ks4JFLlRgt5Gb3O1gyfshcYHjDrz4CBJjXAJbHECEY+UvoIBIsMUoVqCf0uwScCa9pVCrZdAVYDGzYUi0fHoxmMVnwt/ysGE/Mbxcw/FLoSKy383DgQdRatv+GwE8Fy9EgJAxVoxLKuTINd5pmJJh/62OHHCjMQ3H5F4YzsaRwQtz2umZKd6I8QDWr+Y2d07GzXCIz48TadxvNf5cD+8lDBKbR+/f38o4qW+l1PsbbrhaScQg+Md+ro19ksRbCGYPXz+7+Tx7fEOAsjQZjwP46k3r43qswGngf679SuFQv4kQL6lKjuphnHuG8XxsKnwUsn8so5MZC+870omQ84F2frCF1IaDMfN/NJOvb3ry4Tkfw0xWhh+zhafEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2616005)(40460700003)(70206006)(26005)(2906002)(7696005)(6666004)(86362001)(8676002)(44832011)(82310400005)(8936002)(5660300002)(7416002)(36756003)(70586007)(83380400001)(426003)(4326008)(316002)(508600001)(356005)(16526019)(81166007)(110136005)(54906003)(336012)(1076003)(36860700001)(47076005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 09:44:29.4451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4313e6b9-4f77-42ad-8345-08da3e332a10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
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
index 027cd6d62f21..415d754fea8d 100644
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

