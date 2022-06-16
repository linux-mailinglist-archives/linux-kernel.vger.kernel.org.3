Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B69654DBAD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358999AbiFPHbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242021AbiFPHbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:31:44 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20082.outbound.protection.outlook.com [40.107.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFD751338;
        Thu, 16 Jun 2022 00:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnC7uczepsooC6gfKx2ScL1SKTVCzRhPsm+G7V9MPpdazSYj89EF+vqvAmR+fW6g2WIqMikcL53kgBMxO7tFFT1UqvlFwhrPINcNePx7boSvsJlSLkL6ELRSgai+rNIUYY+LNGRAvSx6EzfrLVRLT1wn8SazJ0dBwI39Cs6EzDtBE7D3QpVX+JzgQVU9VLrLojrdS2wFVuaDvDx8+aTEFqDmhh53Hm3OYDs6Fn54828aDF0C8fvvYiu/i/6UtwUkKS58x2wC2VlRPMNfv7ETwYff0ooDVipPJwv5Jo9a1eExkdUduCkEjyAV63LjLpMzWIkvqjTD6/kmReLdKV/FwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgLgMfJVaTYFJuRZQbA7dsevjLDufgx/ruBuvNivTwU=;
 b=GE13nsiYzqQfzdPryeeOVHAavGQBpGBFt3ZhCsXo19B7dz+D9DFgXUUxVX+jNjkbxo00gxw40eHIEJ3EQmi5OW0B9Ss+HXsmpjqixggRIR33lv/Q8T+C/lMzXY/wau7FKWU35xOkL266PiNKRvYJAboVbMDO5ZCo18OaHKRQ1KsZIqKYomKgSSg6OQK/LPHEc2uuKc1BsRAGM9WjGcdk9YKmC7czbkxCsxr1tvtpbmQJdIFwO7zZdgQ1mPW6ju7hqt4rRpyLGp7fUcOVaceCvC0bpvWK9KUECmsBMSgy09MB/LIKhBjhR6ZeOK9BC2qqEIm7ooql/2x8Muq4vy3LkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgLgMfJVaTYFJuRZQbA7dsevjLDufgx/ruBuvNivTwU=;
 b=D+w+/YwKpkrbKC/42dEtV40KrWQ5tNXPif0lRBQvzufVk0BIA/0qHtIsT5a4/3xqm8GqpZDVlBnRgu+c2Q2q6KjoUMMxQWbcNaASTSgkOJwZlrD4H7QohhtTTvtf32foQXvXmbAg9JfNPxZLv9oXjQEZVVyW/BbjIPJtxLEmoX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB4850.eurprd04.prod.outlook.com (2603:10a6:208:c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 07:31:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 07:31:40 +0000
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
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/9] interconnect: support i.MX8MP
Date:   Thu, 16 Jun 2022 15:33:11 +0800
Message-Id: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a54596f-05a0-4133-46f8-08da4f6a40bf
X-MS-TrafficTypeDiagnostic: AM0PR04MB4850:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4850C3E5ECBF29FCE0E55C55C9AC9@AM0PR04MB4850.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 263AlMxpFVAzcBWb/hsT6cRiHengLA5OaQORmwHh2FpO+vlaiRGfgUAihap/A/07MGv84TFcGqdO/7qN7oEcS1JKyavYy3ZbF+3b0FgxvtKtHcPdYt36kVsLYtGAF5gBxhHMaN4WdEz8sTVvBf0X3F7Dp2QuVyDEMDQIBzUvu/TFDr/toPpaDzY28kPKjIGML9z1rT07P+m5g8OD6iCm8ME5uStfwC1KYgS2wLAC1tkCATCO6bSlHbkRhM49ocsnVlVG+ayCV90cEY7UVb9VUJJ8cvOoyOspXzP5wj/LPRCaqHmRvJ2J2Q/F3q2+Movw0T282RO/vxvEHG9V9g1Y0LR1KDQqY3gzpKvWw7lzn+pxCLmj5riflxiBEHD0YpF3LHkKiRVejqdizjHy3M3Fe6+jqd4Lnky7OH9gg6f9U3cVSchjjPxBqzbvPrMasJYahBs0xZMvIkm4rSV++OXpCzzeq0M1s+BFGIGCDNKd5ysX1gOiu/yhi15GUQPRzqMtyIafymBITzmy+kQarczQF5HUC7LjZ4LwxPjqDEwGF3ySZb+Pmhq2RwAEEz22h9H0rAV8YsxDtSLzBZAIev4e9188UaiWz+CQtHgEKB+wlxWN7cVGlW4nbxSgnf1eS0puGW9+8Ab2OSgKH2/27uP90lnMo61lXIpDJdKX/D10ohnA+GxXwfUj4gTIi70T3Zx6JJsmoOv+4Puq0kLrfUCIGeoMXitYJo0Vuxi4R3yz0LRlHjKAbXV2L/8AwcEktLpQP5bX50rs7f/4Kh/GFf+naQkh0l4Tsv+zLGxPbzPTY3ehBWUnYox62/Dinci+9uye/BecFsq97ssZ5V0O2zEqvrWK13CnJktlXRmJiuzZWBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(66476007)(26005)(52116002)(6506007)(4326008)(66946007)(6512007)(2906002)(66556008)(2616005)(86362001)(6666004)(8936002)(38350700002)(316002)(38100700002)(8676002)(508600001)(7416002)(6486002)(1076003)(186003)(83380400001)(966005)(921005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7D1NYbUMzn4cCQW6wqMrmFUE6VXSro9JXCnHNIKUwBcllHLuoMRbg0wTnhjT?=
 =?us-ascii?Q?bC+ef1r/xxtSC2pI1YOy+T2umX0b3pVyv1W3ZYl8mASzGYuXSWed5IVXbI9u?=
 =?us-ascii?Q?jNsJ4sEl0MXkmcStLT11GXJzAYvTchQmln0os5MIksKRW/ymKjl1/1ygjWHz?=
 =?us-ascii?Q?Pr0B/k83ztUduAZAKYv026ZplX4WSYmkCrskBmQaBdsKWHA7QF6hu913Fdbo?=
 =?us-ascii?Q?I792IHLbt8n59nL5qX2b0K2NLPAFOZV7HxgurHO0v07b7O43FiJuKItXW6iG?=
 =?us-ascii?Q?VxR7Mj89oo0H8f8i2Suez9T2VgX40UXHT8f+2krfhN0HEgid2KTcRu17rQGR?=
 =?us-ascii?Q?lyrZcDja+dZyt5SdNePTI0suvL2FRTRbaf+v3pPjM3Eyu3+N11DOtmgJ36R0?=
 =?us-ascii?Q?LHuyajbplTFsBanOiaFFdIE0n4iItBlZkWQlU9m69zxLV1QskHDh1KfnCXuq?=
 =?us-ascii?Q?2kdnIZfK8LVelUjFol4i8aCubSSDZFq6LtXFPJmuX9rg4P9iSSi6an/Pnw2k?=
 =?us-ascii?Q?GEpDxH+SpSpl7bOsFyWQbeInHbTxIwm5RBI97ugnhTTQIpVm7I2RFerewgWD?=
 =?us-ascii?Q?1nNKzQ9+rh4bt1w5XTX1itx09TEThnYSfeJFR7bUp1q6b4suxdyyBzjvAzHC?=
 =?us-ascii?Q?zLP/KHlY8JWmFBfWMLl2kcUr7IZr8xf17dES3KNDakNWkG949NGqv6v+vMex?=
 =?us-ascii?Q?DeZA7Eh2Ep940Gfm3SNqKr6XzJUqOGEdG2CmTrZeqVQf8WFOBI6ebhFec4sr?=
 =?us-ascii?Q?yEnvJx6b42Wp0bAC1EVVeVPuLTe7TdaeaDbBqgaEDgDNhtW0YvBevuHIz0vU?=
 =?us-ascii?Q?rdLJjZwPuazRDMZ/Ah66LEHJm4ROhcyuXT9uE7eHKTTV5MtmVDAyaf/b05s3?=
 =?us-ascii?Q?rCTRVia++qVjSl40C0OM8u94zHYRtjJKWDJjtwCoySaon0GyyUDtruV0Qfiz?=
 =?us-ascii?Q?+nHbCPoqzqp23OQp4z2NjXfrQ0eE7RvtBscqMXdyc+5ljZU6FEIVKzvA8Bid?=
 =?us-ascii?Q?a1MQgtkg1oIF+JE2nZoLATcSMsX7/PPcMZvSWNwVTOdb+48GNOUaN1cSfnj2?=
 =?us-ascii?Q?BTWJ4WUs9VLhE6sSpk015tHt7kTHk0MP1RDQBI3YqOpF3awaD5diBbkC8QRv?=
 =?us-ascii?Q?WhE5ClF1lQZ8ErjskkJU8XNCphT8xSPvI+fk/ft7VID8tx/zwOBvF0b9kZdF?=
 =?us-ascii?Q?lgF5wmJ94JlG1GHqca0fvLnM6lPSKz2nTuFokfepSDGVLBlzY0yjwx68aLMq?=
 =?us-ascii?Q?RWGuhZ9NpWBsXRoh7urVT0oIKyC4sZ9SwFvSZkZGoR2PG5Ih4HlTRk9w+10Z?=
 =?us-ascii?Q?A7vHOqoPpN1esZhEqcoO8BJJtIY23mE9E19f/Fzt37H29y2TiOyCWOXtNIn7?=
 =?us-ascii?Q?vXbBMpz+tQk14m6xLwmKiZOrW28TfJVZp+mAI3VO85v+ke3Zm25Rk2tTMRAI?=
 =?us-ascii?Q?IQx2KylwuTBGK6F+YP+LRREElXFUTELT8VSUutbdz2wqnpCC4zTMevYWZIk8?=
 =?us-ascii?Q?2hI4rm7aWlypy9QEkhoH/4Ktl583KVpYB/fLBf2IpH2DsUA49oDiJIVg48rq?=
 =?us-ascii?Q?xl/S7eWBLmI/MSr4CC1SziLk/6eEBnOEj1kC4pMWpi4UfomSUBF1PemYEMnY?=
 =?us-ascii?Q?VrUQPPXXMgh+wMGhm10wrzkvSUv7WSzSlyMBZZ5tIRG/CWJ26UEtregDV9o3?=
 =?us-ascii?Q?6cGmYeO8SVVhkpZ9Wn2Dt2nbn8CQTjhcJYQBsKs9ZfGFr1EwG5kAIDsbXZj+?=
 =?us-ascii?Q?kUm/PCXbvg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a54596f-05a0-4133-46f8-08da4f6a40bf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:31:40.1301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvUmVirZbyQFVpdKYyS50lTj2M5DaAbbcTTsI48vVa5Bl/BuPZOalOatPA9Kfc3NdNwDFqVx3RUN6nCRKMXnMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4850
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 Per dt maintainer: drop syscon, move binding file fsl,imx8mp.h out from driver
 Per ICC maintainer, add kernel doc and add static inline for an API in header file
 Rename max_node_id to num_nodes
 Describe more on the registers.

This patchset is to support i.MX8MP NoC settings, i.MX8MP NoC initial
value after power up is invalid, need set a valid value after related
power domain up.

This patchset also includes two patch[1,2] during my development to enable
the ICC feature for i.MX8MP.

I not include ddrc DVFS in this patchset, ths patchset is only to
support NoC value mode/priority/ext_control being set to a valid value
that suggested by i.MX Chip Design Team. The value is same as NXP
downstream one inside Arm Trusted Firmware:
https://source.codeaurora.org/external/imx/imx-atf/tree/plat/imx/imx8m/imx8mp/gpc.c?h=lf_v2.4#n97

A repo created here: https://github.com/MrVan/linux/tree/imx8mp-interconnect

Peng Fan (9):
  dt-bindings: interconnect: imx8m: Add bindings for imx8mp noc
  dt-bindings: interconnect: add fsl,imx8mp.h
  interconnect: add device managed bulk API
  interconnect: imx: fix max_node_id
  interconnect: imx: set src node
  interconnect: imx: introduce imx_icc_provider
  interconnect: imx: set of_node for interconnect provider
  interconnect: imx: configure NoC mode/prioriry/ext_control
  interconnect: imx: Add platform driver for imx8mp

 .../bindings/interconnect/fsl,imx8m-noc.yaml  |   6 +-
 drivers/interconnect/bulk.c                   |  42 +++
 drivers/interconnect/imx/Kconfig              |   4 +
 drivers/interconnect/imx/Makefile             |   2 +
 drivers/interconnect/imx/imx.c                |  78 ++++--
 drivers/interconnect/imx/imx.h                |  50 +++-
 drivers/interconnect/imx/imx8mm.c             |   2 +-
 drivers/interconnect/imx/imx8mn.c             |   2 +-
 drivers/interconnect/imx/imx8mp.c             | 259 ++++++++++++++++++
 drivers/interconnect/imx/imx8mq.c             |   2 +-
 include/dt-bindings/interconnect/fsl,imx8mp.h |  59 ++++
 include/linux/interconnect.h                  |   7 +
 12 files changed, 490 insertions(+), 23 deletions(-)
 create mode 100644 drivers/interconnect/imx/imx8mp.c
 create mode 100644 include/dt-bindings/interconnect/fsl,imx8mp.h

-- 
2.25.1

