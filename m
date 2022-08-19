Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492085995B8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346922AbiHSHBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346858AbiHSHAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:00:41 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA551A83B;
        Fri, 19 Aug 2022 00:00:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpBhCRreRtAsetNaqRYtFz/7uhXS2Zc5YXYiX7yJnEq2DF4Jgkumx99JDHw20rBfOodvjyvoFoRKnC3CbbODUldcSDYyJcq+Ww08kyQieKQrqlslFkdgTtVZEVyIh+IVBoXxHbzF8tuBRw7qoD0w3CVw+kcVYIEWWhaZmxVDSyrDFbJlJsNjAi/E8Jb3KMhTJLDyquRN5NeqcGahFm1jPLbOnK560nLHfvk/S4gsWXKqXq4a+C/k5YqdZG4XY0uDU+kXUbuamn2HLHiIdCvBBTYHVx35VUcbY9bf+4TlDQ1XzhBeQ4akjV8uAr8+N8YCxSc3AH2P8Jy1629q+IhsmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gd3VYNsGQXI3W91x8h9TQ2L9ikaOGmPCMBRYTR6flyM=;
 b=KPloVDin7TaIhsycEscYwMfBtjbxvQAjFpuXEOwqffnQ6tcj+6LVcLb29nj9E6TbaXDX3sRlv74kBm8Dhkys8DDK1ltmoM217oW1Az9zoHBcvFcHJxAGxfptLsa/j2aMP3jf0nznMMs3XYMahrJViqXSuNZ64sP1TFhyadV/ZSDvGn0M8/l3CVSFVxZF6GxW4zgnJeb0OL7j+dsoGOztDfeNkLKcNQBjqLervZxXxqhaD9bpQkOs89fibf0L5nVDxMhH7qSFlT42k4H4PBIe20I9Qw/SyxzADhpg0FEjnn8MGK3y2PyWyvTmeXsmZnU0/6p7QwqobSPkbB0pTU5H3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gd3VYNsGQXI3W91x8h9TQ2L9ikaOGmPCMBRYTR6flyM=;
 b=Kzv4w4PrMsqecBlJZ67Ap+G/idoD3FiGH9EhYtQXtdnnwqf+Z55/nU89/ElNMaIZ3ci9Jn1Q6TZRwNTauAE9DGlUAvOgYxY+769r2lDonqwf9hmHUMCBUXALI5SHldS6dQaWxyXnKuZmGinfmfpklKIXokMu1yQISZDChXcAA3Y=
Received: from DB8PR09CA0011.eurprd09.prod.outlook.com (2603:10a6:10:a0::24)
 by VI1PR10MB3535.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 07:00:33 +0000
