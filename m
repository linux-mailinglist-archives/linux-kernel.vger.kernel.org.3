Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58F446347E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241686AbhK3Mko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:40:44 -0500
Received: from mail-bn1nam07on2056.outbound.protection.outlook.com ([40.107.212.56]:25730
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241669AbhK3Mkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:40:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8xWhW/Rn+gd3lx9tLlGaHs/oRjUrbggO+XSl1r3z/Mclzm4xkQyYdYhvfngsLvtNwqpBECrFOPA6i3RVzz+liEdW+rw6w44Y9npwlotxAoUBJKP4+0bhQl6Ay3xNOyqc3Gir5/ss6YRDb2tX7h+8mQQ//9BUuUQeaTQcEoKN07T6u471r9bmLtraTHnASX2AqoYifUwzW7fj9GPN/v5TbZhWo5YGqqI4Ct+SEb/6zWosA8BfAZ7yXR4BH8M/6FX99B9DMEf6pJM3ONQVBkjbmXCSk6DKpdjQsio5s+w4fCI6+Sj/AOP9ZTxo9fnERLIPfxvi5PgkwmLqXD/BL5jmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8kgyOkrddODGeP9fLYswG8P2mhNQkaTgXSoOqeB0ZY=;
 b=FJLwutf07a5xilT8W3icv/ZORC4RXN5gvQWOFhagK2QjqEAzgyrkKBD/QQAUFDgzucphLANcCYVPCz/R2FZf0JN6FF86iV5AZqqjAKmaguYndKycn3dZy8VX7ugGliPl1LbI8c2DASWM4hQ4IFZTFcU7B6IIDH7mAo0flqWQk8SW43ed3BXy8Y0jj/zmv8W4Gls4g7kFqKojH6ZckD5sdmcjLJJHk79Hl+f2v/NeNwd6tIeO22I8FXOPIjkIdlGYSkxRlURY+gUutrGFfq7lz/pjnHzQ5+AVelcM9whIvepAGOysLkwIotMtad9V8qFkN1OKQCWWhz9g6zwtwn8Hng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8kgyOkrddODGeP9fLYswG8P2mhNQkaTgXSoOqeB0ZY=;
 b=Wvim3lBvbEIzmRJZBIpsyD3e2+aSVyLtnBr/I7VlXX7f87WzlyVHHrc2m9YLhFDfXTSDxuv7p7dZTjaxRR5fRjZ0WtDy5Hu0HTxp7y82tVodHQKLbrb+8RKpLpAnvrixtpVQEMCeHEvFu5uyMpCheNJ8dBm/NryEfWIZv2JLGfU=
Received: from BN6PR22CA0070.namprd22.prod.outlook.com (2603:10b6:404:ca::32)
 by MW3PR12MB4506.namprd12.prod.outlook.com (2603:10b6:303:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 30 Nov
 2021 12:37:12 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::55) by BN6PR22CA0070.outlook.office365.com
 (2603:10b6:404:ca::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 12:37:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:37:12 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:37:07 -0600
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
Subject: [PATCH v5 02/22] x86/msr: add AMD CPPC MSR definitions
Date:   Tue, 30 Nov 2021 20:36:21 +0800
Message-ID: <20211130123641.1449041-3-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f36b207d-ed55-4cae-5d70-08d9b3fe2200
X-MS-TrafficTypeDiagnostic: MW3PR12MB4506:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4506D12E576F4D33D50C5A1AEC679@MW3PR12MB4506.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSAgXcVkgFrr6Vby8ZlafW3PHqLol0sOJRZdUijqp4+3amJZ5aWw1dHmKQbqHC1cfjs2XKhnU8wlJAZd6ALojFHj1Mo+LaE8H1t4YHAcFBBhYt5jb74NWiBsOSrnt9cHyNlEwWYKkWaeP6jKjXsJmpUUAK2fBvoWgEkyyMVfgIgTmglcPgBooNgW5r8+TxzHOFyhRvcFTSk6AoZ8gKsHWjfyZcSWXQlmqL0J6BhdrmXOQVZ+BvPTKGW4jCKpg5da94FxKguW8+TQechKFXkjb7Nk1uuSp7v5Y9NopNoVY8igPCJWC0qV9ejN3eKlGqAqrJmd3etY567mYAfMSeF9w/Bha6N0RmiPuq4crsA8FzRBM4z7ALTh+dxs8H6hSMRRy9ajIQe1iA6EqUJ6hxmQWV4shkBpNnMlXcHgvJZ7QaNDg/jsNhloMCZ+9e9d0wbLEo8Lm4C1zIdEfmjVZqspMNAZiooTc4hOCDikOFTIuiMTJLqVRcxgOKBgVH/tn7BkUfgqH762xLZ/l3AkinNPk5LnHxXPFjQi0MgIaCKcFe3CGrANeztOt4tLUYZi3IayvGfeFmz0d6tSMi41Ezh262RS/cc3O4BQ5+5gI2yPWZ7eZTqVOwvJW44ra+W7ptTIesB5T76RcQfCGB8NEqanpujXiuw83To9ojiSLYIwrJAwwcleRwzfZ0Iu0RElEsjeJwZ7kfLsmYspCTtUlM2P+1xaj7cwwXUpTlQiYf8w5M1cmVgHZgHYDA2Hlt5ldzkok7/5OIGIKRFS6x5gSFxedv/xm5z9L2rPhcdT4Y384ZI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(82310400004)(47076005)(7696005)(54906003)(508600001)(110136005)(36860700001)(36756003)(86362001)(40460700001)(316002)(356005)(2906002)(81166007)(4326008)(16526019)(70586007)(70206006)(426003)(336012)(1076003)(5660300002)(7416002)(8936002)(26005)(2616005)(186003)(6666004)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:37:12.2710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f36b207d-ed55-4cae-5d70-08d9b3fe2200
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4506
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD CPPC (Collaborative Processor Performance Control) function uses MSR
registers to manage the performance hints. So add the MSR register macro
here.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 arch/x86/include/asm/msr-index.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 01e2650b9585..e7945ef6a8df 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -486,6 +486,23 @@
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
+/* AMD Collaborative Processor Performance Control MSRs */
+#define MSR_AMD_CPPC_CAP1		0xc00102b0
+#define MSR_AMD_CPPC_ENABLE		0xc00102b1
+#define MSR_AMD_CPPC_CAP2		0xc00102b2
+#define MSR_AMD_CPPC_REQ		0xc00102b3
+#define MSR_AMD_CPPC_STATUS		0xc00102b4
+
+#define CAP1_LOWEST_PERF(x)	(((x) >> 0) & 0xff)
+#define CAP1_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
+#define CAP1_NOMINAL_PERF(x)	(((x) >> 16) & 0xff)
+#define CAP1_HIGHEST_PERF(x)	(((x) >> 24) & 0xff)
+
+#define REQ_MAX_PERF(x)		(((x) & 0xff) << 0)
+#define REQ_MIN_PERF(x)		(((x) & 0xff) << 8)
+#define REQ_DES_PERF(x)		(((x) & 0xff) << 16)
+#define REQ_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
-- 
2.25.1

