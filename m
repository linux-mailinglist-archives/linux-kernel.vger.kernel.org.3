Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4638F56291F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbiGACeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbiGACdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:33:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12B86052B;
        Thu, 30 Jun 2022 19:33:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKoPTIUbNkALaYLO/ta9WfdC3U27Fff8DETsCCQf1IOiaZiihzPSkrPvfvPpwi5aW6suIIE2jpNsHBsYcZczJP90PlGR7+OiWC9jE+ylvG7WFKDHrYb9ov31ui4AEFKZtU9eB4jIilFUU4dDLscPRIkcDM/JzODtHCaRZYBCL+yHU2p8tQnwYY7p2N00OQ2sUkW3q842R2Xqd9IrkFY4wvRSN3WbMZlqa3/Z/dheMTK+vxU1W6qo4a59IqvsTNIoNEWu6kul1/6Mbx1zRE0snzLA0YaJGqhQDmD7mSjnn6KbJnVLshVRHQ1qVM32tS4KVWeMRHRDg+Omr5XYUg6mMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcQ+c9Vx9IWaoX5Q4p/A1m5l6ISx8PTZ2lKytNI1+Sw=;
 b=VGH7IZsmCwr6ORZ5DUj8NBuNjcYL9xiJzzINeVcf4zkmTNicpJuMKznSWlVvE3z//cyVO7zcIy19CKonrxYZ3cmufE21nmtkUfCjdzJmrPwoe04DJYXo55i/Mbwz1HSjheBk4jM1P9qCkmGlrOidSlrod5Gu1RC45SXgFfcxtPoJ5vy6Pk7rsYQqxwFWibUC94ca4o9tvykXcDtqbQTsL5kqjc59ByYqJRsMQMW2dlV5E0aGFgpnf9mc2Ze8KAi0rlqJ12PZ3n5aAhCHRrIrnDUyGxgyg4ViDwLW17g+UvPGHoEhjSOQobvDivVc7prq6jNlYHVlhi3wyKnvGZqJsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcQ+c9Vx9IWaoX5Q4p/A1m5l6ISx8PTZ2lKytNI1+Sw=;
 b=jBTSmvuGSa1DsuSFV0AIUMW9D0syjGd83ZpNRNa83mw5JMhALqj5mGR0g06ieDBgWsYrA+44HueYVnWHVKfzlskT6+EGfOEVAQdahUwrbGUeMELgjRFfaCjHFFFXQHuA0h1Yfw4qnMLenhCaPNuynaIvP8Mu2AsiIgFHeNjFUYI=
Received: from BN9PR03CA0981.namprd03.prod.outlook.com (2603:10b6:408:109::26)
 by DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 02:33:34 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::39) by BN9PR03CA0981.outlook.office365.com
 (2603:10b6:408:109::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Fri, 1 Jul 2022 02:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Fri, 1 Jul 2022 02:33:33 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 21:33:32 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, <linux-kernel@vger.kernel.org>
CC:     <linux-pm@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH v3 07/10] drm/amd: Use `pm_suspend_preferred_s2idle`
Date:   Thu, 30 Jun 2022 21:33:25 -0500
Message-ID: <20220701023328.2783-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701023328.2783-1-mario.limonciello@amd.com>
References: <20220701023328.2783-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d599002-59e8-467c-6662-08da5b0a180d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5374:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +KXS98Se7N3LEk1OMCePKB5sb6IPPmHS/cpOcFGvsTcBM11XUrTSKilCN070FRqp1cQqBRBFaTs002qINuJLSmJy6u3gNI6zTz4LJAB677htfbus5n5lQUSbYpPIfIg2m9/+lzfYRspYHX74SzbAkLE6ITfpzEmjKTYiZ6Ze4WUN9brhT2xjkglx1YEka4Ro4YcfqDWtySpnL+U25c5xcTePhQ88LG2HXKwwjK9Zjz+LzTfOQafehjkslljobs6DWpzB8kIFupo3bBVkvXy25ATO8qlE9EJtG8BgTT4Jk9iqzMnyKQsGMqWo1ii5uiCDc+hC4NvfnhXQWYfdi1MKt+nAIRRNLlefU2z5v0nHjC/KYHFYGAgEe4yMU4ResD3+ju6vl0PKcIg7pVWiUm8SGCoHRwC1/ZQ6xpvrgnSxCrg6acVdJPwsBo/VfBq0JlA7cdhdgPXZNw1lGRu51nJUPa/YoQXp+OFtyodfNYz9PJj8mqkdSyq/Doe5WqSaFujiieXVSz2H6Ps3j9YP9cPreMuetDTQOBytdblRdtrMdjF3c7cB3BaV5+AYxnGSz53d2FwVsclRIuOIcPQCzqhogb3vraJDqtYFd9H7troaE1QTAINLjt6n1+gYG/6ORjBbiZvbYlrn9ZNwZcN5UUk5+Apww+dfPWk3XdBOeZ9S4czIN3/0THG8nH4LX6mZyeIrXqqX/lVpjSZ1ZGR3hglPZnmhN1xhXTe6GS1G9qDCsNm947tJKUjUnpc0bGELQ3mjvg21SENAKPzfhBXnsxgaVPxs7bDvuoT5Qw8vTyo6hQlzkmNGVGSA1+QfS7AKTvSfHNgO5/e3QK1uV9BLxy2s5DCp0H9ZCf8Bt7GLQvHZWNeABJXX6A8HyuJbQhygdoKK
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(36840700001)(46966006)(40470700004)(5660300002)(40480700001)(4744005)(44832011)(8936002)(4326008)(36860700001)(81166007)(478600001)(356005)(1076003)(186003)(47076005)(336012)(82740400003)(426003)(83380400001)(2616005)(16526019)(7696005)(40460700003)(6666004)(41300700001)(2906002)(86362001)(26005)(110136005)(70206006)(70586007)(82310400005)(54906003)(316002)(36756003)(8676002)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 02:33:33.7053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d599002-59e8-467c-6662-08da5b0a180d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the direct check from the FADT and use the helper instead.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 98ac53ee6bb5..2146232c62ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1072,7 +1072,7 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 	    (pm_suspend_target_state != PM_SUSPEND_TO_IDLE))
 		return false;
 
-	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
+	if (!pm_suspend_preferred_s2idle()) {
 		dev_warn_once(adev->dev,
 			      "Power consumption will be higher as BIOS has not been configured for suspend-to-idle.\n"
 			      "To use suspend-to-idle change the sleep mode in BIOS setup.\n");
-- 
2.34.1

