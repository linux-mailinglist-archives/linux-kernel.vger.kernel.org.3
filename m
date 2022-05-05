Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490D551C5C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244481AbiEERLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382377AbiEERKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:10:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE14580D0;
        Thu,  5 May 2022 10:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqPiTD6vUGfsDV15DTqVGR0hvs90pHYhAoeL6vDVsAWMi6ws7+roSwXdAKhIwpqcZb/xetth4hala0kf4IgoIxNNAaR177FnlB7RPviXvsczU7GrkV8X4bDdMIlMI7tXJUG5gHNHepwEiEgqexW9dDxTvaCMAMUnzga7uRrHW5m1RQjocCxCwbvbQ5jvUeDEsvFDoXy1HP9SxW7cuXGd10mW238XDmBVNb2FCsfT+ZAZdknWuT69gq8adffP9OmTr0a9Pp4fOoXwmVMxynXIVJ8cmo904yA3UqZW8LWqD8wVIfIJCwLNvpUF9yDOgQ36VVD/kYrqXtyJt1WqnjTPdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eG14c3KRpTkDKkRI9q+DcH6s59wZ2nhUVcQxRA8QMEc=;
 b=Hpu5mynLqRq5MHZJwsBJ3zXokPiKPkho0dwiVr8fQYCs4U78AB8BHU52BVyD3FqZphaPfXL2d7GcS03Y7rMv6KIakSmXN0GAPW/w+mhGXUTpPY88t4+jRR/HYyIdQucQMfzLa+b5hj2DcCF74GBI8cmeiBTdbPBRf2UYmE0/ZUTiua6yNe3m6DOcI0vhRJ7QoNkwg1kzlL8J7iP5VvEADQfbdUW8SozKfuFaiCQcuf0Wc9HwGHhSFAink0qw8WHwu8Wu8xIpor8b2KzwqK3ROZDjFwHVl/UB53ZZiYVGWPPkHXUi7qMH/itr+5qHVbsTyhVk2D5SbUx9PbLtZgNsKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eG14c3KRpTkDKkRI9q+DcH6s59wZ2nhUVcQxRA8QMEc=;
 b=OS1KvLfT6FMGZZnfHoRvZbfK47ICwIXTBrJZuQgWNauLx9lOEkEt9NbRekE4T5pG+TS/QGyKfLISD/Dbs/eZb5hujAPBCTRb2VYkVPCe+Z+N/JLvrsdmrCKn1M3b5zwleFnFOBKJNX7dCDyfrHEfkfQCXKkesC7WQ5WHhy4HL23vJ96Y9ivtJ2lOcR47ZvcUN5GlMLBPmykpSMZWmfmtOe0cxRPRlgXyr753aqoK1eRCOyQbVTVGW+HGTOQhmEF4gzBb+Dyx22JfINQOVtSKxtwqUWOx9DnDXzVERfknrAoUjhLhWUm3+4Bl3pSY9w9lFK1jStZTngkgGjX0DRANsQ==
Received: from BN9PR03CA0793.namprd03.prod.outlook.com (2603:10b6:408:13f::18)
 by DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Thu, 5 May 2022 17:07:00 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::5d) by BN9PR03CA0793.outlook.office365.com
 (2603:10b6:408:13f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Thu, 5 May 2022 17:07:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 17:06:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 5 May 2022 17:06:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 10:06:58 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 5 May 2022 10:06:56 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v4 4/9] arm64: tegra: Add node for CBB1.0 in Tegra194 SOC
