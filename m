Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B82A4A67D7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241222AbiBAWW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:22:57 -0500
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:58465
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240082AbiBAWWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:22:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARx8CXvWzzYbKp2ne/3qsq+ttyo3VvzsNPglIlRAwkNIl/3lmFXaSO3YtPd77iu8F3TfK/kKbFnUqRsDrsAl+K1px3nff6m+RIV4eGy/BBhniYK2Yn1hj93Jeqck2bPKuliGPw2KS0WzvMhz/yZhSaKWDMoVsjPbTFJ5JrHvqEA7sgd2NNb2kFO6MgqGGkaBktTe4JrVLEUHQ4VYbSdFzxyiG4rvmlQPO+01nnwCtg4h0KEDMYlbdiT+zUMxF0PvmEcAwm7YNH6zbRRapQ5l+90DplXwlK7BWmwINVE277kQJSyS5R0h/XUnRI9YCm0+8NUfl1myNRGNQGZeWD3X4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0bfyf1RK4fTt6eg8QNmTnYzrE35PWEQwGMwv8csjoU=;
 b=BrU8LZGhkLqg6SBvCbMAADouOWdJMIcihvFZQVl5FGKfbl+5dlVW6wzDpDpaGMWgtlw4rVWGFwFQhQ9rlXar67sCzN/3+QIrrtRPJ/TzpkNOFLaJetnUryxPfyNZSLIO7gyIjanP9A0Rgy6fh96gErE2n65KDh760deBdEazYQxUcYE9kLsFn1IBRPJ+ORMEwZpFqS+/uuZW5Bq0uYjfl4cgHQ2EqAnKilIBAwkFxF+uBabl2F3p7S9/idyWo5h+1JE1n4ryA4vT1bkLpqTmy4SPJS9XKfLKY8fwq77ONFKbsPzWi9YfDR0aC2BFyrbRe43FrlJqcNwcgtK/weYVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0bfyf1RK4fTt6eg8QNmTnYzrE35PWEQwGMwv8csjoU=;
 b=C4oSSm0c9kCz8lJabKn5AdsK6H7zThMhjfPMlN11EEHBRWT0+S95uY+gweQGFExntEHSi/8MMU0s2tbWZHyTE/bcLB3vE72DvLhlTyBufVy6bJTUBz3gv7uRYkWQc9I0VobgV2IQymloZOTUBLbVvIRlRcYuOGZQjLJogYPEL8rQfe6788a2j2bjGwRwZ52CsMfjZRgthj4nGao1MCSwbzIOGA5sce2+7K1s8q82wXEU5I0bX9+h2oOU6UGckjmxqulH+gWR4SALQ7t5J5AdpghhFjIovE7HwdgNmTDSLdU42hmVYmhsUFiAO/kMQD0W+BugDiLGz9YB/HJwStVGTA==
Received: from BN9PR03CA0690.namprd03.prod.outlook.com (2603:10b6:408:10e::35)
 by CH0PR12MB5060.namprd12.prod.outlook.com (2603:10b6:610:e3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 1 Feb
 2022 22:22:38 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::5c) by BN9PR03CA0690.outlook.office365.com
 (2603:10b6:408:10e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Tue, 1 Feb 2022 22:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Tue, 1 Feb 2022 22:22:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 22:22:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 14:22:36 -0800
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Feb 2022 14:22:36 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v4 11/11] MAINTAINERS: Added HTE Subsystem
Date:   Tue, 1 Feb 2022 14:26:30 -0800
Message-ID: <20220201222630.21246-12-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220201222630.21246-1-dipenp@nvidia.com>
References: <20220201222630.21246-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b890281a-765c-485e-25b9-08d9e5d15a97
X-MS-TrafficTypeDiagnostic: CH0PR12MB5060:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5060748E849FD5275FBBFBACAE269@CH0PR12MB5060.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZSOEVvDVeM6AuO8RygmnsdcakzVYw2/mAMAZvcFBxmwNwn0oqyZ7XJdyLiqKnBXDsHFgSl3lQ/lSZ1S8MiFTj7eUs0/czJyKdyKahqwSr/up1kReBs7+h8iuyFaeM4nVb+wKjnqaiDDCOz98k5CNoGDoD7ywLmfBcQxFFb5Cru8O1LeKayt2v9tLI3VhoCjCyAJ1mU0Q9yIpbr4VaUTpF9LIbjceJ+soRhyng+FS2GVJ94F6bB28rp30inR2kTW3zLc+KGw9dJTQUl1Wb1sQn450wOiW5avrEt6wjANMBWh7ZxAj18l8cNbvveFmBw9t1My2JzpysdoBcqqzcfcU7iJxbQ4qB99sdUnWYv2pyU2EOQmwFbeELctAgRYIm44uaKoPaJ9Pg+fYAvm5FvH47sWCDsKiCExrLkLJyd5vipS83uhpfZ3FJ1AyS1KWkHH+W6vFBLm3mxgokRbenHa0WaIU8I8hfKQPAWZPR20O9zL65TL9MyUT+WoLEXLR4dN3fHEEItCDHdyE6JOdz3D6IoKSh6jbWL3f+YzAJWbMApeG7eL1XFl/XjxDLaIt7F7g2iPObKbW1bqKL+Opbz/22S0nVA9ix/qu7R4OCtF8BvdDJQnZMB9FdywtiM5Vxg9kZPjYsRPMAwFd1IHKTsWOEqvL39XJ7ILlwocQ/MCNGZQOhPoEWpOET/Tr4zEYWD5345b1QqxPtDpNtfH5AStIN+wP1KrFHH253NE98/Xo5zAYGNdZHb/T1eELG8VJq1A6BA/H4RdJ99skftGXBz1a4A==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(110136005)(82310400004)(5660300002)(921005)(7696005)(6666004)(7416002)(4744005)(36756003)(40460700003)(356005)(47076005)(316002)(1076003)(426003)(2616005)(2906002)(8676002)(8936002)(70206006)(70586007)(81166007)(86362001)(186003)(336012)(26005)(36860700001)(4326008)(107886003)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 22:22:37.8697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b890281a-765c-485e-25b9-08d9e5d15a97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5060
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added myself as a maintainer for this new Hardware Timestamping Engine
(HTE) subsystem.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
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

