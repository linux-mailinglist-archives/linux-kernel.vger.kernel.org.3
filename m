Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039BA5598F2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiFXMAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiFXMAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:00:13 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BD36F7A3;
        Fri, 24 Jun 2022 05:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDDcRZ6eizcMwCoDDpPOskdeBhZMBpXRa9TbwOXyHA0idyQx8bzsfCUrK0LNcCsVEdmC0okuZL50uWepDPDPAvhSdFbYjHePsucb440r2/SbThsIrCfjQ0fQ0LWqYXxhFJcnWaddu2nUUqkuV3HRggJ2MrdeBSQLVvOiYS+Mgomjkt5TDy0RVAWCWhHOeVqsrJrzKxA9RDmtzhpuYEfOEcvGk5dGRDFDH5bo3dNu8pSv+xSN6FBiOVhrQaSB6rhlUDPO494f+335txUvc61GPH7TuMDh1R7tORHhbWlEVQhOqL03rC0IEsOiZXAcx2YxSzYqVYSG70c2SDh/MbUd3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRtZPd9wsZ/Ox8tuYJn4oLK0HiH3a6yfv8EaNw+9Rwo=;
 b=c3c9nakIu5cB+xgawo3tXkYXYubtemaLkXySKmCwM4w1Zm9QOM7/jWXnh5dfG0qIlrNCf7N8fAvv9q+ipQh2cf7XC2YVvJGKMagTUWQUXXqp0e3SIecbWBMjTgkhSk/GV5CPfltLNMyjrP3KFAeQyy0ap+2jcVAudysYUnU3T30brJMQb8c4Qr7oUxlmAcjpIbcQbopX+FKpjond1VZhuUMgh+X96jdML/oWXX1fc4MnIWOzfYhIUYaUnKRKRvXsDZfXRZdn7K2ZaIT2N9geZhykRy/4eX7HUe4HlINZtGh1B+NAvb7QIt1pa3ypQyDJKYQb2ir0L1T8TnNOH+XF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRtZPd9wsZ/Ox8tuYJn4oLK0HiH3a6yfv8EaNw+9Rwo=;
 b=DhCneliBuPXLJOqeBet7HWiZwXeWUy7dhYLV9+AMppR2Y+apRPADR/XukXdshnxeRsJzSmyvGBzgKpaOaiDwHp5kgDjwnvPz86u5a+gs8fgsV04oZAhepzZMQTYUAzr+wHM+Igm+gh0ZDMHb12HraUd/z2kNbsDw/NlwMYdac+Q=
Received: from DM6PR02CA0046.namprd02.prod.outlook.com (2603:10b6:5:177::23)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Fri, 24 Jun
 2022 12:00:10 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::d9) by DM6PR02CA0046.outlook.office365.com
 (2603:10b6:5:177::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16 via Frontend
 Transport; Fri, 24 Jun 2022 12:00:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Fri, 24 Jun 2022 12:00:09 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 24 Jun
 2022 07:00:04 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <Ray.Huang@amd.com>, <Mario.Limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Huang Rui <ray.huang@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Nathan.Fontenot@amd.com>, <Jinzhou.Su@amd.com>,
        <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, "Perry Yuan" <Perry.Yuan@amd.com>
Subject: [PATCH] ACPI: bus: Fix osc_sb_cppc_not_supported check
Date:   Fri, 24 Jun 2022 07:59:40 -0400
Message-ID: <20220624115940.272422-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa57c60c-41d5-48ea-e2c3-08da55d91651
X-MS-TrafficTypeDiagnostic: MN2PR12MB4301:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VxQBE16Y9oZtRQd84qX2uhaUYln6fEtLcDb/G6fr8vYLJqFIHF4UmLgumvwnqsD+gRn+/XZN2F0rBbSKbNQndC+cu5EGFrY/+GTMJ8/yZy9vm0AwrbHsu3FDpOBOJXxEqYw4zq7jjcSCL5ZTQ1Z3SPzVUNs4YypC5ILJ7F1050q6mNqTAvAwof+CpjtKSvG/g1p4Tdq9ZWP1M3PLNumSJuHSaXRwVzaqeRy0LokZouIx/yiqY4nzLZUNPoAbw+AeRDXybYZMx9AOUVR9HdGxrfuilKF1+b5p0+HQg1UoCQBNDz5WF0GQGH923ZkuykhuWNt5N3IbMDfQBc9L0Z+TCXDfkgGs0dYVI9E4vOLC3bhMzqLGPX107FiltimlMrrtO+Pt7/ak7fCQXnb+WFB2fFtCLmfTX2O6eGixqZOGy8R02nDv850ay64l3rymOym6JKg8Pv1sTMSN5ZkMjRIjtgfWoH8xK+HY6XIDPxrudWEwRtkTNQiGWalJXOnAAcQOcs4xKFPsuUP30CFVnQP3ZbqPM09G6R2MWkC/n/tgK9DEpv95vI4cLAxu88y7bJWdqAzDD1xvh2FVffoAot3zIwI+e+PlMVp+dyzGXQkVWLv2D1VoXU8l6BCSngT0w0UUdRoJTDH4a+PnzTVOlPKPR51aB89YpA7k3glKwIaDF2jWTis/hKuKGbaY+DQo23PJfor+tKor71ERCwAm9luGT9ve9bbDqGBnmXQlOZZ8iMlGqFDDR/7H+Pt+gaQqCdqp+piwAfenfhF26/AjcoSKhVjuC2szvLEHQnUITNMxzdzzzDKvlW4lChJMLZxexkTPGtQGgUlNiFy9eEjaJjO2Kw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(346002)(136003)(40470700004)(46966006)(36840700001)(47076005)(336012)(356005)(4744005)(83380400001)(40480700001)(36860700001)(81166007)(426003)(316002)(40460700003)(110136005)(8936002)(54906003)(41300700001)(82310400005)(2906002)(70206006)(8676002)(70586007)(1076003)(2616005)(478600001)(7696005)(16526019)(82740400003)(36756003)(6666004)(5660300002)(186003)(86362001)(4326008)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 12:00:09.6138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa57c60c-41d5-48ea-e2c3-08da55d91651
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fixs the osc_sb_cppc_not_supported variable checking
Otherwise the cppc acpi driver will be failed to register causing AMD
pstate driver failed to load when calling acpi_cpc_valid()

Fixes: c42fa24b447("ACPI: bus: Avoid using CPPC if not supported by firmware")
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/acpi/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 4d7c51a33b01..9731e4a1e338 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -359,7 +359,7 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 	}
 
 #ifdef CONFIG_ACPI_CPPC_LIB
-	osc_sb_cppc_not_supported = !(capbuf_ret[OSC_SUPPORT_DWORD] &
+	osc_sb_cppc_not_supported = !(capbuf_ret[OSC_SUPPORT_DWORD] &&
 			(OSC_SB_CPC_SUPPORT | OSC_SB_CPCV2_SUPPORT));
 #endif
 
-- 
2.25.1

