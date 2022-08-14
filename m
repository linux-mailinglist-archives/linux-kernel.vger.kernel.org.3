Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6508859259E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242117AbiHNQxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241337AbiHNQwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:52:54 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817D21F2F0;
        Sun, 14 Aug 2022 09:40:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/WX1dBlx0coQ36sMgicXMCqPK0dxmvOqyHxdD6hBktmddecdOMr7LEnykebz8yjXXzKIxI13rKj9oWFv5BrY7C0IUnaDLJeyyBn0aNY+7j0Sb7XLntD/FyG5slSXWt9F5Gpr02WoJD7D17/8lFzvqV+xNWND4YfIjA97QJsrPWsnQvZBpYJ2yHU2C/OFmE1ih5qzr6N8TkFWG0nXHmS0EUS2lKhRCISyNNSw2F6XA7qP1PFr++Kormd2tjausb8oHNTJFwIECer/hwj7I9abZfMsn6ZE/ijTD0r7MIoJQ8lsmEQ+f1tonI8dcJFuf6qT6oBgmFMTw/y9aj3D9ySrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ff3ndFWIZBqDVEj8f4uYGUSDA/HodWJS6C9fUnChvhg=;
 b=mC3NU7FftRte1jBtoeaNHGk0ebY8qup0I8I8O6NalWKgatGsiSrXG1hOsDqPKztvqmeiTBuw4g5/LJn2ck/a9dyfFZWaZefA0J0eoxo14RcxjaPM/uDyGR3rWVh5sd/ygkhjj5P6i6hq6wnoKFBDocrLHRoL5O90BVwhg12q2NTpKPPRhNJNpOdD4R5dzSCPu86EaUHgzsSH818+4zxq7Vu0/XYaRHl31JM2KYtSCaJldvMJfC1/sFl+YaNlkXoYoPcGVK3Aft3bulhWvlo+nh9veN7Je8DUwp9G+/eR7kYtnA7Kuhpel/TPgyBRZdV4B9KhitaCvNnsNGi+Jj5FYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ff3ndFWIZBqDVEj8f4uYGUSDA/HodWJS6C9fUnChvhg=;
 b=F0mYJuGgitz5dlV/TREoPpzrB08FcfkGsuVllyo78qpSlvZKzB77JnxrBz4G9eg0QUDM2jSdEC3XKggnKXbXunhnPSeU7nzjBS7BCErrKHevcDpyfYDHjUBGuZmmhr0Zp6TvCeTMfFcQQdtNh4w70d6XRGzOi+vbEBh8qO/4p8E=
Received: from BN0PR02CA0047.namprd02.prod.outlook.com (2603:10b6:408:e5::22)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Sun, 14 Aug
 2022 16:40:11 +0000
