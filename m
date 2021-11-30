Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83ED74634A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbhK3Mmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:42:44 -0500
Received: from mail-bn8nam12on2047.outbound.protection.outlook.com ([40.107.237.47]:64939
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241809AbhK3Mly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:41:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4/B8ZuEtUhsYAIoJL3pmooY4zRWDcV2zWzn5GlNx1JPYEjL1w2bEYDZZ+al6moGAv/2b97ZAzH7Zyx5SD7N3VqvxRPrQ7rQw0PrKC5Zio0rBIi+eoCmVX4EVN6vk+htnRdiTcPPzIyy73VghmVbahjT2Xc2QngShJRksXWSnOOPgdqcV490zvC4x35sIsDg8hGPAaozVuh8wTsbnlkkyVu9fa/IBxSUjd70AdoTTPmlE23NqVqSFEM0KZ4lsWQoMSRWGD81f/W9GcuE4IVbI4dGbNHwCyxLvTmhMLWMFf6x38MzcMxN38rxxsIq4UbQI2ZcOdm7I3B0pOl8qm/q6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLuKm7guG/EjmNklr9YbZSw1vi5jb5wNC3n2jSyi8CM=;
 b=Ui/5UOcUxOaqods2HBNuoecfkV0lGGoN316mm8Sg1ONhNwPRImKMIui+2usOi796RZ2BHE8fFssxndZxzC5IADzTF6P92Yjv9ZswfWP9nA2m69WqOANzyMEZJwp3RQ51gtG4cYW2sEjvSOfkMMHpIO08fU4FSM+ZPGQi649Tu65VfpELNgVwyLameOBNv/QrcNQIdBFYKCgC3/8zMw3IxiDx+pGszaIe7v8tCUgc8AezJs4Gh2KOAkSeOYux0LrVdfIy3PULoBLgse7QC1xODiErXgPEfBy2rgC3Zk6+xrRvdhcuH2134vzxRPQBhaSLsnCrL8uHTDUhWz/Xhs9E3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLuKm7guG/EjmNklr9YbZSw1vi5jb5wNC3n2jSyi8CM=;
 b=a0vh3ygtviAYazXRiplJNDdgTm9AbNZBi0TSt/GIfBrKkdL7OxeyxWoUxm/43q6wnuBIrq5+hLOoYBfdw6qjLRdLUf6uh7oFH36H0rkkpADuaGONIT1ny+OIKGyiyRXNbJLsdQU9J461u8L33paWkhE+vy/yGlm+I28IQg5XHw0=
Received: from BN9P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::33)
 by DM6PR12MB5533.namprd12.prod.outlook.com (2603:10b6:5:1bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 12:38:32 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::86) by BN9P223CA0028.outlook.office365.com
 (2603:10b6:408:10b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 12:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:38:32 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:38:27 -0600
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
Subject: [PATCH v5 20/22] cpupower: move print_speed function into misc helper
Date:   Tue, 30 Nov 2021 20:36:39 +0800
Message-ID: <20211130123641.1449041-21-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 527f336d-a2b9-4cd2-5617-08d9b3fe51c6
X-MS-TrafficTypeDiagnostic: DM6PR12MB5533:
X-Microsoft-Antispam-PRVS: <DM6PR12MB5533090124AF4F1DBB8B67B0EC679@DM6PR12MB5533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXk6W9X6R8sgMg93Fwm2tMUye4W7Cdb5zAWlLEKM3MD+HR/iO30Xf7AwHPu/xweOzV0MxLFVearxSOudnG86XAhHqCuidyGxrUny9s3WbwvxzCCuYMHLQis3k4bCSWoWepBQiYSiuGDJK6RtAnApGAJg3U0KYNo1LVnRz0c7r36K0qmAJPyg+rTQnz6rZjLJHjUIOkAzbuEKB4w1Qnb71Y1JtHcAQmV2WXhvI20MLmfYrqsaKfk+5nkaN2R2uNOVm2eGy1KZKkjgjWQs9DxsOF7IAudrjXHabSHh8euWlMNEGVqGu+2d/5YdxrqO+KlRb8K8P969fyQBZVTlaaIY6CfmGq/1lTiskjFexBNuEdu9bGFdakrpPEe4D0pksgFDr/0DqyiNVnUGD8xXsJ0Z6XU2kJGG+CJlFsnV8DzA1bAP+mrYVRPURuIUe+kS5fhDIciDOY05KYAxT+LuoIZ/S/3e56iolHAFDQTc/SAAPw6gmDJJ/ey8EiIAhxaT7+nzfogtVw+QELe+CKfOWW7q8QJXMPx3JrmgIkB5YPcObYKlwPUVzJOOO836AppLMDPhgNGag9rDcFadwOWhQih6Vu9+bzHselO3AA0UX90rmtFKMwBePGpS3IYoufWvnUBq2oY/YhIBZIMl9kopxPFZh/db8x+kcDALvLyamgWVJSIim7iuZSuZcigpy3K/3yAxslVl222HSJ9KdeG5rgcFl3vXabc6wbA6yFWAVNqxDyHJKddwHwANK9wXGAeZseKR8tMAOeFktm7k3DqDsyNI+YDwknu4zKfc5uIhMWipjUs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(36860700001)(47076005)(6666004)(36756003)(426003)(336012)(8676002)(186003)(26005)(2616005)(7416002)(7696005)(1076003)(16526019)(356005)(82310400004)(5660300002)(508600001)(4326008)(70206006)(83380400001)(2906002)(70586007)(8936002)(86362001)(316002)(81166007)(54906003)(110136005)(40460700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:38:32.4233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 527f336d-a2b9-4cd2-5617-08d9b3fe51c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5533
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The print_speed can be as a common function, and expose it into misc
helper header. Then it can be used on other helper files as well.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/cpufreq-info.c    | 59 ++++----------------
 tools/power/cpupower/utils/helpers/helpers.h |  1 +
 tools/power/cpupower/utils/helpers/misc.c    | 42 ++++++++++++++
 3 files changed, 54 insertions(+), 48 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index f9895e31ff5a..b429454bf3ae 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -84,43 +84,6 @@ static void proc_cpufreq_output(void)
 }
 
 static int no_rounding;
-static void print_speed(unsigned long speed)
-{
-	unsigned long tmp;
-
-	if (no_rounding) {
-		if (speed > 1000000)
-			printf("%u.%06u GHz", ((unsigned int) speed/1000000),
-				((unsigned int) speed%1000000));
-		else if (speed > 1000)
-			printf("%u.%03u MHz", ((unsigned int) speed/1000),
-				(unsigned int) (speed%1000));
-		else
-			printf("%lu kHz", speed);
-	} else {
-		if (speed > 1000000) {
-			tmp = speed%10000;
-			if (tmp >= 5000)
-				speed += 10000;
-			printf("%u.%02u GHz", ((unsigned int) speed/1000000),
-				((unsigned int) (speed%1000000)/10000));
-		} else if (speed > 100000) {
-			tmp = speed%1000;
-			if (tmp >= 500)
-				speed += 1000;
-			printf("%u MHz", ((unsigned int) speed/1000));
-		} else if (speed > 1000) {
-			tmp = speed%100;
-			if (tmp >= 50)
-				speed += 100;
-			printf("%u.%01u MHz", ((unsigned int) speed/1000),
-				((unsigned int) (speed%1000)/100));
-		}
-	}
-
-	return;
-}
-
 static void print_duration(unsigned long duration)
 {
 	unsigned long tmp;
@@ -254,11 +217,11 @@ static int get_boost_mode(unsigned int cpu)
 	if (freqs) {
 		printf(_("  boost frequency steps: "));
 		while (freqs->next) {
-			print_speed(freqs->frequency);
+			print_speed(freqs->frequency, no_rounding);
 			printf(", ");
 			freqs = freqs->next;
 		}
-		print_speed(freqs->frequency);
+		print_speed(freqs->frequency, no_rounding);
 		printf("\n");
 		cpufreq_put_available_frequencies(freqs);
 	}
@@ -277,7 +240,7 @@ static int get_freq_kernel(unsigned int cpu, unsigned int human)
 		return -EINVAL;
 	}
 	if (human) {
-		print_speed(freq);
+		print_speed(freq, no_rounding);
 	} else
 		printf("%lu", freq);
 	printf(_(" (asserted by call to kernel)\n"));
@@ -296,7 +259,7 @@ static int get_freq_hardware(unsigned int cpu, unsigned int human)
 		return -EINVAL;
 	}
 	if (human) {
-		print_speed(freq);
+		print_speed(freq, no_rounding);
 	} else
 		printf("%lu", freq);
 	printf(_(" (asserted by call to hardware)\n"));
