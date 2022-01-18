Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9442A49239D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbiARKQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:16:38 -0500
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:44046
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229514AbiARKQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:16:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBYicL4kMvweJhNtLdJtMSrMD40Ndy2kPXclNwuqR1vLCsfD5vN8jdIq5ZIT8MjtGeQKRi2KQcP7xTFwPTJvR0nHQKpeOMEdMcQDoSCR5Qo7SDdaV/mywBMmqPLPxhUOmcMd1KP7Z0dCqfKOOxuIbmZiG4fucmRawYqmt/RnW26jMRjrzFOl2fSTzcua5181qYbCYILG3MqtjJBHF0lDKTezLF4lNTX9PbND3ODMOqP6UbDKoA48zLPKbke9/TD1NsvyEsgFZH529BKQ7bHzuVsjQLRx/zr8P/JYSjORgdMXG/2kiCaOalgCcOuqFwBbVC2yCo81u3e4RSIOPm76aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTpn9KTXBPARDKidxzAsPN7elxywc/FFM5ye/ipuOT4=;
 b=LthRxCsQcDwsveFb/G2DENvPxxHISzxefwIKgKMeby4rGUiUW3Z457Ibxc5Jxfs2Q3EypBOlnkB24J8kWMZDq4Wp4coj3JDFd3t7oQqsfrIEjcMCnAOckGdvqzQKhpFJWWlHFLWbaAltVcQC+dAEG8D2MdVFOfVBHmSeoL9Ei37DWvswBgCMO1HL5dYv39QXfU4GQwcKk73B7CB1Nsb8ebVK/Qn7eR/Z6Bg66QNUSjbg/TBLaWMep5Jy/ucDIUb5BngtCv07RniAOGm0wntPBeMitLv0CrRTxDTD4ugd0Ds8lUlz9q0jvGcO54WudH/+CQENtuSSKSDcK6U53rzo8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTpn9KTXBPARDKidxzAsPN7elxywc/FFM5ye/ipuOT4=;
 b=qmuVzzg04Dln5lUUT5nef+t3CiV3gEcQcN8F5eHtKN+D3gmrjl64is01AJbKOWE3fGi7kApDNyPNYpleV9g2hQu7XaoeeRJKtg154dysD5ZrHUD3Zh5K+rQylLOBJmQjJPJIKevKKKyouizUaiKZ/Yf2O3KX6qqtzvceX5sUQoc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AS8PR04MB8657.eurprd04.prod.outlook.com (2603:10a6:20b:428::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 10:16:35 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 10:16:35 +0000
Date:   Tue, 18 Jan 2022 12:16:32 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-imx@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, ulf.hansson@linaro.org,
        aisheng.dong@nxp.com, stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, adrian.hunter@intel.com,
        jirislaby@kernel.org, giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v8 3/7] dt-bindings: imx: Add clock binding for i.MXRT1050
Message-ID: <YeaTgJ/81SY0utye@abelvesa>
References: <20220111212606.2072669-1-Mr.Bossman075@gmail.com>
 <20220111215415.2075257-1-Mr.Bossman075@gmail.com>
 <20220111215415.2075257-4-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111215415.2075257-4-Mr.Bossman075@gmail.com>
X-ClientProxiedBy: VI1PR0902CA0040.eurprd09.prod.outlook.com
 (2603:10a6:802:1::29) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcc263d3-b95c-4ad3-65c9-08d9da6b9b10
