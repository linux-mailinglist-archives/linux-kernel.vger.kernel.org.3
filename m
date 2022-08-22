Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9C659B9BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiHVGo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiHVGoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:44:22 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2054.outbound.protection.outlook.com [40.107.105.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B5B286F6;
        Sun, 21 Aug 2022 23:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VI6xOaNhac//fBBZIKTRpJONER439MZFmXmuUIXwc39SJ9yS8ltbv7FRv6Iv0gdtRucet4RRze9TxjhOuDO2eHXqDtGd/UbeLPYEUSL35vFr08QgWNhJMgmP9iKEPLQD2qlXtEk2qS5+WejIlCErpbnnnWTG5ueb7dkRCqX1Pnkyx4IL3Q8e4plp4uU1AgBPorKkNx1M41FlvIroomLrI/U1DiV682JZ3GK2WeIeoGJcp/AZEQsAC0Mss6ITztVBY9lpGyx1oH5I00VKdDD9vRXbXenwiAe9lvHUkegPmDv6SxkrJjrYvq34HEDHnHBCCzIBrUikHSFl1ZHeK+PB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ysh2fodLYYYpJnJNAYZRw3B1MBhuonjR7RoQeDO6NyM=;
 b=Le4HGJiUF+JMwfT57kb0aKDnVjFM0EyVCn7LDWPQPL9DPtlqZBJYDVe20e/1LIioxyLBbqUJrZC9C444yFqCDNsBishYq87GGvWskbhHARV8d77RgGjjcqrCqd4poElISxItXDWEGIFZ/fpwXCHQFLBsqCIS/y61JMsI6TmnQ54iHyRUsrtBAnjlD2pgGZ9m/OTHOp71vHzvk9rAQRt6trk9BSXSBj1qq8ddfOjzYQyIBEXKLBDuV5ZTsXR+W985utWFmG0MWROP5IJYLEhP4tOAS0A3kpEOZUOspx3JNsIO+CRjxLd75/B9gdqlraMAR6D/HRJIkllHLFaNW2nocA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ysh2fodLYYYpJnJNAYZRw3B1MBhuonjR7RoQeDO6NyM=;
 b=jx7nNl8PCTEDWVZkUkVfs1xDi0rS8tPq3FRMk/EDBImdsxeChkxaBe3tw0a5TvYEjaf8RwMa6vOoJjVlCmf5KrjX74TfQuq1BCd317aZL3+F77wA3osOAiUCaVXEvwtshggZyb9nQ5O5w5bfyb8Sjkw4ogYPNnJkVFV6kGRYvnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8476.eurprd04.prod.outlook.com (2603:10a6:102:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 06:44:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%6]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 06:44:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, laurent.pinchart@ideasonboard.com,
        marex@denx.de, m.felsch@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V5 3/8] dt-bindings: soc: imx: add interconnect property for i.MX8MM vpu blk ctrl
