Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E11359D0C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbiHWFuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbiHWFun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:50:43 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00055.outbound.protection.outlook.com [40.107.0.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003B55EDD8;
        Mon, 22 Aug 2022 22:50:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T48SJOjbGxcMTHlFfxV1CI3vWHDvf3syW3i7P76xcIv8H0Tq4T51R2YTMSh52J7uqSFbZPE1HmNhT3j0IbEPuGzciGBaUePwkrRmvNKivsYFCOL+pMKs4L2r9enmMb4VQ8zCck6gCW4//dqIfe4ikQk07sdl76uR0NB4623ddT5MsZB6Dafpy8h/7sXQhGhc7DNh3aONmO+MV3k6MEb1wDXtrW9le/L6TuW7ZsgPRryNghVdsk64mR0tSVv+RP8s49DEp7GcmCKYAIcB/tSRCqSbQGa3/mVT2Ajulu5ofqAMt+KuZyXFi7ZsNVGkHInE+WBbe1YEz4WPAObxtDNQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Adw4CXFYsZTvhf21DlI8CGwN/V9E/1/CNTrMVORfkfA=;
 b=kWBkDMYACBx01XgEnDakdd9qhzHsZUpPTSTCC1/YKnd3mnPWBpeWxADM3Ue2YV/Rf6gZYYkiZm+59+TzzCbh/4sAHvhrKVKJwm22hrnRJ8QQgElYYyEw5p/2+a0Lv8HcBvFnYUiy2HQ9DVGJNXm6/dPdoN3devAjpyIZfaYeMZXqXRWDbbL9/RZJijTXvAaYKbqKLUq44DngJkRT3Seom3nQQyHABkcoSkFZH5kMVZ4IwgXa2gN84c9l2kIUOPlVu1zMOnZeHG9qTwMP9o4dia+KpafuiqPyXgoIwb53zn5SbpuQcd2YGL5CEPpXYEjz6axXrM804KsPKZmrDnRkWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Adw4CXFYsZTvhf21DlI8CGwN/V9E/1/CNTrMVORfkfA=;
 b=jqxhxFcAL8XJjsPmrHz0gcXtU/tOWYuu9R9oBjqxCFAiBBWvip4Bw5YzYftQwd08sX720qryIrf1lJvQQ6V9wtE0QJq1+G0HXgIgmEJOmdelLWs8DFPROVPMWpmPOusbFrwdGcWCidWZ4zwaqsWsZO/RBAw9oTboj35w0d6dRRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR0402MB3778.eurprd04.prod.outlook.com (2603:10a6:208:6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 05:50:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 05:50:36 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V8 0/6] imx: support i.MX93 SRC and mediamix blk ctrl
Date:   Tue, 23 Aug 2022 13:52:09 +0800
Message-Id: <20220823055215.1139197-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e35c5d5-09cc-4b21-734e-08da84cb666c
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3778:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCEYBy6ROkkFs4d8oCB+ICuqMeKPtKM9PvP5/2isNOPAJEKPnDM2Zct+prwjss0woMmiicKzTMlwCIxFdDyAVoggDbTPqJNnqdfUnBjVt4ypTJbHPWgRunDdgmBqhC4OZ3YeGLyOf+YnkXOYRCEL6qJX4AUFA9Tydg79Rpe1JfVIhq07vNOgSz6TF8tX6Vc+tt0yGSGDgGxEANFDbBa69N0LhtyF8XgKycF3YIEzwZhvvskt24I3GlTBbi/1XmPBqEGz8NZBBVmtYc9VZ2xJC7fwflhfrjnETluGh0kohB5/dLFAgn0fGtbQOTysdPfSIFr0QLqr+OVh+7KLvmHXnrJog7dKz+f64cQBI4Ppxt5Gi5fKQ4QkXf4B/JJjj5od/esYLgVV9Cv7FQo1pLfhPCfwMY1mVLpE+fyTk7NkL0Tp7pvBQe3BGMqC5jNtI86Np0XADzfUzaY/qyO58deJJrDYyNaSizHE+NlMiPyWr2TtUKo3DRaYABWPD/W52sJTU3IW9Z+PdpyyQyjr6eLJsMhcqXH1FkJEwKFPVM3hUXrIldXwcvEC2ovaXOfufnOZKAVjtPEzEDSBjsHbK4dLm6z8DkaRf9rJZ+hJjC+EKPswHe3ZTYdW9h+CRi4nYwVDhicUyJEqpUU16Z+zbdL1ZfOcRxtW2waf+LSVKMR5gzCagBKzThBJx73eUFEv4Mz8XDK+LPXXNAQ5qVdYnRIaLu1bFsonvlZWdzClogNW6jtdbGz3QLSX64eg1vNSLYlv0b2CAfiI9ce0uEHYyN6tTjLBhQMeirWoM85FpD8UBsc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(8936002)(2906002)(83380400001)(38350700002)(38100700002)(66946007)(316002)(66476007)(6486002)(66556008)(4326008)(478600001)(8676002)(6506007)(86362001)(26005)(6512007)(966005)(2616005)(186003)(1076003)(41300700001)(5660300002)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Xzq9eOluszNrkJPORq1thzKWvJg3zZVLyRdl7MfzciWBsAaEuXZaSb+41b0?=
 =?us-ascii?Q?3lCThBCSdkLnM8Uy4ZeB0I+2aMVqsJTAW2x6DSY9IELqjNl+A5gjA0mj8ERA?=
 =?us-ascii?Q?xBg93peP07MHkaKkLthUote8X9la6CDH1aTf/MSHkuImnfcu2d0zFOQFXa2C?=
 =?us-ascii?Q?gHVYaCfEYEXxakosRu/5wYhkEfpYHI0X4rQ8FzDKk0gI4zx8UjcmrGo0ZAks?=
 =?us-ascii?Q?ifKl8GONnBFtE8t1EKevT/OSY9r9hf3qkt+kUwGMOw7T46/DiYRHAmFdJ9v/?=
 =?us-ascii?Q?SiUgH02Lg6mCwJC8ntTSCS2/hsFQgidFL4WJ0Tm8vX6DQ9Im30H1VHy9GMVA?=
 =?us-ascii?Q?zQojaxntWCr1wUitlCA9ajVOtJR2Vj8bDuU9/4Dvviijji9DWG4FVIt6/M7K?=
 =?us-ascii?Q?Whp7BqFayRCGh1Jsm+4AOr/nnZdOteG1Kw0g3GRDXnsVRYYZoAdAzprwQ1cz?=
 =?us-ascii?Q?7H3DorfK+fRrpGlHhQf0fSePLGaXiGL0A6CqfCcywVP+LYJmbvH40oxUwFFF?=
 =?us-ascii?Q?p0kSDfg1JADhxhTFZwWBFOQwZXgHMgEpKIgbS363ySVsMYmpAjY65vleYQ8V?=
 =?us-ascii?Q?4eBW4q6uUvSXRTPCne26HqnRcUTBsJJ1RpAt2paHoAUz0wWRyx6sMjoUz5Ue?=
 =?us-ascii?Q?s6aweRPdLeJWalAC4SEVBk9pqDuYIXktzHYxvfszFHGZK5JVWoiBMbJT2LZi?=
 =?us-ascii?Q?S6Bce54QU8X8RuB4pFNSVBqirGB2/9BqeqR4gLRUptA7MOVhNoaKgX0YVLlZ?=
 =?us-ascii?Q?EcYpg/IXUkPmNGPPBhSJNQAwEXqaOtDMIfdd2hfq01RXQLze8ovVZU0Wqzyf?=
 =?us-ascii?Q?UDteYfgcYZptarxc4deTDCCjFM73LfnO8tGsOsbtGu6WxxkPePmKPGrmhfNO?=
 =?us-ascii?Q?rOlZvUvcCQ4HktpKwRPTHIsvFiexNbXo216At1k3uQ/gBBHXcON94sOa1D7w?=
 =?us-ascii?Q?ZeVxwGDqR/57texgHUXR6eABx+Ot3qmV/Ng3U+cD4R0Fio4OEp2CX0y+VSE5?=
 =?us-ascii?Q?ezkiUi6aMWuHOASh+Vhw/snyfwuKemx0GZhQgQoUNNuQscNUMaXN7NCD/hef?=
 =?us-ascii?Q?/JuUSQOxvKo06W8xzw3Ezv81hHfnj3pQwVaxf/O0m7C2TnSrmPxZvoD5g5IL?=
 =?us-ascii?Q?n1hq26+pU3cAzFLQVpgQeQOiF/CrbW0ubiUWV4L1rBxeNP2D+3KCmANRgnE/?=
 =?us-ascii?Q?/AHETpsAt36un2OaMGBodmmuaKWbFzPDDFg5JbHGdJQVkwuSinuSFfmQyWEw?=
 =?us-ascii?Q?2iMNpIHlh0k8Vv6Qfoxg35mR4dKihLKe6VXaLrG+Y5lYhTESusgkepbyDAAm?=
 =?us-ascii?Q?n0+6HfPJbzqJBUdSM2ZgqOCrh/4+Jxd0YPSGiTM6nbqSVsAn8jIyvSeE3h9y?=
 =?us-ascii?Q?cPjyH7OGGhnWHUe//6J+2/tshOYegwqUQFoPCfbuRMgBwelZwCkVealI/gx7?=
 =?us-ascii?Q?uwKC9T0ZygUWGbb6h+A2SVev3ZpyWR9hKMBzAaQR1fTCiMOdFzH3QDzjPS8n?=
 =?us-ascii?Q?8MnbMH3gs5nDN55XADMTlyOrK2COlok9Yp3aNbYe+MkVJmtpxty5s5+McpFb?=
 =?us-ascii?Q?4eNxVg6TbWPww5kW/SWSokHAOLigSBbCjDYtyAYG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e35c5d5-09cc-4b21-734e-08da84cb666c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 05:50:36.0925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNkU+EykoL7KBzssU9e8Y7DpjrOf7NKqGGZFOqId6RvGhOUOA/QR4V7P8AHrQQ4BrqIA60P9PMII6nNRD4hlAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3778
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V8:
 Fix error reported by kernel test robot

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
 drivers/soc/imx/imx93-blk-ctrl.c              | 452 ++++++++++++++++++
 drivers/soc/imx/imx93-pd.c                    | 164 +++++++
 drivers/soc/imx/imx93-src.c                   |  33 ++
 include/dt-bindings/power/fsl,imx93-power.h   |  15 +
 9 files changed, 894 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
 create mode 100644 drivers/soc/imx/imx93-blk-ctrl.c
 create mode 100644 drivers/soc/imx/imx93-pd.c
 create mode 100644 drivers/soc/imx/imx93-src.c
 create mode 100644 include/dt-bindings/power/fsl,imx93-power.h

-- 
2.37.1

