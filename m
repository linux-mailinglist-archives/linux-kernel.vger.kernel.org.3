Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910634B81C2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiBPHii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:38:38 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiBPHhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:37:51 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464061802A3;
        Tue, 15 Feb 2022 23:37:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2qA3zAhJjbvdWyUjOdnFYiYTlN1Q1GkOrSwXyxrVsQFMPnOQA5d3smMzD/KKMQ3VCkvdb2wAWyPbFXVrMOjT5K6qsvcE7Oh/AmYf5mHITjcdh8wU8Z+tslnsqxPVpqufcAQHj0eGMmq0CPqM0o/Ci5AXP89Rf868SxITegqlqcw14QbE9Agr5FEoq2I2CeOw+BeXm0MPiCwKNWsBBE2JQ1k9lTj0A3uK3VgKDFIfEMg2UFkvskvBZZsIRaJkJ7gc7+znCKBFSSXKccjJGg0oqtLBQLGEHe6EtavAJQwIEfBoEb3ydKiGN2RM8O6pVAoHUgyygdPL4aGvYqXdEB7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5K0lvL9BTquP7/qoyBkBqBf462wzUoODlevyZRog3g=;
 b=iZxKf3cIpwINz9MXC8RKitXiI8EYr+cSXC0n2aQHDT6n1CUNIUIipdfnpYlEAeXaY2ATO1g8jH1RB1nWTUNnjfYsVNQk6tR32N9sVnK3i/x3g+1Z7u9DYA3cs0BwNID/gKNH/k5JMvCt62y5GXEq+RXQ+vzp6nsVRO/726XZA06cIDEucZFBaBQ3Scj/3Z4+N4DCulv46DZ0Asy/U8K7TRe+f4pIHFScp9mU3rJAm+9c8WyN4W2ucXthYX23Bl3RGb9mXP1w2Q0qGvkIaA1a911AWZkOWXOUlA91B2WOH28ZbjAGjiZMore7OmDuz9eXPdMnmPWOn8A07W4reb8tNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5K0lvL9BTquP7/qoyBkBqBf462wzUoODlevyZRog3g=;
 b=b/7G0v7iZR+raw60zGkblmQ4EeTmXOjncCskkiA+mNnuf9sLFsUQpPHHJU+0SGDUXjl8aOiBTT77XxK15zdKAFW8ZDjL6vF7PgTLRj0YLV1lYuLU3BpqQGHf45Fq95QIxgmk4rQsl1YoUToUE8XH1iigykx7uSCih9U/oSxu3jI=
Received: from BN9PR03CA0850.namprd03.prod.outlook.com (2603:10b6:408:13d::15)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 07:36:40 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::5f) by BN9PR03CA0850.outlook.office365.com
 (2603:10b6:408:13d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Wed, 16 Feb 2022 07:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 07:36:39 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 01:36:34 -0600
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
Subject: [PATCH RESEND v6 2/9] cpupower: Add the function to check AMD P-State enabled
Date:   Wed, 16 Feb 2022 15:35:51 +0800
Message-ID: <20220216073558.751071-3-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a451f2ba-f1b1-4f7a-9a9b-08d9f11f1208
X-MS-TrafficTypeDiagnostic: BY5PR12MB4098:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB40985A480EC949156512E2F9EC359@BY5PR12MB4098.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 758FztabVNA5FalIVK4sMxGoyZudc+Cie5vt/XJl16e6kt+wVOIsLfL0lKlwmkow1e0Anw1R0vilE/APv4YHCzXe3lb4yRK0GZ00sefyWKWBwmLJpCpAKBrW84SUW5jsLCOVu76areo7yIzgrqjXjph6pzUPaMbpPtby15tKHzAQA5WZTzimpr/0A2SxpZGyvpRK5koEqLEiTAaFuvFWMsbXabdjeL+YeyRc/ZzzyAInJckeKQmVm7igeXNEYbau8XyjyHCLAyybWvTuGqPwN/O+RADY4FduSqcn05ZnE9FvsUsqyuPruI8LdGf+qCU3/XruAEGBykavsWKvGY1jdPT4rVwvFFQt8Jt6WhSQCyyHur2+qN0zpNf6nNmdf6gy1Gt6VuhvUSRiQOWQ7yQFJpqEtRUcbmVkzeoFHDwksx5EvEMp8midDdn9KKGn/lvwoTh0RhYzkOQG3zhXLecPZ2nFY60aVo/bujsSem3hq07YOZ2vZJL0L6LNjkItr6NHG5bb03e8y8GGD2ObhtZFwv+0+pPPT6AiEfPSX/PGmTWbTN2rrAZvtAEAI5zK8ZCtZNN9i2+RT85Gxi9RafqWpRrucO80EBqiVqFyOp9j7wtyGaFt6Y+ebHTHzQbuxUFzg5ZBDL7nXi1bo+Fp+j5BhwJVB8BJfEqMNypOaiDDv3Uxtl24tqfVX8FLhUS1btInZUYjTC6FOFZxi7EafjmN6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(7416002)(26005)(47076005)(8936002)(426003)(6666004)(36756003)(81166007)(186003)(16526019)(2616005)(336012)(1076003)(356005)(86362001)(7696005)(40460700003)(82310400004)(316002)(70206006)(54906003)(508600001)(8676002)(2906002)(4326008)(36860700001)(70586007)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 07:36:39.7688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a451f2ba-f1b1-4f7a-9a9b-08d9f11f1208
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The processor with AMD P-State function also supports legacy ACPI
hardware P-States feature as well. Once driver sets AMD P-State eanbled,
the processor will respond the finer grain AMD P-State feature instead of
legacy ACPI P-States. So it introduces the cpupower_amd_pstate_enabled()
to check whether the current kernel enables AMD P-State or AMD CPUFreq
module.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/helpers.h | 10 ++++++++++
 tools/power/cpupower/utils/helpers/misc.c    | 18 ++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index b4813efdfb00..557524078e94 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -11,6 +11,7 @@
 
 #include <libintl.h>
 #include <locale.h>
+#include <stdbool.h>
 
 #include "helpers/bitmask.h"
 #include <cpupower.h>
@@ -136,6 +137,12 @@ extern int decode_pstates(unsigned int cpu, int boost_states,
 
 extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
 				     int *active, int * states);
+
+/* AMD P-State stuff **************************/
+extern bool cpupower_amd_pstate_enabled(void);
+
+/* AMD P-State stuff **************************/
+
 /*
  * CPUID functions returning a single datum
  */
@@ -168,6 +175,9 @@ static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
 					    int *active, int * states)
 { return -1; }
 
+static inline bool cpupower_amd_pstate_enabled(void)
+{ return false; }
+
 /* cpuid and cpuinfo helpers  **************************/
 
 static inline unsigned int cpuid_eax(unsigned int op) { return 0; };
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index fc6e34511721..0c483cdefcc2 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -3,9 +3,11 @@
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 
 #include "helpers/helpers.h"
 #include "helpers/sysfs.h"
+#include "cpufreq.h"
 
 #if defined(__i386__) || defined(__x86_64__)
 
@@ -83,6 +85,22 @@ int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
 	return 0;
 }
 
+bool cpupower_amd_pstate_enabled(void)
+{
+	char *driver = cpufreq_get_driver(0);
+	bool ret = false;
+
+	if (!driver)
+		return ret;
+
+	if (!strcmp(driver, "amd-pstate"))
+		ret = true;
+
+	cpufreq_put_driver(driver);
+
+	return ret;
+}
+
 #endif /* #if defined(__i386__) || defined(__x86_64__) */
 
 /* get_cpustate
-- 
2.25.1

