Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586774E278D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347872AbiCUNfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbiCUNez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:34:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9607F33E88;
        Mon, 21 Mar 2022 06:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mh69Df6ZLE1rBjPoxFK5kh2suLVUUfIFoeXmnHr48/53o6IXT46KojPZb7KSQGV4SNOZyeyCXce8KgX9gnHyAOk+KU90kUrAa3rRYJSrf7OgV9UJwvX03oUYSlOu3g9dwvwJA+iYldvYzNOWLzRbkS5VdF9p6E9PE3MK73SdhxpjOUcLmKsums8gk5zsSZIyV+oJPqrREDays2clbxwQX8633H5Juxtj1imoE6at0oIArlmiiWjy+qwrH2eM3ujO3z15SaWF4QPMW58iAl/Snt90plPG8iLRlH53Us6/PDKVZM7Q2OWR+twmDioVOIqVGAo1aCVqsEcednpw2zmlNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+pUVmUnDBFDrdPfiXX7u2v/2nQJhINr6rhBDssIs8w=;
 b=NetjdjDcBQZZPIsCS2Ec4fT2laSmyQibSis+vMH5ie8L/lqrYhAkquOLFIOoAAsrCnFVJMleZWMllSVi2sPGJca0EkQTlZnIPtdaLLC6LA6axmJCerEmA4u8t1VoTKVL5Lp94ZijeBvAto9OHuD++V1O2NMeTNEzp9vkFPywFHLegLOfs5l+H/QkRuTuBTT8Cs5xOeFLjIPQrVxaxsP4vZXi70k2iJUyme2cesvI+Oh+YGrmSENvjhgwtXuVb0vKtAKdofe3qFwgOtFxPaDH4+rOEtMYDdQgPraQ1b+nPnbHD6bzerLCr/ICNqXbmgl0Q//0Sd+3WhICRMkenly6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+pUVmUnDBFDrdPfiXX7u2v/2nQJhINr6rhBDssIs8w=;
 b=cAob8GLUR2Ej+ekrxPwoQ18XXpDEHsjEv3/Ed6D9PlRFsvSzGEFGNtOqf/x87bF/NuTlXWDBlhUwn7zMKXH9tMISjaeyoTd3E1/kzeDA1kscfH5e4Hfzsphw9EMkjJ0U1fQjRNW1byyTJdVw5o+CtELKUYXxzYwGikgKb+02zK0=
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by AM0PR04MB5284.eurprd04.prod.outlook.com (2603:10a6:208:cb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Mon, 21 Mar
 2022 13:33:24 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::c121:7f8f:a903:ae7f]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::c121:7f8f:a903:ae7f%5]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 13:33:24 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Sherry Sun <sherry.sun@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: fix potential bug when using
 both of_alias_get_id and ida_simple_get
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: fix potential bug when using
 both of_alias_get_id and ida_simple_get
