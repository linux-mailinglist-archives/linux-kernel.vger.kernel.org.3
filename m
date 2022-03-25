Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710654E707A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358613AbiCYKIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358604AbiCYKIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:08:22 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA391CFBB8;
        Fri, 25 Mar 2022 03:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5kci1H9ytcKEfdjHVpBl5E2B/M6ewhYHiDeaGQk9Vl69NblRInIzwkL7rlJcjJX0JamVuxxPg1SzYm0XcBNgyBnryDP9I+eIi/2hXb0Ru59gXO1U6h47agBrBxklgNCW+KJW1PdHShIVU2/TRBtA8NHC7E+TUQyPXT/R3ZjDLSAwoJ/qQXaulMvHEQgPFTyVxoiXXZFn30dq+C4SnbmTY2AySE+Mp8trrLcinFBmzS4mNk5GRhmLkb2GdWHJCkB4u1JhCfTO2gTEasAyl8hIQ/JW8jgrKI4pycFADUX8GX7PI60Mn6EJ4OGF9nBphhioaMy09uQoSPU9rMRvOwyhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8+emKMsoSAvt8yDUGswWvEYqF50aUsMHG90VxOOTqU=;
 b=DYseBWCzlMS4anyfMTKsfOOGA28VKWVhwnsj7UVZAqWQ3SvXpbGoZWTMPen64TvvGRvr0jvX8XY2bpbn7vx+oAOjkH1uRLz/jBVqReWAM+qrBc3jeQVBRFIqmr4q3w849SNfoUoFTqdBV3sl/GFeU74IQYg0kIvwlR9uAf2xylSsXnDJkrcxQELstYquzODaXVyucB0m5D3QsBg9iZiLjTfQdNB8oWMB3eyK1kro4S+pq4ZHS6huwC9ojvEwSH5pAd/KwLvK1LMOiu4C+8xPkjchwULkqPAfIMalihZ80cPrYDbvgHHUPA2qj4YaVHERjaO55MWxUAJKlbWAsDGFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.200) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8+emKMsoSAvt8yDUGswWvEYqF50aUsMHG90VxOOTqU=;
 b=ELri/lx2bfc9idxjZbpDoOTqywb5qK081sX60IgIB/owN0yWoXJjUSizJTCcKYdaYOgnfCMq8oVHPrusF9t0BptD98WUjesYZ9F4hx+kITFc9PrIgHK80TuqrpsQYt/+GLGjvT4kP+eadrfsUOueegKxJfGP4f/UH6b4gpVVjuQ=
Received: from DU2PR04CA0233.eurprd04.prod.outlook.com (2603:10a6:10:2b1::28)
 by AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 10:06:46 +0000
Received: from DB5EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2b1:cafe::e3) by DU2PR04CA0233.outlook.office365.com
 (2603:10a6:10:2b1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 10:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.200)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.200 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.200; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.200) by
 DB5EUR03FT046.mail.protection.outlook.com (10.152.21.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18 via Frontend Transport; Fri, 25 Mar 2022 10:06:46 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 25 Mar
 2022 11:06:39 +0100
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 25 Mar 2022 11:06:39 +0100
Received: from localhost.localdomain (10.167.1.162) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Fri, 25 Mar 2022
 11:06:37 +0100
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <robh+dt@kernel.org>,
        <tony@atomide.com>, <bcousson@baylibre.com>
CC:     <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>, <Gireesh.Hiremath@in.bosch.com>
Subject: [PATCH 04/15] ARM: dts: am335x: Guardian: Disable poweroff support from RTC
Date:   Fri, 25 Mar 2022 10:06:02 +0000
Message-ID: <20220325100613.1494-5-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
References: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.162]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31fe1690-6117-4ac3-370e-08da0e472bb9
X-MS-TrafficTypeDiagnostic: AM9PR10MB4231:EE_
X-Microsoft-Antispam-PRVS: <AM9PR10MB4231B595E80EE5FD8F905257A61A9@AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: paoYz7ZDYKVjaa4hsxn6KRlvrjlCFnjZfVizPwSWXo7XXFkG4sqwYFPS6fytq8UDgwPr6Wvl3U4CRGctr5iaqkR2IQZDUq7iLBb2N9ZsJ4kMjmru68+QfX40sZ3mI+T2rpLKjHsCEVG2cedK2hmGdnmZvptjp30z0w9Q8HP+TWgRnuz7irrHE3DO292KO+NBLLT9IV0Tj6ex8wiMkCTDemqYqFy5uR05rSPG1pF+U/lGr4Eb3DplVSGv5bf6shULH91GoObRARZYWbC+c24wqlSc6T77MhStSvfWuRuFCe07bKrTK6bIqO5dbQBIWwqnoNr/Bm7HMFW9OT7KeTnst/b+++NmRhVF9WVSbL2RKJLeHCZqYyftEucGGEFT5Vls21A9TQnCzsLjIlW7MdyUyetLB4RjFjIUnlL+bzZyWIs+T5MrqSKEYRwWGuLfAP880XG85/bpcgMCdubv3nCLsTO7IToukUv8ACXNPPUHLpPxIwch8ib2xp03286L0j5fPs6KuWJPddft8Fi4LFow6l8Odq6B23QSKTc5k2NS2Ivv27gFNvYCpZ27K2wXrxIzGU2mwp5MTDoJqXK5QgTgafdSCpcMs4zMxtgWbe6oypK50d3UmLv0SjmmRzpWKgOawPW3nskjChH7ogkbbC0c/V7rjf1eeB6YzRD7P4sxbHnccRdgFHjdAYAiJpdpDFna8IRM0f4gds7uEm9UM/U1bw==
X-Forefront-Antispam-Report: CIP:139.15.153.200;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(110136005)(4744005)(316002)(54906003)(2876002)(356005)(8676002)(82960400001)(86362001)(47076005)(2616005)(36860700001)(107886003)(40460700003)(70586007)(70206006)(1076003)(16526019)(8936002)(186003)(4326008)(83380400001)(336012)(508600001)(26005)(2906002)(6666004)(82310400004)(5660300002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:06:46.4278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fe1690-6117-4ac3-370e-08da0e472bb9
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.200];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4231
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

 * Disabling poweroff support form RTC will allow poweroff
   to handle from other machanism

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 arch/arm/boot/dts/am335x-guardian.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index 6f59c5f36c0d..46314f1bc85b 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -282,7 +282,6 @@
 &rtc {
 	clocks = <&clk_32768_ck>, <&clk_24mhz_clkctrl AM3_CLK_24MHZ_CLKDIV32K_CLKCTRL 0>;
 	clock-names = "ext-clk", "int-clk";
-	system-power-controller;
 };
 
 &spi0 {
-- 
2.20.1

