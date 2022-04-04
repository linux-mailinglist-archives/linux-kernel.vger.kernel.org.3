Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A7B4F1EE5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382355AbiDDWJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379772AbiDDSEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:04:13 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2122.outbound.protection.outlook.com [40.107.113.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F31B37BCA;
        Mon,  4 Apr 2022 11:02:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEuUpuKsvbm/BsfqoybsH6EJyC0bUZK/DD37LZHyXWBGsqYSkuDNe3s7lGoL6EfjM8jEwLnuyBoBBM/hnxtlcRdHYh7m5qZ+Pd2iuZAio5UzNOLf/f/Lg5Du6MqD1lz4bJY8YkHDhTUB+2AEKJ4CQsMf2jBmiFJ1Zg5Dw2wRAJ1/1bR0Nh+Bn/AP7eKg2GjhP1oB89S0krsTjaSpWybE9eZC7a6qvJ/w9Xq52OkSEAFyDwrY8+1cp+ds+iOIiIG8jbN7dCYrAkbtcYc1plTs7/cq3TZuOWDudPuEkzxPBJfbzAq43YN+zXB7EAaH6fLvWXZmldHi6UCJMeIV9Ayt4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyD2dEX7H0sfudCrKoeJATj/UlcwLm5YmQ8vGy67Oug=;
 b=V5KjXz44YHGr5JuI8HPp+a+EDPGYLE1Akie0zVbw4S43as8j7+xsvz6qSoavX9WtwwHiNOWs0EKvSHTXtbnQBqngTom0qyBTDRIKDSmpx25t7SsafAX4L3CHRM1lUP6VocLfV5JH06X1TtKE8b2QKJaPjCXgqCmpVdGQBzf1o2MNu4Qqyiy/3s1O86upFU6nsPb9mZ4HY/p3hgl62M2hPWN0W+Q6uhCN1j7I5zzabDJderTDtHkSXUYnlNKePASI0tHBwbLP2RN1O93b23S91ZlI6G39Y67WlaGKBED6DB6RappxFZQNcWBK5vWz8szY5Z6LF1vDANeSbQFlxGsqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyD2dEX7H0sfudCrKoeJATj/UlcwLm5YmQ8vGy67Oug=;
 b=aAcP/F8AyFcvPP8U50gDkI5lCKGMoQ5GjC+BQaMfVMldFnNrW1Aldc9rPchJof3WH6TpARHKajAmZ+4KESXFvY0/Dihh1dvYFMvrg+CjWq8rnaeq4JbHiS7mu0svjGmSLwzPGIOGW7/vSu9W6MCnyETG6ymOMdQB86X8sV52BHg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSBPR01MB3111.jpnprd01.prod.outlook.com (2603:1096:604:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 18:02:11 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::7ccd:4eb0:e2ae:fca8]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::7ccd:4eb0:e2ae:fca8%3]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 18:02:11 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Pavel Machek <pavel@denx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 1/2] mmc: renesas_sdhi: Jump to error path instead of
 returning directly
Thread-Topic: [PATCH 1/2] mmc: renesas_sdhi: Jump to error path instead of
 returning directly