Thread-Index: AQHYPRZLkioNdXEb806mHueeH0kdlqzJ1Y2Q
Date:   Mon, 21 Mar 2022 13:33:24 +0000
Message-ID: <AM9PR04MB8274AA137A140A4B4DFD0EE889169@AM9PR04MB8274.eurprd04.prod.outlook.com>
References: <20220321112211.8895-1-sherry.sun@nxp.com>
In-Reply-To: <20220321112211.8895-1-sherry.sun@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 223cb923-9428-4335-8643-08da0b3f5fae
x-ms-traffictypediagnostic: AM0PR04MB5284:EE_
x-microsoft-antispam-prvs: <AM0PR04MB52847F8978174796D8CABC9689169@AM0PR04MB5284.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tQocNzTuqJhqnc3o0b4+Odpx8m/6EttDR9r3oNO7i9/eotRfng6ca4AqXHYMu9bthP8UcJcMbxMcuAbqTHaZXRR3gp1sNr9nHeXr1yyVrvOaZdBpGbHOK6EgMbaToYl4RsB2zU0s+DB6kY6KCO9TrtLWOFgQCHlKcFN1kLdPumjc4fFvSAgrweMWqBgL1kXzGFwrrDGx85/ANRSyNZ19H7Q/KRuEOZEj6at1IQggfJ3FkqnwCCSNaV3nj9kyhyguGETNIFM2wMjAKKhKuVADMsf1tBzMUDqbBOOXqcaa8AV0aqjfdHSU0tQOvdm8CO05n9uROzO5o3rBHIlEhrYFeXGAWxtVjSG1USkkkhIbbtOk/GZAUW3gMMcB4b2Ork8rP9W3VY1Ynz5LxEtYt4BNZgDmyLGc14q4EmerqSIpHahajOgkOenMf5mNT42KucJUuIYNFz5ZUBW8xaoPU11HkFgTRfqmc4y5HXY1K9NU9j//RpetSQSoZzVtKXvwDtdpyk56hpJS2GJF3SprtplbgzfOeUVyn4Cagpm7gXlYx+zHxvhoR8hhR7vGUJgyWO+1x9vFjiwAGkA7D022vuYFu06pg6ivpqEAiRzMq8nbiFwP/SO0YS32OTv9LxEUHq4ZHbJ+SPQzoqOdksIrbEeHxsuoJRQJTa8FMBmvrcxV8pV6It2OWDw8cqBSwqZWCEeYWJs9m1emw/sn8kJizTyVJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(66476007)(52536014)(8936002)(316002)(33656002)(38100700002)(44832011)(66446008)(6636002)(64756008)(8676002)(4326008)(66946007)(76116006)(5660300002)(54906003)(55016003)(66556008)(110136005)(2906002)(9686003)(38070700005)(55236004)(71200400001)(86362001)(53546011)(508600001)(122000001)(83380400001)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HR0u1emeasx2+UUoSd27TN8bv+sYKWF+qhTVmNYh9BvVo5TWGWcfCQqneufF?=
 =?us-ascii?Q?d8pZv/K8wOf75ve7QMdfzs73iPDVfuiXznzJe6M1kIk1aTAwAYkAGe5NOW6V?=
 =?us-ascii?Q?f5SJYzFE2z6lBnR/CN9qSgrcSOXioq95bkcy0Vn2oIObmeGZoI4aS7g8lbyU?=
 =?us-ascii?Q?YxKPVcwti+wOIpj47QDK4DvYnQm0hTxsbKgKj/9sLxn47+2fokObR4wvTUvV?=
 =?us-ascii?Q?dJDey+y7kN3BvmHWiuZmsgmeG8oE+b+4H/Sn5G5DaZqQkTEUy3dKO5Cet4BU?=
 =?us-ascii?Q?dlR7mBdroinpeGk2g5kwEq5Da++Iif1Kpu+pzwylD0NxxI1HSoHCbSd2AnPL?=
 =?us-ascii?Q?4RwOOQgjqrX0sVeGLYqxWK9ueWVPW9jHb8llpVz1eCYUhsd+gCf/ZuQnrJsj?=
 =?us-ascii?Q?xZu0VYK2M1TKaZwGL5yqUnsW9ZLy2S1mZbxTOjIZYGaJrIrB+apphDbGyK6B?=
 =?us-ascii?Q?6M45VlbhSk+ZTuN8hAhhYJ1t8Zz/1QnkmN2SZL1ZF8G2NbhgO+drgg6CCAzi?=
 =?us-ascii?Q?w3RCMpCUxydOzy3HYxIv4RpmpgDLUHSIQeTZBQdO/iB2dx8f1kb69thGjdcu?=
 =?us-ascii?Q?cQDFRKXuOVWMbo/ApNH+OHqWp1jXOcxrF6qkc9jC3uVb+INBqR8sgFHZlsKp?=
 =?us-ascii?Q?i+D68Rr50RgmzDAYfNtqwyfVVmL0ubUIdzn7ZPTgwADEkzG3p29ZyOwFee1v?=
 =?us-ascii?Q?ZYPLs7HlYcmb2oDlIDxDRtyqoZIKmZ/OIciaQi+o+cQmpX3yrd+WnmZPj/AW?=
 =?us-ascii?Q?IYk4khlwEdccMhR4+s2oxmKJAGrcp2kamycEHf4x8p6I3nY/2PQUPA16DwtH?=
 =?us-ascii?Q?WQoRyT2v3FZMveRqEzBDhfNxGhQ6Rcn0Z/nyEwD2lMBLwFveRKpyPgtOSnhJ?=
 =?us-ascii?Q?q2iCFSimqQIR+Kho9Eb+dsggDyeVRqcfet3Isq7jn5Vuy7hGfspSi24gXiAK?=
 =?us-ascii?Q?/Siavu2IlZgDup4cIq1+KhBuEGfJMDQYtbqC00m7CFCGGNUf8sCQsv0lIWDx?=
 =?us-ascii?Q?3Qsgoz1xVpcGzJUGU2NGRW2mwvBh3HiTv4O7e8iVOsvqKmet2B2Hnz5bvxft?=
 =?us-ascii?Q?SnZGgJHwLsF2qUjCToupnFKf6TkVajgDgDZZhuTH49+x5kbp0sh0Ec5TZjs9?=
 =?us-ascii?Q?fxXM2QCLS0cSp3b3ywfxEdXkAhY0EQhG0ktGjp7bbU8wTr2WXIlHaq9dmHU9?=
 =?us-ascii?Q?Gg1/Gd/1MNk1anp2jHY3Sy5dGMCFvdF5EtD9ePoDVLJMpFcDK48lwkJL6Ufm?=
 =?us-ascii?Q?w75HikP7rt4lGol+lLaSwSHuSadV5+ItWGlxGg3njuc3g6raIN8IwsfGJWm0?=
 =?us-ascii?Q?sMLWhsFb7RycqQ5rIM/oicMtI2oNqRpicHY5kIXX6t7AvMpLHtMiU19Nuv7q?=
 =?us-ascii?Q?7cRrg2awiPGcbHpBef98JHDWx7x8AiTYiN9u5iSSZdHF9pF0ET6UJ4Br4qK7?=
 =?us-ascii?Q?TRIVKyj2KVm7TZay2S92FkBtSMTUb3xv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 223cb923-9428-4335-8643-08da0b3f5fae
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 13:33:24.1527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZyLlBUiNsP8eoQLryQQR/OhUAs2nkGm77pkOkAEiBm+xzH+IdqK95HIRgSVVBE9Rh2SqnBISB3FaNdJvD7EUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5284
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Sherry Sun <sherry.sun@nxp.com>
> Sent: Monday, March 21, 2022 6:22 AM
> To: gregkh@linuxfoundation.org; jirislaby@kernel.org; Vabhav Sharma
> <vabhav.sharma@nxp.com>
> Cc: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-=
imx
> <linux-imx@nxp.com>
> Subject: [PATCH] tty: serial: fsl_lpuart: fix potential bug when using bo=
th
> of_alias_get_id and ida_simple_get
>=20
> Now fsl_lpuart driver use both of_alias_get_id() and ida_simple_get() in =
.probe(),
> which has the potential bug. For example, when remove the
> lpuart7 alias in dts, of_alias_get_id() will return error, then call
> ida_simple_get() to allocate the id 0 for lpuart7, this may confilct with=
 the
