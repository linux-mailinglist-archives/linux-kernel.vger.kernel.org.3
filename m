Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B40752111E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbiEJJmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiEJJmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:42:01 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5351820BFC;
        Tue, 10 May 2022 02:38:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHOglBewSnndDgmOAieQhyJ3gFXHCUM9GZkiHhpvq0jL/mjdnr6ZkqiXS1fY935tYopaziuDP5sTUv7NKLJjHQdaoLKxiKvWfwwqnEzyxGU6jsvBoQEAA0uOZMNef5hvDfk0fcrB8z66VIJwa7270qHcgoSanTWxiPNZiKH4qyJ4bmmcJqgASUJC/+w4g65T8gHpqpwEQMAsmgSkJxz5pPa+aGWUBW5Tp4OfZgZTlZg7BsGoEeobQrYVfsgU1/1DDZ5UmGzTMDu8941DB/Rtybyef70BoVrMh/+v45bpLuFvKg2CMpwaUldtPN2lIMdc60fW/VZ4N/fcP/wmIAuH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKIx+0KmRpDf7q9uNFOrIRmseAWTxv4+z8ub/YtwChM=;
 b=VMLG/p3ryVjnyP9cppr9r151QROs8aLnxzwK9bj9JuR42Oj4mbLcxP5QXhaB05CGYRZTWQSbpx56kF0HeAq7emAkvySlEmZVt6pPX7axJMjkucif0g9RCSTbivg8oM5tg/wDbLejKxmAxYfTD8WXCBuvV5s8CPB3F+Y83w0UfuMUvhBSLNiAR8Bh1PlHW16qo1xjeQFeC/NS0/D/NMO7f9g/v88rDESk2Lebnw1iNmq7PE3BtDTv18oVer+cZefs207VxswabWfPcJGka7eytBIkPnjAbh/kxeO4G88lEkz0sGRlIk6iWZ5TKJE58PBMmagcm6gb3L9UGpPSTKMDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKIx+0KmRpDf7q9uNFOrIRmseAWTxv4+z8ub/YtwChM=;
 b=SNz+Di+0jsdiB0EsAgWWPMzfg4C99/mmpI5QcwRde8eYX+BuYiii042TdkPnm9uJdn9Fnjgqr/4GYJIFFFoQHpCKF5/SKrQbZ8S3xEcEcFnmtNMov+aYzkTj9XDjSnHsjHLBqP0wK3VvH/+csdZ1Ee9IierJQJdiXAqYMzOZCK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7514.eurprd04.prod.outlook.com (2603:10a6:10:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 09:38:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%6]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 09:38:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 0/4] arm64: add i.MX93 support
