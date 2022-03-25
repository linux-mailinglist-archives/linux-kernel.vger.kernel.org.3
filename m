Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377724E7094
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358681AbiCYKJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358650AbiCYKIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:08:37 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20062.outbound.protection.outlook.com [40.107.2.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC794D0822;
        Fri, 25 Mar 2022 03:07:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFCGHNVPF+lgvHX6tCTgJWoBPDJH5QW+o31MaClJe0dofTYVjAZ8cIcDyp9uc5+B3e+NgFQArUfGWu55r4l3bkefmBHXGKKe+q4GnUNsn+9Hy7F2/BXAG3Loe4byIz+Dfv2Zb9MtUtNhgzQqfy+X+/VpFSBXfFN9ofwHfGgwT+n80RpnfQ+Z6XwKRw2bm2BWMNN/oDFxkjhjowDWPpuuzkNFuDpceDFiFEQxDrWYK0D6BfB/xIQsbRUv0fnfJEamyRKb3RF562C5rDU6sRddK7LV6aB4x2CXYR0QUtf9VNoZ8Qx7BtLoR+dV/HVOzsOb0KKjTH7MFti06IZGslkbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xW1dGLPwu8Eb4lu4s7uFDDC7+oUzr4ZSvOdrs9DE3I=;
 b=IIbJX715pLa3Iw4IyddG1vscXX/mQrISMSvClgfTw1AxVwMFG5BFux1xtMuJwUJV6rAobBEppVw9ovxYrc1p9+jWHtnFwP34TlsqeKHxMIR8hWvFXVlpOcJw+UUrBgDpxypphSuX5nIaNnWoda8KpzHmyZfBKoQrVKIJVPp/3j2Ct3AO2W6SgF7GWP8XeQGhNLOnHG0memOjfo6agX+rK7R5q5NKFUKkeEAhhwZduhrCMac2DOdDZy1Gv2A55jYE1dOGmSLoQETFqTLoZie1W4JW4QZWDKM2QeX4+rMEMaV5KJy+MqrSzzsZ+/o/7n/Ebn6+dNPNL6JRGpKGXTKnFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xW1dGLPwu8Eb4lu4s7uFDDC7+oUzr4ZSvOdrs9DE3I=;
 b=WlDcG1QsokLLTce5hvtDM9JdDP31XPjArzvjKsXlljE6Bhm1nMtyV1++WsSP1m29thj9ux/dhlfK44uZIUOne9rXTGnfV7+QRyTjW8KD3OjEkJ0VYhSlo7F8GOWaNe8Nge8PDWuLnZHO3H46dwT3H427hu0mw0ImcnK+09lXHyo=
Received: from AS9PR06CA0146.eurprd06.prod.outlook.com (2603:10a6:20b:467::9)
 by AS8PR10MB4818.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:345::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 10:06:58 +0000
Received: from VE1EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:467:cafe::91) by AS9PR06CA0146.outlook.office365.com
 (2603:10a6:20b:467::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 10:06:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.203 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.203; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.203) by
 VE1EUR03FT049.mail.protection.outlook.com (10.152.19.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18 via Frontend Transport; Fri, 25 Mar 2022 10:06:58 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 25 Mar
 2022 11:06:55 +0100
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 25 Mar 2022 11:06:55 +0100
Received: from localhost.localdomain (10.167.1.162) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Fri, 25 Mar 2022
 11:06:52 +0100
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <robh+dt@kernel.org>,
        <tony@atomide.com>, <bcousson@baylibre.com>
CC:     <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>, <Gireesh.Hiremath@in.bosch.com>
Subject: [PATCH 11/15] ARM: dts: am335x: Guardian: Enable UART port two
Date:   Fri, 25 Mar 2022 10:06:09 +0000
Message-ID: <20220325100613.1494-12-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
References: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.162]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cffa94d6-962b-47d1-6590-08da0e4732e3
X-MS-TrafficTypeDiagnostic: AS8PR10MB4818:EE_
X-Microsoft-Antispam-PRVS: <AS8PR10MB4818AC39827488726245E81EA61A9@AS8PR10MB4818.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +igKHFM2p/8WQPrujfwNJkfNnDCGDRrExJEjm2brwKwdt9cdPrdeYCRHLnZwr3opBl+J3EHOMdqvfq9C7L1CDNTU6Puukp7QXpzgwIROQYTozwQf2Jh0hl3/uieYHa7rSjATe6ORadKPSdfJcgA+FsuR594obLsFoXu6T1yH4e/C2m85fOV74cSptIzyrxaqf4pBmWkK7gI2GixSkRlpMhdeMsyATtaOe5S91vmYJlM0x0/rg+hGA4IN4QDzqa1m7vbHW06GUwYqwG8wuam+fzGj0WHF/9r4wjvFxKLZgUZyty/BA8dB4hJHhi7MKIjWuE8o+xCVd5QhQcvtO2tKiQqNC0DtSpukceNHywn4OdK6oN6OOwbEmmNhNrdoRkJk4DMdBnQVZe7Ee023cGzEjozoru1dxyIc0TbGmhbzbLOGofl5LOEMsHsBMMJGoiJ/NlrBYyl/NBX6TEyiVVHA8w4f4bdn5KCtSuUvAaAiG8XXNr/pAEHXdnMpaFo4yaP63Tj2GdSmSzM4Mq4uPVLtakn6AGh/pZ77yctZQp/a1Y42gIaGUlJbmpv9puDV2btVJYW/t1EM+BldzgGavIGbVMvtm2bQt+OZmyZNmCPGRvII5s6EgdEURWI93CNz1+nymPuTFsL/9SkOwF7mOfn/hZtgZSRFTK+dtijvMHIwAXrSmgEjuOovnibF0l15R750nkMvTdHA0PrRQaoJv1W7Ng==
X-Forefront-Antispam-Report: CIP:139.15.153.203;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8676002)(2876002)(86362001)(4326008)(508600001)(356005)(8936002)(1076003)(81166007)(2906002)(70586007)(6666004)(5660300002)(36860700001)(82310400004)(2616005)(107886003)(70206006)(82960400001)(26005)(186003)(16526019)(47076005)(316002)(110136005)(40460700003)(54906003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:06:58.4663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cffa94d6-962b-47d1-6590-08da0e4732e3
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.203];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4818
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

* Add support for uart2 port

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 arch/arm/boot/dts/am335x-guardian.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index fab844815065..9f60f5430f36 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -383,6 +383,12 @@
 	status = "okay";
 };
 
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "okay";
+};
+
 &usb0 {
 	dr_mode = "peripheral";
 };
@@ -582,6 +588,15 @@
 		>;
 	};
 
+	uart2_pins: pinmux_uart2_pins {
+		pinctrl-single,pins = <
+			/* K18 uart2_rxd.mirx_txd */
+			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLUP | MUX_MODE1)
+			/* L18 uart2_txd.mirx_rxd */
+			AM33XX_IOPAD(0x930, PIN_OUTPUT_PULLDOWN | MUX_MODE1)
+		>;
+	};
+
 	nandflash_pins: pinmux_nandflash_pins {
 		pinctrl-single,pins = <
 			/* (U7) gpmc_ad0.gpmc_ad0 */
-- 
2.20.1

