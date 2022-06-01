Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F19653A0FB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351342AbiFAJoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351276AbiFAJoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:44:21 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6A462BE8;
        Wed,  1 Jun 2022 02:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8OZXYlmIZ/rRmzXL1vf9oVRNVs3yGJ6e6Tl7FCaLgE+bs4SBMDXD8lKZ0CJIPXbbU7ufhQ1iHGqvQf1I4KkpyWRoWheGySJPsbY/Mp6pC85Y8jXN6xjxwfwGmfpGkAZSQlrN06ROVFcphwimOkld9CgogLz8dufQ0xfXPtiyAYW5n0hK9/fOwPCxL4UvvGLyShKQ3MduvRWXwy6UO9PmkkdOyS+HzfrOHnV9xDS1Fc86qCvbn8lipvKJSt77ovJ5BET0crHNbuvxVFMvcOWujFI7AiZpkGU54pWk6G0KJswHu94oCjxD7cju3UtWi/pHUkqe3pVzMUuktTubLQfeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/Iv8p9Y88cY1urx3A8Qys9vLvC0KnScZcSNIlZLpVA=;
 b=JyjknvFRLXS7Eb4476b5LntV/f9nCSJwQbhm/2sO1dzVcwG+C0AtAacGCH4cL43hkTrVubE72LedSdy7gvoQLd7NnSWKKX2SHDf8GQLsbltUayvYKKjiVDwozab9E/oucNWipQhoDSK0/IWQE6x8PnHjQJhTdRsh71LAJpYb5TFMDE0uqrVR8z/29irQ0th8GgExueD+zziptwxwa+jQeU40EP3RdaVb/K96mg7HaIkRj6zvtpGbAM3Gt9VvrxsKIJXJNOrOzckNfmJIrD9ij8VCm9FpWrq90WnbFZgnW/dULwCjSzOl8+UjIV7r0vpqUf09UhpC0jUhAcC11+84xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/Iv8p9Y88cY1urx3A8Qys9vLvC0KnScZcSNIlZLpVA=;
 b=SFrw46EREbwcXbnF42WUUu4HcIDKJzZyLDM7lQ6683EDznElXa8NyN6S228rffSdSul4FxvCv1ltgsONPIZEwUTxHh9Rqv86UAUvCisnai8Dm3U8VbmHVuce6Rez66YmMT77VtRo/bFODHHAxywgu87fSJEOOhQT/ZPvN/Eyrrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB3PR0402MB3897.eurprd04.prod.outlook.com (2603:10a6:8:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 09:44:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 09:44:12 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/8] dt-bindings: soc: imx: add interconnect property for i.MX8MP hsio blk ctrl
