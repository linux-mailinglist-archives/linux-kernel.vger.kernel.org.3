Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7921C4B81B9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiBPHiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:38:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiBPHhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:37:50 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2046.outbound.protection.outlook.com [40.107.100.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1478172276;
        Tue, 15 Feb 2022 23:37:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIj8kaNTWnB3leKZX1JzlpMY/cidDVTJw/hoOF/Th8ikSqY52vnFvUKF8Tc4NPTqsjExoZr0ZVXoaykHZ/cpJLsUUxszUEYh9VOA3aMUhFUcIV4wm2V45zoUcFPKMWIUWEY1VSSm9VW5/VbKzINa5deRySpMwY7Lu6eRHpnPqpNRh2k4cEn9RR00+GATj910G6dtkZ7gk1ZPaHOSnPDNHbSyH0bHQ1rmFny4yshTCWwKBbCnlxkg6Voia0GtIscoEaMTMaXZYMyw1l80lcg8Jd+8jy6rkSkcQNQLAdUfR2Pkpnlq5jl1iqCKha22ebl2lzjeAa6+Sly8HM37ktxmzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5iwzIdMOvVnHP6ggSINV8XsIMjw01pyhmcrOPIF31U=;
 b=jM46Md3FLlQxbxor6c2H2Z+JeoOOVjN7z7snYyPuT74HSC4IrO+RIY9yS928DwROkGT0W7B1QBK74anfrJy1tjIt5mzNSJx6wlUUfH7uoqwZs7ufNZiywVQ3MCfsKuZJZwSHrlHmylbb8JbkkOZLWLCIOeEewn9I83ilJ3jVvurQHufsfB9KVWpDU4Z14NAR35JIG3h0+1GaGQJTlGCvCJLzExWX8v33h/1Xkr7msAi5i0o3aT5NV1N6E11nlNa0bOxZUuuLodVMcyQtm3m54isurhnIYsHuTU9BwZesRPU+s88Mj6FaBpoCz21bVKM++t4WNLZ8kFtJhsjvtSpktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5iwzIdMOvVnHP6ggSINV8XsIMjw01pyhmcrOPIF31U=;
 b=3/AqpLZQTsYBqKb1IKhlewY6Ma+Kwv2biqyqomeIeUkQ0ssqMWOqwVeQHUFQW/XDxIrozdhbUQZuW664b88tsB99AE6hkxh1EV/87sq9Ieaiatp1eMVdzB8nmTDRID924iAi8faMX8xxnngOxzHa9MiY3xsnwS3bSHY2dGZKVB8=
Received: from BN9PR03CA0467.namprd03.prod.outlook.com (2603:10b6:408:139::22)
 by BN8PR12MB2850.namprd12.prod.outlook.com (2603:10b6:408:95::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 07:36:56 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::2e) by BN9PR03CA0467.outlook.office365.com
 (2603:10b6:408:139::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Wed, 16 Feb 2022 07:36:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 07:36:55 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 01:36:48 -0600
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
Subject: [PATCH RESEND v6 5/9] cpupower: Introduce ACPI CPPC library
Date:   Wed, 16 Feb 2022 15:35:54 +0800
Message-ID: <20220216073558.751071-6-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216073558.751071-1-ray.huang@amd.com>
References: <20220216073558.751071-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3208578-8759-42f0-9b1b-08d9f11f1ba1
X-MS-TrafficTypeDiagnostic: BN8PR12MB2850:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2850D5584FC6CCE5C9930686EC359@BN8PR12MB2850.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZcJayJqx9V17suyd9sgZKeE5jxDYHFO7iTevrLqDm330DU6WdeyJp/jHKYPUuBd2QVeejWzGgwXGsE/VR63OsJN+x/qgig+rVRc4M2evb1Sw+RIgb35TwPUJDKkcOb/I9H+7q01f6upT4bwCaU6zCcjw59TO4+8Ggd50ZUsOFYowKs9BXyW0E5A1Ds3mJVUAD2/xBk2i5AkiwLR8sv+k7aQfjtKkrkv0N0hoVOLxDAv0Yscewg0hjalBx4Ts4J+FImpHgmWM6SlqxF6DLp4aO+s20Ls3+ytb45u3Tv/9iYqkIAI8hbZlKJunPKDxHnjWpABypSmBxIIj2L8RmtnZgnn4++kg0OU/LLX5LEPK6qofC/SMXsNhhB0vQuLcC0XiC8LE2wwqugXFw4XdUNxp2efeZZNKZvjycBDEgwkYA56MlIJdu9R2qtwkvKPFKkFrgpP25hMsDjIAU7nvAeQ7GuxOgaOHCox2poGf5SVOXZGkHpIQSGBFnBBFXxE+iJcANPhScQLdVC9V4j7T2dHPu3KEGJ/Ai2F7NB8GcVmLvxfgi2tde+kUG3yupiwoZJMyrBebnUb0WVhmDwLoOzRXN4CbGqC3NnNL0EVHJvXwICggDf7U0A+lxhDtnJIZM1Xi9HwOjmLnQqBH0iHjVe5fnvdZyVdICzvaNEOb7AJgJx4WIKD0S75I5RQOSQhwHU2UeA0KXZSz7YHmP/yUv5u/ZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(36756003)(6666004)(2906002)(356005)(8936002)(36860700001)(7416002)(81166007)(70206006)(70586007)(47076005)(40460700003)(8676002)(336012)(83380400001)(4326008)(82310400004)(2616005)(26005)(186003)(1076003)(426003)(16526019)(508600001)(54906003)(110136005)(316002)(86362001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 07:36:55.8866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3208578-8759-42f0-9b1b-08d9f11f1ba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2850
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

