Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0BF4634A2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241918AbhK3Mmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:42:31 -0500
Received: from mail-dm3nam07on2050.outbound.protection.outlook.com ([40.107.95.50]:27617
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241919AbhK3Mlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:41:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmJ2Ucwe3J5NSundCL6WjuW2dE56EczhOSJVileIn783MERVd/9rrh8XZwJQd8ZsztUzfxVcuv3C/ooVIQNDwC0rUzfWB41yHvpIr9o23qxUqF/eciUKlvb3TW6uTLik+kgUDblL7gYHgQqCpjWAcDBwSixWMeSSH1laVzQJ0bimNEFl7807Cd+v7rLcv+OJbkBLPlT4HmI9p6Tme23v5NlNYjEjbmAyuRGwj8Bd8OTpI6wyogDGVNRC8fXqiRjy2t2OtGhBwy4TjRQ0qJ2Zzo2/jRy1tmOcJrOBNBIJz+/lO3HzId7e1lZlrMVext7A7zvH0iLnZ8QHHM8HSE3cZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k/zus4Ykvg9YQ8ScAPNoaxGrxYCilniKi+hCW4Rdes=;
 b=chQDhUyijsf/aE7M6vmwhLLZJD3n+b4uqvLy0ftXvnF7rrIU7PGdP4U/u9dHfA/SkhyVDq/Tc/yRZEsMheJCYap9K9EHygrdQevLngU1dDtd4qtc6qAacwbgSrwHYMeKdhpsLpdtc0zExEgjL2lP90EmwByhZY5jxYAbXTkJnPEBVAJIa1463k3VBT2hC1KFuFlT/yKRnqeiwn/Se/qI21LycZt1I9pd0+mi7Q71RsoXkYK77Y5ydXi2oJz2W1bYYmaXGiuTLTnOkr2E83zzZGcxjpaQdE0FeJFCJJU8wjZ7M2aHJKu8Hz5l/Kmm0Ql5eLugiQDCxJsgDp/ZZmKang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0k/zus4Ykvg9YQ8ScAPNoaxGrxYCilniKi+hCW4Rdes=;
 b=Tri7wOsxfExQ7cNaSkfinw/ZzMmTOD7ZgrwybEmgK9wIvV01j8npJZ0zIPcOKqLLSHCpBl0TdlHOZ6sg8YRi/ha7eEiWigyyjP4eYHvz1yWVoj+htkSgpxLBc09v5FtmJ3JCAgwDoYQDcK1GhC0jI11CkLN2j4bExTIA4MS9/dc=
Received: from BN8PR04CA0029.namprd04.prod.outlook.com (2603:10b6:408:70::42)
 by DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11; Tue, 30 Nov 2021 12:38:19 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::d0) by BN8PR04CA0029.outlook.office365.com
 (2603:10b6:408:70::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 12:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:38:19 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:38:14 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v5 17/22] cpupower: introduce acpi cppc library
Date:   Tue, 30 Nov 2021 20:36:36 +0800
Message-ID: <20211130123641.1449041-18-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211130123641.1449041-1-ray.huang@amd.com>
References: <20211130123641.1449041-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 886c1bea-e9ad-4c2b-9a1e-08d9b3fe49d1
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:
X-Microsoft-Antispam-PRVS: <DM8PR12MB541390E3F5CB292577E6D2B8EC679@DM8PR12MB5413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yg/1jQtvT5qWVvXZB8DjMn9KRJowdIrt7AObGK8W7ey4OaXrmoDGHb4kWb5UNSVFbEMCNGwiIRwUVkRUKsntXyWBeItGKhF/tWuqXXxjnVBCe5MzDFz6mzfVft8RYldyJLnXwGPztWtDOqKbMbjyMiJlLXbo2mNqnF5RoIIxW8dCPOe8poMsCjUtFilj2iOr3vcNvLKQn67+T8f7z2IH1Ny8zb0zcmAXHsfGzBeixMYO1OF5FTb6nCIG9MpnD8zaABLAV2VhxWtolSnCKPNiBrAX6N0Mbce3CJKeLigHP7tB/du2+uDYUUS05GPcKTUacxml3ZKGNukbGP+TEdnsE0T9MbUL8/lmcAhfsS7riZGHBwkBEQfQKGym55nr/gtfnmJTr9ajgIRKfQidOYXyH1B3FiUbqPPSebYPbdPupC60eA6BUyUOxhWSqR16Kkno2QRYi4fi4sYIzOXXQoV/9y/2C7uTZN5ylB81UOWZ0VBcVs9btI5jgDaf/1KP5nF+kol8CoaYyvQg/uCChmXI6jSlTFngxPbXwLxa0tN8h0xwb/s4E5ciF54+v8oFRpUTf+/vsbio9wQExpFnEpQXM5xwuy/pwz45xLTQXv3q5OgbCF+zpaHsyl2LlgpG53JiJ/0zgJCNsRu9RCh4tvYlETsBsHlfBZuXWfhdDk4+5D9U1i+aIzIj4HxZIFUYFJzSnmTOKKG+KMgoX3oyoSaf7WY94uHUtMvAxjJkl5MbVZwIAzIJDhRcvS4O1N83QPY5zVUhFarInnzOcXZOlWOcfLlZ4xAheS0NS21XRB9Ia2c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(83380400001)(356005)(426003)(2616005)(8676002)(81166007)(336012)(86362001)(36860700001)(70586007)(70206006)(6666004)(54906003)(1076003)(2906002)(7696005)(47076005)(36756003)(4326008)(82310400004)(7416002)(5660300002)(40460700001)(110136005)(16526019)(186003)(8936002)(508600001)(26005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:38:19.0734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 886c1bea-e9ad-4c2b-9a1e-08d9b3fe49d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel ACPI subsytem introduced the sysfs attributes for acpi cppc
library in below path:

/sys/devices/system/cpu/cpuX/acpi_cppc/

And these attributes will be used for amd-pstate driver to provide some
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
index 000000000000..a07a8922eca2
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
+static const char *acpi_cppc_value_files[] = {
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
+unsigned long acpi_cppc_get_data(unsigned cpu, enum acpi_cppc_value which)
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
index 000000000000..576291155224
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
+extern unsigned long acpi_cppc_get_data(unsigned cpu,
+					enum acpi_cppc_value which);
+
+#endif /* _ACPI_CPPC_H */
-- 
2.25.1