Received: from DBAEUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:a0:cafe::f1) by DB8PR09CA0011.outlook.office365.com
 (2603:10a6:10:a0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Fri, 19 Aug 2022 07:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.203 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.203; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.203) by
 DBAEUR03FT020.mail.protection.outlook.com (100.127.143.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Fri, 19 Aug 2022 07:00:33 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.31; Fri, 19 Aug
 2022 09:00:33 +0200
Received: from FE-HUB2000.de.bosch.com (10.4.103.109) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 19 Aug 2022 09:00:32 +0200
Received: from localhost.localdomain (10.167.0.81) by FE-HUB2000.de.bosch.com
 (10.4.103.109) with Microsoft SMTP Server id 15.1.2375.31; Fri, 19 Aug 2022
 09:00:29 +0200
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
Subject: [PATCH v3 3/3] dt-bindings: input: gpio-matrix-keypad: add reduced matrix keypad bindings definition
Date:   Fri, 19 Aug 2022 06:59:46 +0000
Message-ID: <20220819065946.9572-3-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220819065946.9572-1-Gireesh.Hiremath@in.bosch.com>
References: <20220819065946.9572-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.0.81]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f28012e3-4ae4-4ce1-207a-08da81b082d5
X-MS-TrafficTypeDiagnostic: VI1PR10MB3535:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QBTm6S3Lm9eZlfqvKHnxFToa+7YmL+W2hXhiEH+QoXs73Z0Iqm3E9Qt7b96wubq7cht84u5n+gbZ2k7bbk2zN5uJ22edrD0VwieU8C/xeKxvUsdH6bmiQraX1h3xO7FTdPexe+hPtdU/yDhdgCyvdZRkZ9yI5ekNxUTu82VPQJiRiQqhVyM2ObYmQrAp12uMsKuX50/FJ0DYd9tnMtI6jHg5brBX7gOFkfe7Fgk3nddm1rPTX8SrY2h1puMM0V+gvgG+FXWRueWF28VkEgG/9zX7n6gVgkFWAUMVJguPsio8EgEz2fBfC4uIKwqoem1UqBqkk6K8mvTT+pqECzTtoyWAkueArp26PHQRqtLNjc4bhfbC65lqJYUziiGyZhLDMueuMCYWQ0S7mvX4GPJmpOuTPzR1QkqAHnTAcvBO+cDfEEOBvgIxRlbwWDYB0wCny6V7GhIy3EWHfqmdbhwyoXRTm0k+NPjfh5bcKdzJzKpH1NyzhF1dm+Wsnd+sy9owIGVN/ptzpuS763JIMnnaDbhJC5zEiBKmNN3y75jzFyUTlxshDvJNrQSnH/QgtXf1M2YTUb3xbwxuLNUHFH24xjUsPsAgvRfolU/4dToXOHnKgMewnZfwHWdsUGBRxOYP9s/LD5s0FWRqX5swzhN6mJq7reKcPLqRi2apB3rW0gNgqT6Z08VHqrPSbwjnsKCrav4CjCf0fL4baaMI0ezSg6896dROhad3ahJn+q5x4qQDJ9U6/k8IMtJaZ87k3hFsEvMOms8utxz3mgC/jNI5Tb2bbsj10lW4CaUDytMr5zDLY0sNVbCqY5HNJ3JZmexU
X-Forefront-Antispam-Report: CIP:139.15.153.203;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(39860400002)(136003)(46966006)(36840700001)(40470700004)(7049001)(81166007)(82960400001)(82310400005)(316002)(110136005)(54906003)(8676002)(356005)(4326008)(8936002)(70206006)(86362001)(5660300002)(70586007)(26005)(40480700001)(47076005)(36860700001)(40460700003)(107886003)(2616005)(186003)(16526019)(336012)(1076003)(82740400003)(7416002)(6666004)(41300700001)(478600001)(921005)(2906002)(2876002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 07:00:33.4329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f28012e3-4ae4-4ce1-207a-08da81b082d5
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.203];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3535
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

Add binding definition for the support of the reduced matrix
keypad driver.

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 .../bindings/input/gpio-matrix-keypad.txt     | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
index 570dc10f0cd7..1cedec29505c 100644
--- a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
+++ b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
@@ -1,11 +1,46 @@
 * GPIO driven matrix keypad device tree bindings
 
 GPIO driven matrix keypad is used to interface a SoC with a matrix keypad.
+
+Generic mode:
 The matrix keypad supports multiple row and column lines, a key can be
 placed at each intersection of a unique row and a unique column. The matrix
 keypad can sense a key-press and key-release by means of GPIO lines and
 report the event using GPIO interrupts to the cpu.
 
+Reduced mode:
+The reduced matric keypad supports multiple gpio lines, all gpio lines
+act as row as well as column lines, a key can be placed at each intersection
+of a row number not equal to a column number and they are diagonally
+symmetric.
+
+Example- For 5 gpio lines, possible matrix is 5x5 and maximum possible
+	keys are 10.
+
+	Sample matrix table for 7 buttons and 5 gpio lines
+
+        ------------------------------------------------------
+        |Row\Col |GPIO 0 | GPIO 1 | GPIO 2 | GPIO 3 | GPIO 4 |
+        ------------------------------------------------------
+        | GPIO 0 |  X    | KEY_9  | KEY_2  |   X    | KEY_1  |
+        ------------------------------------------------------
+        | GPIO 1 | KEY_9 |  X     | KEY_6  |   X    |  X     |
+        ------------------------------------------------------
+        | GPIO 2 | KEY_2 | KEY_6  |  X     | KEY_4  | KEY_7  |
+        ------------------------------------------------------
+        | GPIO 3 |  X    |  X     | KEY_4  |  X     | KEY_8  |
+        ------------------------------------------------------
+        | GPIO 4 | KEY_1 |  X     | KEY_7  | KEY_8  |  X     |
+        ------------------------------------------------------
+        X - invalid key
+        KEY_x - preferred key code
+
+The reduced mode sense a key-press and key-release by polling
+GPIO lines and report the event.
+
+
+Generic mode:
+
 Required Properties:
 - compatible:		Should be "gpio-matrix-keypad"
 - row-gpios:		List of gpios used as row lines. The gpio specifier