Received: from BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::4b) by BN0PR02CA0047.outlook.office365.com
 (2603:10b6:408:e5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.16 via Frontend
 Transport; Sun, 14 Aug 2022 16:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT093.mail.protection.outlook.com (10.13.177.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Sun, 14 Aug 2022 16:40:11 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 14 Aug
 2022 11:39:20 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v5 7/7] cpufreq: amd-pstate: add ACPI disabled check in acpi_cpc_valid()
Date:   Mon, 15 Aug 2022 00:35:48 +0800
Message-ID: <20220814163548.326686-8-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220814163548.326686-1-Perry.Yuan@amd.com>
References: <20220814163548.326686-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26ac1cdd-478d-4108-df36-08da7e13a7ce
X-MS-TrafficTypeDiagnostic: MN0PR12MB6271:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 54UuinXxIs2rwkKeC1c77NUVJgU2DaE9orDknMJDNwVIUa7Jpdx+zcIpQe8IfL2kbug8m2Htwj7qtmxwpp/BuqVMbwSc7mw7UbeZYpBEVIU4J1QFqi7gyVP1pUmFSvDCjRziNhQInh3P+QeVBEhEfUAohxSY3Nwxdip+jStjSSrQqsnUl6rpmLD3vR5wXfvLq27qODLCD0WQ1aWk53q8+2pj5WDLFM39f0+duB+kWqRuTZ3SnIsnlJMcoo6Ro7j66HN/gjkXz6NcyNrWuQW3jE6g13go9Hd5hEb+jwjo7zhfFa5Mt2LoxBWrrAQIObwLUHJu+X5aSD9VIL0fm/LScgADWssAODg/nbKIpebjtCdBlkXVh1JMJ9zxzD0BHf4JVRRWCgqTWx2pSHlGxNDMwBD2WqOC0JjM7XJBQ7KnBzVm+vyh/rR9ijCaPb8LqkLk+0Q29fvWw/JebthswAxKamS9/A0vjv6zfiOJkbk84NRpl4oZNLudb68f7rYoa3uPL2k/yBQdEU1hdE/7fi4EuC1hMJIZhsahA+IUuSAgmBPVAqjqblHnxKE1/ftfmTf7uyNoOGqBffpNBAi95LEEhqBBYwd+3S9ABF53GZVlDYq7+JCvUK6gEe+K0+Ja+rgnxqHRfie3mXH5tLerhWE6J1Yo8ML7tk/BhLSwOsbuYyObZ5QTS793tPK+OWgMvWRQ3bCoZp1hhdPye94OHN9sIm+tcBzHaMZnXi9XeYIT/4NgB04eEeYz2RW+JD/dCJXkLFCsSn/cnbfsG0/GPEsNb6zrejEmOMEZS+VOlh005b7RNgEGLI+QWRcrTH2jIoy/I/T50QTD/JO+mfBa6Ri9h/6UlEkSonYKoydtuiS1QLI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(396003)(40470700004)(46966006)(36840700001)(7696005)(83380400001)(70586007)(41300700001)(186003)(8676002)(6666004)(4326008)(40480700001)(70206006)(16526019)(1076003)(2616005)(54906003)(110136005)(426003)(82740400003)(47076005)(26005)(336012)(2906002)(316002)(86362001)(5660300002)(36756003)(82310400005)(8936002)(81166007)(356005)(40460700003)(478600001)(36860700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 16:40:11.0552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ac1cdd-478d-4108-df36-08da7e13a7ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add acpi function check in case ACPI is not enabled, that will cause
pstate driver failed to call cppc acpi to change perf or update epp
value for shared memory solution processors.

When CPPC or ACPI is invalid, warning log will be needed to tell
user that AMD pstate driver failed to load and what is wrong.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/acpi/cppc_acpi.c       | 3 +++
 drivers/base/arch_topology.c   | 2 +-
 drivers/cpufreq/amd-pstate.c   | 2 +-
 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1e15a9f25ae9..c2309429146f 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -424,6 +424,9 @@ bool acpi_cpc_valid(void)
 	struct cpc_desc *cpc_ptr;
 	int cpu;
 
+	if (acpi_disabled)
+		return false;
+
 	for_each_present_cpu(cpu) {
 		cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
 		if (!cpc_ptr)
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 579c851a2bd7..73a8cb31529d 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -352,7 +352,7 @@ void topology_init_cpu_capacity_cppc(void)
 	struct cppc_perf_caps perf_caps;
 	int cpu;
 
-	if (likely(acpi_disabled || !acpi_cpc_valid()))
+	if (likely(!acpi_cpc_valid()))
 		return;
 
 	raw_capacity = kcalloc(num_possible_cpus(), sizeof(*raw_capacity),
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9cb051d61422..96e4ecddf3f6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -661,7 +661,7 @@ static int __init amd_pstate_init(void)
 		return -ENODEV;
 
 	if (!acpi_cpc_valid()) {
-		pr_debug("the _CPC object is not present in SBIOS\n");
+		pr_warn_once("the _CPC object is not present in SBIOS or ACPI disabled\n");
 		return -ENODEV;
 	}
 
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 24eaf0ec344d..9adb7612993e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -947,7 +947,7 @@ static int __init cppc_cpufreq_init(void)
 {
 	int ret;
 
-	if ((acpi_disabled) || !acpi_cpc_valid())
+	if (!acpi_cpc_valid())
 		return -ENODEV;
 
 	cppc_check_hisi_workaround();
-- 
2.34.1

