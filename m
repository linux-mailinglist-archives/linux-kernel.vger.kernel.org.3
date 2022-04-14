Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07AF50084E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbiDNI2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240944AbiDNI2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:28:42 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2071.outbound.protection.outlook.com [40.107.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F282A5F8F5;
        Thu, 14 Apr 2022 01:26:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ox8Rd2aGAvv5O+NW4/hVDAZkQt9ZUJCWJLk3SVeken3pNpmR+Oo9kVecKAyZ/9BCWFy7fpzQ5x+9PcxvvEK04FQ4sq9wp/JGkt46Deqs+bNcp9mZ1ye4ClO3h+kF3fWuflet11510OGFEsAq6T35kmY06sPgyVuw7hKbouxhGmIS8CmPlVRlS43yN6cNJmed9Ol/Pv+e8OO5+Zn0E0RSGE9ODynfIZSNqHAv0v7GrTPNIy4g/A1zbcjsfwROMf2jJQu5uL7g+RQ4uuNnwsNm2rXyMHGg+LAluVYl/Yz+OyqbREo+PV4Jg7Dte+e4Un2nzYiQ2Ji0s0YTznZ0zozwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMNbZSeZegM0+xNk2Dde6puKq4p9tgRHdo8flLTkPRg=;
 b=MF+kMnQZYcXlo9l6tzCtTldxqcYzS5Gs2D01bKA0uVsD7/Pb7ecYaiWzWnXeoDetl0tGUx7RrjEYGnPkTzLDm5Pvxss/+5/agtrTiiYybRhWKO/pFTqUzV5/SOghyX8uozPudz/70BiyQ2rIDYfZc8Ci3nRipvBtoLiPYgYrSyZ7hQQXxE3LL9QOwpUQHqWFg9VTYe/NjfQU5n4X8twIYCO0NgIes+bzhOYl7S7H8YWbQr6pfjqZCS3h2YrLg57uFxeo1gPPS232+hTb4KXdSSq6l2fyrZ+nARZBAEjnykICY7TagNBW84+NJegpwYsCmMlDVS5xidq8Bt9ephlugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMNbZSeZegM0+xNk2Dde6puKq4p9tgRHdo8flLTkPRg=;
 b=mrXrP+sojKefra/klg30/Q+RFx+a7pptr765f+HdvWFFS5FWq1kgHZuaqwbzBHhrK0GR8VTfQWNlNi2t8S2VkDndJ9bOdkL2rftHqmT3cJaKnvWQePG1SBOC4qc8OsfCdnwJhHrUyrfKPuF+WQ1fKVSph/UdsdesgZ5Itx3tC0BDczJvuZzadWLxLu3dx3D9gES0piqGByxTCHyDqGOVWiePdN9sFhh6mUUdF9+/kjdh/cvM+mGUmJ6uB7+sUzldSJMHxird0/LXx0ykJHel6LA7IRWNJleZuRZC9n+CxQH9Wtv8eFOpmz3Cphp39nt5H491K4cgelF+AXLN5zFO1w==
Received: from DM6PR07CA0083.namprd07.prod.outlook.com (2603:10b6:5:337::16)
 by BY5PR12MB3812.namprd12.prod.outlook.com (2603:10b6:a03:1a7::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 08:26:10 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::fe) by DM6PR07CA0083.outlook.office365.com
 (2603:10b6:5:337::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Thu, 14 Apr 2022 08:26:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 08:26:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 14 Apr
 2022 08:26:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Apr
 2022 01:26:08 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 14 Apr 2022 01:26:04 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <akhilrajeev@nvidia.com>,
        <rgumasta@nvidia.com>, <pshete@nvidia.com>, <vidyas@nvidia.com>,
        <mperttunen@nvidia.com>, <mkumard@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <kkartik@nvidia.com>
Subject: [PATCH 5/6] arm64: tegra: Enable native timers on Tegra194
Date:   Thu, 14 Apr 2022 13:55:37 +0530
Message-ID: <1649924738-17990-6-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649924738-17990-1-git-send-email-kkartik@nvidia.com>
References: <1649924738-17990-1-git-send-email-kkartik@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ff0b61d-1f6d-4cff-caf9-08da1df06e3f
X-MS-TrafficTypeDiagnostic: BY5PR12MB3812:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB38127FDF2050D87A5790B72BCDEF9@BY5PR12MB3812.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFHwJAjbotKpSmtFcfNBztN5EfabzD8+w44RInn6Qq1PfmzkkX/05wCw65b3yIkG1es5aq0onlwxUdE04+yfYI2sQb48j8fne39lN6ckbfMjMkNJ6T6491OaN23+5eJ2ETD5icas1EF9dq7LUsLcQmXkxd2o6Gq8LPq18dEc5N4aPtllZYEEI42u3sULudN+hUO68+XBHER4uy3hdXQRn25CfB9YqYYU4dRkn5qrDUKq9zfVefaGP6ybMFO99FUIOmntHcKAtX11ntWmpZIfKtclgUtFPR18QTcHOVe6uD4tlHG0g8MtDbcPtc1qRbXzKbjaCVG5Ya/sXxLrfh8/qPJP0TP3aae9nMowuOd/Su3QgEiI6t3zlzAumvMruthPVf7Odi3Cy2TQE66Y7B3bAv/Dt3HSqCKThDtqdUDpRjNT48UQAu6ZxeIOpRDRR+KjrTiUgXkLlriSmD183ADcShq/lHa76ylW+BESY0afw5/aiAKovJiYJK/75QuqKYJ1ZkfpDphs7mvcPOeXsYPHz0OHNUvTn1ri0xtRaPJZ7RZtHJQH/12phyqzBWS/vF4lIVwLYJETZ/PQa3Vtz50XsUyxCsGkToQKqEa5uuROwRA78Q6uChiQl99IlamMynXh8nPaTzurvRB7yx0IhtQRDkOSHLtgBf/MZy+fY4LwBtTWWuvl+DGmkPaGD/5fELLTezDLeUY1+GHjEkWoJh3/H9F7N+hzXg6wwhfDmfnOmYA=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(2906002)(26005)(186003)(82310400005)(86362001)(6666004)(426003)(8936002)(336012)(47076005)(7696005)(2616005)(36756003)(508600001)(316002)(921005)(356005)(81166007)(7049001)(83380400001)(36860700001)(110136005)(70206006)(8676002)(70586007)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 08:26:10.4127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff0b61d-1f6d-4cff-caf9-08da1df06e3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3812
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The native timers IP block found on NVIDIA Tegra SoCs implements a
watchdog timer that can be used to recover from system hangs. Add and
enable the device tree node on Tegra194.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Kartik <kkartik@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 1d6be5774fac..fad2b1a634cb 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -649,6 +649,22 @@
 			};
 		};
 
+		timer@3010000 {
+			compatible = "nvidia,tegra186-timer";
+			reg = <0x03010000 0x000e0000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			status = "okay";
+		};
+
 		uarta: serial@3100000 {
 			compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
 			reg = <0x03100000 0x40>;
-- 
2.17.1