@@ -47,3 +82,64 @@ Example:
 				0x0101001C
 				0x0201006C>;
 	};
+
+Reduced mode:
+
+Required Properties:
+- compatible:		Should be "gpio-matrix-keypad-reduced"
+- number-of-buttons:	Number of buttons connected to the keypad controller.
+- line-gpios:		Gpio lines connected to keypad controller.
+			all gpio lines act as row as well as column lines.
+- linux,keymap:		An array of packed 1-cell entries containing the
+			equivalent of row, column and linux key-code.
+			The 32-bit big endian cell is packed as:
+			row << 24 | column << 16 | key-code
+
+Optional Properties:
+- poll-interval-ms:	Time interval between poll.
+- linux,no-autorepeat:	Do no enable autorepeat feature.
+- col-scan-delay-us:	Delay before scanning next active line.
+
+Example:
+        keypad {
+                compatible = "gpio-matrix-keypad-reduced";
+                poll-interval-ms = <10>;
+                col-scan-delay-us = <2>;
+                number-of-buttons = <7>;
+                linux,no-autorepeat;
+                line-gpios = <
+                        &gpio1 24 1     /*gpio_56*/
+                        &gpio1 23 1     /*gpio_55*/
+                        &gpio1 22 1     /*gpio_54*/
+                        &gpio1 20 1     /*gpio_52*/
+                        &gpio1 16 1     /*gpio_48*/
+                >;
+                linux,keymap = <
+                        0x00000000 /* row 0, col 0, KEY_RESERVED */
+                        0x0001000a /* row 0, col 1, KEY_9 */
+                        0x00020003 /* row 0, col 2, KEY_2 */
+                        0x00030000 /* row 0, col 3, KEY_RESERVED */
+                        0x00040002 /* row 0, col 4, KEY_1 */
+                        0x0100000a /* row 1, col 0, KEY_9 */
+                        0x01010000 /* row 1, col 1, KEY_RESERVED */
+                        0x01020007 /* row 1, col 2, KEY_6 */
+                        0x01030000 /* row 1, col 3, KEY_RESERVED */
+                        0x01040000 /* row 1, col 4, KEY_RESERVED */
+                        0x02000003 /* row 2, col 0, KEY_2 */
+                        0x02010007 /* row 2, col 1, KEY_6 */
+                        0x02020000 /* row 2, col 2, KEY_RESERVED */
+                        0x02030005 /* row 2, col 3, KEY_4 */
+                        0x02040008 /* row 2, col 4, KEY_7 */
+                        0x03000000 /* row 3, col 0, KEY_RESERVED */
+                        0x03010000 /* row 3, col 1, KEY_RESERVED */
+                        0x03020005 /* row 3, col 2, KEY_4 */
+                        0x03030000 /* row 3, col 3, KEY_RESERVED */
+                        0x03040009 /* row 3, col 4, KEY_8 */
+                        0x04000002 /* row 4, col 0, KEY_1 */
+                        0x04010000 /* row 4, col 1, KEY_RESERVED */
+                        0x04020008 /* row 4, col 2, KEY_7 */
+                        0x04030009 /* row 4, col 3, KEY_8 */
+                        0x04040000 /* row 4, col 4, KEY_RESERVED */
+                >;
+
+        };
-- 
2.20.1