Date:   Thu, 5 May 2022 22:36:32 +0530
Message-ID: <20220505170637.26538-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220505170637.26538-1-sumitg@nvidia.com>
References: <20220505170637.26538-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6f779cd-d98d-4c44-9c45-08da2eb9ab21
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB541387D686794CBDD53DA3F8B9C29@DM8PR12MB5413.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JhER4guImk5YBMEMDYW5zGHAcy2mnPiPm+x8cmPSYOBGx5dY4vf52UtW0TB/2vM0MD+3Y+Ee2lBvv5dwUpxywi6QnnipXVaje3YBsoIjqDt2LuReeTNTwD0KveOkdSWM4vjv0+dzoU5o+vIaK9nRhrSlnJUxfwHa8wf2hCnmhFlntqMsVbX6NRyXcdpvl2YEEScYJNkfzLkoOGckCX6fMsXpK6dCUHTmmzy700WXzKSmy5rQ/DaQ2QY/SrSwR1TBFtqquNOniuSNUQejTTiLwKGAID5anEMkZ93N8FYY2mVZrxQW3rxm6FkECOvOwYk/6TPyzEq2Wi5ZGtn0pRocJl6OfNpej9Cc4lhYpGnUj4ckzs/8EvdTCb24Q716wdFRLxuPh4bQqCaB/MI94pTbI1+o/dOsb9YJy3/KZBUvQUkjvPPRHqFjtoo1fwB7wlxFXKtUkQ+o1AThbx7V8qGYtCc9cYPEmU5c5Zgmb3uMX1MHpO2ndyhJLs+1NKQQVRX/4HvtJCXmaNkZLPn/mBKTSNfEZ32fnCZ8tLr8AmOPdcTQa15WhTBOo0GEPxSkKviSPB62vNg4BPFAQKqSlJNO52AjkbY5hrX4ENU2WafzSsBVN9cA/iQmz8dVnDZ9ozKU81bKlb9CWQAo1xBFDZCtLnOIS2Sr8Z7DW0kWmf8vmPLfjLiUInsg2KRkOJdszdclyOPSYEKOXj6BAQFL670V9w==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(83380400001)(70586007)(40460700003)(336012)(426003)(47076005)(8676002)(70206006)(107886003)(4326008)(81166007)(54906003)(36860700001)(110136005)(82310400005)(2616005)(316002)(1076003)(186003)(2906002)(86362001)(26005)(36756003)(6666004)(356005)(5660300002)(7696005)(508600001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 17:06:59.9561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f779cd-d98d-4c44-9c45-08da2eb9ab21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding device tree nodes to enable the driver for handling errors from
Control Backbone(CBB). CBB version 1.0 is used in Tegra194 SOC.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 62 +++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index f9d343b24597..40ad58a1dd10 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -23,7 +23,7 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
-		misc@100000 {
+		apbmisc: misc@100000 {
 			compatible = "nvidia,tegra194-misc";
 			reg = <0x00100000 0xf000>,
 			      <0x0010f000 0x1000>;
@@ -88,6 +88,27 @@
 			gpio-controller;
 		};
 
+		cbb-noc@2300000 {
+			compatible = "nvidia,tegra194-cbb-noc";
+			reg = <0x02300000 0x1000>;
+			interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,axi2apb = <&axi2apb>;
+			nvidia,apbmisc = <&apbmisc>;
+			status = "okay";
+		};
+
+		axi2apb: axi2apb@2390000 {
+			compatible = "nvidia,tegra194-axi2apb";
+			reg = <0x2390000 0x1000>,
+			    <0x23a0000 0x1000>,
+			    <0x23b0000 0x1000>,
+			    <0x23c0000 0x1000>,
+			    <0x23d0000 0x1000>,
+			    <0x23e0000 0x1000>;
+			status = "okay";
+		 };
+
 		ethernet@2490000 {
 			compatible = "nvidia,tegra194-eqos",
 				     "nvidia,tegra186-eqos",
@@ -1442,6 +1463,26 @@
 			#phy-cells = <0>;
 		};
 
+		sce-noc@b600000 {
+			compatible = "nvidia,tegra194-sce-noc";
+			reg = <0xb600000 0x1000>;
+			interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,axi2apb = <&axi2apb>;
+			nvidia,apbmisc = <&apbmisc>;
+			status = "okay";
+		};
+
+		rce-noc@be00000 {
+			compatible = "nvidia,tegra194-rce-noc";
+			reg = <0xbe00000 0x1000>;
+			interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,axi2apb = <&axi2apb>;
+			nvidia,apbmisc = <&apbmisc>;
+			status = "okay";
+		};
+
 		hsp_aon: hsp@c150000 {
 			compatible = "nvidia,tegra194-hsp";
 			reg = <0x0c150000 0x90000>;
@@ -1576,6 +1617,25 @@
 
 		};
 
+		aon-noc@c600000 {
+			compatible = "nvidia,tegra194-aon-noc";
+			reg = <0xc600000 0x1000>;
+			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,apbmisc = <&apbmisc>;
+			status = "okay";
+		};
+
+		bpmp-noc@d600000 {
+			compatible = "nvidia,tegra194-bpmp-noc";
+			reg = <0xd600000 0x1000>;
+			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,axi2apb = <&axi2apb>;
+			nvidia,apbmisc = <&apbmisc>;
+			status = "okay";
+		};
+
 		iommu@10000000 {
 			compatible = "nvidia,tegra194-smmu", "nvidia,smmu-500";
 			reg = <0x10000000 0x800000>;
-- 
2.17.1

