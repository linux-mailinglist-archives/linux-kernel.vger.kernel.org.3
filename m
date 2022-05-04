Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44330519D70
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348445AbiEDK5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348365AbiEDK5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:57:12 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60073.outbound.protection.outlook.com [40.107.6.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1252613A;
        Wed,  4 May 2022 03:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2sUzPuZtI7EYwyUTiI5mNCQ48dIc+Xv5cbTXMiR3/zOyxnDC1g1PYQwHVACZTpyDMfmoHhAMYDsQ3qukgD6O4rBdcXmYvWJ1u/H32G3GNIvNZ4DL/QTHQ6jAcAZu4cx9v1g508BV1k0oevRvEGiy6mJzrwn8npeqjQ1dmd3JASJ/ZKTwjG0XwcGzqM77L55RuNGXQ/KkmUc/IoEXONe8NO1VTYkJI32kS+jNsU6LOApHtamLak1S3t/2Kqbl/cAriaQX6MWBTdjho6RawoNPLYWg0bNia1jhRvN7MEWJXY6ef3rLsyXl+gcSyEJHgEinr8fgB/ZPOvtkgA4ZKZ5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg4ruBWX8xAgoRwabWOQbPrfznvfyIHfENU/osYJm1I=;
 b=HkYoyQXsXU/MISXIPORfoUrUw02PamflsdOic1jPzIWhPVPIr0h0Fb+4dZFVObg4qEE7nOAHbQ+AzRgryM7nbs0GOnvyGqaO4Yt/9nCk1fl2IwuKRsB9EeJ3F46b39Jpnsvh06MIeWDtvp4tMMFYQjczmdfu66Wpy6QF4dogtQa5PZXJy5s1JqnTK1/2G2NJWy08E3MBvCfFWJApgpNW0hOto2b5eba81FrwxnCwT6I5Lf4TsnTBGJmvo3NE/DOMu+bStx3nRrPozdUZur+u9YKdPzMC3sQUeI/0u8opvjQs+dmwV8ZZ9E5WBka1FvXElu4g3JbVKIve3m9yrbye0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.199) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg4ruBWX8xAgoRwabWOQbPrfznvfyIHfENU/osYJm1I=;
 b=TfMKFKvyv3jJ7pTjc5en21OApjPal6pEGVrmgIMxivi0Crae52T5I24SMA7UNiLgZ9+0+YR1aSsTtJe4IqLRkVIEbyYxNN4R+p7z/s5/0qui+KL9p94WXmmpqBN9sVoy0LOifJSB/3XkksuXtOaQ+U5+3mzj/1ci4CDaoG+HX+w=
Received: from DU2PR04CA0058.eurprd04.prod.outlook.com (2603:10a6:10:234::33)
 by AS4PR10MB5521.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 10:53:33 +0000
