Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC7156B4DF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbiGHIzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237560AbiGHIzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:55:04 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10060.outbound.protection.outlook.com [40.107.1.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DA97358A;
        Fri,  8 Jul 2022 01:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpluSB+LFblzbkZzokhfsW5aprNJ9WJ4Mw0c2SdIrWk3qDrR1GL7QYeVzRaR8OhAtFHqZAgFFQV/EHA2C2cpqILCLpMYL2wSyogqv7i35jsbwvRmicY9PeG/NB1jWEP8Xr3nRN4mmgEIv0Zchk2zUz4B7lftLCUjS/b90zc0ueN1t8E7yS1Q0woRFIesiZUFTrqkvJsFZThyTU+UAsf/aRyStiYLkDHxO9iu0zYi+j+2Wm6IxoKPaId1R+AFUUdaA/F3RPXshL69D7tn82pBndrUrJEQui1AK1t2rEYjKA7jdR1go9AuE9UySCYHVCMdK0mas2lbu+Mj9q2JrDm6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiA+8OnmQ7YBctwKVNxjpamwVG7ltfYqmjcEzCuMMxA=;
 b=XHIawkLE4OxIdX4bwYWbW9WcLO94TFyXV8YByAiwRyrMWAmEyzZk5d60CCjRxrnQIPUXhz0BPtwgi11Vhe2h0CSNZKgyXUjynEgS0N11ug6TffB5vLy29nNs+iFRlJAdjibpudId+PNXS4QDKwMCQbP21Gq3KJh1BJ1B/mzeqcwS6w7Uful5U6MOlGC2uk89Fw4R3c04/Qd1WAvMV/hhulnoKC5nN6sWuIdpwfneNCFZlHAxAqfj1uHw0ZM+1TCqngtzk0Qao23Oax0zl7KKpburOG3DTqznG2z4AuDVZFctuNSS7zBBUW9QfyTtJLXwltdQDrPDm9DActZWuV02dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiA+8OnmQ7YBctwKVNxjpamwVG7ltfYqmjcEzCuMMxA=;
 b=ag1uu2IE/On4KzlTEVoO26wh8jnSY2CCcGjFmcmjSkZkVs9nOtZmN5ROJ+K/ObjcfdRasTZTfBt0zDCuqy2/MG3M1Attjyk3jm82FqwQRQhr0eB3tVPi8CB06+Pt3lLDqaKIa5WegX04thp0IZFbTMa7/wfDLTaqd5DNZR5Izt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6503.eurprd04.prod.outlook.com (2603:10a6:20b:ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19; Fri, 8 Jul
 2022 08:54:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 08:54:59 +0000
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
Subject: [PATCH V4 1/7] dt-bindings: soc: imx: add interconnect property for i.MX8MP media blk ctrl
Date:   Fri,  8 Jul 2022 16:56:26 +0800
Message-Id: <20220708085632.1918323-2-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 12b35389-cc12-4a46-1ec9-08da60bf89c9
X-MS-TrafficTypeDiagnostic: AM6PR04MB6503:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6M8THm3Wknz2Y0XSP5jFN31b8rZk3tgjYTFFvGZQ6IEc2oe3krfKUTfKcEwmOMgWsO8QWlpWB6HcZtZnZdt4p0ZvKrZPmT7301S1bErqitNDscA5iC7dtvYgA1l+dqRiIrL95XOcI5uPspUhmu9/J52TB8HIhfIrvR80ha3k8swG8K1uS63rLTZPpvkcZv6MnbvVAgblc3ixhoAV5osDjDlVlTwS8a1oj+XzKMKNUIuM/mr7D3HXrp1FiCaji/V0MErvaofaYfzgIjL3W3tyibmEdhOz8dB8wkJnkvRJBFggmTxZr5/6M1Y+fB06itsTzfExfm2BQ3SdtQQWxrqf9tm4TUUHW+HDLDjgt5i54+Lw1vZZ4klfsT8vk5ceugPOvqqOU8lZQNXEu0A3dJi3XEPHpiabiVTMYRCeH6sWMQomKHx/TmBomAADMhshbfStiGgHhSKDgVTuN1rdd4yLJunqwoiccMbzxLJYna+WE/43E5ZluAACHMT4VTOtAz5xCr/GrBYhMGc7+z+gp0D3pjq9RNp+884umbhK4d41I+bqENhluzSiS5p2RRRrPimig8xaFt2589U+7wtoernz+z7CQXCkv8VCS8fDWrd+GNGsg/xOUen7PCyka4vGi/qzAq1ZGTGDL5hUvPDCeWzf3LTmmCmps9hYzKRe/1IUuX0qSUh60Jc8Aostk+bPg8ooe0BVX2PBs8bjF1Q7BA9LoAsSfSw20MHiInZRuqwbFxknuAgPu0xzACb3/75ztlCQ8KukIuhKAwyve04jQCxAcHXk9FovywVy9FgwKCAy+3fKJd1Mq8lrb9vFWn9D1sDV+Vk1B3FDMlWa0vbnd7BCfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(66556008)(66476007)(186003)(66946007)(2616005)(8936002)(1076003)(7416002)(4326008)(8676002)(5660300002)(54906003)(6512007)(52116002)(4744005)(478600001)(2906002)(38350700002)(38100700002)(6506007)(26005)(6666004)(41300700001)(921005)(6486002)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yZ2uH5SOGBwfhghVDbiBXuJzOQ9MPtRSsOpiqMb/PksZ2ZAvd5e+uRsjDALH?=
 =?us-ascii?Q?xHjE9kCJ5Tl/ddFZ3hn83rK7tzmY0Myukr6y1kMPsOJg+36AP6k9DBolesk3?=
 =?us-ascii?Q?z4+S0Dnv+xy14GvaRLqeVVxP+FrcymG2MJBkyNUzCx48mkVG6ZFu7Y8waFJw?=
 =?us-ascii?Q?yJ9vJE7IOC1B392IYzphr0Db3iNa6iaJeh4IFD54E4koqe7T3ie9Uuo4jorN?=
 =?us-ascii?Q?/6N988t7rX7cYbia/bzKGy9R+uiooLz0wuCxyB9kSioXZKSjCh2HpRqPa3A7?=
 =?us-ascii?Q?Qp4RySvb9CmIv2x/hV1uHC7QqU20v9p/y5bKBcDeV3nlEUgagS69hMEqg4Uh?=
 =?us-ascii?Q?WT8ga0T1SbL5rGfQ6HjU6dv0ReiBayhHCjKYYQ7XD24rZp+jR3q93hm+tx4/?=
 =?us-ascii?Q?0r4IjzIYdMNUukBCjXBXDUuexPfnkIsJpe+DENHok1nVzgBItqP0M+4iqXXi?=
 =?us-ascii?Q?hefz7B1JC37m+EUPw/ejMQe+CSqMkfFz+1hPgisE5VejXNa4eO9vM3mOpFcu?=
 =?us-ascii?Q?xSODtINTy5wnYa/OPnSTKV6hm3oaJQ16Rm9qCox7Tjk/nK3vsDGH9TWJ2mdl?=
 =?us-ascii?Q?iX5jRMHEa3UkKoIB0glbJxGlfcc5fjimWr9s2BoqmsKL9iSFD1VawIfD6cBC?=
 =?us-ascii?Q?HQeZVJQl56497PdlWmpHStwO24ovKVt+SOQvZTGjgndgQvPL7ATZM1+00VNR?=
 =?us-ascii?Q?8nbJJmBlZ7whWhwKoEqxesjwh1Clud5uMurALtJWoQMzWOF7gcgF5h52pTeD?=
 =?us-ascii?Q?VtXrONwMWcSQhGqsuf0EJAxUEL9FaW+NcGWcsIe4ABU7ey2WT2zluxQRo4Ro?=
 =?us-ascii?Q?kJ80FrVkkL5MBSILW2epLC08fVqKsvbQYPm95mvpUvSya93ke2wksH+CtV0M?=
 =?us-ascii?Q?kgfnidnS9MPNOnqWW28xz3vb2EZF6ryWMua2wA0pbAzZ/GNNTSc6/UxpcEfH?=
 =?us-ascii?Q?s77iBcSJMRmCU5B/ut+Jl9iJCAce5atXYHPZ0GZTjaMSRMAv+cIWxICJuR2Y?=
 =?us-ascii?Q?/R1inQktwTpdgkg5I6vk+1MXGLFX7kMuDAc17R4Nosm+KBWlBOdp8lvIoxGC?=
 =?us-ascii?Q?j0UdePc4lVQwIcA7MlkPOw7GVUlqLDkBlTS8WoHCCmkAGo/lO3EGIzmbh6r2?=
 =?us-ascii?Q?QvBrMt5vgwM3mcrb6tt0z9FiwmzFNFmQWu6jtyzh+Asmx+9TYYgCK7JwKvm9?=
 =?us-ascii?Q?ekY1Q5XPczWq32n8V1QwhW/DFoXMVHBPshvuc7rosceOgxDOcCKcrVZFeBb3?=
 =?us-ascii?Q?Emq1LlWOAjZ9jjoWKizuLSr7zMO+L1LP9Ti+ZKVxEZIiZZa6GL2r05MNLHKO?=
 =?us-ascii?Q?1ufVqEYyb3pq+imvXJq7GqI65m4N7qv4yhSsO2BwsxeNNsF2XevVERiLUVnD?=
 =?us-ascii?Q?Me6LEiMfkJ/ZoXmqKK17KAj01AJlCB/KUNzI5Q5HPkQ9dDk1D9Qg4q/Frym4?=
 =?us-ascii?Q?bGnElijeUcptv2fyKyCGxXI+aTsHOfof9Ee8p9u/CgIHe3lHUwRh9andDA3v?=
 =?us-ascii?Q?+56PNcUUKloCqy/qmRn6y+CLCZIdd1mvuIRP8nwnWX/gOAqCmf6w2QoTJSBE?=
 =?us-ascii?Q?7AWUnBTz1SWCGfiGzYVQRQ42X9nr06f+LWa/h91k?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b35389-cc12-4a46-1ec9-08da60bf89c9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 08:54:59.6477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oB6H7olg207fDt7IZqiOEXU4t++J5dqcWJ0MZqxmvCd1VmZOvHBi71lGTej9sWuJPURFxPfhpkiRHUPvn94zrA==
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

