Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E673C56B4DB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbiGHIy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbiGHIy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:54:57 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10088.outbound.protection.outlook.com [40.107.1.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E9C7358A;
        Fri,  8 Jul 2022 01:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byipbMwcn3z9R8RUGtNXhScYF8hY2pjXK9A0fT8tQ+Qa2oQEU2BVZxHOTpuUXv5ziOV5FuOFWaKgP/Y0iZ8t08swoF1iEISzdXhxHBDug0i2KdK2xxtRjTE8VXfX8OfmX1rL8xzNABJFs7Sw14WdKSa3jk2RcfdPOd4pjF8hFSYEvsMs52lfEbUV8Y6zE2bV7/MKJgjtHRjaL0N6FE8EDGCFc8NYL2rGuJ8WYpxYQ6VJKsfhAU2VTx6AU85VcIevpi2SzhRYS7GDJqfrpjwXWmeHcuZf1XPsSZRJBOPon3z9zyC+d8xNQuRodhLJD+skIBusy5kgVFGLYkzkTBaY+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEDy8b1A0VTbNWgDP+hM8uVjtU2Hh5ztr4g8wJ1afzM=;
 b=YgqVmFgd5c0lq8+GLaqwQJ9HHJG8mLrsDml8FLeG2j65P26uWtUuMLGeKmDjJhxiC9GDH3d9GTo9NFeZwNYBSntou22MVGcuoqMC446TONW414B/kZ2WEPcVhb7L46PG7Wxc8/pcIG0ymJlNPGKE59uz8KWrKkgtZl4QsX8WnDEsbARAcVljcSPQyL0uu1v3TRwf4Y4LkwNBuB9mXSs8RxH6ez6TEzIoM0fb72A0+nJpld8sweUp+kAg0yKuQP/eIhiPkECKshKUTtfCoXeZ4SkoZyMSHPaLE/JkrdWvZ6J51H2VAPmlm4ewa8UdgqVLd/0j+ZPNW9QQ9XFQaXx+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEDy8b1A0VTbNWgDP+hM8uVjtU2Hh5ztr4g8wJ1afzM=;
 b=hg8UpGsycij+HVxK92rFoCPr1uIQ4S+TeTqFISZfalJWyLTGJgwt82c48fE7JtJW3Zsa7SsaWpeV/qFI8Z93ITAi+frdvJHaO6XJj1kfSn73XjEA3vfNrdx9jUNklNL85pwpyJNL0QVyd/0RwmQaAHU8SUeEOSijvzlWUYZkaeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6503.eurprd04.prod.outlook.com (2603:10a6:20b:ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19; Fri, 8 Jul
 2022 08:54:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 08:54:52 +0000
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
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 0/7] imx: blk-ctrl: Add interconnect for i.MX8MP
Date:   Fri,  8 Jul 2022 16:56:25 +0800
Message-Id: <20220708085632.1918323-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::14)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7df27ff-f30a-45f4-2962-08da60bf85a1
X-MS-TrafficTypeDiagnostic: AM6PR04MB6503:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0spGK0R1uxxHT3j2QGZcn8nsxTSUpL6/Eh3bXmU6K3ksYw/Q05Rpr5pxJ5qo6BXxCriPkTn4HoHZfMJuo+RKjZGSilTSDvBnj95JwCWOKfiWe4J3wdnh01EXfzFzg0TKNaIr2SXIqB8xdm6lEmIi9t0FAmjPE16AwEjdys2jwjkoBVlYOsBiJ5xFnWnyoQuk0cf6uMdg1fscFsFscFdbs3sOh7RkHVpRDNIR5zFQgiTzrX+qtf+zK5CBAuwHCRCtd8NgPKSIsuK8UskmPPwE/aeTMT7YBK7Nd6D7eei6YBOf3lHOutVKbc4lQWqWX3dBazNXlWmNK/TjEj/T1MwEtBg+I7ROP7K6m8c6xOMVpjf9tA+Vr0ByTi1vxTdwfomde9ueIA2jdLELSF3CZXDkqWctLJFVvLgNcBz9i0eJaDfOgRIvjzSSuGh2Z+OW5IHhhbXMG3n5WIkKLn9A8piB2sTYVkyo+XZPhKKFgBamMmmaTfJcqrHyZCY8cOmCk2/o8vnYLfeKZO9pk+eA9UbS6QNkz0Klk4o5o080VLmTxxUMdzeJ+et/agQ1RNgo+d13Pi/8lKIFbEIk2Yi0160rvBAiOradtILttL/rKiOqsjWJ8lI1ryJTYd2g4D9GSdrPXpQVSckXHn0sMqZqb3mVS3oIE7xr8QBqEw+4+jCQl4E4xFj68jXtFV6OIu3RGmG4tDXa2jRmnBOqmxAY+jLpdqu4+Xbc1PRSLEJv9z3OLcJCzvK+WMxFWW3SXXk2FAwHFhKfAAiUnZEGGNxY8V1F973YWXZsZPc4zV7F9aSDIdbO60zWU1LR2MsNkUSiPvP/28aZaqYjdKcZyOT2a1n/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(66556008)(66476007)(186003)(66946007)(2616005)(8936002)(1076003)(7416002)(4326008)(8676002)(5660300002)(6512007)(52116002)(478600001)(2906002)(38350700002)(38100700002)(6506007)(26005)(6666004)(41300700001)(921005)(6486002)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bf1P3WwbzU3VuKCnOhhoUDdIeFV259y1k7uK0n2EOwqPseh/T/sltsZy/MDa?=
 =?us-ascii?Q?01ODcw2/JLDpX4J16dF01GkJoxXQ+rT+MO5F+cjrp03v8ql6J5Xl2KDRV+qV?=
 =?us-ascii?Q?al0lwkopgl5sKcUtT+LbTcJgKtsVB4dzokXrmAxds5dNd6YDFfkGdx0IvH1V?=
 =?us-ascii?Q?t9AJRkmKXro3amzODOp9UzE/+eth4L9jhRQJQEecDoMUzLdbSa9l5OCJpbiM?=
 =?us-ascii?Q?2FH1D+0ijt5dy8QrG1nCmdR+P0UdOxFfVyCeyUqSZg46/VEPClbn80Yhd8mV?=
 =?us-ascii?Q?1ul/ETi1CP17Yw2noB+HmTGbOpv1U94fN6TLSUHogUOZP6Jhjp41khrP9nll?=
 =?us-ascii?Q?+uryG3UzCJCWIFvYzJeH/vnbisZXjmluT2mbYgmJw6fK5Ynv7M/WTJLyQba0?=
 =?us-ascii?Q?lwjbtjx/fpcM2lux4805Bq+j9UHnCMqqqei+mkFoCM1WhYe45mi3iJUlo5oi?=
 =?us-ascii?Q?X4jH/hX+YOTfwXKPVBP1/qvpWxVkqFKyEryyVtvtcGXDS1XxiFpTvMDCBxd8?=
 =?us-ascii?Q?mw1NvFkXbtrVMJoCKiPCFTDHIO/jHfyeeZe6w5hj4mAWP4iewyeh66I+NDI0?=
 =?us-ascii?Q?0S8EaAaJKq95mJWGq3fF72pGSwsQMc2reG8DpYVmBlafBQcmE9HL/KljfD+c?=
 =?us-ascii?Q?eOJhTTsiiyuiyfNwnJHpj5i2ii4FsjB7gW+MPJCL4Y4GAXBg4NcK9X8u7jdu?=
 =?us-ascii?Q?DiYVjHmLqj3+enp6iSwoupgOSVX3OCCrGhSeoX1iH8PvVjlDvsOTggxx51uL?=
 =?us-ascii?Q?b0HSnqNLNd2fcnLCD05JfO9ZGwFe8J/Nq1J3kLVujMx03wfrG8FAUhrUhdfU?=
 =?us-ascii?Q?4M6r18Yxw49kIP2i9dB7wCklsAFGvTHq2DNIB7QmUAtfmCkzFptJlmYder3t?=
 =?us-ascii?Q?jLqGcJRAeJdENiiCfuzKHn0aDgYI4Avs9/zwXADpFaCSqm42T1OUexT3AlUo?=
 =?us-ascii?Q?CgpwTHdSCNMo+qI3QKQqJylSJC2gxtlF06dBkD17uBQLNM4JOfjHhp3RFGMx?=
 =?us-ascii?Q?lfsmbAG6dnCANniB7sTnhSkmKk9i/vBnaNlpyjqiytmkM7zYUXRz4yo/xM7S?=
 =?us-ascii?Q?ZkJ6eo6LAlh2uP2DGi80WZdgFsFfbBOsdqZfMDBe34Jq41YfNwCFm6IGEq2m?=
 =?us-ascii?Q?0rP91DLCkOob6zSRsB0kmosyf69Nn4a3KWM+DSBzLPs74e0WAPfey8pse+2S?=
 =?us-ascii?Q?X8NJsNLf1KLzGiRpKAIf/lXIOLMZIsp2CrxHQyOWYTe70FUtGUSY9XmbgcU4?=
 =?us-ascii?Q?wsvXG/JzYfwpAPtGrJcL6+Y/d6Yk7GtbyDPrbsRgQLQ64i6IZFnYZCkz7C8u?=
 =?us-ascii?Q?rUCJobi22VCHv0/8hFNenKOWGol8Ac/nkMUUMQ0FqqYck0ssG7kXEbLWwHNx?=
 =?us-ascii?Q?DclzCOLyazgXf2tFcIYvkMI52RGZ110AboQtBO5xgGczgPd+dqC/bgsfWnB8?=
 =?us-ascii?Q?NDpWrMHQViowXjnJyY7HgBUH2Qfpb7nfgfqZZdGvULmyQkpvaCO+P8EkN+h6?=
 =?us-ascii?Q?FbSv1X+Qcm+kAFhR01/NeFwe0SPK0zrxlXhgegFMtSMm/R+73dfYSXGD+8tf?=
 =?us-ascii?Q?nZBzacmWke7DOUvt1QBAANyraW3MmT4xiABElnir?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7df27ff-f30a-45f4-2962-08da60bf85a1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 08:54:52.6891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1t4WqGAseUuy77/X8VXAE5H0NRVVfpv5F+z/Dob4NIemRmNkfTmdvLAr6DG7/9qbhz303urukluQib8YN4Cw/g==
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

