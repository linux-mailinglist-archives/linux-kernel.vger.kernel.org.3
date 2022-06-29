Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7CF560914
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiF2S3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiF2S3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:29:37 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F191C93F;
        Wed, 29 Jun 2022 11:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbqd6aJ81sHmpkLWftw14B+v2JJ7ZIvvNN9abWyjoIRjhE8EWDgfQOL3ViZoGNHBRisL46rILUH6rL5r8B1Sd5h6BAFLktgBkBaGdDI+7yWIVFsvlkPCB07X8DpXavPhIX4AhYGU/7LEX5xaLQG7w8+8pm4B/Cbn1IjiCQKyt7MWyiBO2NbkMTsiswqcfiaPtjjhkFmx7WN+Gho4do/fZ7UXswGpBLuxKoCxrxwjn/v2VMH1WSB7PFrAuf0PayQCCXsPneY5Dq8ht6bUjTqKtLghA/yb0ZHjMxlLD6xOsnTc1dFNhgLo72HQrvrucTtkjy4yShHwaexbJHu2eRAY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeLOet+QJ/Hmz6DRh3RFdcMlxSD5v2N07EybnP+/69o=;
 b=nyN3e0bSVjwxbZvGT5ncwZ00lAz8eK/egZthU+zfC3eMbB6tdjjI0NKUODR37L2Wfk9kSNSxoCbFS8i2S1wJIU6dSWM+9JqoSxe0swXyWWbx6m2PfOzQsCfa2s2LYAErFHaEQeu8P7opLxfogXcUoA0Va6ArugsIzPZqMEcXvj1FcBSC2lSwnZlzIL3Y+mNcr9psV+xONSDCqaDec9kL78k7hTU6Y1orzwTSisOW5di7/Lpya+lnlNfBppmtd6eu0FfCB+gUkwnz5wtN4HK1L1IPGGhUwJDm2Cj9/E0O/39xjobgIIeKxbP3legBWKl00n+1XYHhBz6xT1n7P7Zr1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeLOet+QJ/Hmz6DRh3RFdcMlxSD5v2N07EybnP+/69o=;
 b=Vd0iBkaMM0dyaJPfLKdPOrd1yp0wNc6bNwKcu2qs5+gfdsljRTDwHPihvT8PBKQf4FyaC53V/d+QzjcICgqt4wQyB16F6RhU/Zwta19zGU7osTE2OKRkE8pX2Tyi08gAIaD20IW+kqiVSq6xSWMnsUthsZuMqds+o6Z6DTyXu2T7SBiB+7bYGOFOusgnHoJdhwlWGwHPqm7ejHotVCjQDoolaQcxuKyny1kTkEsl6Lae+2j8sD4/Z8FPXFVgl4WH7gVdiNkf41P7JFWZaq6P++BXRh9Bs4vswHNEId5WJRaMrbrsqmxsuz6PPAvaCiAA6ULOp+n9ezuqK9xeid4jMw==
Received: from BN6PR19CA0064.namprd19.prod.outlook.com (2603:10b6:404:e3::26)
 by BN6PR1201MB0066.namprd12.prod.outlook.com (2603:10b6:405:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 18:29:35 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::4c) by BN6PR19CA0064.outlook.office365.com
 (2603:10b6:404:e3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Wed, 29 Jun 2022 18:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (203.18.50.13) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 18:29:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 29 Jun
 2022 18:29:31 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 29 Jun
 2022 11:29:29 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 29 Jun 2022 11:29:25 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <akhilrajeev@nvidia.com>,
        <rgumasta@nvidia.com>, <pshete@nvidia.com>, <vidyas@nvidia.com>,
        <mperttunen@nvidia.com>, <mkumard@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <kkartik@nvidia.com>
Subject: [PATCH v2 4/6] arm64: tegra: Enable native timers on Tegra186
Date:   Wed, 29 Jun 2022 23:59:02 +0530
Message-ID: <1656527344-28861-5-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656527344-28861-1-git-send-email-kkartik@nvidia.com>
References: <1656527344-28861-1-git-send-email-kkartik@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5330f289-1673-4b96-9de7-08da59fd5136
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0066:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyNFbwjWM4ffRosxi7OHX+LXtHlHI8KbGR1yjrhD4ofi62TgvFkYWh4189o3F7/tAAKu7brkRzAbVgoPrZ9MzdJKVqC58ruTT4A1psaOAS1LHc2Ov3b8P479jiUiBlBGTUICrTGib5P2AncOVftciKFLeQtGfuC2od/3Y065aLjlqb4YLdzcXk09K/b95BEFT8AvvwQ5r/7VO7ZCZUNE96ZUPe11h0ip6AOls352XVmf4lXuSm3YUqbHs/iwDesBPs+AgtR0OUn6RiyV5yPG2XgVYRBubrLys5SWhIpG6YaPygH6sLnxTI3N36MSuXEgQ1+h6fuDGk5AkK5KEmfN7OWTASJUUcdZbEwb5kQdkQNLAOO+q++c2IW096DyUqpy0mAUHjUPjufzIf6SkZn0zLusNgHUmef+BkeXMQP1xEz2NxEIAGPWucJ7OeYYKnrBthgP4Qrx+u/rd5djEKLeNZ9A9FzhTm7ZedKTBklom/4kcZFkU41emuCyRZ9ExTBo+v9JWfyQeKTWvBIjeZUS3WYCAlG0pl0KPKhIMPDdM4kUANy0hDXcV73yiEkYvogT45Ska6XPSIHd+EmAtoakvraWZzlpJIiLpq1k6f2o4iMISXfBlM4gLvOJqv2Om+lMJEtKPjHhm2fpFO00DIjn3vkp+KK7GpBhMGQDu3MyZ5Qs8LRUO3fgd4rUggx0Y+q3nGEh4n/g7ohYrVA09sYmEISBOa5kdmZ/0i0OfiN9GtMGQ7MkivY2xviphAv4lmIS8/zp+MuSAic5ZGuiYhg/v06AAgnqocimN0Oyd/3OdVyntJScJ4+WGP2MVNVCT3p4
X-Forefront-Antispam-Report: CIP:203.18.50.13;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid02.nvidia.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(46966006)(40470700004)(7636003)(478600001)(36756003)(356005)(921005)(82740400003)(83380400001)(426003)(7696005)(2616005)(110136005)(41300700001)(316002)(6666004)(186003)(47076005)(336012)(70586007)(26005)(82310400005)(2906002)(40460700003)(8676002)(4744005)(7049001)(70206006)(5660300002)(8936002)(86362001)(36860700001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 18:29:34.5478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5330f289-1673-4b96-9de7-08da59fd5136
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.13];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0066
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the native timers on Tegra186 chips to allow using the watchdog
functionality to recover from system hangs.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index a87b52434939..a07acdaf345f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -599,7 +599,7 @@
 			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-		status = "disabled";
+		status = "okay";
 	};
 
 	uarta: serial@3100000 {
-- 
2.17.1

