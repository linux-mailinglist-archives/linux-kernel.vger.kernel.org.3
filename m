Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A190B4EA4DE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiC2CB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiC2CBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:01:47 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207185FF00;
        Mon, 28 Mar 2022 19:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLHGNfCckfEvDu4pLyahTquwLadNvqyU8EJWByyzm2e4cij0c73IPVmn1i8rbc2yO5YNo5NQcUQ5np6LSmumWmpr6qw5UObiIBt6lhbiUzP3o6SoHU66TlvJpH5H5MJzFJsYKaMfvL82JtqjmQPU+zuuTWcst9FJTeJCQ16BeKZtFMTDZ84G31xSeySZGMFeBFd9v12oKuTOuRkEyoDFZIGb2ioNGiXkL4FeKsG0rpkUbC3OV5wbkVg3QvJTUYPvtBdCN88i34IWXIwRdg5c/QaunjqChR9HpPIVA8YR4ReW74f8dGaZ3ba3RNypblv4LIYSRQA1yxrg6XPHkfgKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2o9TYKYWmMlrLfYqR1q3xd+ORprXeP9B79TT0Dj/pzw=;
 b=P+VNsSa8lL0NON+IY5PX3WqKFRIdoBLCW8RrRyM7uuoCe/W5nFUh4BjkESov91lOnW4FN9K261lPJ4bLVNPc3JRQbt4emBnRv/bfhO1sz/zDSyH4HsneS4UdqFc3QcFVC+EeRP/WaHsaKjHGaRRXOALVqNjQ1Pug2HfMcjTKxs54vn/k83+lSi8FJw872rYt5ZA/iKPIHG/3EtVzvZlJ//uv4dxS87oKh0DuqcPaEXoY4MB373+DKqTdJjFDJqHu5KaOD8tmBfVrH/1KV0qHCLnqjbY0i+16b0CuMi+Tl+L25INiG/9Y97FocF4wRVzxBLrljk/oyKUFRJWzEx9T+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2o9TYKYWmMlrLfYqR1q3xd+ORprXeP9B79TT0Dj/pzw=;
 b=ewy6Q2wIR1Pkc74xasAKE1NUn/x8WvCh3hRTfkLZ8BqTvhIKfkIOCCUBff/iZdTPtvoytWZoXprma8ba6AKwKDijKSOhN21HKEcWU3R1gQWDrs8Oy6hWdccbeTMS4/ynFPohXvlH+6XzWvEwLLJxjBgDgAoZ2nBHXii6H7thnmU=
Received: from DS7PR03CA0250.namprd03.prod.outlook.com (2603:10b6:5:3b3::15)
 by BN8PR12MB3074.namprd12.prod.outlook.com (2603:10b6:408:65::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Tue, 29 Mar
 2022 02:00:00 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::3d) by DS7PR03CA0250.outlook.office365.com
 (2603:10b6:5:3b3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Tue, 29 Mar 2022 02:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 02:00:00 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 20:59:55 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 3/3] cpufreq: amd-pstate: Add a module device table
Date:   Mon, 28 Mar 2022 20:59:47 -0500
Message-ID: <20220329015947.565-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329015947.565-1-mario.limonciello@amd.com>
References: <20220329015947.565-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3711fea2-8d3d-4756-71db-08da1127d538
X-MS-TrafficTypeDiagnostic: BN8PR12MB3074:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3074C54466486507014F939AE21E9@BN8PR12MB3074.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ImQ6dfrjCR+IK2dKE82TRnunh5eFKlXCzExYjsqkRoQUVAWefM98tHk8XKAGfPv1CgBJQxYMqzceMHWA4gMSVWCwqR8V2etmvfcE9rYzKTrHtVcJkb40kZcV5IUevajX/rmP074NsFowe6TRnzRsDX53vrTINvthjV1oK+xNFi6ncrpnXRqM/6r/pJwjNpxar0X6pE2pOJyUOnBhOc9SQm9gbqPsQl+jI3grJCavC7T8AlJXE2PZVMv5PilHJqYhqbPr/RX1sPlGgTYzZ+OZGBVm8jhrrMu5Pg0GoL5FVXaoRkUjLJy7tNOyYKT48fHeDjqkL6V7yqMF3CV5frGOi4VVjVE/CncIY1EXFABXf0Gy/+erbCIVC607mDU8cSebVTLNdSukDXuWvFOqtp8SeMOYJEXBvSg9uyUFU5IbRTNCtS229vmkXvd4483KDbJoHvThSy2cGf3u7I9AcBCZRXRJuRadzh/zGaOjcYB9W7ji+7XXWgN4RXSxHpLvoHUQDjCQmghwSmqg/bdp9KBzhnn8raZEHHSomA1876f5Uo9zbJQPpFuY0Qzs2WEJGxZWunQMPJ3aONQ+cGzmrQ0dGXD0KAYza8gSoJmUb+5k+9YX+RxfSO+ZmpUIt8p4CktZD7xHXhrtb6JlNJ+2/QOK6U7ohK5bfG3Lwfg9cEVewW47r6ZVJX5czidcSdaFNtc0OpI/w7O6V8pfug9CmTZjwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(110136005)(82310400004)(54906003)(508600001)(316002)(7696005)(70586007)(70206006)(4326008)(40460700003)(8676002)(6666004)(86362001)(47076005)(5660300002)(8936002)(81166007)(336012)(426003)(83380400001)(36860700001)(44832011)(2906002)(1076003)(36756003)(16526019)(356005)(2616005)(26005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 02:00:00.3895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3711fea2-8d3d-4756-71db-08da1127d538
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`amd-pstate` currently only loads automatically if compiled into the
kernel.  To improve the usability, add a module device table that
will load when AMD CPUs that support CPPC are detected.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Add comment to indicate need of SBIOS support.

 drivers/cpufreq/amd-pstate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 7dc2e344f222..9f78849654e7 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -705,6 +705,17 @@ static void __exit amd_pstate_exit(void)
 	amd_pstate_enable(false);
 }
 
+/*
+ * This will only match the HW feature, there still needs to be appropriate
+ * SBIOS support, so it's possible that in such cases this causes a module
+ * load with -ENODEV as the result.
+ */
+static const struct x86_cpu_id __maybe_unused amd_pstate_ids[] = {
+	X86_MATCH_VENDOR_FEATURE(AMD, X86_FEATURE_CPPC, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, amd_pstate_ids);
+
 module_init(amd_pstate_init);
 module_exit(amd_pstate_exit);
 
-- 
2.34.1

