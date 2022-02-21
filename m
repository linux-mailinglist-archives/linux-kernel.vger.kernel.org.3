Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1138F4BDD54
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357045AbiBUL4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:56:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357043AbiBUL42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:56:28 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80042.outbound.protection.outlook.com [40.107.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBCB1EEF2;
        Mon, 21 Feb 2022 03:56:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKX/pECqjQid1sXIGDt+67OGSwW6pLfn9lBfSfCe1xiFVTZ+sKjx56Kn+oNFIVMaXah1BvlXiHOwvRpUFITvTVGwnOHN6LnHYIXfGM00VahSRNY5reitpudjSWf2AZmQ+qw6Y3LujdxMI4/PgzqvIP9Ow76hzlIYyJaV55JEdTPu+L5WqWVVP0WXtS3x4SQyfw/CC/j8rAFHIpUfNW1SE1mpbbWbBLdJstk57eca9JUId2uXnci90NmKEGM4x0xzpUpUx0GDcf9TCqzf151ghnMIiBJEfArOZODfRzoYm6UnZmVxSR4y2NHoC2/fW6nBdo/ZFlR0woozBhaF02NhKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5al5yQVork/IyD5SvXx0lgCzSBzf2YYNAOQATYGn8EI=;
 b=K2eXosGoeLM9DAcAAUSntyqYkEGmst3RozzN6zM+eqEM6ICp8gFVI52gYCnX2bfzytz2WTrhDXwanvyVtEuqPgFtW4LI5RZ75Ey92g06usbjfrY+Yp90BVn+LVYwruIBeRzqjMVHgfqnjYDsrQHAz2Nt05k8OcrJYXfWtLZ73EdwAzKXmlX4IFFgVxgF4JBiTEMNv24wAIYKytR0od2RifdUZis2sr+V4sk1mJPwdtSGsoHi62v5wu+YrH9/JXDwhTXHRm+xEdX3uCG8DEq9dityzUMTIdqcBfTkzkzqLvD0Eycko/LI7DSe8fBLKYRCdsJjP0kKvjhlHyCPo/hZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5al5yQVork/IyD5SvXx0lgCzSBzf2YYNAOQATYGn8EI=;
 b=pe1UfqchZiC+SWHTJm4UqYZ4OeGTZPQ3qcTdQJFytRfg3tUva02CF51mvjAqrBhODUrX6zidLx5Q9x8lA/EI4MAe8DAmFdwsiepKHbb3kDdgzIUnjaNq9r+oiYHT5RhCLCnJOF2zzSJhZHq9TEyJ/IxvQkiP49YuvHjmwxfLMo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM0PR04MB5043.eurprd04.prod.outlook.com (2603:10a6:208:c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Mon, 21 Feb
 2022 11:55:57 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f%6]) with mapi id 15.20.4995.026; Mon, 21 Feb 2022
 11:55:57 +0000
Date:   Mon, 21 Feb 2022 13:55:54 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/4] dt-bindings: clock: Add imx93 clock support
Message-ID: <YhN9yvmOW2z7sjcW@abelvesa>
References: <20220215081835.790311-1-peng.fan@oss.nxp.com>
 <20220215081835.790311-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215081835.790311-2-peng.fan@oss.nxp.com>
