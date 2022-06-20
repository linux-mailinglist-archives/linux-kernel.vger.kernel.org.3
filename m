Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAB0551912
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242731AbiFTMhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242579AbiFTMhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:37:36 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0125115A1E;
        Mon, 20 Jun 2022 05:37:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ym3ctNRXB+drBJH/ADX63zdYREjwCCn2N+hNUmPJ16A6pgl8Ptp6XS30yDIpj2Xw/sibxJ0z76SlvH68fmy3/ye+XdScBOf7ZuRwHpYxPkZiUixB2oVBOxTmcTeZIbQlK8amVtsEyER6NyXrKlOmcRqf2JN3WABjvUC/frA0ljRucDUUD16KfTQ4cdb8N76rY4IM4mUAX9Ny+iCX/opfp6HP8xsz59rdhfTP2eTBZh4Em2oGObxd95hUuUnUqYK50H+T2G7jr9SCld2d5qOP77w57sBSxRx7QiV2WR9GYR3LQzn2O8m+VihpeGyNcP0z0pj8YCxEYekvvy2KSkGDzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TR+12cvuFynEIiTRe/V/YLeiVgbSjZTlvYnsT3rLGsA=;
 b=Kx98VhyaquQfNpFcAZFBGCIgAhypD8anGcswkxVj6T+GWoXWNGUgcQ7Yg7pu2vbB/Kbjr53FfbaG+t95qBJOJvfmpEl10A3VnCPYBJtqMOEoiHlszmOtFU9ifPqU4HnNSQBlDPEu500/e+b4LcoxfH3AggZTjITRarDtVCYDamvwmWVbRuv9MJqAGU1SpCc+fXqnu4KV46X78l1HuKfFaYExM/SCRI2uzwgR1Ej1yfuCMCSP1FW35YnAYlx8Hefmlyy2ZSUaQ8qRacLvrGLRS8gpZouHESOcVljojHp4SkyK1QmzZW10d0z75SHtwAAUawfI4Ld93aodYrFLiQogCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TR+12cvuFynEIiTRe/V/YLeiVgbSjZTlvYnsT3rLGsA=;
 b=swZq5BbI5LArGtIWzyM6UX7KpLdYEX6Grofz2oJrhXIbQFy87/e40Dag9rGmUKd8xc4n1cLQydBL9W4bTUlxllDbqt3pYP7fEu/3+nttbrzSWGNlVNi9GmTYGV4l77mrST97S0ka1NZkgNjs3R3YcIryhxx/F7FUFEAyDnx4i+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM8PR04MB7873.eurprd04.prod.outlook.com (2603:10a6:20b:247::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Mon, 20 Jun
 2022 12:37:33 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%6]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 12:37:32 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, krzysztof.kozlowski@linaro.org
Subject: [PATCH v3 2/3] dt-bindings: phy: Add Freescale i.MX8qm Mixel LVDS PHY binding
Date:   Mon, 20 Jun 2022 20:38:53 +0800
Message-Id: <20220620123854.1138028-3-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620123854.1138028-1-victor.liu@nxp.com>
References: <20220620123854.1138028-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0219.apcprd06.prod.outlook.com
 (2603:1096:4:68::27) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5c744b8-3797-4047-1dda-08da52b9a59f
