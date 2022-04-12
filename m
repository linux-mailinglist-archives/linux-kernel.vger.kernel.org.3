Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70ED44FDEE3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349501AbiDLMCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244761AbiDLMCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:02:09 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20073.outbound.protection.outlook.com [40.107.2.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D98673D1;
        Tue, 12 Apr 2022 03:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uzp0ui6iX0lz8trs+GaBn2nb/TSH1uFPtrOqaqZS4DXqssCknV2uGiIc3O6Oc3a0MmR66dQ5669G2Lgob9X4xmmGh53Sn+SZWlm1hClqkUgeW8NsGSRG7mSL6M46knff/ETN3fOIdogobVgTcLHaijH4h45erUYGqtJKAHPMOenM5e0bA10GHcdAcnehEKainWn6lEdBWtcjHYfn8j3IFv/elHBV9fSxBXrPRNgjeAqO5Z4sh6wKgxNmlk2saA5Et6hxoX1Rb2th1K5bp28QgEcPSOeslTyvpXi4+bDaE4/W7EyACYB7MerfewfgJTo8od5O/EsYdt2ZuPFbRRCNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrOlTTMQP1qQO8O7bH/P3v4R5s2/PYP0iaiT+LVF9Yc=;
 b=nVX4BHlzjiZe5tTmZUiTTT8pUJx3TlTrO3daT4l5lPXWGLodowyp9s1ENw44Pq+a7nIaVXDc9pCGalXikr7y8AK8jlLotrRI9m7c6bATl1QxgLEl6nsIPegIICPWR7bNguYJap6Uby1YOy7GFo85TCOsQOBqjta9u4gzbIUT/SwCVd5yzckIROK31XH0iAEFuKPUOokOzTmx7EdOAR8Dho7MWaOMSQO+4flesX9tgEAwsoJIPmBDZJP4/hi2pHiU/FISyiyTteM6k9X9Qh1iFTn4gqODBlTtg3Ip4qc/HWlgkqRfSj/jwXyxrnwTIWlrVY0Imbm5Gy6nrSo94tDzDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrOlTTMQP1qQO8O7bH/P3v4R5s2/PYP0iaiT+LVF9Yc=;
 b=fpU29bEk6lRmg5j2SALqP9DPRkOw8iLMBsCHoLZVETLxwsAp244c6SgAM5YjpjQ9/WPEb2C+uJpECv1ZDNeU90ad3W/dNcDmBZOmSIyIWXmDRvQGwJeD0WU7HaT5uTrVvcQkilAG/Vru1csof3eoZf8//Nf0iIPyYoaMwhfL020=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM6PR04MB4951.eurprd04.prod.outlook.com (2603:10a6:20b:3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Tue, 12 Apr
 2022 10:57:05 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f%6]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 10:57:05 +0000
