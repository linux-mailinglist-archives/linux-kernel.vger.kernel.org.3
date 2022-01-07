Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C763487471
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346344AbiAGJFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:05:09 -0500
Received: from mail-bn1nam07on2073.outbound.protection.outlook.com ([40.107.212.73]:36905
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346331AbiAGJFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:05:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwiBIclXoLAUHs6GB0otnozO9FVk0S0EF79UZUavExFrx3lopou0a79i8gbH9nAK9zDDqwZJEZ0FJrQvGGCcN0Uz4Yro5ZmDUV1WVpVSbEt5AZqzLLcVDW61dW/DqDhbd360euf0qPjdJsaFRcehczU+zbiQehHzk9JXY+fSyfNzoHLKbzFaa4EGUYXyGlAGWuidukurNOjWBq6x4AuUMuzoiGZzEB/k5Eg4KENagvCrNfQF5ox6K7oG23evRNnthZFnss6puP6YeMlSGr1eAjEp6pa6jUjaltbY8FXVW4DJRkybeMlCwVSqkvqNf/3MnC+MKWrSQtzdfWfd7Lv8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8AaTW2kKYZg8KNPUH7u1v3H7KwhOqhh642x4E46P7I=;
 b=AJrfq3TgJCVbP/K+USLKcHAHzeleHuocKliL8dJg0uE9uTT53CBKPKvyD5k4wgZPo/XUqVoIqptgGhAv8uC8vRGBzEI8hRpoRGzNwRX3uetacs+mycHX2+mWPvBheeg9csnM+Pyj+PpTDHeT3iphTUSkT4RHJLxbHaZYJ9tbmm4OfFAZGOdU/8VqySmvfX4e+8mM5TwrfOmIQgK43ppfsdsHfV+hWL9nzVFbES/P0QMcsetxirnEcn0x+nxFDdrIHC4sBvcGcEu4F8VONrrXmSvBg7bFqoHwn/5lQNi8KqJQXNJFJa4qHjvGi7iyrbO8rP0sGKQvHXAqHCnV7OMN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8AaTW2kKYZg8KNPUH7u1v3H7KwhOqhh642x4E46P7I=;
 b=XcNhj+CmwzF9SP5QHMciwov/gHi1/gICByRU7YR9Um5ptGuW9xAI24Sd3Mrzowx4NkHCVkJGQkfSaQsk9p2HmX1IqKJt23Lv6vNluW4dz8SRPbxaOMZRxyps+R5MzgGvTCGx9hZYIQyi5M66mQQyHYxtKoOp452B8qbu2VNazupvArzndRlwIrq7Va4gi26G5Bj5k9nMAeWFySteP5AtuNLZs3XRxboMORNlqSMF6PcWDU43WD/basIdPj3AtHJC+ybZrPa3vez4OFgUTjR1T8ECFEbWxIeLlyW1If+Crxa64Rp33Ne1SSUmlSUNQtFO20iubQ5sl7kKJNFnaDeZ1A==
Received: from MW4PR04CA0134.namprd04.prod.outlook.com (2603:10b6:303:84::19)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 09:05:05 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::9a) by MW4PR04CA0134.outlook.office365.com
 (2603:10b6:303:84::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14 via Frontend
 Transport; Fri, 7 Jan 2022 09:05:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.9 via Frontend Transport; Fri, 7 Jan 2022 09:05:04 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 7 Jan
 2022 09:05:03 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 7 Jan
 2022 09:05:03 +0000
Received: from waynec-Precision-5760.nvidia.com (172.20.187.6) by
 mail.nvidia.com (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18
 via Frontend Transport; Fri, 7 Jan 2022 09:05:00 +0000
From:   Wayne Chang <waynec@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <zhangqilong3@huawei.com>, <yangyingliang@huawei.com>,
        <rikard.falkeborn@gmail.com>, <chunfeng.yun@mediatek.com>,
        <waynec@nvidia.com>, <linux-usb@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] usb: gadget: tegra-xudc: Do not program SPARAM
Date:   Fri, 7 Jan 2022 17:04:43 +0800
Message-ID: <20220107090443.149021-1-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d702ae6-3b48-4a5f-d3ba-08d9d1bccb70
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2447753A08CE7BFA90081214AF4D9@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOWmW/PX2i18DWnOZoOMwnua0RSYFOXeWlHH94tvkmR8HV8/x4mLaVGn9vRpC3oUr44JzH0XI9aWMGs+JqmGuVguUKdjPeb3BgvthNpWufOzSvXHlFsKbOmAaJDQyRSdTZjfEHNIBCF/qf0BjSwH7NhQKpz3kr6+H6/Pb5J+i/kaHE0UWFotPXlGzVlCSZBSSsH/PaqgLdOhQYlRYMqgb4yGsHDHNqkFnLnhqaBhBP7po6LvuunPv/vilS33i2kTWvt8nvqBYWywAtsKtZ2bIY/O2419Aj0/BOk3pn6L4NTeXWEGCDuqKuYxd6X+8pe5wB+WIfisy49wirvPwaWyoZ6CVhDh5KPf+p7UDV10Tp/1133Fi81EOLI3wkxR33b6THhDWBSI02YEAYrpjENcJNp+MlO8dZjU7sBo1FmwVGSS3ZfnHRlC/OW0Y1LTbVRajcc8T7b7ENcUK56PtFAy14JCDJULg0AS3jk3Lb2hYndDoQsHgpJGpqMBy+geufErNGz+3DjRNWpiKnpuk0cPhqkNXe41VRsbbG2m49ZZjZ+qntfl1AIlKRKM9TXGCmmFbBCgNAATk7LtuiVZCnRBIvtDwj6yf6MCyliUQi9N//Fnu2NrCev/g53MIQzhwge6rnRJYG/E2lInDdWQmqCkUsMYH1+/HO+FmtV550Y0I8YNj6OSxjA5HDVCdk3kspsD1Fi40Tw+meiifuRKwxKNNg0ooE8zZtv5IpOxY4KTjRrmGiK8JAjUb/koGlyp+e8ZyV//yEHitOUujGPxX+CwyWzWhUQNC7ed8ZuvBIu70H8=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(4326008)(36860700001)(47076005)(83380400001)(5660300002)(6666004)(81166007)(356005)(316002)(36756003)(82310400004)(1076003)(7416002)(26005)(2616005)(86362001)(54906003)(70206006)(336012)(70586007)(2906002)(110136005)(186003)(426003)(6636002)(7696005)(8676002)(40460700001)(8936002)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 09:05:04.5611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d702ae6-3b48-4a5f-d3ba-08d9d1bccb70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Tegra Technical Reference Manual, SPARAM
is a read-only register and should not be programmed in
the driver.

The change removes the wrong SPARAM usage.

Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
 drivers/usb/gadget/udc/tegra-xudc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 43f1b0d461c1..716d9ab2d2ff 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -32,9 +32,6 @@
 #include <linux/workqueue.h>
 
 /* XUSB_DEV registers */
-#define SPARAM 0x000
-#define  SPARAM_ERSTMAX_MASK GENMASK(20, 16)
-#define  SPARAM_ERSTMAX(x) (((x) << 16) & SPARAM_ERSTMAX_MASK)
 #define DB 0x004
 #define  DB_TARGET_MASK GENMASK(15, 8)
 #define  DB_TARGET(x) (((x) << 8) & DB_TARGET_MASK)
@@ -3295,11 +3292,6 @@ static void tegra_xudc_init_event_ring(struct tegra_xudc *xudc)
 	unsigned int i;
 	u32 val;
 
-	val = xudc_readl(xudc, SPARAM);
-	val &= ~(SPARAM_ERSTMAX_MASK);
-	val |= SPARAM_ERSTMAX(XUDC_NR_EVENT_RINGS);
-	xudc_writel(xudc, val, SPARAM);
-
 	for (i = 0; i < ARRAY_SIZE(xudc->event_ring); i++) {
 		memset(xudc->event_ring[i], 0, XUDC_EVENT_RING_SIZE *
 		       sizeof(*xudc->event_ring[i]));
-- 
2.25.1