Received: from DBAEUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:234:cafe::19) by DU2PR04CA0058.outlook.office365.com
 (2603:10a6:10:234::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25 via Frontend
 Transport; Wed, 4 May 2022 10:53:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.199)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.199 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.199; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.199) by
 DBAEUR03FT052.mail.protection.outlook.com (100.127.142.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 10:53:33 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Wed, 4 May
 2022 12:53:27 +0200
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Wed, 4 May 2022 12:53:27 +0200
Received: from localhost.localdomain (10.167.1.123) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Wed, 4 May 2022
 12:53:23 +0200
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
Subject: [PATCH 4/4] dt-bindings: input: mt-matrix-keypad: add guardian mt matrix keypad bindings definition
Date:   Wed, 4 May 2022 10:52:54 +0000
Message-ID: <20220504105254.1576-4-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220504105254.1576-1-Gireesh.Hiremath@in.bosch.com>
References: <20220504105254.1576-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.123]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 413c6887-de9d-4c4e-0d8e-08da2dbc5559
X-MS-TrafficTypeDiagnostic: AS4PR10MB5521:EE_
X-Microsoft-Antispam-PRVS: <AS4PR10MB5521E4328127F3DBE9A9FC98A6C39@AS4PR10MB5521.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JqqqRLpxPIaDnLiMEidM6NnVu8FT0BWkWfM7wIno40y7NiuX5iE+V68YGdG+DgvjXYiVuOZTbBxrRSlktlGoroR630/jufbvATbEBlq4ask30bN6vF070IpqnWe3khmLEpjvGRFgoInBBrfcOJAPVsJke/WvP6y879WgVrMbn7GvJAgAHSvltrJXcAi4pxihL5E8k9zz7W3q1+qKTQ2sODMS2arlNUfWOfcltVzcwi6lszKg+DVl2uMBxPTepp721rQNUqPhYrLyVNHdRQHuiPxH1pc8IWblveKZj49L03Gxn5ZQz7BvyDV0p9BknJoQL1w2cjbh9abMLpwQsZg9xtvTK1A01zPL+QZWeaDKNeKeVHJ8Pz5mSC927i2eccLXk96KQZCdp4FWUIQzwJU8V9q31qjO7jnYY/v3XhL0zY97+hvBTVxZN4LHBvO+E2O37e6TRBMBwpk18QbKaKI0FxdkmlmSlJkk0eS3jYatMnTK8kagdlmosmJ7MmIBuWeTbJbvpYcgFdXaVtseXZAE+kVmmWZ5RL/4QF6sAu6vkSGWVxPWLyOlzuWoBvmqjM8OLjfQytcI4B7MiS4Rv6ycVj+KV3JPmqHNZsmznsg0Ct6IDzKw2+rOh/u4lWqTVK7kEJrBe90HfjXm/VH25+DQhbtWuPYi912Pqr0hkEn1KH4+Yx1TB2SQiWNKU2t9T2hToyQ41gGqbPuuvI0zViJeL7xciV9/fTp1XjjSU4SEn+272MLxgyyJBcv9zHPTloP3l3Zk7F3cTuA8tZ211HddMVtmjxkpblnxRi5w+duuLNoXlB7IzkNOvluTYnMQcKVX
X-Forefront-Antispam-Report: CIP:139.15.153.199;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4326008)(40460700003)(16526019)(36860700001)(2906002)(921005)(70206006)(8676002)(70586007)(2876002)(356005)(82960400001)(6666004)(7416002)(86362001)(5660300002)(26005)(2616005)(8936002)(966005)(508600001)(47076005)(54906003)(316002)(107886003)(110136005)(186003)(7049001)(336012)(1076003)(81166007)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 10:53:33.4253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 413c6887-de9d-4c4e-0d8e-08da2dbc5559
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.199];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT052.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5521
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

Add binding definition for the support of the Guardian
mt matrix keypad driver.

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 .../bindings/input/mt-matrix-keypad.yaml      | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/mt-matrix-keypad.yaml

