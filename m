Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867465A9A70
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiIAOd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbiIAOdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:33:39 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2071.outbound.protection.outlook.com [40.107.96.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141895F20C;
        Thu,  1 Sep 2022 07:33:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNL6Dm0keavM2lQbln4Vi5T0IfhLSJpub/ocobvr9A8BdaMzHahPvB+PPbe/uu0rQOjVL4s/XPXKaXXsXmFyt+vgPOVAE5JSByKXvLYx1/cAfHQVnOS4i6crauk8ho9ROkpSNc8iFrJdiOA+hIyFW/Goer6rjMQdjKoQfS7XpKigkWVw6vQAwFsBklgsiOLwv6boUZ/jALYY9vJvrgP4JXpMSIgZLr4im0hzaN90RZ9bimbtUn5XlX1ou87uBPvWsGDs6BqqZWMd5OZvmtrNwz5y8co8H6clPvds9EBlxBya5VU+wy9WfFYK7OwWyFkrCnfnO/fSUzv4x0ifLUo51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjpOsNB24bsbE2XZ1RtpKQuk8WQ3/mVz/1WHwUfhYA8=;
 b=JM8UkXp5AURDwHiIcLYZKp35qfiL9bzy8LbpC+lR3vm1jGPjJHM1OtBg0zjfH9kPFI8oZKjfhWZNa70cN1PlJVbRwYRqODeOd+0ReFd9m7ZQF4QCc+zR/CYmXNdbv3sI5uoMQHCeFTEubncR9FZpXAIakKmoMLHSvJ175zkE7NJ5T0AhMRiByHdv202PeMY7cAAV999GZA4mq69djAWmYPMTM61gWElqYe6s4beou0d4Dry2LEP6bsSn3rjMY+4AbcyZMEPOf7ihU8bWf/s7BMytADLPeTe+E10jPAWBMh9sZrcIZv+Hs5h1CIqNNZ/whr+2JH2EnWfFpn9mrzscTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjpOsNB24bsbE2XZ1RtpKQuk8WQ3/mVz/1WHwUfhYA8=;
 b=OjyZXt4F+aSB4/D5uJ3R0/CZsBq/tCRskF9BV+772KNUpnEN5mhbV6qh+7wRHjOvyKaTXxYPchVTHj1oiDgakI2rhzeT7an25Yd64c04onLDkrosmA1h3riquIDoFZDrM2BqbN8BpagLFD7T3egufHplYHEmE7mCxD2R1Zzx0Og=
Received: from MW4PR04CA0110.namprd04.prod.outlook.com (2603:10b6:303:83::25)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Thu, 1 Sep
 2022 14:33:35 +0000
Received: from CO1PEPF00001A60.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::d6) by MW4PR04CA0110.outlook.office365.com
 (2603:10b6:303:83::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12 via Frontend
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
 15.20.5588.7 via Frontend Transport; Thu, 1 Sep 2022 14:33:34 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 09:33:30 -0500
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
Subject: [Suggested-by:Shuah Khan Patch 1/1] cpufreq: amd-pstate: Add explanation for X86_AMD_PSTATE_UT
Date:   Thu, 1 Sep 2022 22:33:13 +0800
Message-ID: <20220901143313.1491951-2-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220901143313.1491951-1-li.meng@amd.com>
References: <20220901143313.1491951-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0de4e50-b735-45c8-c548-08da8c26f391
X-MS-TrafficTypeDiagnostic: DM6PR12MB4466:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M864fWAHq3yuiHvY1z3DfZjAD4tjKh+ZKquZ/v/etib/hCUmeRKlGiIjCkf1RZFW4JJmZQPBu4EvmkPr2Ua/CnM4+pc791NkFU2b+RzO7bjToeIZ3FmfcKGA3MO/vTDV9d4K7wbGF23QAsv93n2QW8GiNqLFsOC0yy7Emz5eYUQ9Afd1TIc7wCZklnKb5WB/k/P1ajGiQuq9sc9RiQCcgaTUfe2lB++29soTUA5TYesEX87+Omg+qtp4+HwQDM5Ag+rc96AONRj+H/Q6PY3IhQ9eNMZMG1i83dWc8Sr9Rly4ziFWv1QLad8OF+4O0RCgQd5OsGaC0DqsRiD4YWJb7FhjRqKa5JPfxwbWrE4F3Jkvq7SaA3g+sluKV+VQQnCvLY5XpRgMYp0/xeKIp+aaNTYofjf31z4tZ6VP3YS28qF3j/jkhOzotsZvDCj5Van5RGlQQ/qLY81hntuqwz3yTAAzXUuugGyYm4gZv5joLo5Y2Z7GU48Wf2Ug71bTjHXTzfzlzL7QbAkz4N0FKbQlS8LNm8hq2jZSnFr2XoMEFjV0x16yAggKdJ6F4fQINGRCnMJJCt39UoChCfyRys0hs+OlDtxYZpcQZwg2XPKNyHtMhh2J2D3nKR9Kvgp3GIoMER7L/ggmpBEt4hhjeESEHGMiY3nqc57HkohKgNDxbLiZVo4l57/DvSc4EUs+Wa35xVv6HHjDtOCappC7INMU9u4vpQPAjWxYBujNt6pYqo/6hdn6ZYEDajO3muX7k8tH/7xLxGCo9qYq7hzsNY9QnXUanPA37pduffDyfmAXlfELphcHHzcRAhFkektzAukr
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(40470700004)(36840700001)(82740400003)(7696005)(356005)(81166007)(47076005)(336012)(186003)(426003)(16526019)(36860700001)(2616005)(1076003)(6666004)(8936002)(40460700003)(2906002)(8676002)(4326008)(86362001)(5660300002)(82310400005)(36756003)(478600001)(40480700001)(26005)(41300700001)(70586007)(70206006)(54906003)(316002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 14:33:34.7377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0de4e50-b735-45c8-c548-08da8c26f391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This kernel module is used for testing. It's safe to say M here.
It can be modprobed even without amd-pstate module.
When the comparison test is performed, it can load other module
like acpi-cpufreq to test cases, then compare the test  results.
When only the test for amd-pstate is performed, it can tell the
users they loaded a wrong module like acpi-cpufreq.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 drivers/cpufreq/Kconfig.x86 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index fdd819069d72..fd1582716c58 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -58,6 +58,12 @@ config X86_AMD_PSTATE_UT
 	help
 	  This kernel module is used for testing. It's safe to say M here.
 
+	  It can be modprobed even without amd-pstate module.
+	  When the comparison test is performed, it can load other module
+	  like acpi-cpufreq to test cases, then compare the test results.
+	  When only the test for amd-pstate is performed, it can tell the
+	  users they loaded a wrong module like acpi-cpufreq.
+
 config X86_ACPI_CPUFREQ
 	tristate "ACPI Processor P-States driver"
 	depends on ACPI_PROCESSOR
-- 
2.34.1

