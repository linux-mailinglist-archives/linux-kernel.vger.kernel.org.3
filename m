Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A5B4AE8CD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbiBIFGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377714AbiBIEcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 23:32:04 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BD1C0612AA;
        Tue,  8 Feb 2022 20:24:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhPsm8T3wEIpOM+t7r02wP6jcCjcTxv1JvGb0ua7ZfBk3FiqArC5tBKq5JT+gIfS8gvqF9yOZjYTqygmykUqCsthjarxqB6hY0WWpET2h+KUvn3bkp31TW9Yq95aFH18+eThf5AXjDhxGvVCzaxs/6DO2kgv2qvIqLH4PJYcafUGUmWO29hNzN3jyMMstcfmMVTfIr0SIx3dY5jKE3nLZDIQBo7iP9I99CwfVTO1f0nTWNPqT0GlvdZeM0ijdJzkORn+1vjekB9tgenSrLiOpBf0agD4MiQ7NlQNDe7mJ8FrntIu6z6cTyhH1hfI/nIiwjnfQtNf1yYCk33dbl52Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZ8pWhBYxN4Z8njNSU7NHJbHmRMuwUbMwx09/TIKk9g=;
 b=VkMwn7IpIBpwbQLMi2CVAZCDU+jPzGDbIoSCaJT+Eu400BO/4gP5HIJhOKEr6JLdhtulOXs8k4RYlQhV2nTj81fFwkAfzk26TJt7xS35i0TVj9327Phf4pzWK4MAMZ6cJgaIIthUL/ciRYY4refPKWfYDQE9MBVeShyIq7VMLmN/2OlBCFYC/PPn8hUQBeRXO+/Pj96hDcygl07Qb5EyJr3IfwV4QfDL6qb9P/xwtSKJKXvoYYzaRgXJ+AaddXdVJV2OgMV6faugyUyAnq4luVEYF0pJSfBH9KSpZDJSiRFnP5kA/PxIkC+tVyrm3QLNkeGCsG3Q+tWpgLHgYwKG8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZ8pWhBYxN4Z8njNSU7NHJbHmRMuwUbMwx09/TIKk9g=;
 b=CQJeakIJW73YX1Q28abiYsebgYySCLgVQvCU6Buq8POK16ivzF2HMdH3o5V9wGZMRyckxrkBc5sVmHarCPjAWI4IVXXTthGCWWrOP0tKqyvF9hxM+p2YnElQ+9jKcKe6jRAQTImDSXIPTnbJPgFS94pgA/oXzu9695jIK/Fxr2vkn20FLu4j2ppLTNM98FY5xsYR8xG2hc02DrgozPWTmhoMGOJkD527ReM0vPLsNrZpuBtnlQQ7gKHlaenbvE1uoKhrxp2Q59ULfvCoaE8Bq1xQfOo/Cwvb413YMqwXCdk0yd6Ibt6TFhiPxb+8bKg9l7jGTsUhA76av0MzHBuiIw==
