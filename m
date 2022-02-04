Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E41B4A97E1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357826AbiBDKeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:34:22 -0500
Received: from mail-bn8nam12on2088.outbound.protection.outlook.com ([40.107.237.88]:36755
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231259AbiBDKeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:34:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioDCeS3K1RVLybWjsfcCYl9QjO+SgN+Ga4MNABuRXOhVnbEnVbG77WTxYyEgGF6opQfCcsVvCD8rSXakWbu/5fY6JAnOWwQuL6iSb3u0EVXJTongbX9C5y8kiQTC/NBEc+mqS3zTDTOokXvR4XVZ52NvzMq2cm9HuS9yh/ykKbsVPtV1v8JTvdDbs/SSE+tQNcj6IzCOLZETuCfCtHYVVdLBnr1bkl2JmRhpkKw22fp/YVvV+AHVS4unRbM8xikQiltP2fn2gN8LLsJSuOF5lKO424OJ6oFF4OWgBOc/iySyJh9vAkMih0/cPeNWzieQCFyx2m29+utlnfqivPu2Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+3OEMu/V9sCkn5bGZ9XD1moDlGM5JnXy02JIOToiNU=;
 b=joWB8RTJrRvgrxeOAgsFL4iGxz7yLBIAwKbIKEyGpLG/7QZJ8hzksCy7HxTmYaSxbPQmfwBTNFDV6zgGQv3PgnCYmX3KOxPKGNWmqrDLAqVBbSYGwp80hhaE7LAwAavrzV5/4hpNsmrfZ/+FpDeOdlP1CUOn0aMCdOXjFcHs1+9+AGjnDQdob6yXh90fPBrMlApGUoPc8Iocm+JQCBFsTGTL8grUmOWhXZip2zDau1mzAUK7kJiCL5yOGlC3AZJs5uQLK881I7XtFIWdE6+qxUktCr6CpqRsyXDlTtPAM/8A/K8941RUbvbd8tNz+Q0//63YAiWW5Q4TKGF5h4u5hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+3OEMu/V9sCkn5bGZ9XD1moDlGM5JnXy02JIOToiNU=;
 b=taAYak3FGJzdl+tYQNW3xFU5N0OJOxyVGhDlZkKKBxc+ebr6LWYXJxMCP1h2dOKZcSYD+s4kg/FlM2hnMryucjh4k6wAH+pR9X8tY1nSJvA1jyAc0lVi24QMahCvdIF8ojox9c/tOdXZJjWizOBIiFwY2dw2p5MTfxKDXnMRQv1xH9VLrigLx2tHL+b97DyanuKuTPzaDMGaAbdU/SJr5dcLes9CaHmpEkUhl28AVOZ2vKLa6uk0XfpEnsC9kLiWk6HIPFprklxZ2nP65pR2G/tYch9a932+MacbK9HXKlrknO0vqulH+hSVQalikT5TS+EkvQshVuQ3LKt6s7odFQ==
Received: from DM6PR05CA0043.namprd05.prod.outlook.com (2603:10b6:5:335::12)
 by DM6PR12MB2841.namprd12.prod.outlook.com (2603:10b6:5:49::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Fri, 4 Feb
 2022 10:34:19 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::39) by DM6PR05CA0043.outlook.office365.com
 (2603:10b6:5:335::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.8 via Frontend
 Transport; Fri, 4 Feb 2022 10:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 10:34:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 4 Feb
 2022 10:34:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 4 Feb 2022
 02:34:17 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 4 Feb 2022 02:34:15 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <thierry.reding@gmail.com>
CC:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH] reset: ACPI reset support
Date:   Fri, 4 Feb 2022 16:04:02 +0530
Message-ID: <1643970842-2364-1-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89a45870-c867-48a1-4ac4-08d9e7c9e620
X-MS-TrafficTypeDiagnostic: DM6PR12MB2841:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB284115B5A0742BFD001EA4E1C3299@DM6PR12MB2841.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N0DoOjh435VNivgDss4nOwMhud6RHP0sfj+diYuY5J7z8202gqSVJWTmXqviwqDZ14xQMbdePTYv9rwo4+q7AlTTfXPY8423qNkGkOpvXXWsZEBehEipZdiwrQ6zzSVXwKE9M2ljXw/7JkVRHrPAlNNdLQkKU8CQW9Hms7cWc1VfjsqrEo2tiqUlGGATocb8+7yDRV4O/LBz+zdReA0OWQaU4Ii7GmN5RURBZccYPOgaj6Se4tbMYEl/W1o9VUnEp5l4W/0jgR3m1NsXnR0kGlgH4Os2Eji5TLp563hTGQoyZ9APwlk8URRgoi6z6IqTXiGs/B6nv16XAR296RjMDQkSSABse26WIhF9+R7cPkotjMArcSE4WQWOrhoSLwcIj4mSkp8PC5CQJmrBFAeLWfM+PHprLI2LscXwjY9ybZPnHX2QOb9JFoOh4xZBcdnuWA6NTUPnrhmvobHm8lMYfC8Qjg7+weP3CeNBVBI6Sljr+5VdDLZJybcWqk5h5M8m39jv70z13IXImjeqYtIe7H2wzQ7x/Ixd8LL6d5ZjJ73tCfZ+2zUQE08MG0QF4sTNFjEwjggEHQ9ehvq/zx+ZeCbUUheb28g7KSREEvpovkHNAuyKZ8Y+zsODiHlf1IQVZL8yIBNFJoj1+79PEZ6x+zyYGXrD1Uz7WppG/XmHltcQCUwYFqhAkOVO52OH0fbVQwkEfSH20ifRA80EUV8RKg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(8936002)(70586007)(70206006)(508600001)(8676002)(316002)(107886003)(2616005)(336012)(6666004)(7696005)(426003)(86362001)(26005)(36756003)(356005)(2906002)(36860700001)(110136005)(82310400004)(40460700003)(47076005)(81166007)(186003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 10:34:18.3860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a45870-c867-48a1-4ac4-08d9e7c9e620
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2841
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the IO devices like I2C or SPI require reset at runtime to
recover from an error condition without changing the power state of
the system. Added check for ACPI handle and a call to method '__RST'
if supported. Devices using device tree method are unaffected by this.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/reset/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 61e6888..e4fb533 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -12,6 +12,7 @@
 #include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/acpi.h>
 #include <linux/reset.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
@@ -1107,6 +1108,11 @@ int __device_reset(struct device *dev, bool optional)
 	struct reset_control *rstc;
 	int ret;
 
+	acpi_handle handle = ACPI_HANDLE(dev);
+
+	if (handle)
+		return acpi_evaluate_object(handle, "_RST", NULL, NULL);
+
 	rstc = __reset_control_get(dev, NULL, 0, 0, optional, true);
 	if (IS_ERR(rstc))
 		return PTR_ERR(rstc);
-- 
2.7.4

