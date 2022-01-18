Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56D34912C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 01:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244078AbiARATJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 19:19:09 -0500
Received: from mail-bn7nam10on2061.outbound.protection.outlook.com ([40.107.92.61]:35553
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243901AbiARASv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 19:18:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnOQnkdEqBwysfqq3hTP/Nrr2JukKGLY2fyPnFXR4AT365HdwI9ZKkeYIREe5pGuLgPFLNx7o3p8a+imjPiP+9MofIf49Z5533pIdcuwov+LPFlt6DS3aZ/7OZNGgWjMVKiT5TrjMTw7JSqHGflkuSyrIe9BSLDytXnpGtAGOXEjz6VB3xtowqfewXuznPQGkt0WFRwV2yXX/tsm36vm6P/bxt23g3NPg6jPgCS/9QNYbhWECqMHIUTBYEbvyRmFncKWE3vFkmuj97e/xCqMglmdi1bGPbjJktwedVHCiB6Tlq62Qtc8nhAmI95Elx1GumMN4tg+qDxgtTMojCVZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cew5xKMQrFXVqnM+rftSOIhzNmoAp/N1h+Wzv36pRQY=;
 b=JrDgXIP18bf/F7wVFQWw3yQxPzkcER3zC29/7eyUJpHqbgR3eoKOIfGvhQL0S3w3fRcEASTBF348Ta6qjPu1IQUJrOlHOdRTezm+44ns5kI0koQq6aPHLKmS+OpBPPKSPk8ao04pYGD4snbx6F6EpOKkTWqPP4UNu6pjSn/pnZhs0nACaYzA7V0C7vZ+VnZpQ7HNWz2zrSM0dGicWEuRWbejeDoVCeeGFIh+K4unLo9Enh8I5takcYurHDgrdlU01BYrC9hLgU3V85qrY3tApc3fnCPa3fQ8q5hS8lcElpdMYqO8+G6bOZRMAFS0SWsJ3uRpGssosjKdMawotAB8ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cew5xKMQrFXVqnM+rftSOIhzNmoAp/N1h+Wzv36pRQY=;
 b=uQZY7PBmFrGI1sh7da/Vc2BXToJ9JqKTkFJhRz/pjC09TwvQFXkImJpMPvQWP5zpPT42Tbmt2BLRtBpxV/+RlTq9wzuvQbnVRjsWAf6685I+XhTV9ultbgHhqsQ4l8iHb/YYAaaaJm2wnwvT8YZ8OiHLI8UdpY0y7+zItTr5u9YtJIdmSD7mdGPzZywg2CJbOOG8lfBeA8P3GTIJAqeKLuvP43BCF6Ev8NNDr3yOdPL0F25whQX2oF8JadtpW85/GZIedhgqUC8y/PJPvE0rvJ/tGPD7vKfVPlc5smIKveCzQchlyUNKZDAgDzj8JtcF1+8ce/0AyC8i6Mq/jmw9Fw==
Received: from DM6PR11CA0024.namprd11.prod.outlook.com (2603:10b6:5:190::37)
 by BL0PR12MB2529.namprd12.prod.outlook.com (2603:10b6:207:4e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 00:18:49 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::e5) by DM6PR11CA0024.outlook.office365.com
 (2603:10b6:5:190::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Tue, 18 Jan 2022 00:18:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 00:18:48 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 18 Jan
 2022 00:18:48 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 18 Jan
 2022 00:18:48 +0000
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 18 Jan 2022 00:18:47 +0000
From:   Dipen Patel <dipenp@nvidia.com>
To:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [RFC v4 11/11] MAINTAINERS: Added HTE Subsystem
Date:   Mon, 17 Jan 2022 16:22:14 -0800
Message-ID: <20220118002214.18271-12-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118002214.18271-1-dipenp@nvidia.com>
References: <20220118002214.18271-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dde374af-3942-454a-d63e-08d9da181955
X-MS-TrafficTypeDiagnostic: BL0PR12MB2529:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2529507F43F78A0D8D9BBA90AE589@BL0PR12MB2529.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oKXX42PPNe4CoANTPCJddhf9fa5+hk7UIbc0YEtjoW/cBx8dGLUFlBJJBL8ZOFkyheibry6l1lYD3clil04zMfQeyvxWMtTZCXgH+pR88z13bCRvrOJUCudOyCMECksNHG2MX/nAoV3vtp0B0hdwrJFX1BlYOHNRcwO+fHoZAVvz/FaAReS706O6euDXhXr2jNnSsLFlWYmF0ryccLfAslur3pagexWobLU1sZRaONif1KTtgmeVC3MoePAROcdHqbXYVAgqI61ysMLZg39VPXyHUOmlpKZsrBEewyGGwsBAexxXrSw8O9ALfM+vOt0N/AXoxOI4FMqGNSqhwtz5IaozNXVbZYP8g/mOFmFRN4bKMkRLS3pvc2nXYPRVTgb/SA61444l4CTZFDrKDyaVEoJ60kfeBUp+6KFV8OXQZFiw578lbnfW+C0CFRiNKqsZBKHSsPUwVmsRqhiJRoVAxcT3OVGBac78U71gd45z4+QObThjVZHF+wnFhiV0hC7ibUGNNBvGzihlCBa1P6b7oVlj0Dj8Ve4T0Qjg/ET+AjM4jFnALCTv8fqlf3ZjpT7hR7MTssQFM5Fzprss3OTG6J+XvIWrxuP5AI7YDgZSur5NBpaB383hJKNj8UURpvVUeOGOMnUv8e/wO4xi52hW4xp8aIkLcia+Ug/ti96RW8+5dw4AxuHOWSvbNOlf8uJE3AzkEd7jFyzDAu3j6o5Fmy/WtLz2Tjt6jPdpnt5Rf1sNKTHDUqDtzBEBq7dcPEeobKbbKoBKxtUrjburtbR5qtz60HDyn+yePquD7AQJsuf3pa6vRn+TCF8LkilU/iNnt9BdFNB6KZHtXS8MRmJw8Yins8mPpngSgDxBSj/o9xQ=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(508600001)(336012)(1076003)(81166007)(6666004)(47076005)(26005)(8676002)(8936002)(7416002)(40460700001)(356005)(82310400004)(70206006)(426003)(921005)(316002)(110136005)(7696005)(2906002)(86362001)(5660300002)(36756003)(4744005)(4326008)(70586007)(107886003)(2616005)(186003)(36860700001)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 00:18:48.7512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dde374af-3942-454a-d63e-08d9da181955
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2529
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added myself as a maintainer for this new Hardware Timestamping Engine
(HTE) subsystem.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
Changes in v3:
- Followed guidelines for the "M" field.
- Removed "*" in "F" field.

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c87a3f5e302a..1a3705fa7163 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8811,6 +8811,14 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/input/touchscreen/htcpen.c
 
+HTE SUBSYSTEM
+M:	Dipen Patel <dipenp@nvidia.com>
+S:	Maintained
+F:	drivers/hte/
+F:	include/linux/hte.h
+F:	Documentation/hte/
+F:	Documentation/devicetree/bindings/hte/
+
 HTS221 TEMPERATURE-HUMIDITY IIO DRIVER
 M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1

