Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F974C66C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiB1KEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiB1KEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:04:14 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726272D1C3;
        Mon, 28 Feb 2022 02:03:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMbpMndPQOE8PNdB5xHjLfJkEF0mSPc1Cl/rlyJ4dVKiTFb4q+4/QVLGoZmIIL/058CfjsA/bjOmSuCuTqw6H9DrtHCINN+51NkcOTcKdGPaZblXwCfovoFE483jWKNuH1R6FZLEjwypegq0f7RPjWKxKA8BjT/SteL44bbwqseQrfTou8To1h2RRt25R4PMU82SgT5dH+Rq2fuygiwtWXvqonXo9Ix5rNVxc0CthfM23gPzd3KkA6HvA9pnkZMiTBKuWrVZMWntOy+R4UB4wGoS1rDp099+zvcD4FpmJg2yy771JFJkdt8nWb/0hFVqyaJhQ9wRzQBvbrIguHVynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/Uu9HUAr6DHKPpkxrTh+l3FmT1N3LSt0R7pkJ2mBLU=;
 b=GRtgMuo364MZanUxnmfvmn7FSpi1EwYSI4IbF9EqZxD9/JD3oDK8SIUGEJ0wEz5Dn3Wsg/rBXklXbWkTIU9SJJRuMOgS0oJBn4ybU55M/sT4K9sTtEi4ZOqnx5YlKb8+/tY2GjDFNc5q3W/R7yDJbmH2ivGmlIAD99oLc80s1WAsHvferij+Ni1xqbJOVDchrJm3DpFBUWbiUxb2KyJmXy9Gn2PTLFMU+GHUYGHP0EoJX8GyzQEkdAxfxX4/raAZrdKbnKiJgzY3M9mW8NvdhW+XIMusHQ13K+E9yKnsqIoYh4DSdbCFV8FcrUM6T4nOI0SQz4TGd4wXW/vEr3crUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/Uu9HUAr6DHKPpkxrTh+l3FmT1N3LSt0R7pkJ2mBLU=;
 b=U8bsY5dNaaOK7l8nbhI+uO3doFfTaNnGpptMVvuT19T9u8jCmOirgTccdK0dOG3ih+q1cZhYFEIu0my6czOkrPpu+CeLPrr9y3aVFn7YfzQ2CD/ih3OgSeStZRAv4acDbM63lDRcx4FuUUioskNyPz/kWXzJHRqHK0l80PK0Ux9iSx94G14SzlSYf+UoGjkwZOBMzcoNs3VdFdkta9FhmnwDyICRfxNl8wJPm6wfprcqg6YraWnRapdkvN0jDs15tI97V27SIHFen7vPOTq+IkjgSu/WTDwWI2cNcJQw+V6ia/cHnbfzhC4yMPiL8/GCHiKGwdn9T5jSLso0J3b86Q==
Received: from MW4PR04CA0091.namprd04.prod.outlook.com (2603:10b6:303:83::6)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Mon, 28 Feb
 2022 10:03:34 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::d3) by MW4PR04CA0091.outlook.office365.com
 (2603:10b6:303:83::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Mon, 28 Feb 2022 10:03:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 10:03:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 28 Feb
 2022 10:03:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 28 Feb 2022
 02:03:32 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Mon, 28 Feb 2022 02:03:30 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-gpio@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH] gpio: tegra186: Add IRQ per bank for Tegra241
Date:   Mon, 28 Feb 2022 15:33:17 +0530
Message-ID: <20220228100317.59885-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d414f05-81ac-4588-b07d-08d9faa194ea
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5753ECF29FB09589D0DF5B38C0019@BL1PR12MB5753.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mGjv5dnRE1aVOlGUqC7roKXVAccq2tolFxEQS8RB/eygfviLHNM2UqCKZW+hAzDhqZnfrgZc+xbpB8mgZclBm4uy6w+262p5yjnZR2A40Vr2OTUqT6k2gs0ywTxXOD10X3KWuh8RVW8H+mN6ZI2PAToj0ln5LzEboSplDCPMiEKuK1NA25Y4EmFpdyiN8gGDJ0xc2bUghWSSvLUhmKoD5rYr4FJf+YgdQgSbfCR/Fe2gMu0muVB1T5SwJfxruJ0DjefTRoKi4Oy9vp7zJk537rXx4WhxX58/BsbQc/ih2uQwm8iyGII2/mqIEjixyCcggItdwrjAL0ZEoadjfRJBej7f24c413WlhZvsOCKFTGqM+tFUEAykvPUGiJmH/p7j6HV/P4c0EkQ8Qorg1HlzZKIt+m1WlarJLoRKeC42xDnyYrL15tAf3QudWWJzVIppvs6MfKCS2e5K8EbUOxsl7CbNq6nHjVv0Z2fTzpiMQt5lZ++znQmYpfBQxVvShPqhnqm/ZPiYoV9I4ecVxnILs4jnGrlzGdz1vfgyQiY6Acircc9lA5sRydmg7lcTRbM0I0i9RGvBbHWoEim06EVZ1/xLxlrpkQ29IiFIZb/GYNZZ/sIbw8fAWVSSsvJZx3AIwIbjdC7VXvcCVpJEGQNsAsYh9F2Vo+bH1646E2vAhH3/dqghrw2w/SwwtVPBq/VTb6V40fXBKm/FZY8613nbQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(107886003)(426003)(336012)(36756003)(2616005)(4744005)(82310400004)(26005)(2906002)(8936002)(4326008)(8676002)(70586007)(70206006)(47076005)(36860700001)(86362001)(186003)(316002)(5660300002)(1076003)(356005)(81166007)(40460700003)(7696005)(110136005)(15650500001)(83380400001)(508600001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 10:03:34.3629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d414f05-81ac-4588-b07d-08d9faa194ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the number of interrupts per bank for Tegra241 (Grace).

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/gpio/gpio-tegra186.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 8d298beffd86..031fe105b58e 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -1075,6 +1075,7 @@ static const struct tegra_gpio_soc tegra241_main_soc = {
 	.ports = tegra241_main_ports,
 	.name = "tegra241-gpio",
 	.instance = 0,
+	.num_irqs_per_bank = 8,
 };
 
 #define TEGRA241_AON_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -1095,6 +1096,7 @@ static const struct tegra_gpio_soc tegra241_aon_soc = {
 	.ports = tegra241_aon_ports,
 	.name = "tegra241-gpio-aon",
 	.instance = 1,
+	.num_irqs_per_bank = 8,
 };
 
 static const struct of_device_id tegra186_gpio_of_match[] = {
-- 
2.17.1

