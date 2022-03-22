Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5354E366A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 03:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbiCVCJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 22:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbiCVCJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:09:30 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60073.outbound.protection.outlook.com [40.107.6.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282F11A82B;
        Mon, 21 Mar 2022 19:07:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwXbVFt008phazwVv3KzRSEsFeztZJ3L5bPlQIz3Zn8F7OP8iF3LBK87jxpLyZusW/U5ZRZ53IbTgTQLox2l92fmCSfExwgSIzbrjulqx7HEzBIfv+VcD5PRjunwsnmCKhbress2/S7J6rrXDZIn7YuMWKVS9n/ZReFALk9SBjtV5Sjs6xKvR6EZpMEOWQqxDCVXiumcammQ5XoAU76kHXvyx8EQF7mdWxJ8l5hgUSB5b8WUGLr2Pspv5XTKOMbkptsv0B+Oohze7ct+6mAIAoa23mryFNar+2vLj8t4HSEWEyDlt69Uw7eVLUhpmed1K95jxERHT+gt1tplefSMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yI45HtmahhhggjOpd0eci+drQjmlmFbkR7yCudOkk6s=;
 b=grxBsyMXFOmAXMOIhovqGInC8yCyCLyRqlqg3OXaBUElL7f47fJhynu29z839CxQvmdRu54wfKh2EefMR+IMLsPcFNHzfmQmKaYlJH2j9UVaMB1xI1YI2LKylrXiZ72p1dFlbYm3ttfx4JA61s8syCi/oVQh+0eKShe5TJVCAT+OQaAQnxc2XW7jR0GU2RxVP86DhsdkXfq1vLRZ67hRk997//EDxPuav6Xd8s9nlHfxTPGoXWWUUaH5pglERcfIz5Uhw+QKF9RZP4A4TIiuQ+2anxuf0KUKx9b8Ty6TDTz0hcr5OcwA76SWSketMqi1t8QYmq6YKdUCh9SBuTeuhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yI45HtmahhhggjOpd0eci+drQjmlmFbkR7yCudOkk6s=;
 b=sbF6ASG6ysTRbzxay1gC9SNhN2hhDgN7rVWPJNnVOCvBFaqwWy34D16CFlBwfCjUXnsyZBCE7itubaubnL40IFwR6RtmG0aKuJpo6+LtjA4te7Vg0dC29/PEMNPMIvfs2kMIlJxyzYQEVfZu5JXOYnpf1BpxptELekJdxfyS6K8=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8595.eurprd04.prod.outlook.com (2603:10a6:20b:426::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Tue, 22 Mar
 2022 02:07:48 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557%5]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 02:07:48 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Shenwei Wang <shenwei.wang@nxp.com>,
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
Thread-Index: AQHYPRZKKS2PkrWc90O+BIkrSaMZEqzJ1k0AgADHXlA=
Date:   Tue, 22 Mar 2022 02:07:48 +0000
Message-ID: <AS8PR04MB8404C6C283903E10E71D409792179@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220321112211.8895-1-sherry.sun@nxp.com>
 <AM9PR04MB8274AA137A140A4B4DFD0EE889169@AM9PR04MB8274.eurprd04.prod.outlook.com>
In-Reply-To: <AM9PR04MB8274AA137A140A4B4DFD0EE889169@AM9PR04MB8274.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8985004e-a7cd-4d71-53db-08da0ba8c362
x-ms-traffictypediagnostic: AS8PR04MB8595:EE_
x-microsoft-antispam-prvs: <AS8PR04MB85958D857F20574ECA719B7E92179@AS8PR04MB8595.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: At958C0PL96pLQYrc6M5nxrNGAb4Dhm6vZHKA4LQAzXGwI5fgmptc/T/UY3yBgVWfvSsG0i1aBdqq8VXWu1oPdxOPoLH0uuB3eP48K0JW0MdS/av1PUpbRxBUmXDpnEBPD2ct2B4fSqgwfyVM1ZSCNImXkfyqZ6cz6807IYz0aay5XExy8+9kcI3bHGx8kpeB++pgBd021LmgorctPHwww0RUKuWUOWcnVo9FdJGkqZjZ1o2lldP2oykmjL7vv8CikgJukELSZegMvRD7TT/GpYM3pzxsHrIRc2nmZWpRoreRaEoQba0a9xzTGmwYmtoub9FHTSwpT2sxsv2NHiRH1EaDdSvqEHvFGrfuvbvFc3MbQywyFDESO48JrthJ9kS4azFu7xAFBiPL7RSU1qwPXzX8E66jX7+Y/HdLmI3RZ7Fz4aqJ8qW1irXoakPDHmzrYxrpBJ4uy1us62o6Sv4AXGg5LYU9FaRiAKRQjsp5wLopEhK2D44hut9EK7C+UPgHsWnOLncrOTLWEDpsX8X2Hp90Cu8tOUuYm1FzD3RS6pQluDy5Uq6RBRXctlWldeNp0VHjiJlkSVlemZi6/qgK9i6egpKTcWD09AUk03caymWw/d7JxSIKdKMYaU3OUTRRUeqlHJGTVM3Yq8o8cNvb8Xv4Tdq2d4lzBejTaSd7qoSxIsGcRPXnFTU8UJdw+iAlMTee/i6aWmIBRyspoB6bQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(110136005)(6636002)(508600001)(122000001)(38070700005)(86362001)(71200400001)(44832011)(52536014)(316002)(76116006)(9686003)(55016003)(66946007)(2906002)(186003)(26005)(38100700002)(64756008)(66446008)(83380400001)(54906003)(33656002)(4326008)(66476007)(8676002)(5660300002)(7696005)(66556008)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ywCekYJv3nLlc2lfto7rJ1tJe9hvrxMitEFMgVhipHse5UD4gqPR8xn8PgU1?=
 =?us-ascii?Q?OkQJAEpJj4pCPZ/+WA266EtL5JGtcqa2hPYw2KDd7DZVy15LMvIhY1dNG7sr?=
 =?us-ascii?Q?evH9H+TKMft3RDHbLz+MF2As+FesZl/E3vWkdXZCfOvTAvl2Vq+mN/t2HIYB?=
 =?us-ascii?Q?EbdBO1knXz42tHi3YupIdVlQuHA3elwQ2G6aGvqrN8fRP7p4lZs10t9fewqh?=
 =?us-ascii?Q?mDgfOvCAXJ60XBonTmhjL9kXB5RGArLfgWAm1TpJK82B2w/rTeOBm9v6cAp4?=
 =?us-ascii?Q?ZfW0BaSkyzfqnR0NB8CTo13VWiHlOfLndfiUryGhKe8zjA8pLHqv6yfzIpxS?=
 =?us-ascii?Q?f6ixstrgJ8dyybpgD8SdPoaxNjMYysI6bRwDjTsSwX2GP6MAY55wDugWZ60q?=
 =?us-ascii?Q?jMBXu/rSrRJA/bWMBGJ0VPHoFrMgiPQyBpfLDi7WmutZFQIjk7d5LKmnUdjO?=
 =?us-ascii?Q?LR2TssytyTJ8A1wIGGf6o/Z+jySmulf5X9SonFRvS7WnRT73klanqbirpohi?=
 =?us-ascii?Q?YkcwiwPs6Z9NVRwWQhqtBHoigTpKK/iRYizk5Zyys58tlQ4AmRTLSL/cHo+6?=
 =?us-ascii?Q?Ip6bYFXrvjee1v8zV59x3TgqqJkRPtOjZsdE2ifCHGzS9WTLqpU5/X8vLzgz?=
 =?us-ascii?Q?7hr1xff/MtvQc9DAgvbxemQWPwtBrdYN7xFgekvSzcDjSbN+hwavKGl7cChg?=
 =?us-ascii?Q?SGWncWjezxhhTtQk8kGAoknET3qClvFpSXfrJmVlKdEokmlmQMfa2fhEgSZL?=
 =?us-ascii?Q?Cs7a74sy7DZHDVLyxz0WzVFUSSVoEUuiO597wg2+rlE29lGuYRACqQQVQfbX?=
 =?us-ascii?Q?5ZzUpHZYFCnip9Aj3Re0NIAaX2SXLuY21NhzNwdxHROfPCDd0T84a1fkPuJI?=
 =?us-ascii?Q?obdd/r2OlQ/cZKomd6ook8oKurRvCyT3ORb8HeYCqkeRR7jNZ/VfJ6TsAMRr?=
 =?us-ascii?Q?fMYhCvE6Kr6BNQas1I5jKyq1+wu93pbYnEvDOgwPyEgerEk2csKXtWpshhBB?=
 =?us-ascii?Q?ktEVFwd01vApTsGaZwBDCamZUzuWcLC+JrnD9gA4I71falg4F53neznYfK+1?=
 =?us-ascii?Q?zPouT9u4O2bbuK51ooB+HN8kCOHODuRFbY2Fd/7GmarfYHRu5xP9z8FLt/bv?=
 =?us-ascii?Q?CNJ6ViVk5U7dJqhoIE0Hso3UvBL5Z0JntY/qbe9aAQeXV+pT+bnHoCseYSmR?=
 =?us-ascii?Q?x0859Kx8stmClE9e0JWsnZX0SBWhowoV22xl78usrBBkngZiNFrje2uBV7P3?=
 =?us-ascii?Q?FMI/IEvNUE6RA0+udT/egxvqwnkvFLVK54uXcVqDSjfVdABB1HxLSvsZC2Fd?=
 =?us-ascii?Q?WK2lsmNQFHG/GRsfgZ0Xmd46fc4aVXWadNdPBnY93hdNWAUfQ5XMTxSXMIGZ?=
 =?us-ascii?Q?cH5N9j1FCyjvzEPoRX2WPtRhnNmUOr3ApVLmuLkbxtSDV8gG/35HoTtyyupE?=
 =?us-ascii?Q?IhgLDg7hINovE5WNRPAaTn8zlwIkHQ/u?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8985004e-a7cd-4d71-53db-08da0ba8c362
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 02:07:48.5821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3y6AGKTdBKQmlZqFf7acbNQKGR1zZbqZwxJMKPgCaH54tQKjemRdXjh5wJClaNem3PYuBk9THWicQMT9Bljz3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8595
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shenwei,

> > Subject: [PATCH] tty: serial: fsl_lpuart: fix potential bug when using
> > both of_alias_get_id and ida_simple_get
> >
> > Now fsl_lpuart driver use both of_alias_get_id() and ida_simple_get()
> > in .probe(), which has the potential bug. For example, when remove the
> > lpuart7 alias in dts, of_alias_get_id() will return error, then call
> > ida_simple_get() to allocate the id 0 for lpuart7, this may confilct
> > with the
> > lpuart4 which has alias 0.
>=20
> The behavior of ida_simple_get() is to allocate an unused alias number. D=
o
> you see any conflict when you test?
>=20

Yes, I have verified this on imx8ulp, I print the port.line value for each =
uart port.
When I remove the lpuart7 alias, the lpuart7 will get the id 0, same as lpu=
art4, which caused the lpuart7 probe fail.
ida_simple_get() cannot figure out which id has been used in the uart drive=
r.

[    0.894549] port.line =3D 0 --> lpuart4
[    0.908148] port.line =3D 1 --> lpuart5
[    0.939844] port.line =3D 2 --> lpuart6
[    0.953608] port.line =3D 0 --> lpuart7

--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -25,7 +25,6 @@
                serial0 =3D &lpuart4;
                serial1 =3D &lpuart5;
                serial2 =3D &lpuart6;
-               serial3 =3D &lpuart7;
        };

