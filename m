Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90B54EBAE5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242806AbiC3GjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242459AbiC3GjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:39:03 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B9456C26;
        Tue, 29 Mar 2022 23:37:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqGyFdW1v96Uv89+/IfkZqKzfD8eUrIzrxexqwEiOqrdHnCWqXCkEF9pH59QvA3MzI/LeGtZxAuqMZbS+TCREOyfq1Ed8lQrTtF9MhiFNQDdfyPfH0ltDqF26kyrtLfRTGo97YWFbKikLFpOaEEJay2rwZceD/I7ZGvZyFC0bw3n+lCGGSWO8+pRZiAA8RTcK8thItpCXDgp/4nxeSWI8DuxBxQQY2f5YA5lC1LGzifblD/+buAHaCCmRGiOFKoB8Qjwq89i4tf7S7l0zRhw2Zyrbxs1//eHgOTChghoNHzFQuWk40k89jEqO0JeM0KljCRyLamDmWQOfq8l1JrH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oV0lsDvGcZ1mWNfNIxl5bV/CvFDD6sV7h3MvMAIpMX4=;
 b=D2Y/EYeT5D01ALh4ZMyrfplrkVZHYPki58TeGk540t1IaNb9DVh/PhWgFtOC60qz539mtRP7vYYFBIG6cJYQDbEGlFsO8CpumW6RGaAHoGkiT1pQdtc1bTV71f7nSrVGob8HG/E90D2Ydy4J+k6Q3tnCOZmomtiL49/bIXmR3Mw68auUZUxL6jvelpduoCENQMv86wFqnB75CE/1dffIpvTV2PFwnmnX2T5Z8E/LnuFBENAOO+ok9amDCDnTEDbQk6TsranGcr8qVzWskRe1GwSHVCLRhLy+d6UgLCz8+f9AzvqLN3TY6f31T3N5lTSG4/obmJDWaXZkB7zLFLaOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oV0lsDvGcZ1mWNfNIxl5bV/CvFDD6sV7h3MvMAIpMX4=;
 b=pDStPeUA4sNQ5JgSpzJuFKbvPo6e//eEgv3osKOJ3b/Wbib05HLX4RtciVAujh6k+7ccilGKa+1YecnGaHQu8biCNlysh98J82pu9+O2jpJf3j1EzbI+1tndm5KwbTUKg8eJpLRGWHpkv3v9BF1u/E5eJEJBYxmrsZyqeSyCxPR0k64InS3IWOqBgm529QOT3fvzHtmcCqEXiSntxI1197DFlKwcl8QFN28drSwOHgGXh/nV3YWNz3pU0/sF+b4ssJixjuOyrT6MAFKQ29OhjBvELP3av3NJtKjWxuSVe/N7Y2Vos5dZxTkKpoPKV9yE2xh1LDDv1moWqQyfFJhM5Q==
