Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252C5490AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbiAQPB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:01:28 -0500
Received: from mail-mw2nam08on2089.outbound.protection.outlook.com ([40.107.101.89]:44897
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234686AbiAQPB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:01:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKvPyuwRaPuovMSXX0GOSOH3XVh4VWX/F2t8WM/0gPsDHvJPcyUHSiDrmvYfEpi+f1oqpIH/Gl6fn5gXCJqsre6lYWHCWjJ3IiGZXv7lKhYAGV8XKZRjYoHDQfKBa4q4be+yNckK9ztMja0Wa+gQlsKUpsO7pCb+EfcvjqpBEgj7ug9s+n6u96SOKSxB7jNC1AQSjv+MV1aKkj3m7Sj38zJOKdXH6hUeoWwHGXw6CR1cNYC1a9VH72zmsRZowynjUMgDGcrY/zpwgjSR7XAf9Jcz/rimmE6Ec7t+o8mq0UqNt3pYi2eF4vUOb0SR10nwkzOabqThChrlFG44+59upw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Cx7bWS2pRq6Y613DdQYMRNcGLfA9G8tuuMQDpIQ1Fw=;
 b=mFuMLSGcHnabaLdOJKrxg6prhJvRNErwKbcIiJF5fxrOinfzMonDY0iyyE77wvgEglKnR9eJSTgnmbED12HhX7uWaPv9xlhyPgacGbD+y3xX8gQPO1U1P2EnzTrYupuPwxM4/eHA953Hz6iMqWf3KCc0DHUUaWsOkjpWjiJYvY/Kz6hYv64HmHGgzG4xOUaIx/AA1sdA0hWvbvq1spkh2NrPMZogqlQ0UU3rTvQ14SNWkn4ia6jhrNwsiyQSeVQN6HJZpCmNkVQkc9uv4tcDchc9yJYOkudIrAdeMIAZ4hzubIBzoncC2NCqHAV+q2XNgxnX/8qp/QS5lsjx19EmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Cx7bWS2pRq6Y613DdQYMRNcGLfA9G8tuuMQDpIQ1Fw=;
 b=Y1cwOf1WOo2GRjai7DD469jv2VbM3NEOAq6wn1Vq+36ngDLZWoZDwQIHMgWLbpOWz0WmLA0OnGNGiqdrJkZIrk4Xn5QcGlRxx880oRQiqrQlLH27GM4vzIeTs5f1JGpD4JHeqseZN8WPRKeVzoXgAJ1MNYth45YWcKpA1WbKrK1tMhK8am22OyCTat7Opt6W0+qkLSP2ZHatTUsiM4vNIxoTcGg6OQvcD8eqmcHCZKrBYPXr7sIaEeHWQHDUYqqX1Y4CVeg0g3kg2HxfnG+rs+MWBv7x91aUz8w6ojErghCOCDXp3TMiXWcyfSXMRDuDty+lACck0nI6bItDVQTQmA==
Received: from BN0PR04CA0128.namprd04.prod.outlook.com (2603:10b6:408:ed::13)
 by DM6PR12MB2617.namprd12.prod.outlook.com (2603:10b6:5:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 15:01:25 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::2) by BN0PR04CA0128.outlook.office365.com
 (2603:10b6:408:ed::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Mon, 17 Jan 2022 15:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4888.9 via Frontend Transport; Mon, 17 Jan 2022 15:01:24 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 17 Jan
 2022 15:01:03 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 17 Jan
 2022 15:01:03 +0000
Received: from moonraker.nvidia.com (10.127.8.11) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 17 Jan 2022 15:01:01 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2] usb: common: ulpi: Fix crash in ulpi_match()
Date:   Mon, 17 Jan 2022 15:00:39 +0000
Message-ID: <20220117150039.44058-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06dce57d-551e-46f3-c762-08d9d9ca3aff
X-MS-TrafficTypeDiagnostic: DM6PR12MB2617:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB26179AE6052761EE2622BC49D9579@DM6PR12MB2617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSZFvxydmekXqSm6g+27IvbUYFMMJk7+MJavbmO/0ua8MHk9J4vxELdmcgVsW8BlPu85uXYRchkdf3KSy4UCAqTV6xfM05ri0hWrTzaBJ/E1qUVA1CWBGWB8Ogn3B28yFpNLtC7uqv+DRLLq+KlKxPsQRNlaTiItt764PvjILxayRrEPkLhLWbhseoo0PRHuo3X44eKVNksTYbH8eMsrmWcPxQWu7HXpHvF/miq+FouqJrKA/uYqys6IGkyjX+E38cLxsui6C+k5XKjP0b6FSajxNI6Eq2W9FXhc1tNXryUEUbkz0p1tnrBodUWCw3wwpDHSkmOcIeiPo4CsnF8oCLk88d05dcKpbYBs90Bbdv2WCKWAlCIIbC0axBwInbz0dPJNG826x97Tp2UTguMKRoaUBoGSoNN/0+YRsGrCfcnMWAbsh1g+hNOrBfOxnLG7luJIb/vjVZrgq2RmkmxhXuuWT1ZLv8vpiJTFO93RVe1zvoJooqF6ONa/IzD+2BjnS0mIled2POV7sGaN33JbX9l58gZe3palCUtWLSjrpQb3pkHmkR4JOP1vofeDheWVABH9CFqghfAzTKesLJ85ReNfd4Ixp6wN7YPvPF6gsVbY1xZpsKHrSP3WVp2+R6VqmXGTBu8hJfSPewWeAra3NelnSy2rGzUc7CRgUcHV20duljyzErWY+kSHibFEQtf3pGy4WeSEQ0LXNyHz7t6bKCGIWQzet6SoAgiaLB+rJCtLm7Xs34zCkdGi1IoILQq/yYk59WcE68FU3ypjduVH1fisx/GgeU6f1Jx7yvm1YdE=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(36860700001)(4326008)(54906003)(81166007)(82310400004)(6666004)(26005)(40460700001)(47076005)(508600001)(2906002)(1076003)(107886003)(316002)(5660300002)(110136005)(36756003)(426003)(356005)(186003)(83380400001)(336012)(70586007)(8676002)(70206006)(8936002)(2616005)(86362001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 15:01:24.4223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dce57d-551e-46f3-c762-08d9d9ca3aff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2617
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7495af930835 ("ARM: multi_v7_defconfig: Enable drivers for
DragonBoard 410c") enables the CONFIG_PHY_QCOM_USB_HS for the ARM
multi_v7_defconfig. Enabling this Kconfig is causing the kernel to crash
on the Tegra20 Ventana platform in the ulpi_match() function.

The Qualcomm USB HS PHY driver that is enabled by CONFIG_PHY_QCOM_USB_HS,
registers a ulpi_driver but this driver does not provide an 'id_table',
so when ulpi_match() is called on the Tegra20 Ventana platform, it
crashes when attempting to deference the id_table pointer which is not
valid. The Qualcomm USB HS PHY driver uses device-tree for matching the
ULPI driver with the device and so fix this crash by using device-tree
for matching if the id_table is not valid.

Fixes: ef6a7bcfb01c ("usb: ulpi: Support device discovery via DT")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
Changes since V1:
- Added fixes tag

 drivers/usb/common/ulpi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index 4169cf40a03b..8f8405b0d608 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -39,8 +39,11 @@ static int ulpi_match(struct device *dev, struct device_driver *driver)
 	struct ulpi *ulpi = to_ulpi_dev(dev);
 	const struct ulpi_device_id *id;
 
-	/* Some ULPI devices don't have a vendor id so rely on OF match */
-	if (ulpi->id.vendor == 0)
+	/*
+	 * Some ULPI devices don't have a vendor id
+	 * or provide an id_table so rely on OF match.
+	 */
+	if (ulpi->id.vendor == 0 || !drv->id_table)
 		return of_driver_match_device(dev, driver);
 
 	for (id = drv->id_table; id->vendor; id++)
-- 
2.25.1

