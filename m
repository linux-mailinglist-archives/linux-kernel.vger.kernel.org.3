Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1911519D6D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348412AbiEDK5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbiEDK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:57:04 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283DC26569;
        Wed,  4 May 2022 03:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVzKZjfRRSdpIlh3+ezW/VA+Bcjm9U7/6qnyboAIc5yRePrIoRLBc9InvrazxNSa6LzlIqqNKnjhCh14l67DoDI4kNQ8yTGiZAAuZXpjElp/BgYNfww7Ef8oDAXlcCHK5F0FPdDEibTkrqLT7jRmFTpTSWR0+yK28QBxgGYKpCqTr//eF0NIG46md8zEqPdujD3VDpu8F2Dmiw3aNx9PgWigbV0EaeaVDDTXUs+foSNXOTl4ekvbdNGF3FAcaqB+G1TrxBR/h3q5GiEyrXqNvn4QSZHAmlZyQbVq6noiM17vDUT8Xn6tY5E2SHthAeffEArEDR4zjD0ZMBh9/stCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8PNDlAdiL+jpdE5WTZA9BGflE1CWoLRpbGd0dgaUAU=;
 b=D95qQBnRJM9zGxD5VvzhYjknzQATfTEr37s1XlvahR7WX7oVbGlRD/mXkoHvGflvpygyD2+PlpYisBq945BLrURdZRuHJQskJrcB06a55DrkrIDc2wmgYPxYFUlCGsX0j9RXPDvhIsOHDsXB9lDv+BWGIRnM868ruSLOTV4f2qaQFKh7KPrjnhSqedFYHXzvnx6XVR1jjPg9x+DbYzU6SR+mj4c0DuNQL0C+o3CGtTht7ckdcbXClxo0fnyCb+zDcltE8PtWzpj6wIn0ggp21PqCfhG/Q59APaGQ7biSB9DBIKgJ+eqtEBXKDZR3x5dHMjKaMotgVbPbIfYvgIa+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.201) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8PNDlAdiL+jpdE5WTZA9BGflE1CWoLRpbGd0dgaUAU=;
 b=Q8HrmBWWIi4Z8xY8rV2XuDCz/12yeUYGFpWrttn3/9OuUH7eWsIj8rNheIwGnr7GJyq59nG9O2GKa6Rhez3DDGOnCBdLPG4NJ0JL3Z0d312j78pPiSVQioST0CLz+2EJtd1NEjx3+FXeRw7hC3GLP5nGCn2rVmv6AnMmZ+K/Alw=
Received: from AM6P193CA0046.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::23)
 by VI1PR10MB3312.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:131::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 10:53:26 +0000
Received: from VE1EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8e:cafe::5) by AM6P193CA0046.outlook.office365.com
 (2603:10a6:209:8e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Wed, 4 May 2022 10:53:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.201)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.201 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.201; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.201) by
 VE1EUR03FT056.mail.protection.outlook.com (10.152.19.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 10:53:25 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Wed, 4 May
 2022 12:53:23 +0200
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Wed, 4 May 2022 12:53:23 +0200
Received: from localhost.localdomain (10.167.1.123) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Wed, 4 May 2022
 12:53:19 +0200
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <bcousson@baylibre.com>, <tony@atomide.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <dmitry.torokhov@gmail.com>,
        <mkorpershoek@baylibre.com>, <davidgow@google.com>,
        <m.felsch@pengutronix.de>, <swboyd@chromium.org>,
        <fengping.yu@mediatek.com>, <y.oudjana@protonmail.com>,
        <rdunlap@infradead.org>, <colin.king@intel.com>,
        <Gireesh.Hiremath@in.bosch.com>
CC:     <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>
Subject: [PATCH 3/4] ARM: dts: am335x: Guardian: add keymap to mt matrix keypad
Date:   Wed, 4 May 2022 10:52:53 +0000
Message-ID: <20220504105254.1576-3-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220504105254.1576-1-Gireesh.Hiremath@in.bosch.com>
References: <20220504105254.1576-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.123]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de21aca4-3c1a-4cfb-9e63-08da2dbc50a2
X-MS-TrafficTypeDiagnostic: VI1PR10MB3312:EE_
X-Microsoft-Antispam-PRVS: <VI1PR10MB33121C8C2319362DFBD02760A6C39@VI1PR10MB3312.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4X2rIffJ0ZfrBM1nMkLID2U2T4uQJQ5K7u8xPdBNJn+vdfXw9pUh26mkjQ890l0Fm28FNW+eJZYrtIis8IcaC8xcJDhsN7wwp6sQO/yHwFm1d4iMAfVM5/XUD0aqf3m01h709n0YU/WuIiXX+91QDZHrDEcKWpnHE9xhqmoReoKdbiBM+0f3SXmt/yo7ACzOJXNnVcCt4sHvWQRlwZayJ7PqQw642LeL2rcaCoNwjZR9v79HBQoh5qiT6bxVEnxWZlMf5t4MUaqcMaK0PDsIFlv7VfiYUzfqlmcAx38+ftGMBWIog9OU/1e4j/LxWkacSvaYYkCbH79FzYPidV6L7dWiCQtxkT1bz+9qKOw8a66Ty1E3UTDXx664OliJo3Q9F08HOnhOmcN6cAzwolgJcj9yxSELT93VJbzPHX+vNhNumcvtdfvbzDLuZwhwgkB8gu9nxBIye1fq72HYWJzQGxJ2ahGIsKhyIo9nhY5YoObjj5+yYq/HkuLu3/mYcg3t8MHPM1Z5axdsucI0kxuIkuRoj6MajWuBRxSsRa8i8lAlKSc6QhNacs+38CjGrIE95xT7ryZQfjXEgSfPEzjnwD0zA7031cNAdUQNnDH5EKc6B7Wuz1CPOoHZlBQ/YsyUrTykNlp7KzOj4pTj+UxanyifAf0QYnuwcd8rSegTiIVFvvFjl7Ltq4k+cBQ/Q3paNXWxWJSEBsV3/UaCOg9qfgRSWjBUifxGG0XS9ozOZTU=
X-Forefront-Antispam-Report: CIP:139.15.153.201;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(186003)(16526019)(81166007)(1076003)(70586007)(921005)(82310400005)(2906002)(8936002)(7416002)(356005)(82960400001)(336012)(107886003)(47076005)(2616005)(4326008)(26005)(316002)(2876002)(54906003)(508600001)(110136005)(6666004)(70206006)(5660300002)(7049001)(40460700003)(8676002)(83380400001)(36860700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 10:53:25.5309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de21aca4-3c1a-4cfb-9e63-08da2dbc50a2
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.201];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT056.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3312
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

