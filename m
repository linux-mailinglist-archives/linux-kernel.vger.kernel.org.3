Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3FA5A9A6B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiIAOdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiIAOdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:33:38 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2883D6FA18;
        Thu,  1 Sep 2022 07:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJduRuz4BxxlpLBeKrZpnlScEpj8DGGv2Rtva2Kk6fAUi7WsjKBSKuw0QpCPUR/l0iGuKhm1Ges75fMCgGZayUi/4wd4sctuuJN503wzmxTLjlPs9ctu4UkNYe1euBlooM1SqClLMb5oDL608mnrnvVJz/sr3nMjbSO3kXXVZAlqsxyhzPuI0z1CpS8kdoeV/KkKhS/Pt8JkNS914CtGP1OVILmK1QMALCZ6DHG41mjAX3EV3i3FxScrn4aqMWsvnkfugDlQN9Nrd/rlYr/za0DY/KV77QCjrkWWyEwcKhMQLq1ZF7G1PExO/JsdYcClq+U+lm5Le0IWU9P+7M5aQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeXH7BRgXTCkpCKmgAhR72Q1WvbpZbXS1SXiP6cNnkY=;
 b=GPAE1vOUtBAPT9cfDGB5Z50Y8a5+C+QQmW9zYoXMSa9Qv8dr+1UZkvi8ejSgqRERZvhOhuUFcdYFVQ8KmDE7sYOKMGLZh3QPlbCOkZFWe5oTQJEqfMrqvEDmJ+UQ7KloiLuvgfM1mh4ZqWPWVkHh84cMVYS1wvxQ64gAPnJTgDej2rUxkGbS/VWlexFSE2kwpSNnvCpTzdtEX4AXOomYU+dK3JssQxfNgcGcR7bumoQFt9zuryGfZfV6LhI+FIrlZ2XuskTNPPtPmFomLSA30GU7DXYKCISIovu7IwAw0/NsN2t2xY6oX7kczcdfgjSG8pyK4P2vvCRRXh88RqHNBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeXH7BRgXTCkpCKmgAhR72Q1WvbpZbXS1SXiP6cNnkY=;
 b=QENjYabqOG0xXxCnw+4XsPFLQWgYmwqaL0TOSTKjD5n9F08+BjgNH6VQDhJm/BOyozTkdF4UasoCKw9cnypyw7f0S1sUZgqIUjAWzlz5ap00xEuioNdHtpJ71NUGqjCLxrNAKtH5Z2lQIJJUdMpThPpPfXbLJL+8e7dvlZVFc2o=
Received: from MW4PR04CA0112.namprd04.prod.outlook.com (2603:10b6:303:83::27)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 14:33:34 +0000
Received: from CO1PEPF00001A60.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::4f) by MW4PR04CA0112.outlook.office365.com
 (2603:10b6:303:83::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 1 Sep 2022 14:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A60.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.7 via Frontend Transport; Thu, 1 Sep 2022 14:33:33 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 09:33:26 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [Suggested-by:Shuah Khan Patch 0/1] iAdd explanation for
Date:   Thu, 1 Sep 2022 22:33:12 +0800
Message-ID: <20220901143313.1491951-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fad6696b-26be-4563-ca73-08da8c26f315
X-MS-TrafficTypeDiagnostic: BL1PR12MB5301:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TozokaVx0V0vwH2F6BT4TKKr7lNEpsptJrKazQpNMOASUfYXar7/VS5r3FkyN+mA7tJ4Jp90uuXg/9OaxH7OpW5OUJJhWuhCBA9BppVMrzDyejEQdOKQsMG4XrpSoe9wm6p7FuHVQh6UKP+6mmoIOURh47w2kcd5X6CJ0ddSnLuxTKxO5TkVJuWDIjyjPp5Q3TWHN3V6cznLgsprAYRODBHriJjgZw+FFVnlx7kEJd+6T39jvHgq14Wq/LtcBpso+1yKAeCp3Hu+oXuK7mzLbra3XXSfWKGqGyd4lH7jV+B6AgxuMTseqOq2X3TrI/tGeK6D++NF+6XKhydnActmims4pSS4nRcrxc5U+LUkpWPj44ZNeia/HgFyQGDduVPYqzG7Fc7yfLP32vfuk5kAI2Lr6K+CgfRMpxuq2qsnFn4LdIQ9BkHTrdmiu607nF86HNLKvY9+9kWk/Qxk/c5qmQiZ1vYPfh/P/YwA1gx5H1jYEaU4jVSV4HOZgfk7M2C1w2tdWzgCBSWwktKk6SgPxdPxuE4ZlBBLab2vodjqkCBmF7GwReQq80dI4Ghr5I/bFqniMmgXz65PxNqInbOTnbQb8DpIMAiwAITa+CxizcAdJ0/hO0k7+Dm1aXjADgR6qX4iwqqkoHBRc9Ndk50RAViorQMyXQoJpuWqXnKn1mYUygmvSO9/bgyNINJNByKa0l6hp9Vzc7jTHOxEWnV/ElChdXB6atFF4P+7SBvXq4Wc8+76FROZJGImiY9L00Ct/yFMY45JM49YxrHEZmxgJA6qVIZET8hMvt85P3feCVw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(39860400002)(36840700001)(40470700004)(46966006)(356005)(81166007)(36860700001)(40460700003)(82740400003)(70586007)(4326008)(8676002)(82310400005)(110136005)(2616005)(316002)(2906002)(70206006)(54906003)(1076003)(336012)(40480700001)(5660300002)(4744005)(8936002)(26005)(426003)(7696005)(47076005)(16526019)(186003)(41300700001)(478600001)(6666004)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 14:33:33.9252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fad6696b-26be-4563-ca73-08da8c26f315
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

According to Shuah's review comments, add a new patches for expain
X86_AMD_PSTATE_UT.

amd-pstate-ut can be modprobed even without amd-pstate module.
When the comparison test is performed, it can load other module
like acpi-cpufreq to test cases, then compare the test results.
When only the test for amd-pstate is performed, it can tell the
users they loaded a wrong module like acpi-cpufreq.

Thanks,
Jasmine

Meng Li (1):
  cpufreq: amd-pstate: Add explanation for X86_AMD_PSTATE_UT

 drivers/cpufreq/Kconfig.x86 | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.34.1

