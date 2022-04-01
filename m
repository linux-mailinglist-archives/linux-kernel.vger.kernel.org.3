Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD994EF2DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 17:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350087AbiDAO65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347836AbiDAOk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:40:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5522228B13F;
        Fri,  1 Apr 2022 07:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZyL7/fpgpOJO0lIvA3xEJXp22Z9/lnNzI0ieVYCaxpaFr2Uyelya3SdwRnAxs3AJn61hzM80JYap9LJJv02lcHXqJxBsiHVwjR+GZn4qbq/gtWU/UjG2AW2yPWTEkr2LUYLEgmdpGr3fgzC2B+wAbV1TfkEzfOus8TeqeZWT1ciY4wLixVJHszl+o/DQNMh8u2SL1kgyETxkgY7i6Mdrv2WnOEsAfHyCaOf7LPVkExFUNYCsJF1SX//tVCBV/2ATl/69w9Tf1WDDQylDjv9PL1ilLNzJAWfnHC+wnnsozV0kGDC+DmmFaVdztdK1+2rUiKffv0wyfzwJgdxQ80ZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9ALiZJtZXVg988Ue8lD83xA3ESKh4pq/gCaN3cUYcw=;
 b=nioULujHtwzF2IEtto8q+wm5+lRZO27OD9mOMIxyK7uHrY6vxLJ9qlfrDWtdcDWIIIiMnp1ucLnCi3yM3o9hjwYzZdjm1sPoqWcPFLvwwyOSaKSgd7RuHtgvt6KyziN7nQBdOw06shvbNOAyY/XkyXRFMlNazfNAVGTbC7PakQqT/uFiJZMKCvOwauiHxPFihI8bDqWY/im5O8ddeKvkP+ODUz6mvY2fsSAlXmFSTZHIsXfrCEiTpi3j/PAEQ7gqvcu/MZK7/tszCes1Q+XV+LbbbPvojnmKMCfddBKpP3ph9PxeyxNdY2QCA1wqTIqnYRkj7aKv1DPHQQGfQvPQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9ALiZJtZXVg988Ue8lD83xA3ESKh4pq/gCaN3cUYcw=;
 b=Em2xzMnILDf0bUhsP3UN2z9VQ3daE9NTQwllQ8i+bG14fTECZ3/DlcgdrI+H7WOyjF3rkMGE09D6snu7vvBrcuePr0ZCRH7oUuWBDzEYQiwhgLdpIaFSJCn5xqRxrU6ghFUnzi3W0M3xq1O6lKywWJ2Hg6WFf8dxgi8e3sDotV+CHEFk5NPqY01mqqwVQufWkEnLw/mjCmovBp31YcS2NgdkfQ/Tc/R9GfS2uACSga4dV3FBebGDPSzdGALd4guFQzAN7Y33rUERVPaVQ8pLLVC9Jiugh9SiGewSihIwPc3hsOwmD5HdDpPiu79LD46ZfjQgvrkFI7VXPzVa3IL2oQ==
