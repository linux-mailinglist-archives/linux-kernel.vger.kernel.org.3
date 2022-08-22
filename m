Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D2059BBB0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbiHVI3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbiHVI3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:29:33 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70075.outbound.protection.outlook.com [40.107.7.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3460F17078;
        Mon, 22 Aug 2022 01:29:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMD3rjzldqY976JGNQdVqJn9PQgLsC3gGOfCeu+5H31cRwkdYEDGPwasINyDWHvnU/Sqtt/90k8C9TPUmVskbwKQSy5a0mETXdMO76bMvO6Ctk3uVVE1Dhum3IxvrPjW9/sd8vEVTrwhbPyjQheGZ1695JfO+GN2g9C3yWV8bVSGGuwsIw+e0CT6itcyOQNaSk1ARnCt/DThSKOn8DhnNQOdX7Fp1bNr3sVHU/syTcfGUZ1o/8Z/3Xsmrzlad9hfkm6lAiub9J231QSaxJGd19X9imsUmX/9IEjM/HGeZU9jeZDJhBEUwAY7Rfk8dTCO/eOwasWLGMRzY1ehpSXg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4q4lHut67ntpk6nESbfLwYCqQVzOKm+pfjBt8m3W+BU=;
 b=ngG9zY5EFZnALGL8L37fBy67zZAVptOJebx4CN+0eY8Crz87+ucs+Q0G8jddoy+RV1z7xZB5TJwIHgafPxvHKXz+em51WsV+fZpx88WGOwQQbhxVSBDvrFGfEHL4SBdu9kDVUGumilmWe2TzuDXkFidjLxGx7LI5cfnOYLdeCVDZ2UioZdsuk7iG3yAe0IwwxXz+P9giarfO6wfsRwAdiuP5k6YO3Aok4ePGjE/wl3w4QWBZ6867FEGUOsa8sWlihC/RsokZPHf++jrCv0ZbCh6MyuxjbeG1lOgnnOYvNiGqnIRA9X9334kE2vDe8L+29DgGqHu5iDVm7IDFQoUAEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4q4lHut67ntpk6nESbfLwYCqQVzOKm+pfjBt8m3W+BU=;
 b=NVABCr7DEURr5efU8Rfy6pwp5DufivDWszPNgREM4sDu4ddop5VuaWLEou4cYhP+NCUwN4OI9QUdovgXm/urSF9Q0//vWw1wvvzrQ5V2PBTtkIY2pw2Bkj7l2WEhaJfTyrh1RaDfvc6bUpdkpTkYHI7uDUklbTMSzwmeM73Z8LA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6128.eurprd04.prod.outlook.com (2603:10a6:803:ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 08:29:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%6]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 08:29:28 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 0/6] imx: support i.MX93 SRC and mediamix blk ctrl
Date:   Mon, 22 Aug 2022 16:31:00 +0800
Message-Id: <20220822083106.156914-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bbb4c1c-f256-4f64-f5f3-08da84186d63
X-MS-TrafficTypeDiagnostic: VI1PR04MB6128:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IfVUg360+zo26SIipTiiy2nW/B39K02K0Y8iz9kqEWnu0X61tceYQk4LNgT7rbBrNQHdZdPjrpnC83w44PpU46magrW+RyhP9LxNGe5SoT7NDh5xgL4/LwoGB5hr72ynUaD52I5C76WNl/hUeaJUch7xxxaCemJOTOlBfnCCVNqeu3gtqrghU3q6Z81FzanPed8gajtbu6HdEDw6XUz50ZKIvrk8j4CQ7GFLxWi1zUmFeV8Yielq3Mj/Po9/HtyZRE8FoNZAnuZYKqkSnKf8sZNWh2SfwMR0IDdsoaXqhRsYMtDm6srtJ9J2PTOAv+SVPdcMaHfRQfSGGf8PwkcspEZ9jtxsGbwq1czFqty0ODoYUAfRvfbHKdOiGehJ21lMJdqsLdfTTiuIIz1fmlBXhpciKy2FsS9CNwrWuRsSTmsJ9JYCE+jynUHUnrrCCt3XmWR+HJ8xOYllmC1KurTt0KIrEqr0CjLZzl1YTS4HvCfNFsmU3ZspofhEQZIY+oNmHhjZcroK8Y2Z065dwgGKAMBpUhqDicUTtQF4jcMjHQIHZmYHuPxTeuET5x1O2YMbePwzJVGRyTiCdreV4H9NkKWaD6ZiJ17EeLwU2ZAlmWIxNFyTJSh4PyZqbHFDx6sPcHr2PoRJ3ez8wO2BTrMYTvkPxUccoXilIX5LnBf+cKULEZMtogfwtvuLyANUfO93ncchJ7Pntzga1sK2d10QLuoTjn9nyRr3cGmwUxN48dLrs+NwYrNcPuDF33DHy++lZ+rWxc+AHCenpU+73WVq8zjZpH0gNWkLcrdHLpuywkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(1076003)(186003)(83380400001)(316002)(2616005)(26005)(86362001)(52116002)(6506007)(41300700001)(6512007)(5660300002)(6666004)(38100700002)(38350700002)(966005)(6486002)(478600001)(66476007)(66946007)(4326008)(8676002)(66556008)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kzh210KKSY+tR/+qlCdZuq4SfpSrwfs1GcBIfNPRBA8LN5ERnFTvOMXn/cFd?=
 =?us-ascii?Q?VK8rJGD4IMbzjgZESlsx+xnsgWSyQMLHvL01Pmmvb4U+z2XhOVIuHlqJeTKV?=
 =?us-ascii?Q?hlzUMQbL0ppICh4XqrxzuN31pr7mGh8Fy2NSYfT6ZMp8eO0WlxXUl/+kew5X?=
 =?us-ascii?Q?ch96rPATzoLqWWY2+8qD9MUE7x0CFU5GtrQqDcl3ZFDsVKVX+iq+OQ+TjvfF?=
 =?us-ascii?Q?X3JyduIQdRSGkDjHswtnlVycnkoT4NJiSfExW+vDeUOBdmSPVyKG7LlSr8A9?=
 =?us-ascii?Q?/Vd4bQP/hEyh/M72LCXy07egeltv1lMhpc43Mm0VWjh5wtqNOfNpleySSF+A?=
 =?us-ascii?Q?ygZWKdM08F9uPPQfxYbcXtk7AFks5mJTrB20xjtjpY0e764mtdza4PCHdlOl?=
 =?us-ascii?Q?WiigCKMoGYWKyBjpG+JLuJQYWX+OvyjJeC4BEgeVAMJuUIEVe6fQHFYO1G9D?=
 =?us-ascii?Q?CwnDCGs23MZ0LnplnoHHL4a5o5BVhRldL0WfaZL0sqCfH/frHZPPBCetC2N9?=
 =?us-ascii?Q?5/NfhZ5Bv8FTvLdqA8LxPVoNhuVdmcjp8t6mMwUYwGtAHfMDY+H7moIiZOUe?=
 =?us-ascii?Q?gg4BbgqewdsOFXhIeWXupo3Tt54+r2Qmzm311JOgObcSoMUzRp+U/rsCaHCR?=
 =?us-ascii?Q?ghy3Ta52GEC/f6fZmh6VdL3FfGvfqoTJzYHw7DF5mons7q/4h9YxWol5lg72?=
 =?us-ascii?Q?7S1LFJ2flPBO+nYSmOBU0maw/yU+l6aOo114Ob3PynjIAHYJyJ426Hg1zAxF?=
 =?us-ascii?Q?t/WiKHvEEHkSTUixPt2wL51dGMLjiAapZdmVCMb/rCvPbF2N0evTpswrFB+X?=
 =?us-ascii?Q?BZWjLYP9atmQHQtJOHWu7n3KlJgmYnXoOhKdvZHqnclABm9aClPTqwOkNPq+?=
 =?us-ascii?Q?Dpqa0Qev5l9ESbZtqwj0Suvvxeq+WsOe2uhD++JBJFoRgYHoTHsOVT8aqJxE?=
 =?us-ascii?Q?ED6Jzh5yTDg1vwAbeYwdP//YLgqAH7WEUSgU9QImePtvUVtD9UpSar295boU?=
 =?us-ascii?Q?9uOqiZiRweFW4ySgQYbYSUEc38teJ0IchO9c4hGzjIPghfqO18Wrtx4GyC2P?=
 =?us-ascii?Q?4xRgT/mAWx+T0sTvtGdeCv+lYHUtW948UO3j3Ys/JTrSnn4lqHwbYGacc2BJ?=
 =?us-ascii?Q?Eh7Rs+PiZPjMFIOYrXCaQUaSMJSnUdLkgYLPlmpolbDha03ECVFDJIuSyB07?=
 =?us-ascii?Q?sqiHmqLz7AQGwfrqVP3tn3TLSbqT/UUivedkkJ366lnTNHr2Uc2IymQcKypC?=
 =?us-ascii?Q?bzZxZIKVxJbcBoUcbkQKi/7h1aUbIM4x26sML57terS5Sofo34aA0DEfavos?=
 =?us-ascii?Q?xuUAONU4h9nmQ7F9TZMi4gQdVqE59UUagDL3uqZwoXufngfrjlduMPD9v8Rm?=
 =?us-ascii?Q?J8yAhotFKum4FyUqQr3S1ihuOv7SeouwCy/FvTavO5XhNOCfVvCWTXSSQoZC?=
 =?us-ascii?Q?672PJRzZBVs0BVpB6VXdtO0ARj4PaUN64Hw8qtZuogqQOdPjBg11Q2FQRbnL?=
 =?us-ascii?Q?yFKdKE0MNPGNAHG0rurJuQdu/IEoatK0Zvbwz+N27mMSg4dHDt3ficbTpNQL?=
 =?us-ascii?Q?kDyo00Lrk0r1EsUA2wnm5E3gZtpE4FHls43zn37H?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbb4c1c-f256-4f64-f5f3-08da84186d63
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 08:29:27.9913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: so4SZnSMqhE26DwoAxanKvcmwpMGFMLNmKw8Z41fu0mSYYftMRQCn4Qa8CxiXRpYRB2kJ5cgXnKGxB0l6/VYww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6128
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V7:
 Added R-b for dt-bindings
 Addressed Shawn's comments for patch 3, 4
 Included NoC default settings in patch in patch 4
 Use regmap access table to restrict the access to blk-ctrl register in patch 4
 Update node name in patch 5, 6

V6:
 Per Rob's comments to patch 1:
  Drop the ref to power-domain.yaml
  Describe each item of reg
 Per Randy's comment, drop duplicated support in Kconfig
 Per kernel test robot, use `void __iomem *` instead `void * __iomem`
 not default select PM_GENERIC_DOMAINS for SOC_IMX9

V5:
 Update bindings for SRC, remove the slices node
   Although there are several mix-slices, mem-slices, but actually
   they should work together, so I use one node to group a mix/mem with
   dual reg entries.
 Add SRC driver to include a driver to populate subnodes of SRC node
 Restructure SRC-PD driver, because slices node dropped.
 Drop the patch to export of_clk_bulk_get_all, which is not needed.

 https://lore.kernel.org/all/20220711062452.3575032-1-peng.fan@oss.nxp.com/

V4:
 Correct including fsl,imx93-power.h, not imx93-power.h in driver

V3:
  Move src yaml to power directory.
  Update slice name to slices

V2:
  yaml fix

This patchset is to support i.MX93 SRC and mediamix blk ctrl.
SRC functions as power domain provider as i.MX8M GPC.
mediamix blk ctrl is similar with i.MX8M blk ctrl, but much simplier from
software view.

Add bindings and dts node

Peng Fan (6):
  dt-bindings: soc: add i.MX93 SRC
  dt-bindings: soc: add i.MX93 mediamix blk ctrl
  soc: imx: add i.MX93 SRC power domain driver
  soc: imx: add i.MX93 media blk ctrl driver
  arm64: dts: imx93: add src node
  arm64: dts: imx93: add mediamix blk ctrl node

 .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     |  80 ++++
 .../bindings/soc/imx/fsl,imx93-src.yaml       |  96 ++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      |  45 ++
 drivers/soc/imx/Kconfig                       |   8 +
 drivers/soc/imx/Makefile                      |   1 +
 drivers/soc/imx/imx93-blk-ctrl.c              | 451 ++++++++++++++++++
 drivers/soc/imx/imx93-pd.c                    | 164 +++++++
 drivers/soc/imx/imx93-src.c                   |  33 ++
 include/dt-bindings/power/fsl,imx93-power.h   |  15 +
 9 files changed, 893 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
 create mode 100644 drivers/soc/imx/imx93-blk-ctrl.c
 create mode 100644 drivers/soc/imx/imx93-pd.c
 create mode 100644 drivers/soc/imx/imx93-src.c
 create mode 100644 include/dt-bindings/power/fsl,imx93-power.h

-- 
2.37.1

