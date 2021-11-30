Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18333463482
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241701AbhK3Mky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:40:54 -0500
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com ([40.107.244.72]:60512
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241674AbhK3Mko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:40:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1PKZLMxUUJhF7LCIVJp3fyfVE8gYjpHmaO0SsVF3Li3p0wn+mMj7toHHWQIUlpg9NIl9EJUbSAiGp7Mww70F734KQX0m5UmA61R6P8jo6v1BLZgGwcH4lSg/1BM8iJs6P/vMEUVoOXJ9c8VJE421zWxEteGDis9520r2jKr8Us/+0i2VBLvpNymzoQUKLg+iUZKEjOd4Sm3T2on/1stBcr3jnCfgqDnh06fj46eIiPveaZEDVlFTdhPfi69cNPmJ/iDil4n3gSZ/6GZDNpAY+WCV/N/PIn8rwffUZOfT+LYeWLV6OXir2fFndYSJE0TAxj0GyXxKH8dcsBAB0A87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmrJdogSFnhgOG9FgwOU58MPcseoeLMGB3Z6ARKq1WM=;
 b=WcZBRjz4wNE4R0jWp7dPVNT4wahb8II4SBgDWjDIeKP3d8jaDW6t+U0OqEPNxpCneP3mGOlTll0hiIWKk1xZ2Za8P3KS60IRcobMJz52MNzHNOK1hZ/Yc+2wcKOEPOLvE5jwgwS93npiXGjlGWFt4Z611/YFOEf3Y1UP7Es9S5Q1ehloqI7OGF9KYDInqAo/pHZn7Z4adJ0b2Bgk/x1RpulU0r/ovQ5CRkZHNv+F28pyixFOxcMVMJtokfMS8O+dNiC9CmsdYYpY1YI851Sn+tb/nkeU2RyhKeMA7kRvrs5XYKPKvqguvvAUZBPE1WlgOSLv97mgnx8mIMxTeL5o9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmrJdogSFnhgOG9FgwOU58MPcseoeLMGB3Z6ARKq1WM=;
 b=VGiBNw/YAOw2ebf4ibq5J5FfqESwo8+MvBMO/257R/M1pHpH+gabhGYIkZREdx7b7YdbCNfYNpodQqoBV/EqHgeEjyNTRJmsynQFCFGp76LPc5Wus6XIZFoXX0zI+qgpKQ4Ki1nMpBzirj6+13v0XSQYuVNAOFMMLg56C8X21wQ=
Received: from BN8PR04CA0030.namprd04.prod.outlook.com (2603:10b6:408:70::43)
 by DM6PR12MB3051.namprd12.prod.outlook.com (2603:10b6:5:119::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 12:37:21 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::1a) by BN8PR04CA0030.outlook.office365.com
 (2603:10b6:408:70::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 12:37:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:37:21 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:37:16 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
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
Subject: [PATCH v5 04/22] ACPI: CPPC: Check present CPUs for determining _CPC is valid
Date:   Tue, 30 Nov 2021 20:36:23 +0800
Message-ID: <20211130123641.1449041-5-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211130123641.1449041-1-ray.huang@amd.com>
References: <20211130123641.1449041-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 728a1f63-7c0a-4825-52aa-08d9b3fe275e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3051:
X-Microsoft-Antispam-PRVS: <DM6PR12MB305110520054FDCB0FCB1715EC679@DM6PR12MB3051.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HRAoRO3bkXg7GQhvdi5USBXu58MlyxgCOTUWhhOJGJdv6EG/Oo1NOcz6ankgr+dh4i4fjH+kKJvHEDtkzLGOOJgjcxfMxtj/H0ZuxETaVTCeL0iIcZpFICLG6KgtJUOnDcvYiIq0ha5r3H2+/ShLNfkHehkZMAUFgBi+bDSMK1DMct4XBbtWnUkwgFwpOEou1xJqRQmS2JqpuKIt3B5hNRgtrgCnFqFkS6U5iDtIDK21ZqsVrw43j9uQ+cPX+MzK3OY71N2H0MngGWUwLBTNB8TMjIcZGvyWqlyvm5OGj3VVihBkrN0RGsHxwKrezHgafaK5UZinoq2p72v1Lx/x5QRBx2EaAtNVbtW2sen0qhdPwHtJmsPRCnYw2nrI0j8VMyC0HGHZK6NryHfQTy2R6ILz4OrQY8PcNeW351ArU6giP1F6iXgDXrot7heHkVlyB0qTei7vhfQQRZqH5VgfmFxnwB812jtVAQ16zhYHvuZPonA0YcAvWLZewB2gjltXOdsrlpuh0UQvQPooddI+W1we+LP42TD18pbX1cn+o6VyJbHmzZN5YguS2LhNZyWSSLZB7MQxo6VBM/+SyXHy1/eawW1pnBJOnVCZF2jjvkLkzgEhtDM1UadiLYWjAQtnxCxrkvzVgviFMDGB+byeS7SApiCrjFw0NYWQs+/n14e6tBpogWltVyC1yfgU9d/407a6pXIhSn9ftwfwu1kag4+VQGLwO5L0wnsDERPbUn4P9pHjk1eFkEMtlR/iLMK5yLmlPx3xJI42pvMEXlyZymsBTFX/06a9g7EwZ49/wWM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(186003)(81166007)(83380400001)(70586007)(6666004)(36860700001)(82310400004)(4326008)(36756003)(508600001)(2616005)(16526019)(26005)(47076005)(426003)(336012)(7416002)(1076003)(5660300002)(7696005)(356005)(86362001)(54906003)(110136005)(8676002)(316002)(8936002)(2906002)(70206006)(40460700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:37:21.2744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 728a1f63-7c0a-4825-52aa-08d9b3fe275e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

As this is a static check, it should be based upon what is currently
present on the system. This makes probeing more deterministic.

While local APIC flags field (lapic_flags) of cpu core in MADT table is
0, then the cpu core won't be enabled. In this case, _CPC won't be found
in this core, and return back to _CPC invalid with walking through
possible cpus (include disable cpus). This is not expected, so switch to
check present CPUs instead.

Reported-by: Jinzhou Su <Jinzhou.Su@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/acpi/cppc_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index ca62c3dc9899..a46f227dc254 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -411,7 +411,7 @@ bool acpi_cpc_valid(void)
 	struct cpc_desc *cpc_ptr;
 	int cpu;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
 		if (!cpc_ptr)
 			return false;
-- 
2.25.1

