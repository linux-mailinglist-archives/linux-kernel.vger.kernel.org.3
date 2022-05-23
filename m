Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83131531A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243236AbiEWR42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 13:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241512AbiEWRau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:30:50 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104266160F;
        Mon, 23 May 2022 10:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aY++OJHVCJMah6Nvd5HcTopmKYYwbsuBv2GQikPE3Q1v9GB0hz2zXPwDNL+wwxZBvxwF/oYXEp1pPmVOaEfRs3wCe1ZVd2DqfI4WfnKqTkvRJiVcG9pGeLfZ1V5L6cgVDIk1hcA5D49a35Pk7WRO257OXYBM9yc1oRyzrXtRx7+kmrwmTOSCJvkP3f39wgAaN+Go3WJxKLRmUjc5evdj3CodHg3VIDBNOETLhWXlrA9scgMUETHTQJaspjXCrAeaHLDHW7OAhH7NCanZJbHVn7cbQuahfdwBIHttyxJA9wOonyXHdDnWw5ZqOytB6WeRGacksqrrdBjrAepiHVPdYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PE0ATOfziP2aa1+Pw4rFqSF03vctJXfPBUNXduq3ANY=;
 b=FFp7SiwCpnv4oEuhFo+98ZJYI6BoJ66RPufgiPxPYTI4N56dlDweLp4RetX/tT8JclzVO3P4VB/517Mpv5Fdma5168+vK9R8VYrmfhPrAyjpUF6K2OkMOdusIqFLhD7luMn/G7rNJ0HJ4Mlsbree7FTVlhj9vhMuvuVxr53l8OFXq6IHnh+SBbXYAE3oolbja0kcoyzMrqT5OOf2dEIEslOrvka7P1V5yJPkAh85TK2nSHWNa3i0wgSC087clM37f44wdG8qjHQRuxwmdhBDj1IDtxGYv35asSBuaofZY4mBc9yv0UJqxOCNiu007BWsdOH10LVCgF6eK9IGz+s9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PE0ATOfziP2aa1+Pw4rFqSF03vctJXfPBUNXduq3ANY=;
 b=H+k04/bWN+/jM8QKfNZy5eMxZqkEjfx9PKjsB5f/v5abYI8WXGC2m5MKZ9xxL4fQmR4WG/jCBojH6OTHfd5GCdDwJU+qBZfDkExLH801Nl0XxD58fG3Y2Q4Xc7AKcA9gWXmqKF6JIfQqFBN018ayOA4fqcQ0lp29iL817IOhGuQzeSXNzNwfQswkdg3uIkkXhjrfYdOI2bb57TbkIvpucM1xgCorw2p8tizuOLQtc6kBL9+nR8OtoJaCS6sw+pb5z6kUEvN9gyxIbedMwtGpvVhv/EhIz3YDUiPUHB2t4lLH6m9rJAkLrYQ0XMU3iw9PzH1XSnGbvYsGO1ILo/zfDw==
Received: from BN0PR04CA0012.namprd04.prod.outlook.com (2603:10b6:408:ee::17)
 by CY4PR12MB1317.namprd12.prod.outlook.com (2603:10b6:903:3c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 17:25:20 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::be) by BN0PR04CA0012.outlook.office365.com
 (2603:10b6:408:ee::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Mon, 23 May 2022 17:25:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 17:25:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 23 May
 2022 17:25:19 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 23 May
 2022 10:25:18 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 23 May 2022 10:25:18 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH] dt-bindings: timestamp: Correct id path
