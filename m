Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCBD539BA7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349401AbiFAD14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349406AbiFAD1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:27:48 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2066.outbound.protection.outlook.com [40.107.102.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296EB20F5D;
        Tue, 31 May 2022 20:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+AqI46LnTGhc0sRxIMTUi1uwzAXo6D1bfnHQA4S3eQiifTeqVWKtapzR4N/wt6gI8UcYrbwz+qzkYsVtLCFn1fKbu2Qpq1eiz5PBsOBT4rF5m4VER4y+5AAHmKU/pNIzA+lH4VRTy2x7XS+yi38sb3oJgjk0b2DmFBkLK101UB0dcA84al6r81mSKdLbnCS5bluVMBTgOihVa7XlHCJplI1sKn3q2cSgH66bRcEx9T/CQsw12BQ/K3HKkxQloENnVs+oTHFtP45lXUQSw6spOQAFdsnsfxDZtn+TNhE9UDKIk8mTfV4prp+QfMxOTm5qW3UyQ6aiT2n0jbWM44COg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SfqAfhu+nR9MuPJLjVOmETEtBJwbZgOuF3dLwJcUP0=;
 b=i5UE5wzRnqOkO29mVz82xz8QZPGBOSGKAp5wcl4wWStSXfhCGRRYGB7vBlDTI9VboEODTkEphSy1A2m78jmzjSy7shY4rZ7g3HmMom/RNBO1NwqDqSi1dbTxOoY/AIxDJbH8WZKSvU0f6/XEK43t7WDrUHBXc9gC9+djfZEQrKZ0UP1thdX3xAwAOg+7HAaNfVl5P3iY0oi8W8FOpBlQVlGtCWd81/6MJuC5jxyFJnaKCsUaSN1U5VEeKCqUjN4FdONgQeknFrTpmXFrAcBLZeGktLtEadXfp+PFw2U+z5/C7mz2hlWv00kDSvqOd4O4ygShQmQg3myhqS9k9T5OXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SfqAfhu+nR9MuPJLjVOmETEtBJwbZgOuF3dLwJcUP0=;
 b=HC8dE80ECU3LNdG4bkTXKoLd1LBnK/HC9u8swz1YdGmOh3JORgHEMeSfKXh9Y4WdYV2miE6ra94CQzid/lV9X76abxlZbmbhDcrlLUmSV4GIBjkxeVO49SsoHMEqrs5e0pFcPyh6aIP911bQOsafayUN1jGrgR4wjeGNFkBav+4=
Received: from MW4PR04CA0039.namprd04.prod.outlook.com (2603:10b6:303:6a::14)
 by BN9PR12MB5289.namprd12.prod.outlook.com (2603:10b6:408:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 03:27:43 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::d5) by MW4PR04CA0039.outlook.office365.com
 (2603:10b6:303:6a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Wed, 1 Jun 2022 03:27:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 03:27:43 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 22:27:32 -0500
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
Subject: [PATCH v5 2/8] perf tool: Parse pmu caps sysfs only once
Date:   Wed, 1 Jun 2022 08:56:02 +0530
Message-ID: <20220601032608.1034-3-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b6d791dc-3ca0-4208-a001-08da437eb08c
X-MS-TrafficTypeDiagnostic: BN9PR12MB5289:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB52895B67FAE29C9A43BB06E4E0DF9@BN9PR12MB5289.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lv5VTFORWbFHkUzSxJ8SXPh9m/w9fTFk5KYCD2t4uFbJVhJ7dHiU+cUJl7sb6V3r3nWZbRTiEvGyxxmIQT0r/qPf9waBwe+xAY06p3ar/VjvGqhCM8gW54XgtPuBe0/BZZmqgChHYCLI79Eh84L3HML0sgTQ5VU9XUyOiTb3bOCRjRpdGWFITzspaSZmJbKw/MTv1n152kTDwkxGkrOT8wdc54IDK7kY6PUyQkmew86SelSBo3btB4AExjm4oyR5Dny70i1hFJcSHSrCG3O8wSC2JuhbAVqodAsZrVTsatnFhXTEJbjvwzpuevdkkJt4iFXCD7FzS8pjIPGEsKk2xZ+ZU5quv6WGaYgupNBZoCo3DZNdr2v7UJ9lLaIl0f5hIuBjwzJ1zbetiOFBB97/SeW6PuEzxf+cRY/CbSAeAU5py/OcqrYt3RrKQdzvPx9TqaTPpWYS1PYdqICmRP+ixDAX8bVzjMh8IYAqz7UoIgGsTISvENNKkMHpXk81uyuPjIQlm6pqa9rvNx4y5YVCgnNhxyj+i3eFSUUyiyNlvg6eJZ72M+QR6BPEHTSmuOIioNtoqAtOnBUxSNY1HZXAvjULZfJrIMwjiNBqW5Q3V21eMQJu7sMHlFCP0ZGSmb+Rh1IFaIZ8XSI8WFuXeZSLU+cmROVtezHPFZGh1552vXc0+0Fg9ymwKCYTsu3WJ/L6Q5RerKc5J2Y91CI4DVKcqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(86362001)(8936002)(5660300002)(2906002)(44832011)(7416002)(40460700003)(4326008)(8676002)(356005)(70586007)(81166007)(70206006)(426003)(336012)(47076005)(186003)(16526019)(83380400001)(26005)(508600001)(82310400005)(1076003)(36756003)(2616005)(36860700001)(110136005)(6666004)(54906003)(7696005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 03:27:43.1418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d791dc-3ca0-4208-a001-08da437eb08c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5289
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

