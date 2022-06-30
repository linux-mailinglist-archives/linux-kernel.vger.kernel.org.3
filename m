Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6C2561920
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbiF3L1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbiF3L05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:26:57 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70113.outbound.protection.outlook.com [40.107.7.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D944F64E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E90Y1Hm7AwFhTwpq5RON5fvAe5Mg1Y/dm0V6XYydeNP/tu2jiwBywwinXzxPgDPFmiCfJRTxqtLIrnwMeY4/UbPokGyvDWfq6jUxAFcImYxsxI1eBsLhFE6a6Vl4JfM8U2Jj0aaOkzgKsukwg9tbejdI2OnPDMic2DBRUEm5CrsLoOjDcFer9RRWLtSUW2/viGfrCiiXsEbiY29pc9vWezBSHWqI3jKqyrUuSWMMTDjz4ZAOeeM2tu4l+hjWn7eg2y5HymYDgpaQ13dbJe0FqjjX+i2Q/Oh3/JaBnkSDFN7LDzUJhrMkmyPPuVoEp9Nr87n0C565jB8uk3uYi/CGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAK2rMn2qNJ8+1rJGt3TH4Txh5zZIpcOdWViU/GFSkc=;
 b=lOk3ZpC5PE0RNiEnGT3GReFse67poXF3JA4yQAVgDHysbFWnGgNDCg6Xe6agSJE8Qzw3tqW2ZH9swDUyTqdMUtdnjY/ohtWFXZ5OZzqF9nVHsuzUXjz+HbA5BRjjcszsLiO9LCPpK2k53lIZbzvTdMVH8wggGtPtjx2RIA170PstHSIcTijwou2fmqzijsy2QP4nmjcINoLVyoq8OFqfsqLYuzb99bB8pZLBfgpu0UdsDbPnrn8smT4CIauxQJIsOBEvbNlAx1XKCGdwpjd+MXLllURAKFRgLQbbMbQD/mvgx+iNZJDItLxjfJJJCcigj9NgbcV3L/sqfvpuLBHWfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.159.232.72) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=bbl.ms.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=bbl.ms.philips.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAK2rMn2qNJ8+1rJGt3TH4Txh5zZIpcOdWViU/GFSkc=;
 b=dSTUFK9JzL1a5LlNlG51rzYfby2xbxx1pMBIczSmR+BZUQbE5kg5hjeCsq6oMoKjy4VURqjLC7JzaBfGswoA2nmkQl2JSSSv/rFV+esxtx5jKeSPBKzWASAbHBNpVXdFbb0amzTe4JcgHzLO8VCGw4p5qSrxocxVEjSEkOwwOuw=
Received: from SV0P279CA0001.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:11::6) by
 VI1P122MB0175.EURP122.PROD.OUTLOOK.COM (2603:10a6:802:98::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.22; Thu, 30 Jun 2022 11:26:52 +0000
Received: from HE1EUR01FT095.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:11:cafe::f4) by SV0P279CA0001.outlook.office365.com
 (2603:10a6:f10:11::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 11:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.159.232.72)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bbl.ms.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 212.159.232.72 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.159.232.72;
 helo=ext-eur1.smtp.philips.com; pr=C
