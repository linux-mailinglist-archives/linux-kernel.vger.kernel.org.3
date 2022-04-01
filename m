Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088894EEBD4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345212AbiDAKvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbiDAKvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:51:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4294C43A;
        Fri,  1 Apr 2022 03:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULUgrXbl/o1auxGbpFe0jpCk1/Oqghlxz0Nk1G4siBnM1oFHXtdLC1H3QST1Lv9qAGp3ghh0N/zxNneN1LVNAaczA1mnmHtpJUUIx5TzJh7TalBHah4AINHZ37Kn12LB2EKjXc7SfeaIvmhbv1itB0F/tAduxTftG9GSuxinHoGSJpFtGzlfqcHPK1U5eLaJjvmCcT1GVY26burJ66iDwpLIEds/vS3aRFnN106YUvh5FOmChMSpFe3PMsUVACYzeKkgC36OiSfkOilFpIIbQoszwQI9q3a68HlSm/fC/Mb/nbqgk4r0W/gwx6xUdHZL24X9pDse3Z9XQ/HSYZGpEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cmmtbs7MYMHWuxP3S19g2Kjrielq1MRpXqZxCQT3VPg=;
 b=i4g0wzdQWVtK0Mbdv5ThUSVsNzdoiVCs4KLDP7d+KGES5pdIodkIRiqkkfKjjs9ZP3+AkgayoTz7vERYx9RhoWjnrcZGKfRW7G0GcY/WkD9tG6b/rRlNRe9yq6Ou2eF1bbow66Hv7QiwxY0qbIU6FkYjAzgif5ZpCZap1Z76aiboS8hRw03MOorEgIbhiXJLTN7q9eL+q4TJCYipoAsEYws9UbIFWDGYQDmK7GjqMVqtVL9GjgJNdgjbsQF1HvBxfJ03IWdOwhG8+JE388+CVBjLdGKGlWpcslUivPcX3D5cJIZWs55UKsrQSRQ7hgORZ9qvImo64pVLTv/QzpdCdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cmmtbs7MYMHWuxP3S19g2Kjrielq1MRpXqZxCQT3VPg=;
 b=Lv5N6ZBtFJ5xfk/wS/RYUlAT+wnnVjLSGsbEoQVIfbyCNVoTgebAsdiC8puyNdjRBw+K0WIx7aQgGccCLjcg9SOD5GqCicCKIk5v1FNipyrlVl/bjCcHsE7IzLU+6qUq/TwQ9euD9uDgpGNCIO3Sk7EOzFLqJ7kmlAg2oeWniVLQGRudV/nEMmFtjQJ7tw7KNG1FbGhXFFKiUnBo2v9ThBxEOaUudejQQ1F04tqQDnuRK2Z+1muu0dt+6W7X7AeKSACDfBS0EDbNmB401MN7293WPFdD8WJorkXQqOA+Zr6dSELux6rzDUKUiKp5G6FIeQWpJI1iLePr/LmvjBhgDw==
Received: from BN6PR17CA0057.namprd17.prod.outlook.com (2603:10b6:405:75::46)
 by CH0PR12MB5233.namprd12.prod.outlook.com (2603:10b6:610:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 1 Apr
 2022 10:49:43 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::2c) by BN6PR17CA0057.outlook.office365.com
 (2603:10b6:405:75::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.27 via Frontend
 Transport; Fri, 1 Apr 2022 10:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Fri, 1 Apr 2022 10:49:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 1 Apr
 2022 10:49:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 1 Apr 2022
 03:49:41 -0700
Received: from sandipan-pc.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 1 Apr 2022 03:49:38 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <ulf.hansson@linaro.org>, <andriy.shevchenko@linux.intel.com>,
        <cai.huoqing@linux.dev>
CC:     <bbasu@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sandipan Patra <spatra@nvidia.com>
Subject: [Patch V2] soc/tegra: pmc: update Tegra234 reset sources
Date:   Fri, 1 Apr 2022 16:19:35 +0530
Message-ID: <20220401104935.9149-1-spatra@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ab272a0-3bcc-4ff7-c859-08da13cd545b
X-MS-TrafficTypeDiagnostic: CH0PR12MB5233:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB52337253D2D884DD9DB2E897ADE09@CH0PR12MB5233.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AXbS7iMQ0H+jzglXN1jAUqTUDMBjwCmmGq5FHsUQUuZ4kOswF3MDtyhcWocoVfLJtc5PEw9DRakTKWoWq7mjJ12cXKL81zk44WuKM/BLZ0Iwu5WWcgRCmmmNPaa3cR27v+rN8DYHgyIWC1E0y2Aw13fLz89v5Ug9PsaEVS6AhcecV3Y/13jfzWdJXZtbGNjbPD7HrmQ6Gp7mKeczVDXj4SJwV6sYnYHj0q5SjdrWp4c4MmzGInV1xHAgGTKF69MGYrQ4ob8oBe6x0CQDZaioKQfR2f7/fzyPZBfrA1k+6CQW6SMzdiMfk409pawLETod2t7VYQGmsMdzxLqdt5u29CigjIIrvFNshTh78MPJ3RSU66PTs3s0MH4mEECA8kof93VDO9qW7wQS5WWFaJIcL3P+CwayOok9bzeX39YkOLPCwwD2t/e9WQ/bQdh4Ro36OTulZGDg4NoBynAzmAaGA1UYARJ+b4xCIaDxOBL4AyXedp2jXFr684comoKmbMJT8BInXdjHikQ7I9HfOzDOnb6P8n8RdQ18ZWD67My/JrsGn4NJXagjfWUU7psU0krKPSSjbUIG9lhsaTNMZ2U9O/uTmUiDqQYMKx0X96+1j+oAAxzMCytCx6qpEzOAeBrRKvJA5HhEdwtRwmHuuh4T1plTo57uxDHvnRdu9ec+Z0a5Fv0KPZcB1uYscUBGNhBAEFPjPkAnMsFW6E5T/uFoQZ4NdfkXmD9cOI+R/m52ZHq6WuCsa4XE8CVgf+8/ffjAkktxJDAgGvj1kgUGAPvd4gyFYrnThw5Ce1wGo3kIeKA=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(86362001)(81166007)(6666004)(82310400004)(70586007)(8936002)(4326008)(70206006)(54906003)(8676002)(5660300002)(7696005)(40460700003)(110136005)(316002)(15650500001)(83380400001)(2906002)(47076005)(36756003)(186003)(36860700001)(2616005)(107886003)(26005)(1076003)(426003)(336012)(508600001)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 10:49:42.8683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab272a0-3bcc-4ff7-c859-08da13cd545b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5233
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
Update on V2 patch:
    space inside comment and
    Changed decimal to hexadecimal notation in the comments.
 drivers/soc/tegra/pmc.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index fdf508e03400..3799669813e2 100644
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
@@ -3775,18 +3775,35 @@ static const char * const tegra234_reset_sources[] = {
 	"APEWDT",
 	"LCCPLEXWDT",
 	"SENSOR",
-	"AOTAG",
-	"VFSENSOR",
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
+	"CSITE_SW",
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
+	"FSI_VMON"	/* 0x25 */
 };
 
 static const struct tegra_wake_event tegra234_wake_events[] = {
-- 
2.17.1