X-MS-TrafficTypeDiagnostic: AS8PR04MB8657:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB86579C42BE0B2DFDE6757782F6589@AS8PR04MB8657.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8DW72iSVQrc/wXjb9f40zX484CxFhnsHLWKFjx3HEyqnZVv2WO43Zj/2uNIXkWzS5aOa8J6M2Gdb2azuGG8hvXsF+LWNly9dPtFmgLuywp4BJ9zoKp+itHrMSsH1BdHP3e0mcEjIkOykYTwdtgIjAfVAt+rKG4C/fnKLPPLqM1kLZ4N6nDODCz0TuuhfxmAeEy0odql/6xIKBWK15lrz6Xpx8ZshPJwyvyIu9m5mNZ8feCOiPIabPMFlhGILBOZWUxxQjEWXoCTyW3QGA8fWiRx7VRZ/icIGKtVM5eTLy+h0oggjBHriNQySm/SytWl4lt96XqNlxI675k8qCbIhH/s+z/i6X1PQF6wNtC/eQAN8H1ikokVXX4p9oAULZPfhLe4wFn1tmtl8/eoy4pfMGgIqbLIxDLLPOF0MdfT+3V9wYnaMzAS+jQdF3x+1Qa0BRRZB3/7OJLwlKJmulpwvaV9VW82Aka6ICrMMNbtr+O1gh8dB665pWuVoG/b9WFpO6UMdkXnvVgevG+LgM8ECyDz9V2qCX+TKOG9Dy1jzDkfH/EpqhGo30H7RshNWZ54ugk5KCvmLi0K8/WCYTXg8nZNYWwX6dE4vW/Qe865IHGQJIZpHbwX4a8AjEd83EMqm4bz1JBN/HNHt/46jhTHhfYGdrBK0NtvpqeJncudyrvFFi9heUg0rXQRn9PQ6m2VxuK7HdVg6SlBeshgk07TIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(6666004)(83380400001)(316002)(4326008)(6512007)(9686003)(38350700002)(2906002)(186003)(86362001)(33716001)(5660300002)(38100700002)(7416002)(66556008)(8936002)(44832011)(26005)(66476007)(8676002)(66946007)(53546011)(508600001)(52116002)(6486002)(6916009)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CCzX091QWG5JYp6ZKwTWf17SQr7aPZeeS9dtEQDxKmCgAPpzELM0TaSUfo3F?=
 =?us-ascii?Q?fofWZGNY0WsSoCjSf1iDoc60CHc2wn9vnAJf/88LqVoJS4bYTZm9Tdca/nbp?=
 =?us-ascii?Q?nCP81LEIOhBtu6zQNdmYcXy3eRWATMmfANA2vjkG1ldkFjr8LN075dNeKG4i?=
 =?us-ascii?Q?Sd+nNua7ir1VW3LY4M2hrgHNi/Uce/cYL/kyUJWOSp9PGXv3iRxaeDE/JnoW?=
 =?us-ascii?Q?z6rW3O43FZX/RE79u7ZExTnJ/zVsiEpf4mLrLahvbpTtNT05TyD1ZLVp1YOa?=
 =?us-ascii?Q?OQL+LPPXzSqLnCtkru4xjkKerdJoe1+6BVbvulSrM3+ju05xEppm+DL6GmPx?=
 =?us-ascii?Q?JYQI7Gjm96TLRMfvpx7krBAMJivabXYSn4ZHgwXInmmvcEIkfshtmSjSVkcy?=
 =?us-ascii?Q?4OcZ65/RhCcovAQt8aoz0yzmMH+56PNHNSDQrD+Hw0JDaGVIrxrRRBKqVv6v?=
 =?us-ascii?Q?ENb6btMDzPWkcGBfh5NcAelSmycvyLVrAc3L+ShDoIZNTvltJYIHkiV2eaEM?=
 =?us-ascii?Q?NoQnE5EmXkFyUTs1IcXwdkmZTT9MSIiwdaFScg/Y3xgcb5HrdxF7Qhjq3EYV?=
 =?us-ascii?Q?9nz6RNpOwxwIgn+d+OrCrnw/w0BqYdUZ3iDIlWMQzTGuL+3QyvrTIKIgLj/T?=
 =?us-ascii?Q?En7adOnyMzbkC+0LbtaneGRhSVrMGr+VD9WLIerYRCYMiI9gtsQaXjMG9OSm?=
 =?us-ascii?Q?BconnCWK+0y4jdPYvzXPzF1tRxIfqOlH8dyZ64D+7OOlvhtMsHFVg2YZpEo1?=
 =?us-ascii?Q?MSRuvVBg+lBEsMeEaCG9nyGjgh4N7D18Wpcwg8whRytDJO2KxQbopOYftp6V?=
 =?us-ascii?Q?5MumIvqNwxF9zVT8jTZD3IfidUTD00YESyRH0nJiBEi4IVDLTWNKbwUke63s?=
 =?us-ascii?Q?F2J/C6vJHnCAhUcfoZOXYmqaBWQGk68eiwR0wI/n9lCimTw3TftCEw9fPKbF?=
 =?us-ascii?Q?81HWohJ03b6jXk1smw/oPdWzukdU8Nxu+lZDPHe8i0U6nzxP7CIQ/8vsWGYM?=
 =?us-ascii?Q?01HrmbUB+4lSYw9wNwFSm5ah+f4AJcyBBpSEDgjFKNOGP1+vu4QK7rprlxn5?=
 =?us-ascii?Q?s3jxy6faUJzO6d8++CWuyvq1CvRMetx/t0TzROkuZXGjDkjCeW6lrxxQzjl0?=
 =?us-ascii?Q?QbW/3VO6HpePBYa8bjZMlAQ5o0vV4w7uf/br+8QTJ1XQB8JgiunTsB1QMn53?=
 =?us-ascii?Q?lmHIC804ceMRVgz2cRxxi+TKID5PfrJa6bmEVBAD/jbN7hQt7SdapgFzaHWu?=
 =?us-ascii?Q?3WNKtRpAp5OeKANAQ6b9I6mYq3JuXjE78glCvarbuo6C5YmNJrLZfL5uQKBw?=
 =?us-ascii?Q?WzgP48WiFdW65y2paygNRCYAmDkrLMXT/u0hNDFsUUGWZTf4mY6+XDY2PmOp?=
 =?us-ascii?Q?OdvJrrbRKM8/frawmnGRbdZ+GewjlcHM6VAWqcrAowqsKAarW46FP7PBGHa7?=
 =?us-ascii?Q?c5yjaDPdYH4DVxk2JOWknZVC0JLtoXU2MYGVLquOggHn3PsrfWgZjLZN85Cy?=
 =?us-ascii?Q?QDRNDUNTSVlcvEkjyJZfr4WWLRHXXFeXkYAV0oIX3TrfR01J/pqhCXJqjg2r?=
 =?us-ascii?Q?2S5N3CyZhCzogaww5UO984iBLt2kyDfg8DEH0T0LuK9Vr2kLzl5pcYWyEBP8?=
 =?us-ascii?Q?PGat1OwGN/vrQ6ICQhUKqa0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc263d3-b95c-4ad3-65c9-08d9da6b9b10
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 10:16:34.9565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DK2XGrfvyK5damcEOYOZmVubftDNA5TjEh22qz+4F/lc/5c3h1lOZcT8bAxDQr6prhYrTjhui8xKMoDvghjdcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8657
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-11 16:54:11, Jesse Taube wrote:
> From: Giulio Benetti <giulio.benetti@benettiengineering.com>
> 
> Add the clock binding doc for i.MXRT1050.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> [Giulio: added all clocks up to IMXRT1050_CLK_USBOH3]
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> [Jesse: added clocks from IMXRT1050_CLK_IPG_PDOF to
> IMXRT1050_CLK_DMA_MUX and moved IMXRT1050_CLK_END on]