Date:   Tue, 12 Apr 2022 13:57:03 +0300
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
Message-ID: <YlVa/+0QV7um3UtD@abelvesa>
References: <20220317223600.175894-1-alvin@pqrs.dk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220317223600.175894-1-alvin@pqrs.dk>
X-ClientProxiedBy: VI1PR06CA0101.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::30) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a4e9973-8487-4703-45c9-08da1c732e73
X-MS-TrafficTypeDiagnostic: AM6PR04MB4951:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB49513D3DC3560512DBB84B76F6ED9@AM6PR04MB4951.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDqeWOhM3io703n+jE0Rl9k+/VXOhQWbEcU4uD7j2FF16QLJ38IvHDT9MQ/q9OgzbqcJ8K+auWTXrmDdB5go9dKzrTzxiNTraWdyvzSUXKRNgjIx0P+aWfIgQcYqnRPz3Cll32+oWZeIKyy6LD+WpCCC1/Jnmf/Rr/MKcU8QMlJDaGg+x1DAeKNm6so7XKznAqdcPvs6tyFgIxIMUh3qjx28I1P2r2VgERqN5mTgpjX+f6t1Lq9LzzYgYZN8AOdomTWtnI2VmtD1gOoJA3mWV5sN+sfoDZ2fppMNSOUyV+TsLdXIBLkz74ltQFyv9c7iL2ivUSSnyQm2xwl0fFfteOfQPn9iSez1nRhs2rPZLsr5nrNilpOI0O9ZAdNgVZDQeFqtXzkWxNh5l7AcCy48r8/Zo+zk9NIPjnPP/6TCjOKD2VjHZcTP9Dq2FBSHzzLPy2ao/w2iOhnkVc/JNYqm5iWECiotBVSedjRfLkmyI/0Lk9cGIMVIEdN9vq1teQH6Gtyg1kXvJ5wstsBCrj3tkcptAX9qH7Rcg3bBoDQmXhFum8UNQ1OT9qKRmn0mhnAjAnAcDsKw80x+OsAJLG+xnqJDBdFYRT3XNFxRTWCFdis6EzZ3mGjEjTLIjj0lM4wh6icuJrrhDA98W6qiElTv3qe2qgymRA7iWZQC0tNuZF/u3hAuiKwIyXP1fPJ4vxaOoiKEy6PuR7XRG9wTKCfkmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(66556008)(6916009)(66946007)(54906003)(8936002)(316002)(4326008)(66476007)(86362001)(53546011)(9686003)(508600001)(6506007)(6512007)(52116002)(38100700002)(38350700002)(8676002)(44832011)(2906002)(66574015)(186003)(5660300002)(33716001)(83380400001)(7416002)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjVPTUNiTlQzOVNBVDJwVGszV2RGbjZydEZETHhBejA5dG5lcGVtUndIUXBL?=
 =?utf-8?B?L2NZa3BwNXplLzVjZnBQODV6aER5ZFk4MTJqR0REUi92ak9KVGczeE9oSGZU?=
 =?utf-8?B?MnRCVmhsRDc2YlVIeEluM096RXNJa2piTGZLZksrSE1aZlpkbUNWbUthbUFM?=
 =?utf-8?B?THZ6V2l3MVoreU1rOGxwU3ZqcjRtWWI4NWtuc2pOOFFJQWc0SmhKVTdGa0FL?=
 =?utf-8?B?c0dPTktGaWpScnFEditaNXk1bWpqL0w3ZytQRGdIQXN3NmFCSER5dTlwbEtF?=
 =?utf-8?B?MVZJNVJER3NJdWtGWXpNTXBrRHlySWlsYWxoMFExVmQ3aW4yWjEzTzVGakM2?=
 =?utf-8?B?YjF2UjZyT3UzRml6TnordERaY1NXUWJnZDFQd2pjZzRzYkJnejI3dWd6NXdL?=
 =?utf-8?B?YjMrbXJub3JYK0JUVVlYelN5bGw4dkZMc29CS3VjcDVsTlpIWE92cUtqUThZ?=
 =?utf-8?B?ajR6cTk4eWpzbzNUUGI4a1gyeTBPUjFaVGNFV2FYMEkvQTJ1U3ZqRmJqajVX?=
 =?utf-8?B?c0JNQktOWTU5dU5DV1FEeG5jUGMzSzdsa2U1VEVjQUNrVnpMM3U5MEl6T3RT?=
 =?utf-8?B?cTkwTTh4QTkybnVDMlpuTUtoak1lNFp0MWhvc1dKeGFmajh6c0JzZi9pYzZj?=
 =?utf-8?B?MHhwT2JLYjk5US9uNEsyanZKZnQ1SVhuVFZlc2ZmaFJGQlNpdkROR25mUFNH?=
 =?utf-8?B?NVJ1YTF5OENoYi9uZ2lFNlJ5d3hZcjlPZVBtUG9Zd1ZMQWR0SHo5RlBHN0pG?=
 =?utf-8?B?Z3ZPRkxTNnhNTmhDQkwxUzAvSUNTZVJBVkNQeS9MT2tOSGx6TGVXTFhPM1Nw?=
 =?utf-8?B?K0ptNVZxQ09uMzJnTWhCRWQrZUNZL2YvSjBmUkdKYmVrRnlMMnQ2bU53VzUx?=
 =?utf-8?B?eDl4VjI2TWh3akNibzNJTGVmMFdNRzRaVjloWEFEYUN5TTRGWGsrRDNYb0xy?=
 =?utf-8?B?dVk5V3l4LzMxcGpaT0lFR3lIOW5yWE5uL1FZOXFqZEZXLytyNkRrS2xja1FM?=
 =?utf-8?B?REp2TTB6dHIvZ3B2ZE51MisrZ3dhcWxhWmhuYmExbEZjMmlKWEZSckQxZXVi?=
 =?utf-8?B?UHljV1pQeHVTeGt4MDRLc09VZkZST1NYVmUzMVhxS3R0RnQ1S2RJMDV0ZVov?=
 =?utf-8?B?d1NnZ1NzU0VnbGpoSmlhUmhCQ0EvaXFYOGdNdGVIYXBwcDdmQU9ybzdabno4?=
 =?utf-8?B?YkFjTGR2UzNuWkN6RnBtZGZuTFN2SW10UGd5UTZWbDZJU1ZFelZzMU5sQkxV?=
 =?utf-8?B?cm8wb3pOaGdUYVFoUnVudm5NblF6OHFIR2JNSWtGblR4Y21QTGc3dzBSajhh?=
 =?utf-8?B?MWU2R2pCT2JUMWVhY3hkU2JjNU14NnFDdWhDVG05V1d2WDFQbXVPTnEvRmhi?=
 =?utf-8?B?bHNYSTFrajV2TG9WamFVUXd2aTllbHIwcVY4RnA4WDU4UGwvSTBaTVY1cmxI?=
 =?utf-8?B?ZEhpOFNYWU5iRVFQQTFLK3gxNS95NUorcmRKdCtkVXdHem5XTldNYm4zVFJh?=
 =?utf-8?B?eitGTzZnWHdqV0dnY1lDeWRaMGpvUkt0RWNmcC95YXMvdTN4cWRZV1liYlgr?=
 =?utf-8?B?ZW5scUZvWUJjSm83TUZhbzNtRzlSSmZHb2FQdno1VmVoYWZSZnliMmVaTWFu?=
 =?utf-8?B?R3phb1BaSXhxamoxbzMxU216SUpWRGw5VGRoM3dHYjV5VzF3TFo5cStCNjJL?=
 =?utf-8?B?MzVrb25LNWt4QUlJQ2ZPL0RPdFphUzhPUGs2bFZBY2JNb0RZVTZvdEg0RXpK?=
 =?utf-8?B?RmZzYkFrQi9XUDVXNVBQTGFPVmZmcENtZklPemtobVVwdzc3RmFwbzI2Mm1M?=
 =?utf-8?B?bHphS0lkOWtGZmt2dVBoY1ZId3Nma29uT0IvV1FqbkJUOFRsTFNsNVpwL0t1?=
 =?utf-8?B?a2tnVldHbC9EL1ZBM0VpU3g0b3VUZHpBZjJtNVFKQVVJQXY5QzNXY2pZcVVP?=
 =?utf-8?B?Qm9Zbk0ydi80cEpZWTZuc2NJTGhRQUNaakNJQXJoenI1bU5uTlpveG03Snln?=
 =?utf-8?B?VzZPZG5nbU5qamhRV1psR1NBcENYekdqb0VQT2ptSDA0Ymp1YUVFdkRtL2NK?=
 =?utf-8?B?R2V3TmFSV0M4U1ZLMzQ0OWpnQyszaVd2OFVCMW4xL28rbUw3MkdMRkhhdXgy?=
 =?utf-8?B?UVRyT2dlSUQ2TmN4ZjJqaGROelpsTHV3NzVaZHI0bVBDRDVXNHQ4cnNQb1dI?=
 =?utf-8?B?ZCtzSmhWZmJjRi9nbWVPb3NaV0RUNGlvNU1rNE42WFJxRzFYZlZjZjZEaTFT?=
 =?utf-8?B?SkF0MkpMVmluS3BCVlJTYVNIRzd4dzYvTkVNUHRiTW80QVdUUFRTT3dSSUZO?=
 =?utf-8?B?dkJSNjdxaTF5WjhhVGxDSmtISzRCMkNCU0tINHJlUEo1VzIyYXRqZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4e9973-8487-4703-45c9-08da1c732e73
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 10:57:05.7469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJ8B8hf5ldt4yIJJaeHZyKQyXO4UQBA/zvNs71QOJQqf12ujtbphb8v267qG65djrPDjsNau44QnOjhMKx1IIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4951
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Applied both. Thanks!

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
