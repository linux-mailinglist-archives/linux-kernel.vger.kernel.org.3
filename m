Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2724BFCBC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiBVPfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiBVPfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:35:31 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22EA163062;
        Tue, 22 Feb 2022 07:35:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dx6YvNEK7jAcWHCQhiBwSs6WFOE4LW2OIkuKnQy7/QZ1Y60OuDylJTkQmVtpyEk6kH9Y9uBkX/3RAKrfKO8PtYacTMpvMeHe13JSYYJzyUp+8PgfCSLYaTRh9oseH1RM9iOGJllZ3UZ3M+xA26siA6VZ1RjGrv8hn1YtcbTiWuRLjVI5+4KXGSe/pe6jBrX9wIUkyrqp2ns5iMsgmQtJV2OG1OKHeQ8XGm/yh/mCID3ysIhjQDJC84NIAQE9qTpoCVpzCY6n6OwMef1cL9YuydgtTlvQ0yZ9/texoESk7qLRsClq5tbvtgdFFO+icR8ZS8FWNXQcyWjL/o18q/UCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IR0wBb+b8UoTM1GoiX/M5OJbOl1cycbDU15JfAwfGLw=;
 b=FsNkp1noyC6qwz4Vm3XTXOH0XH3g5Tg9ynJlyzmDbk7Hg/Vh8y7od1Fdz8ZAzJt33ja+3blGRlt+ZlNEI+cz/CtzhYbH+1yXXFeuq96+SFUrCxXmLe0OLLF6EwbEKWYB6e4h0Q9R1DGnDD2Z2g0eEP5DnvQnd44RDuHWq4fHnVNTbXyShlYFB8GQThOlJ4W5obKFDvavPyUdHFcxgYfG8483plgnrb6jgScPlBSQLt0I9e2OxIfVbbyy/PSqCx7MqLrk4jnIvfW/ZrLMjJmC/IK6aRXkbQgXxvRPkuiP2goLDqRrGpjxVi3P4hPJ4w71wWxG8q3CzwyaqrWWhfQQYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IR0wBb+b8UoTM1GoiX/M5OJbOl1cycbDU15JfAwfGLw=;
 b=ITZFVR7sOAj/+2WMW9JLf9mu8f8a0hlbyVDNAOHEBjT1dMALqSbDMEY9uCSKF5jZKiRUgOvkNcXRgyqOyevAs71BejZycEGGqkwqLPeH4rejZIGti9616BgzS6OMMKfeXYGASLmBwZrd2yjV2p18Q36nB2sA9mb2oFPizecUMZM=
Received: from DS7PR03CA0148.namprd03.prod.outlook.com (2603:10b6:5:3b4::33)
 by DM4PR12MB5373.namprd12.prod.outlook.com (2603:10b6:5:39d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Tue, 22 Feb
 2022 15:35:00 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::58) by DS7PR03CA0148.outlook.office365.com
 (2603:10b6:5:3b4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Tue, 22 Feb 2022 15:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 15:35:00 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 09:34:54 -0600
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
Subject: [PATCH v7 02/10] cpupower: Add the function to check AMD P-State enabled
Date:   Tue, 22 Feb 2022 23:34:18 +0800
Message-ID: <20220222153426.2216974-3-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 06af5af6-0287-4fd3-0561-08d9f618e351
X-MS-TrafficTypeDiagnostic: DM4PR12MB5373:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5373AC40C7F1415EF2F7C80DEC3B9@DM4PR12MB5373.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0MFC94RKjT47mzjy7sEPcRW8oZwqdAPMSi3vzJ98/ZTDiWb2V8IVDYP2NVsd/6EC+DDDgJrzYtJ7KqawotkRoWueXOIrRNzlKuGdxwubi/T6oC6/tiytqxUeT35KddaTn5aJ7VNR5KzjMmeK+r1d43Bysxi0rLVq1mpinfzk0/6ks0N109b9Qnx6hDQOtozkpE+oX+TK5v+NsdLN0UQY1+wefdvLNGTOFiVSrBZtXahrUDrmelbwO0Z733QSg5QFFnAc4d/AdJuWJEaqz2f6sRODtxB79vu5X6X9E6NDHv6NC6T23Vre6YA0KmaE451oOZkRVdyFoRPHP/6OQrY2OiEAlNbvkyz5QNf1FNZNXb4DbyhSNAIot0CF84mEbjzYIWmnb2Dw7Kg5S7pEXhBchgMa2B3Zp1PGhlQn7cTBmEJf872D0NgrirsnKlZKElLXyX5ieCKWFP0KvGfNWJPGedi2ay+QipxOHBA7SdE0K6IOyZETxmRI12EAz6y7frWpfpcVdqLhDzT16Qvo+6OhEs0VYudsLke7WScpugAtUwzuZNOEIL/DrzJi7Oh2Y+yJ8TmYnypwxdiJTROyLXe7xk4JwxLdk9P38PgvF2oVvxj4NorkSSyCBTvV1YZX/ow3eZusnn2j3IKr/dGusQWNj8awA0QfW7PLigC+d4H0YU3njJ8i21nSZ3VO98vl/cWPVjHlvsEOUeVHzkUUVFZL5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(336012)(7696005)(70206006)(6666004)(316002)(186003)(110136005)(40460700003)(426003)(26005)(82310400004)(47076005)(86362001)(4326008)(36860700001)(8676002)(54906003)(36756003)(5660300002)(7416002)(2906002)(8936002)(2616005)(1076003)(81166007)(70586007)(508600001)(356005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 15:35:00.1927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06af5af6-0287-4fd3-0561-08d9f618e351
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5373
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
index b4813efdfb00..62771a086871 100644
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
+bool cpupower_amd_pstate_enabled(void);
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

