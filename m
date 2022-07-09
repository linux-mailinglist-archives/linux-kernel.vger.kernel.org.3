Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D4556C9FF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiGIOVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiGIOUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:20:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E4C140F4;
        Sat,  9 Jul 2022 07:20:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ft7czpqRZGTm7GRflr9xaQF3KaSZrW7Fcc9M69JRkVRco80ju392cVt90fUUHuQTTBfe1MBCfeuXInHkUlh1THZ+LeE29r0yqdgk1w0s50O98EKLZWzEGpLyFjgGZrkbw0M4Px4egzE9dPtgZb9jaBwDmU2pgQ8eJyd6237hm1tnqGWxhZQNtkZiSODhBAnQr7iChEQDUMt6hEHBFpYHbIu7+bIZiWGi8GL3lk5QJsFbEXtq/oADVZvRgoHO7V/95CNCfjc2N+OdOUkV85mTyr13Ozeku+aQrIt0uuJ7+RUG3oEoBWwCV+qRV3EewcNZJM4sTbgZ+lkEIl1w/gArAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pg1W6FnKHehDtSxZjy9OOG/riwVCF9EOOqtUhcHbOHs=;
 b=S6bLEW2kwKDSqfgOZ9Ilejpsg6tNNi3YkzY8mY6yEzrGrOaXBypdkUyGbFJpTN65/F6uM327Fv4Q8CvxUyPbw9ayERHqhFyOUo+ZtSP+xi6wfP9CmvdOFcz/z6deI5RJYppTCG7LequtdD7ll7RS47VQ6xsBw7QZydqLnyKT944NcPP21/k5LJ5VlJjyW/anwKP5WrBXnt+8iyOQp5DYs8MgHspzasITc0dxDrEHweoq1KnPYAb/AL0WqZT5dORx+mMSWeiyx1m1c9hJ5IzJ4aqcPjLvkxDpu33Iy+EfwitO5K8L8U+v+o1NHDPh3kYbVkvLQX8RBEuGcWROocjcNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pg1W6FnKHehDtSxZjy9OOG/riwVCF9EOOqtUhcHbOHs=;
 b=IBJaHt9aos6M2epiF2f2oZw2t1rN9y6Xwd3Y2O7ZAr1SsvjiEsg2LLKI3OcvW/mwNk/F4dYaGH+JlHKcfjjcNODefgGdvSIynCWJyz7qATwYJp+C7iIBVOU2d4yqawT8vvoRmlKbMhweLgBNS6nZSzi7LeZi/Y6/XnijgeTfrBs=
Received: from BN9PR03CA0088.namprd03.prod.outlook.com (2603:10b6:408:fc::33)
 by MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Sat, 9 Jul
 2022 14:20:45 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::89) by BN9PR03CA0088.outlook.office365.com
 (2603:10b6:408:fc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21 via Frontend
 Transport; Sat, 9 Jul 2022 14:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Sat, 9 Jul 2022 14:20:45 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 9 Jul
 2022 09:20:41 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 14/14] cpufreq: CPPC: remove the acpi_disabled check
Date:   Sat, 9 Jul 2022 10:20:32 -0400
Message-ID: <20220709142032.837089-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73c98851-8e07-48e9-c901-08da61b6369b
X-MS-TrafficTypeDiagnostic: MN0PR12MB6366:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBZT+oZsVb+epJ591CPxnWJPFFkg59Tsy2bdvf2QzhkA/OrghZAOlmKX4bMcvMt9HLBmhF6g2tV9la0zwHqNpB+nO8kfmir0V8MzKMNcDK5k4rERqQmi2sIQ2IkKVlO1isZKIus8CVq40rUHjrGV/Jsatjk5KPtvZnL9iYQJIA2TTSVzrMTS7XXqSn6JYQninCWv4EruQmrNMXpReSn/FCOQz5QhxRfoSDp0ZUN3gxe6Ccz5IVbnjSTPueSbvTFdDlbEP9RpRozdnwxvNCMCzG/17GTB8X5tZvubalRgT/Qgt40N8fpffEoDMxemgEZh5vk1E0tnM0aQjDSChs5WhsO7bTqO6nBRVLiKbGl7UoV7OiWmWM1BaE5ogBJtLTDSI1sOy4OC5u/UXr4P2BP4ZsiKDCDHi6CjhFzHLmQKEIYTOq/eY06Ckxlf2ZbffEwsSf35xhg2eV0lXViQuKPmZ4e/+dpD+0tZg1uG5kxhZre/tbg2IHqdbRdjMsOMv+BLMnkmwtYd6wbF4pjTgc4RU2ZGLb3vv+KNj4R2ND2BJV2sHsM0x6PiiWFoqKoMnBh4qaSC8HVxCHOABBFww2fA33Niu2zWEW8yqyFmFuaih+bYBjSHZRdQRIHoKXy32/6+cBN8xBFkMI78hl3lV32ImnJ2ErUtfoIXv/BSAHThWe9Uc5N7P+og3pypAD/G6qm2Lmb/oNlkEScZpJlKFYLkGqxijVu5PrOIaxGd2UlN6nxfv/yFVZKDmXo0AVA5fo5LRrVYnYLJK33m1d0aovbmtVSO7hiwOlBwTYm99Ali+iHHws4jMGvYq9TISgRtHznSE+p0S37PB4/C8eEU+cjqHZlgAsys8I0PjCY6zitF7BELEWn7CuNzlCQxmRwavgwB
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(40470700004)(36840700001)(46966006)(110136005)(316002)(36860700001)(426003)(6636002)(26005)(36756003)(47076005)(186003)(34020700004)(54906003)(16526019)(336012)(83380400001)(82310400005)(478600001)(8936002)(81166007)(40460700003)(2906002)(8676002)(5660300002)(1076003)(86362001)(70586007)(41300700001)(4326008)(4744005)(70206006)(2616005)(82740400003)(40480700001)(6666004)(356005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 14:20:45.3842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c98851-8e07-48e9-c901-08da61b6369b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"acpi_cpc_valid" function already includes the acpi_disabled check and we can
remove the duplicated check here

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 24eaf0ec344d..9adb7612993e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -947,7 +947,7 @@ static int __init cppc_cpufreq_init(void)
 {
 	int ret;
 
-	if ((acpi_disabled) || !acpi_cpc_valid())
+	if (!acpi_cpc_valid())
 		return -ENODEV;
 
 	cppc_check_hisi_workaround();
-- 
2.25.1