Received: from BN9P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::18)
 by BN7PR12MB2673.namprd12.prod.outlook.com (2603:10b6:408:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 04:24:07 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::54) by BN9P223CA0013.outlook.office365.com
 (2603:10b6:408:10b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 04:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 04:24:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 9 Feb
 2022 04:24:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Feb 2022
 20:24:06 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 8 Feb 2022 20:24:02 -0800
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <spujar@nvidia.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH v1 4/6] dt-bindings: Add HDA support for Tegra234
Date:   Wed, 9 Feb 2022 09:53:24 +0530
Message-ID: <20220209042326.15764-5-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220209042326.15764-1-mkumard@nvidia.com>
References: <20220209042326.15764-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d7570e2-0d5e-4ea0-ad6b-08d9eb840391
X-MS-TrafficTypeDiagnostic: BN7PR12MB2673:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2673F3A843C96F8E6AB8664EC12E9@BN7PR12MB2673.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDVIwO8Kj/1eRpWOBkIzKhcL6XBaNrAMatsRdoHpy7kWLrFYyjdJqJhhVdTD0LtmB1QXeQJOkFOits6SMb69Y2ZmGEJx3VZQqrW7iyf+kvPBvUSYlmQZl8gVkIWrmr+TW4gph3TW58Ek4+N7cBk2zpARMPg3X8gfUQZOvlwa89ur73hIKQk6VGIEhOXJnFBr4kX2B6zGlLFv/Xo2sHTikE4Yq2189SZoN/j5GpgNs6ISS2Or0EYdasFpXRNmWvzcqi2230ocleqveMwSFAsxmcEKgR08c6khPVWsZnH1IyLxwvSX0Y4z9OYDdsA8+OdtdCClovVrI227a8AVQF+chDT6g6ARvQUma0S2Zh5obQFwqEyJdilz8tEtRDPOqLNKZs4EciXK9bUrrdOluSDuBnv4NsTSaDwzKmIL92LIhQkimpR2e7IURX5lumG71AcRrSgO61Gb9zpeNxlrAlHcAU3IVo1PnbO20tfFhVxtE4m3cLl08+67Mcvnjy49rf6il6UOcKifz0DGZAWnCUnK45dzJA37P9LfzKGWOs8INsv8vpuudhZcXbkXR4/RjRsadAV+B4H+8XtDIGzVARIejajxjDdceeAPp40O941IPyBBDT90rFx+0Ml7IFoPrWyg1iqkwtSBhZ4SqcOWHtf97ecWHO9V8nowGb7S7WYkembEHpQpv8gXQEIJu5e4cMEbDZnnL83tiwfSkm11kaLXr5CVHdDKyA2Yekd2/0jAghA=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(8676002)(70586007)(508600001)(356005)(7696005)(70206006)(6636002)(110136005)(316002)(54906003)(81166007)(36756003)(2616005)(1076003)(107886003)(426003)(336012)(83380400001)(2906002)(186003)(26005)(47076005)(82310400004)(40460700003)(86362001)(36860700001)(8936002)(6666004)(5660300002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 04:24:07.6006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7570e2-0d5e-4ea0-ad6b-08d9eb840391
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2673
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hda clocks, memory ,power and reset binding entries
for Tegra234.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 include/dt-bindings/clock/tegra234-clock.h     | 4 ++++
 include/dt-bindings/memory/tegra234-mc.h       | 6 ++++++
 include/dt-bindings/power/tegra234-powergate.h | 9 +++++++++
 include/dt-bindings/reset/tegra234-reset.h     | 2 ++
 4 files changed, 21 insertions(+)
 create mode 100644 include/dt-bindings/power/tegra234-powergate.h

diff --git a/include/dt-bindings/clock/tegra234-clock.h b/include/dt-bindings/clock/tegra234-clock.h
index 8d7e66e1b6ef..c014269b7245 100644
--- a/include/dt-bindings/clock/tegra234-clock.h
+++ b/include/dt-bindings/clock/tegra234-clock.h
@@ -30,5 +30,9 @@
 #define TEGRA234_CLK_PLLC4			237U
 /** @brief 32K input clock provided by PMIC */
 #define TEGRA234_CLK_CLK_32K			289U
+/** @brief CLK_RST_CONTROLLER_AZA2XBITCLK_OUT_SWITCH_DIVIDER switch divider output (aza_2xbitclk) */
+#define TEGRA234_CLK_AZA_2XBIT			457U
+/** @brief aza_2xbitclk / 2 (aza_bitclk) */
+#define TEGRA234_CLK_AZA_BIT			458U
 
 #endif
diff --git a/include/dt-bindings/memory/tegra234-mc.h b/include/dt-bindings/memory/tegra234-mc.h
index 2662f70c15c6..f538fc442cee 100644
--- a/include/dt-bindings/memory/tegra234-mc.h
+++ b/include/dt-bindings/memory/tegra234-mc.h
@@ -7,6 +7,8 @@
 #define TEGRA234_SID_INVALID		0x00
 #define TEGRA234_SID_PASSTHROUGH	0x7f
 
+/* NISO0 SMMU STREAM IDs */
+#define TEGRA234_SID_NISO0_HDA		0x03
 
 /* NISO1 stream IDs */
 #define TEGRA234_SID_SDMMC4	0x02
@@ -16,6 +18,10 @@
  * memory client IDs
  */
 
+/* High-definition audio (HDA) read clients */
+#define TEGRA234_MEMORY_CLIENT_HDAR 0x15
+/* High-definition audio (HDA) write clients */
+#define TEGRA234_MEMORY_CLIENT_HDAW 0x35
 /* sdmmcd memory read client */
 #define TEGRA234_MEMORY_CLIENT_SDMMCRAB 0x63
 /* sdmmcd memory write client */
diff --git a/include/dt-bindings/power/tegra234-powergate.h b/include/dt-bindings/power/tegra234-powergate.h
new file mode 100644
index 000000000000..3c5575a51296
--- /dev/null
+++ b/include/dt-bindings/power/tegra234-powergate.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2022, NVIDIA CORPORATION. All rights reserved. */
+
+#ifndef __ABI_MACH_T234_POWERGATE_T234_H_
+#define __ABI_MACH_T234_POWERGATE_T234_H_
+
+#define TEGRA234_POWER_DOMAIN_DISP	3U
+
+#endif
diff --git a/include/dt-bindings/reset/tegra234-reset.h b/include/dt-bindings/reset/tegra234-reset.h
index 50e13bced642..2ab61c69a3d9 100644
--- a/include/dt-bindings/reset/tegra234-reset.h
+++ b/include/dt-bindings/reset/tegra234-reset.h
@@ -10,6 +10,8 @@
  * @brief Identifiers for Resets controllable by firmware
  * @{
  */
+#define TEGRA234_RESET_HDA			20U
+#define TEGRA234_RESET_HDACODEC			21U
 #define TEGRA234_RESET_SDMMC4			85U
 #define TEGRA234_RESET_UARTA			100U
 
-- 
2.17.1