Thread-Index: AQHYSEjXOMLpIeOQFkaJsJDtWSjZC6zgCvxg
Date:   Mon, 4 Apr 2022 18:02:11 +0000
Message-ID: <OS0PR01MB5922182F6302386EFF2ED66B86E59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220404172322.32578-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220404172322.32578-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220404172322.32578-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea0e63a6-e346-49a7-7e48-08da16653e24
x-ms-traffictypediagnostic: OSBPR01MB3111:EE_
x-microsoft-antispam-prvs: <OSBPR01MB31110E44C7288B3C4D612E8186E59@OSBPR01MB3111.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eGOnNm0ZJpCxIO5+gABe7p1G57hfzuNGFNg0Ypou+MTKxf423MlLENv6axGNjFAHLuMV0RrRnTCIcfQ3EdWPihO7JVWdFoJ6XRjO98snv69QkFMCU/xi8lKPGaCvbh/Ozth5sR1Kg+Pz0f7iB3okzNPcXQSyxIKyoaHufExRugd4T6rBFQ3yuDMdxNWDgr5+eHG6u5oGi5DgsbgJBBksEYPvvu125SG4buL8voSp1igvgk2SCCR+PR7OJ0zKmYrZmsyXZWvlwF6P2SP6cwhEOlMmaxw5Md2SIOsxoNW/4sW5lq2RwX94kDuRDj/LVnQKQaOHwDPDh8M8+usxHRwAzTA6T8taYtbdkTt/Op+yf/GuA0V9j93OIlSmh9M1vYVAiJ4EBdWukGw0QjaAoKRkTIOOZjWQ3HzscLaWeBO2gtDnjyKI8uHt7EG96J7bS7wN7kcvKY+WBaru+59WhSQscNzPCIkKEigCEyo63EjqCgJ1RAnd28XHfbzVzofe2apOlfgZCbXdN+w2kx7Yj5xl71/RIC9dA3CpOZ0nv3MGBSKySX1bK+WnbO0r5gGRCw7ubt19fyDnFBGhjKZLwqAAEI6iEDXDQX4gEui6uI2IQ1gde4bKtr8wQUwm2XzS1dVnm0G1Jot2hkjAPXwwnovCo/HLm/23ElMmPwReB+S/8X1dJuYl3qUJKQI0J1Vp87a8HIlxqu19UdpmsqjB4K0B6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(8676002)(66476007)(66446008)(64756008)(38070700005)(66946007)(76116006)(186003)(9686003)(4326008)(52536014)(26005)(71200400001)(33656002)(5660300002)(86362001)(55016003)(8936002)(316002)(508600001)(6506007)(2906002)(7696005)(54906003)(107886003)(110136005)(122000001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3wzS2Z4iHIV/s+497eB/qe1Ipg6ton+g6/pZGLzjKR3S4nq6MscTN577UIQm?=
 =?us-ascii?Q?rmbC2wB/t8qLoWMd3x0dUhAdwRygo1IX27a9qjfdsB2zQ3BY5VHDzh/LahoG?=
 =?us-ascii?Q?G7QbYV+teSQTjWbt/i1rKc+wXu1cU1jQE3NI1wscUIRJtNNji1Tp8TnBiFtH?=
 =?us-ascii?Q?SnLpirOqANVhjkanlU3er3Ct+ACaRlcIoaq3JOMWxdQhtDidLZsvHGZmeti6?=
 =?us-ascii?Q?H6xdIjwi3+cpu7EfqxD06zjXDWWEM5yCuY/a+fo9bLx9UwNBWcWethYMvwNp?=
 =?us-ascii?Q?6lQLcBb60NLudfzR8zM8nJVLxoauqYdMmS5fnd0H9oFsuXEfrC4YUZOCBhq8?=
 =?us-ascii?Q?eTLm4G6iABWcJkh6s2+FLati+hkh8zuyknbuhONGUWvsXcJUz5WbzO6IFa0c?=
 =?us-ascii?Q?CAfOKtrus/2SKPpg+BEBrC6QXP9rXmawlWVgAMGDkBQqvqf/16OplqH3Vqpe?=
 =?us-ascii?Q?bHqfRKDb/mU0M6rXtUv1H16vekTOPw4Or6wravcwJywLtD8OppSRDB8b+Ykc?=
 =?us-ascii?Q?pIsmizLhdevBTP80roC6gWMo87+5dPtodupc561ORUTz/5cbHAGocfcowJhP?=
 =?us-ascii?Q?TBHzoa/7fCGZdw2vxjMiEachF47NIZWGRP1F5CejfZo4HFEn//x8s7ZLjpip?=
 =?us-ascii?Q?QM8WUzxuQiS6Ln9h7ISLJ6cQI0nd2bTg1nD91UxPw4Y/HtzmosFobEvLtCY1?=
 =?us-ascii?Q?oxGb8I0Ih2oQEmS0io1yr60GIn5qVaX8RYuFCRXVr5wV8Sx4+PwazC1OzJEA?=
 =?us-ascii?Q?T+RPxI5YUywNf8rOYXEfOGWnIOU//fqpWzJb83iiJutkciO40d571Avo9IZY?=
 =?us-ascii?Q?vFm0/WUcZM3Kc0hTvb6Vs8C6YszFI+H/ZOuKN1L3MVigYXQEwob62LHrfaNr?=
 =?us-ascii?Q?oubhLd/kB7VfiyRncYglFhbXiI/A87+21aORwdMwvU35VBjw7Gcm4xkUTArX?=
 =?us-ascii?Q?tJ5t/y3A3hoxVjcuYsK9peqfD9637lpF7kTWcXZmxZWQdhzzekrTkQpM8gCI?=
 =?us-ascii?Q?v4/1oEDG/Pshxhq2Fb9TioK81eDoK9UX2hKbc6DMZcrqHO5kS7VHQ+7YxlYT?=
 =?us-ascii?Q?nvLR5X/i+4OmL61ePaJ3iaTfmEOfbr3twR6VOqLmbWxhrGa4kj+fYFRDitCh?=
 =?us-ascii?Q?JiHzVdBb9DY2WPtC0AdqSefMfUifnngqW3d3Dr7ws2j72WQrCKW5CTjiiW9J?=
 =?us-ascii?Q?9u+GQMnqCi9CAxDLMeXQMo4n/b02iIbyrhQOhzvmkrQTCwB+dBe8uCu1F0bn?=
 =?us-ascii?Q?5jWNwkU9CeJewt6+Htxqa53fnToieqvSJak0M17dUd5U/RsFYXtZdj4FXeiQ?=
 =?us-ascii?Q?Hd/Sz0KKTYn7W3jxNQqWdyCLoPA39cptmDvv4BAp5RreKVXrc8ZKxJu0uYjd?=
 =?us-ascii?Q?yynVRt84faJn9ReU54JrxNtSOEEvRnIUX4M/b83zC84IVQ80rlkf7yf9yf3D?=
 =?us-ascii?Q?5Pnn+wX9O3psJtzasOCPkevdP3ojUWqD/ohBiA1MOuVgJfANNZn4CO2o8yQl?=
 =?us-ascii?Q?6kp+xHylUWV+x1GAhaV2Vy3iJcTnD4CQD45on1iBBOMpUuF03I6Gr5IrY9qb?=
 =?us-ascii?Q?fTDh0TRYomsZFhp2YOEBqM/4OfSW1T5qwETAR4yBWHNoXGDWb+oIZIertS9e?=
 =?us-ascii?Q?q50iBoj9/4dgrKM3loUYTcrsEd0x2giUHTKBXXqsUcw2IbHOYddAM2R7rdo9?=
 =?us-ascii?Q?vBsKvTtLZc48NzcYhjN36u22DAG+lnkr50N5fTZ3FZqD/xaeKozAg/yee3Z9?=
 =?us-ascii?Q?qSKUm7pO+ohU2Hdun3kkVBLGlAWpWX0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0e63a6-e346-49a7-7e48-08da16653e24
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 18:02:11.5965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S28CsCuqLN9UQAgBYeyAC0V9D7AfP8rOsUu0203C+Pt0t8K/H3eoesXvVe+FnBIFqpsS4nyOqteqXGQZVX4jbzEjZDJIpOHi6gq4cmMGJP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar and Pavel,

Thanks for the patch.

> Subject: [PATCH 1/2] mmc: renesas_sdhi: Jump to error path instead of
> returning directly
>=20
> Jump to error path "edisclk" instead of returning directly in case of
> devm_reset_control_get_optional_exclusive() failure.
>=20
> Fixes: b4d86f37eacb7 ("mmc: renesas_sdhi: do hard reset if possible")
> Reported-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c
> b/drivers/mmc/host/renesas_sdhi_core.c
> index 2797a9c0f17d..cddb0185f5fb 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -1033,8 +1033,10 @@ int renesas_sdhi_probe(struct platform_device
> *pdev,
>  		goto efree;
>=20
>  	priv->rstc =3D devm_reset_control_get_optional_exclusive(&pdev->dev,
> NULL);
> -	if (IS_ERR(priv->rstc))
> -		return PTR_ERR(priv->rstc);
> +	if (IS_ERR(priv->rstc)) {
> +		ret =3D PTR_ERR(priv->rstc);
> +		goto edisclk;
> +	}

Why can't devm_reset_control_get_optional_exclusive to be moved up before d=
evm_clk_get?

Cheers,
Biju

>=20
>  	ver =3D sd_ctrl_read16(host, CTL_VERSION);
>  	/* GEN2_SDR104 is first known SDHI to use 32bit block count */
> --
> 2.17.1

