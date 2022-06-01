Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EED53A0F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351293AbiFAJoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351258AbiFAJoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:44:04 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374D75D644;
        Wed,  1 Jun 2022 02:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePpmYCL/qqk8NQHc0BUm2jJD3KCwYEfBMG/8Pi+t9mnvmoRasqC7FbRq5MCLqYT0RpjddMVnQO57z+52GDzsmay+23gjqoe68YMQkvnIXiQJRbvDjDNAGZGsNh/TlRcYioSzlemDKs9yR1YjiHjMLT7iKDOZIYybnQrOme1VNRueuAULad/Qf66D0HLvIorhKX5sSp26DrUFf9T4/7rQr3G3xDeQWJVOhW5GGRLZ9Mg5xm/38i3KCNgPMWMvIkwIelqVk2TLdBizyJCwfcj5NTU6KWTnH7ebdVbnF/SekSiX0XCQNJJRnNMof4mtrKfJ8g7/XuEUhY7JDU00BLoTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3GtQEdqSC7fqVLi8+8T3VB7jQ44T5LvbhD8ODbmjeY=;
 b=dPeta4sQc8O/BtkhwQlugtXwyJON/FA/XIOKIlvjJgehO7s6o3oLKwzmpA+bqj2i+YCjLVjQ0fN5UZzCVBxl1HAhprjCKYVBAQbiRqPHF3aaghEQjeUDyazZLkFvQtQsEiE4AD8zJPNZd/aSiCyFTQhZE4pDgGbrVt3NBV8P2lDD7jORFWDc2TO7VhXo9LJ39aljh4V4rtus14DpdEHlwQrVAqROhxjL09GS8lowCPcgXrNkIjH4jiG/rATBv/oFTVvvduQYXuutN910y59c8F6Z4T1XpDbY3b3rplh4p/PP3k3EHuEFl1Q3A0lHd7J9yTdB9yBUSgBESYtzb1GQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3GtQEdqSC7fqVLi8+8T3VB7jQ44T5LvbhD8ODbmjeY=;
 b=QSfheY1Zc3YSh7c7Y0cIF1NnI6ICUT9S9xLhHkXWCON/yxEg4Wyjwhxo5IXhZQ+tbGAieT4Pml/hMcfxrY0+VMYkk3unEncAznoyYrFfMaGVhbOTgoWSkwwceNRCKv08EuhqlV2W9IyvW8ZetjLgoSUnNpdM/uvJox+8nYukWiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9507.eurprd04.prod.outlook.com (2603:10a6:20b:4ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 09:44:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 09:44:00 +0000
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
Subject: [PATCH 1/8] dt-bindings: soc: imx: add interconnect property for i.MX8MP media blk ctrl
Date:   Wed,  1 Jun 2022 17:45:30 +0800
Message-Id: <20220601094537.3390127-2-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c39cdfdc-a6dd-4593-0147-08da43b34116
X-MS-TrafficTypeDiagnostic: AS4PR04MB9507:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AS4PR04MB9507E8F2BDDAA4AB1C0852A2C9DF9@AS4PR04MB9507.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r9zn/imkQdXEqsWrM3E5IP0URLH9B63db8zp7R9/DXbIKYv8NN915cIrRthRtCs56K8OdDRREHoI+Yr1jppVcuTA5qsY9LrLD2fknShv19nH+jCYBYUslOH7RcVrY0uvyWvW7dCH7z53+M4SS1wTzdk2/kZCKNVbeZ2Wyw4barmaLyPe2sExK7yg/YD1swxLtpM709DhlnQQhGGTDyAULc++DRZnYOdYYI7GnfiAzdvLifWckyqXCaexc9l34CfVi0QPQiPHX1xRhuihhFreRVbuIo4xNkRvShd61NttaNNxb+RvV1rL9VVzqKuL0ismdn+zisuGXr0FaI6ATPXZ2DMZxR/7WNnq/AiGHkcEHfR9RVO3X9wg5X+IVH+IDuwTcxWkvFpAnY+7IxbSJ7KbMW9/aXrgLvEYlCUAfXIXCoROik32l/KEVhdsbyh0dWcWEGuoEPWoelD5G4LhhrykuJ86Fh8F/rpKzoDGyI/2Zd9HhGSToKNzYzW6a6ZFKTF8dLRl62VaD5tDgkQShUqZ0AyB2YO2i1LqJwa92dADYJo9RxUyGGBmSPQcYzKZFAsWcdWBFfPG7onI6mY762gBoSZ8736lAIv7BPJPud2G/41R+gOunpBNJdAu4GsT2235s95ESkBFJhw1hg8dEp2cuhCx2IVEyetLsChO0SjOiSzEj7VOktue7Wb1SC+XiNcsnEa+HI5OuEVEpEnrbHtAXQ9WAn1aZaEtftyVwrXLXH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(508600001)(921005)(6512007)(4744005)(6486002)(86362001)(5660300002)(52116002)(38350700002)(38100700002)(7416002)(6666004)(4326008)(66476007)(8676002)(66946007)(66556008)(26005)(6506007)(316002)(186003)(1076003)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4hAXqoy4BTWsMlXKkaaGj82McPbkP8Fkk41EwHeUcUlqFd2J80goICp6dunp?=
 =?us-ascii?Q?9buex/8IeBmwkRPxvBvHv9AjAXgsOqePV92dG0k7+uykS/wIXz9qaxjH/Vmd?=
 =?us-ascii?Q?5DRlw9+8UlsJs3C7yfY+xsxLEj0lp91s4n2nzDYnOjTLoOmIZWt2CqcDiMWy?=
 =?us-ascii?Q?79kvkGmgECyLdnu+7oBSh1DsTnljv4CnMWzShE40/W/HzaykoMdSXw+ztPMW?=
 =?us-ascii?Q?OBOnkZonA6T/ZYfp861nAyJ5IKK8lV5LiY1jwIRfz5hFtsSm70ji0U8HfvoR?=
 =?us-ascii?Q?RVr/JdX0dj7BnQGtz6sbiIbTMFqM0VgZ2ypV+PamYzcGKrJ952ldh02UmJOj?=
 =?us-ascii?Q?TYcPI670YonGioJQQlkG+hK20EJdRVr4d8aMSZo0o7zIJ/qrwO5Bd41BREiY?=
 =?us-ascii?Q?AwHZsyvAbh59szLpd5zVXTQNdr9YjMRP1eO5n0zZhVBKuVvfKg/82hBkmalv?=
 =?us-ascii?Q?jwb9QNIGmQAIn2JFNfPLotz2npvswI+MV/h2+GEygOJMNJfJ3nIBoTkBlJuK?=
 =?us-ascii?Q?SgT92cvpf+T9TnVR4vLyVAdbdkG8mfKJPifFYtaS2+lI59f9DjdX1TFiT/4I?=
 =?us-ascii?Q?nzsTPt9K6A3eKqa20lAwiSE+7/1wLTqIp1fn50X51+Tv9mU3wMe7rc4gtO1I?=
 =?us-ascii?Q?RPLX0i+GPMby2AIXXlEE+YFWmzU4T+OP6zq7aK7yl29ppiO+Wk18tv/MVUE6?=
 =?us-ascii?Q?MndF7LvXzNhjVkVDdR2H2UrUVJ+ueRfvqVCR01uJLSjqN0bf3rO2+WVqqhBk?=
 =?us-ascii?Q?s6aF1pQ/kw4nugrno5FF5kow7+2ae/B2S2agpAEa43AYCuthdNAvPXdBWVev?=
 =?us-ascii?Q?PpxEjEL8gWSu6mGln8x1oqcmlykkQJRAggqhr6IzcdYnOszYRKsktse6Z/g3?=
 =?us-ascii?Q?UnpoWS0aNSI10s04wp3jV5TDFL+JLz+hktxiOXrq3VTOUmkBLlKv3kzoj5dt?=
 =?us-ascii?Q?TFLInpcvHu86GNDIpWZk9jaQPzis8drK4nCPEHiH6o5/h7Tw7uJiTUlfcO3V?=
 =?us-ascii?Q?3tevNA1pwhFKnhDtJ9hky9Hgz+81kI1cMESQurzEdqHoq9Ok7wbYiQcnXAL/?=
 =?us-ascii?Q?WELj4A+WbxbXllDE464BaXpf+36f/zVMo5e/BFmIKnrsmqx5TZnMrqZgD8Jw?=
 =?us-ascii?Q?gUxPB4UdYQl0Q6hyyeCfYDq5iOT7rcG9GWPY2Rfjb3qwrR432qZoEnEsYVIy?=
 =?us-ascii?Q?VajHodU0oeUeOTVr4c1oWhlfRzw7r2MLktewqA10r8Gcw7JkBezibBNPrXzT?=
 =?us-ascii?Q?Lkn7alN+3vK/ZOpCjSWW0mJoHC10rsZOgyiDpMN68udyYpy02YUkfrlE2gnG?=
 =?us-ascii?Q?HEZ9UwJjgTlrYIWt748eQecX8BRJkyRhGRbk5B6sYL/40I4r3We+RKEEaa11?=
 =?us-ascii?Q?+FJBov4Qvq2SbH/JNkgA8zoND9TS3rIOVCZkOeXCxWo+yepayNxPeNowVIpC?=
 =?us-ascii?Q?DsROVa32KrjTh763+dUcmz4h0Enmfb32XmzcKjLx6DgOdC+wo6LJwCRM5m2B?=
 =?us-ascii?Q?Rdjo5wTwLtM5cfDo/43vuRzvkqDtpXBupabBo7eSlL8t0YC7UCSfDHgcF4ZH?=
 =?us-ascii?Q?DZCZS7pEtffGa6C+LM66teqZzj7AvK3NqR1zlVb6g1LBDjbNWnVx2hDnPX8/?=
 =?us-ascii?Q?C12HVkpdCXSq3Hxvta1PqAcxGXX7Macw1Bp5DAoXfSYpC7TF9dMazoMEeHrq?=
 =?us-ascii?Q?NrC8fkfO5BGyBk24Zn3kBbKH4zucjxHI9FGAbwk2QXt3x4bRjLNyyRg603+z?=
 =?us-ascii?Q?IeD7iheCqQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39cdfdc-a6dd-4593-0147-08da43b34116
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 09:44:00.2451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obKWqi2uR101FZ/oLfB7ZpHCRkuIouS45/aZwBHRFel+Q3npPxLm2LvQFJasega6U0Hp1TwExsLJZxJXrfHNKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9507
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add interconnect property for i.MX8MP mediamix blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../soc/imx/fsl,imx8mp-media-blk-ctrl.yaml         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.yaml
index 21d3ee486295..706bef39b87e 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.yaml
@@ -64,6 +64,20 @@ properties:
       - const: isp
       - const: phy
 
+  interconnects:
+    maxItems: 8
+
+  interconnect-names:
+    items:
+      - const: lcdif-rd
+      - const: lcdif-wr
+      - const: isi0
+      - const: isi1
+      - const: isi2
+      - const: isp0
+      - const: isp1
+      - const: dwe
+
 required:
   - compatible
   - reg
-- 
2.25.1

