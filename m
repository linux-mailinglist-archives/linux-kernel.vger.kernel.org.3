Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BB153DF7E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 03:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352045AbiFFBsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 21:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiFFBss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 21:48:48 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD6227FED;
        Sun,  5 Jun 2022 18:48:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5sLrUA0xazRVPfMbkwMoy6VexmB+IU/qZK+qTgxoimXWyX657QoDCUTsw7AVjeZBLQUiWAm3CcD455ExInRuR26bLNt2OmECp6T/W0of06mGGgyJDdKQpur0W8+5GpCVcjCCPZrvPf0/xwDOXFc4ngnZfX/X+VgW9YwAXp+PYFTSPB/3w27n95uNyFMXlgM54G2aoKSbTQtP4+cCXLXdZmrh2RzFmgouGoTJAzKqR0RLWtmGvmWPlHocyYzndlg01pLegiiPEmYpX5YJROOc/9TpcQBKWmk4No9UxMRmsoN/LMK1iIZIpJP9tAJpFZAATJbaBhdJYtFSKQak8PKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FBeCKUr01tU3IwzEjk36SymVZEx3jf0/fCfXMoOCz4=;
 b=lVh9dI2MmBEjs9vH9uTrK8uL4DiDWEKGD0qytQp7c2i47s1PvDRkQD1vYFqBZ5N9pI/uXMUoJt1c2Q21KmESrZX0bDD5g4A2eLTm3KPIuNZH4pLRk3G0T/0s0kFPDjDJ7Tx7Bev1LNDvB6fpVaVJlJ1BTI0tAP3Z9Nr3ps+EW3nLwgP3JkLU9p/SibUbNQ3UT9YPMaNHF3cI+sVEYNoH8332EsS/lNW1b37QIAh82pltxv9rby+g40seIeKXEhKI67PgDlgBFWCE4Pw4oju8+c0/OfQzJSGjHVZq1F8Cct3dGPUCKXTbsRzqf9Lz1v2bEKZUrTQap2zKR1p+AlZXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FBeCKUr01tU3IwzEjk36SymVZEx3jf0/fCfXMoOCz4=;
 b=KtegU5bvxuOTO5gA5tFjdNmCJKn/F4mstQHNcEOsjUN3O7AuvCWmSMtxz0wI39FYwzWYpvLSk03Uccn4HWVdcM6zAM8xZ+kbRn1xOsWu+esJ9WD0Q4jofsXJUg1EX61+y8ginhKi9CYZuTpZo7XeNBzy6qBMd736cQy26pd6jec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM6PR04MB4840.eurprd04.prod.outlook.com (2603:10a6:20b:11::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 01:48:42 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::f9cf:2b4f:f903:fd63]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::f9cf:2b4f:f903:fd63%4]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 01:48:42 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/7] imx: support i.MX93 SRC and mediamix blk ctrl
