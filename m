Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666BE4E7089
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353045AbiCYKIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358638AbiCYKI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:08:29 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150075.outbound.protection.outlook.com [40.107.15.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79ECD0815;
        Fri, 25 Mar 2022 03:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APCDPNSCErBG0GKGzXvXEGErlRzORdtYAyXA5ifuyG1N6syL5Nf8rwyd/73NU47fMkXkFsikO0mKLlCN++sFunMyT/Vroh7fYXr+UeIbMItpVcVZtEMwEEt8RwjyhwwItfK1+4zMOUWYuDCe/dgqpAC8cvXjbSS8ETp64NWKlbj5TpBE3IBDfEy/d5+kFmxJCykT7T89A7b/YEVsLW5BOr3XZ1onxUjnaxL7QdkWaMWQ+qTJp5qTC2GR/1a6TYI9u8QhAQ8E4b7Qog013oUt2jx0p3g0cF96HXruw3yC4VbCvcMwXBp9qzQSOqsvz7ssvUXtSUG3araehLGjNPitsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hp8/DfZg3gF9FfZYutzynRslCnm/igeQazDDw5dRr7A=;
 b=L35o82j46HPxudgA8OUDYYCrzmj82g5OR19g7DffQROyJtu817HTZSFhwLnGZEr0RBxY3lbp476YseLhXqwHGojm8BRhb1bI0ysXpUTKpU5Ryr8fceuHDLJw4wij3aOg7nMiFu6MJDC15ZddXGxDs0sOGAcnURXEV24VFpVoISXEdN9U4LMvILYTJ81LxWZOAzg/9AfVibI3JwNiwkPeSpyi1ABlKLld2KqBEnngCLHINKim1NoQgr5clvXP0q5RfkMsacslXKOiBp6qYZBvnREPXv37+evtPfc6CnbQFwB8anpyfWl5Tfk9pz0XHyiL8Xt4Eo+QDperu63IacWBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.200) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp8/DfZg3gF9FfZYutzynRslCnm/igeQazDDw5dRr7A=;
 b=hAc1icVAXetdG6zg/oiQ5sC7edKv6XF0t9J3g72KR28kLo+HBh28DNac+vG3HfYpb0lNtSQ4f6jrb2FcO3S57Pc9nBoxLAuQRg++8MTIGzVCUKTOWbFdCWG4T5zTMgyh81Yk6IPqJfdBHEMBxomD7UdJ9hr99zBdg+RdZ9SVu0I=
Received: from AS9PR06CA0265.eurprd06.prod.outlook.com (2603:10a6:20b:45f::34)
 by AM9PR10MB4296.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Fri, 25 Mar
 2022 10:06:53 +0000
Received: from VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:45f:cafe::28) by AS9PR06CA0265.outlook.office365.com
 (2603:10a6:20b:45f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23 via Frontend
 Transport; Fri, 25 Mar 2022 10:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.200)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.200 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.200; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.200) by
 VE1EUR03FT012.mail.protection.outlook.com (10.152.18.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18 via Frontend Transport; Fri, 25 Mar 2022 10:06:53 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 25 Mar
 2022 11:06:44 +0100
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 25 Mar 2022 11:06:44 +0100
Received: from localhost.localdomain (10.167.1.162) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Fri, 25 Mar 2022
 11:06:41 +0100
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <robh+dt@kernel.org>,
        <tony@atomide.com>, <bcousson@baylibre.com>
CC:     <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>, <Gireesh.Hiremath@in.bosch.com>
Subject: [PATCH 06/15] ARM: dts: am335x: Guardian: Update life led
Date:   Fri, 25 Mar 2022 10:06:04 +0000
Message-ID: <20220325100613.1494-7-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
References: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.162]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96f5dacc-68ab-42fd-4b9d-08da0e472ff3
X-MS-TrafficTypeDiagnostic: AM9PR10MB4296:EE_
X-Microsoft-Antispam-PRVS: <AM9PR10MB42966B5D91B821EEC4DE4963A61A9@AM9PR10MB4296.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0iz1AzNEaUXDL53eXfITRbTD6jF0j8xEKswsnpwii4/+8svDJm+/wcNslbPLW6P1OYNLihZ/slGQK2uYWU8b/pVEgyHm6qPbu/asD1y4CliuVAyeQGhIedFAoxsIq7W3eOA7ks3wKLzYSGNu9wwn1iTipsjIx5fjL1SWyQOAdF/RAOEorJSyUyG2VYknB8USwObkYhg7Z65NtgMlw+j/ImpyqYHk3frZNHm+zvKS5JmszMyDf1Yp6j8mkWhMNh/JuEWg0KspvFeSxiZEpg9eJuZLHX+ZZKLGJlpLlrFsKZBcaEOC0R0Brn7nwCd0aX8iRCIRMye2H2mYq/Y36vyhndj4BNs5CdqjbMn+UVPsOSd+D125D+dAKOkj1GcirYkljN/jSYdjVP+GNgdDV3rT7q5bjSXea+LqRq53ucYS1foq0djfFicqTOEOm6DXn93fgyl2pCQEAe2tSkHyhzvNVrymS1A27XAsiFaDZhCVKRED93ftL0UC4qwRB6+DLJIp39J+OTdMRLrsDODflsGiNxlWG3mJKAo2nBqaYG5kx0qQ9td7JkkY+velKmhK/uzmYBR+NixLdGjlUF3/u7GrwqZslf5bTIN/URI7TUwanH9Zw2P50ShdeZw2MRcS9BCtwyXepyaySRKcWiwxHldjN5FsCqHcAapKN4J16aUopNmRZU24tyGYBUjqpW6UrcqJejIPWPdcC8YMR3T/tIyq4A==
X-Forefront-Antispam-Report: CIP:139.15.153.200;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2616005)(107886003)(36860700001)(86362001)(1076003)(83380400001)(81166007)(40460700003)(2906002)(16526019)(186003)(70206006)(2876002)(8676002)(70586007)(15650500001)(26005)(4326008)(508600001)(356005)(336012)(6666004)(82960400001)(82310400004)(5660300002)(316002)(110136005)(54906003)(8936002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:06:53.5349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f5dacc-68ab-42fd-4b9d-08da0e472ff3
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.200];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4296
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

 * update life led label and pin number

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 arch/arm/boot/dts/am335x-guardian.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index 749239081bf1..68443c59aba4 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -51,14 +51,14 @@
 		};
 	};
 
-	leds {
-		compatible = "gpio-leds";
+	guardian_leds: gpio-leds {
 		pinctrl-names = "default";
-		pinctrl-0 = <&leds_pins>;
+		pinctrl-0 = <&guardian_led_pins>;
+		compatible = "gpio-leds";
 
-		led1 {
-			label = "green:heartbeat";
-			gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
+		life-led {
+			label = "guardian:life-led";
+			gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
@@ -465,9 +465,9 @@
 		>;
 	};
 
-	leds_pins: pinmux_leds_pins {
+	guardian_led_pins: pinmux_guardian_led_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x86c, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x868, PIN_OUTPUT | MUX_MODE7) /* (T16) gpmc_a10.gpio1[26] */
 		>;
 	};
 
-- 
2.20.1

