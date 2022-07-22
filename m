Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC2D57E1B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiGVM4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbiGVMz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:55:58 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7F42F64B;
        Fri, 22 Jul 2022 05:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kyl7+juxGVa/s68CuatURz90KqGAUUsnw9fYKlsTuek5d/EpvSyhNnXHK2re5HJSwO+zYTYZNiS06Pqmuzc65kk0UT+4TMhjptBnAOwWBXKNiGtf2FoceOISsszNRTSDil95hSgxDD14Jl6AE2wPY35FUQFOiIcxJY52l98Kczrs7ZmWN840+kc27OFARv6HQ/RO1rQdeRr+4iobIonqOm3ffCE1JvJQXyBZdoVp0QH6/jAUwQd+OUoUAWpSATPR1L5XuokowUvPGzA4euvG9VQXfUsHyS27J4i/qvmoePzsh6Wmds56qlAnUoaH7seRkxetneONQbIK/1EQwjwkUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOvcoiujRM4YGHcQ90XgT4lan8H5hGbdTmpsWHJ7H1I=;
 b=Ck9jT/7SZtiiuUoUTR3m5OcZTX1KVNKdTNMU8KYNNBheX2l2Kvm7Wq6xeltT82TeDJHAGUOrNumYy/QYLmEE2GLVblMTtCi0b2Kqa/GxqHJV7lUqETDIpdVZeP7iOS91Un6gQ1Fas6zR+xcK68kJX9U8k68fzleHCXZA56adEDKOchOFCceQZG69hftB8ZJQ/3CEYQc3Wq1Q4H9HlIS1Rb4nMEVgVnFSHuUufnw4LGBCyoJ0/AgT+R6P+HH+IpaErZANoDwJbz7fqHjhxZu2qlwyDZ+SubuAkq/Kfwg+njuaR4gW07mmZZQKX1ZYvUJLouG9O43XMc0jFWvvuSYUYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOvcoiujRM4YGHcQ90XgT4lan8H5hGbdTmpsWHJ7H1I=;
 b=kXZcfV955r2hhig1gvmEY+WZiaDj1YOQdEDOk8gx+jc2uT8hgl6cSvLWKIE9RT3TFaSczDVuM0BM5Hz2HoWs9v8OrXK0DOeKXKFO1S04DrcNAPcEPEMZCnscM1Yjx5alhOK49u4lP8hT1Aeu9NoKGJ1gh14vCzux/DpZnuYOXOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7633.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 12:55:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 12:55:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 0/8] imx: add i.MX8MP hdmi blk ctrl hdcp/hrv and vpu blk ctrl