X-ClientProxiedBy: VI1PR10CA0109.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::38) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11c5ff85-37bb-4724-4b1a-08d9f5311f10
X-MS-TrafficTypeDiagnostic: AM0PR04MB5043:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB50431FB7B3092EDC002CD724F63A9@AM0PR04MB5043.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfccR/oGGSolezGKhLjeZ6g1oLukDdbxLx3I0JugNaC2tFfKDjDtw4u4/yCu/sPXgx/uoo2BFp/00mApGr0L9OyanrLVrY+c8/WWY4rgIg8F78qjGWLyeLE2eE7leljEs859PVPUFEYeT2audVIlWgs6zus6S2Q726ieVMiWfTaqVfUygzqpquZLcCP/zB00HNCLRAaEcmO7xs0JzBWgI12ysMZ9tzpSj7aqk728pbAW4UKbn8RxvbwnVzkHbPiqBfGzB5sO6CPIsAjDVrlMKzALZnuk6RZxagxW6vZQOFv6Z5fXu59IbQkcCz3m5GZDcF4nHMYnne3DtbemE1ls9a6BdC2+PMgCCn+FUU45T+7TSb3VRNuWzdYthZpRZDrqfdHZfiBkaKUbO4HotQs8X3GrNEtBEoLju39Ui+pF+L+HGQFJUMPt7XI9J4FRMr207iZ5dasBBNtqcY1aEV/qFv+5nueG1WczarKLUERIBFm0nb3ufD3IhpVDXA2Lfnu/a9pbcAusXONdNAOByK7akEsEXTd0qqaIXAoCnNG2taj8gxZtkMsygaHTkTQHANyUf1exkKb+B9ZgINQLjYau+HG1ESY5neywrDYuBj9u/RPv/Q7vMMq+oToWN5LQlaY/rPxZEcGvvm0EkA4pufCUlsdsAgdwOnw9fu+Fahl5F9pgtVpljebY7FOxc6+zRQAW6+M/zxcC89q2VqZxDEt5Chhn5tu7O28u/BYQ6xfjW9wZzoGC9wdlNmIXOSJNAK5AHUkbXJkzmjzvTHTAKzfUY2vURnPhyEKYIRBzHDLcik7mYDaKNGN0+7xSyrueHm8mt0QvH/Ql844wIqicv7ooTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(186003)(8676002)(4326008)(66556008)(6506007)(6862004)(66476007)(66946007)(38100700002)(52116002)(38350700002)(33716001)(53546011)(6666004)(26005)(6512007)(8936002)(6486002)(966005)(508600001)(9686003)(5660300002)(316002)(44832011)(7416002)(83380400001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cxfgroiUK06P7hoQcexHTglGwGhHYoFL6mBz7F59q3IYoJYqf15rmw3KopUB?=
 =?us-ascii?Q?qgFaQ7haX4sYVslqE2FuhiKfoSs7Q7UyqyQALjgqcmMpM2NBaQw9LezfDhRC?=
 =?us-ascii?Q?e7JwvknnDkOzs5ZN8H4amMNZYKKoxENcR1aZbHbYxFCCZS70QQCQ8ZjnzL89?=
 =?us-ascii?Q?VC0FUXZrj+9T4MpwzSHznW4w2l2OGG2tIarkjxMtYaaI5NC9Lyv0szmZuxnb?=
 =?us-ascii?Q?Oqr8JTl8bbOFNJBw4bTwemTd6fpck79a4m1dMhXwKE2n7pPJNOwrPufsj80k?=
 =?us-ascii?Q?IT7jHrcAHe19htjm0hFbf/+I3qXOG8pLa0uDbSMHsRR1dendsEvRyX8CEehS?=
 =?us-ascii?Q?mtSHgTDePi/Nzk7++yYBJsOqZ5VHSWdoAo80Eis5p6I+V7oKeO4jj8MhH31q?=
 =?us-ascii?Q?CRXKSG69ykjDKd72QqMFzPtVHjDX8/e0/Z0BZmTordOIXtqff0chK+4UzTG6?=
 =?us-ascii?Q?0wTG87jzueW4Kdhyl6beOveI9m35/9hXUUELHD87qEAzzoL68wPAD0f90jBV?=
 =?us-ascii?Q?QbUOQom5rgv1rROwqHZaLHLDxspgJne/lw7yrT3eSiqf5NxO8MZu5L20T7+Q?=
 =?us-ascii?Q?MZkFpl62a7Rz23U7LZKYMZk5K09jOhT1NF8xDPdRXqmyW0BcxXJ4FDj379MP?=
 =?us-ascii?Q?9jpHW4BdCgC90WBlJjX4hf8kcdb2HIjVOEE5a/kHi+jd4mldUWeHuLdkajEO?=
 =?us-ascii?Q?p5n0p4d50OOFlNViaPgk/VTkXmo3Nht8+ib+pz/k7dxxs2mKVSgc9FQX6wWH?=
 =?us-ascii?Q?QGrb+y1IU7q3Qs7WLu3+R+l+WlCjxSQX7AKldC+SAr0AgSC5BiOHZoasWMZi?=
 =?us-ascii?Q?vmljSsBmsOSjefOlr0ZH0K6hXtWxFwNP3pen2I30qMzDV9mdGQf2gKHRj7Ce?=
 =?us-ascii?Q?Lu3l75DrEXCml8OtJOPjZAZ88xp719NMro7LfGOQsMMD9iIbHCBgaxhnQUDY?=
 =?us-ascii?Q?dc3dnF8R207Qo1sYzvCaTSxDg8kCEWAO40kFdXUYFk9uNTMu/E+3fqOXQ6LC?=
 =?us-ascii?Q?iCDOzLTr/jbffTQakunEM0NuinoN7kQmq89npibRM50xY60+y4wMsaxtW4Bx?=
 =?us-ascii?Q?WjdnOi6woVudueN4MuVY1TJdotqlYFMnglIxeJoKEtOtjNOmwzds1kcdijhi?=
 =?us-ascii?Q?6hRw9uwWVKmHpvgOWxUFSlMpegvYyf694A9F8TBV6HNhYi7JL7bfinHk/Aas?=
 =?us-ascii?Q?lHSAPF4TzDRibeMF3oQA9tvjvj8nM+I0WM75x1I2IImJMBv1ae4je3SEfpo3?=
 =?us-ascii?Q?Wk7hb0DaqOWq6hOt4ZuSa4M9aPkc0Cxeaq1rlqTlXXjgSO37EUqjCabummhA?=
 =?us-ascii?Q?PU8l1cm2Mw2LobAvekuFrZv9vhuPFoQS71Dn/vRkHkrNswZc3kbgWaUEA9EV?=
 =?us-ascii?Q?/keXqq44m0bJz0OAybM/i4yYZfozByq7XbFGoFY0aJOJcuItWCX2Wr312e6O?=
 =?us-ascii?Q?M4Px8tgRI/32zWCmC4EM4xM5Y/wkG2RdDbyqQLLjAji1gxHB+0IYC/vdvi5j?=
 =?us-ascii?Q?MY18ImGtyZfE2azd2SfNlmd2+QnGE3o/OOVbV/hcOydh/Z7Wx5uGFBnrEKND?=
 =?us-ascii?Q?0UGl+CKGKQw97+GQXN1Z+eTf9mMl0Ba4eduln2QJDAOcn5N0/jOqFFnS0fs/?=
 =?us-ascii?Q?PCCfwgG+nhIgjJ0rBS5yEPo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c5ff85-37bb-4724-4b1a-08d9f5311f10
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 11:55:57.5187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYvfwLww5bdyc8w8f5F8VNLrvxvgM7lU3eHkSBkv1358Nw97GE9ufaPQlLcaTN1bO++CTlEivr0qU9lvPLznew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-15 16:18:32, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add the clock dt-binding file for i.MX93.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/clock/imx93-clock.yaml           |  63 ++++++
>  include/dt-bindings/clock/imx93-clock.h       | 200 ++++++++++++++++++
>  2 files changed, 263 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx93-clock.yaml
>  create mode 100644 include/dt-bindings/clock/imx93-clock.h
> 

Put the documentation part in a separate patch please.

> diff --git a/Documentation/devicetree/bindings/clock/imx93-clock.yaml b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
> new file mode 100644
> index 000000000000..a4c3ae23b8c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/imx93-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX93 Clock Control Module Binding
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +description: |
> +  i.MX93 clock control module is an integrated clock controller, which
> +  includes clock generator, clock gate and supplies to all modules.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx93-ccm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      specify the external clocks used by the CCM module.
> +    items:
> +      - description: 32k osc
> +      - description: 24m osc
> +      - description: ext1 clock input
> +
> +  clock-names:
> +    description:
> +      specify the external clocks names used by the CCM module.
> +    items:
> +      - const: osc_32k
> +      - const: osc_24m
> +      - const: clk_ext1
> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      The clock consumer should specify the desired clock by having the clock
> +      ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx93-clock.h
> +      for the full list of i.MX93 clock IDs.
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  # Clock Control Module node:
> +  - |
> +    clock-controller@44450000 {
> +        compatible = "fsl,imx93-ccm";
> +        reg = <0x44450000 0x10000>;
> +        #clock-cells = <1>;
> +    };
> +
> +...
> diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
> new file mode 100644
> index 000000000000..416e6fd7856d
> --- /dev/null
> +++ b/include/dt-bindings/clock/imx93-clock.h
> @@ -0,0 +1,200 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
> +/*
> + * Copyright 2021 NXP
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_IMX93_CLK_H
> +#define __DT_BINDINGS_CLOCK_IMX93_CLK_H
> +
> +#define IMX93_CLK_DUMMY			0
> +#define IMX93_CLK_24M			1
> +#define IMX93_CLK_EXT1			2
> +#define IMX93_CLK_SYS_PLL_PFD0		3
> +#define IMX93_CLK_SYS_PLL_PFD0_DIV2	4
> +#define IMX93_CLK_SYS_PLL_PFD1		5
> +#define IMX93_CLK_SYS_PLL_PFD1_DIV2	6
> +#define IMX93_CLK_SYS_PLL_PFD2		7
> +#define IMX93_CLK_SYS_PLL_PFD2_DIV2	8
> +#define IMX93_CLK_AUDIO_PLL		9
> +#define IMX93_CLK_VIDEO_PLL		10
> +#define IMX93_CLK_A55_PERIPH		11
> +#define IMX93_CLK_A55_MTR_BUS		12
> +#define IMX93_CLK_A55			13
> +#define IMX93_CLK_M33			14
> +#define IMX93_CLK_BUS_WAKEUP		15
> +#define IMX93_CLK_BUS_AON		16
> +#define IMX93_CLK_WAKEUP_AXI		17
> +#define IMX93_CLK_SWO_TRACE		18
> +#define IMX93_CLK_M33_SYSTICK		19
> +#define IMX93_CLK_FLEXIO1		20
> +#define IMX93_CLK_FLEXIO2		21
> +#define IMX93_CLK_LPIT1			22
> +#define IMX93_CLK_LPIT2			23
> +#define IMX93_CLK_LPTMR1		24
> +#define IMX93_CLK_LPTMR2		25
> +#define IMX93_CLK_TPM1			26
> +#define IMX93_CLK_TPM2			27
> +#define IMX93_CLK_TPM3			28
> +#define IMX93_CLK_TPM4			29
> +#define IMX93_CLK_TPM5			30
> +#define IMX93_CLK_TPM6			31
> +#define IMX93_CLK_FLEXSPI1		32
> +#define IMX93_CLK_CAN1			33
> +#define IMX93_CLK_CAN2			34
> +#define IMX93_CLK_LPUART1		35
> +#define IMX93_CLK_LPUART2		36
> +#define IMX93_CLK_LPUART3		37
> +#define IMX93_CLK_LPUART4		38
> +#define IMX93_CLK_LPUART5		39
> +#define IMX93_CLK_LPUART6		40
> +#define IMX93_CLK_LPUART7		41
> +#define IMX93_CLK_LPUART8		42
> +#define IMX93_CLK_LPI2C1		43
> +#define IMX93_CLK_LPI2C2		44
> +#define IMX93_CLK_LPI2C3		45
> +#define IMX93_CLK_LPI2C4		46
> +#define IMX93_CLK_LPI2C5		47
> +#define IMX93_CLK_LPI2C6		48
> +#define IMX93_CLK_LPI2C7		49
> +#define IMX93_CLK_LPI2C8		50
> +#define IMX93_CLK_LPSPI1		51
> +#define IMX93_CLK_LPSPI2		52
> +#define IMX93_CLK_LPSPI3		53
> +#define IMX93_CLK_LPSPI4		54
> +#define IMX93_CLK_LPSPI5		55
> +#define IMX93_CLK_LPSPI6		56
> +#define IMX93_CLK_LPSPI7		57
> +#define IMX93_CLK_LPSPI8		58
> +#define IMX93_CLK_I3C1			59
> +#define IMX93_CLK_I3C2			60
> +#define IMX93_CLK_USDHC1		61
> +#define IMX93_CLK_USDHC2		62
> +#define IMX93_CLK_USDHC3		63
> +#define IMX93_CLK_SAI1			64
> +#define IMX93_CLK_SAI2			65
> +#define IMX93_CLK_SAI3			66
> +#define IMX93_CLK_CCM_CKO1		67
> +#define IMX93_CLK_CCM_CKO2		68
> +#define IMX93_CLK_CCM_CKO3		69
> +#define IMX93_CLK_CCM_CKO4		70
> +#define IMX93_CLK_HSIO			71
> +#define IMX93_CLK_HSIO_USB_TEST_60M	72
> +#define IMX93_CLK_HSIO_ACSCAN_80M	73
> +#define IMX93_CLK_HSIO_ACSCAN_480M	74
> +#define IMX93_CLK_ML_APB		75
> +#define IMX93_CLK_ML			76
> +#define IMX93_CLK_MEDIA_AXI		77
> +#define IMX93_CLK_MEDIA_APB		78
> +#define IMX93_CLK_MEDIA_LDB		79
> +#define IMX93_CLK_MEDIA_DISP_PIX	80
> +#define IMX93_CLK_CAM_PIX		81
> +#define IMX93_CLK_MIPI_TEST_BYTE	82
> +#define IMX93_CLK_MIPI_PHY_CFG		83
> +#define IMX93_CLK_ADC			84
> +#define IMX93_CLK_PDM			85
> +#define IMX93_CLK_TSTMR1		86
> +#define IMX93_CLK_TSTMR2		87
> +#define IMX93_CLK_MQS1			88
> +#define IMX93_CLK_MQS2			89
> +#define IMX93_CLK_AUDIO_XCVR		90
> +#define IMX93_CLK_SPDIF			91
> +#define IMX93_CLK_ENET			92
> +#define IMX93_CLK_ENET_TIMER1		93
> +#define IMX93_CLK_ENET_TIMER2		94
> +#define IMX93_CLK_ENET_REF		95
> +#define IMX93_CLK_ENET_REF_PHY		96
> +#define IMX93_CLK_I3C1_SLOW		97
> +#define IMX93_CLK_I3C2_SLOW		98
> +#define IMX93_CLK_USB_PHY_BURUNIN	99
> +#define IMX93_CLK_PAL_CAME_SCAN		100
> +#define IMX93_CLK_A55_GATE		101
> +#define IMX93_CLK_CM33_GATE		102
> +#define IMX93_CLK_ADC1_GATE		103
> +#define IMX93_CLK_WDOG1_GATE		104
> +#define IMX93_CLK_WDOG2_GATE		105
> +#define IMX93_CLK_WDOG3_GATE		106
> +#define IMX93_CLK_WDOG4_GATE		107
> +#define IMX93_CLK_WDOG5_GATE		108
> +#define IMX93_CLK_SEMA1_GATE		109
> +#define IMX93_CLK_SEMA2_GATE		110
> +#define IMX93_CLK_MU_A_GATE		111
> +#define IMX93_CLK_MU_B_GATE		112
> +#define IMX93_CLK_EDMA1_GATE		113
> +#define IMX93_CLK_EDMA2_GATE		114
> +#define IMX93_CLK_FLEXSPI1_GATE		115
> +#define IMX93_CLK_GPIO1_GATE		116
> +#define IMX93_CLK_GPIO2_GATE		117
> +#define IMX93_CLK_GPIO3_GATE		118
> +#define IMX93_CLK_GPIO4_GATE		119
> +#define IMX93_CLK_FLEXIO1_GATE		120
> +#define IMX93_CLK_FLEXIO2_GATE		121
> +#define IMX93_CLK_LPIT1_GATE		122
> +#define IMX93_CLK_LPIT2_GATE		123
> +#define IMX93_CLK_LPTMR1_GATE		124
> +#define IMX93_CLK_LPTMR2_GATE		125
> +#define IMX93_CLK_TPM1_GATE		126
> +#define IMX93_CLK_TPM2_GATE		127
> +#define IMX93_CLK_TPM3_GATE		128
> +#define IMX93_CLK_TPM4_GATE		129
> +#define IMX93_CLK_TPM5_GATE		130
> +#define IMX93_CLK_TPM6_GATE		131
> +#define IMX93_CLK_CAN1_GATE		132
> +#define IMX93_CLK_CAN2_GATE		133
> +#define IMX93_CLK_LPUART1_GATE		134
> +#define IMX93_CLK_LPUART2_GATE		135
> +#define IMX93_CLK_LPUART3_GATE		136
> +#define IMX93_CLK_LPUART4_GATE		137
> +#define IMX93_CLK_LPUART5_GATE		138
> +#define IMX93_CLK_LPUART6_GATE		139
> +#define IMX93_CLK_LPUART7_GATE		140
> +#define IMX93_CLK_LPUART8_GATE		141
> +#define IMX93_CLK_LPI2C1_GATE		142
> +#define IMX93_CLK_LPI2C2_GATE		143
> +#define IMX93_CLK_LPI2C3_GATE		144
> +#define IMX93_CLK_LPI2C4_GATE		145
> +#define IMX93_CLK_LPI2C5_GATE		146
> +#define IMX93_CLK_LPI2C6_GATE		147
> +#define IMX93_CLK_LPI2C7_GATE		148
> +#define IMX93_CLK_LPI2C8_GATE		149
> +#define IMX93_CLK_LPSPI1_GATE		150
> +#define IMX93_CLK_LPSPI2_GATE		151
> +#define IMX93_CLK_LPSPI3_GATE		152
> +#define IMX93_CLK_LPSPI4_GATE		153
> +#define IMX93_CLK_LPSPI5_GATE		154
> +#define IMX93_CLK_LPSPI6_GATE		155
> +#define IMX93_CLK_LPSPI7_GATE		156
> +#define IMX93_CLK_LPSPI8_GATE		157
> +#define IMX93_CLK_I3C1_GATE		158
> +#define IMX93_CLK_I3C2_GATE		159
> +#define IMX93_CLK_USDHC1_GATE		160
> +#define IMX93_CLK_USDHC2_GATE		161
> +#define IMX93_CLK_USDHC3_GATE		162
> +#define IMX93_CLK_SAI1_GATE		163
> +#define IMX93_CLK_SAI2_GATE		164
> +#define IMX93_CLK_SAI3_GATE		165
> +#define IMX93_CLK_MIPI_CSI_GATE		166
> +#define IMX93_CLK_MIPI_DSI_GATE		167
> +#define IMX93_CLK_LVDS_GATE		168
> +#define IMX93_CLK_LCDIF_GATE		169
> +#define IMX93_CLK_PXP_GATE		170
> +#define IMX93_CLK_ISI_GATE		171
> +#define IMX93_CLK_NIC_MEDIA_GATE	172
> +#define IMX93_CLK_USB_CONTROLLER_GATE	173
> +#define IMX93_CLK_USB_TEST_60M_GATE	174
> +#define IMX93_CLK_HSIO_TROUT_24M_GATE	175
> +#define IMX93_CLK_PDM_GATE		176
> +#define IMX93_CLK_MQS1_GATE		177
> +#define IMX93_CLK_MQS2_GATE		178
> +#define IMX93_CLK_AUD_XCVR_GATE		179
> +#define IMX93_CLK_SPDIF_GATE		180
> +#define IMX93_CLK_HSIO_32K_GATE		181
> +#define IMX93_CLK_ENET1_GATE		182
> +#define IMX93_CLK_ENET_QOS_GATE		183
> +#define IMX93_CLK_SYS_CNT_GATE		184
> +#define IMX93_CLK_TSTMR1_GATE		185
> +#define IMX93_CLK_TSTMR2_GATE		186
> +#define IMX93_CLK_TMC_GATE		187
> +#define IMX93_CLK_PMRO_GATE		188
> +#define IMX93_CLK_32K			189
> +#define IMX93_CLK_END			190
> +#endif
> -- 
> 2.25.1
>
