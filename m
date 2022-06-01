Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535F953A0CE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351047AbiFAJka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349789AbiFAJkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:40:23 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B7E49913;
        Wed,  1 Jun 2022 02:40:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXwZ/QtxeqYNNiWc05a/3quKNvhOELZqUzHh++7NA2VHKcegTTekLVO/NM3b9aArAOyE1tSS1Q3a3k8fwH2HQ/0454ACbb/z0Tr+0NdrBYpbBYx03RUnIxO0qkfZeDosWSuB4MludDfZzBdPpAcXrMBeqIuRZK67PUktE+3ZbUhUSVQpNnAgo8MgyUF2/m/BLDokQJjV1n6UAvpih7y5Kvw8758khQtsHwjSrHZj1QpKe/pQGCXglYvRPN9TqJosktAmp/KqHu9b9lZp4/5Il+CIAkNjm7GPKXrYPG1nGOYgPyUeGpsLuC3UoG6CA94gJXAkGN3rMuRgpp12a06sxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAiHltzt9iPXWs7va5jg1kDM5JO/U1I2D5o0n0klu5k=;
 b=XGmt/wP1XwgQVqVldtdAoBmOhaMjqKcsgLZ0Y2FanAut2JHcP/FZcTvyg7+gmq9KBNwIe9Kp/zZ7mGuUWhYBJlzkEGo92ITvXZ5ra33IYNb55rvGvWv8UAG2wAXsA/MDbt3KBC554L5XUBelYCenneVJg8tObzgevmsBkoJt+KJFzSpI3YrfAq8GUjLCZ3OX280epUi3Eit07h6LylAzlH83xKcVYQnDA/+wDciwyF8ibIyOnpSiBtGKx8TDSpLo1LBnJhHCOg/Dxj6fVH750uDoaF+OPglpQ9EdeWyk5MkMoFD4OLmiJJPgadyNfJM4b4VQagWD2KpX3ZOj4GkH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAiHltzt9iPXWs7va5jg1kDM5JO/U1I2D5o0n0klu5k=;
 b=IQcxPMJ4J7wPjLzZx4lymh46jIxk61fHzJkldYYD7AhssdK3q+Csmb9BJggUfFxlwWsziCbMRXvEeuoV0pV7ZKa0+okc9DRvsBog6/BW9O/dZpWwM78Dvw/gEM/1dCJrYgQXTYDQKbt3ExW3kdru2h0U//f13/fUoWa2koplXyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6498.eurprd04.prod.outlook.com (2603:10a6:208:16d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 09:40:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 09:40:19 +0000
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
Subject: [PATCH 1/8] dt-bindings: interconnect: imx8m: Add bindings for imx8mp noc
Date:   Wed,  1 Jun 2022 17:41:49 +0800
Message-Id: <20220601094156.3388454-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
References: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0078.apcprd02.prod.outlook.com
 (2603:1096:4:90::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e9079ca-7ea0-4364-36fb-08da43b2bdc4
X-MS-TrafficTypeDiagnostic: AM0PR04MB6498:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6498D37A4AB822C137C9A192C9DF9@AM0PR04MB6498.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mS/BFILwofD2GWIJTlU25RbbGxOAyKHMMXgBzQ/7U2G77/62/sEdv/Rhu03FyQWKUTaQ7of4MWAoC+cgKvlwXrJImJXMxizzp59/qeYgI4ar7ExhpkdRdgPrhNdjx9SvclDOWpbs329LW83G3RgH8sGx5d/9cPaGVCxi7IfLjTlPLJKRjzKNNHmX5JvgNLiC/kitLuhclEb4Y7wSjcxGu5e3IdkG4mKM9SOo4J3s6VhRsFhoCTWA+izHlbdT03jukH963qL246bKpM5iq/5USwnUotR6G1eaugMUkjFyTUXr+lq7nrTlWCJ9Arm0QoXPWVLp/IU4JTqvJpnWZl182mKyy3+opcorjMtocc8GzjGUG9qZUx0xQ1/XnhNJnet8WCiAGgO1YVMDOc7R3fHnDhHyh7NfHUg8cKRJimKUDxcmK65qEVxEYHkE7DGmMn65C+ac7hdIK72U1hV+sKa7bd77Um94RLExXEuXjE3mtqEiaAsLURHY8kPjPMSP2wz+R7yM0iUa9UN8oojlNZEXtMl3IhN69KROhhniQv3gl33e8kvJrxkCS9nA2QcR366Kxm3At7tCRlcxbswRTNW1/z03zAbzGGcYun2z2b4l1vRcJ3G1iuB/rZZ88QS52MYkPaL669wlPXJtRTi/DbZn6aJHnhtM8XHGVtjz/SqKBUamnlvXHmHt3SFWAVmXlqzPUiDxhPwAB8ADmg1rr2DTUGpc40JVheTnPVfM1S+2/6vEwHxuvNK4Eq9IaSVHWjX9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(921005)(52116002)(4744005)(2906002)(6506007)(508600001)(316002)(6666004)(6486002)(1076003)(7416002)(86362001)(26005)(2616005)(8936002)(4326008)(66946007)(66476007)(5660300002)(66556008)(38100700002)(38350700002)(186003)(8676002)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SD9sbDCTS4M84InYAoaSFJOojywvEdH/jsF67st0yV/QVf9EBPmVyiJ6dlzr?=
 =?us-ascii?Q?7yEHMhzZ/0slDH2po0ke27ghskqQzRmgGfh7sZVicZMB6jl6IwGi++oqLTji?=
 =?us-ascii?Q?f4LBZo1UWSbBGwlO/0HItk4WZjyZLDbKBdwueDPzUVWoxRkeha6gOGzrPwyx?=
 =?us-ascii?Q?PRLh3fli0lMVpNQ/6sBT70sKFcEzs5jWQG5SieJgNRORN1XJLv3nxwecn1Lw?=
 =?us-ascii?Q?AlXkQUOcm6sJXbt/z3IC1rIcZ+eLgjgfxdbYE2ix4mBIdJcmpirmae+RLzel?=
 =?us-ascii?Q?NagF5hf8ffAqtF0+1eI0yRrPGcDg/Y28kiEEEcduTGRxcmVSL+v8jxb0y5Z5?=
 =?us-ascii?Q?yDD6TEgyqtJ7cSxpx0CtyDdNR6YCRdLvhkppAwJNwM5Gk7MumzUr1VIe3eB0?=
 =?us-ascii?Q?h8XQNSYhSpEk88wcqaF+BLS87DX3+hIwqWH+fw+7gUCrvmjxg7LLM12irj22?=
 =?us-ascii?Q?vy5kO/uF1Ysd95JTTPAVtxu9aGCZeoH8cxzJyxXcXTFCBbezptSvNLl36gE6?=
 =?us-ascii?Q?3fwp1bz3wYGH6TG6G1MQyNxQxUokMyH0gcwD0jkynBm+HYPM1+SGv4MSW5yP?=
 =?us-ascii?Q?bjU7Ub+zzFl9VLjTZtNX/NMDd5caFsne1AFEhAUIqCMBO6Z9qnSTuEiVsFnh?=
 =?us-ascii?Q?pU7UK0VGywlanZdPWxa+g2UGUdfYJ8EarFnBuegIUGtUiXyypQg0Jo2/Dcmk?=
 =?us-ascii?Q?M6GLnF20SOXLVDg1dI8V4HVyORt7JZckuqmR642yKSvzZUgtPCVeRyulSYTL?=
 =?us-ascii?Q?XzQMh9YCSQuBbxZek8Ozw/9GQpqleQJz7xyhiQMSZIb91gyuUxH9FtQGWxvt?=
 =?us-ascii?Q?AYUB3KhiHTKLG3kG6BwfFIDKsvltS+L4iFOkHFIolwph3QDrOY1BRrRK4sVq?=
 =?us-ascii?Q?kJOaoDRL2XyXNPfWRw2BX5NAhD+n1vWExzaMDvMBF+/gtZ9/K14KTW7OwwSC?=
 =?us-ascii?Q?88IBh2l7U7jQ1Audyj5PyYeAWSOSAVZwqv0Zt6BCxYYl/P6cRnzMqjm5mPTe?=
 =?us-ascii?Q?dIEDofuUFCGepnajXF8VqNDQnmNB0deRXRuKYazwKKh4zHATR8lOjil/DnXi?=
 =?us-ascii?Q?eAt7gu8K3nBm+Dne3A3oXHRFM1MLNq3dwbhQ4fzoC7AnuKSE3XZAWpwFGwes?=
 =?us-ascii?Q?sWFJXdW4dxJgDDpuRIrRLkj0F4KHwAF/kBx2hg4cst8Fz5ZBUQB30ibKjAkW?=
 =?us-ascii?Q?I3He3BaK/xqiEO2ltrRTlCXQTxpJWR+v6DtXTPlSducLidoF2kakZifXmAtF?=
 =?us-ascii?Q?g8dpSBsGwyLO0itgeAG3AAySlSiC5O5PytOudBTTZLXwWZyz9rCuWKGcJFEL?=
 =?us-ascii?Q?Ifn/8SU2qNQzUrX/7yoDJWZVcmRNbmX5ZDTRRS0pnm50AS5QxzCzCGTThVlA?=
 =?us-ascii?Q?qTJCKJDJS88sEHzva9zpj5wZOLg47DoaQHqg35zAYwfSpmGSXhwl9YKUoG4y?=
 =?us-ascii?Q?KDqvyurbWo0SgQAMf9MfmBiP3/iB/M7vUY6yAHEJc3O2iJgeQiYZ/Fyb+hQM?=
 =?us-ascii?Q?PyzLJ+J0+qa+oXRbgx5/y0mct5j8CsBDvSAVvPqIcyy15aAAzv2ppLn9EJs7?=
 =?us-ascii?Q?ISSNi+HdYfv+NCkpy3qS440pqkHT+nv7/b9EPtEJaVqoeuvuGYuT89AQ4m16?=
 =?us-ascii?Q?Wqkm8Z7rG9NBffL+HvYs8LNEes2Mx8IsJSBdK1lwuzGyh0HdoMYKKId6COzw?=
 =?us-ascii?Q?YvDxttmhOWVRji3vUpyZE8hn5pkAAzaeR/O/uuG9GeqGMS4iFxX+rr10sWfz?=
 =?us-ascii?Q?lJ+WIWIFGQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9079ca-7ea0-4364-36fb-08da43b2bdc4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 09:40:19.6932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULneV28Oa1YRzDJR0XvDemkIsfJlLoijZWt4u9XryseJJ8DCjVMuXKsatrdY0MT7AJHPUVnz7C+1Eo+jiCr7LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6498
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP features same NoC/NIC as i.MX8MM/N/Q, and use two compatible
strings.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
index b8204ed22dd5..0923cd28d6c6 100644
--- a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
+++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
@@ -26,16 +26,22 @@ properties:
     oneOf:
       - items:
           - enum:
+              - fsl,imx8mp-nic
               - fsl,imx8mn-nic
               - fsl,imx8mm-nic
               - fsl,imx8mq-nic
           - const: fsl,imx8m-nic
       - items:
           - enum:
+              - fsl,imx8mp-noc
               - fsl,imx8mn-noc
               - fsl,imx8mm-noc
               - fsl,imx8mq-noc
           - const: fsl,imx8m-noc
+      - items:
+          - const: fsl,imx8mp-noc
+          - const: fsl,imx8m-noc
+          - const: syscon
       - const: fsl,imx8m-nic
 
   reg:
-- 
2.25.1

