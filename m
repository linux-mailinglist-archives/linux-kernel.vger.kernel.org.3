Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FBA51F5E7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbiEIHy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbiEIHhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:37:03 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50075.outbound.protection.outlook.com [40.107.5.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E441B1CC5;
        Mon,  9 May 2022 00:33:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCx/AKPfCYW/cyh+LsBKti339+NWF1QnycvhGkLiSJGFZHI9fomnyPwEDiUsnjeCjAZex0xj8UuWNDjxZpNpC2A9a0XP3CLlZaXyH1Y3/Kn98bWBY629kL+1y09r/6hPaQi3wn/rAw8oDjYLjGnuQQDkdlT6999jeXvj+bYo3jE3zRplrxCGQcpK99PjwWze3QyHYT8kg1QYct1B7vKg6NjCDpJ/LkkFZBgb3l8ysF6Jw1FtTKCvdIxnIPG92R/sIDCHRwrUSLc1NHOIfVZhNy2hSYtVWpegjH7k6IBbIsSCyLSWGxROjvlmn7MLRYtEPXJG4hiX6lYY1zprmmWRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u43qhZErCfsp/WfsauWb+AYqBw4JKz58QLCHywZ8RLs=;
 b=XnYBPzl9+7Kq3HllOEEgDvhgRqHOziujjfekMxZKr04G5DmnOZ6DJ7TWEA+Jh5ziFrUn4ws7ifC0D13TalkytmubAoyMd8DPVSz/Hf0ewjJ7hXpaIIJIDCuxIIOksEIXfem0tAvufcsI17KwW24bX269k/eVv9G1xu83tApUTVd8SiM38CtY33v8ZQBupuUWNe0iQVn0ubWlMvd3vSI+Tqas2TZT5u6yTF3g9SBu1uElTuIje3S4Ohyj2azIjr0r1+LHpqDTA2S/K8T3dgl4pATtlMou9y+4ZiuB/HYTP7rMvf8iwMCi3nXAYLqGZqVy/RCNuBSx/r5Pmw2hFOQclg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u43qhZErCfsp/WfsauWb+AYqBw4JKz58QLCHywZ8RLs=;
 b=efgIQ5dwUoUP2yfu+6x7YlCS2BtaRCNoRhR7e+HHJ74RxY/UMLYkibhdZ8VgZWCpXpOSslN7ICEhT/BplUD+bLHhrfUvLHgbqvG2hMNxyEXbn6kF/aMDopsrlR1efAg1QdZwXcacxHzaJtu92SBdJ3RXPigo7GVLebPdcZxpF8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR0402MB3330.eurprd04.prod.outlook.com (2603:10a6:208:1f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 07:27:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%6]) with mapi id 15.20.5227.018; Mon, 9 May 2022
 07:27:23 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 0/4] arm64: add i.MX93 support
