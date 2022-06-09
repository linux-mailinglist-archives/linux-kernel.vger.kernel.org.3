Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD102544C7A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240476AbiFIMt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbiFIMtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:49:19 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30070.outbound.protection.outlook.com [40.107.3.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8020835279;
        Thu,  9 Jun 2022 05:49:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQ0njA5jSGo+7UGQhANys9XDq6mKIj4rYo4B+Sv8KAq+WDRkpACsSOf1mbQ4y4acXZV+XuK1vL4E1I/Xf2fD54O81lIZyC8N97ZuaZy7exyoecf4W+b4pawU2tTBaNQKnCyU/a5oN1OOIAAko8OefJM7/mx1HqqjPGbMoI5TLL8llZksV/d84g1KnxOxkCVvSvyMDn6AxEk38ORjyLfk4qf1+9GC4+Vll/xaERvO0tT8GAcD+oCK8sVAhMZwsL4YcTvm3d2GXjeUCe2LCNVk8DpGaZjOiQbhyeWYSRxsW3ToGPiZfUkSOsb/gCZYgGkSeARdaD7+jkTWKT/j/yeaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FH4hP9d6aHq3hUVKYCBPs4TBfO4fIjSpodokEPv6k4w=;
 b=JCW2WVnyMq7ISEVbS87mkEe0DlgYWEH8+YqXYHI+8kWehsmqZJJl0OjRrdlcTiLOsp3yt9KsCYoxrUhOVchZEmtHazsnR1okcXUFFiSs4LTUbe14Hc5yf1SRxrqp/hstwKHXFZQv54n39SVh4XxHp/hR2smJb1ae50CTgjyCL2Z1OYrDxzeLZpPco1f6MxCrhibux2OIrjw6Tjokv8jObc/Dx/z/W0Dz1FBLtOuuMK2srDXNJF/+xjB9O8X+WsBGRkarcy3mbYJssoAAOSyr9SYuywcO752aMaO6y7IhVhJr8Ppw+WW5xwVYBeXziv26uazaIdkJ4Ezw+oVTtISepQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FH4hP9d6aHq3hUVKYCBPs4TBfO4fIjSpodokEPv6k4w=;
 b=GpVphZAftqVZVhruQGAw61QvWagR6frvKq/rBncX/DQdgaXPD3nos1Sp2JYs6GnpOmK8r7yQ1QCicFl0413JwC+rGX2hOExB8Tq0rOpMAF+2lJsfRSVxFr1dvMxYVdvkVJJAbYfw/xUpl7787OD4R3ZBNFWsK6jh0KrFTLh6FEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6952.eurprd04.prod.outlook.com (2603:10a6:20b:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 12:49:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 12:49:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 0/7] imx: support i.MX93 SRC and mediamix blk ctrl
Date:   Thu,  9 Jun 2022 20:50:53 +0800
Message-Id: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb883def-a4f3-42ea-c6f6-08da4a1675c4
X-MS-TrafficTypeDiagnostic: AM7PR04MB6952:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6952ABCAE0D9EFC51CF19B48C9A79@AM7PR04MB6952.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: apZ6jIEi0HuTH5sfrvSkoTm9bUWbecYBCeyBskgDmQ7hdldhYLeTAODuSeOSt2envTIGIfyGbv+T2ybhysCVIeL++OgBZtkFseNNbRzHyEFAy9Nny5WtJoWw5kPZJF0N3uWU4nn8X6rZzXWvzwL+0/BdDylVBWDzKFjYC6a2gKJCpyKo6XrWB/7O9fxgj2nHghb61sSiAgcWSt5qvE/7z+x72cMuy1+PMjJsCx9p3/Pgu4NMwcfu+r+EJArC/fNEKlWxvrkTVseCZ/BNBP4KdNacim1uVcTBHwTvujaOmtJPOWDCAO5MPMXXB/6UQRG1uzGGciV3DxdqnaY70Gk7uYciLcjGzjcSxU7LpKkf4GeQQ4Ch0SFD77L7fhlhrqtvlIGi9I1sIpJ4fMVOMPnMP8BZbT/GKWe0CVmXiJwMAPZjY1L2RPfzF1fGsJET8pH0zIHM7dlkSR0bUrFduqx8LYOguipMPDcxL2xwDvpwR7yRsba3uA9QqamKKkeViFxlaOzOWHcbcb96ieoPbpA9Vb/oOxw9GPy4X4IIFc5ac2UIWHYwvgm2gZKOVitUtoNJaMxSAkItIkQUVxzx/gsQFKuPw/TQXmoocIhXV388nW+m2KIV8dUJflsJfRrvyJWBohmPX9SZEF2yDACNmbNk1PQnIeLB+ws7BVosz7nolvABZ699goNpxYMVfmDw4Q2rErgS+uYGJLaSljrHp6id5nPI2keFlMQyzSS1X3LDRvSYF2aYFGqalBNr8eRVg0xx7GLQEoP8IpLrYOpqTVk70Yj7SCSHWHAmawo3+hsCRs4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6512007)(66556008)(8676002)(2906002)(4326008)(66476007)(26005)(6666004)(6506007)(38100700002)(52116002)(38350700002)(86362001)(316002)(8936002)(2616005)(508600001)(7416002)(1076003)(83380400001)(6486002)(966005)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1YANMgTDlXlulGnkCtP7h/jEvfH+pILHg83foHbiAfIHfgIk1xlyjJkqC7Zu?=
 =?us-ascii?Q?0ZaiozQVUTUUMED9XyqVYGFnzxMT6OIsCgn4PouCa3DT3+MKOnnRwixBk0dI?=
 =?us-ascii?Q?MIgwqDUJE0N1N+VknlTs+RUVAyzhcepQuCNWzZG936gWIbWF3HvK+eEz38Xl?=
 =?us-ascii?Q?wk7VlYyh+6Tgid1vs69vo+3W5KpDtAqyzxBV9BlbmBs2MDqm++n5NJ+F1oBZ?=
 =?us-ascii?Q?UZDIlLINlIsk+2AarMVSldFoiCadNAYoutQpyTOU34Ucp2R+bZohhh26rP2o?=
 =?us-ascii?Q?waeSi7FI27izjdLKnnfF0pyEZVIU7jtmFBGdZJ+kwcuziNZGm3PqY65EgyyH?=
 =?us-ascii?Q?mPFvCmiffDbF4Koe/RZYgqZw+fw6AnxJ7gnxwa5gGMtXz0ImsW7f25mjG0Ya?=
 =?us-ascii?Q?Qjjahhfm5dSwXJHNJOEBvNkA5gDJjlfcDR5e1cn1ERDLqnOJIi4XJPFkp8ey?=
 =?us-ascii?Q?Fta7aCn0S4zMH6ARbGvuskTADEAwS0/IItJrfUSb3zacS1w9VLYLtjii0rGo?=
 =?us-ascii?Q?B1GCUe9CQE7A66CkXAOnUnf+I8ERvE+Zn7dFNHUGxJsJJVcdknsGHwF4nXvV?=
 =?us-ascii?Q?3nEctAZfwnAkxd2VBI3nNPf7AhpCd5n3YteJc/KZTJIxvXXq0W3iEN5iMDan?=
 =?us-ascii?Q?BTC07X+jCPXmJqwbzYiBzqS2XpofzfpuYjojkzpO0TQUcJpT5MqrJE+7RDFi?=
 =?us-ascii?Q?nfyWOBX64JG6yAfWhKcCv5O5blBSIEdBAIIxTE69at2xoCccR2sbdLqV64ha?=
 =?us-ascii?Q?8nEcg/v2RN5xDESJkFQB8vi/2k+4yau4GMBw1769Ju22wGIpmV/zhSfu2FtE?=
 =?us-ascii?Q?141BjoyYcKmd0x/7cickJwoKwkUkU+PL0hq4Zxyg38zQ4FMUQzf07tlBT8O0?=
 =?us-ascii?Q?IE5wFbOWlwZzhmB/SpciGL0UkwUu1TAwEM82jIHMaODuapq7E906Dtnd9pqy?=
 =?us-ascii?Q?0nW8JmIi6Pdk9oHnlpqHutfHy33iJQmdFzWLVC9eW0wjKULc6xkoPkShMtqB?=
 =?us-ascii?Q?yZ6vDboK1N1yLLya4US3eQVgWQ6wTorAHp/DSxwHfnH0YkQqR2v6AM/7VqkM?=
 =?us-ascii?Q?s9U0WrkhrqGPst+pHmcf1opsPrMHWhFk44QADlOFByl6GtcMg3qimAtnb3eS?=
 =?us-ascii?Q?sDOzFwF3cNpHEXrbDOZjbowKprEkqCrN/e5jIcGU81U7IrWRz7sF5nCDBmy1?=
 =?us-ascii?Q?PLBiHMQ+ABpdoyzR4Y6zNnlGbD1/qlP5flwwUQTv0f5TgdZ80mxn/46baaZr?=
 =?us-ascii?Q?idQIVYqeYh8CPjs2An+HeT4C+oBzT/snUUxG5JAYL2hJRx011k0vb9CVFHm3?=
 =?us-ascii?Q?oGGnmokF4M17bFN87y6dHAy3cKoHHyDdCYgoYiUSZ0FVbCNGZXKd1jR/oiXa?=
 =?us-ascii?Q?IbLg9PMgAamyyKJfNKnpaVagdQM0+MNrDWJk0KwX7F16SQ9ilvInnF1CTBb2?=
 =?us-ascii?Q?6vWmqsa6OG7jsVrLfmI7FZ/6Opy+p2bOH7+8HtlerqYx0YUwjjqz44b2SAr5?=
 =?us-ascii?Q?22G2qKPu/WeidxupCq9dVUVohrCB+Au35ylEadi02aAKbj7en4Eju0ebfIrk?=
 =?us-ascii?Q?V5vGvLbGTRr+8s95+GHShuUBKvlbt9KUfIK9SxyRr9vNjR7x4zPb6iEtkiqZ?=
 =?us-ascii?Q?tiz+LwPpLdMXZuECqcGjQPHe3oinVebw+Joi7GEl8Xx41C3ueHLLa79pYAlE?=
 =?us-ascii?Q?Em807I/alnzmIHS3ePuQvyUXx/Db8eWhmvec40v9KrkmGj/NlGsdHb2RvAlp?=
 =?us-ascii?Q?5PTyMFoZvg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb883def-a4f3-42ea-c6f6-08da4a1675c4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 12:49:15.5183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0lWUtqjVFU9OH31aEfKvdCZyJmP7T0NOuQe7gv11hTZmJau8elb32mEiNnMd1eG8pXF3r93EalqUtKNxCjySQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6952
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