Date:   Fri, 22 Jul 2022 20:57:22 +0800
Message-Id: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b93f099a-f67c-4474-99cb-08da6be18319
X-MS-TrafficTypeDiagnostic: AM9PR04MB7633:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WjShz8heN5LexKitSSZ2msj2+jmBoeKVN0uGH7SlYiR0l7RoL1gaWilzjMNh0P6/QA7rmP2/wosxp0VEilLCvd1ZDBUr5Z3czzyEy7lRG5wJPJeIb7ALVXlvNCaULA0VylHsvEKQMAKeDipCDZpwDsYRRIAHKZ0tt786AWJnj3bnC0Rn7sxI4poiRC13NyZNylV9b46JafkuwBv2Kskk0+DBVNjYzglS7qg4hPtagBavK6kKwfyd/5+FQn5zx+h31ZOMGwXraVitox6jAbdPKuEv6FHrCkPNh+CHAyKy4acngARbIODAIw6sSTUs5QUmktWNnotXLaaHCq+odS/V9uy2+JaEk7QF4kdT55+ed+WqkksqUAKEOxW0+TEV6Q3/ECwdYA72NsGExJUAwM3JsKWy61yN7fXtWPksVC1q8Lf03dcuX1qIfKNDY2G3sAeWMFxBM6H1iE7o/G68RS5t/OPQFwfHqUoZ+HvrqpHy5GXuD67RHedrmMTJTtVMd7BGqUR2umVOulIR3/I3huj+T1SVlfHodify6baODj65XSdgxYagyZMBokFm5NJNKT20Lhu0gR/st/UQu95F9LPyNglG7WdNOBwUoJFQi6aY/+oZz2YJJrov9221GUPvvOe1oUjV5wShmJAHlg3mCyY+rbzxANHn0Ii6iEhGbwWmvproArZ+eVX+8i4IeICDADSDC9EPVKjtNwrfS2jOBDth3AuTeXcPO9INQE9oM01O28lfb1xpPVacybjMImKAvCW3LxjuKnYnwrZcBoLR3AF5+dC8Mahj826ZtNRT1BdaADutyOh6icQyslO7EKEE+QPJurwTapOYjfsSoEG53kQxImDN8W5BAKvAshLoTxiMUx4BhLD3cZc2/TMg+Up5T+r1hq+CIWKSad7DPyTuMGdvJ75PpIYekjSBBntju9mkr8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(66556008)(5660300002)(8676002)(66946007)(66476007)(6506007)(26005)(4326008)(8936002)(52116002)(186003)(83380400001)(7416002)(41300700001)(86362001)(6666004)(966005)(2906002)(6512007)(38350700002)(6486002)(38100700002)(478600001)(316002)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1UH83cfrzkqLP52Ysk/0fufk5hPEl+7rsVOKIzJ2GvixO6IoRgMs6vkczgu1?=
 =?us-ascii?Q?pP2LcaGU34g/LOer95YwpzMv1zCUt5TTsw+O739AGA0D/Uojlj/LkNwzaYpc?=
 =?us-ascii?Q?9Whp/tXZoWSO8W6n6Z1LPTjHesXXyXq/B97TI6eyj0dSL1pLTwnFbUsh2I6C?=
 =?us-ascii?Q?5mop5ojgZWK6AZzLiySG3yLtZCAxAKDHAa5/uWL0rpTvxX0Ws6n0XLCq9yEb?=
 =?us-ascii?Q?sgM1e+jfjZASrQopg0gg5bSAQJkxTRnfW8NcMnshjQlLNkmQNyRDwOYrszBv?=
 =?us-ascii?Q?S52LKxs84DjM0CWFLQJlMZfGs7/Povjjt9iids0uRiNmerruBMt76OQiAUrY?=
 =?us-ascii?Q?EeNBYkMU3L9wpEa4v3w5nnJZRV/hl9gKuI/Uhsc4ne/HvccNC3BqgcabYZtp?=
 =?us-ascii?Q?61tDZWzIbnlLYt4nPeI5otDaHP0IkDTtVKU4s5VX3Fod3l/SFiBPPDMz/ocL?=
 =?us-ascii?Q?6cOides+2CGkuggAGhZ3srFkO3rE4ddeTeGkktZNBIBwErufYFG7o3SfhEWQ?=
 =?us-ascii?Q?XHBnHzfPmh3JjX+M7AFI9rnAWk82LeJZQSCdwGLQUma0rRZDt3Yuhj4oW7jv?=
 =?us-ascii?Q?f6qmVzylLzPUiaVnMfc1Fu9HBsbWJPU3HuQHZu8v1UZutLJd3wHByoIN3o+3?=
 =?us-ascii?Q?HLhybJIb47gvLXC38bglPfx7oFj3gPSdxKP6bXLKCRnF88kzPbZlzxK16gG1?=
 =?us-ascii?Q?jzzHe8EGgIBztK6BkbDViThg/Q5c+jq/mgQMynviIC52sUBEUdevc3JFurUZ?=
 =?us-ascii?Q?bxiZKgthVRdMzIuvWkOfS6CefObdfOZzMx0wkQVV3OeJ0Z5tTigYsVV8IagU?=
 =?us-ascii?Q?MtpMT/wFZfCODWvxN17TSQqrGysZ3078NgzF4aItnyAy6su5VH9H6HY7X72E?=
 =?us-ascii?Q?7meJRJl28pQk+iCa2AfgZpoX0shO/tfTrMvkWCali46C14jYLeQAVnt0lOrF?=
 =?us-ascii?Q?8V7JabbHRxiCMOVcey7GQEpqsWvb1fPvadjBNNXnxNTCgtugtGJ78rHqtnCH?=
 =?us-ascii?Q?/SE26+foofAW43GBCeObCVV0dmunQSzPJMuGX4KtLJin95pN0oZxW0qjnPms?=
 =?us-ascii?Q?aTd5Nas1OOI0xS0goXLxqxMJCiWpHxKmx8JT7j/JjEs2PwdgF1EVZp9/AUFR?=
 =?us-ascii?Q?kTBFDyVge7OKD0pIqI6kRQojWIrBC1SM+jf+St3q6nE6rX1Tuuw2efHv5A2t?=
 =?us-ascii?Q?j6faWfK35JVeQfk2qwttqZ/HApdp13HUobtqEB6H10gqyaSdC0haSX5ONFSs?=
 =?us-ascii?Q?DtQNqofTzr7loDC/ubbhePKswJWciX1IjpF+1mZLaVe1IVMGrRGBPkBg2oSB?=
 =?us-ascii?Q?b5dTU3elYYbpvcYiASg4McLwCgLvq6VmjVIrRbqH00xXSu2Ei21poMkiM1cF?=
 =?us-ascii?Q?hKvIFSnqzi/j9vtHSpzVuMppA/lhIgZxA13hB2QXP8US7w/xQmnMTqX7o+PR?=
 =?us-ascii?Q?XtFHj5nOB8S0s4LK5kE9nZCMlfByD5L9NyFA5nx3V6MhYmxyyVMqH1cF3NsQ?=
 =?us-ascii?Q?lk/oLC6SBzN2vRlHeFQFdkbOkTlqLDLn9r6iMiePH218PIyT5n1IgxxWvZzM?=
 =?us-ascii?Q?ZyMuqLvg1IfpaQfi9Ml0GNeH1E8CZGEVYHHQvKi2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93f099a-f67c-4474-99cb-08da6be18319
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 12:55:54.1246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfFoEwT1b9fLwy3SyheClXhVSIZPRkgmNo/21b7hGzO0s8b89FlqLmK94vSS9J1JkR3irXdsX6+rc31qa7Nveg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7633
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V4:
 Add R-b for patch 2
 Add a new patch 3 to introduce interconnect property for i.MX8MM VPU blk ctrl,
 same to other properties, i.MX8MM/P could use their own names in patch 4

