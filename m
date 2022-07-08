Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADF656B4DA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbiGHIzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237560AbiGHIzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:55:10 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10050.outbound.protection.outlook.com [40.107.1.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA7571BED;
        Fri,  8 Jul 2022 01:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NF9iYDyKAm6LAIqsjdMRcbY3Cb2GzoyKl1xHig8h5sJkzlpIvbJUlG6wnlnqvNvJ211e1WoVxsipTpweak2NA4PgZ4c4fnhvkFwiBv2EY6gtgHig4Ad7FxDlJy2NK8I5GgDdWShLijOBsCHezrgVyXmwUPWmtLTBMnlkX/VfqYY+VEqeLCI7pOxUDHytmql9tBZp5fe3Fypy9qdY47UTozXLpcjsHOXah8Fmcng73G/i5ki6vehrvFrLn5zt1sKoeso3F08IK6FwDIV43foBuLuZlcBKhq/8BSfzeUGouEIXAP2sBe/XHwf7MDES25hFeL+69Gd2kfcpp1D0YouXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLhlNisqvlpwQtd5Dm08Rk/xcIL5USTSTUhDsl8b+U0=;
 b=NY+6uTFObg2SZ/SEL/OoHYgsXLf5rs/3rg+ElHmAmCM9zg/Dfj/xVdGknx6Wo9YrkCX1H/C6YDoHUgtd/H2F2AjZ5WYZLReTpZ2IvHJiL4UBeLOd3tL84nSzVN/JAEMiUOzAQjUivDk+xD2zBoySZiZ88bamUAEL5rCII27HW8JOlX1h3rDDct81of/B9HWptUFAUKH1yNPnNeFb9mKWAw0o8SsBBAiH0qFlo4Dq5HuZn442OdXilPtWcoW1TKLukaP9Zymr9cmrHD78pMd6z8gxIeKGmMOL+Mrk1dgU4uAd+q+XqhnYSRIhUrq8copCbzxhxu81BHaYDHO1vMDXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLhlNisqvlpwQtd5Dm08Rk/xcIL5USTSTUhDsl8b+U0=;
 b=R4Lcx0ySGI+JcU7UXqTzvOTiENNlsSAMF1YBg0G+SoTQTFqN4Dpz9Lk0hNGgPL4jXBaSY703cK5C/UktzS2qqarQz69GaSJK/lGID6IApY7vjxak145YRNdoV3ntzuVm2bj07KJ5NbTVJ9KWtLZkMs5akSafaqVRDlF4HCs7Mko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6503.eurprd04.prod.outlook.com (2603:10a6:20b:ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19; Fri, 8 Jul
 2022 08:55:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 08:55:06 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abelvesa@kernel.org,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V4 2/7] dt-bindings: soc: imx: add interconnect property for i.MX8MP hdmi blk ctrl
Date:   Fri,  8 Jul 2022 16:56:27 +0800
Message-Id: <20220708085632.1918323-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708085632.1918323-1-peng.fan@oss.nxp.com>
References: <20220708085632.1918323-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::14)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35d309fa-bb45-4b90-421e-08da60bf8d88
X-MS-TrafficTypeDiagnostic: AM6PR04MB6503:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8rr1yvTY88eMg1vMrv/8aCITJvaUGCg/AAkV/ppZ73uwdDMZP/c3zTILi2Y1PiDf9q5upWuH6oaiL2PGGf5wfS0gZwYWv+ywMhH6HEhbQBWEgd9Dx2hScUZldQwgKrDz75XfUlJCdvpqVK0ygzAN4GQAV6dznk/cMWZWvFMqQdb1zsSRvjKm53uHZd7V3SsEFr/seUJhKXAwPVauIOsbmtBN5SdN2VWmzbWT3m+rDG23tA4+G6koPmlU47J57InRcYjkyjvCpqYGSx36kjvMYAHaz7zxwcBrXUmNZh0ChF8J4o9JcO3xygVlij8sInfSELzYb19dVResv6giHcpdbqYvKeLR+HyujdjJN73jJ8dAofzOSv50tNYfSgR8AiBNfVqlb3CN09SqDLYRReaeRuZi0s0uJqWFjXnP1dJ7ihXIMpWe9r9baqWRb613QEkFKabdDGBHgV1Asg/diY3djkKwcTTOjFYHg3ShhFZjxQAvB2HnzMG1oUrQD4/XvSBi6myb39NX7VSDZEiFsYcX2arLAir93fAK9mVUAch4qAWqmkG2Hbq0B6iZTHtP0suWEpMAYYjE50j4YFy7lNV/PJ/oc3cbFjg04ZGcGK9yuWneW+fxZp4zmBoYIELELJt5mbzLLFdHfPZJmQqG/yOMiM1M6loD01hcBtXrtp0VJ3bIPStqwqGUEuq+YnlVpmf/SaCAlvawbOzvZcWEgyEk1AfpQALAHWUMtoEWxsyT8JeCRJIeOiUkAkWLJM2chxPhvrdKeMmHZJVu7IWQm5zZZF8Iic/VrxmmVjQzVMfUpnrdBHrDFhN2N/fY/it1D3EUEdya+Qfgk9XhztQi5J3VPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(66556008)(66476007)(186003)(66946007)(2616005)(8936002)(1076003)(7416002)(4326008)(8676002)(5660300002)(54906003)(6512007)(52116002)(4744005)(478600001)(2906002)(38350700002)(38100700002)(6506007)(26005)(6666004)(41300700001)(921005)(6486002)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vrmINypSMv8Z6nj5pWAVmZv5f18dHMdp3wiopVpMX/tGTyMs1j4dLG0WavWD?=
 =?us-ascii?Q?jvsHTLTv6kyFTveD7TeMpOTAof9BW8lkAkpP6yO6/KDiWpWuetqn+uX0SxOq?=
 =?us-ascii?Q?VmyLITf1AupV/oVXqwCCXmVaWHU6+rB4FUFQZ6RvwARmwW2B8R6q+QqewvXt?=
 =?us-ascii?Q?z2hJJFdoYjQAwBBb354Ea8Y8tPFleFc6dEtBrUqX0hw98cb08va3y4i/fhrW?=
 =?us-ascii?Q?uQ3ANbPgHQKQWf+xjuYGdiope3cW3v6816PimFNkRIsBAXRuAcSZfsPE28Gz?=
 =?us-ascii?Q?lASFPQoUfB+HZvS50gK32Zb9P5PN7Vvonsw7vWkBZQ6bIHPJi8Gm4N8TZpCn?=
 =?us-ascii?Q?swVIU/yZJMAH1+JY/6K38hy20q/c69and4c0LWq1nrQ2/0h2vVq0U8+K5KTo?=
 =?us-ascii?Q?HpDDx4bgFvaQI8Bd6LU4c5X+T6j9tT3paNp51GkC1wmuocplpAc8D1kjxhIs?=
 =?us-ascii?Q?nwOt6BbJvc+vt/s3mq3ZOX/WgZk8O5tq4SpZoeXEFHZ9ZayDGM7cLytA/74A?=
 =?us-ascii?Q?mBt7tDXtMLb4J/kuBnOOqxQuKxSJGUAzv9a0bAMmG26BVtZOde4KgRvoYRmV?=
 =?us-ascii?Q?+MacZluVRE3nb4g7Y/Qmn67po3jxp5w675v6msZf5gVXQMM3D/2plTEjeVSG?=
 =?us-ascii?Q?3IeQfcGgnVNc7sUpnrOKG4A2vpF2LSlWjl2PBE1FE1DNUuXiUYlSuGbOEyJY?=
 =?us-ascii?Q?64Y4YiGuLEhoZViJSfG1Tw7ruOVW6O6AAULix4bpDtNAeEMqQDLADqtOzCyL?=
 =?us-ascii?Q?Y8oBzAWcoN+ULJo5tJRikW2w4lD2308y+xDre/ngHfKNuowxtaRzO7FS3c1K?=
 =?us-ascii?Q?WnkOosihDJ/x/zwMNXKwCwKU2q8EQXy3tjOC8sYdj3eAQzoxHugVnEise7Gn?=
 =?us-ascii?Q?ciKQeQKRZBxOhEFUaVA02xN2807rTBbxkcjxXyTQ/g0y+a+8BH/KRIRs5a9g?=
 =?us-ascii?Q?nDerg/gNCi6KLREYjr1TQJ0fKTxNPjxa+g1dVp8/UkBCwmB7Pl9FwQVAYCXp?=
 =?us-ascii?Q?/bVVBUHnExQ0FE0bWr04mp4irgLpgKfekkLKMwAbEJiBVsmgiWFqM+y9MZZ5?=
 =?us-ascii?Q?y6LmGPd6CGKn8Og4Wlncp65M916zdoi5LgRIeIAA/xyUOz2KGue7SkF5is5S?=
 =?us-ascii?Q?GCPMoSGbT/BQpkc1xCIEpLm+OfAyKENN100Af8nqFjOB+CA4H+5sCEbGCSjT?=
 =?us-ascii?Q?saKBCX3JvWyONbnxBUORuKqH8Ksv4eREH5sCiRsVAZo2f6+2ZLGjgAKwo4Gr?=
 =?us-ascii?Q?u4ug8Ntxou2XS6G0e7T+0yW9sb2T1xABM+T6Onf2RhjhfuNU1eWfdttjWGTR?=
 =?us-ascii?Q?Y8MEboKau7uzYlQGwoo/IMy9l/nMLAcZAUX1keqZckDmzoJvhQxN+CPJJAT9?=
 =?us-ascii?Q?3p1GQlxUlyPB7/s/ujDZdo4KEuxvlcTC7sS6s1/YpSJ3vOPqPMzr72oTiDT7?=
 =?us-ascii?Q?xrwUP6t3Dg0uHvKzaVUzHox/s90hFb65sTsPgfyjwdl/b/1SY/DXzPRaRGtq?=
 =?us-ascii?Q?+BU/XvVht1zGG+HP4B3T1ekESqsdn+R+cXUw/7nYej/cQDxKYlqH5ER8HUE6?=
 =?us-ascii?Q?ULafRJbcK+wML+hvJQDaw4/hdNKiKwaM/1NBaq51?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d309fa-bb45-4b90-421e-08da60bf8d88
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 08:55:05.9164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xx0nPNVC2+TRPG0AeJGFHx9CG/x/pvZLp06BtHWaok5EiVZYrtjDKJ3s1aa+JMMmCFvYbUcAGswjIF8fXYIN1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6503
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add interconnect property for i.MX8MP hdmi blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml       | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml
index 563e1d0e327f..1be4ce2a45e8 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml
@@ -52,6 +52,15 @@ properties:
       - const: ref_266m
       - const: ref_24m
 
+  interconnects:
+    maxItems: 3
+
+  interconnect-names:
+    items:
+      - const: hrv
+      - const: lcdif-hdmi
+      - const: hdcp
+
 required:
   - compatible
   - reg
-- 
2.25.1