Applied, thanks.

> ---
> V1->V2:
> * Nothing done
> V2->V3:
> * Added GPT binding
> V3->V4:
> * Change License to MIT or GPL-2
> V4->V5:
> * Nothing done
> V5->V6:
> * Nothing done
> V6->V7:
> * Fix typo in numbering
> * Remove GPT
> V7->V8:
> * Nothing done
> ---
>  include/dt-bindings/clock/imxrt1050-clock.h | 72 +++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 include/dt-bindings/clock/imxrt1050-clock.h
> 
> diff --git a/include/dt-bindings/clock/imxrt1050-clock.h b/include/dt-bindings/clock/imxrt1050-clock.h
> new file mode 100644
> index 000000000000..93bef0832d16
> --- /dev/null
> +++ b/include/dt-bindings/clock/imxrt1050-clock.h
> @@ -0,0 +1,72 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright(C) 2019
> + * Author(s): Giulio Benetti <giulio.benetti@benettiengineering.com>
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_IMXRT1050_H
> +#define __DT_BINDINGS_CLOCK_IMXRT1050_H
> +
> +#define IMXRT1050_CLK_DUMMY			0
> +#define IMXRT1050_CLK_CKIL			1
> +#define IMXRT1050_CLK_CKIH			2
> +#define IMXRT1050_CLK_OSC			3
> +#define IMXRT1050_CLK_PLL2_PFD0_352M		4
> +#define IMXRT1050_CLK_PLL2_PFD1_594M		5
> +#define IMXRT1050_CLK_PLL2_PFD2_396M		6
> +#define IMXRT1050_CLK_PLL3_PFD0_720M		7
> +#define IMXRT1050_CLK_PLL3_PFD1_664_62M		8
> +#define IMXRT1050_CLK_PLL3_PFD2_508_24M		9
> +#define IMXRT1050_CLK_PLL3_PFD3_454_74M		10
> +#define IMXRT1050_CLK_PLL2_198M			11
> +#define IMXRT1050_CLK_PLL3_120M			12
> +#define IMXRT1050_CLK_PLL3_80M			13
> +#define IMXRT1050_CLK_PLL3_60M			14
> +#define IMXRT1050_CLK_PLL1_BYPASS		15
> +#define IMXRT1050_CLK_PLL2_BYPASS		16
> +#define IMXRT1050_CLK_PLL3_BYPASS		17
> +#define IMXRT1050_CLK_PLL5_BYPASS		19
> +#define IMXRT1050_CLK_PLL1_REF_SEL		20
> +#define IMXRT1050_CLK_PLL2_REF_SEL		21
> +#define IMXRT1050_CLK_PLL3_REF_SEL		22
> +#define IMXRT1050_CLK_PLL5_REF_SEL		23
> +#define IMXRT1050_CLK_PRE_PERIPH_SEL		24
> +#define IMXRT1050_CLK_PERIPH_SEL		25
> +#define IMXRT1050_CLK_SEMC_ALT_SEL		26
> +#define IMXRT1050_CLK_SEMC_SEL			27
> +#define IMXRT1050_CLK_USDHC1_SEL		28
> +#define IMXRT1050_CLK_USDHC2_SEL		29
> +#define IMXRT1050_CLK_LPUART_SEL		30
> +#define IMXRT1050_CLK_LCDIF_SEL			31
> +#define IMXRT1050_CLK_VIDEO_POST_DIV_SEL	32
> +#define IMXRT1050_CLK_VIDEO_DIV			33
> +#define IMXRT1050_CLK_ARM_PODF			34
> +#define IMXRT1050_CLK_LPUART_PODF		35
> +#define IMXRT1050_CLK_USDHC1_PODF		36
> +#define IMXRT1050_CLK_USDHC2_PODF		37
> +#define IMXRT1050_CLK_SEMC_PODF			38
> +#define IMXRT1050_CLK_AHB_PODF			39
> +#define IMXRT1050_CLK_LCDIF_PRED		40
> +#define IMXRT1050_CLK_LCDIF_PODF		41
> +#define IMXRT1050_CLK_USDHC1			42
> +#define IMXRT1050_CLK_USDHC2			43
> +#define IMXRT1050_CLK_LPUART1			44
> +#define IMXRT1050_CLK_SEMC			45
> +#define IMXRT1050_CLK_LCDIF_APB			46
> +#define IMXRT1050_CLK_PLL1_ARM			47
> +#define IMXRT1050_CLK_PLL2_SYS			48
> +#define IMXRT1050_CLK_PLL3_USB_OTG		49
> +#define IMXRT1050_CLK_PLL4_AUDIO		50
> +#define IMXRT1050_CLK_PLL5_VIDEO		51
> +#define IMXRT1050_CLK_PLL6_ENET			52
> +#define IMXRT1050_CLK_PLL7_USB_HOST		53
> +#define IMXRT1050_CLK_LCDIF_PIX			54
> +#define IMXRT1050_CLK_USBOH3			55
> +#define IMXRT1050_CLK_IPG_PDOF			56
> +#define IMXRT1050_CLK_PER_CLK_SEL		57
> +#define IMXRT1050_CLK_PER_PDOF			58
> +#define IMXRT1050_CLK_DMA			59
> +#define IMXRT1050_CLK_DMA_MUX			60
> +#define IMXRT1050_CLK_END			61
> +
> +#endif /* __DT_BINDINGS_CLOCK_IMXRT1050_H */
> -- 
> 2.34.1
>