V3:
 Per DT maitainer, add a new patch to clean up minItems, see patch 2

V2:
 - Add A-b from DT maintainer for patch 1
 - Per DT maintainer, I added description for items. To
 make it consistent, I also added description to i.MX8MM.
 - Per Adam, change VPU H1/h1 to VC8000E/vc8000e in the patchset.

This patchset is to add more blk ctrl support for i.MX8MP
 - Add HDMI HDCP/HRV BLK CTRL support
 - Add VPU BLK CTRL support
 - Add PGC VPU node which supplies power domain for VPU BLK
This patchset is based on:
https://lore.kernel.org/all/20220708085632.1918323-1-peng.fan@oss.nxp.com/

repo: https://github.com/MrVan/linux/tree/imx8mp-blk-ctrl

Peng Fan (8):
  dt-bindings: power: imx8mp-power: add HDMI HDCP/HRV
  dt-bindings: soc: imx: drop minItems for i.MX8MM vpu blk ctrl
  dt-bindings: soc: imx: add interconnect property for i.MX8MM vpu blk
    ctrl
  dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
  soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV
  soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl
  arm64: dts: imx8mp: add vpu pgc nodes
  arm64: dts: imx8mp: add VPU blk ctrl node

 .../soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml      | 110 ++++++++++++++++--
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  45 +++++++
 drivers/soc/imx/imx8m-blk-ctrl.c              |  43 +++++++
 drivers/soc/imx/imx8mp-blk-ctrl.c             |  30 +++++
 include/dt-bindings/power/imx8mp-power.h      |   6 +
 5 files changed, 223 insertions(+), 11 deletions(-)

-- 
2.25.1

