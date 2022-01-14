Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A8348E805
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbiANKC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:02:28 -0500
Received: from mail-mw2nam10on2050.outbound.protection.outlook.com ([40.107.94.50]:10101
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230329AbiANKCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:02:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bpg62Bu5e3JNObL+FoT1oWLdwijtm/tmLt6nbYnqXm5y7uMrZHefb/WQ8edixpUzifvPSHcQN0E/FZ3OI6o5ScWwSgpHuxodWLvWGwo0flv05hlBkN7vZLwrsLfLzYvvFyoIl8QC+2Vfau2IKhBifrySTalclz3BBFFZodA4bXqKI1mB5qdUiAd74ceR8Ik2S00jSdtAdera11zf2kxtvvgvClaZqGB3uTAED9xszOV0wHXRPiwor6oWNo3gcnPKwc3zYSIcgzUrGShZBJUnoSw7EG2bhk9eFEBC4QUwWvdk8MvZdv5pA2M5pQHGbGJDfnUFtl2VXAMWqix1fKLiGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=635GWRb8oEgugdj7wfSSTmegZKq0nQe9AneCKh/6UGE=;
 b=JlzKUBv/wuzEKBuqZ7EygRFb58onxnuRf23tcCKv6vjPt0C2tcbWj/4aLeL3nHkT/M27opQcN9wkcvV/PkNSIKuOkXvOQ4hOjPwEiYSHL7I43jP5Z/wBrRCm3vegzwNVlV7tzzpOvnbWCAUzxLTJG1BBWiiN5KuH1+Wr7cINxfGWWPdZ1OQApgj0ltmRIEitZGPpJSINnwnLbmrIH1Sbwr/+BiL8UqaFqKNQNM6gBMSIdDDqYHaghlO+K6OiZD52kqN5CFbqCAXhvELZcLZG+JsUlmXu6m4ldjG+BKx3r/Apk2Pcn38+I0baGdVRiW1bvpX7usIx2+t4Dlz0vThtWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=635GWRb8oEgugdj7wfSSTmegZKq0nQe9AneCKh/6UGE=;
 b=K4VLJwTQutn5QSbXcYcaw+9T3R56QcgGH+cw4aeNo2VoOK/wJNJ4wNWmDx8EZqXT8nRwmdKCauBzaZeLhtnsspJnLGTBqZ6EZkdsT+wokBtCLIlgIQ1TnluD0bwfcfWQLMNZm9nbdGjqKLZmFzNMw5yA1SzK6X0zI2g9Galj0+IQHBTjAUuP3qkzH8huJ5nX+ziWtN0MINOlGl1XVDOPAhHQOqxzHvd1ErjZAWPvp/ffW3LRjTUIvQGQ/+pdumxvTiQKp1JhGXo4AR6SUsp08cvfQzltH8CX7O+ZqUpW9QBIJovJOauBYCiXmGTnw3z0DYtaOwPRcqa+DNVAg84w3g==
Received: from DM5PR04CA0040.namprd04.prod.outlook.com (2603:10b6:3:12b::26)
 by DM5PR12MB1594.namprd12.prod.outlook.com (2603:10b6:4:e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Fri, 14 Jan 2022 10:02:23 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::bb) by DM5PR04CA0040.outlook.office365.com
 (2603:10b6:3:12b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Fri, 14 Jan 2022 10:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 10:02:23 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 14 Jan
 2022 10:02:22 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 14 Jan
 2022 10:02:22 +0000
Received: from moonraker.nvidia.com (10.127.8.11) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 14 Jan 2022 10:02:20 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] usb: common: ulpi: Fix crash in ulpi_match()
Date:   Fri, 14 Jan 2022 10:02:17 +0000
Message-ID: <20220114100217.59541-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e011d1c-d56a-4423-fe6d-08d9d744f605
X-MS-TrafficTypeDiagnostic: DM5PR12MB1594:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1594F1501AAE07464978EED0D9549@DM5PR12MB1594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szR0NZyeVOqZED8j3YE2UMy8lGzPeArmhowaOTn+2JeL1ttVBrgzjYHxKNHKmPJ2/9a7Kp/nJQhTPqUyrTCA8TDq2tLpbFFnpofwjLQ8uJ9EL2DmwwnJCEQmb3+TZz60KkcSZ+gYRWlKpYoo7l74C9/qva/pjcGfxFs0r3ROn8vQyDF6cZ8s3+E32wg1PfMidldR0aXAl+pzsSuwr4BLJUkPsmRpgSGkkMiwIraIepo0YuT6AY48NOVCrDyqsCCusq4s1jy/2RIiyCrUQSG7HW3lT//vWouXGlIVXg41esPu2xmugjAul0S3sqEaMPbXXxTz5ArUpBCgOT+sIFOqf6lGV7hC0RREHlp8+vhs9sOtNKoqVYbAqmARZ1T439u8qrjE2seeXMRJU6b7TvfTS0uMgpgYn1Bs0fgspDk/69DoRWQx+f12oaKsIatxjEOGaNU+lsqZe2qofPcPb1/luCHy+AcoHJvO0V7oTMXXaAaMFr9UXHflnV74g3RL6ZFYpbnUT++wJikCPhgAodeulpu2OxfWB1KB6wSFYjUkSXME65/DiitfWRI2l+s9XG2+blK4KX2DHD8ZVgLismOirIHkmhOj1ey51ZUCbXSN6k2Iw5gcZzoSwANGySEjZT7AIMVdm+QIOcn/zB3aFhS6y/I9MYPvYj/FpLgkEp3JRUnhVJRTxFUEb0buSrw+58zZdybmmmpBOb4plICbXep1eGEr6t66AXQ7/NhGWMBmaXUE441GJ+F8xueL5hYFV5VDZEuzjMN7tEgCA9K8uaz0QSjE0pNS5BJczUaQOzc4+MY=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(6666004)(8936002)(336012)(186003)(8676002)(4326008)(1076003)(316002)(40460700001)(70206006)(26005)(36756003)(426003)(2616005)(107886003)(82310400004)(70586007)(110136005)(83380400001)(47076005)(81166007)(7696005)(36860700001)(86362001)(2906002)(54906003)(5660300002)(356005)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 10:02:23.3878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e011d1c-d56a-4423-fe6d-08d9d744f605
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1594
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

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
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

