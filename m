Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B13A56091D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiF2S3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiF2S3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:29:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953F427B16;
        Wed, 29 Jun 2022 11:29:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfb4HyM9lof+5PgJ/OMkY9XGEso7lcME3fS2O9HMnlrisI1iCJ+z5OslVHrKP5PqHbKPbTe4nQrk4GtDO8bHBJ8i4AJluMrjYYwEYoDl8Lkc0YjqFkexHZbzTBWWEhDe3aVECxY9O93bdyfovNw/F2kNxWMsq7p1o0xWjuH4l645n+O5AXgHqonEwQE1787sgi+1IuRORt83KMqsblWMUSMsGStEDSPH2UzgQV80HPiOEywzHI7N6QRSHlQaPuKmJElJDuQw+o2qttzdzpxHXDJNSJUbGOYnc4ZZxilOfpAqNP/tuA+ELKPXFmzBPnZzJBRQ6K5F4NS6lwWoXG6cew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXIrN3uXHaeCInASd2PmUFVjlPsl/JgwvWPSyYL3Bcs=;
 b=in88rBGO9A8kCWjsIELGA8WSxy7j+tubGjjwDGi4+HID0oyTe70IJO3HhZLoMWy58hgAvNAHVwUn0N78zRTJEF9gP9Vgjf1fpAOCSI+QfmzePT16AoS9WY2dEDNeIctc1tMmbhmeKorwS8tHwIfx2Zt84wQV9C2w+bTI+f35qRkIK3p3Ns6uPPQqrmUsExa3/qtv13goDs9gPI09TmQKofDAAnVi2zl6jUURW6uwQxq3bpzC/wSyaYBiQsdoNGgVyuMdufTdzPaJ5q3+Uzsxk3EOKK1X4SYSsUXyvfAAvFD0cyvwI8KCXuHadN44hLbyDxLoFTJmjJOC0Iqb2jXwEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXIrN3uXHaeCInASd2PmUFVjlPsl/JgwvWPSyYL3Bcs=;
 b=lE8ubQRK9z8f5qmBAqUwoEc3FMVwzPdsTsCCAf1ePDijmXgM23dImMWS4hos5j8VkJJUl8ZYlJGdCO0+Pr5ObJNC0p+N+mR6JSouIcZetSjC9MV8HjhwiTzA80iK0Rt/3wH336NOfKVeJYOBn2Q+ef9OfYYSPST4rWzaEqdY4bGiQYlHpeeCSQclW/uyzNZJU94p0mIL1hsgJzMITx+BdAi4siI5cIcE3RwKk/H1Mpc5ScQ4UPn4vUwebR3IkSqkhZEQBaq4DDvsejiv0l+fY4lJRgWiG3E5gWfIM5ta1juhDLyZDWwZ2N0VcLJpPJ4MVHJ1OfhEIv3X9t/DXja/Pw==
Received: from MW4PR04CA0185.namprd04.prod.outlook.com (2603:10b6:303:86::10)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 18:29:39 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::e5) by MW4PR04CA0185.outlook.office365.com
 (2603:10b6:303:86::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 29 Jun 2022 18:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (203.18.50.12) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 18:29:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 29 Jun
 2022 18:29:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 29 Jun
 2022 11:29:34 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 29 Jun 2022 11:29:30 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <akhilrajeev@nvidia.com>,
        <rgumasta@nvidia.com>, <pshete@nvidia.com>, <vidyas@nvidia.com>,
        <mperttunen@nvidia.com>, <mkumard@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <kkartik@nvidia.com>
Subject: [PATCH v2 5/6] arm64: tegra: Enable native timers on Tegra194
Date:   Wed, 29 Jun 2022 23:59:03 +0530
Message-ID: <1656527344-28861-6-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656527344-28861-1-git-send-email-kkartik@nvidia.com>
References: <1656527344-28861-1-git-send-email-kkartik@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e155458a-701d-4a36-9a46-08da59fd537b
X-MS-TrafficTypeDiagnostic: LV2PR12MB5942:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FjSDvNp7StLO1+I+0VVdsFa38jkYEAR7184+112Fd9+ijXBHpQ2wNNBU95wq1CkBwaSxACVWnEpW5Nt67vnr0njoatcUDIY3oKrU+dlweNkJ697ONedYKRIEfsnAEXdsqjUanoXb6sq7mNTWOunkHlYgr+4GXuuGnZJgzAHNCfEYiJ4HLNvr6rqw/AkuhaGy8DVBMfIMMUmu19KMMAmV0+oFsrbkRspnZDmfIgdrWL3gNRh/QWlT38A3jRgMCzw8ko8hZ1omL5bWdm737H2VFbWIgvlDxKmW2WE0BDnYD4S9IWMs78+Fy4IaPF8ujw6pqp9cUzPccnUEkwBa8LLnm49ILF+IpCVE6UlKMe7IvTltBtsTu8a3sls6B6LPApFcNuwPJL2efgj79cgm0lCl54HbeKv6GvdbP/tAxLgoqpBt85rn3xkd1FwY8mlSTrMHcozrWMgzyREWdycVDYS92grJbkyPRn+IWXzTwyQ1XjIkNMD6WCKVFzJn7YJXWlnVH0AtOpP3p7brZChWCnFmTpk3IQuxGvtK5NDflSw2W4YPv2zSHFZUB1SGVgA6pB0aawJ9JNH7BUoQnIY/m9aa/curfO9HgfvP9xH6ggzEFkCW+8yn7WhKlOFtPd2z2GR3IQRmTiswnWW1poZ06qF5tKCR8qbcDdSsAhdfwTX0dk0cqXbsVOcCJOiCs8x6QAZdAFcIYzhO8X6Wbzp+WRtnK0Hq4Twf/94cKTI2UHJSDIhuZxJNdSZ//jBRH9b9Q+Z/ZLMdpXo34gQ/Y3ZIdOewsL3kw3K+TedQ/EtshEfqfT5uEYmun5AbI1c0braPrI17
X-Forefront-Antispam-Report: CIP:203.18.50.12;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid01.nvidia.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(346002)(376002)(40470700004)(46966006)(36840700001)(83380400001)(70586007)(2616005)(356005)(86362001)(36860700001)(47076005)(186003)(5660300002)(478600001)(41300700001)(110136005)(6666004)(336012)(7049001)(26005)(40460700003)(8676002)(36756003)(921005)(70206006)(426003)(316002)(82310400005)(2906002)(7636003)(7696005)(8936002)(40480700001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 18:29:38.4804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e155458a-701d-4a36-9a46-08da59fd537b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.12];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 9566c6388ed9..4b37aec69448 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -698,6 +698,22 @@
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

