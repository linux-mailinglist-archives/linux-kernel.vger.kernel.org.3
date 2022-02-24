Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D734C25E2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiBXIZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiBXIZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:25:10 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CD326F4EC;
        Thu, 24 Feb 2022 00:24:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl0Av4U1NIvOYgGef5FclIMAOAWapqxpS/Goxuw3OPKdoqtdkpAvfxluxqJ1yyhem+LLfhj+5W1z7Jf9Xg69ZId7pdLkHiCVcnBfgLrmdtiW/YXatt7ourqXi7SRPoaH3M9POk8I3XEHHOyhCMtXXTiVZJjpVUa6PtXm0nFl+aJDH7A3hjkBR3nbVt/R+w47Oc2jdHsSrqfPRTOz30LgXZgqJ3PDpQKrnlNmNaDuFDonA05duKscwF1jTvTWLlFoc7f/exJgaJsrt1XY4i9MNfAM9iwxlxw0AsYgV5/vWw/d4JrOXkZXxDEN4ExBFnUAlmoXWa3E19SpZunCCpPndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lc+WDFC/CpbhGUMZrhMYL7smDwyVZbUk2feF155k8K4=;
 b=ShDNZPS3WproTH/Rg3W7+IKRcN+8floF1hIOJYHKneNAQXAgkathvY66jmKnbhXRz2ehy06XXln0F1Wvkju18EJ3N/K7/HuaBP55yKzMd3Sy4S92nBT5x0nEwMM8+cdor0bxZdQtfTOvhqq4zulxc70T7d9QrCXfNyiJT6OVof+2VPUF8o0Z3va9v9/pLIzQeiO5bx7/QYXTGAHQmMLbz2EB4rGGxRU3aPmQkCkOCAS5G38o5osmoA0EsKgOxnpD/MawjKyZeNMGhkr+9gT/O8iJj/K4MVQR8hY2ZY3z5K4Lm5lcRxqEhRDMzoMqpEkJOPrZdfLsiocEWKDIyFXxrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc+WDFC/CpbhGUMZrhMYL7smDwyVZbUk2feF155k8K4=;
 b=X0GVqYNLRsyQuDygb5HJSWAV34Pf1Kec4jt/IbXLF9FKk1rExKNYArrQXA4nldsWyjtoPWuje82FLswzgJiGA6hnhY030OzyyzUUFwa4tAzWlXiW13PFapmyhsSsVN2q3+Gv84xTuGwVp0k4knSUEVeWdUfp8TtiLsN3wamj9pIjiFo6KvWD2EuIShCx44y3POJZlnnhauUnvlRVg9MUOtXAfOlJ4UHrJJ1NGgw1yZ5OMvoxJRJ+uWmShhHtDnUxI88/2vxXVuRF+fMD+J6wE7xHdVzlFAGBY6ZI3vLOmXhJcGqc55STJpo3gTEPqHutmfDmeNFArGDeTYOYPPVAYA==
Received: from DM5PR21CA0017.namprd21.prod.outlook.com (2603:10b6:3:ac::27) by
 MWHPR1201MB2478.namprd12.prod.outlook.com (2603:10b6:300:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 24 Feb
 2022 08:24:39 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::16) by DM5PR21CA0017.outlook.office365.com
 (2603:10b6:3:ac::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9 via Frontend
 Transport; Thu, 24 Feb 2022 08:24:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 08:24:39 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 24 Feb
 2022 08:24:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 24 Feb 2022
 00:24:18 -0800
Received: from pshete-ubuntu.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Thu, 24 Feb 2022 00:24:15 -0800
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-gpio@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <pshete@nvidia.com>, <smangipudi@nvidia.com>,
        Manish Bhardwaj <mbhardwaj@nvidia.com>
Subject: [PATCH] gpio: tegra186: add Tegra234 PMC compatible in GPIO driver
Date:   Thu, 24 Feb 2022 13:54:09 +0530
Message-ID: <20220224082409.12559-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e21943c7-eff8-4d26-6989-08d9f76f1987
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2478:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB247897C07F37B7CF345D3305B73D9@MWHPR1201MB2478.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j8TOWvmoJtJz/Ol4vGO1qKKK5IjIdnjDskLbo+gB8xRuDktGlFH1vyyV6m3zCth8sSLElGWZux7VmFJyNvOrICXBVu6N9bm70jHw6M8/ik1uYJ8+MjkJitzDq1KsQOh288nHO8V6yxyhD6klzgkNs9GXJ5mgwcjPZE+q9u06b3AwWgvZ2JXrd7SrZVpvaXpfdM7H9qOq0c3Uw+K1W2vczt+jtr728suuN2pISut+XokscNR3P0zpx5Um858EWhSBRTcNvrJwV+WeAWHjLI5vnoqQ+/0T6c1RnEYWIcvOrEm1PAZ1fsl7XKZ2Gq6wly8mv4m/b2iBEL2lqKnJt+/pAVMCFx5qJuAuduP8yXIQqoLbefPK6eMY07iGJp/3wwCp6IlBpbACZ/2DwRClUeM+Uog0/ULLMHgTdfRZHwVyL2cMkKdVB4Mln6iCJrcy2nkXNo8UChWOD2QWbraX/7HeGzuiTJXHVcrU5PWNOVAMcKSWyL925Wwzh842MjzpL3rOzVQM5xnL1+y26FyZhRWrYtnpK037myDlY7qUUQ037/XbYqrwwOgEpH3krezbGJtlC9X/tKCzknqfUlSeuNp5SMFGiRNv+45NfibnZZbZuVdGS/HKBRJ8/NP7ogPF9TTWMhLbW27Be72sWEcxBBgB+RyonRPr16YQrhoZCAd98J2cUqEBhSYJNX2qBFnN2Um02tmdtw548hLrgJedn4/Xeg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(8676002)(82310400004)(7696005)(2906002)(356005)(70206006)(8936002)(81166007)(508600001)(6666004)(4326008)(4744005)(2616005)(107886003)(1076003)(86362001)(316002)(5660300002)(36860700001)(336012)(426003)(26005)(186003)(40460700003)(47076005)(110136005)(54906003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 08:24:39.0121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e21943c7-eff8-4d26-6989-08d9f76f1987
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2478
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Bhardwaj <mbhardwaj@nvidia.com>

Using this patch we are adding PMC compatible string for
Tegra234 in GPIO driver so the irq hierarchy can be set.

Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/gpio/gpio-tegra186.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index d38980b9923a..c1e9dd8c78f8 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -563,6 +563,7 @@ static unsigned int tegra186_gpio_child_offset_to_irq(struct gpio_chip *chip,
 static const struct of_device_id tegra186_pmc_of_match[] = {
 	{ .compatible = "nvidia,tegra186-pmc" },
 	{ .compatible = "nvidia,tegra194-pmc" },
+	{ .compatible = "nvidia,tegra234-pmc" },
 	{ /* sentinel */ }
 };
 
-- 
2.17.1