Received: from MW4PR02CA0014.namprd02.prod.outlook.com (2603:10b6:303:16d::29)
 by SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Wed, 30 Mar
 2022 06:37:16 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::3a) by MW4PR02CA0014.outlook.office365.com
 (2603:10b6:303:16d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Wed, 30 Mar 2022 06:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Wed, 30 Mar 2022 06:37:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 30 Mar
 2022 06:37:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 29 Mar
 2022 23:37:14 -0700
Received: from sandipan-pc.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 29 Mar 2022 23:37:12 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <ulf.hansson@linaro.org>, <andriy.shevchenko@linux.intel.com>,
        <cai.huoqing@linux.dev>
CC:     <bbasu@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH] soc/tegra: pmc: update Tegra234 reset sources
Date:   Wed, 30 Mar 2022 12:06:35 +0530
Message-ID: <20220330063635.1689-1-spatra@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56eb7d1b-7328-4b39-5b9c-08da1217bb53
X-MS-TrafficTypeDiagnostic: SN1PR12MB2414:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2414A4BA55B8C2184B6D2720AD1F9@SN1PR12MB2414.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Le5HofmJULxBPI1C1dQ9N/D7DSHQijRd7YsV84r2MvtXzxo9GuvstmkHkfcUji6Bh4nT3vyCB+J5QCb8YtxTAXt97NB3pG5MF3B0SGRwIawXYIMFtu9dQfwaRdz3W5zsiDLGN9qR/z2zGMa/I9Tg7zfZKdn6AhjTs0ba34/jPLHS1jS6TPJMPFgU8A2nzuFmhAfmXPxSffiRCrdWZ2LNPub1Oic1lpAComIDLBtxALV1ENPd2uuBepMshXtiC213Fpg911CmmQDwpGMqDPc3ORmJtdEBAKjTflTLUY1tPrSn7A5JmtLjT2HX4a62wgPx+qwBvTlzV2TkVUg/MyjdvYw2vluqVwm4cOoSz0cR0h4I8blrb/ZkoxPzIFu/utpI5cceuGvzUa83rv/DjnMwH/FWlR4YqRgHuwD90xZoeTenxuoOn2iSxVg2LYSgmq8F3U6x33ljnQAdCI5oAZa3dLR2yCa7GY2Ah7yk4fUCBrvV82iKYz80lqTalbVTk+b6z2MMLQFSU8Od5kht7vfCfrCgbQ3xBmcBB6vduBYhgxSIe3Xm8L6OBSzmiUAdAJL/AOR+gKm+n0XNokvQnhAEy/KMPE8utI+JfZHAEIkaj7r6wP0e0OtaPEW7fmbLJ0pfypeVf2iD0nVfDghbjFhlJkpGmWrcQertn206xaP68aqj+j/W1Qqy4KCeBTNC57kdyh9dWkmiGm1+bsMBZK+AnjQgflG9BNJ3Xb27gwK9gIRp07BmCwGKXZBeHzSzY9Ls
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(1076003)(107886003)(26005)(186003)(81166007)(2616005)(356005)(2906002)(5660300002)(36756003)(15650500001)(8936002)(336012)(70586007)(83380400001)(40460700003)(7696005)(8676002)(4326008)(508600001)(6666004)(426003)(82310400004)(70206006)(36860700001)(316002)(47076005)(86362001)(54906003)(110136005)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 06:37:16.1446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56eb7d1b-7328-4b39-5b9c-08da1217bb53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2414
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset_sources list is updated to add all reset sources
and removing ones that do not actually exist.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index fdf508e03400..d9129b940e3b 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -3766,7 +3766,7 @@ static const struct tegra_pmc_regs tegra234_pmc_regs = {
 };
 
 static const char * const tegra234_reset_sources[] = {
-	"SYS_RESET_N",
+	"SYS_RESET_N",	/*0*/
 	"AOWDT",
 	"BCCPLEXWDT",
 	"BPMPWDT",
@@ -3775,18 +3775,35 @@ static const char * const tegra234_reset_sources[] = {
 	"APEWDT",
 	"LCCPLEXWDT",
 	"SENSOR",
-	"AOTAG",
-	"VFSENSOR",
+	NULL,
+	NULL,		/*10*/
 	"MAINSWRST",
 	"SC7",
 	"HSM",
-	"CSITE",
+	NULL,
 	"RCEWDT",
-	"PVA0WDT",
-	"PVA1WDT",
-	"L1A_ASYNC",
+	NULL,
+	NULL,
+	NULL,
 	"BPMPBOOT",
-	"FUSECRC",
+	"FUSECRC",	/*20*/
+	"DCEWDT",
+	"PSCWDT",
+	"PSC",
+	"CSITE_SW",
+	"POD",
+	"SCPM",
+	"VREFRO_POWERBAD",
+	"VMON",
+	"FMON",
+	"FSI_R5WDT",	/*30*/
+	"FSI_THERM",
+	"FSI_R52C0WDT",
+	"FSI_R52C1WDT",
+	"FSI_R52C2WDT",
+	"FSI_R52C3WDT",
+	"FSI_FMON",
+	"FSI_VMON"	/*37*/
 };
 
 static const struct tegra_wake_event tegra234_wake_events[] = {
-- 
2.17.1