diff --git a/Documentation/devicetree/bindings/input/mt-matrix-keypad.yaml b/Documentation/devicetree/bindings/input/mt-matrix-keypad.yaml
new file mode 100644
index 000000000000..b52cd478f638
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/mt-matrix-keypad.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/mt-matrix-keypad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO driven mt matrix keypad device tree bindings
+
+maintainers:
+  - vinay <VinayKumar.Shettar@in.bosch.com>
+
+description: |
+  GPIO driven mt matrix keypad is used to interface a SoC with a mt matrix
+  keypad. The mt matrix keypad supports multiple gpio line, all gpio line act
+  as row as wel as column lines, a key can be placed at each intersection
+  of a unique row number not equal to a unique column and they are diagonally
+  symmetric.
+
+  Example- For 5 gpio lines, possible matrix is 5x5 and maximum possible
+        keys are 10.
+
+        Sample matrix table for 7 button and 5 gpio line
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
+  The mt matrix keypad can sense a key-press and key-release by means of GPIO
+  lines and report the event using GPIO interrupts to the cpu.
+
+properties:
+  compatible:
+    oneOf:
+      - const: gpio-mt-matrix-keypad
+      - items:
+          - enum:
+              - gpio-mt-matrix-keypad
+          - const: gpio-mt-matrix-keypad
+
+  debounce-delay-ms:
+    description: Delay after the first bounce of button.
+    default: 0
+
+  col-scan-delay-us:
+    description: Delay before scanning next active line.
+    default: 0
+
+  number-of-button:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Number of button connected to the keypad controller.
+
+  linux,no-autorepeat:
+    description: |
+      Disable the Linux input system's autorepeat feature on the input device.
+
+  gpio-activelow:
+    description: Gpio line are active low.
+
+  line-gpios:
+    description: |
+      Gpio lines connected to keypad controller.
+      all gpio line act as row as wel as column lines.
+
+  linux,keymap:
+    $ref: '/schemas/types.yaml#/definitions/uint32-array'
+    description: |
+      An array of packed 1-cell entries containing the equivalent of row,
+      column and linux key-code. The 32-bit big endian cell is packed as:
+          row << 24 | column << 16 | key-code
+
+required:
+  - compatible
+  - number-of-button
+  - line-gpios
+  - linux,keymap
+
+additionalProperties: true
+
+examples:
+  - |
+    mt_matrix_keypad {
+        compatible = "gpio-mt-matrix-keypad";
+        debounce-delay-ms = <10>;
+        col-scan-delay-us = <2>;
+        number-of-button = <7>;
+        linux,no-autorepeat;
+        gpio-activelow;
+        line-gpios = <
+                &gpio1 24 1     /*gpio_56*/
+                &gpio1 23 1     /*gpio_55*/
+                &gpio1 22 1     /*gpio_54*/
+                &gpio1 20 1     /*gpio_52*/
+                &gpio1 16 1     /*gpio_48*/
+        >;
+        linux,keymap = <
+                0x00000000 /* row 0, col 0, KEY_RESERVED/invalid key */
+                0x0001000a /* row 0, col 1, KEY_9 */
+                0x00020003 /* row 0, col 2, KEY_2 */
+                0x00030000 /* row 0, col 3, KEY_RESERVED/invalid key */
+                0x00040002 /* row 0, col 4, KEY_1 */
+                0x0100000a /* row 1, col 0, KEY_9 */
+                0x01010000 /* row 1, col 1, KEY_RESERVED/invalid key */
+                0x01020007 /* row 1, col 2, KEY_6 */
+                0x01030000 /* row 1, col 3, KEY_RESERVED/invalid key */
+                0x01040000 /* row 1, col 4, KEY_RESERVED/invalid key */
+                0x02000003 /* row 2, col 0, KEY_2 */
+                0x02010007 /* row 2, col 1, KEY_6 */
+                0x02020000 /* row 2, col 2, KEY_RESERVED/invalid key */
+                0x02030005 /* row 2, col 3, KEY_4 */
+                0x02040008 /* row 2, col 4, KEY_7 */
+                0x03000000 /* row 3, col 0, KEY_RESERVED/invalid key */
+                0x03010000 /* row 3, col 1, KEY_RESERVED/invalid key */
+                0x03020005 /* row 3, col 2, KEY_4 */
+                0x03030000 /* row 3, col 3, KEY_RESERVED/invalid key */
+                0x03040009 /* row 3, col 4, KEY_8 */
+                0x04000002 /* row 4, col 0, KEY_1 */
+                0x04010000 /* row 4, col 1, KEY_RESERVED/invalid key */
+                0x04020008 /* row 4, col 2, KEY_7 */
+                0x04030009 /* row 4, col 3, KEY_8 */
+                0x04040000 /* row 4, col 4, KEY_RESERVED/invalid key */
+        >;
+    };
-- 
2.20.1