add linux,keymap to mt matrix keypad

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 arch/arm/boot/dts/am335x-guardian.dts | 44 ++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index 94d9e51cd0f9..13024c328a0d 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -120,20 +120,48 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
-	mt_keypad: mt_keypad@0 {
-		compatible = "gpio-mt-keypad";
+	mt_matrix_keypad {
+		compatible = "gpio-mt-matrix-keypad";
 		debounce-delay-ms = <10>;
 		col-scan-delay-us = <2>;
-		keypad,num-lines = <5>;
+		number-of-button = <7>;
 		linux,no-autorepeat;
 		gpio-activelow;
 		line-gpios = <
-			&gpio1 24 GPIO_ACTIVE_LOW    /*gpio_56*/
-			&gpio1 23 GPIO_ACTIVE_LOW    /*gpio_55*/
-			&gpio1 22 GPIO_ACTIVE_LOW    /*gpio_54*/
-			&gpio1 20 GPIO_ACTIVE_LOW    /*gpio_52*/
-			&gpio1 16 GPIO_ACTIVE_LOW    /*gpio_48*/
+			&gpio1 24 1	/*gpio_56*/
+			&gpio1 23 1	/*gpio_55*/
+			&gpio1 22 1	/*gpio_54*/
+			&gpio1 20 1	/*gpio_52*/
+			&gpio1 16 1	/*gpio_48*/
 		>;
+		linux,keymap = <
+			0x00000000 /* row 0, col 0, KEY_RESERVED */
+			0x0001000a /* row 0, col 1, KEY_9 */
+			0x00020003 /* row 0, col 2, KEY_2 */
+			0x00030000 /* row 0, col 3, KEY_RESERVED */
+			0x00040002 /* row 0, col 4, KEY_1 */
+			0x0100000a /* row 1, col 0, KEY_9 */
+			0x01010000 /* row 1, col 1, KEY_RESERVED */
+			0x01020007 /* row 1, col 2, KEY_6 */
+			0x01030000 /* row 1, col 3, KEY_RESERVED */
+			0x01040000 /* row 1, col 4, KEY_RESERVED */
+			0x02000003 /* row 2, col 0, KEY_2 */
+			0x02010007 /* row 2, col 1, KEY_6 */
+			0x02020000 /* row 2, col 2, KEY_RESERVED */
+			0x02030005 /* row 2, col 3, KEY_4 */
+			0x02040008 /* row 2, col 4, KEY_7 */
+			0x03000000 /* row 3, col 0, KEY_RESERVED */
+			0x03010000 /* row 3, col 1, KEY_RESERVED */
+			0x03020005 /* row 3, col 2, KEY_4 */
+			0x03030000 /* row 3, col 3, KEY_RESERVED */
+			0x03040009 /* row 3, col 4, KEY_8 */
+			0x04000002 /* row 4, col 0, KEY_1 */
+			0x04010000 /* row 4, col 1, KEY_RESERVED */
+			0x04020008 /* row 4, col 2, KEY_7 */
+			0x04030009 /* row 4, col 3, KEY_8 */
+			0x04040000 /* row 4, col 4, KEY_RESERVED */
+		>;
+
 	};
 };
 
-- 
2.20.1