Date:   Wed,  1 Jun 2022 17:45:32 +0800
Message-Id: <20220601094537.3390127-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
References: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da6e7759-f40f-4edd-e07c-08da43b348ca
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3897:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3897406B1A08E49B2FDDF4E4C9DF9@DB3PR0402MB3897.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Ssd0vXm6Qyi4VjT8Xt6lwZJzEvgr92ueBRQymgaaMo3owikTFixCws0TiyY/B9kCwY457COEtcA7ykBPE/hnVAuN6fZxd4QRBpmcDKNxfMEyqjr8TgWxoHLqlF64PlatoFaTSqbXU6f9h3joxC3X5lS4QLjYB4wokWwhcGkeynNgQpnRQRk+u+Lt02q+NBKfwKBaVs1Hq60iovylXobCC41tkZRUstF7993RqkB4bfRiMpp/tzU1ndtyH9YfJrSwVFGvtttGx92v52IIzxopwsdSeMTxrQK/LnIZCXnx+tONja4D+MVnvyE7yEZaYpYRFezK2PMPNQjZYzs7YhDcsqIyX3PyRynLNU7FOLBwILqMIRK58AutswzqBK7PC0LJfVMY2+GV/4P44vzDdCml8eR9hU+INd3bl7ExRoeRU8tzpDk3LJ1qOs2Gjbe49H8ubSMlXkvlK0s0hJKDasRinDkdM6T/iEt79hF4eufL2PUyE2nicM3I7GFs3hD2sR1iTc13ccNSG4NZLFOFV3i3+ehxrnX0sjjr0vO+GEFljMUm7GrNr9dMVkSejSsZoU4uPeFBoivs6RxmauS+tvrd2fohaarlTU6OZfPW66MoW99O8qKrJRRl6AXj/gAD/HZ9Im4DD3ooVJp96sn4iQkNWYlar6+e9I0G9sAQiteYzBlA8M01ZMkOtpa66SmZ+UQ3BhFrGGdBaf99Cenhdj0jGsBVl7K/f+OcsYTe/AxVQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(66946007)(2616005)(86362001)(52116002)(6666004)(2906002)(508600001)(4744005)(38100700002)(7416002)(8936002)(316002)(8676002)(6512007)(186003)(66476007)(66556008)(26005)(4326008)(6506007)(921005)(6486002)(5660300002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gwbpAfbJ6HahiIcIBk+BCQhvYYTBKoVG9KXv+S+TSAbvoTBHxnJtZMNfSibY?=
 =?us-ascii?Q?rDetlcrh9xsnDiSqdm41sw1iWJiocvrpqi/p5SOAxz5h70QBkUq/E7SeOnFU?=
 =?us-ascii?Q?h+QHm1iTwBk52+NdsYzX7csIfGHWnfY+2u3pa/HLuGvHpG4q4fjmV8Hamvt/?=
 =?us-ascii?Q?GE4cGR7JLj/1tpthRPuuqHJ8tzVVrvQ0gaIEC9+Ut/GNrfsNlvtZL4EBGU71?=
 =?us-ascii?Q?dthfDcOGlR41iMTHpXoSq+/DHueOct3NPT+4P0wgOF80DBx2YxHwGUYSYm4c?=
 =?us-ascii?Q?1jNLOZpfm1Tn3+GxsXbEvKcw5ZYiH0hxq7IoCPS6bgDe6/wCWmg/6QFQiVt1?=
 =?us-ascii?Q?cDxa0kunb7WXTUpM+6BEfm7NNSvAhsqQd3j/etkt+iIM+a2ghxh7u7KTW/LR?=
 =?us-ascii?Q?/9lNE4bdbJgd153Jucw+kF74H5ejJG8R2GOa7A/4fxKbQToSnLS+NJNYAjPt?=
 =?us-ascii?Q?/L7MUd+O5zcGoewzlByu3hfnXcJQvtZDXpCwmoUSWxByrRIszy/HvkkcefZ/?=
 =?us-ascii?Q?jZNLv6Yy/PJbTBDlVp31NTOFDcoq2KkE7EIK4q6Q64MkauMa9qz62D9Dk+8F?=
 =?us-ascii?Q?x6hIGOu39lSMCZmpf/cHh9+o9EMcTDrpqK7+Ch4M5XCFST0eA9T9veJLf5hB?=
 =?us-ascii?Q?3rNhrmwUw8wgb98QObqrIApHKAPjd04ojPCNruAdJP4mk8as2WpPw7i78/Pq?=
 =?us-ascii?Q?7n4+xzb50yBktvcM8rGxcZ2LOVMIMC+KTpqFNlOugncq9Iv2eSq/A6wYAYZN?=
 =?us-ascii?Q?yYmkAHuqc6y1kj7tzIE4M6vvP4AhrlG/nTjeN+fPRPc9BU8PTj3k6QMk/uHa?=
 =?us-ascii?Q?wGYJKg7az4cccxfBNOS5gJhwubTN488rmrVd8CMex7GZ3mdT4TfG6qElZ0Wx?=
 =?us-ascii?Q?LBKNlYMxaBzTyTDcp1LdGcasqpB9+XNR3qmgLCkuwssuH3r7ByWWz6mWarAb?=
 =?us-ascii?Q?B+M1auGvCUppCQLiJ+AOd/qQ/8cLCKCMYHbksryVkCxp/kyToQX9fZal2cYv?=
 =?us-ascii?Q?IFKBy4tRUjAdC9kXmsG5MzaM2OD8UEjweSG5CSSQPH0yxD9IDh5xu688j6Ml?=
 =?us-ascii?Q?33pH2EjC0azfSs9rVwtUO5DLNc4GEV7TMExkurX1AdlWng1UpjJK39iRBQ2k?=
 =?us-ascii?Q?CREq+pj8vy/muiafhcNCgT6lFC5RO2WxQR06qXLZiXrQexILFu5fSwgW5Q6R?=
 =?us-ascii?Q?0iRzxRwVlx7fV97ixCyBCRv1Q2fvqfRFOXfgjLWmf5Df9++wATcBCSURLi8t?=
 =?us-ascii?Q?9SscYr/FIjWO9Ud9oG6lqZ3y6Cwd+jMi/w+laYtM3voN7hJI9J6SoepTpqeq?=
 =?us-ascii?Q?sTU7Kh93RbpTDW36ZQDfRWiPN40dsQf18gTBKRWKLcGMtc2lub03Rbh79bww?=
 =?us-ascii?Q?h7wlwvWskOzJY6bnO6uZ7MU6XA8pMwWNDqTjC1+LIbftM9quOSQ7FYDTT9dD?=
 =?us-ascii?Q?RNjBPbJsZdF68b1hSTMQhiXUhpkFui5lwnOZjTpjjgrFEEq5uj8hHJmFaIw1?=
 =?us-ascii?Q?ccMWVqcApdAJfSNY7Rax6Allz7OepqpvU6dp0MBcqxtaBBommDvRP7xCOwFP?=
 =?us-ascii?Q?THMviHM+KmpaSP67tGALaA/2IT2KcS7hKkAYW9kWnxTWSUkyt+1Xh/n2AkXD?=
 =?us-ascii?Q?IIoJQaVHMciUriWpJRset5nbeE/7PN/DBF8DzPA38JriipFlT80I9F+i73zi?=
 =?us-ascii?Q?UPWzdU1F0Yx3j+vVwRba2O/EwBHW05b8w0x0UV1RkgoIXdQk/9BN6XuUDPcg?=
 =?us-ascii?Q?Db6yaps95w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6e7759-f40f-4edd-e07c-08da43b348ca
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 09:44:12.8933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxHtbyTuUExmsNE5Te02mjuBmHywROdulBaI6GxSP160tOGfOzqz/N0MADUW8jI9nkSMLcnE+//z3WJBu74rug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3897
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add interconnect property for i.MX8MP hsio blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml
index c1e29d94f40e..a776dd386ae3 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml
@@ -48,6 +48,16 @@ properties:
       - const: usb
       - const: pcie
 
+  interconnects:
+    maxItems: 4
+
+  interconnect-names:
+    items:
+      - const: noc-pcie
+      - const: usb1
+      - const: usb2
+      - const: pcie
+
 required:
   - compatible
   - reg
-- 
2.25.1

