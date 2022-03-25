Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854944E7095
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347360AbiCYKIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354317AbiCYKIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:08:31 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3304BCFBB1;
        Fri, 25 Mar 2022 03:06:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgyWKjHTDx4wcpjcDYsE7zxOZPI+WFZBZkGcEqoUrkEPgewKGQH72z75TvXwOLUO45qRADSodqncJd/t/y//5lrZWA8yNPnif3LvRQc5zDHhYF9IbdgqNS5XAfSgjW8nIp/TFQGgKplp3q0GcrbA/bwZOk89USdJYVERv6ZZsfhBIWuwSp+yCwP5lVrHgbILhwg2mpp2Ckt9KCvOTZ/nxGBbndJzgX4H7yXZZ1aUPrlvsxIsNK9FZcuUwnfBCikwPsCGtlt4PW5i0ee1T2M/JYSXvFK83NR82t14/u+tkP5xtb26312fHj07biCcoeQcCP4IX5tC3/Dcz8MJRcd0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktMzNQERUeLGtOwMthkiq5f0zAjUKTKfS/R5FX12clw=;
 b=RYY7H+vSTRj59hbpv6REUR2RRP0q/jGaRHkuK2kCSfyQCpgtgh5GQAlfcXEiUTq1B7FpoqaIoyOhWU+QJwMJFVQYpbOa9rEAd2salnWcPK1dtb9+u1mFbcWJ6TPWaLg7SAFZVe3PkVh6REfQcb7o/8JuGHSPb+MtBFAfOq2J2QJJEA+bC6/4YkRjWnGjkndYfpBD5nrXdzdJJcV86ZFHrcsgJ8xcvCLhjkEKjcZRus89Q/wGJfli7/E08Ae9oaatFxzEvimjP/kaJEHL2XNeLCGiR3IT8vTOOePvWbVFBY2vrpQ0seN4vj9x/3JrfqPw7zVKLgsvnBpY7hGq2da9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.201) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktMzNQERUeLGtOwMthkiq5f0zAjUKTKfS/R5FX12clw=;
 b=VQmQODKZePV8BetcI19LD01B0actHBivs3AHRnT3bwBvC3OhJJM3KLwC1OJIs3Fr3GCyO4DPdFVU5TEAk0kE3gD+xKcry1RHMEMdJX4GTZwRG47nACQsU1iOl2mLUrZgBXWSM8GsBaIe1H7Dl8vljCwQSxIkKwv8Et/jWe2NrCc=
Received: from AS8PR04CA0026.eurprd04.prod.outlook.com (2603:10a6:20b:310::31)
 by DB7PR10MB2458.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 10:06:54 +0000
Received: from AM5EUR03FT030.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:310:cafe::de) by AS8PR04CA0026.outlook.office365.com
 (2603:10a6:20b:310::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 10:06:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.201)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.201 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.201; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.201) by
 AM5EUR03FT030.mail.protection.outlook.com (10.152.16.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18 via Frontend Transport; Fri, 25 Mar 2022 10:06:54 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 25 Mar
 2022 11:06:46 +0100
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 25 Mar 2022 11:06:46 +0100
Received: from localhost.localdomain (10.167.1.162) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Fri, 25 Mar 2022
 11:06:44 +0100
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <robh+dt@kernel.org>,
        <tony@atomide.com>, <bcousson@baylibre.com>
CC:     <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>, <Gireesh.Hiremath@in.bosch.com>
Subject: [PATCH 07/15] ARM: dts: am335x: Guardian: Update beeper label
Date:   Fri, 25 Mar 2022 10:06:05 +0000
Message-ID: <20220325100613.1494-8-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
References: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.162]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69c8282f-fd08-47db-8d00-08da0e4730a7
X-MS-TrafficTypeDiagnostic: DB7PR10MB2458:EE_
X-Microsoft-Antispam-PRVS: <DB7PR10MB24585571BCDF08B9A5AE600CA61A9@DB7PR10MB2458.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1QKtpcK/ppGwXFm7W+TDy4LgGhlKFpE9KaIWI22P1rxv7lri/0NVGU/kMDTksus/xhvqIlPFVFUhTs94XHkuF7x5LPLpPKLBI8A8BukgnLW+2utpG5ufKoWExaCzPjmwor+jKjQHl7AzrMe1plUeRkxT+kFnWWnidazCTPnDTCKee0U7Ve0s/B55KCHZzMJkVuq8iASIZhKMeVYUt0+3TEVl4vz1mPZhwn/BJWu3u9Ym3vj8o8PNPPTenwRZHPISG55HsQWLELAJspa/kfe1ydOchwwdX54itwjWUtmHOGbB8otTPerXrn73iVJU6FV0is2ujjShSw/LKrHQh08/yT7hoW1ws5zXd5UmGvBjO9LQKoo3R67JZKJWKcgaQUhmw67aQBdNZLEV5JWXj2hRNgJIICxzA9cS7pHkpXadQoXDRWG/dPrh87OVUAITiUXWkyhWs1ToRmnGzWDWSr5ioVTJJrLyW4mYLwCXt/jQyb+vqWp+CTToSPa3CBosdtMlGo/5afh3qI3l10UFfnF+4zfvipIZyPGXqW8PxNOA5yv32xkRjv0GUV7AblZg6yQdIcJdIp7xb/zMJQ5T9L2o8wnDu6cg5RLpO9w8i4Jj0ztUy9iyzULi9DWBUCyqeifLr+bQWQm+H+8MBjo+NzC4c9BuV+iEEIxv2AtqHsOQvNbou5ASb3xYu6tR9gLE9QiZYuHA4EkPrHi3szRBjjq3yQ==
X-Forefront-Antispam-Report: CIP:139.15.153.201;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70586007)(15650500001)(4326008)(8676002)(86362001)(186003)(5660300002)(81166007)(508600001)(8936002)(82960400001)(356005)(2876002)(40460700003)(83380400001)(2906002)(1076003)(70206006)(82310400004)(107886003)(2616005)(336012)(16526019)(6666004)(110136005)(54906003)(26005)(47076005)(316002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:06:54.7162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c8282f-fd08-47db-8d00-08da0e4730a7
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.201];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT030.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2458
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

 * Update lable pwm to guardian beeper

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 arch/arm/boot/dts/am335x-guardian.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index 68443c59aba4..ed4cd51dd838 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -100,11 +100,11 @@
 
 	};
 
-	pwm7: dmtimer-pwm {
+	guardian_beeper: dmtimer-pwm@7 {
 		compatible = "ti,omap-dmtimer-pwm";
 		ti,timers = <&timer7>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&dmtimer7_pins>;
+		pinctrl-0 = <&guardian_beeper_pins>;
 		ti,clock-source = <0x01>;
 	};
 
@@ -374,9 +374,9 @@
 		>;
 	};
 
-	dmtimer7_pins: pinmux_dmtimer7_pins {
+	guardian_beeper_pins: pinmux_dmtimer7_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x968, PIN_OUTPUT | MUX_MODE5)
+			AM33XX_IOPAD(0x968, PIN_OUTPUT | MUX_MODE5) /* (E18) timer7 */
 		>;
 	};
 
-- 
2.20.1

