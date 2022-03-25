Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA694E707E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358630AbiCYKI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358605AbiCYKIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:08:22 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60081.outbound.protection.outlook.com [40.107.6.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0386FCFBBC;
        Fri, 25 Mar 2022 03:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ih8SlA6lzaWxqWVTplcDEWEizYEpMUsuCoESkUPR2Lec3GVjiGEA8PtqGmhnYD0oQdMw62DBSiwc/PzU3rE2Cwgx6k5nBbZ7j3Oj9LKvp0ms7W7GNhwq4SJXbzUJBOE+AVvqziRmHd3wbm8d0VcZfgyzZ0ndz8MREMqCOgfKB/5B3Z2f5mHii5HMEjRE5/n+kC5VOW0ZzXqUzwI3dRmatMX+q+OlEhQT/6hWk5vdK6AKCTkvHd/ZVoq6v4GSZ/1aiLv04DqwYhKlSsarOcZqzjphfn7AoMbaDcbT2sA/DaajREpEX9pHPZW9MngG96zLfgWHkr9pUh9hle8DVyNH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qf0MshCFPwDoVd0aMdofMkuvFa4y+PjCSxm+g7IlAUQ=;
 b=RTetQxgfhiq9dY/azMALYc8MmAkR2uspaaESW/p+2Jxu5ZlkmrbFNREnY8UgBG6heJbu/LGToUb7mpJrBEEu/9W3Gw7686bEJ+fELBXpQYU+MZ3XqAokYb7PhtijXH+Hg81PvMRDMyrE16AOhoSciIL54DmhhEVJQQcZdBaB4Qq1GKkEyict1vhol54XDdKDqQM3r0XwQLadKtaBh9RUntTcrpNEIq+gCTLuDAQv7oZYht6aJljRwZYKf0Rl5yqyLgty4V/6B9C16NXPnyAO9nwBfEpZzZJet3ufV1w/4ZXHc84jk79CGoYo7z9risro9RqvfmomAnCRAOrKAkrPJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qf0MshCFPwDoVd0aMdofMkuvFa4y+PjCSxm+g7IlAUQ=;
 b=DHotUuHhmbI3KdEqf0o1piCaHPg2IbI8O6iUVAPOROznzA+KmsoX/5OZwniGr6iJGvllD0ERkB7aRDz+zaiTQYMRmGMmUUvgFwenbXdseUj4gpqP7uLWyTZS4dv1X+qjVbagT9gCjAaE6ZYijmr0aWgUK01dZg7xDcD/RMfAZeg=
Received: from AS9PR06CA0075.eurprd06.prod.outlook.com (2603:10a6:20b:464::23)
 by PA4PR10MB4399.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 10:06:46 +0000
Received: from AM5EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:464:cafe::bd) by AS9PR06CA0075.outlook.office365.com
 (2603:10a6:20b:464::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 10:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.203 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.203; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.203) by
 AM5EUR03FT011.mail.protection.outlook.com (10.152.16.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18 via Frontend Transport; Fri, 25 Mar 2022 10:06:46 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 25 Mar
 2022 11:06:35 +0100
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 25 Mar 2022 11:06:35 +0100
Received: from localhost.localdomain (10.167.1.162) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Fri, 25 Mar 2022
 11:06:33 +0100
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <robh+dt@kernel.org>,
        <tony@atomide.com>, <bcousson@baylibre.com>
CC:     <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>, <Gireesh.Hiremath@in.bosch.com>
Subject: [PATCH 02/15] ARM: dts: am335x: Guardian: Rename power button label
Date:   Fri, 25 Mar 2022 10:06:00 +0000
Message-ID: <20220325100613.1494-3-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
References: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.162]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f13058d0-8bfd-4ada-fdc1-08da0e472bd8
X-MS-TrafficTypeDiagnostic: PA4PR10MB4399:EE_
X-Microsoft-Antispam-PRVS: <PA4PR10MB439959251199076853052E72A61A9@PA4PR10MB4399.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VugNongvWuABEvvUJJdtj0Z1kakmECeWAjnYSiU58AvaqX7n6Doo8OlCy8z7b+vY7evxW+SFw6UljI92caSKhkudewXtmKi8vm9AFOa3yXeqXoXeLgcbl4vQXeWgf35N5fksr9p9Bvc4gDR2TwfZRKEKYyq/qA7TElNKVm/uu8eKD6eMOZ9i2E4q/lklYlPkBv6MY03ri3PGyK12H5h5BOkIyC+cYppegq6sXtk+4zVOyJBDo7T+E7qrjzopuqENLR7lamk0WEu18pm7bQOkAKL/hRE7LWdKuLVRkKj1Mgez8RTLdHADVH1Rlb9KIkpBGvY1aNy4NIAoCG5WGL8MRAi1w8MrXsY9DIq9v6XTXO4jA0fvEGk8zilajfF51epVOJ7ggoX1yyrDDxOnwqjpF80bmTWjTo5aJTroiQK8au8TSPQdBa4fparG4qYge07zsS71UB7uuc4eLcLb4LH18ISMU42UlxM+dU1VGJJnB9S1qIxmO3goqebXoifiZAnDHCEOxN/6PHXw14Z9x+IFa0Ao6cu/7G3k73m6b8z+ZbpfVf/L4QjxhCSjMweEsY8qLafq/OMdvb1gsjn2UtDKhHsqDudYGLYjs8rSWzotewqaDBnBmK4WcPzOQqqYTvi/ljnLMzcBRIShpsifhc6smamB7meUs0APmbu17tIY7ejjJnZezZ8JCLXmITVKePfFziSJtHgXawTkum6lxvD6dA==
X-Forefront-Antispam-Report: CIP:139.15.153.203;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6666004)(336012)(356005)(82960400001)(47076005)(54906003)(8936002)(316002)(5660300002)(110136005)(82310400004)(83380400001)(1076003)(2616005)(86362001)(36860700001)(107886003)(26005)(4326008)(508600001)(81166007)(8676002)(70586007)(70206006)(186003)(40460700003)(16526019)(2906002)(2876002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:06:46.6516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f13058d0-8bfd-4ada-fdc1-08da0e472bd8
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.203];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4399
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

 * Rename label button to power button

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 arch/arm/boot/dts/am335x-guardian.dts | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index 41b7adf78656..645de77bdb56 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -29,21 +29,22 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
-	gpio_keys {
+	guardian_buttons: gpio-keys {
+		pinctrl-names = "default";
+		pinctrl-0 = <&guardian_button_pins>;
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&gpio_keys_pins>;
 
-		button21 {
+		power-button {
 			label = "guardian-power-button";
 			linux,code = <KEY_POWER>;
-			gpios = <&gpio2 21 0>;
+			gpios = <&gpio2 21 GPIO_ACTIVE_LOW>;
 			wakeup-source;
 		};
 	};
 
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -365,9 +366,9 @@
 		>;
 	};
 
-	gpio_keys_pins: pinmux_gpio_keys_pins {
+	guardian_button_pins: pinmux_guardian_button_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x940, PIN_INPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x940, PIN_INPUT | MUX_MODE7) /* (M16) gmii1_rxd0.gpio2[21] */
 		>;
 	};
 
-- 
2.20.1

