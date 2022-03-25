Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3D64E6DD8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 06:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358381AbiCYFnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 01:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358357AbiCYFnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 01:43:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535D05BD18;
        Thu, 24 Mar 2022 22:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPco7CLzVHBj1fHeFBi1rsXaI+nnf4kAtsaLFIJdpi+MQUL08lfKuoBpVHetKzOi8TebUy2IfmUDypcX8/o/e7f7RSgtuTve3JTFXFRe0vN8ILg6lZzFnzZdL4hYMBGJaQjwVzB7g8Ps0Ku0rAkgOUJge2/lD3TmeqFRPxHqHGWPhekUEpTHkQlehb0wQUjMLTVOKuzQ8yVvyw8U91AhEzjyOyo6BmAcGVs0kSF+fUarW9ZeIWyQ1lzWiDdDknLvbXva2190cmrFr2jTM1j6PMEymXJYS0/JH5HXI6WqWXs7q9v8KVMcxu5icftFPVpjp8jTZ57Cw0Ita7FUpY3AQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjhH8cZC8O/uMrXHISn1l1eK18iR0z8NPc51X44UYds=;
 b=hiaCvIBgye0eQc42iZ8hHNKoCEjLw+iXEyf1llnQ4J1RW8/WEgxXAMF0wVMoD5KvRyc8gGIjSr4tUDp+qm/rRUSgYkZuDs7vll+JfYmW6N4y9Zuz9OyT7tD9i5nc0gkRWEopR/N+s9uNya76YkWHND/Ilr24qSjeO6JjkT6RA+vZRtvFVgWsKnGvI3TLSj4a7M6xDmBZuSMBR/Rh054jkZYMqA4CLVZTn/dk0jezKH/XJ1BCI2LEv8Hhx3EDwsLKmn+tIqHOivz+k5XehY1r1zZPtmYXLCIHrwxfRp6NQXF+ijA/umbBpfhMWhYTvjEdx0Cj2IuinrZ2eFhAOlSYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjhH8cZC8O/uMrXHISn1l1eK18iR0z8NPc51X44UYds=;
 b=WsVsWXAgR6YzBxMd0bRAWVZthl7E5YdMIwl1CzyO47JNHtpr69c73McLHmowNxgdmENsYCyyyKKoIOD7XLdTJ5YncxVQyPeZHigqaG2uviHHjpCl+8PW5aklwxdygXH1S9v1KsoVv8Ehp9tyMllfNXHddrVgr6I8oFVANR3xWso=
Received: from MW4PR04CA0091.namprd04.prod.outlook.com (2603:10b6:303:83::6)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 25 Mar
 2022 05:42:01 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::d6) by MW4PR04CA0091.outlook.office365.com
 (2603:10b6:303:83::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 05:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 05:42:00 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 00:41:58 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/3] cpufreq: Allow passing NULL as the argument for unregistering a driver
Date:   Fri, 25 Mar 2022 00:42:26 -0500
Message-ID: <20220325054228.5247-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220325054228.5247-1-mario.limonciello@amd.com>
References: <20220325054228.5247-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 956a18a0-6bd1-4bf7-e30e-08da0e222f24
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB594687804FBAE9756E957AB6E21A9@BL1PR12MB5946.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nrlr7+4A0a1YaZTtnuBHAWofr9T2EvXqI4/kWiILU6/kakfICdI5Ya4qqV03msCEtec7gSO9hLS0K+wyLRuqLwnZKTtdj3iSvPZHKT/q5vVXYa/15gHCwpOa65/c2y5FGqPPAYyv2EUA9BaAdG+CsdbahFdTNoV3fQJaIjXxKb9o1kekw9SZhvCq8djFf+MkOXCSWpKsCQ56sDfSZrsBPNE3RoLo0u88Utbka83o66Nc6in8G7SpKtpgl4zgNJGBq6UcHxsrCjEr7EMG2gDWPZlhFx1Y6n3t0bXQBhgd6Tqrsya61Dte0NU6gOTfZEqehP4bHFXlKMXmBAcub+2GrCHk4CFZ3hA4jM4l6f1BxispnyZT5iGMlPj2meEpHGyCT/xum3WS7x1aEJeT7UOLnmuOgAc5Wfic9fLRvpBd8h1LPDmWqfEgZbmthjuOmUw4tnbAUOH23k9KF9fgjFBQYD9eWNl8MZnrzIiG43RYZ8AkgCuO1k4odmuaX5oY0p7AG7dGS+XQT/F6AEKlRuOtPJu52bwrsM323vu23FJxlG8yE1J/zFTiPUwoG0m/9Er2ZYuYuUGf12YvX2X0sI2dsMn9u+cFdz19aZkxs91sY87k1ZdLtcXYGyl+5Sjim65MQUp3tuVYF7GmgnJxNPSCnb9imCM3FocSWZA/Hw1Hebk8StxMjxGf7JFDHHfsL7Bv9K8EPDbSlkiY255bp77z+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(44832011)(7696005)(2906002)(40460700003)(508600001)(316002)(26005)(186003)(110136005)(36756003)(81166007)(356005)(54906003)(6666004)(70586007)(1076003)(4326008)(86362001)(5660300002)(8676002)(2616005)(70206006)(82310400004)(83380400001)(36860700001)(16526019)(336012)(426003)(47076005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 05:42:00.6938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 956a18a0-6bd1-4bf7-e30e-08da0e222f24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the arguments passed to `cpufreq_unregister_driver` are matched
against the currently registered driver.

This means that the only way for a driver to be unregistered is if it's
module is unloaded.  Loosen that restriction to allow other kernel modules
to unregister a registered driver.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 80f535cc8a75..4711c17a89bb 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2885,10 +2885,10 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
 {
 	unsigned long flags;
 
-	if (!cpufreq_driver || (driver != cpufreq_driver))
+	if (!cpufreq_driver)
 		return -EINVAL;
 
-	pr_debug("unregistering driver %s\n", driver->name);
+	pr_debug("unregistering driver %s\n", cpufreq_driver->name);
 
 	/* Protect against concurrent cpu hotplug */
 	cpus_read_lock();
-- 
2.34.1