Received: from ext-eur1.smtp.philips.com (212.159.232.72) by
 HE1EUR01FT095.mail.protection.outlook.com (10.152.1.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 11:26:51 +0000
Received: from smtprelay-eur1.philips.com ([130.144.57.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by ext-eur1.smtp.philips.com with ESMTP
        id 6kPmoelKRl9Zi6sJvoXdVL; Thu, 30 Jun 2022 13:26:51 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
        by smtprelay-eur1.philips.com with ESMTP
        id 6sJvodLaNBXNN6sJvoZUwq; Thu, 30 Jun 2022 13:26:51 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl2xr12.bbl.ms.philips.com (bbl2xr12.bbl.ms.philips.com [130.143.222.238])
        by mail.bbl.ms.philips.com (Postfix) with ESMTP id 9654B1833DE;
        Thu, 30 Jun 2022 13:26:51 +0200 (CEST)
Received: by bbl2xr12.bbl.ms.philips.com (Postfix, from userid 1876)
        id 892FB2A35B8; Thu, 30 Jun 2022 13:26:51 +0200 (CEST)
From:   Julian Haller <julian.haller@bbl.ms.philips.com>
To:     linux-kernel@vger.kernel.org
Cc:     julian.haller@philips.com, zbr@ioremap.net
Subject: [PATCH 4/4] dt-bindings: w1: Add schema for Maxim DS1WM
Date:   Thu, 30 Jun 2022 13:26:51 +0200
Message-Id: <20220630112651.2739425-4-julian.haller@bbl.ms.philips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630112651.2739425-1-julian.haller@bbl.ms.philips.com>
References: <20220630112651.2739425-1-julian.haller@bbl.ms.philips.com>
Reply-To: julian.haller@philips.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93ec2591-4dbb-4fd0-a406-08da5a8b6e1a
X-MS-TrafficTypeDiagnostic: VI1P122MB0175:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9YjOMj9j78YCE5nNdHAq93FtxAWXUVviqdojTJa3ajzqFKiaD81QQHubH0KJCNS8vO7v9g4Pt2R+sVAGgLnBJeBdTiAbb87svXtRdChzp8psteSKKzpnyTDHFyZ0MdbwjjP83/onjt31b16ZhADlH+mfTY37qfBP0VvJWehy8d4+XS81U4VsEH+JhIaaanNhd9Id/gerrjmGkTHrnRbI4QNuTRStOuPiqHWxzACXBX15AfvXuSjE1u3nevaWgrJ7IFFtie0wgVfbYcoemGll2xdZiYs5RlfhF1dMie0Py+W2+SAcud7O7o8IofdlwBcZzV1OgbVw8SDEpEOwfhUabfr30KCvxZTQgPNRE31DUrwPg7UhILI9StZ4Oui+NL/NZTKgvOMCmEYQZYnYiiruT/Cy5BNHyHX3kIwTaXx+JIw/m62T4gQWnd8B8Y7TLD0CafJNAStyLSgqaF86HtINgl+z2maCxcZt83sEZPdbKuCdJmxcKGVr87BWumAB7FHd2vs4cOauiGMLlo1t5AAOyw3CfIIWzPlveA6NKF49Gw7pO8AfHyi4KuZJDnYNbXwagCSkoN1QDnSP9HHDqEDha5UUG3HLV0EhaR3FPN0aFJz1Z8UzCNY0BOWHsZPSSv3MvBw+N9g+ELkhZIgngnPQshcXEjNIuExDQ2rMBGIY59z7VPTnjoBPicHJHP7XTsK300MsQn2Zw2wXM7TCEQu3j5eae0seTew1l7PH9T+zT8Vk0OThhYgP0whxkv/HHZCOGc8d0nlR/+Q8yPijr7Jmndekl9UELrub9h2UveOkz9yhMuwZxp3Lwy8C1ixgDfPhUukt1zvyE5k+Ew0e4qEc6XbF7iTIU4apdiiRQMYrL9sBe5yAncfwsRQmxMrZSMwF5DBZ/MDn5hKBSjx+czkLIQ==
X-Forefront-Antispam-Report: CIP:212.159.232.72;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(36840700001)(46966006)(40470700004)(356005)(2616005)(82740400003)(8676002)(82960400001)(42186006)(36860700001)(40480700001)(966005)(6916009)(82310400005)(316002)(70586007)(26005)(6266002)(478600001)(4326008)(70206006)(40460700003)(7636003)(41300700001)(8936002)(426003)(336012)(83380400001)(5660300002)(2906002)(1076003)(44832011)(186003)(107886003)(7596003)(47076005)(32563001)(473944003);DIR:OUT;SFP:1102;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 11:26:51.9602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ec2591-4dbb-4fd0-a406-08da5a8b6e1a
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[212.159.232.72];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT095.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P122MB0175
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Haller <julian.haller@philips.com>

The Maxim DS1WM is a synthesizable 1-Wire Bus Master for usage in
custom ASIC and FPGA designs. The datatsheet can be found under
https://datasheets.maximintegrated.com/en/ds/DS1WM.pdf

Signed-off-by: Julian Haller <julian.haller@philips.com>
---
 .../devicetree/bindings/w1/maxim,ds1wm.yaml   | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/w1/maxim,ds1wm.yaml

diff --git a/Documentation/devicetree/bindings/w1/maxim,ds1wm.yaml b/Documentation/devicetree/bindings/w1/maxim,ds1wm.yaml
new file mode 100644
index 000000000000..c3f57ff2fdde
--- /dev/null
+++ b/Documentation/devicetree/bindings/w1/maxim,ds1wm.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/w1/maxim,ds1wm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim DS1WM One wire bus master controller Binding
+
+maintainers:
+  - Evgeniy Polyakov <zbr@ioremap.net>
+
+description: |
+  This document describes bindings which can be used to
+  describe DS1WM devices in a device tree. The DS1WM is a synthesizable 1-Wire
+  Bus Master for usage in custom ASIC and FPGA designs.
+
+  The datatsheet can be found under
+  https://datasheets.maximintegrated.com/en/ds/DS1WM.pdf
+
+properties:
+  $nodename:
+    pattern: "^w1(@.*|-[0-9a-f])*$"
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  compatible:
+    const: maxim,ds1wm
+
+  maxim,clock-rate:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      DS1WM input clock rate.
+
+  maxim,active-high:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      When set, INTR pin is active high. Defaults to active low.
+
+  maxim,register-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      DS1WM register size in bytes.
+    oneOf:
+      - enum: [1, 2, 4]
+
+  maxim,reset-recover-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Amount of time to sleep following a reset pulse (in milliseconds). Zero
+      should work if your bus devices recover time respects the 1-wire spec
+      since the ds1wm implements the precise timings of a reset pulse/presence
+      detect sequence.
+
+  maxim,big-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Set if DS1WM hardware is of type big-endian. Defaults to little-endian.
+
+  maxim,strong-pullup-enable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enables the strong pull-up output enable (STPZ) pin’s functionality which
+      allows an external strong pull-up any time the master is not pulling the
+      line low or waiting to read a value from a slave device. This
+      functionality is used for meeting the recovery time requirement in
+      Overdrive mode and long-line standard communications.
+
+  maxim,strong-pullup-supply:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enables the STPZ output while the master is in an IDLE state. This will
+      provide a stiff supply to devices requiring high current during
+      operations. Requires maxim,strong-pullup-enable.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - maxim,register-size
+  - maxim,reset-recover-delay
+  - maxim,clock-rate
+
+additionalProperties: false
+
+examples:
+  - |
+    w1@4200 {
+        compatible = "maxim,ds1wm";
+        reg = <0x4200 0x24>;
+        interrupts = <10>;
+        maxim,register-size = <4>;
+        maxim,reset-recover-delay = <2>;
+        maxim,clock-rate = <100000000>;
+        maxim,strong-pullup;
+        maxim,big-endian;
+        maxim,active-high;
+    };
+...
-- 
2.25.1