Best regards
Sherry

> Regards,
> Shenwei
>=20
> >
> >     aliases {
> > 	...
> >         serial0 =3D &lpuart4;
> >         serial1 =3D &lpuart5;
> >         serial2 =3D &lpuart6;
> >         serial3 =3D &lpuart7;
> >     }
> >
> > So remove the ida_simple_get() in .probe(), return an error directly
> > when calling
> > of_alias_get_id() fails, which is consistent with other uart drivers be=
havior.
> >
> > Fixes: 3bc3206e1c0f ("serial: fsl_lpuart: Remove the alias node
> > dependence")
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/tty/serial/fsl_lpuart.c | 24 ++++--------------------
> >  1 file changed, 4 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > b/drivers/tty/serial/fsl_lpuart.c index 452a015825ba..40465d23d7ad
> > 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -239,8 +239,6 @@
> >  /* IMX lpuart has four extra unused regs located at the beginning */
> >  #define IMX_REG_OFF	0x10
> >
> > -static DEFINE_IDA(fsl_lpuart_ida);
> > -
> >  enum lpuart_type {
> >  	VF610_LPUART,
> >  	LS1021A_LPUART,
> > @@ -276,7 +274,6 @@ struct lpuart_port {
> >  	int			rx_dma_rng_buf_len;
> >  	unsigned int		dma_tx_nents;
> >  	wait_queue_head_t	dma_wait;
> > -	bool			id_allocated;
> >  };
> >
> >  struct lpuart_soc_data {
> > @@ -2716,23 +2713,18 @@ static int lpuart_probe(struct platform_device
> > *pdev)
> >
> >  	ret =3D of_alias_get_id(np, "serial");
> >  	if (ret < 0) {
> > -		ret =3D ida_simple_get(&fsl_lpuart_ida, 0, UART_NR,
> > GFP_KERNEL);
> > -		if (ret < 0) {
> > -			dev_err(&pdev->dev, "port line is full, add device
> > failed\n");
> > -			return ret;
> > -		}
> > -		sport->id_allocated =3D true;
> > +		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
> > +		return ret;
> >  	}
> >  	if (ret >=3D ARRAY_SIZE(lpuart_ports)) {
> >  		dev_err(&pdev->dev, "serial%d out of range\n", ret);
> > -		ret =3D -EINVAL;
> > -		goto failed_out_of_range;
> > +		return -EINVAL;
> >  	}
> >  	sport->port.line =3D ret;
> >
> >  	ret =3D lpuart_enable_clks(sport);
> >  	if (ret)
> > -		goto failed_clock_enable;
> > +		return ret;
> >  	sport->port.uartclk =3D lpuart_get_baud_clk_rate(sport);
> >
> >  	lpuart_ports[sport->port.line] =3D sport; @@ -2781,10 +2773,6 @@
> > static int lpuart_probe(struct platform_device *pdev)
> >  failed_attach_port:
> >  failed_irq_request:
> >  	lpuart_disable_clks(sport);
> > -failed_clock_enable:
> > -failed_out_of_range:
> > -	if (sport->id_allocated)
> > -		ida_simple_remove(&fsl_lpuart_ida, sport->port.line);
> >  	return ret;
> >  }
> >
> > @@ -2794,9 +2782,6 @@ static int lpuart_remove(struct platform_device
> > *pdev)
> >
> >  	uart_remove_one_port(&lpuart_reg, &sport->port);
> >
> > -	if (sport->id_allocated)
> > -		ida_simple_remove(&fsl_lpuart_ida, sport->port.line);
> > -
> >  	lpuart_disable_clks(sport);
> >
> >  	if (sport->dma_tx_chan)
> > @@ -2926,7 +2911,6 @@ static int __init lpuart_serial_init(void)
> >
> >  static void __exit lpuart_serial_exit(void)  {
> > -	ida_destroy(&fsl_lpuart_ida);
> >  	platform_driver_unregister(&lpuart_driver);
> >  	uart_unregister_driver(&lpuart_reg);
> >  }
> > --
> > 2.17.1

