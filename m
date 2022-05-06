Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB4D51D24B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389551AbiEFHdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378251AbiEFHc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:32:56 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4DA66FA0;
        Fri,  6 May 2022 00:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRUPARCI+gSyLGQmveZx+QXPFv79FDXtbhWEVZzkYXWUwYgTXxqYiFnOxBj6FnlYHCcHd7jzzY03pHDyF/OGFkFe1BIVn5CKkiTPEvycjNhJAv5WfqgxLN6O1iicGXQ4h6Za8by6Pe56g7l50ZU5Zmju//vMH7dJyhn49326+nDxZgc7N43/lxMLD5w3ZCdnkMUOk4AoertizLgKcb0oTxQaqCRwBeueimS0oM9WEiVQhLZJYGDgmw7Clhn7ZgwLv12GED8pDIqnQTdBX/bOflAokxemQBB9FU1XYcmfsjX/lAl1St5UwDdJtFiSyoZrPWLA+Zt1PXspkqPL2GQSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ra9aVPNgEMdzmUCQXvAKbZdrFWPXBt2CyVsxdFca7Rs=;
 b=QYimufKSTYUFi0dmHsXZj5gqWn02a53bsXnh2MuO1l8Y2Wou3ApiiMsiS7V/vQp5O3VLcptyP36t5e6j8II8rDadWZeIKtYLUJMzj+pZ0kSLmfQxWw+pEk5x2axAEGjBFzYOQWVGqs6a01zTwKIJZSBTgNdY2E0bQGMgfbSVIr3Pu1GBoKOO4gRU7p29HcubXbaXui7au9rCmVGCUPPLrdaUI6O52vk77WzUc4fjUy476hN20XD9lUHrgrK8HdfeMZe2upGjb63X0AWkZgty/Bz1V1rvWmHyz9bmqxV5p4xhNEpa4mUrHI4F2xmxul5azL1qFVZ/UFp/8GfTlA12BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.200) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ra9aVPNgEMdzmUCQXvAKbZdrFWPXBt2CyVsxdFca7Rs=;
 b=DgFZ9MGB50cYRsr+Irb0QRMhxzUvP5u2j7iUXTrDXWssWmvUuq56OvHTqvBCJHNJN3lMUZaylPV8x4EUMUh/x+1K1B1hILBcXpYHAz6DDf9lXHpciI7+SAiGn5Wv0r5LXloznw+OsJgfn2RJTCGwW2sj7lV12kxxNCHyaB5tYJo=
Received: from AS8P251CA0019.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:2f2::22)
 by AM5PR10MB1843.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:1d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 07:29:11 +0000
Received: from VE1EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:2f2:cafe::50) by AS8P251CA0019.outlook.office365.com
 (2603:10a6:20b:2f2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18 via Frontend
 Transport; Fri, 6 May 2022 07:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.200)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.200 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.200; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.200) by
 VE1EUR03FT010.mail.protection.outlook.com (10.152.18.113) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 07:29:10 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 6 May
 2022 09:29:10 +0200
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 6 May 2022 09:29:10 +0200
Received: from localhost.localdomain (10.167.1.123) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Fri, 6 May 2022
 09:29:06 +0200
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
Subject: [PATCH v2 3/4] ARM: dts: am335x: Guardian: add keymap to mt matrix keypad
Date:   Fri, 6 May 2022 07:27:36 +0000
Message-ID: <20220506072737.1590-3-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220506072737.1590-1-Gireesh.Hiremath@in.bosch.com>
References: <20220506072737.1590-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.123]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24ed3e19-90cc-4d80-71df-08da2f321d12
X-MS-TrafficTypeDiagnostic: AM5PR10MB1843:EE_
X-Microsoft-Antispam-PRVS: <AM5PR10MB184347C8EFD48C52E2D665D4A6C59@AM5PR10MB1843.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zn5xc/aAVkfDM0A0LCT0ah74ymR12uKPUZyRgazftFmxDtgvpzYex6HYF04MnimHM3CzySwsd1NiN5VZeT9q5sXTw/InPoq26MdCaz8+maMVtbCo5Nyr73QdxDJvQAYZBT3LGrW8VGWD/3Y5RYjouFFQT6mct9w7QJ8v8t3ARcjOMYmBOTAs6wxBF9Gln2zkx+6+DlmOLDykRTfJsjf7dWcao8RZpTyjXFUJiMG5S+hCc3eyYj3Sl3sek4pYTZdZbL9ivG3czij2PASIshGTRVv44DVCuhrObyc4QUhEfbDitl+nBxNBJJGfizuR+G2V+3fe96I269Pv0PJ8buyTuG67wresYtH+j7mIvfN8E1IykaQNHdrYOMtPckW1d0aFbB1SjpAvqacPBNBNuCrPjybhchqFEZ4ngQotUhOeDXysP3WttSXKHp2Qa8PH418p8/UBryb4/lhcvddzRCl+3PE8SwIQmrrtM+kffjIG7S0HPwvLwXYwOT04v+8CqaF3Z7yQCdrsolnlTLLzxHdPf7Bs9WAJZM0tphWLIbp+TepptxBLqgZq8kf340L/nb1rbG5gSJCdr/+6z5G2TfzXTpZ2RWfEjyprHZo6rGcyf6zJIMvwBt+OsbGUxrZwq5iGjhsBBVd3UsCKU+VmWBKa4ax6tBOakndNtqRPMyrTmz4AKSXKtxHHlS3TKA37RSLDyfkfn0viaRYWhTYJGcQVyPWyGzWjK5A+BalWazvgc6s=
X-Forefront-Antispam-Report: CIP:139.15.153.200;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(110136005)(186003)(26005)(7049001)(54906003)(7416002)(81166007)(82960400001)(40460700003)(5660300002)(2876002)(6666004)(356005)(107886003)(70586007)(8676002)(4326008)(921005)(70206006)(316002)(36860700001)(8936002)(336012)(16526019)(1076003)(86362001)(47076005)(508600001)(83380400001)(2906002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 07:29:10.8016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ed3e19-90cc-4d80-71df-08da2f321d12
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.200];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR10MB1843
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
Changes since v1:
	- updated node names

 arch/arm/boot/dts/am335x-guardian.dts | 44 ++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index 94d9e51cd0f9..a172d0e2842f 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -120,20 +120,48 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
-	mt_keypad: mt_keypad@0 {
-		compatible = "gpio-mt-keypad";
+	keypad {
+		compatible = "gpio-mt-matrix-keypad";
 		debounce-delay-ms = <10>;
 		col-scan-delay-us = <2>;
-		keypad,num-lines = <5>;
+		number-of-buttons = <7>;
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