> lpuart4 which has alias 0.

The behavior of ida_simple_get() is to allocate an unused alias number. Do =
you see any conflict when you test?

Regards,
Shenwei

>=20
>     aliases {
> 	...
>         serial0 =3D &lpuart4;
>         serial1 =3D &lpuart5;
>         serial2 =3D &lpuart6;
>         serial3 =3D &lpuart7;
>     }
>=20
> So remove the ida_simple_get() in .probe(), return an error directly when=
 calling
> of_alias_get_id() fails, which is consistent with other uart drivers beha=
vior.
>=20
> Fixes: 3bc3206e1c0f ("serial: fsl_lpuart: Remove the alias node dependenc=
e")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 24 ++++--------------------
>  1 file changed, 4 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c index
> 452a015825ba..40465d23d7ad 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -239,8 +239,6 @@
>  /* IMX lpuart has four extra unused regs located at the beginning */
>  #define IMX_REG_OFF	0x10
>=20
> -static DEFINE_IDA(fsl_lpuart_ida);
> -
>  enum lpuart_type {
>  	VF610_LPUART,
>  	LS1021A_LPUART,
> @@ -276,7 +274,6 @@ struct lpuart_port {
>  	int			rx_dma_rng_buf_len;
>  	unsigned int		dma_tx_nents;
>  	wait_queue_head_t	dma_wait;
> -	bool			id_allocated;
>  };
>=20
>  struct lpuart_soc_data {
> @@ -2716,23 +2713,18 @@ static int lpuart_probe(struct platform_device
> *pdev)
>=20
>  	ret =3D of_alias_get_id(np, "serial");
>  	if (ret < 0) {
> -		ret =3D ida_simple_get(&fsl_lpuart_ida, 0, UART_NR,
> GFP_KERNEL);
> -		if (ret < 0) {
> -			dev_err(&pdev->dev, "port line is full, add device
> failed\n");
> -			return ret;
> -		}
> -		sport->id_allocated =3D true;
> +		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
> +		return ret;
>  	}
>  	if (ret >=3D ARRAY_SIZE(lpuart_ports)) {
>  		dev_err(&pdev->dev, "serial%d out of range\n", ret);
> -		ret =3D -EINVAL;
> -		goto failed_out_of_range;
> +		return -EINVAL;
>  	}
>  	sport->port.line =3D ret;
>=20
>  	ret =3D lpuart_enable_clks(sport);
>  	if (ret)
> -		goto failed_clock_enable;
> +		return ret;
>  	sport->port.uartclk =3D lpuart_get_baud_clk_rate(sport);
>=20
>  	lpuart_ports[sport->port.line] =3D sport; @@ -2781,10 +2773,6 @@ static
> int lpuart_probe(struct platform_device *pdev)
>  failed_attach_port:
>  failed_irq_request:
>  	lpuart_disable_clks(sport);
> -failed_clock_enable:
> -failed_out_of_range:
> -	if (sport->id_allocated)
> -		ida_simple_remove(&fsl_lpuart_ida, sport->port.line);
>  	return ret;
>  }
>=20
> @@ -2794,9 +2782,6 @@ static int lpuart_remove(struct platform_device
> *pdev)
>=20
>  	uart_remove_one_port(&lpuart_reg, &sport->port);
>=20
> -	if (sport->id_allocated)
> -		ida_simple_remove(&fsl_lpuart_ida, sport->port.line);
> -
>  	lpuart_disable_clks(sport);
>=20
>  	if (sport->dma_tx_chan)
> @@ -2926,7 +2911,6 @@ static int __init lpuart_serial_init(void)
>=20
>  static void __exit lpuart_serial_exit(void)  {
> -	ida_destroy(&fsl_lpuart_ida);
>  	platform_driver_unregister(&lpuart_driver);
>  	uart_unregister_driver(&lpuart_reg);
>  }
> --
> 2.17.1

