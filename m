Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BF051D249
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389549AbiEFHdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389548AbiEFHdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:33:02 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ECF66FA0;
        Fri,  6 May 2022 00:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMP0NWJWgS3stdeGj4v9ZvusMUfohC0nqhc8Jf8faBetKQc7sZuDNLJgiDrur4Nc7mqklFOS6TEKMMCqBJLm8jToAomPf346gb4x8gLob2t4mZo/sdKRZLDxssjDjzy6BHgFeR46xfjqqwgdWaINLgClNykZ3vzpogp5Xr9zWuCprSuDuD/LMARwViaAvFUXZU7TYwsc7w95llteIyKor0czKKKfA8zmsWPSRcbE9jXcYiN7V9425tlChcG4jKEoi0LzU0krblsIhqnguJYRP+Kyplj6ZXDccyKYWoLz5AE18NKeFs893Zu+/Z8teLTYpqpbovQcV46vO78vF5vcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDfLiqMaFnxYhVi9yn91Ko6mT0Lpt3PlAC2y+iD44jk=;
 b=FLN4VpatEuZlE2BSCDgl3QDhyJTkt3fVt1KY0nAk2qJtEkpnZVzrrvv/hTFH62Nb/WuDqcMys3nOvUP74CiLJYk5RMW79APrdb3XQLzrD6k0CC9Hqd4ERbPbwn4Mg01WtmcJ4EaJSxfkdEEn/79B75fRVF4/+ChqcFsENwFY4MjdpeIiwntBvMJjc9KUFlHcZ+Vf1W/13jFX9lUoQbJhGaRdLf1VfSIcn1wXga4iHXiplMrWWSU0SY8OacnbuX+35VZUGp05/0XEHR+/Q0zUj6LxuE3zYve+LstOpOzHh7MukuBId6doOr3EPYP6j5OrqJg4G0oWY4kaabn78Rym8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDfLiqMaFnxYhVi9yn91Ko6mT0Lpt3PlAC2y+iD44jk=;
 b=UHonRfDvdNGKCikn4DgJrqm/4YXavC2zMZfZmO3gROVDCimX8gKolFdqvKiXLeMIDJJAhkE9qQ8k5sMYrPmi1vcYUEMV+RZupDbjSuRN1nP+Jj5JASVFQHL9uKYqhFENw9WGhC9m/K3goUIxR91JGfOA252dKo81x/Ub6yRe9wg=
Received: from AM6P193CA0089.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::30)
 by DB8PR10MB3308.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Fri, 6 May
 2022 07:29:15 +0000