Date:   Mon, 23 May 2022 10:25:15 -0700
Message-ID: <20220523172515.5941-1-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f822c8ec-ff2c-44ae-ac4c-08da3ce135fd
X-MS-TrafficTypeDiagnostic: CY4PR12MB1317:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1317BAD55EF8C98B7CBC673DAED49@CY4PR12MB1317.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WL0achfSZkZwRtogDtd0EyY7C0x0V6T3UwcEh8aV1h5C4e4VSaQQrxX8zgtJpi1GbmndMBWA2KFForMbWjLsnLjrWaxK0XVFwNuVyXSsZHf+Gcutb2oj9BO3jbIvYqkZW//rIqrbBFbsoV7pJ1f6k5IW+ZwXBPXMri90qySkGV2RQg8ZBZcL0ht0mQMOQHyO4rzFri4JQYSpIHPpflt+jqNeWeeZOingpFMaoXBfexfEH60CPgm2nV+gjan7kSmEtCV1iSWsjtjaKb4N3Bdvm/UjDcuy4ldn2sB3uM9u+IS9btOC9STCb3/FFsU9MpGofIzUv7wyQCuvTzf3ks5S3y4krWbXT4aR5F3D/VAFYVc24uG9zxnsetMW3RaJFDP9Y8ICC/2czbPLgwKRdjkP9FWckdfUE9ST6+YWIQ3PG8YyA5F1Z3vVKCHCvy8O5Dg32L8CjIj0itomFILXH0RBeCeyQISH+7x7AyMjTXK0eGgO4XNlnn70HdPRzGArzYFiooFHMCVmJ/kwKQ0OoTlr7wg38Kayzq6nr6tu3KdiFDOnvtmmuUECKtnafalb8TmCNDQPBQifUoN32+eN4NqZw+21OePhZXwe6N833QjAeKM0qVJCI8qOtiUf/81mLW5aauh3Xkc+TDAYb6cT6udFdKlrKDIHyknb2KKZ6ZSsmkxrlDF/0ytYhk+FJu/FNk2E4whHPZca9fcncyppFTu38PPc4iDE0UnJg/AfvoTAhRyeayrCDdofG92IcH3dYgXjeXQ87EHxioaTH83ojsnOke8QAFg/X5MGgZe7ecwKYfPTLrA/ZtrFvLadxfsSGXkmp0lDGkk0Ii3F28fz+px2tzkPuUCvsQYNU0IOVdVbltg=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(316002)(83380400001)(110136005)(40460700003)(356005)(36860700001)(8676002)(4326008)(107886003)(82310400005)(1076003)(47076005)(336012)(426003)(86362001)(2616005)(70586007)(70206006)(186003)(966005)(508600001)(26005)(81166007)(6666004)(7696005)(8936002)(2906002)(36756003)(5660300002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 17:25:19.5596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f822c8ec-ff2c-44ae-ac4c-08da3ce135fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1317
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the repository renaming from hte to timestamp, $id path was not
updated accordingly. This patch corrects $id path.

Fixes: af583852d2ef ("dt-bindings: Renamed hte directory to timestamp")
Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 .../bindings/timestamp/hardware-timestamps-common.yaml          | 2 +-
 Documentation/devicetree/bindings/timestamp/hte-consumer.yaml   | 2 +-
 .../devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml b/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
index 4c25ba248a72..fd6a7b51f571 100644
--- a/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
+++ b/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/hte/hardware-timestamps-common.yaml#
+$id: http://devicetree.org/schemas/timestamp/hardware-timestamps-common.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Hardware timestamp providers
diff --git a/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml b/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml
index 68d764ac040a..6456515c3d26 100644
--- a/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml
+++ b/Documentation/devicetree/bindings/timestamp/hte-consumer.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/hte/hte-consumer.yaml#
+$id: http://devicetree.org/schemas/timestamp/hte-consumer.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: HTE Consumer Device Tree Bindings
diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
index 69e8402d95e5..c31e207d1652 100644
--- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
+++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/hte/nvidia,tegra194-hte.yaml#
+$id: http://devicetree.org/schemas/timestamp/nvidia,tegra194-hte.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Tegra194 on chip generic hardware timestamping engine (HTE)

base-commit: cc63e8e92cb872081f249ea16e6c460642f3e4fb
-- 
2.17.1

