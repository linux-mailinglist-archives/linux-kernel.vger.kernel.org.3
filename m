Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C1956091F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiF2S3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiF2S3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:29:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF4B27B16;
        Wed, 29 Jun 2022 11:29:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cb2+Z4dHSodk1dxm9qEEG6TKBJ3FU4YX2zI+/q9KXfgPEZQQeauv3blBJUn/3ilLvCe/lIBq187pobpTWR2SJCKd0gq/DutmKvxhgUpo3nzq8d29I6lrotrHMhSKHGXj6c6+IWy278IHLg3GEHyqrCku1YeoY7Dhk9Nq3kZlOoFQ6/CMZNGe9KTbgS8D271lC+fG6mrU+tLl7yZJEupnQuyOcuSfdhWWpp8SpFfi8dbLim6cah3OmucANJFfccnYscDtcJmsik9d4XePxjXO0KO3GICgZOI8df3C1AW1MflwSehoLfaleTyc/T5P1Q7Z1XUO8Oj8+Mw9XlUQ3KNNVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9WVzM7NxBw0OAk9OdScaj1tfTOaBvGBi+xBegen34c=;
 b=BFfpHFcmi6RDio1D8HwEROuRWZnjfJNQYnIzvTsjwe8fMh5qzUXxoxKLNZRmYjJIGASW9ikQ2P+emU5GHmtC2y5R7T1aSlx0Z2vITQTJkWoMk+DTKnDKBTnNA0rz2zWUdglI6vzGhvwM1RQA5BwCEIzvgfLLwjszvkAItYllyCqJfiqOzVfgRTUN66U/viKRz8QDdbO4ozDgF6OFBnodYsk1FEqNNnbKyYF6kvpKEox7Rm8eUGq4BSL1sSTQXJ56BksOPQXOdy/3lh3lul1vLrupwHS8LT4bhmBqR0c8XqM/8LInxm/iNRDgUXP7714inwXLkdB+chyjhsRAJeqj+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.15) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9WVzM7NxBw0OAk9OdScaj1tfTOaBvGBi+xBegen34c=;
 b=X4Dv5L7iNvdiJAoJqnnjWaiVGsuTJiWXV87tJh7nmZMamSzDDnCwgEpFgAr6dZc2QbqOZR3qQiMw2iUo6SpKLokeCmKiLvBsSCrFRc8Tj8W+v8gDE8zf9vw1+5w+K4BpAYaBZYu1MArZKEHguTEYrlfhRSS4lFcgogc7vndDgjCcR50L0ZoPmYEpPSK0tjmmDINfDOj8qEAkQN5YYkTok+oR5XcGZTLo6u+xR79UWXNbTGIJOMrNfLJLnlfj4Fk5TcGWUFRS4kApTivnGCDTuSBiR6wBUrLqMVKXLhO5uvIsB5FCSupuwzRtbz7IM5v19S2favF0x/GmVO4xgcuShg==
Received: from MW4PR03CA0012.namprd03.prod.outlook.com (2603:10b6:303:8f::17)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 29 Jun
 2022 18:29:43 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::5b) by MW4PR03CA0012.outlook.office365.com
 (2603:10b6:303:8f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22 via Frontend
 Transport; Wed, 29 Jun 2022 18:29:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.15)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.15 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.15; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (203.18.50.15) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.21 via Frontend Transport; Wed, 29 Jun 2022 18:29:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 29 Jun
 2022 18:29:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 29 Jun
 2022 11:29:39 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 29 Jun 2022 11:29:35 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <akhilrajeev@nvidia.com>,
        <rgumasta@nvidia.com>, <pshete@nvidia.com>, <vidyas@nvidia.com>,
        <mperttunen@nvidia.com>, <mkumard@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <kkartik@nvidia.com>
Subject: [PATCH v2 6/6] arm64: tegra: Enable native timers on Tegra234
Date:   Wed, 29 Jun 2022 23:59:04 +0530
Message-ID: <1656527344-28861-7-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656527344-28861-1-git-send-email-kkartik@nvidia.com>
References: <1656527344-28861-1-git-send-email-kkartik@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1dd4413-cd10-4a22-d750-08da59fd5628
X-MS-TrafficTypeDiagnostic: BY5PR12MB4289:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vs61iY49QeoPCcpdk9foU5161Q0zKGiCfBGghqZ9/X1AlX2qmX4sAA3u450cPU0OWDGPHk//XJ8F4JhPpylLBgiW67ninc+wzi2XyGlpU5JXkRXLBWhZFXXaRgiJPR1kxW2FMlEJ9CTB0K8hBO+Ep8XtXrJHB+ULqiRBLsUpQVF6IWo5FiXj7QybSLyxMELa/Vk543ucTCgjR9v41O9jGlewmcmV6uyMq+82r+OJNxsoHOQksnWNv6u0aIVXTu6p+v1QJW/GKaZSEwd+SYJVCZDrA98SX2RlF2t7ZOskMtpz1r/a1oBiQqaRHceXoSOAFNOGiGeg8CW+k2vrYwtG66dEFDwZ8Sm6qi8XX0Vye8arqcOy2bs9CP1jkAFhRplV6q7jXdfufIbIYTX4MMcKNB4s0VXwCb9N+kAQD2P6+Jw3RsNfolJ3UqO9dBBOT4IqPXc+4il+kmjwsrpyqbHRJrhu0MHpGqN4ap9Cs6kClOhg1V8BoX0WS4PTwt7EIAJ8AJ95wzlWqZD+wZEx8tOAdFuNsKLHbp87yD+6/8GbNTOPobOo9NfhNUPY66XpoLgQzSRRidAujRnL/10S5xoOhdOYxJRkEt03c8AIJuZ9aw95CJpmCSRNG06dX+yn/YbrFo+4HRIDn6jr6IcFDwI+ijx748ilV3VYnVa3UKS5KAJq4y1isGIMhJHDorV6FC7Qy/ADtf6t2ErAg97OzPD3zWyehncz1CuyEPZtg0yYpbcN3ThLq7Q5lXVIwMwuReV4777VluYYqE+c5y+UMEJN8T8L34svTQlKIJF0SkO+nFJrBRail+b4jN9/CSUN++NR
X-Forefront-Antispam-Report: CIP:203.18.50.15;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid04.nvidia.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(346002)(36840700001)(46966006)(40470700004)(40480700001)(36860700001)(40460700003)(83380400001)(36756003)(47076005)(186003)(336012)(426003)(82310400005)(41300700001)(7049001)(2616005)(2906002)(316002)(110136005)(8676002)(70586007)(70206006)(26005)(8936002)(7696005)(5660300002)(6666004)(478600001)(86362001)(356005)(921005)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 18:29:42.9868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1dd4413-cd10-4a22-d750-08da59fd5628
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.15];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index cf611eff7f6b..aa8ceb3c329b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -519,6 +519,28 @@
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