Received: from AM5EUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:88:cafe::34) by AM6P193CA0089.outlook.office365.com
 (2603:10a6:209:88::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Fri, 6 May 2022 07:29:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.203 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.203; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.203) by
 AM5EUR03FT035.mail.protection.outlook.com (10.152.16.119) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 07:29:15 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 6 May
 2022 09:29:14 +0200
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 6 May 2022 09:29:14 +0200
Received: from localhost.localdomain (10.167.1.123) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Fri, 6 May 2022
 09:29:10 +0200
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
Subject: [PATCH v2 4/4] dt-bindings: input: mt-matrix-keypad: add guardian mt matrix keypad bindings definition
Date:   Fri, 6 May 2022 07:27:37 +0000
Message-ID: <20220506072737.1590-4-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220506072737.1590-1-Gireesh.Hiremath@in.bosch.com>
References: <20220506072737.1590-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.123]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3ba7966-136e-43b5-3943-08da2f321faa
X-MS-TrafficTypeDiagnostic: DB8PR10MB3308:EE_
X-Microsoft-Antispam-PRVS: <DB8PR10MB3308DED5F1AF15A21AC2E269A6C59@DB8PR10MB3308.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lCR4IZ/Rf+6YXhD5G2oyG97fFwxPV92piXNF4kepTP6LOpE3IEEYGH1J6z1JPcccm/gB4dfBjjEqCKMh4NfE6QhyJYbmkZ9dIPL6IJM8Iy0/4kSRZlVC6hzrdBztMwSrbV7jMnbDodP/F6kKAsxQFXgwxJ4RfDcbjyjrzO7MMUEpwLYmJOPnDzgeXAEwOxjM5MfFZ2eks/0vdXUtf/UcbCqmF1ZceDXdnK3ul5VEZCbffVT0bo1P3eaFvyqOPqSTbtk8YdhCxukHaQ9EJWUeNQr2uOAwPpsDTLTQW5/nljSK/e2ZQ7NV/YFqebO59DAVObaqyyWTckKLvFzGiXguRDb2mnep4shhkn4dvof3g//4S5lwIidf4gGFNVjMysj2uBKC8hPL/y7BW+nW6d3OiIdQjWmvFr1ipoxlTzCSijKKa5UKFeOGJWVs90TAYJqizuBa2JEchaPpkWMbb0fQrZ2W70A0GyZUcR6/OllVI24V5GBHsoB84DVylNMDFOBom7fBLKrg3q73D+lB0BZuHhCg9zcoe/yG3MYr3ZUE4EFb8w1uoiXmYBrXwGpyv/0uHpbRzL3YICdB85Q4BbkkLcBLIve90Zc9zaG00Q64/o/h2VTRHhvJv9dFQYFKG+leHFguyVW6Fr9mO60LmakGwn+M8CSAy6lLuSTg7ovHRRS+4UXoARTVZAZScdwjybV1woj5Iv9Qag5DKqNDi6Ti/b903QHHJBybXtZZXOgms1jxdtqMBA7QzoKsgYS/U9HOrw5E6atfJDs4OQmyBKx24dq5h/3kYTQ4YnYLHina3pf1PnWMLzardJoVnFQujxss
X-Forefront-Antispam-Report: CIP:139.15.153.203;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(336012)(5660300002)(54906003)(107886003)(110136005)(1076003)(82310400005)(7416002)(2616005)(508600001)(26005)(40460700003)(966005)(70586007)(8676002)(4326008)(316002)(70206006)(47076005)(186003)(82960400001)(16526019)(36860700001)(81166007)(83380400001)(8936002)(356005)(921005)(7049001)(6666004)(86362001)(2906002)(2876002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 07:29:15.1528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ba7966-136e-43b5-3943-08da2f321faa
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.203];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3308
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
Hi Krzysztof

Changes since v1: addressed review comments

>> Add binding definition for the support of the Guardian
>> mt matrix keypad driver.
>>
>> Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
>> ---
>>  .../bindings/input/mt-matrix-keypad.yaml      | 134 ++++++++++++++++++
>>  1 file changed, 134 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/input/mt-matrix-keypad.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/input/mt-matrix-keypad.yaml b/Documentation/devicetree/bindings/input/mt-matrix-keypad.yaml
>> new file mode 100644
>> index 000000000000..b52cd478f638
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/mt-matrix-keypad.yaml
>> @@ -0,0 +1,134 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/input/mt-matrix-keypad.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: GPIO driven mt matrix keypad device tree bindings
>> +
>> +maintainers:
>> +  - vinay <VinayKumar.Shettar@in.bosch.com>
>> +
>> +description: |
>> +  GPIO driven mt matrix keypad is used to interface a SoC with a mt matrix
>> +  keypad. The mt matrix keypad supports multiple gpio line, all gpio line act
>
>s/line/lines/

modified

>> +  as row as wel as column lines, a key can be placed at each intersection
>
>s/wel/well/

modified

>> +  of a unique row number not equal to a unique column and they are diagonally
>> +  symmetric.
>> +
>
>What is "mt" in the "mt matrix"?
>

mt is bosch measuring tools matrix keypad

>> +  Example- For 5 gpio lines, possible matrix is 5x5 and maximum possible
>> +        keys are 10.
>> +
>> +        Sample matrix table for 7 button and 5 gpio line
>> +
>> +        ------------------------------------------------------
>> +        |Row\Col |GPIO 0 | GPIO 1 | GPIO 2 | GPIO 3 | GPIO 4 |
>> +        ------------------------------------------------------
>> +        | GPIO 0 |  X    | KEY_9  | KEY_2  |   X    | KEY_1  |
>> +        ------------------------------------------------------
>> +        | GPIO 1 | KEY_9 |  X     | KEY_6  |   X    |  X     |
>> +        ------------------------------------------------------
>> +        | GPIO 2 | KEY_2 | KEY_6  |  X     | KEY_4  | KEY_7  |
>> +        ------------------------------------------------------
>> +        | GPIO 3 |  X    |  X     | KEY_4  |  X     | KEY_8  |
>> +        ------------------------------------------------------
>> +        | GPIO 4 | KEY_1 |  X     | KEY_7  | KEY_8  |  X     |
>> +        ------------------------------------------------------
>> +        X - invalid key
>> +        KEY_x - preferred key code
>> +
>> +  The mt matrix keypad can sense a key-press and key-release by means of GPIO
>> +  lines and report the event using GPIO interrupts to the cpu.
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: gpio-mt-matrix-keypad
>> +      - items:
>> +          - enum:
>> +              - gpio-mt-matrix-keypad
>> +          - const: gpio-mt-matrix-keypad
>
>Aren't all these compatibles the same?

