Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FDF47A165
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 17:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbhLSQhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 11:37:12 -0500
Received: from mail-bn7nam10on2072.outbound.protection.outlook.com ([40.107.92.72]:43744
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233242AbhLSQhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 11:37:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgRxyIV/BawkyROCGGvU3gMwYDthCJqMke0TNp2ytZSwqp04UC2XydO0WAOiwVBlePVzIOsVi7/yPEXHylKPwGbhA4RLOeYp0Fcxh2P0/P55MxbdkzYm+hjd8PmDU4fYUkVZEqBbSWptVUB1xCiNB+b5tKe78i5rBkNTGW3fvqEJIR75UcbRUl8y54mfFrdlI/lRz03pOrL7+qr7BTg7bVrF0P82CjjYjjkl8m9L08ll7VLOuRIoOQ7Tnz+R6b9kiY0y1TcDL2Ic7M97Ipr46eWai/VnOY0I3TbLM5dL4X5Ip0K73KlREiPe8/rC0BZhXUbc1EHo1JVEIDULMjKrXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/LfjMYioRuigC5rv4WSx+ehE7yjhQnxsEcC3qCNrDc=;
 b=i3CNcPExjJG/3PFX4RmsB36GTyjnCtIKrLMyGZJ/pz9nZ+2cdrLUrNLCbRWPK7fV+rgxov97gks1QcKvw4W6BlCcUGrHx03k1TTotYrW7h4q69pWJYYuFe4vDwHSjIthYk0XZ9jbK8HD35hXGk7mYxOMLdefOPmaehNEt4bLwMN52EtWQ0cg5mNhj9uDQnN/Zq8CNYJfceLRaM79DlvOZKdHFe0CT5fH9qC4o4/famfWHURw169i7TpgjC2VfN7TXfFhsZt82E1kvyHua5InUZMHX56BhD+x3vMokKovy/HCWPId7YZdb6/Ap2jEWyNr2ATrHkItpDJdIEyHZKDyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/LfjMYioRuigC5rv4WSx+ehE7yjhQnxsEcC3qCNrDc=;
 b=w+p/GMAtvdUf1Z1Nfj43JS97azgDCh6GKKS+VCOYeGGEHNuhHA7wEhuDoJYMvxTq9xvbtCl5aH5PgRSxWD9M0rJzOdeQiBONQbN2uxfxN8pHR3W2KE4xUtX6z/IFimo2lWEleWr63b4es/oKXiYEGlQbbIQ93GgDEncds2thu90=
Received: from BN0PR04CA0041.namprd04.prod.outlook.com (2603:10b6:408:e8::16)
 by DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Sun, 19 Dec
 2021 16:37:04 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::32) by BN0PR04CA0041.outlook.office365.com
 (2603:10b6:408:e8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.16 via Frontend
 Transport; Sun, 19 Dec 2021 16:37:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Sun, 19 Dec 2021 16:37:03 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 19 Dec
 2021 10:36:59 -0600
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
Subject: [PATCH v6 14/14] MAINTAINERS: add AMD P-State driver maintainer entry
Date:   Mon, 20 Dec 2021 00:35:28 +0800
Message-ID: <20211219163528.1023186-15-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5b910686-adf5-432a-6b5d-08d9c30dc9e1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4516:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4516010D0FCD979D5A189F84EC7A9@DM6PR12MB4516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: msZLZJdgT2VA9K8OU4KVxiQgWMBES1otf4jccY11RdkhN7NUABhNPf188D25fkjs1kBCUKfDW3oFcpg2ADzO/zjbLO2M7RdPO/XOfLAwAN2RLGjEvcSb/Q/Z26l5mMaWvIboHhjsXBWniwgpXsRv20zcOzax2oGFgx+lqWD5Sny9HBMEcLnYMqoGEJOdjYkf4h2iwGPmBMTB34aKnoOC/vDjhNT/m3OW10CGGWO5wdkxbIVACvhmTx9U4lxVk2UTeLLxrdCR04V+VBO3UNXuVzL9NCotNw8kKXlc13ikdqNp7wHAZk0LGtm+BnlvRcSDKIY8qlKLWWThrzjyWIEwBUpAmRLcJ25oBBqlIircqefT0JEtbxloA42UJwIMqxzhfT4E0wnfFbNEYIC+tFmlzsem68peQVPFz4jmImOGU5flWsno2sIzDDOr+KGE/k9UPSKW6Ddf7HB7qMr+U/YCV/6OZ9f5l4EeesqUn2eLMHGUwDWNpKa6GUTmXlEMgNxHRN461vv0zyYKy26bf19ygF7EwEkfy+q3dKfn55kBm8eqdxr05GfEgr36WLLaQJ2qquzPr0euCOw7TiEbJoWnBMZhflUcbbz7IUZ/eZgH7RLnim+MdISgBC0u9fI1jUMMrHF18jVZEHsVSB4zTqLTiBeXQY352yKA547wO79WIQQ/Ntdn7+M39Q1OaLYc5JB+XK4wK1k7i2z2frsf9Z4dsYEORatYB24iM7Aj27eBtwYFQWSd96zGXmZNgQYCtxHdR90YsxdYS6a57CuWbNEOzb7soX2AEZj0SAw2Igqr5so=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(8676002)(16526019)(966005)(356005)(83380400001)(26005)(8936002)(508600001)(4326008)(336012)(110136005)(54906003)(36756003)(70206006)(5660300002)(81166007)(70586007)(7696005)(426003)(36860700001)(2616005)(86362001)(4744005)(2906002)(316002)(7416002)(186003)(82310400004)(40460700001)(6666004)(47076005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 16:37:03.8151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b910686-adf5-432a-6b5d-08d9c30dc9e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will continue to add new feature and processor support, optimize the
performance, and handle the issues for AMD P-State driver.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe347675fb5c..8e0666a552df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -975,6 +975,13 @@ S:	Supported
 T:	git https://gitlab.freedesktop.org/agd5f/linux.git
 F:	drivers/gpu/drm/amd/pm/
 
+AMD PSTATE DRIVER
+M:	Huang Rui <ray.huang@amd.com>
+L:	linux-pm@vger.kernel.org
+S:	Supported
+F:	Documentation/admin-guide/pm/amd-pstate.rst
+F:	drivers/cpufreq/amd-pstate*
+
 AMD PTDMA DRIVER
 M:	Sanjay R Mehta <sanju.mehta@amd.com>
 L:	dmaengine@vger.kernel.org
-- 
2.25.1

