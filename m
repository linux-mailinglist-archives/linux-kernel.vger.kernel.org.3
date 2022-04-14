Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0419350084F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbiDNI2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240943AbiDNI2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:28:42 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2073.outbound.protection.outlook.com [40.107.101.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D29962A0B;
        Thu, 14 Apr 2022 01:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd27uU3JHtXrylViL/yQ6xyK55chlE5QS4326wQ+6W1nSYgKOn8olK8l4lPlw/HCRvg3lqAM3Oh5TIljODgsOqby0Z8hrft7HR797+eC5kivLjkPAvbwkm2Il4SDXXY5oDPnDGBxLtReFG6RpfZqgNUcd2YJPGOe8TJc6oKereqWdzANYjAUfz2iaMWnBll21T0tFWzf8M46hh/GS19HyFx+f/GCS49/XhBYTsBNcSavIfi+IM/JaOzEbQsyBjRSATWhWLImArk3EkDwR8CM4nNtCYL9L5x9wVHLwvYamDLheELV0+AvKrJ5d+CGibSaeFlirAPRtoWOoRE/BT+YLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mnb8JimGRtHYkhbofNSnWHiAzSYjtmeLFuBWyg4h8c=;
 b=VboUP5JNR8rS+03Ml49MHBSp+XDUsbcNrBrC/o8uxN5MJ8JG7akeoaAWrvgmswshVYx+s6+y2f8vLVt3oChK4ylmmMuCzNitXpq3ZQviwoWkGUWbMonpGEaWPs4HIgL4Czl9YtVmJdTpZWNZYPsq/0nUKZ3SPpcKqw34751KjBttACWLUj1FfSW2NdpoPN1/HlOOIqQ4Fp1wyhqUX/Zym3ikupkYNxh7zl9oCH0GcKoHoElQk722ZlcjDjaUqe0aOa7mYIT3IygfuyhwZAwoSRQTyFkMf4hfErk72z3/Q3PaM0zScOA6ENd2PV4GnUVBebbbbrNfcLjlP4933LJrdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mnb8JimGRtHYkhbofNSnWHiAzSYjtmeLFuBWyg4h8c=;
 b=N3C2RZrf3ACb5rPJu2TQ9jQ2k0eHzjVaKtmzEbAN4kRfbx5Q5P9atsJ3ljiqaBNHxdemTzjp0stBk/0g7xR4FJUPAm62ZpaLX05RtMlW6mNIA+DKCmh0yQTaeKjjSwSN0NrubrevhlKrz+Vxp7UpERMlasBKlil323lEn9LjLcQOPrlNyci2NXuFq6Ho2ou5bm1Fm7PGID2A6cLZ19HhFaGTfriSZks37o3Ct5JlhCWAtj4X/NBPI90hQoqKgvdk2ncJhm7M6euk8ZPWK2V4uTsW1+IK+NOXOdgUlbZdixWaR7OwTZFO1u7tu0uSpQGX2BZZQyugy103uutTys66jw==
Received: from BN6PR22CA0027.namprd22.prod.outlook.com (2603:10b6:404:37::13)
 by DM6PR12MB2697.namprd12.prod.outlook.com (2603:10b6:5:49::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 08:26:15 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::63) by BN6PR22CA0027.outlook.office365.com
 (2603:10b6:404:37::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Thu, 14 Apr 2022 08:26:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 08:26:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 14 Apr
 2022 08:26:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Apr
 2022 01:26:13 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 14 Apr 2022 01:26:09 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <akhilrajeev@nvidia.com>,
        <rgumasta@nvidia.com>, <pshete@nvidia.com>, <vidyas@nvidia.com>,
        <mperttunen@nvidia.com>, <mkumard@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <kkartik@nvidia.com>
Subject: [PATCH 6/6] arm64: tegra: Enable native timers on Tegra234
Date:   Thu, 14 Apr 2022 13:55:38 +0530
Message-ID: <1649924738-17990-7-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649924738-17990-1-git-send-email-kkartik@nvidia.com>
References: <1649924738-17990-1-git-send-email-kkartik@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1258e399-e489-4589-77b1-08da1df07137
X-MS-TrafficTypeDiagnostic: DM6PR12MB2697:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB26976B3DC25E79B66D717EBECDEF9@DM6PR12MB2697.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ezRIoqVitdA5MqNVUyAOxpCrMJDktqD9s9dQNlDdxrD6YqABqCl8DEI2r4dD0F7rfTDCCTPHvJIQyz7r4ZZuXiDIOzwVfpEnIzTZQRUsE6J9h6c79LcMw/+GWeF53ccTT7bu4ydbBKgJC4W8AhLbAk05TzgDoipqgzuCXLNg3B/dQI878QdPeDeWuy76XTDWJgg4D1dqsGQMVLPDMHd1yIjBUHoXvcGCZWZDARWs1GBu7wWBWLxpO0qYiBNrk7rcbq14BzNHiGD+zqkcZrZKiAZFzIhV2PVDzCo9Q2TRJsm2efVBGCmjK02eicC7DBH8ZF/xsYdSTq5DQUQK3kJtEvOWa7ZMxt+phKkO8X4+1EGWESsXqi+HgszCdchTglYIBFvFDQLNqmeUlhD5e3xNvFRB3Po/svKeG5kRSdNJjc7upBEarVra27VL/hznlzHOc6bv7jwl1SFVKto3xp8HDa8tSzHRD50X0rmffhQSH0bDd9hssMEmAjczHssLEPxy30ASn022mxX+z8ClxU4jtqWAXSgGWHBhBKv9H0bhlYPFzK+5JbGADfFA+tQpjhtJlyqLQiVnX63pxAtAkGAWLeaCo3wDzKiqH2xJTF6mNtT80oh5LemYxSWPM759bWwEL8GYzM5WD94VBuXxeEqPGVku83uIre+F9I5itEYx/3rR5kR3DFdnFX/iRFINuPXcCW/THQqorAjEmcWktLw/BIiJUTOjNlWSkcT1sccJJnU=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(316002)(7696005)(47076005)(426003)(336012)(40460700003)(6666004)(82310400005)(86362001)(36756003)(83380400001)(5660300002)(26005)(186003)(8676002)(7049001)(508600001)(36860700001)(2616005)(70206006)(70586007)(356005)(2906002)(110136005)(81166007)(8936002)(921005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 08:26:15.3444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1258e399-e489-4589-77b1-08da1df07137
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2697
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The native timers IP block found on NVIDIA Tegra SoCs implements a
watchdog timer that can be used to recover from system hangs. Add and
enable the device tree node on Tegra234.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 8767dbe2d066..47e0500a3838 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -446,6 +446,28 @@
 			status = "okay";
 		};
 
+		timer@2080000 {
+			compatible = "nvidia,tegra234-timer";
+			reg = <0x02080000 0x00121000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			status = "okay";
+		};
+
 		gpio: gpio@2200000 {
 			compatible = "nvidia,tegra234-gpio";
 			reg-names = "security", "gpio";
-- 
2.17.1