Received: from DS7PR03CA0328.namprd03.prod.outlook.com (2603:10b6:8:2b::30) by
 BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.26; Fri, 1 Apr
 2022 14:33:53 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::bf) by DS7PR03CA0328.outlook.office365.com
 (2603:10b6:8:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.26 via Frontend
 Transport; Fri, 1 Apr 2022 14:33:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Fri, 1 Apr 2022 14:33:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 1 Apr
 2022 14:33:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 1 Apr 2022
 07:33:51 -0700
Received: from sandipan-pc.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 1 Apr 2022 07:33:48 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <ulf.hansson@linaro.org>, <andriy.shevchenko@linux.intel.com>,
        <cai.huoqing@linux.dev>
CC:     <bbasu@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sandipan Patra <spatra@nvidia.com>
Subject: [Patch V3] soc/tegra: pmc: update Tegra234 reset sources
Date:   Fri, 1 Apr 2022 20:03:43 +0530
Message-ID: <20220401143343.31989-1-spatra@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b621d6fe-dfc3-4384-4ad3-08da13eca520
X-MS-TrafficTypeDiagnostic: BL1PR12MB5077:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5077F59093D3E128EC7E1BE8ADE09@BL1PR12MB5077.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYabG/gMJvN+MRgn5i4JSS381jFh+bQA188VZbLuQ9zUir6ek3bYV6p1/dPabnFc4xgAb3sX8P/449wHCc5Wz1yp7D9EHkkbbWYkvzlbwJbrP62sDSOInCYxSM4Xn/0soCBEnPTwNhxY7KgTIPmXJHp+DHatF/ZkU5amd3V8iiSsSkubO7PcAbofyyHjsiHfhlD8g4wX8MXzOsPskpS5h8yaUpt/vI31364R+uf0+AMBck3F5vBKYlwwCOvniGs5kQ9lz70IxvG3xUgjcTDe5Q85JaKvAZ9cy5MeQm8rthFbTBzBT+aPxiHGYPq8VG4WSQjFnGtyKE/FMSUKI5ifTirq7S3NtBnNxq/+xaVNQuxZuQPC9WsZa9GdGOCvAd6igsJTnX6QhEqgoRWMPk5GEu0BX/6r3ce5e0kJdDfUkZS5d1CwTnldg7sTHYNQXX3lmmVVS83XFBkn8nOzfcVnuUyMMre2Cnxz+w8pB+lb6G3CffBPcEqJx5OlS6LU3Gd5LsqPxbOyBZ2qDUzNL/jFxgGdt44BTLkgaNpgE3U9jp08og9Cqr6SvpcdtXcU6DM4ExTkNVGX8Ct5PJy6w2c07ph/7CGHOm4AU/C8maKdWhZNDr6nh0hXU5J0I8hsHmxfX+PWTMG1h0dmlaEwjlejtAukGDRtWidRNesE0yWgvof3BaFZSY+uLE7Iy9/g50hLfVYf63y5fBKhbipX7/g8boiYwzz0JrXNjPJAHb4UB+z8B4dibOcVUnD+UaEsJjaM
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(15650500001)(36860700001)(81166007)(54906003)(316002)(107886003)(26005)(186003)(426003)(336012)(1076003)(2616005)(83380400001)(5660300002)(36756003)(508600001)(8936002)(82310400004)(6666004)(356005)(86362001)(110136005)(40460700003)(4326008)(7696005)(8676002)(70586007)(2906002)(47076005)(70206006)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 14:33:52.8663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b621d6fe-dfc3-4384-4ad3-08da13eca520
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5077
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset_sources list is updated to add all reset sources
and removing ones that do not actually exist.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---
Update on V3 patch:
    Added more frequent comments to specify every 8 offsets
Update on V2 patch:
    space inside comment and
    Changed decimal to hexadecimal notation in the comments.

 drivers/soc/tegra/pmc.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index fdf508e03400..c01db5309b5e 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -3766,7 +3766,7 @@ static const struct tegra_pmc_regs tegra234_pmc_regs = {
 };
 
 static const char * const tegra234_reset_sources[] = {
-	"SYS_RESET_N",
+	"SYS_RESET_N",	/* 0x0 */
 	"AOWDT",
 	"BCCPLEXWDT",
 	"BPMPWDT",
@@ -3774,19 +3774,36 @@ static const char * const tegra234_reset_sources[] = {
 	"SPEWDT",
 	"APEWDT",
 	"LCCPLEXWDT",
-	"SENSOR",
-	"AOTAG",
-	"VFSENSOR",
+	"SENSOR",	/* 0x8 */
+	NULL,
+	NULL,
 	"MAINSWRST",
 	"SC7",
 	"HSM",
-	"CSITE",
+	NULL,
 	"RCEWDT",
-	"PVA0WDT",
-	"PVA1WDT",
-	"L1A_ASYNC",
+	NULL,		/* 0x10 */
+	NULL,
+	NULL,
 	"BPMPBOOT",
 	"FUSECRC",
+	"DCEWDT",
+	"PSCWDT",
+	"PSC",
+	"CSITE_SW",	/* 0x18 */
+	"POD",
+	"SCPM",
+	"VREFRO_POWERBAD",
+	"VMON",
+	"FMON",
+	"FSI_R5WDT",
+	"FSI_THERM",
+	"FSI_R52C0WDT",	/* 0x20 */
+	"FSI_R52C1WDT",
+	"FSI_R52C2WDT",
+	"FSI_R52C3WDT",
+	"FSI_FMON",
+	"FSI_VMON",	/* 0x25 */
 };
 
 static const struct tegra_wake_event tegra234_wake_events[] = {
-- 
2.17.1