Date:   Mon,  6 Jun 2022 09:50:18 +0800
Message-Id: <20220606015025.180840-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e4461e4-62ca-4bad-677d-08da475eaf0f
X-MS-TrafficTypeDiagnostic: AM6PR04MB4840:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4840D14837925525C256FEB5C9A29@AM6PR04MB4840.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 85wrioCZ8dQhv7L5gM5cPzrx5ABI+EbPEhP2TveJl0FaW939PuPvuo/qR8B5EQuNJhHq1R0oHcqRqq7cSfQhpX6XGOubLuXhxt5CY2YbqsJkdNOtV/Rha/lFGzK6UhjMinhExYsoUAULF9/4dzfphkNL3sR4G5V8jBe9F9cMdHZxkfR4GhJG6N9jtMH9OyglGCIdLDU+YKhnyM8e6LxbuJ2tjcsCCdfVkQwMfHaHy7cMAYA0xI4T4cQvt3K7SUSCSdmoyc3uVOvqjxw2oJivH+hBa8YuJ9BKu2eoRemmMoOdybvesQ7WSWBTEtLXtAi7A77c3OrlyrvOmyqc/HUHSL82Tptn0InMoVza4hvkWbtHnzM32OvtaE2M8ho1a19ubb+RwzlJ4GAjE6VzBDpTg9qznKN0rT3yN8pR0CpdG9raqlggu4prjIcsZ8vtyWlrNruwd+r3o6xx6cL2ztxSiUyyUPfhTRsn1LEJuZGeoun91yBnzqygc1TAgX5xhqGsmlxKmIlYMn98xFWB/3gU8K+lSeXKpXjI40OL6t5n0V1g9BDC2hqfXY1BFh+BphlgBA2oV7Hkwwiuc3UPXKujNaTpVvRAvrRKmWdR3i5yCTIct2C1vNb2jf+TvUPxddXpRLfyhvsZolvdLQ+tsyP7BPhGYwW17vWKhfGME8YDKriD2Y3beADyjinLhLF11WPwlLtPGVnLNjuNoTwvX/47Dv+zefCIiFHkQZ89Dj0amDmbZB5CoETOQ6gFoDtQz7VbIHyChYS4NyrzgKfsbwrRbT0uvW7adeifKY/EZ+Vr0oM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(8936002)(66946007)(7416002)(66476007)(66556008)(5660300002)(2906002)(8676002)(186003)(316002)(26005)(83380400001)(1076003)(6512007)(508600001)(38100700002)(38350700002)(6506007)(6486002)(52116002)(86362001)(4326008)(966005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W9LWSgCttLMlo0Zf6/xX/jNcA1+MxQIvQzp6LSq7u0Ox4nBf5UqcVMea39IY?=
 =?us-ascii?Q?9GOGnYDC42pUwenB01jSHRgjL4CkFxoSokxH9SKEVHYVpuYJJWIqmYyzfo8h?=
 =?us-ascii?Q?FOf/kyGbACt9xhBoeplsRQIeRwUwWC5MlR2H3NwtQm8UGAnies9Md8a0BGyo?=
 =?us-ascii?Q?fzok89268w+0R6SVefXBd6jGyTUeOclToSGGoEulLeMVlxq7u3ZTulqH7Vs4?=
 =?us-ascii?Q?J2vegeyw8rHUJ3o4aW58RNvnLLz4eTte+KPAL5hKV/YkejfHbjZ/0kwqcLzF?=
 =?us-ascii?Q?/sB96VfMGUM3jRMmTwRSTCyRcbYoTx7OxltoUYyf7co54zVlp7OTSBUxCVs+?=
 =?us-ascii?Q?8VSsPB5edAmQLYxGognn7b3Or/ah3kcGa/sc2uC/okaELO06uanr7G2mb/cJ?=
 =?us-ascii?Q?a/ELYySw1ryh01+5dHwQ0VyOeWiTDIv3RjbOJ66KAnblf6ugafGk5N80JU8C?=
 =?us-ascii?Q?hoouOyv8iWIaNOATrtLZ79xu5+q8jz+tgmzP34MGDpB9CC8yZwF+5/S2NY1P?=
 =?us-ascii?Q?Z1Wv9np3PY8kEIrVQtNybfMhuvK3qHbV+uXtCsbxNWqo8BUuf5nc7ieBXd+q?=
 =?us-ascii?Q?cC+UeRb5DRLqzHV52odnALIfKan978rOJ8iPGjcuLpT54ZsYXL0D4361Asa7?=
 =?us-ascii?Q?0BhQhRgs6b5saDEsl0sMiYEjEJXU3MizNTw+YY/01bBypuDIKAC5iEApJrVb?=
 =?us-ascii?Q?3hTfEnrWthfJn/5UyJwobuVTNzicl6xxGrnMoroCEkdGqdS8AdaE2TYkwIP5?=
 =?us-ascii?Q?O/Gz1rpE/x1SAt5rLJkcktqqB5ylKqcBGoHIgPXpSRwz+SfVCjdlXoiUoOTG?=
 =?us-ascii?Q?NrUKJ6Wq1iTJJuyF15J4JtlinnEFZRMtPVXEJWwVFxZfrllOFMUwlKRt8xaX?=
 =?us-ascii?Q?M8z2u6YWscnPtBA77VJvT/BzoD/HWEgoDFbG5NilfuS1lp3mrnR2uPsfxyY8?=
 =?us-ascii?Q?3HWFZItAOTJx04jC4L2K1PFvQsS6h+w6raFbfT5qkI4fjtCQ1DKBN9fjO+75?=
 =?us-ascii?Q?d31ZF98o/3ft/4rVy+J+dsj+LMf0LVM8P7saKeBxP2mXsswORt6t2sexL6B/?=
 =?us-ascii?Q?Lzvuk4t+v21Q2ATxN0n5fwbbu/IXxh4EWhjQEGozQDETlWuvd6XVqzOdzDeM?=
 =?us-ascii?Q?T8qEtz+51Rsxe0wrSD3LEjuoibFd7Rkb+07NM3WCgE6G7tyw8RAtv4f14wcY?=
 =?us-ascii?Q?aR57K5PJ4tjsqnTZp6F9y5wq5v49vJCr3680WX3pr9gtqW+Hy7LyyEvbHCnc?=
 =?us-ascii?Q?MU2OBxmq69eRRu4BPvXap4yV0h3zlFTbPKwfRdJXOqGJ/gGm7T9w9onKciEX?=
 =?us-ascii?Q?r6lR8BwdHvy5ubX/B1QLKBSe1ZL+lrI2P8d8s+oNpmJ8hXAKOukY8yfOoYR2?=
 =?us-ascii?Q?kvruMvoKnDxd6ReLeG8XMjDPFihm8bzjDvTc6MFzzQ1uvoqI6klc/PY/Z8Jo?=
 =?us-ascii?Q?2ff26l06sP1a93uHSJ95K5lL4cnvK8vHV/z2+ByBL0p8/Z7U0yIaJM4hZDBo?=
 =?us-ascii?Q?EvQFMYQcAhEb72CIYLXZgxeUc/qYqPKHQG7jBc2jcLC4AB0N/VVk3kstfPtH?=
 =?us-ascii?Q?i6CuRxRu0S4nEhn5RuqHzQiWgMUTKW+/0t9iRh5ZKGgm9VEP0V6mur+07iW5?=
 =?us-ascii?Q?rk6X788EthJnZ+pJJg7Hva3FpVEt0UeercibKTTwhOpj1b6bUGrVhwPnD2I/?=
 =?us-ascii?Q?ZGgQkjF+LjQ30Hty1+vPkVq7CILtUHyjEypsz7tcFKqMmWkoRKE2UfwkKZPK?=
 =?us-ascii?Q?t0W18Hz6Vg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4461e4-62ca-4bad-677d-08da475eaf0f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 01:48:42.3590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CvJw4WYKqcdCsTrbh/gznRnqCGCQhcv+bZ/URDT8ddW4sAhjl33ILBR+whuv5yKaxKTc0Jamwy765R7JhM9dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4840
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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

