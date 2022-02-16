Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235994B81C7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiBPHie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:38:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiBPHhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:37:51 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CD5187E06;
        Tue, 15 Feb 2022 23:37:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQ0JTgr93gAmo/9Ua3hDDgd4N1FJGc4Sf3RGWA68ZflPviCwSSYYvB54i+bjUXgJ6sGvpNrbCDxxz7ZsPJquy6jMYnL3yXilCHj4ZSUrvZlQzQK1Q3dbMCk/LJxszxowiM8StFJyh4N9AMOrYELvAhtIPUU3b43vklKb3CzZ6d/QNXap9SjdoBTK9128Q2ZVuY8wdLuGeQVAmQ1hUsX+dODVLOSrqcxWFThiYeCKQEj1EDbvSMSYXkQHuZB0DhbtSn70LoOvbuQMvfEcAvR2BFHeZypxm67dvzQLHXKLycXPnM0Gv934n2KUEyUeicqhJ+aaudgnZY78l43AeQDyOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvFQRM3Kvl5/VlKL8/woeNbPXhFxQXuwUSuzc8bAQKo=;
 b=JRPVrvJ0wXuqNKmaEmsX/BqRSRtDLebnYnlWlXtwysKw8Qq4c/klohLG+/NFK+ZS/arj9o8JIcsK/JcJ9TImrLfcszJpoSIIQL0kCF7UVdk848WVRs3u96CpAgHGdk/4k9ErfQIX1kZYhExl5SuV0LdWy7JyvXvFXcmEzW8ko8eJYqySApucf/oHLQRlIzyGmGc0mCGNfWlNw69uLYI4fBOCZeBq3Xs9qIDg2KCIly7HBjfZqGqCf6u6CGxjBl4QjwG8g4U+ncdPIUlp/TDIKBj07yFJ/+gW5Y2sg9wlhvH11qhndxvf5m/PWoO/Y//i9usjyRv23E0bw/uxnCukgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvFQRM3Kvl5/VlKL8/woeNbPXhFxQXuwUSuzc8bAQKo=;
 b=OXOsKSHSpqU2aZ3uIkW5ObM1QuB1l+Jl6Na3FHX5XmFKh52TKbvvKAUTqksB9xhuwTcU3dJGHxJTnkqA6pjf8d5UjlWoAka6XlMeEUKCP4NmhDraZuw1xfBZ/oxZE2d9YtkF/OkDlxSKSu+8AY+ksdPYmlks21/4883Px360tJ8=
Received: from BN9PR03CA0652.namprd03.prod.outlook.com (2603:10b6:408:13b::27)
 by CY4PR12MB1895.namprd12.prod.outlook.com (2603:10b6:903:11c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Wed, 16 Feb
 2022 07:37:09 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::34) by BN9PR03CA0652.outlook.office365.com
 (2603:10b6:408:13b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Wed, 16 Feb 2022 07:37:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 07:37:08 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 01:37:03 -0600
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
Subject: [PATCH RESEND v6 8/9] cpupower: Move print_speed function into misc helper
Date:   Wed, 16 Feb 2022 15:35:57 +0800
Message-ID: <20220216073558.751071-9-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2dd5a6d3-cc3a-4e9a-bb58-08d9f11f2339
X-MS-TrafficTypeDiagnostic: CY4PR12MB1895:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB189527155A7B7D0566BF4CF9EC359@CY4PR12MB1895.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2sjMofuZsNy65zyK3QCsZbFw5aKtYsOXgN9XeD/cvqjRPfSRD0BK9YqKRiM60Wp/gXjo6iVWRc4Uw0W4OXhB9Z3dZyyA/Ol2topJ8qpSGU91ut3ooohh3IwKd8/rWUJ8mLiYoNHc1rojZTGBNypXkL9GzeIodN3pUi4J1TA6x5ZAyuNMt+02ylHGZODUX3zlizmPBTdtFUH2dKsJ0DgtT1FuBZj3eAbBVvf12Ag7qSUEMERa6bsFvaANIcWdiaGtG8gEzUu4Dj9m+oSqF1jI3ExB83t7NI2pMelKVdF5/gxX/bLhX9v1u6QXznR7SKhUrCfAgkL/DG7y084dv/Y9lMMJz1TUwe34kOkweDE2Q9UgCIHim0Qo89K283XWPseRZvq33A9gGZ5XY/+23FP800/iu1NQakNaQWyEtJ6RjO+e6cnzV0jQgdp0kCPxxIQeNvcWOjfwZURzTbLLQX0cPBCer9uHgl6m42qRxYNUg/jL8ROZ1cH4azi8XhJpcoylW9Aw7oPuFU3Rcay4z7dD32RZzFHXeW7xM9KsnulSCKTmwlTSLhm26OwM40urI0BBw7aFby0DJ7gjLO5owRpDEj8u8bXDxMdxtKWzwq+g3k/t+foNKbpeYlVzrmfjp2hONX7uQbw4vKB2XmpFJF4L7kxS8xENX9wp9XedD6MWGEgiSZkj35PYXer18hBJvP3ocKEuoCk8Az/n2g+4Buxyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(356005)(7416002)(186003)(70206006)(36756003)(54906003)(5660300002)(2906002)(86362001)(8936002)(8676002)(82310400004)(81166007)(16526019)(47076005)(40460700003)(426003)(26005)(508600001)(70586007)(6666004)(36860700001)(336012)(316002)(110136005)(2616005)(1076003)(83380400001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 07:37:08.6120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd5a6d3-cc3a-4e9a-bb58-08d9f11f2339
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1895
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index f142fbfa4a77..4c24c25a7b07 100644
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