V4:
 Because the header is not included when adding NoC node, the fsl,imx8mp.h
 needs be included in this patchset. So include it in patch 6

V3:
 Move adding NoC node patch to i.MX8MP ICC driver patchset
 Per Lucas's comments, warn once when icc bulk get not return probe defer and continue.

V2:
 Use a low bandwidth value instead INT_MAX
 Minor fix to move fsl,imx8mp.h out to dts patch, not driver patch
 Add A-b tag from DT maintainer

i.MX8MP NoC settings is invalid after related power domain up. So
need to set valid values after power domain up.

This patchset is to bind interconnect for each entry in blk ctrl.

This patchset is not include DVFS DDRC feature.

Peng Fan (7):
  dt-bindings: soc: imx: add interconnect property for i.MX8MP media blk
    ctrl
  dt-bindings: soc: imx: add interconnect property for i.MX8MP hdmi blk
    ctrl
  dt-bindings: soc: imx: add interconnect property for i.MX8MP hsio blk
    ctrl
  soc: imx: add icc paths for i.MX8MP media blk ctrl
  soc: imx: add icc paths for i.MX8MP hsio/hdmi blk ctrl
  arm64: dts: imx8mp: add interconnects for media blk ctrl
  arm64: dts: imx8mp: add interconnect for hsio blk ctrl

 .../soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml     |  9 +++++
 .../soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml     | 10 +++++
 .../soc/imx/fsl,imx8mp-media-blk-ctrl.yaml    | 14 +++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 18 +++++++++
 drivers/soc/imx/imx8m-blk-ctrl.c              | 39 +++++++++++++++++++
 drivers/soc/imx/imx8mp-blk-ctrl.c             | 35 +++++++++++++++++
 6 files changed, 125 insertions(+)

-- 
2.25.1

