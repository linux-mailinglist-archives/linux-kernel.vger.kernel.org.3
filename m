Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263154BFCE7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiBVPgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbiBVPfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:35:47 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2043.outbound.protection.outlook.com [40.107.95.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CACB163060;
        Tue, 22 Feb 2022 07:35:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6PbjljuA+9b7HDYiHzYMj6JkMQug5gzCcpKVHpOJty20DLQAQb1j2KJ4ZPpWBRThqDt26JXHR6Z3K8YdFDbmo/V3ELTS7tVHxxLyPCibHDD7IwskEQowv0otyU3gnARAEOwMJzcbOOtbgvuYbxpBaHmfm7zqbyraeszYNliBt8xCn90fOSIKr5orhpPX8mF/Pe0l+eMsYhOzbVmSWMg1E3ki6AsJ6hlMoHf4kafB+jn73MzFN/isuDjGseYatZFUVSgACvF5fDOsZC5/yAmn6RL2/kAXiSbvl8ergU5FRC5RKS78p3bckCJIQmi0tzLGqIH+0feAiiRlf417ENZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZe5bDP64hYKiHZrC0wX8i/vH7xVvrgomx7/1q2O71M=;
 b=AtVf9VEhVs0PvTo5hB+aRxHib21rP59tI+qs4LUbIDpZi7S7vZ+esw4/PiJLdFMb0/qGYFl8b4uTkQeXnaV70IEcCUTuvNMxI/3xj48njiE5nElHGZqnFpGffYvX877mKLF9/x4jr72FI+nBO3W84yY3m64V+KtAkLjaYWdX6zgj1LJBpudOZ+RjHCbTTu2MjpFizIy8fRTUlsM8pvhhKG9vaRxKm0hpq6PVeUbsQLo/grIFkPX+nc3kGEUKb+12H9jhTgUKs71c6DjcJBdo8Ix6gtpDW+S6NiGVe4QN+3holmCxb/ROqZSNJFE8v5a2GyvUcgevHRy+2UsvFEQQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZe5bDP64hYKiHZrC0wX8i/vH7xVvrgomx7/1q2O71M=;
 b=VdyFNxJIFjvvXXFxosPqg3DWGmVh42wyYwaD0J7szLZdRBBaEnanl7HYrgUydR0seEJGi+4xk+0z7ok0V0OTtGEVndwZ7eyOBn8IFU+x1i4IlH8gpsd+VOnnZLbKPyXyM2b0a+QTebdFW4Zr0OAtRCu6MSFenzagtYDWdZoF/E0=
Received: from DS7PR05CA0049.namprd05.prod.outlook.com (2603:10b6:8:2f::27) by
 DM5PR1201MB2505.namprd12.prod.outlook.com (2603:10b6:3:ea::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Tue, 22 Feb 2022 15:35:14 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::f) by DS7PR05CA0049.outlook.office365.com
 (2603:10b6:8:2f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.9 via Frontend
 Transport; Tue, 22 Feb 2022 15:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 15:35:14 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 09:35:09 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Jassmine Meng <li.meng@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Giovanni Gherdovich" <ggherdovich@suse.cz>,
        <linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v7 05/10] cpupower: Introduce ACPI CPPC library
Date:   Tue, 22 Feb 2022 23:34:21 +0800
Message-ID: <20220222153426.2216974-6-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222153426.2216974-1-ray.huang@amd.com>
References: <20220222153426.2216974-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19dcd77b-f2e1-42ef-310e-08d9f618ebee
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2505:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB25058F34BC64B08EB0189ECDEC3B9@DM5PR1201MB2505.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7prKZ4eZBPzQg7MZYcj22egJDHHyKiyVX7O5AgjM09uY1Jb4e03UQYoH1UAUs33/WIzxr3zQkatOL4sxbxdxnjxA660cgYfZ5F3uENfBOhg15fGzeGE5llaFl14ViHsr1h+UqMQxyS7ZJNXgUTWCxiK8JVsVUYcJPh8nGUtMZlGcHoF5/MGRHYL7qGd0y1RFc1nre4e8mgxHU0ohETMTedGfKOiQ+z/cNyg4GnP0rKxHwt/DWWuWB2XPsNOj+YaqvPCE7VhvdtDUYyx+aX0UaSUI4s7yHm+vrzZNGuAgCSpwQPM/3Z3muOpiv/4lXaXBxs1JuNjxstG2HyoDE2wNfMQgvtGY319XIoAfiA+QjPAa8C8dTSVAP9zVjuSsw8PVZl5UJUQpbnlshrfevG67KcUnVkb1WGWpMhBPWk8ula+M6d9unFWmjHumnKimkNzbA1SQ2hcpEt8a7wzoWksuj1qI4/5TnDs4DzleI7NYZygskaRoj2zi2VXyypkm0YGPqP+Sj7bshtI6gRKpPkgWbJtdLVAEtBO4Nk0z5W1aMTnR9xJvGOz8Jptl30mDXnz8hgEeIRCFPPhqw0f4RLpDDZ+gNpw9xtB/ppmPd9FPDcnfFWcNixMmttIooCRn7LWwglcBavvR5RtyCG6deMsEJTTVJx/S3sGEfAxsYJ0OHQUHuydtizcQbobVGpbBN5MsbjSTNq9SwCg8/lzh3tSurQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(336012)(316002)(7416002)(16526019)(426003)(36860700001)(1076003)(5660300002)(86362001)(54906003)(36756003)(26005)(40460700003)(83380400001)(186003)(110136005)(47076005)(82310400004)(70586007)(70206006)(8676002)(8936002)(81166007)(2906002)(508600001)(4326008)(356005)(7696005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 15:35:14.6602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19dcd77b-f2e1-42ef-310e-08d9f618ebee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2505
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel ACPI subsytem introduced the sysfs attributes for acpi cppc
library in below path:

/sys/devices/system/cpu/cpuX/acpi_cppc/

And these attributes will be used for AMD P-State driver to provide some
performance and frequency values.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/Makefile        |  6 +--
 tools/power/cpupower/lib/acpi_cppc.c | 59 ++++++++++++++++++++++++++++
 tools/power/cpupower/lib/acpi_cppc.h | 21 ++++++++++
 3 files changed, 83 insertions(+), 3 deletions(-)
 create mode 100644 tools/power/cpupower/lib/acpi_cppc.c
 create mode 100644 tools/power/cpupower/lib/acpi_cppc.h

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 3b1594447f29..e9b6de314654 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -143,9 +143,9 @@ UTIL_HEADERS = utils/helpers/helpers.h utils/idle_monitor/cpupower-monitor.h \
 	utils/helpers/bitmask.h \
 	utils/idle_monitor/idle_monitors.h utils/idle_monitor/idle_monitors.def
 
-LIB_HEADERS = 	lib/cpufreq.h lib/cpupower.h lib/cpuidle.h
-LIB_SRC = 	lib/cpufreq.c lib/cpupower.c lib/cpuidle.c
-LIB_OBJS = 	lib/cpufreq.o lib/cpupower.o lib/cpuidle.o
+LIB_HEADERS = 	lib/cpufreq.h lib/cpupower.h lib/cpuidle.h lib/acpi_cppc.h
+LIB_SRC = 	lib/cpufreq.c lib/cpupower.c lib/cpuidle.c lib/acpi_cppc.c
+LIB_OBJS = 	lib/cpufreq.o lib/cpupower.o lib/cpuidle.o lib/acpi_cppc.o
 LIB_OBJS :=	$(addprefix $(OUTPUT),$(LIB_OBJS))
 
 override CFLAGS +=	-pipe
diff --git a/tools/power/cpupower/lib/acpi_cppc.c b/tools/power/cpupower/lib/acpi_cppc.c
new file mode 100644
index 000000000000..c401ac331e9f
--- /dev/null
+++ b/tools/power/cpupower/lib/acpi_cppc.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#include "cpupower_intern.h"
+#include "acpi_cppc.h"
+
+/* ACPI CPPC sysfs access ***********************************************/
+
+static int acpi_cppc_read_file(unsigned int cpu, const char *fname,
+			       char *buf, size_t buflen)
+{
+	char path[SYSFS_PATH_MAX];
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/acpi_cppc/%s",
+		 cpu, fname);
+	return cpupower_read_sysfs(path, buf, buflen);
+}
+
+static const char * const acpi_cppc_value_files[] = {
+	[HIGHEST_PERF] = "highest_perf",
+	[LOWEST_PERF] = "lowest_perf",
+	[NOMINAL_PERF] = "nominal_perf",
+	[LOWEST_NONLINEAR_PERF] = "lowest_nonlinear_perf",
+	[LOWEST_FREQ] = "lowest_freq",
+	[NOMINAL_FREQ] = "nominal_freq",
+	[REFERENCE_PERF] = "reference_perf",
+	[WRAPAROUND_TIME] = "wraparound_time"
+};
+
+unsigned long acpi_cppc_get_data(unsigned int cpu, enum acpi_cppc_value which)
+{
+	unsigned long long value;
+	unsigned int len;
+	char linebuf[MAX_LINE_LEN];
+	char *endp;
+
+	if (which >= MAX_CPPC_VALUE_FILES)
+		return 0;
+
+	len = acpi_cppc_read_file(cpu, acpi_cppc_value_files[which],
+				  linebuf, sizeof(linebuf));
+	if (len == 0)
+		return 0;
+
+	value = strtoull(linebuf, &endp, 0);
+
+	if (endp == linebuf || errno == ERANGE)
+		return 0;
+
+	return value;
+}
diff --git a/tools/power/cpupower/lib/acpi_cppc.h b/tools/power/cpupower/lib/acpi_cppc.h
new file mode 100644
index 000000000000..85ca83080316
--- /dev/null
+++ b/tools/power/cpupower/lib/acpi_cppc.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ACPI_CPPC_H__
+#define __ACPI_CPPC_H__
+
+enum acpi_cppc_value {
+	HIGHEST_PERF,
+	LOWEST_PERF,
+	NOMINAL_PERF,
+	LOWEST_NONLINEAR_PERF,
+	LOWEST_FREQ,
+	NOMINAL_FREQ,
+	REFERENCE_PERF,
+	WRAPAROUND_TIME,
+	MAX_CPPC_VALUE_FILES
+};
+
+unsigned long acpi_cppc_get_data(unsigned int cpu,
+				 enum acpi_cppc_value which);
+
+#endif /* _ACPI_CPPC_H */
-- 
2.25.1

