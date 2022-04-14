Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E13C501996
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244432AbiDNRGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244603AbiDNRFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:05:45 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2045.outbound.protection.outlook.com [40.107.95.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6427A49687;
        Thu, 14 Apr 2022 09:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F44kyiZ3nLO5CSxAOGS0Kkh+SgHUfcYQ8YlcyEJEK2+ITgPTwmsfh69VWz97NgGKovGPiaOKJrTKhl8kgbX6q1sT00QXvN+0f4dYUmq8rWRYRWxwyntI+arDIdM0hXDXrBnsKE6DIRya2EdXgtBdKJlkXsCbQxe5O7qhgbCZU12HZ4So03QSxvF62XOUfQoI6y5EezRe6WPbOzt9v/Ol4PrGIndW/LrbHnGm3DaCtRjczzDlkye68VuY/eIOcvZ1RXaoVho2pn7uU30aHML+cz5Lcp7lGnKFmSueCiMcpMj1rzStwjTJJQtuOUhXK4tvsKR88zHByPYVNzPlQigeiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwGTwtCH0+YudosIEhG/8CiHFOI8FMbNpAfVkGHDIiA=;
 b=bgoQ0gxJKz7ouL8Y4njKODwNOk/ue59+F4t9i8cHBWfb1lG809rOHFik8jbc6AttYnvR9EVugn/lv3D4R57f7+Mp6mwsy2Y4ITS8jo73fL44C+mr6/L27COcUHCLpx6QehjkSHrNfDc+a0tTivTzvsaTg/CfeLcm+wCw4n7hq6MHQ0Zfj91o61hREO78fR4PpHamY+VUr5vKN1PhKTCne7mwcnpW7gfiSBMKCZHSOci4v/xfN4NcSXEZE/pBEELUKazA2hMsR8o2L6XIW4BRXFtq4lJ5CK0j8uwSK5mkR380aKJfkLDCieLlCn/tV+3lX4gk4q82DOXB1Zo3OCtc4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwGTwtCH0+YudosIEhG/8CiHFOI8FMbNpAfVkGHDIiA=;
 b=OwhuzH+vwotDMgo16ZJa2xc27Fq9sQewGbynfJ7xCCFskA6a/aJ0he01CYgP0Qj2rgEHbeiS0A69wAYzBVcDb0QYbmoWJFqqPxlaep9dsYoM6q2J57w0M4KSAbPIh7hWCdBDYFYfJZXbk/eJh+dSeXRnVjrOla1mt9HOBsCxDrA=
Received: from BN6PR2001CA0019.namprd20.prod.outlook.com
 (2603:10b6:404:b4::29) by BN6PR1201MB0034.namprd12.prod.outlook.com
 (2603:10b6:405:53::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Thu, 14 Apr
 2022 16:48:14 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::2b) by BN6PR2001CA0019.outlook.office365.com
 (2603:10b6:404:b4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Thu, 14 Apr 2022 16:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 16:48:14 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 14 Apr
 2022 11:48:09 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Rui Huang <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v3 3/6] cpufreq: amd-pstate: Move cpufreq driver check later
Date:   Thu, 14 Apr 2022 11:47:58 -0500
Message-ID: <20220414164801.1051-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414164801.1051-1-mario.limonciello@amd.com>
References: <20220414164801.1051-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6deb2a6f-709b-4c16-1ed4-08da1e369172
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0034:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00341A8E92354AF40DFBB414E2EF9@BN6PR1201MB0034.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MDu2nQUHZ+2V/8rvvGzysxEGVdzOFFUVW9J/zHlpMZ2zs6n31PgRED8UkXizGQkOZgxwGpp9WY6g0MgMWl8fqGIPPzkIOu++/0Ha14QgfMe3dY8HKgW3Ta2rlhKZVW1AlRo56aMA/5UgqYl3BVdJHezULzLO+q/+0NxzB8CvcqaHbC54LOZ+xmKRDEWtNOpH+qaxxQR64RlWxgtoEQYYVgu6Y9vqHZtUmMRKCQXdipK/5yms17bdrpAHHrlhNm9BJ30Hykn7BZF1voh6tYIH5VKJXFlqM1jlv36hP3T7gSTr1WjGDWXeD+V1B21lDAlHKe6Y10gwQDPxAs+/sy1/0tCkC5X6+64PZhAjEQZLcJ8sBx71w/x68CRhLB/VfdfoS3U43+do+LGImztn+xZ+L872uKRNHJEUz30RgKOB8NWJUV+hRP2BzyGS2GZNBR5kv1lSharJzmu9+dZVaE2JaJDz5sNjTA3Bp0naRATKmkGjfRFkK0k0HAnhaLAL9pQ0ZKxzQTJMiuFvRC3jTkHaTF4gcoTBHcWcryhay2TN+y1atDUWE8BqWlIxuqoOjxa0Loz25fj4s6wZ80MkBX+cVjH7y4UVCLaiQwg2xczBSpXy0TLcTuaq0MYTWMUa3xY5suw4C5B6HA7K0pborGEQ8FAGcg80C3+x0Ln6pdklgn5C0CtROTAH0PwlFBxvlLXSbvP/mENGr987q0D7qLug4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(40460700003)(5660300002)(8676002)(4326008)(36860700001)(81166007)(7696005)(110136005)(54906003)(70206006)(82310400005)(316002)(426003)(83380400001)(336012)(47076005)(6666004)(356005)(8936002)(70586007)(86362001)(508600001)(16526019)(26005)(186003)(1076003)(2616005)(36756003)(2906002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 16:48:14.2964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6deb2a6f-709b-4c16-1ed4-08da1e369172
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0034
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpufreq driver check occurs before we verify if the CPU is supported.

Depending upon module load order, this may mean that users are never
notified they can enable the shared memory solution.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * New patch

 drivers/cpufreq/amd-pstate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ecd1fd5e5b5a..d323f3e3888c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -653,10 +653,6 @@ static int __init amd_pstate_init(void)
 		return -ENODEV;
 	}
 
-	/* don't keep reloading if cpufreq_driver exists */
-	if (cpufreq_get_current_driver())
-		return -EEXIST;
-
 	/* capability check */
 	if (boot_cpu_has(X86_FEATURE_CPPC)) {
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
@@ -670,6 +666,10 @@ static int __init amd_pstate_init(void)
 		return -ENODEV;
 	}
 
+	/* don't keep reloading if cpufreq_driver exists */
+	if (cpufreq_get_current_driver())
+		return -EEXIST;
+
 	/* enable amd pstate feature */
 	ret = amd_pstate_enable(true);
 	if (ret) {
-- 
2.34.1

