Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C4153D58F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350551AbiFDEq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350499AbiFDEq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:46:58 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A3D119;
        Fri,  3 Jun 2022 21:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtpwUVeBRLs+YHcIclQ/78fb4T/7JGvBKRboA4yRaUlV538vURgYsCsEooFrFdCAk6GRGBbGK0kniqDAw7WnP68P5GLfSsN6ZYDtCR+bfwXHoyHA/dhxFszIEWicBh0cnCGl7eojC+Sx+UK6YrjnKL3ZK/mQP6DnyrRbWacVosr111sniCZI+tGhMOl+S1pa7ThyqL6+WXA3OxWDTe5V6Zcy92shgDOGwl05fY25tdABxer82ImvLdbCDQ5IrYIJ3SANKbvvunzproPylZs2YrutqsVb5rbE6rBRTYtZwMMYx8+OHio8YoDSuEtrtqAr+ETQRUH03nHJ3MeIfTcgDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fr0iiCVmUq495iO5pCc3+TXgRDcpM7cEuex7fBd3u9A=;
 b=cSbSIy86MnG58gwI+ocTTCW1LGwHyuipQBbgEe2mkDDt+NIG6kNTAwc2kEH4SA77qsEVJ3CNIFtrHKhLxra/eeETyL4+efkvT+CUM+2Q+ZNfr3lPdsqnNyTzmh6pCc7XdhNG5IZfbTyN8wBbHnm04wShRp5Me+Xd6DgGmhuEeRu4+jJ8csHSQmTapDqxW7JqU5yGfUVCT6vZGe1T5Pz8OnNQXVVyBtHwcBW2UhmRz3tlekSkNGTVC3mN+gstQ9BpIw6/4w1nQeohD1KwmIDIzvDR8eKHoEmC1uqVsPRzqt61sJOF0jPYIImiq7KK2nfaCOYxRUEpOPFdg4OgENXcOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fr0iiCVmUq495iO5pCc3+TXgRDcpM7cEuex7fBd3u9A=;
 b=shbZpKcNtgldM7CrrI1xs6/Ilbf0ld4xWdWKMSJCSh6kSvtS42gwPiB9w78ec5npxJ5oaUsSS2WD1Sb2oFXvXxESRYVHdwPu7ybaEDaEh/TCe6k5ej3ZcCqFNErAnOFfZzc8LsBM2s4K72kFvOSq62QR2hne7+AaxJFHHxeoyZU=
Received: from BN9PR03CA0367.namprd03.prod.outlook.com (2603:10b6:408:f7::12)
 by MWHPR12MB1598.namprd12.prod.outlook.com (2603:10b6:301:4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Sat, 4 Jun
 2022 04:46:48 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::21) by BN9PR03CA0367.outlook.office365.com
 (2603:10b6:408:f7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Sat, 4 Jun 2022 04:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Sat, 4 Jun 2022 04:46:48 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 23:46:37 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <kan.liang@linux.intel.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <irogers@google.com>,
        <peterz@infradead.org>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <james.clark@arm.com>, <leo.yan@linaro.org>, <ak@linux.intel.com>,
        <eranian@google.com>, <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v6 2/8] perf tool: Parse pmu caps sysfs only once
Date:   Sat, 4 Jun 2022 10:15:13 +0530
Message-ID: <20220604044519.594-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604044519.594-1-ravi.bangoria@amd.com>
References: <20220604044519.594-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38de83e7-e07d-470a-cb12-08da45e53bf6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1598:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1598D64A0EF5DB048D4D309FE0A09@MWHPR12MB1598.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DhYpPpy/VwQ6yVlFBjVKgpCNQo1Y8Ri4rPQLUbqnaEePy+rYYN4vVxFLs2I29SaPTBR/oEq69nL5ioEHTaFUGFjUZbtEOIjTcsbGKSncKoBkakmUn8rXwIkZq8nibb1HbrpqTyf4DkqsyDUktKR3avXwFmrGG1bngUno+H8h/p6wYbR6uI4aqHvW2FrEdHZbWoHaiRUeH/wFvGOe3J7qe+kBeheEMeRkNNi82ehk713rm0D33KkcPM8AUNvrRkFSYooAQr31qlL/WFdAxClR5QYe5UHxcI9ovROonv5z7ILS7fSMQuLcvWRGwt3IE4JZMGshZQ6LKWBUtnbdKJH8QEo6UeMZNGdnnZeF8GsCjaiviko/8tWTU6qig3e6IOqzJBosz0hS3XTNp/MerDIZUgjhwE964KvWt7hsvT69xBUiHfdSsrFLTKsZEEWgPYlPiQ0Q2rSdCcbTBUqJMUEA3NoSV4m6mwqRkztIvi94COH8xHi4up3jzOfTWGFi44ZNlQkFhzJ4FcHvszawzckk3WjO6xUcPDQHr7mXU1ppL1SXSOraubc2bwoGc0N6mKKpMDKqz36hMweXK4iJocXjFH2+OvryEQ9SNO45ixYl3LWI07Q2BmUwm0pCP7DKfiW4Q1EuPqIJ/KaKZ3G74rkrGLYV1Ibo8AKxPrvMTZrctFUw+Dp8Dc6Xd/tYIjSeQjMXBLXIA2L4qPQxzK574wIvZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6916009)(86362001)(54906003)(36756003)(316002)(7696005)(1076003)(186003)(6666004)(336012)(426003)(47076005)(2616005)(16526019)(2906002)(82310400005)(83380400001)(7416002)(356005)(5660300002)(4326008)(70206006)(70586007)(8676002)(44832011)(508600001)(40460700003)(81166007)(26005)(8936002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2022 04:46:48.1578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38de83e7-e07d-470a-cb12-08da45e53bf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1598
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to returning nr_caps, cache it locally in struct perf_pmu.
Similarly, cache status of whether caps sysfs has already been parsed
or not. These will help to avoid parsing sysfs every time the function
gets called.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/pmu.c | 15 +++++++++++----
 tools/perf/util/pmu.h |  2 ++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 9a1c7e63e663..0112e1c36418 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1890,7 +1890,11 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 	const char *sysfs = sysfs__mountpoint();
 	DIR *caps_dir;
 	struct dirent *evt_ent;
-	int nr_caps = 0;
+
+	if (pmu->caps_initialized)
+		return pmu->nr_caps;
+
+	pmu->nr_caps = 0;
 
 	if (!sysfs)
 		return -1;
@@ -1898,8 +1902,10 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 	snprintf(caps_path, PATH_MAX,
 		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/caps", sysfs, pmu->name);
 
-	if (stat(caps_path, &st) < 0)
+	if (stat(caps_path, &st) < 0) {
+		pmu->caps_initialized = true;
 		return 0;	/* no error if caps does not exist */
+	}
 
 	caps_dir = opendir(caps_path);
 	if (!caps_dir)
@@ -1926,13 +1932,14 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 			continue;
 		}
 
-		nr_caps++;
+		pmu->nr_caps++;
 		fclose(file);
 	}
 
 	closedir(caps_dir);
 
-	return nr_caps;
+	pmu->caps_initialized = true;
+	return pmu->nr_caps;
 }
 
 void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 541889fa9f9c..4b45fd8da5a3 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -46,6 +46,8 @@ struct perf_pmu {
 	struct perf_cpu_map *cpus;
 	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
 	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
+	bool caps_initialized;
+	u32 nr_caps;
 	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
 	struct list_head list;    /* ELEM */
 	struct list_head hybrid_list;
-- 
2.31.1