Export of_clk_bulk_get_all for driver usage.

Add bindings and dts node

Based on:
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20220510124050.398891-1-peng.fan@oss.nxp.com/

Peng Fan (7):
  dt-bindings: soc: add i.MX93 SRC
  dt-bindings: soc: add i.MX93 mediamix blk ctrl
  clk: export of_clk_bulk_get_all
  soc: imx: add i.MX93 SRC power domain driver
  soc: imx: add i.MX93 media blk ctrl driver
  arm64: dts: imx93: add src node
  arm64: dts: imx93: add mediamix blk ctrl node

 .../bindings/power/fsl,imx93-src.yaml         |  96 +++++
 .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     |  80 +++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      |  38 ++
 drivers/clk/clk-bulk.c                        |   3 +-
 drivers/soc/imx/Kconfig                       |  10 +
 drivers/soc/imx/Makefile                      |   1 +
 drivers/soc/imx/imx93-blk-ctrl.c              | 333 ++++++++++++++++++
 drivers/soc/imx/imx93-pd.c                    | 271 ++++++++++++++
 include/dt-bindings/power/fsl,imx93-power.h   |  17 +
 include/linux/clk.h                           |   2 +
 10 files changed, 850 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
 create mode 100644 drivers/soc/imx/imx93-blk-ctrl.c
 create mode 100644 drivers/soc/imx/imx93-pd.c
 create mode 100644 include/dt-bindings/power/fsl,imx93-power.h

-- 
2.25.1