Date:   Mon, 22 Aug 2022 14:45:31 +0800
Message-Id: <20220822064536.3947512-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220822064536.3947512-1-peng.fan@oss.nxp.com>
References: <20220822064536.3947512-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e47fbc7f-bac5-41dd-5069-08da8409bc75
X-MS-TrafficTypeDiagnostic: PAXPR04MB8476:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2YRdCyzuqOMKDEnfKXrn40vETOQZub4xkp0Z/kOACJokB+CiOVZyl5Fk3oUSrxfTtVoGZK3Hw77fYD0WOME+SIuPA5hZgsMNxf+xHmoaJ0EpX/I/xJrvjkumUNg+N1sOlRmblXjXIrckKL97PzsOQ1e+hKKbOAmbrxd+P9Zry2TXa3bMQMpYVHdXBeMDJLKrdtRfAjj5vjmpEYKLszxYgsb1XRArjm3hhCuv3K3JFysY671UDeA20L1Eq9LDChXGVujyWX1liwUMe0WnuCYJDhg9Gm3cCjcSPkH0zvfwWlUuIzjcPPufxPU/Vetsjh0amTLKvzwObetOrNnE/n1QukLrg3ZbicuuFebWBiS3MbzTuzbPFSGSM8M8Xjy0yodw6DfM5aefRCt9+mZgsKRBcF0hAcTdC9Y7UTzQ5ol/xqU44PeHNCHrLCg1D06u3WWpGRQz3hTUt+LKs9Dn0tOhiUWKUeFFjskuavEspPD2GEgg8Gb/wZzj2fWEJAqape4O05Hbi4xoGFQW6BCAFe4CIGf1WrWg5tntqGqEppu5S5wuDzk0ymwN7PDhrR/q3CLJKPZZY0kh347jhPi7QRvvYXlKjcEA43UXmGRH4WtoAtoxSSzErQ00JgJ3vVEA89CbMOBdTEJwIlOLszCpDhC02RHC2DDeSFhmo3O1sZp9mM8ZfB2Uq0HdevwJb8VsNO2gce3j93FXtTlcM4sUzydL0ujvLVdAgUsOpgqGSw+h/Z0oLo7Me3Tm1PRKcG1cVpGxDk63cPj8YepcaMgaaLSqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(66946007)(66556008)(66476007)(8676002)(4326008)(86362001)(54906003)(38350700002)(38100700002)(8936002)(186003)(1076003)(6512007)(26005)(52116002)(6666004)(41300700001)(6506007)(6486002)(478600001)(7416002)(316002)(2906002)(2616005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?INyq2gMj7Zu85ASXL85un123bG08jkBt96ffl5TH/ItK7zqQuDsOUpgCPEJ8?=
 =?us-ascii?Q?LLHEBDPHZ7f2HIMN+7VITZCDNBKSiUwEn4rlREtUISNQYXRKIQKnCD8jjsIi?=
 =?us-ascii?Q?avOZBhKIT/H0wbm3C6n68L78C0fzNz92fc3utKwobiDdoAONCKzXbvkrLAGq?=
 =?us-ascii?Q?bZiJI4x2e8lPELwhBQISxwPW2q6luUMErQRGa6vufGfFgBHAopUnY0V4caoa?=
 =?us-ascii?Q?iKvbjRZ0bujoQd18CQlTUkQrwzE6dUnUTOHHAsS6hAHiC6PfFrOhinLcIARj?=
 =?us-ascii?Q?QZ5T5/R00Mbki/PTuLIthLZL3fJC8cRpIk4uRt7N6BDw0vkJCQpxcvSFMNXU?=
 =?us-ascii?Q?mZU5DDtjI8nsza+waU/J70j6jyPgpZulJUdeCUIjLBJMrdNKNYP4Qoqe7zeQ?=
 =?us-ascii?Q?XISc1kqJNyOZyeh17FXaSGaHXPXqXXGtflQKXSSb0HZvVXHIe39BJSwknOjX?=
 =?us-ascii?Q?sOZHUbibdEGIjeFS0pjgFpzQDvvNH9oKJWKJ5sOtkRGVN0kcikvx+G5XqNjv?=
 =?us-ascii?Q?oyTKL8wauMVJxtt1qFt1xpRPNaAdxq/GXgwrlSNmFNL3yRK/F50eSVkNU6Uy?=
 =?us-ascii?Q?px1jNRzOS7gOf0oZRTgkPPJGhmUQjaJamzx5XrlLrRocfuPkZ37zIBwffPwx?=
 =?us-ascii?Q?quxnj8/ne75tFAXvL6fBDeLN8fd46He9l6mAA2i3TOBamZmHkif3x5k51TK3?=
 =?us-ascii?Q?be5Yk6pBg2KYvpXrOxkaRQxLzRaURxqNKIi5LHL/SEyqfDE82tVU0bVvyt4t?=
 =?us-ascii?Q?wNCRpNNfwdAKSGwRV3Y/wG96g6V9kkcIzWVA9pJMvrg82zWYzvAZs6LYWY2+?=
 =?us-ascii?Q?8FkGLblu5iChqDtiN/Aeb5IPagNGA3Rw8qA2UxBSfKMDbv9OCkukJ+q8khcd?=
 =?us-ascii?Q?z1vatCu2JhZ2Rd4g+xFRoXluguYwwAVRBOirLjTpG+eyoyF6iiK/OLSXDh2F?=
 =?us-ascii?Q?Mz3GMNH/RYSt3IiccdYuO8peNSOm6z5DEqNmFD/dtJ9l6sg8f1n+RvvQIk52?=
 =?us-ascii?Q?aY1kJMZx0j2NcID5RoMLDkAoJoj3GgRFaM1zjruSmrVmeLRewB9pYZSaXbOM?=
 =?us-ascii?Q?3efxG0crBv50IEvlzWUKpcZJiE6lgraLTd9FbLbsnEyLhCpZ5bp3jM3U8nRk?=
 =?us-ascii?Q?lx7ApEZE/Ko7xX1hxcUnrZWSnU9XlVVrpsOC08OADEoXzBvapLKzrD5hKEZz?=
 =?us-ascii?Q?Dru2CQZ4AXkE2zWzdnqxjS5Q9xArDUKV52RHQpvJK8uxX0X0O/pw91l0lRHl?=
 =?us-ascii?Q?+jlv5SnFWb5mt8EmMJa6sHgT2CZ+UnePgMSHIKOCCxtanDYQaMjEzd8InimQ?=
 =?us-ascii?Q?WYNw8AOa/71Jq6dqCqAGDvnI3wBjnSVjmJ4ZipKuS65EcpYFqU1Ymqsog2gG?=
 =?us-ascii?Q?fTZizC15/On4s+FoLEFpen+DqW0+vcoqRdof2FjtWrwg/7e8xJ8FTryNu/qP?=
 =?us-ascii?Q?yGJSdgrRaCrLPsKgCFx1b38pCLue6Pfrgpg8W2VaFLpnd/k0IOx4PlGfEcjW?=
 =?us-ascii?Q?GqGG/ZcyAxQtfd7+RGYH/eofE74rx0bmKCp4KgnY8Hndcu4y8YM3XvJkjZLZ?=
 =?us-ascii?Q?tUZXhWvcjnj5zOJOPDx5ug8/nLVNy/Zc2YTbtt6g?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47fbc7f-bac5-41dd-5069-08da8409bc75
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 06:44:18.0693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6O6DM7VwVBeV3MsjSFZEbf9PCfC5by7ZdsHsFnRWVZvhdibDBFUpww9gf7P9VKEy0OX2N1m3j6X6rEYv2tNbYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8476
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MM VPU support NoC QoS setting, so add interconnect property
for i.MX8MM VPU blk ctrl

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
index b3fb529b399c..d79e5d2634d6 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
@@ -45,6 +45,18 @@ properties:
       - const: g2
       - const: h1
 
+  interconnects:
+    items:
+      - description: G1 decoder interconnect
+      - description: G2 decoder interconnect
+      - description: H1 encoder power domain
+
+  interconnect-names:
+    items:
+      - const: g1
+      - const: g2
+      - const: h1
+
 required:
   - compatible
   - reg
-- 
2.37.1

