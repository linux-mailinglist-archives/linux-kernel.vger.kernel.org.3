Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A501050EEB3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 04:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242183AbiDZC1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241949AbiDZC1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:27:33 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20044.outbound.protection.outlook.com [40.107.2.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF7FAD131;
        Mon, 25 Apr 2022 19:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5EWoBT2oe8ushvdYwvxuwGNghpudwjA/3cIbT/B85GVdfd+pwv+YC0grS6qkPNcSBwGu1J7LKfYlEELTkUaPaCqxXYyrTqk/04iQlDDKD+Bt3I4mNEIc8EHMTO1hQi/mwTuaGPc9OE0933Frx2Q0LwMBrQQsUj93N68xZfrzh1saM1Q4CPBFF5dWgPFoxffK2RN580MeSwHFVplhkemAMt043/0wCk2oSk4Z7f7aCJgYsR3XEYS+exq27hdfHogOcu3JNQPm6+9YqsVEKi8x3aPkDQUEUuxZ1uIkLFMxMeZYVAoKk+hCe8rP5efWKDIwm6/itK1D+HP3guuYRh1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMjVPGa2ZvyrlfuABVg3JPk4xJXkPDOJ8l2PpruaOjo=;
 b=TfI9/nQktBJJwPghF4z7x2htrLySvl1zz3Jm38qMUtXOseDA4IgkLsMn4bx43Fr55KMvjgVjam+oNv2AEYbfCTVlYCRvcHg4RdnmfecBMP2rkdZBK/CPWKLq+VLR4xkeBp/fJezHCLjYYcEqqOm32uWNpEFeFeLCPkPzifrJw4sV0P4JeoefAsUpVpQm1m42MgS9Ruz45TKoxbCnZNAZgVuuaZzPiSwByLtf80YFyqjXahrso444Svt69Ccu+ta9eHAsGcZoV9F4GpctywtcUCqLh65L46SN+wZIlG1fC9wZiLnbrvqxSYk8x7CnG/BB8R15ARDCVeHZMWBTaq/kcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMjVPGa2ZvyrlfuABVg3JPk4xJXkPDOJ8l2PpruaOjo=;
 b=lsRPkePCETxGqnIHYNS4v0UKsnkCL96qgHsFhEW3RglRsfULu8BglYPa8s3IUYxAzKTimHLVV5bSgyEHda+m47AcKVwG+5aPDs/DFavLpyD61HIXLSksk2RmdXaxSsvP+cf3d1GnJyE/X1gjp4GKkAYiLQZNrb5abZeDemR309I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by VI1PR04MB6127.eurprd04.prod.outlook.com (2603:10a6:803:fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 02:24:24 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 02:24:24 +0000
From:   Changming Huang <jerry.huang@nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Changming Huang <jerry.huang@nxp.com>
Subject: [PATCH 1/3 v5] dt-bindings: dspi: added for MikcroBus socket
Date:   Tue, 26 Apr 2022 10:24:11 +0800
Message-Id: <20220426022413.885092-1-jerry.huang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To VE1PR04MB6477.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 224f4c99-e05d-4fec-1435-08da272be0ea
X-MS-TrafficTypeDiagnostic: VI1PR04MB6127:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6127D2CD333213890EFD3303FEFB9@VI1PR04MB6127.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPzBbEZb17kdRVU2H2pNLPAuKQPpem6colng2SPSo0AAQcjfmoto5qTP0VRXhL56psHjtmm1sA7r1GFY5+7dofu/B27AcsWdS4SIOCaIuf+fjyjDl4HfYX6q7emDfs6VEh5Ad0w0PjyAssSDYKGGlTKlsqnLeeDg0uTgMIMxK5RG5McigYolgRZkHRTSbsa+HREG4rthOC3xUzGH3ZFc8RevegM5EAB4kJonPjgBIqqe7zBft9XeFN2K4f1QSkpCwMQe2Mo2EfEDlNtG/+p++NgFCt3YQqie2txuMXEqVHClhuxsNHd2QkcTP1fWh5sfhPrLRprlr+LKbyParJCpXa/Crt7mmTZ1jDPegdFXXmA4SDLKOx4bANVHjq5E46PHUDiAzLsZluFCFvTVnEAM3jfR1rEmtiy9ODPxgEdIw7lse5sv4G7OLieiYn5wHAjjYbHlCRjwuPb8G7IYDN9OPJFRki7ki05CqzecUC7NfiipihrVYL0zgASwKhw922z7u67CjFmr9tp6dS84j2kwkP9ekwJroGphN0wzT0N3X3A6DkQtDBrl0EkMlkL/LfCoqjYssQD9jR7v9r7O0AaCG18VoEnXLW2hrnlU0xu1Cn5ddOyS0kCf5BngKYnx8otqszD0TwhOJmfQMQpis2Ptdklchstb8PTouKKODKyW8HDGme9Sr2y+bKTb1Z2D/c1F4W67R7Ml+I8lKKERJvGDDtpqP8/lmedXsC/yhQGmMZXpyCHU5NNPowT9qTsbXQ7CJPwCDwRP1QptJFsJzgmXXuzaIUrFPKzdA8bZB6wUQtejNqLNz3szbwSXM241XdLo1lyxs2C7QP/UpWUULpgPjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(26005)(8936002)(316002)(86362001)(5660300002)(52116002)(6666004)(966005)(186003)(2616005)(36756003)(6506007)(1076003)(38100700002)(2906002)(38350700002)(508600001)(6486002)(8676002)(4326008)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?smX7xQ+5nC7SeQOLj4DR4bCqEGXMGDHqbcHjOs8yS6S9a6z8po2U9XJbxGx5?=
 =?us-ascii?Q?E8WRmAmcUUjNxs3gfGxkV0n0nqdhopG6wfY/2ctJMO/ZMscaJJCFOYkf22V/?=
 =?us-ascii?Q?AQQmjDy/tb++aqQqjhDxbt7T3TrvmhGzuTGLvVMHbJTCKXhtClFr3aeKadTQ?=
 =?us-ascii?Q?/G8U4DMx53OZKkZEdy9K0Hl85+77pdPlauUBypFWh7qNpPJl2GAkRwyHSxdB?=
 =?us-ascii?Q?pJHyFh2yODem4SIyiFzoxwcwa1bGvwuMGxvhdpSjhmATkIv2wykaT4I9FVCQ?=
 =?us-ascii?Q?nfZNlMbHaFE/02u9NVbyfN33g90iZ6m5ztufzVu8oPNp4oyDi1yiUHqt1dHV?=
 =?us-ascii?Q?iAYMpTkV802nl4GHNnbJBIGC38P2S0qIWbGYyaVGR1Pt3ZZVDIB/bthjK8hc?=
 =?us-ascii?Q?1ItwAD4uFAsEO3WXdYO/tq1BBtrd1Gauu49b9Q6hxCEAcx1ylCRkOYspSXJ0?=
 =?us-ascii?Q?KCfx1knOkPcY+HJda+KaCpCWF2ehdghuL/DduhZzBRC1nhTBA+uDiPYOYsmj?=
 =?us-ascii?Q?HNti8h+v0yBCLfpIbr8fy+2UXgsMmGs9bPvrbJvF4oCyohQ5SFjD5TxNfQjn?=
 =?us-ascii?Q?7MWxSSrleX7tnNLfTkZrpefHrpSZNfhiNwgavgWjwpWXSJ2c4VoyCpUqGci3?=
 =?us-ascii?Q?yCQXeOF/OSPRayfy5t97JUfIEik/pM2aeOipzWd48tkNeAeEnbMpK82ogy62?=
 =?us-ascii?Q?c621cK0b6Ds6Dw/9g2PwN/2ICsbnNgW/4wLW4iPL39vrBncudzN8vXUqyHZX?=
 =?us-ascii?Q?nD8ZMGlu4yuWK9ne1XL7itOtYhuCZmJMALw3PugDfZTjWvNKxz5D39oSyp6y?=
 =?us-ascii?Q?VaHu1LLnZ3YfVItlGiC+14xMZP8+NUTbbk8cpa0UkuMEnLVQU7gI7DTYUK6o?=
 =?us-ascii?Q?nJiNEP2i2e52xuEbtyPbe7YKraH+x7aTtihaVp5Iz1d4ZWDOHDx3n/2HXSjz?=
 =?us-ascii?Q?iHhVLtbtQtSH/eD2+jbIvIf1BFX1H57npMFLVC9fDWdQ0zfMkRJsGlLUWEe2?=
 =?us-ascii?Q?eACLw5j39kk5j7pdseU0QwsRHwkPrt3Q315XlExILDC8c5Py9ffN0Sg1c9t5?=
 =?us-ascii?Q?j0PhNTxE1nsl5JFNtb1epS6CBI6rmoqvdyTky+B1y2ukrxDLzWuJeyp1Vmln?=
 =?us-ascii?Q?LySOlNipdjUilnLfZtqlTRldLa1Nsr+AxmYGBrDTB+Ib9rrexjZxX/7Pg+kq?=
 =?us-ascii?Q?NbodtvTRb8RX/DjO6YkprdSKSO/tmE59s85l51l7um+zlO80J71yjhr4DdYN?=
 =?us-ascii?Q?Y5Azr6NubXx41NQXQUvAA1RVCN2glMKAkHq7PIAwsfpdId03imLgGK3/Sgyq?=
 =?us-ascii?Q?x2PH807vjzcnrXwn7khCZlgFk2Nrg+GcX/UHNcqzTeOOltnf0iEHxeMULfXr?=
 =?us-ascii?Q?/mXBc5wcqeP4wWPAkVJGwh6pBaY93yR9j4cIa1uH1o+1FDpT3botRvWiF2lN?=
 =?us-ascii?Q?tjUU5OflV3HlO3ruJtDWs/hFOAj4w7jRxcblMd630N+fDXnQ27bYQdwg5dXH?=
 =?us-ascii?Q?/4yytjYq0CXAoEtSKDYDI/vOPHvHaE6Y/zaYUf3LWcAGj+aL8Pt0CDxV7i2f?=
 =?us-ascii?Q?PARZfMM3VIbdA62RZUtzQtpALthHfDsAg92CgK+eWYMwTnZHVUNWu0ccen8t?=
 =?us-ascii?Q?s9+mEoR/RwcPJxOWPuf26mlKYuwZL3Wy6pXjNPqT8pUjgfd/yY907wWUlJuE?=
 =?us-ascii?Q?ZEaIXGgx2d/ko2WGebvrcXVZwGjTtfpALAQSU23V/pgseGYdx+IgLc+mF3f3?=
 =?us-ascii?Q?6OLze3vx0g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224f4c99-e05d-4fec-1435-08da272be0ea
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 02:24:23.9204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TReVTkkGtRoVwJq0wL7OkvXF7hSaOr/81/9NeBpRhKGPb8ZH9bqMg23a67nCFgstRbo5aKxSA8j5aqfiBALBBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Changming Huang <jerry.huang@nxp.com>
---
changes in v5:
  - rename compatible name to mikcroe,mikcroe-socket
changes in v4:
  - rename example node, adjust description
changes in v3:
  - add the dt-bindings

 .../bindings/spi/mikcroe,mikcroe-socket.yaml  | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/mikcroe,mikcroe-socket.yaml

diff --git a/Documentation/devicetree/bindings/spi/mikcroe,mikcroe-socket.yaml b/Documentation/devicetree/bindings/spi/mikcroe,mikcroe-socket.yaml
new file mode 100644
index 000000000000..2b0abf7f1d84
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/mikcroe,mikcroe-socket.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/mikcroe,mikcroe-spi#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MikcroBus SPI device bindings
+
+maintainers:
+  - Changming Huang <jerry.huang@nxp.com>
+
+allOf:
+  - $ref: "spi-controller.yaml"
+
+properties:
+  compatible:
+    const: mikcroe,mikcroe-socket
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  fsl,spi-cs-sck-delay: true
+
+  fsl,spi-sck-cs-delay: true
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    &dspi2 {
+      bus-num = <2>;
+      status = "okay";
+
+      spi@0 {
+        compatible = "mikcroe,mikcroe-socket";
+        reg = <0>;
+        spi-max-frequency = <2000000>;
+        fsl,spi-cs-sck-delay = <1000000>;
+        fsl,spi-sck-cs-delay = <50>;
+      };
+    };
+
+...
-- 
2.25.1

