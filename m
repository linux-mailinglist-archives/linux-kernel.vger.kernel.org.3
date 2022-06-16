Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545A154DBEA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359568AbiFPHiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiFPHiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:38:16 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30086.outbound.protection.outlook.com [40.107.3.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109EB50B1F;
        Thu, 16 Jun 2022 00:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4+5H9Exu352aLpVpmO3vCZOWeA/yMhAh5uSU1wBTNampgr+FwF1gUw7ogJ+xcQlzZUs5VNAwZq/DL7yfCbU+MP3Jp27dlirjRLAbQCDsJ+pIp7T4PmrI37ZYjyzKoBnEARSHOXfu1yzKX25GCUUQ3VvMq3zw2+tXas4/cDpqXEVcJbDVMikmGxNKw/gZx8NQR5fAQw7pxzYUgYRLkqgZzWtQ3LcWVIv7t0WtYoj1jravoCsCZnZSz5wr0tfE3GZ5pja/uXOSTXjKqa8pE1/jMPssclMCVG6q501eFUct/1UHQoL94ChKwBNevhhEKLNWtnqJ2R0BzfJvT+SvLCrhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiA+8OnmQ7YBctwKVNxjpamwVG7ltfYqmjcEzCuMMxA=;
 b=HIoUvNHyBZhjisPl7QSqTY5MzyJYC7pKIUq2HOZSBFttBiNCTtoMF1CRRpaTS7sCFrEpG7aSwOT7Gb6HPiLP++nrt4y8zwYtrOxkyH1BMC8GpgXYVQ8A2CdktGtlG8Y8qHGMOPNDhWnF3uRtecGoo7Kq5jbXCBs59xCeAbBn/C7mkYhMC4WHs/lQNsoVZYPVN6LsQvTZH0HPelz1gbVM5dUUfkcOhgQ/vMZ1e69jUAi/GZPwiJFNVkO/IN/16agDcCpSjOTiRFNcHMYYZvD+NfV+AyM0Gi2xZJOTgpaeD/lKSKvEw0ChbKrRTpL0ALDYiDpPaHJ+S486/J7liWKcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiA+8OnmQ7YBctwKVNxjpamwVG7ltfYqmjcEzCuMMxA=;
 b=UFTarEYny58SkbxBHtl05me2LJR/ZPpkgNWwwFhW0k6HlVDTNDeAdWZ7oW1EgbY5gEDl89/DnmBy+0mfFejqkmVNZizSUTfPe1GTqILD2Gy8Mm0eDwkefa3bQqLm+fqJ7GpO/BjeBaj7tq7sR0Na+p3hWtojkvboJbnatm7Ppdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Thu, 16 Jun
 2022 07:38:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 07:38:12 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, paul.elder@ideasonboard.com,
        marex@denx.de, aford173@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V2 1/8] dt-bindings: soc: imx: add interconnect property for i.MX8MP media blk ctrl