X-MS-TrafficTypeDiagnostic: AM8PR04MB7873:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB7873AE89D252C98089D968DE98B09@AM8PR04MB7873.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpAhcnaG7BNwIPswYa67fpPOzT9gKGu6q66ojvC371RXjJFrS/Qh+lnGgfxIoPlkOYxfZM9b5JTG5vl6mBLSg6NUhXoRTaxWkJqZW5jKbpMxgmirKo2tsO4KZEXY3k9qV7O9zz/CnRgv5x2gOSIPRyczbi1XGf401Jd+mk3HuPQWYBJeDWbCWcWPJ0FKZkLAaWTKeS4SEbOcViQDfsyUzzLi4BWHSs/Mh5lfyC3H23eStHPBwacSm3B5udgHc5HvYMhhTg7ljXoDEDKrpZwYHrJJNMLCujGgUKU7joCFAe9eTcUiTvystTzoIvFl6Nft9QjJY9Vx29ksmsKFIZxrt4zLXm+VDyKOsYJQDbTz8Hz2zkSSNjJgAX6ECyGuQeHh1f+cWWqlKA5CK+DJPJAmvEt6RWq0W5YVjpOasFsvY2naPlKsoTJAulOsH3FHUHEL7kagxXG0TWHHgvymjVYpBi28jA/WjlesT2OvnWnAej03EnLJf24GQp1MiaksJ2ejbgx+mt90QfRj7LzQ0rW9i40x3Xfe652NMMnNTrqRhmtqWfx9XV8MmrLrup7OaRCOpbDfCPcAoe6PRgd6+hoYPV57ei+IGwJ9u+yZ7PexsJETUmNgtDIYqakpG7YvrUnUSpoNa/DCodGTXn74DSj4L95HRitQqPMUOz4JoGuL7bY0dRu8aCvFTnj8tePfeWWnkZNao6o2JW79vKdqkjTvu0sTH0uTv8Jg98dnoSpwwaxG2e2QEjXpItn61yhneHOPo7MWaE6xmYRj0h1khU//K3OKZ/6ZaEzUkXB/Z2qx26wCnYlTZtR3XL3KBromFp0G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(66556008)(66946007)(36756003)(8676002)(4326008)(66476007)(6486002)(83380400001)(316002)(186003)(966005)(1076003)(478600001)(8936002)(2616005)(5660300002)(41300700001)(38100700002)(7416002)(6512007)(26005)(38350700002)(52116002)(6666004)(6506007)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AI9mAcfWTAVCuug7EXcVt6luEVo5rzgPczVL8m5O7Rm51lEwmS+y6VliC/If?=
 =?us-ascii?Q?77ig2oIjlYLdbSy6ZuxNlNDmj49lTxCYeXUL6btW9g0BdS808z9vA98qNqp9?=
 =?us-ascii?Q?p8DT62ctc61nshwoOzO153tfwZFXbX1m6fKB2jh7dZQYUCFYfNqrfYlqZp2h?=
 =?us-ascii?Q?wuA6LsuMOLY6gx77IbxLmjCXF6Uq63jXbqI4ieN4VpvIyClUEwVeD92AFQR/?=
 =?us-ascii?Q?qJ/rnDkG+IJHH7lUm+nWa+1VVstG8MoVS6edaZwuRTjGSlUXu6i2RdWtu9Qm?=
 =?us-ascii?Q?QYDI7AbW3s+tkQA8KM9ODWaHVMH91I+64UKc4FXwS48d5Z8VH+w3Q5ZpheYJ?=
 =?us-ascii?Q?fzJWE4dEeOKbyxC2koJMq8FSGIW5WpBB4GihlGntVXcDZlPvvJt7c6dEH7MM?=
 =?us-ascii?Q?Mk+QXvOtM7JorKGX4JZztOVHNwE+8ZbeeEQxUI98lKZnpRprTJaGEsbZ1sKW?=
 =?us-ascii?Q?43ejpHFawHRYiMx9CGypExZHn2K9V74evstPFdvY/9SJNfUDsa7nzx9LN8bS?=
 =?us-ascii?Q?jWUG1nRiXZ9xdHx77Np2fwqJmpoZzOecBP4C2zlIx8P2WvoslOcZHsxo8jv4?=
 =?us-ascii?Q?fC21h1CqfgiAMuwhO2INXg9jSxUuQ7ZAnPV2adUr1JUU2o4WTBQDjeXhCpmY?=
 =?us-ascii?Q?Mj5A0bkIGP+TWYbsN5e0fl4kQPy1lBTFzZ8SQJ0jE4ZzyxCucsYA2eMoN9kQ?=
 =?us-ascii?Q?WHLl9L3pcli2QY6m5Tj8GslZQwr6B/GH2S92h8vn6W32eJfMufOs7Pwc6/zw?=
 =?us-ascii?Q?JQD0HMupsEAuCYj+Rtdr58rClawHlzFbR2wMNhn1mbYQTtw54h1G3On34Ohl?=
 =?us-ascii?Q?W8L5mtSEXshJGESwSxKRvcY02L/onH+/bK6sEFEqnBIsq+xxj2O9CwVBXMVQ?=
 =?us-ascii?Q?FMgjmcHvenbyApgfvFWk9Cdn5dFasN1ixpR2e7pUVdCbNGf3+FK80LhfrADA?=
 =?us-ascii?Q?hO3FPLqDgvonjwETOa38PLDzYslwX6mIyI/yD/ZTXZqFSw6NBBMzwSHowGU4?=
 =?us-ascii?Q?RXBVTm3XBJZ48DaepS/ip97pxJA3awGWB7JxiVo58jKa9Vvp3pft58seeW1h?=
 =?us-ascii?Q?pHohKsQAEEX9W06BBNkBPgc8eHFIcHwJTPgCYkjFZVsYtQ57IM6nN4e8ys6J?=
 =?us-ascii?Q?l23mn5rm0EVYifVBKRipkinT0+dS/Lp2kxataKn85QnRHjwFNUzuNwogcZpX?=
 =?us-ascii?Q?GRR87rPjZHUVDW0CpWS0U0N5q0/90gxSNpvcnZdsoPW/lx9qWMEYtI1YS0Ts?=
 =?us-ascii?Q?bTsSdutKC3VWYPWmdOU5zBrRUzBQfZ2kOn7X5oKfYDN7vo5SMoVe8vEoAEjc?=
 =?us-ascii?Q?VLTdiH1b/TH4KHv7pWIIBHaYLjn9k9oDWLwK1VFYdfs0TFVApFW09ZLxqtpv?=
 =?us-ascii?Q?yOIRNIK+TjxUAlyhTEbe/2cnGRmEox3VmF0SrrbRsDuBtpB0hVgfBPF9sorr?=
 =?us-ascii?Q?ncsF9lVTvGXTc+ts58tw7g2KPvDRiRWIsamsrdB5yq92EX+Fa2pXrioPFZcN?=
 =?us-ascii?Q?ssEd+oj316bBwevi5OkTinUXBLFe11IOFZve2vAQblrmRFJ+ky3cRLvsOeob?=
 =?us-ascii?Q?13Q/bqynW120jLxs80Sl3yRcS1CAfzO6F58E2TsdDDck2dqUhiCkV6KaFdmQ?=
 =?us-ascii?Q?35pSURDQk8EiZixV0c9ELMYaOqXkSwjL76xdqAAHVEhq3L3/fbU0ZNuoXxcC?=
 =?us-ascii?Q?bXFwtpMyrpN5wGNq6UhPWFd6OuVmZmtsVScRDHkEe8cB+c9h8f4AmgzdWF1g?=
 =?us-ascii?Q?2p8TOYFt6A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c744b8-3797-4047-1dda-08da52b9a59f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 12:37:32.9004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwyaM3YuBYoksd0cdmnbQy1ld+P/yh+NMc7bTQ29HrpWtR7z15Xu5O8NbUpH78jSYVZvPIHTV92rIW9FkJy0Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7873
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Mixel LVDS PHY found on Freescale i.MX8qm SoC.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v2->v3:
* Change compatible string from 'mixel,lvds-phy' to
  'mixel,28fdsoi-lvds-1250-8ch-tx-pll' in patch 1/3. (Krzysztof)
