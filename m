Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124074E707F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358639AbiCYKI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358615AbiCYKIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:08:24 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E7BCFBB0;
        Fri, 25 Mar 2022 03:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efk4NzDfxKqswnTf+Nwd10ORobqWSJ5lK+IvgVL1colF0xeegLahhRhLqWFDk5GoTwyK1V+vC+ASCfvOHBm0PX7VT6x9G0lUy54o+6K2VLd45PF3LCO6aBFw3j6488se6gy8aSPEUtzNF/HIU/51z9yRQTnsNEhdM1/OFLNCNOCXMWzIdZ+Suksy6cltI1vMVcmu7CkfcHqV7VYV3mgF52jl3FTLhNB1IJM181P3GoALU5m4VCKHW+cTQOGH6azXctA313t1i+fz28x6wlX2OH+4Hpxa8XSzfiCCPsWRnQ10+IhKlHl/ERSX8CmwgVMw1PCy3HjDICnC8yN1A1nrcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drb1bOL4qIo7wYqmVjWEWEZlB+KSY3OSJa/lDtOkKww=;
 b=BQj6r4rJpWNbxf/zt5965Uwd2l0EPD6zDl4uxq6490HWdBvj0zfzSrD4kjH0lEi4Tg+Y4T8v2th/hb+PNiBYuI9a5p2og/DmvRDsaGKRbS0BMGXt4Y8QxQ2m+zvxRXF9UxIMi0+4o3K4vvcIPVO+v/WE7N0d8xt6QYkbx3KrLzKDB2oJD4OLpHGSj2h5SfPcKomNo/GM3ZFdLUgy5wgzz45ixEdD7eED12Tq/oU6DjbfpaKMne1CTgQjvo501nw34Nf8YHO1I8/qvQlblbS0Z6PEx0Z+DIq1zJSVfiDL/PZVkRMAQ0FGOiT0sekHSmmlofpDxZkMzD9Kk7uGrfVbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.199) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drb1bOL4qIo7wYqmVjWEWEZlB+KSY3OSJa/lDtOkKww=;
 b=OLdw8WTT6e7nTunJs93HmhqnVswiFI6Qs1cbrkUC4SH5mqylmgoFHHsC+aHYJHKoh39p0psordMsFmAegQfpeDXU4/hKLLONsLcqFrpJfzckCQcf5g9M/CgWo6CqHzH/WXHOrcvhp1bCKG1q+g4eiPK/GSQJAOZkRYq9/iUqHVE=
Received: from DU2PR04CA0024.eurprd04.prod.outlook.com (2603:10a6:10:3b::29)
 by HE1PR10MB1785.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:7:5f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 10:06:47 +0000
Received: from DB5EUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:3b:cafe::1a) by DU2PR04CA0024.outlook.office365.com
 (2603:10a6:10:3b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16 via Frontend
 Transport; Fri, 25 Mar 2022 10:06:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.199)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.199 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.199; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.199) by
 DB5EUR03FT063.mail.protection.outlook.com (10.152.20.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18 via Frontend Transport; Fri, 25 Mar 2022 10:06:47 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 25 Mar
 2022 11:06:42 +0100
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 25 Mar 2022 11:06:41 +0100
Received: from localhost.localdomain (10.167.1.162) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Fri, 25 Mar 2022
 11:06:39 +0100
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <robh+dt@kernel.org>,
        <tony@atomide.com>, <bcousson@baylibre.com>
CC:     <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>, <Gireesh.Hiremath@in.bosch.com>
Subject: [PATCH 05/15] ARM: dts: am335x: Guardian: Remove mmc status led
Date:   Fri, 25 Mar 2022 10:06:03 +0000
Message-ID: <20220325100613.1494-6-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
References: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.162]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33cef08b-aa9d-4722-3cf5-08da0e472c24
X-MS-TrafficTypeDiagnostic: HE1PR10MB1785:EE_
X-Microsoft-Antispam-PRVS: <HE1PR10MB17859DCED1AB7C15466DABE1A61A9@HE1PR10MB1785.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lReWWb+42NTIk0zxe2BxbY/wqsNQost0+mOi/7wNwqc5ZwMw0d1yaYGVOWtwhagN1MiWHIASfx6c/fbppl7sZxmcmSsYhEdBqHZb+pkCcHPAzjPwGP6J1p99kFHiB0vjTI81y+Rr4i4oDoL1XAGRzZ9LlXnhuU/Gft1qQMyWRwq6xtVMkfarhuNB4M1Tr+9VkpNotA/pdJVVO1pdicsRHSKxVFCkAWPtt/IZz/JF8di4q9Nyk1E7yi6L7nOWjHCiJcAoOr1sVRgIucreaj5puFmJExCX+OUzMKylqloaTZoN5udUvbccSHkXRK8kuOIESr9KWEZcwn4xdV0bvwnvtNskLjI+KEH6I8+5jKmR22ATwq/pqAQ146sllGvGvtJh7hXWuNzuwWRBc8E+DpD7inOZZLe0ZN10kyynmhwZU+iALtWTLSNQsUB36JpF03bHoyccD18HlW3NxOywbJsvSOakerHKqsmgbMtWsU0Du2oGuFTe6f31UJvoySNd4HybCEd9ELIQHM2ErNh9/9cRPEFO7I8lyzvaQyCxAmTtZymKl8qQ4wtXK9ySxfP24XHbOh8/6xTopua6NJCidiz3UGiYxb5dq8F30yQRpekHeNPeVWPh+ryS2JMa5tSf8YDQEB2pwpiEJF8tzU1ll4nF1mUpB1M697yvA5MUnPwXNMT2aULGvS1Fpxf1Lm/RddUgDCvclb1dPopgvzQ3711Eyw==
X-Forefront-Antispam-Report: CIP:139.15.153.199;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(1076003)(2616005)(4744005)(5660300002)(81166007)(82310400004)(186003)(40460700003)(356005)(508600001)(86362001)(82960400001)(2876002)(110136005)(54906003)(2906002)(6666004)(26005)(107886003)(8676002)(36860700001)(16526019)(336012)(83380400001)(8936002)(70206006)(70586007)(4326008)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:06:47.1292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cef08b-aa9d-4722-3cf5-08da0e472c24
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.199];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR10MB1785
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

 * MMC presence indicater LED removed from Guardian Board

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 arch/arm/boot/dts/am335x-guardian.dts | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index 46314f1bc85b..749239081bf1 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -51,7 +51,6 @@
 		};
 	};
 
-
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -63,13 +62,6 @@
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
-
-		led2 {
-			label = "green:mmc0";
-			gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "mmc0";
-			default-state = "off";
-		};
 	};
 
 	panel {
@@ -475,7 +467,6 @@
 
 	leds_pins: pinmux_leds_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x868, PIN_OUTPUT | MUX_MODE7)
 			AM33XX_IOPAD(0x86c, PIN_OUTPUT | MUX_MODE7)
 		>;
 	};
-- 
2.20.1