Date:   Tue, 10 May 2022 17:39:42 +0800
Message-Id: <20220510093946.335036-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a030be28-1d83-4938-fa28-08da3268c676
X-MS-TrafficTypeDiagnostic: DBBPR04MB7514:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB75142F1D070488478A233E40C9C99@DBBPR04MB7514.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GJk8Czl/8yrQiBtJGAPPo1KvxjdwdvgSnyR0VZ27a/OFkZze5nFTtNP6VP/NdrR0hX9WMbLQaBwefD+rwr0pf/Ph/WDHroximx8pQ7H2T0Pu/ue+t+tXwmiTdnUXHjCgKef3Kb1tR8VkeCXCOd2Z0mf/x9aohxwNYaxWAZP1abQcLAJosdKZHowhj5TCeVYRBfa6/+yZc7ByrKvkTErqtcf32MXzZiaL+Nw0eRT40aimkSERE3N5uxqhcDLAesUFyv1FC3EGpLb1YWXO5/YRWfig9WzHCXeo1haWXAoXME18r3i5eb/phTu18PtdzPq7Lp2SlPVzp+UO8gBr/BOGre8gQ5AvRrfrv9ofsxNv0D0IWUCudJrKH6TeTBtIsMOVzdvKbx1YUF/fZePD0jEyoBOH5g4GiFuzxOXwO//WeYx1UHDsMETWO76b5gtUJQzsBbox897c7fIQE7lhHvaI+doZZB8zst20Z++2xF/uZDKHIFNM4owNMatHC6zMvU4Qu1fCSwghqP5O4lJhto0nARkgj8TB15n5zWKxubmAXvpSd5iBGJuVTu+qGuu+Q6DAkZAm/+CyR2zr1EegfNljcNpIka6A0n5IYx2x3ozASnwXFEx4ZrPPopQbYhXWA6j6jzLhiaEjq0zGBE1Luep2jQ+XkVHwJ1ENOmqoIf9La0pU/V7USIGoCcO70gnQ7L/WUdll95BH58f/K9th9El7Yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(8936002)(38350700002)(38100700002)(5660300002)(83380400001)(4326008)(508600001)(186003)(1076003)(2616005)(66946007)(66476007)(8676002)(66556008)(316002)(6506007)(52116002)(6486002)(26005)(86362001)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VIjgaxMnAaKSEKaDz/58EufxvNxBumvsweWZMNcyi5AQHGgpqEtPstrBWcJ6?=
 =?us-ascii?Q?4vCVZYJAKlRu5hRbqjRUUhKEzfi5Ogmj0CK+QeXWR4O3AoGLCyuz0Aw1Ouk6?=
 =?us-ascii?Q?cJS/yTEKhvAQQr6WVujhA9i6VOju54CNYV75xGSmkSUlnhUSSsVzp70AYXMu?=
 =?us-ascii?Q?cyjqXlHpV5sUNEdTM2Fqn35LVNsVUM+iBAJQIBWJevzmJo/2bHDHkOdVHTg7?=
 =?us-ascii?Q?B+KU+X4yXueKZ/ciuHBm6oH4YaOaYK/cVer5/Jmd8FewqKDxUfQzE00aTJJU?=
 =?us-ascii?Q?Bth4o9MjStUiiKkg+CYj25xWqGZGXUmp4d4q1pbcMK4SrQhTG9GZbxH5h1xX?=
 =?us-ascii?Q?Vph/4y8p80ZqPhah97X84Ao3PiMhgbTUAjcSZJdSFEjMNN+rz0N9l5oj4Aws?=
 =?us-ascii?Q?vaJhWvjncaQIigK0Y6Ok+3y9g2F2TFnQq7QYOwZ4fg40aockYPQCnGuDxEKy?=
 =?us-ascii?Q?l5Dojfp5u9lLJjYNlL+1vZv5nMyfFiavxSYfL+SKo9DbfjBcBK2g+xb1kS5l?=
 =?us-ascii?Q?iy10IJpQYEbRjJAj8ipKpCOLrMX83peBoj08RGoJsoNtOFdarFlhP2LqZmNP?=
 =?us-ascii?Q?BRaFZJ3XsF4qWSVG29om1EGjzL1Ev5G+Y1BvwLV3vKoiRQSKR4kgskh9YsSH?=
 =?us-ascii?Q?LfGzctuFe22Dk95zMFVOf3jnL45AZ4/f6lXXFYrmfB5kEYWvKAHjy7qyWlcR?=
 =?us-ascii?Q?UeggejqCKsl0+Aa0JfRjBS648yRwRVzq/iF7ciRxQQawcu3/tBbKm6WHi8Jy?=
 =?us-ascii?Q?9q+H96h2n0ZEj9ZD+5mB7pt4nj78AINMq0I/h/Ar/KKBlNHBR7tJRi2EzAjD?=
 =?us-ascii?Q?endxLK8oR1jbTqjNJ6ivDQUnWmCTVus9jlQ4P1ZNjRTNH4YhL1nOPHI97YX1?=
 =?us-ascii?Q?L4isr8cyDJUjavEcdZ7r/2ExkKfL3bmTlpmLbCbaq5TtI4zU0v8BOEo/lZlm?=
 =?us-ascii?Q?XqljvMF9L4LXTrEJo96Mg8wGjYOZFoznCr3ReiX8kXf9jb9PRsv2X1uWJKQb?=
 =?us-ascii?Q?A/Tq9h45wFbgykQ9P0TmWIGZuJzl9hjJgeUUn2cH/aJ98aigwXD/TBoczG/s?=
 =?us-ascii?Q?LnT9NT1x3RULrySNT5YzG0Emgbx2QElrK1WtAkL0BSaO1LFw+5/CRnE8azEQ?=
 =?us-ascii?Q?OxawvFRg4mxz+ceZtq51JAEO70kBcdnG3p3sr0vwgdYXbHbZwQZ8orjg+ndG?=
 =?us-ascii?Q?aLSXRXtaWQ/XydjTqIUa4klfyOWnKojUlgKP3w/5EPrNmtngMtgQdMr/jCtv?=
 =?us-ascii?Q?bveIb7BXPYTNHqiO3BqnJAeu1u6J07IrYPUgFFVdkfL5xH5wD45oibhAg/Kr?=
 =?us-ascii?Q?GlkkoPY4bQFYIOaT/6GQqjeHKrGSy2zeDaV5Np+w5wg8M+OIclIQnCG+MGgy?=
 =?us-ascii?Q?bBmWw5PH/dWZkncq+8HzYEbeZ+dymGqwT3cCfON6kQqdX3Z62VsmNUvIoMvg?=
 =?us-ascii?Q?8XV5txW2TyL5Vgy/2HdarEVR7Q0jJmdSr0fEz+6yCL/+9RtWn0RfXGbY9pFK?=
 =?us-ascii?Q?hsSUdTIr7Ii2pj/5vbU9HOExCxySScb2lEE4OKiDlYOo2JOVzl8BloJWeuuv?=
 =?us-ascii?Q?TP7DAXPJULoPQB95G/ViZz6Etcm5e4gxqLGKJ6ObzP0aba0HghyuU5WJX3xE?=
 =?us-ascii?Q?f03dJEpZBc7NL61yUXWgq8QFO/z3E3jAA+yPI6nX6NSM8+OKY81cgD2kPeFK?=
 =?us-ascii?Q?kEL8NtyL+p2bX3eQkH8vK6dPA71obnEDqZd077mD7O+4AzJrHU6XqNSWffMy?=
 =?us-ascii?Q?RSi6Gsv5aA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a030be28-1d83-4938-fa28-08da3268c676
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 09:38:01.7457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKb5bZTXjWfH+AKS94IVpLdW2Dm2FVY51+4LPgXbyF6DuB/5mHr/bizpGuZwA1Lrzl3eAkey0qD8XlJ/0UypFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7514
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V5:
 Add R-b from Aisheng
 drop iomuxc status from board dts

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
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 130 ++++
 arch/arm64/boot/dts/freescale/imx93-pinfunc.h | 623 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 334 ++++++++++
 arch/arm64/configs/defconfig                  |   2 +
 6 files changed, 1096 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
 create mode 100755 arch/arm64/boot/dts/freescale/imx93-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx93.dtsi

-- 
2.25.1

