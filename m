Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCB44F946F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbiDHLuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbiDHLuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:50:18 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10043.outbound.protection.outlook.com [40.107.1.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6DA4AE17;
        Fri,  8 Apr 2022 04:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ix9ZT15fgxKr7h+c5ylzNSAitRSq0eTA+j799K+R/GJSMRpKepxAUN1FVC70QYthd8gkB6runKycsLIZeof1fS5O2l1CYK0kWhZnJAN+D18t4k+GKX87TqusP7sA41tQXXTapMeKKS6FC4W6fTbA3jPqe0dB3oGn6NrUhh6si1u5yEiGrQRn0x0jrjpB7lwCSFjfAvf3iRusC/UKI6Vukxmm5mDnXt3t38jUVKh+KK6vqBXxu1CHxNeHXLs/hyDOUAkA1JulWteJ0gS/DtJzURmQ+jYdFj+j5G1vJ2rgqzX+dvlFVnBtf28GM69ywoXJKv4jXxpMiOEYSKXh2pAmpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vaFwzkFh3lbkH03BkYSfpsrXkN/0617tTGZUYgypBs=;
 b=cVesrQs1R2BKocDJGOgrID+6SiR2TMD49wQjNyoSRghdiG/fdHMAEyuNjzFgfVhY1uzMHBDhpvXm6Z2YL/yRbZ9v3N21+smeC3yH74VnWkpgSZaGXNrmBwMCKeGsEzw2VrCkcM07jn9U/tzbPnFUav9JGUJgcZ6c0UzepIhR0WTaVB9YRX6rKEEh0z3780KRdUTkQyTaaf26X48bwr60agTZmDp+EPA2dpAXg04rKaxov6TlzH3n3Xw0idGF5ka6LQb4jOq8fu05xldVcHu0uMVjBV5JBJR1KqYIMOA9GVqQNnKLuWZIBO+hK6tDoNcZW0FZVhlJEv85dPani7di5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vaFwzkFh3lbkH03BkYSfpsrXkN/0617tTGZUYgypBs=;
 b=jz44/jAV0Dgllopz/8ZG/giohJyJYgW58lA3Ix9wfuDSOPuxTqfiK10fxgfUB93qUBZJQWzLA0Zqe51pqzA7uXtPWNFp/EFGbjwfNKwKfI8SIMUpBJJBYO1u8Htav789ZIL1S5pB3AyoVrzv5Fwu41aRNSn996Fkcfa/ljZgiQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DBAPR04MB7415.eurprd04.prod.outlook.com (2603:10a6:10:1aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 11:48:11 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f%6]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 11:48:10 +0000
Date:   Fri, 8 Apr 2022 14:48:08 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: imx: add clock bindings for i.MX8MN
 GPT
Message-ID: <YlAg+Me6YcwTwZg0@abelvesa>
References: <20220317223600.175894-1-alvin@pqrs.dk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220317223600.175894-1-alvin@pqrs.dk>
X-ClientProxiedBy: VI1P190CA0032.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::45) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36632f2d-cc75-4466-83f2-08da1955a7ff
X-MS-TrafficTypeDiagnostic: DBAPR04MB7415:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB7415CA3E766063359BC93412F6E99@DBAPR04MB7415.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: igVfYWxPT/XkIEYXF09XxM7wTYIcYfva11LFnQLtTIm4D0jdZLNHNhH1zBWYOOMU6M9brFMYrCoEfdzB1i6FCxSSaMqOx+w+6KcNzOu8ykIweG6OzlX1nskJ4NMB0FFJtWAZyjcGDdYOvQflSBuaCHyKYLUoaydd39ifsSn/SLRm4xxhaF2dJHQwCG900KvT3lbPPaPdAcSKMCm7LF8eOgFm+NCadL1m7ptEeiz4oPhEhaAbtjxPmYUW4oseDSe8w0lJCyVDURfsmrHAF7cEqDbRTn7tjgJGNv0ODZduuyb+L9djIFuEVzSBHKzyVhpF6F+xIJl8SfYSsJeG1BrqhX/avpYqO0u6aXy8irbfdup1dSuKOfLfejBiMxx9KHExONVaFYEiEl3qEKzuyNZ1hcia3PMw4EMyRXuRDvBrKLMU/fd8Mn95BRyleYPNzanpdlCLg586Q5cNGoARJjq0ywq0E48Nus7Hj4ScfhdkRrj76nXaVFeONjBlWBKhZgkTRQYk8JQewnSLT7tfH7T8QVG0n+Sjw0S/Y4tnIBiabxHY8wTYeRa7+hheFSHetYpwhLRB8fBli+VBlHF8KZFLlOz7LrahK5CUt2OtdESRYv87AYJTl1/cpPPBCqEt+vyESTmhRAgwEICMhE9yQBo1B1kPteOU8IdMFSivBPmI6v8Zc/+D78N4R8BOx2msE8FMCii3QiGky8jq25giCSXClNnn5hip1arGxq5hJcGT7/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(8676002)(66946007)(66476007)(38100700002)(6486002)(38350700002)(66556008)(8936002)(7416002)(4326008)(52116002)(6506007)(33716001)(53546011)(6512007)(2906002)(83380400001)(9686003)(86362001)(54906003)(26005)(316002)(5660300002)(186003)(508600001)(6916009)(66574015)(44832011)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW5PTUQ0NHMwL3VUWDRsUjUyVGdPODd1T2Rzdnl4Z01uSGNQQ3Yrb1ZuVnRF?=
 =?utf-8?B?aVJPb1JTbGN1RWtHYnNSZG1mdUtyODFhWkdrZE1iYXIwRjY5T0xIeUs5Yld4?=
 =?utf-8?B?QllJN3hha3BrYzFsUWVqd05SdW9oTVdtbWtPWlpWSzNRMEJEM2FlbzJ0N2dZ?=
 =?utf-8?B?ZUJGZ0hYb0Q3NW9DVHJjV0JUTllWcW9TeUlESDB0T0NDcEY3aGpLdEhmL0tk?=
 =?utf-8?B?S0xWNzZRNEpOUTBNTUJnZnF0dGtkdnRMNmZobXRLSEtBMHRlNnlMa2pZT1hT?=
 =?utf-8?B?N1UySzJJM2hUeU5HcDdRQytVenhZNG16WDZYYjhHNHpibTJJdXBjOWMwTnFw?=
 =?utf-8?B?WnlOREgxd3Rram1yMGVBaUg3L2hRYzFVdmRTaTdscExEY3Q0L0VkeFUzQ25Q?=
 =?utf-8?B?eEZucFdjTEtQZTduTWYwY3V3dHRDZmMwVDJESm84VlBJZGs4MUJvMEMxU0g0?=
 =?utf-8?B?RXdKdHFEcTk1cnRIWklzT0JoSTB5NDlRaERZcDU3VUNvRUY3WXExaS9JTWoy?=
 =?utf-8?B?ZkszdFI2eVMyc3RFRzcxK1gzall0NHBkdTBxeFI4LzhFbllqNk51OHp5TlNn?=
 =?utf-8?B?VEpUUEd6eDFXSTJjUVYyWGhPcFBJRVU0Qk1DdmpyaWNiZ3FldjZmK2xvRnVy?=
 =?utf-8?B?WEU0b0hsYzg5dFVGYTdETnNza1ZZRlkrbDFtRytwNUo0bFdyaWQxb0FRVUlx?=
 =?utf-8?B?d3l1UkVtRFZERkxJb0YvT1l6RVA3L1RGOXlZUW04dUFINTYySlVrVEhsNklW?=
 =?utf-8?B?TXYzdXQrVzlQYUl0b2dKdW53MFJhVGdBUDhyU3JlNndwaHIzZjZCZnE1OHNS?=
 =?utf-8?B?Z1lwN3VwWnFLaUxYa2FFNHZsazVoY01taUc4VDFNR09UUHZEQkRZZExvMEJP?=
 =?utf-8?B?NkxvTFRXVUZ3V01zcXEzbmZjVklyMnJDTVUrUW9wbGRSdFU5Tk5zVkxQT2JU?=
 =?utf-8?B?ZVBKVWpaK2JKKzFSWFQ5QVVRU2hNNExWNXNNc0dybEZReGNSL0dWM3N6R2RR?=
 =?utf-8?B?WXpXa0RWTTBkbENWWXd5bmVBYTd6TTRYZFE1a3JTemFjNWwyaGkrUkJCWnRz?=
 =?utf-8?B?cURjcG9NWUdGVFpzSkYvR2NwQmE4b0JCTjBGZ1ppSUhzVlhRQUp4eVVSQWNq?=
 =?utf-8?B?MFFBcVNyQnB3SUpEMHl5REVFVGh2MUhZT3FPWmpwRmthM1E0SzRPYVl3VmpR?=
 =?utf-8?B?aDQxNzJSRXpDam10ZU81YUlqTmJML3EyNlZ5bzZDRFN4L0g1VHVKYlVBYzg3?=
 =?utf-8?B?RFlVUG00R3A4eUpTVndNL0k3eDVYdTFramVjWVFtTm9ZZFFRQmYwRHVycHJk?=
 =?utf-8?B?NUlzSW5VUUY5QUkrYUVBTGtHdWRLZzRBampsWUpuN2JmOE5yMVdnSkl1TmU4?=
 =?utf-8?B?YkJyUE5NbUhTYjlGR3lFS2VrQ3VFSFhkTzIwV0l6dGszNmRWc3pUd1VGcThB?=
 =?utf-8?B?Rk1zRFFCK3FiNXRVakNnMnNuVUpSMHpXTEhlWWFNb1VQZnhwVTdDTjZKaFZY?=
 =?utf-8?B?R1hHeXVrbHpHVFJuNFNQNFZmRXlzTFRIU2dBV000UVlYZnJQUitmOUpVdlQx?=
 =?utf-8?B?cXRCQk10VzdQK1B3Nnd6M01PeURUbU5rQjZSaXFOSGVwNUVFVm5URWFScGx1?=
 =?utf-8?B?azJIdmw4cUtZejd3bnZHb2tITGRRNUtBNi95OWZWUnlUSURnVHBnYTgzZHI4?=
 =?utf-8?B?VytEQXhKRnYwdkRqNzMxZWRkMWxQcHFNcEw4WkZPdTZiVXF2VGFKVEk1WUd1?=
 =?utf-8?B?NlZKaDloSGVSYXByV1gxdmVMNlBHMm12YlJPWW9HUzBUdXFWNGlrUG1yaEVu?=
 =?utf-8?B?WlMxeW9GMWwrMDNNeHNQUlFBejkrelJrZ2s0Yi96M1RSZ2I1Z0pmSkhQazNs?=
 =?utf-8?B?WlcvSXl3Sk1UYWN2NmtwMlVUZlRRdnVVbGoyenE2ckYza3pHeG85Z21ndHly?=
 =?utf-8?B?TGpTSkN0U3ljc3ErSnd5TE84LytQU09HWm5OTTcvWFhNUDlMSW5WRzc4d3BC?=
 =?utf-8?B?Mkd2SzI1L0N5SXNEcy9FZmhQNTF6MThJRTdvMERoLyswWWNRYjdTQTdkNmVG?=
 =?utf-8?B?RGg1R2tsdFhBM2VvTEw3RGRHUi9DQ010NHpUdk1PVGJNMGk1VktPekZrRWpv?=
 =?utf-8?B?WFhOWnpDZTBQQTlnaFNOaDV1dHdvNzhGcDFuZ285c29USC9OWTRQNjkzbHAv?=
 =?utf-8?B?elFGS2dhQktYb24vcFFMNEVic3h2VmdvbTZjSVVJeXJwTzArZkVGT0FpREsv?=
 =?utf-8?B?SG1RTE5sVFVsRXdyem5JVEVsVnRWS0NhMGtJUUtjWE11dUUxMzVINnMzSS80?=
 =?utf-8?B?YkNOWEJpM0pjTnFSWWV1Vm01VTVyczdFbXVPTjRnQVl6djdVL1VxQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36632f2d-cc75-4466-83f2-08da1955a7ff
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 11:48:10.9207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnawMrjjDerVzkgt2Q+abpBWtwkQgEdCeEaaiR7MXlUSJjXl8WRur8OV4DTP6L855evlHMNJAW9UISxpG21CuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7415
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-03-17 23:35:58, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
>
> The i.MX8MN has a General Purpose Timer (GPT) just like the i.MX8MM,
> which already has such bindings. Add the relevant bindings for the Nano
> SoC too.
>
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>