@@ -316,9 +279,9 @@ static int get_hardware_limits(unsigned int cpu, unsigned int human)
 
 	if (human) {
 		printf(_("  hardware limits: "));
-		print_speed(min);
+		print_speed(min, no_rounding);
 		printf(" - ");
-		print_speed(max);
+		print_speed(max, no_rounding);
 		printf("\n");
 	} else {
 		printf("%lu %lu\n", min, max);
@@ -350,9 +313,9 @@ static int get_policy(unsigned int cpu)
 		return -EINVAL;
 	}
 	printf(_("  current policy: frequency should be within "));
-	print_speed(policy->min);
+	print_speed(policy->min, no_rounding);
 	printf(_(" and "));
-	print_speed(policy->max);
+	print_speed(policy->max, no_rounding);
 
 	printf(".\n                  ");
 	printf(_("The governor \"%s\" may decide which speed to use\n"
@@ -436,7 +399,7 @@ static int get_freq_stats(unsigned int cpu, unsigned int human)
 	struct cpufreq_stats *stats = cpufreq_get_stats(cpu, &total_time);
 	while (stats) {
 		if (human) {
-			print_speed(stats->frequency);
+			print_speed(stats->frequency, no_rounding);
 			printf(":%.2f%%",
 				(100.0 * stats->time_in_state) / total_time);
 		} else
@@ -486,11 +449,11 @@ static void debug_output_one(unsigned int cpu)
 	if (freqs) {
 		printf(_("  available frequency steps:  "));
 		while (freqs->next) {
-			print_speed(freqs->frequency);
+			print_speed(freqs->frequency, no_rounding);
 			printf(", ");
 			freqs = freqs->next;
 		}
-		print_speed(freqs->frequency);
+		print_speed(freqs->frequency, no_rounding);
 		printf("\n");
 		cpufreq_put_available_frequencies(freqs);
 	}
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index c03925bea655..fbbfa6047c83 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -200,5 +200,6 @@ extern struct bitmask *offline_cpus;
 void get_cpustate(void);
 void print_online_cpus(void);
 void print_offline_cpus(void);
+void print_speed(unsigned long speed, int no_rounding);
 
 #endif /* __CPUPOWERUTILS_HELPERS__ */
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index e0d3145434d3..d693c96cd09c 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -164,3 +164,45 @@ void print_offline_cpus(void)
 		printf(_("cpupower set operation was not performed on them\n"));
 	}
 }
+
+/*
+ * print_speed
+ *
+ * Print the exact CPU frequency with appropriate unit
+ */
+void print_speed(unsigned long speed, int no_rounding)
+{
+	unsigned long tmp;
+
+	if (no_rounding) {
+		if (speed > 1000000)
+			printf("%u.%06u GHz", ((unsigned int) speed/1000000),
+				((unsigned int) speed%1000000));
+		else if (speed > 1000)
+			printf("%u.%03u MHz", ((unsigned int) speed/1000),
+				(unsigned int) (speed%1000));
+		else
+			printf("%lu kHz", speed);
+	} else {
+		if (speed > 1000000) {
+			tmp = speed%10000;
+			if (tmp >= 5000)
+				speed += 10000;
+			printf("%u.%02u GHz", ((unsigned int) speed/1000000),
+				((unsigned int) (speed%1000000)/10000));
+		} else if (speed > 100000) {
+			tmp = speed%1000;
+			if (tmp >= 500)
+				speed += 1000;
+			printf("%u MHz", ((unsigned int) speed/1000));
+		} else if (speed > 1000) {
+			tmp = speed%100;
+			if (tmp >= 50)
+				speed += 100;
+			printf("%u.%01u MHz", ((unsigned int) speed/1000),
+				((unsigned int) (speed%1000)/100));
+		}
+	}
+
+	return;
+}
-- 
2.25.1