modified

>> +
>> +  debounce-delay-ms:
>> +    description: Delay after the first bounce of button.
>> +    default: 0
>> +
>> +  col-scan-delay-us:
>> +    description: Delay before scanning next active line.
>> +    default: 0
>> +
>> +  number-of-button:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: Number of button connected to the keypad controller.
>
>s/button/buttons/ I presume.

modified

>> +
>> +  linux,no-autorepeat:
>> +    description: |
>> +      Disable the Linux input system's autorepeat feature on the input device.
>> +
>> +  gpio-activelow:
>> +    description: Gpio line are active low.
>
>No, GPIOs should instead use common flags.

this flag is used to compare with the gpio read value

>> +
>> +  line-gpios:
>> +    description: |
>> +      Gpio lines connected to keypad controller.
>> +      all gpio line act as row as wel as column lines.
>> +
>> +  linux,keymap:
>> +    $ref: '/schemas/types.yaml#/definitions/uint32-array'
>> +    description: |
>> +      An array of packed 1-cell entries containing the equivalent of row,
>> +      column and linux key-code. The 32-bit big endian cell is packed as:
>> +          row << 24 | column << 16 | key-code
>
>But anyway this should be just merged into matrix-keypad. It's a simpler
>set of that binding.

we have special keypad for Bosch measuring tools, which is not completely
matric keypad so we have derived from matrix_kepad.c to make our keypad
to work.

>> +
>> +required:
>> +  - compatible
>> +  - number-of-button
>> +  - line-gpios
>> +  - linux,keymap
>> +
>> +additionalProperties: true
>
>This cannot be true.
>

updated

>
>> +
>> +examples:
>> +  - |
>> +    mt_matrix_keypad {
>
>No underscores in node names. Generic node name, so just "keypad".

modified

>Best regards,
>Krzysztof

Best regards,
Gireesh Hiremath

 .../bindings/input/mt-matrix-keypad.yaml      | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/mt-matrix-keypad.yaml

diff --git a/Documentation/devicetree/bindings/input/mt-matrix-keypad.yaml b/Documentation/devicetree/bindings/input/mt-matrix-keypad.yaml
new file mode 100644
index 000000000000..d88a2e712667
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/mt-matrix-keypad.yaml
@@ -0,0 +1,129 @@
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
+  keypad. The mt matrix keypad supports multiple gpio lines, all gpio lines
+  act as row as well as column lines, a key can be placed at each intersection
+  of a unique row number not equal to a unique column and they are diagonally
+  symmetric.
+
+  Example- For 5 gpio lines, possible matrix is 5x5 and maximum possible
+        keys are 10.
+
+        Sample matrix table for 7 buttons and 5 gpio lines
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
+    const: gpio-mt-matrix-keypad
+
+  debounce-delay-ms:
+    description: Delay after the first bounce of button.
+    default: 0
+
+  col-scan-delay-us:
+    description: Delay before scanning next active line.
+    default: 0
+
+  number-of-buttons:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Number of buttons connected to the keypad controller.
+
+  linux,no-autorepeat:
+    description: |
+      Disable the Linux input system's autorepeat feature on the input device.
+
+  gpio-activelow:
+    description: Gpio lines are active low.
+
+  line-gpios:
+    description: |
+      Gpio lines connected to keypad controller.
+      all gpio lines act as row as well as column lines.
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
+  - number-of-buttons
+  - line-gpios
+  - linux,keymap
+
+additionalProperties: false
+
+examples:
+  - |
+    keypad {
+        compatible = "gpio-mt-matrix-keypad";
+        debounce-delay-ms = <10>;
+        col-scan-delay-us = <2>;
+        number-of-buttons = <7>;
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

