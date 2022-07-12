Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DB5571FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbiGLPmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbiGLPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:42:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1007C3AD9;
        Tue, 12 Jul 2022 08:42:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F38lYpzKtCLCxaakyDrtIDP745WJ3zTNnVO2HipAwAQs8EOHAdGEheFgOxrJ40HZkt56Vw0Fox38rPBfuT+kjEmr0dMbNZcnlZ/EAho8+MDUR6h3j/uhZ460a0kPi+Km9wybDb+wvkhvVwlTaP7YjjNDIdTlOOzWzviOuFlizGDc4O3NkFp+ZrHfEVBvYhzMKwK5oy58LlfLNoFmiqzUz1gHbRixL0O05Fuv+bCDV2lF01rr3bpbEtOMw3rByxqKJVgPNOxjh/DiY7llSF/V0YUDn0rYPw0/u3l6TttGI/ffdd+JilNGehOhy6YkPo5ng7taDMSgakuRC9vJMLBxcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQhmJVm7Yytkz/qiKiQkvmInwq2tsjDBkodmzR1O2qU=;
 b=Ta94yanpr11/l22DNZnBPWUFgwz/JAhlLC0tJbLbZfTGONIkU+n3BlwNUavvM/Bf0a51iNmWhgHPtFrwYvOHFuxlzr0EofVmfZHt77dUqpzPEZKzycQBTOU52AJ3fse5qxtHwKfSfw4AFdIZXvEK5UY0I1feZHId/FQA+FNWKEtngMgkZGpjCd3RJpoBrxIqV5Lip20hDHo6DOBwHV0SdvHEMudIr+spJJCcr4sMaAHJhuGCY2y+hrSbHVHUnOpoAOyHqEv+oW6JrHly5xTcq5QQpT0DJGr23ipQK7cZDCn23dVuIPYfFqzn5vUSOWgLXCJaWdLAug9Yfbxczrq8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQhmJVm7Yytkz/qiKiQkvmInwq2tsjDBkodmzR1O2qU=;
 b=B9E74WlEJ2qjLInCMeh/Krg3RhCOMvpQ+Y7QRNB7G16rlbuQnKIQ6WD1EKaHAVghvoEMYGp/7thLukOaUxRIPMpLc3yRG3qvMd8GD54zev5zufFR1KbgOorKh9LLyFleBFwgYshplsZdd4kyFyEJGFZZAuYO8gNGiObQrVWR0jM=
Received: from BN0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:408:e7::13)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:238::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Tue, 12 Jul
 2022 15:42:37 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::b7) by BN0PR03CA0038.outlook.office365.com
 (2603:10b6:408:e7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Tue, 12 Jul 2022 15:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:42:37 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:42:32 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Huang Rui <ray.huang@amd.com>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v3 10/13] cpufreq: amd-pstate: add ACPI disabled check in acpi_cpc_valid()
Date:   Tue, 12 Jul 2022 11:42:23 -0400
Message-ID: <42dc4270e8ad2f9a7ecfcda8ec42225182d9456b.1657638462.git.Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657638462.git.Perry.Yuan@amd.com>
References: <cover.1657638462.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8980f356-34c8-40ca-b1b8-08da641d25a9
X-MS-TrafficTypeDiagnostic: SA1PR12MB5640:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XVJc2/veOK6rm45WF2XmNZKxRXhzCzhWdG36u2J6fCy17Jhd+8xtiwNZAi2C/KCYa0FQKuztHXqHV2228Axa3I55SfpsIznzw8wom/Vy+2h3TtJ+9OZqQdUUEXlo+YdQwUDxUZrrVXiOc9uV6f6TUtf2/kvoOk77uVk9Gwv6hCOab6uX5/q0k+HqF9tl0yULXYQ5CbStTj13F6/A08cV4/2XCSgqEfWhsaj5k9KxaEh4JDjh8o3ZKfM4sZ3d1NqifTVWzZOviXDpm59UAyj2nOsCddh3CVcwv0NPTV+hcdGvg6bHTfuOktK1ee++LSjH3NIdYJ0bKAeLYlQX7rqlF7EpbYKvnrzoa6byy9blLHBbt8h4wbBu02lED0qE3nQI3RYDX7/ghShUtpQCc76WpkFndwndOsMhjogT2ohM8QV3+8YmRhzFjvIgnD937FJjnd4IXmH7vVKUEuigyIBkqXnXwBClBTFYn+5Uscp9g0BEt8wNsQZV1jrokt5vHxVkY3FmQh/CMRh8sWsIWchBX08u+3Z0f8jAn+A6Lrl8KxROhXsM2Jp82WzlQfeiHb7AeoHXXs4cC8YAuA9riwaZBv5axwTfFKBCxuP2axW8RIOIkjEZpAmW0hAjKWE5gnDrulGNxk4l5cQcw/YzcoWi67WtS3fQ7RB1kBlWEX7ArfK7Cc0rpxDiDGWYr15C5uRvCMfAI9kjvFvGFSRDHTkeKe4Jvmtw58l0Axe++bN+kO+otfilBHHFl1ZgGmTqoVuJCcW9s1mqH8CSXxp4T11nDQdU++9/oH2mkLuPMu9xrbkrLSeoPJL2kuXykno4HjSyrw4oMZMzI41CMCpAk1QS3VfuXstyuUqUuTdSoxvewE4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(136003)(40470700004)(46966006)(36840700001)(36860700001)(2616005)(81166007)(86362001)(26005)(47076005)(5660300002)(83380400001)(82740400003)(36756003)(426003)(356005)(70206006)(40480700001)(6666004)(16526019)(316002)(7696005)(336012)(6636002)(2906002)(70586007)(8936002)(41300700001)(54906003)(8676002)(478600001)(82310400005)(110136005)(40460700003)(4326008)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:42:37.4272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8980f356-34c8-40ca-b1b8-08da641d25a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640
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
 drivers/acpi/cppc_acpi.c     | 3 +++
 drivers/cpufreq/amd-pstate.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 6ff1901d7d43..17d67e3ededf 100644
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
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1e5ca4897b7e..a9918728948a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -682,7 +682,7 @@ static int __init amd_pstate_init(void)
 		return -ENODEV;
 
 	if (!acpi_cpc_valid()) {
-		pr_debug("the _CPC object is not present in SBIOS\n");
+		pr_warn_once("the _CPC object is not present in SBIOS or ACPI disabled\n");
 		return -ENODEV;
 	}
 
-- 
2.25.1