Looks OK to me.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
> v1->v2: no changes
> ---
>  include/dt-bindings/clock/imx8mn-clock.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/include/dt-bindings/clock/imx8mn-clock.h b/include/dt-bindings/clock/imx8mn-clock.h
> index 01e8bab1d767..07b8a282c268 100644
> --- a/include/dt-bindings/clock/imx8mn-clock.h
> +++ b/include/dt-bindings/clock/imx8mn-clock.h
> @@ -243,6 +243,20 @@
>
>  #define IMX8MN_CLK_M7_CORE			221
>
> -#define IMX8MN_CLK_END				222
> +#define IMX8MN_CLK_GPT_3M			222
> +#define IMX8MN_CLK_GPT1				223
> +#define IMX8MN_CLK_GPT1_ROOT			224
> +#define IMX8MN_CLK_GPT2				225
> +#define IMX8MN_CLK_GPT2_ROOT			226
> +#define IMX8MN_CLK_GPT3				227
> +#define IMX8MN_CLK_GPT3_ROOT			228
> +#define IMX8MN_CLK_GPT4				229
> +#define IMX8MN_CLK_GPT4_ROOT			230
> +#define IMX8MN_CLK_GPT5				231
> +#define IMX8MN_CLK_GPT5_ROOT			232
> +#define IMX8MN_CLK_GPT6				233
> +#define IMX8MN_CLK_GPT6_ROOT			234
> +
> +#define IMX8MN_CLK_END				235
>
>  #endif
> --
> 2.35.1
>