Date:   Mon,  9 May 2022 15:29:07 +0800
Message-Id: <20220509072911.3268668-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea59cca2-6953-4b4e-fd6c-08da318d5c34
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3330:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3330F777A6DDDCD68A3472EBC9C69@AM0PR0402MB3330.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +sLag3+i+s6+Vy1Qz8++LmPlD/FZIhrEpS1tFA04BVpgzUKQTvZZPH1z1QKPDML4YpeS6526fam/wG9qCACAUy4mMHjZOkuZF1TM12h9/wFPy4g7AKbt45h+sdQQzmgn1JNNyPFNvVJkK9bfBz5oHYQlbpjJDxyAIK9aQq5iTS5xe9zzJWXoK2p3SC+YTZptW4q6Kob2GfptyPMfFPGdgkrIiN77AZlUUvlHbI6c6Kv0NFYk6lTN5uMctZsZVTYfnNzTHJNNTWal5O5xMTcDwZtlgs4lq0CkyJ24KWIcMUO0qXzoG7yIe5IP1CK6vgvY6tj6vmeFUKxd+kOvG/0H4Hn+ZO3+obbr/9GWyafApL/EHoIE6xBIYi2B5kJ+bMZgY4IsbYAjPRLsSBfQwb1rBpAtO7jsdrrOJ3v9BAlYV3U/T6DilZOMxf/040udSUhdreqG0pHrIa5H7iXQsAO20lPdAfz7rRNzLv5XibwrvgFnHQ+OBvH1XLv+pUmdUzfrbIeP0zNO/X/5TdCydkvcK44xnfnHqT0jdHWkk7AnuyQd1G4AFumYaKlL8AU2h6m1VS6dtTYdzB4PzDcelc4v/EmF5rduw6TH+ju3Z8uWxIfh499tGWa+fxibmp9fZ0RHrr1GGc+nhYM5PiWZngnnVmjBR7nGTpuaWL3epwdYR/x89xNGB5cZPmst0ssSZZISSwI54/Pdi6sDx+BIvqk9cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6666004)(2906002)(6512007)(8676002)(4326008)(52116002)(8936002)(86362001)(5660300002)(66556008)(66476007)(26005)(2616005)(66946007)(316002)(6486002)(508600001)(38350700002)(1076003)(38100700002)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Et9jf7XqvNqrerL3WsFpMESLp6iWm52G0+35SeP4zU2+sRPXZcpmrkUgMJW?=
 =?us-ascii?Q?aAs68vCU+lnkXJIbUJn5NYbYyAJgkE/DUb531WV5zN3Gp6v2rXeVPUbA9k/X?=
 =?us-ascii?Q?korZM4YEuZyqJseACk3uCpYYxwNrx/g1M087s1TQ/rmJfRhKiM+ubSgzaBhf?=
 =?us-ascii?Q?Wx2CArD1qxVy6NndGFqg5TO5Mv5ZuR+aIJiK7kmLAgaqfqXJVCJdL//qi0Ln?=
 =?us-ascii?Q?4rCcZz/xCg33Uz9gJenHjOiwBjwtbI6ZiB6hiMfA/cYc6/WVlA2PsooloPMM?=
 =?us-ascii?Q?ldCvtRfAGOffGdb86jCP/WCaDw0umwBCPxN494uidgoFtj4NpGdXpdnQqgpG?=
 =?us-ascii?Q?25uRHVLI5BSCmGqgg2now4fdQcs02eFhJuDveW+Ug4FEZbWgbbWW977jPnw2?=
 =?us-ascii?Q?H/SVmIH0MaKeB73dcrVdQl6NicGzX/iYonWjJJXJ6b1+Lw6YFDXsNujda/Ld?=
 =?us-ascii?Q?g9mkPOYrVbO7zadLLkKXWWCFRgHLhe3hELj1Dci/HTqkgaA9bR4BBBrpGRln?=
 =?us-ascii?Q?bA2gmwxzLH/H+9QAYXG6hZiqVOAms0TRTeH46EGP6yBMj5JR+LBvGiY4RdKa?=
 =?us-ascii?Q?F0FfBrqtk/OyuWuq+fWHG5ruvo2z9us9vJK0mO+QVulpBaXWqvSBIvXSe0cE?=
 =?us-ascii?Q?WHgKsRQJwqU1NQYl/X+ILVMFazqv2XkHOkwBYknyQA95SAmRrhPWSIGKhhyA?=
 =?us-ascii?Q?K9/8TrQddoXdR94fHx0N48+Xywb8oJmLGSC8LCg8gONZyF73cXxstX0+8CnA?=
 =?us-ascii?Q?jk3S2s3q7sAW/FR13jh0OBhfK1MnoH4TI9yT2u66TrLHxgP00rpJ2KVIBZjF?=
 =?us-ascii?Q?uJsHbXsaU5EFN3ZPPVikhsj5HZiDogKFwHvGdgYg0Upa0snmiV8IBh8XaFJM?=
 =?us-ascii?Q?5RXlB0zYQdBhOWd1tH46g1lrOfd/T3LD8bSHzh/rw5aFuKRhhyPZWs3oU22q?=
 =?us-ascii?Q?/aMNmQQclL5I8oUnnMKw6FdVXnThpkgZ3JUNvz+yjbb0rVCNrO+6vgm5Plz1?=
 =?us-ascii?Q?2qbxcAwclhBYtbv2DESZexXEbjGL+RMj/RrU2Wg/H4NS2JcKuxUSzZP3Y+1K?=
 =?us-ascii?Q?pZQ4kMxygMDT6jFDcc3yrIFId2f/FRX0L8jzKJPox1+ro+v24aJ6RCAsjLmi?=
 =?us-ascii?Q?vRnlel/05xVUUUUObcduNLAZzNwNioinOCzYyVKkXlqp0CfNQDmEN6YB1bGz?=
 =?us-ascii?Q?eKN/k2SJC7iH7hVOGek6rOxz6BoUhUq7nM1/g9gIPLPaEPQwWV18bAVyroN/?=
 =?us-ascii?Q?7XCiWlS9/A/cUdp/dt3jBUKa4FTfkY2AseYOj1TMAg001MbfEA5I58u4Mr13?=
 =?us-ascii?Q?742gg0BsBpFg+iIrBiTgAwx8S6Ly2s5YTXSziBaaXuiu39FDTgvCOHsaVFPL?=
 =?us-ascii?Q?76yg0W1kxPVGyPUv6dvPItaJYecUp85oZ28SQs928N9YeK3rivTfgiAouL+S?=
 =?us-ascii?Q?vfVgj6d0kdBU/MXBb5W+nrIBPPl5rq1L989jexu5snf7m72nDKrIItHPZvTH?=
 =?us-ascii?Q?cdymSd3STVDkpWRvEekYwAZCYQu/mmUN+udTt19W2H5y/qsplpbFqqCFMlWE?=
 =?us-ascii?Q?dsIg9Bh0GbVerN59EhmWTPkbAs4Sb1GHg5EMFoQvf9ZT/8jEfAZIcdb2bdOI?=
 =?us-ascii?Q?R+WbJVuFB03jVezPgYYxx2PYgZv3Y6ZzBAf2gBWBxLE+8w9lLE8u/ZXuG8b5?=
 =?us-ascii?Q?ESXyHY98fnzBiyh15oxokit29j2/UevIlB7DX8cTaKqyXMiMJR3c16yJOdCg?=
 =?us-ascii?Q?MlPomkENSg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea59cca2-6953-4b4e-fd6c-08da318d5c34
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 07:27:23.7993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkkLs/OxbkXkosfsx6IdEWxAk1UNUYTve6eZE2nWmKByDeaB2CD/f/Q3zSMb6Wq6VWHDvHwP+9+1z2egQB4+pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3330
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
 Add A-b
 In patch 1 to move imx93 behind imx8ulp
 Drop a whitespace in patch 2

V3:
 Add a new patch patch 1 for board binding doc
 Add A-b from Rob
 Fix dtb warnings.

V2:
 Update License

Add i.MX93 dtsi and 11x11 evk board support

The required bindings and drivers has already been in tree.
There arem checkpatch error for the pin header files as other i.MX pin
pin header files.


Peng Fan (4):
  dt-bindings: arm: fsl: add imx93 11x11 evk board
  arm64: dts: freescale: Add i.MX93 dtsi support
  arm64: dts: freescale: add i.MX93 11x11 EVK basic support
  arm64: defconfig: enable i.MX93 clk & pinctrl

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 132 ++++
 arch/arm64/boot/dts/freescale/imx93-pinfunc.h | 623 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 333 ++++++++++
 arch/arm64/configs/defconfig                  |   2 +
 6 files changed, 1097 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
 create mode 100755 arch/arm64/boot/dts/freescale/imx93-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx93.dtsi

-- 
2.25.1