* Rename dt-binding file to 'fsl,imx8qm-lvds-phy.yaml'. (Krzysztof)

v1->v2:
* Set fsl,imx8qm-lvds-phy' and 'mixel,lvds-phy' as compatible's enum. (Krzysztof)
* Skip 'clock-names' property. (Krzysztof)
* Drop 'This patch' from commit message. (Krzysztof)

 .../bindings/phy/fsl,imx8qm-lvds-phy.yaml     | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8qm-lvds-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8qm-lvds-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8qm-lvds-phy.yaml
new file mode 100644
index 000000000000..8767e48c71a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8qm-lvds-phy.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/fsl,imx8qm-lvds-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mixel LVDS PHY for Freescale i.MX8qm SoC
+
+maintainers:
+  - Liu Ying <victor.liu@nxp.com>
+
+description: |
+  The Mixel LVDS PHY IP block is found on Freescale i.MX8qm SoC.
+  It converts two groups of four 7/10 bits of CMOS data into two
+  groups of four data lanes of LVDS data streams. A phase-locked
+  transmit clock is transmitted in parallel with each group of
+  data streams over a fifth LVDS link. Every cycle of the transmit
+  clock, 56/80 bits of input data are sampled and transmitted
+  through the two groups of LVDS data streams. Together with the
+  transmit clocks, the two groups of LVDS data streams form two
+  LVDS channels.
+
+  The Mixel LVDS PHY found on Freescale i.MX8qm SoC is controlled
+  by Control and Status Registers(CSR) module in the SoC. The CSR
+  module, as a system controller, contains the PHY's registers.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qm-lvds-phy
+      - mixel,28fdsoi-lvds-1250-8ch-tx-pll
+
+  "#phy-cells":
+    const: 1
+    description: |
+      Cell allows setting the LVDS channel index of the PHY.
+      Index 0 is for LVDS channel0 and index 1 is for LVDS channel1.
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#phy-cells"
+  - clocks
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    phy {
+        compatible = "fsl,imx8qm-lvds-phy";
+        #phy-cells = <1>;
+        clocks = <&clk IMX_SC_R_LVDS_0 IMX_SC_PM_CLK_PHY>;
+        power-domains = <&pd IMX_SC_R_LVDS_0>;
+    };
-- 
2.25.1

