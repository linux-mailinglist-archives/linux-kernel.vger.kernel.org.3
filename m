Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731E647A161
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 17:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbhLSQhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 11:37:02 -0500
Received: from mail-bn7nam10on2067.outbound.protection.outlook.com ([40.107.92.67]:17377
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236217AbhLSQhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 11:37:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lP7MCgGI0488lShJrmfgZcVhVRqP0p9WIxFlveWcn5uUV+aMxNzOzoynDRw3eJ/xRzsVJeXk3u1DnHBViPWO5gQKviVOXHzRn9PsuGSwj/SZkKyCh81gsEaNLdpYm6G/3SEpVcGyeVPhC9xKsEPDJUEJxMSqrkq+dHt3JS64a7tdB3osL669pHJYqxMyE2VrNCsXvzipJIzLP1Tuq9ICFcsp5a/J1hwzdzgKDn63FNcCaqpEmF+KOyUSKeR0EjNaNmsa14mzbV2OVH5A99KrsfC50kewTQ5h0g46uH/LI3DJEeF/O1tlpGQA7vsd2AqDuh4AjHk/1Fglu2wY+a4zHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCADWS0Do5yGHmksgD+xJ4LH7aHFJHM649Y32G0bczY=;
 b=a1oS0X+pPExBN1rR7WsumrMgTNwf1Ni0PT1GyIgSd1W5/k3qUcycUSc0btHFvT260FmXSdacuGJmkcYoRE/tbRjVch/Y6VLSlcXKiHB9PJBZJu77j+7SDJph7QFiv60KIpw4ORQmzFzSpyp/ZresgmWAkWiZYLK3ZofmgRTNwiU2kL5Blnf//lSjMFnm7tzYxwv/KIhmaxnYcwe0JtByL4vu7Z8Idfl1SArN0XpEEok49jxeY/E7TKmQDsRh5kZ5Lb9DkQs+ZPwu73xpBx6fjwtbjFoY9SNWMqw6Orxsoqwg+qbP3S+ZrqNkVTABGcCG0N+io6UHcYn0hG7jMN+txA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCADWS0Do5yGHmksgD+xJ4LH7aHFJHM649Y32G0bczY=;
 b=hndx2ya6fSWiJDgqh3rPU2XDZjUj3D9KLzB4QGXNkaOG7S2O9LIYX9+ZbkUdj+K/c9oWTn06QSw718W6H4PwVIp+rnEovfDLDVq8pIQKER5qi6Xhdy0wlibSmJHsZDS7bnDZv0jK/dv09HFfki0S7nuvYtiFlhUrB7rV2gKZDSo=
Received: from BN6PR17CA0060.namprd17.prod.outlook.com (2603:10b6:405:75::49)
 by PH0PR12MB5498.namprd12.prod.outlook.com (2603:10b6:510:d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Sun, 19 Dec
 2021 16:36:57 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::e) by BN6PR17CA0060.outlook.office365.com
 (2603:10b6:405:75::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15 via Frontend
 Transport; Sun, 19 Dec 2021 16:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Sun, 19 Dec 2021 16:36:57 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 19 Dec
 2021 10:36:45 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Subject: [PATCH v6 11/14] cpufreq: amd-pstate: add AMD P-State frequencies attributes
Date:   Mon, 20 Dec 2021 00:35:25 +0800
Message-ID: <20211219163528.1023186-12-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211219163528.1023186-1-ray.huang@amd.com>
References: <20211219163528.1023186-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bacd5a4-510e-4e53-92df-08d9c30dc5fa
X-MS-TrafficTypeDiagnostic: PH0PR12MB5498:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5498C31CD35E01631E7B2EC6EC7A9@PH0PR12MB5498.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGuAdvywyZ6NV4EuBWIYR2pNOkn/WaKxiMu3gEef96KOO7SaLp232OdORdnV1ROIrhdyyC+rCZskI0q19b3anNw0IMst7OgA6N5asi5+L6xfwRCWGX5cPqabBrfXsDd2+yWmMpURgXJ3Lgy7a7pozBXkYTFtMlw8tqoujPj2QTPbaj0pSAZKbhFIo8FdOh5YEe882H8aMIR2I6PlW72HJj8Lq7drNfWt9WLag1ZJI78RovNQf8nbvxlmushucNrG+aogV5/HLRlzxG1OU6eeYvCvnFwyhPPHqec/cmulEn7z2k+XmoMflgR8vDjbzP91VLxecX7UyvzGfbhjkUJYRUUqFbcoTTTQoztY20QMs4mdvHQGGMCmdG0Qi7EbGQ5iWgBXjKHD0eaUYpKCrduOsZA5cVHe+6zE83eynMvcIWgRIxNq4qbIvtlZWpA+5tA2/1ZsqJ/2izfxqT62WPDm7OiPT6Al3TQji4Jw5DCLuXdqVxAjbfAcFGzQm1PCJUY9K+v+xHra4rIML2yqmgS0uxvW+DQBAo73qhHt9xQ36WO57Kc0PF7+ibQxoNUe+H+nFb40MtZjxfO0VNwVpRgC83qvtE2LBb6K7KfcqRT4LrxByHB08QPl9YZcOWCLMgREM+PLAKwJd3NLBqy9tuXu3z6WzZ3+aBIEc2BssOxW87myMsh0VNA81A8P+f2OLQTbmNYmLUfT1qhafLCUW+rI6nhDzBUyPi7QydRkK3vqbt7p784Hct8xsUYuE6jenWgZtEwTpaVMVF8YTzwyYL1BD6ubdgRMTIabzrSImovgB68=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(2616005)(83380400001)(7416002)(70586007)(36860700001)(6666004)(110136005)(1076003)(8676002)(54906003)(81166007)(316002)(70206006)(8936002)(2906002)(16526019)(4326008)(86362001)(186003)(82310400004)(36756003)(426003)(7696005)(508600001)(40460700001)(26005)(5660300002)(336012)(356005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 16:36:57.2725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bacd5a4-510e-4e53-92df-08d9c30dc5fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5498
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce sysfs attributes to get the different level processor
frequencies.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4ff4fb7c3de6..dd8c0e894532 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -509,6 +509,52 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
+/* Sysfs attributes */
+
+/*
+ * This frequency is to indicate the maximum hardware frequency.
+ * If boost is not active but supported, the frequency will be larger than the
+ * one in cpuinfo.
+ */
+static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
+					char *buf)
+{
+	int max_freq;
+	struct amd_cpudata *cpudata;
+
+	cpudata = policy->driver_data;
+
+	max_freq = amd_get_max_freq(cpudata);
+	if (max_freq < 0)
+		return max_freq;
+
+	return sprintf(&buf[0], "%u\n", max_freq);
+}
+
+static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
+						     char *buf)
+{
+	int freq;
+	struct amd_cpudata *cpudata;
+
+	cpudata = policy->driver_data;
+
+	freq = amd_get_lowest_nonlinear_freq(cpudata);
+	if (freq < 0)
+		return freq;
+
+	return sprintf(&buf[0], "%u\n", freq);
+}
+
+cpufreq_freq_attr_ro(amd_pstate_max_freq);
+cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
+
+static struct freq_attr *amd_pstate_attr[] = {
+	&amd_pstate_max_freq,
+	&amd_pstate_lowest_nonlinear_freq,
+	NULL,
+};
+
 static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
@@ -517,6 +563,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.exit		= amd_pstate_cpu_exit,
 	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate",
+	.attr           = amd_pstate_attr,
 };
 
 static int __init amd_pstate_init(void)
-- 
2.25.1