Date:   Thu, 16 Jun 2022 15:39:46 +0800
Message-Id: <20220616073953.2204978-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616073953.2204978-1-peng.fan@oss.nxp.com>
References: <20220616073953.2204978-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be632429-01ec-4252-1f3f-08da4f6b2a66
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4293B948ED3BAEA05E485A5BC9AC9@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p00lYN4+q/Ql9YQb+CN6ZZC7mj5jdt72plFxwMJHVVMXOtp1s8AcUdDWeBOt/TGVf9thMc2z23x2CwCz/ZebQrQyNUspGfR1h3la2T5uoP2ksl9jOaglLaTZPZ8iKL2R39mTDxGZv22+xvLL4/oJFOR3JtSem9iimEn9yA1xfUzNBz9Iq3qet/K5dvlPsdnAFUcSI03zSeTdpXaKTyHpTN/aPK/HTYUnReoTyW5jPPINtd3/lSoK1l+e0QP5/RLDOauCcSzwyHif3nTWNcdXNoAVSoGekwG2ckwESo0SaVXSqBQZumv0LZjSnC5K06Chs51xM4hGMIx+nrlNiu0bXRvVSFoAOIFTpW1sTwmwXYq3rGudOK+kjJL0Fx83UATdAw5E6OdyrSPih8GcRtxWaccykJeXZax1ibw4HlV+7JI3XagZlC+KaCW4KJbNlEFbOhBkVbAXT0O2wovRWn0rpPPgYAmOiNtUdXHNquRBRGMkDKI789w7dF9NNGk/8ZORP2eKiD/xjUnxCcfpzG2tKghNbfrawl0vxn154oyW/xIWq7XP3W21iwkcG6CBR9E+ofyLlCEJiJ5CKKTiXZyP/uale+oHiRQ+MhTIKG2ZppthzsJbkeRFtPSUXOkVzMvMoxZBi0VLrUKTaFQLr4kVgG9RkWF6hQS9YJBkWVfz0p3waJ5YlibVygaMWW1oyuVFXhge/28KXql5mNHwjiOY7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(6512007)(4326008)(2616005)(5660300002)(66946007)(8676002)(2906002)(7416002)(86362001)(6506007)(66556008)(508600001)(6486002)(8936002)(66476007)(52116002)(26005)(4744005)(316002)(6666004)(54906003)(38350700002)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Iyq9q64IeZti8wyHq3PjpKi0QISKi2YZTwRjVoRrJ/pFdr+vqTpstpQaD86?=
 =?us-ascii?Q?+h/GxKQBIHeOlgvHAFDC3DZrEoOd/ZS+MTl3OuSPUN2W0qj5cXTK74+SpsQe?=
 =?us-ascii?Q?00+XVK50anJiS48x29H2AKegiEUoRsfj4vLWokAad3zigg5LY5mNpHd2NN5y?=
 =?us-ascii?Q?WemV3h+H8cshP828IRsmI1WnriiPUkjG6j0uyqc1gUmWZ9bql6sAIuUcHilT?=
 =?us-ascii?Q?Klg/wQvxZTlkvzW90sC5/dX+qVnkkONaz+eHzcK6YaPSRgLJs1GuOHQ5V/1L?=
 =?us-ascii?Q?uuE8G+YlKnmQloWKhOOabw680IQZAtS4TdbCFtUbdjExBgozjuTEpAOYaO0n?=
 =?us-ascii?Q?pAcOEN5Hx0a7sJi78BtIelEh84EEsUZoZ26fCw2/Zepy8hY8ILJBXuUw/lvL?=
 =?us-ascii?Q?xMTZCjkS48DDlf/b2NmaGOqO5wNRbwQ0+GMN6OoD8s9c8dp18ipiDl/UsYEq?=
 =?us-ascii?Q?0FI8b+Sx7cb2YtR7YzTSmDfDbr/MLQjyXxAAKPFL7U65U/I3IR+fl+p9NOLK?=
 =?us-ascii?Q?l5cpoWKKiLm2hYzV2YFfrRwOTyjZMMqVgeG8N462TsmmrFf/ZcrN/LoqhzwU?=
 =?us-ascii?Q?OiNR3zT9LOEHF6u1EtpVXW+RTjny2AxwedsLbfUvW31yeV7QCGoTNgAVPmfw?=
 =?us-ascii?Q?GEUjf0JQFcZ6+jzGm0w5l86YsAT0V/Gq2VKFE5m5MFOYxwM8St1l08OF4dQ4?=
 =?us-ascii?Q?s8wzIrvdR2TAdmNwz2znPqXrUzSvaTxXICwriX1wQUR+5qqqOyxOQUydftH7?=
 =?us-ascii?Q?tSyt2g/DXm07LntmvPpsVZMbg2oomlSHsvuAq6dSLphgLepQItFVgQ3thN4M?=
 =?us-ascii?Q?S6kbigfRxsS06DlKV/AXdfu5REixkdkPYUHKxqy6elKsYpFM/y/JFU7FfiYX?=
 =?us-ascii?Q?ploPSG17Ffx09U8IsQOgW6wtx1wkSFbxyFg+AvgLXLtofRP9hzzvz3MJ0N71?=
 =?us-ascii?Q?cCQ0aLEvywI+GNv8BIYflq+kqij8/jg5y7mWPkmHGDOmWfCtFFd9ViRIcYZP?=
 =?us-ascii?Q?/tM/neN0BpWm0U4aSFeolQgWUp3rULmQIxe+d07i/WraFHd8J6N1vM6vjYT4?=
 =?us-ascii?Q?utd/EJ8t+M8JqDx3PdmHY+9UJvUaKDvdconQlbNO5BZVHEMhGe+oNVP/XFnA?=
 =?us-ascii?Q?E1k30jY2q6kT+LrKlXNuejr0H/Wn4d4kJF47+ua5vyxz1/jh/uIXn2UArcfV?=
 =?us-ascii?Q?YuzaP2v7pa5CbzOO1kRwdpGyhJ3D5VBXjg+YTb1/bLN6Wb2WydFMVU3Kz+aq?=
 =?us-ascii?Q?8M30zdJUYe3zqZxjBoru0XEUPzokLGDwJbt6dpKMbh+vmm1GxbwcO6QPSLA2?=
 =?us-ascii?Q?1T3XkIdAO2iDS68amlot/jjsekIoo1eD1IK6rE9P3FyAIpDPrrBF1/WRyqqI?=
 =?us-ascii?Q?2IurbjqhS+TCLVsDagr7+szZAgI2Z1An+10/9kkRBS372RDf31nwWZKaG/ZK?=
 =?us-ascii?Q?ikUEcL09enBmdtBB1TJx/DHqvfh/eM221h1eFdQdGsECGrT21P4TjKrvKuOr?=
 =?us-ascii?Q?7VpnaLLUUz/x6nErRpwbD6KCn3ALAvyy0hXz//2r577RdeAj2dfgu0/jdPt5?=
 =?us-ascii?Q?zWQqTUKjyuL5DGFReKPYCjq1i1odjr4+t1Fo0U8xfYaKGHvGYZA/P3L3Xx0q?=
 =?us-ascii?Q?NyJgBRbFbs8kH8R1T5NIgIjEG6vGyJ5aDoW4cokLwtMJlAQuHbtR8NKFEwFX?=
 =?us-ascii?Q?QGp2S3CZ5jFsfVErLu/bbCRGxaXGYYF4VD8bBTXSN4a0LbWZzIzn8iKx7Y4n?=
 =?us-ascii?Q?vA1pMhqA6A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be632429-01ec-4252-1f3f-08da4f6b2a66
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:38:12.0901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuB3OydGj/tbchc/kJ5a3xldmT6QRcFv6iL9ASn3k8P5zaSHOZkwaU7G79cuIjxYXYcNUFfWZuYKMgVK8Ub9OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../soc/imx/fsl,imx8mp-media-blk-ctrl.yaml         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.yaml
index b246d8386ba4..dadb6108e321 100644
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

