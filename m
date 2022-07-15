Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A44575C45
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiGOHWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGOHWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:22:24 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50067.outbound.protection.outlook.com [40.107.5.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66FB7437B;
        Fri, 15 Jul 2022 00:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDQAcGjRZ3tvJgvoVXOk2kjWbGcepco4C1PXChcxrVVUr40k6Qdc4c1DZl7vW1rzNu+R7P76U+PPrE6N9Bz035W1I+SsqZBOWFo/hx2JEb83ajZnuhLg7APmlD6sJviWCrskYKFWCVVdLBU/M3UKyc9kBi0Fy6hn0vA9jQfQO2dnN+WQ0GM7M/KxJHbjOZDrbsLWhAWq7Rod3ZnOpePHE3lt+mbQupabxtouRRfbBAKgk/+4dyVE/tFLubKcY1GXdvxAqwlAhLcYCT63NED4gDCmruJBofmPZVr8rYUv1F9xCCSCuPKdpw1XP6jkbJegBzSWPw5SkP1li4gXX8Xmaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQAOxlSgpG0hgY+GjtY76WtBHkrhssgoxqZaIHidnhA=;
 b=Q8OqK1qFNdQIGSDGyHtBvRNt9u/RA+MDNO5MyrRrwYEoQW4R2F11kaF5YD200vEv0s2h0xVYAsG8ZpgE6JTOv7f5vf6m5I2o6BZsQXZvYjU3EBD7PF/SDocBAsw1Rcl4xmb3m3gJpu1uqe6+Op3IqDkUXq1RlZ73yQptM7qcxJIwr3FWMBGeZN13zTorvKCcdhud08jEcCZGwLa/PNnDKactRyS+2JUk0geewfxOF9aFzMh6uP1Mc3o0Jvq47y3Of3XWPOAynknFXRnhXo2/fpNT4iHNxqaM7tiSy1S1LciUhNqFu4gwRTIJD9YqVa/5xXSAUiXnARN/7z8dB7lrBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQAOxlSgpG0hgY+GjtY76WtBHkrhssgoxqZaIHidnhA=;
 b=PCJA1vD18R7iOS0mmnkrjNtMNaCzUANQqiGfSVhVg0ToBh51swYYxFRJarGBWS7TAhNcBia8x9rgFfwHpio2i3liNHASkxVKyxIufGj5v9qrTj2N+GdN1UN3FYLnzJqrVmOG75qv5Mx+sMFvhMuFreruSch4RRvAXAYUSL2kBMM=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM0PR04MB4930.eurprd04.prod.outlook.com (2603:10a6:208:c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Fri, 15 Jul
 2022 07:22:19 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3cec:d61:3836:2826]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3cec:d61:3836:2826%5]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 07:22:19 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] tty: serial: fsl_lpuart: correct the count of break
 characters
Thread-Topic: [PATCH 1/2] tty: serial: fsl_lpuart: correct the count of break
 characters
Thread-Index: AQHYl/co04hpCZj99kO2L0tD4LHyy61/AMiAgAAGGnA=
Date:   Fri, 15 Jul 2022 07:22:18 +0000
Message-ID: <AS8PR04MB84041C0319ACAC555AC89BF4928B9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220715025944.11076-1-sherry.sun@nxp.com>
 <20220715025944.11076-2-sherry.sun@nxp.com>
 <f480572d82310c3ed14e476b7cfbe7f2@walle.cc>
In-Reply-To: <f480572d82310c3ed14e476b7cfbe7f2@walle.cc>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba5e99a0-6091-45f9-924d-08da6632c07f
x-ms-traffictypediagnostic: AM0PR04MB4930:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Td+vx0kDJyTXv0DVtJfyFodjRKJL0f3dSqL4Xv5Z7jAwETrgCO61U4p4tBX88m8yP10wIe9MJUdk6f6YmQjdhOZ/ByzpbVhVnWy44sdYgWioFCsDADCN6VlMnAKaTD12XlVStzo+jGU/P+bLxZAfLUJHr7NrKgrDCT/Yb6TRtSsVlNpSk9WMpTc9C5k7P6sAaT4GuIBbU7ZCJSHKvWRQEOQLdZ2ruvwUcP/FWSWDcmC3bwWz9ifmYIuucZWLJjU88pTI19lK2dx2THA5B/m51yrf4AAEXlJ6up/mDtP/fL9OGWrA7tx4t3Rm+teVmTJZlf+ZzQ9B4MaCBgv6G32/on0sAXEVAbORRRXsEC/qPouSBc8msnlNPkVF5Ss+XkIghFMzth0EuWIhKU3qHgyZ0Rz16pv++DwALpSiDRbcTt0ElgpKbzHRIm+O62ZacEqbA7AeUyWwTuffotJTEQxDbwdHYA2xYUk3t4Iy9U5jp/MpdRV7mRphOpJY0ecAG65LaCC2hxI8eez4KP8MujKkPJmUTU83iXq+xawaM8ZxtKwwDJLJRtNX/CX77V1qVtNdajYVHbNNF74qBXfjQXmiRuW48fvprT9ucnhtL7U14ulttMjewWhFjMAODfu8tzgi4s9KBj8EzPT2yc8jQGau3qwoliH5Ecd7kFvdNM6tio0OfpAH1x6P8usUn2pF6JSWb4BCLvqKhfSFckfD5pb6pJuEt8FHtLUiNtEY/dVOJK0BWwbRC3EbRlPmaKo2s3E0GH/6p28P/De7D2UymHs35thjaZW6VUTXNh6dDpFxySw6K3UE4JONzckkhMOtrfbl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(478600001)(8936002)(38100700002)(26005)(9686003)(52536014)(83380400001)(55016003)(66556008)(86362001)(54906003)(33656002)(66476007)(66446008)(64756008)(76116006)(71200400001)(316002)(6916009)(38070700005)(122000001)(5660300002)(7696005)(6506007)(41300700001)(2906002)(66946007)(186003)(8676002)(4326008)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZkoKFRwisUQ90YVhsrXnliB3myfvvoQvaXtCN7Qh0WW1GFnnllF7HlTTU6Dn?=
 =?us-ascii?Q?ltPYThHsGOMQ7/gVcvKVe6cUMz7BWEeUZUgqfTU6FY/OZ3iBP56fa7g7RAO2?=
 =?us-ascii?Q?WzbhW62CLLjuZYsehq4Pc1ibNMHtNZ/SlZzi7lzqBdKI34OZrbF/2XtYOMwu?=
 =?us-ascii?Q?FvzeAtcNoNOj/pC7c9OXulS+I6ag+4lX9Yzbeb0xp597XXH5/yVwxxtlN+3S?=
 =?us-ascii?Q?HtxHhkyGUrKojxX9EaHHYv56y2ss8hNzT+tqzO6RaG2ZXiaiQfmv6ftPq0p6?=
 =?us-ascii?Q?TLHhjtZ0kOxowaMdBfWa6CX0CwQVm7cLUJ4aJK0cpEffJr8MZZWefR5syzFf?=
 =?us-ascii?Q?vwUwpS6HYacSRaYYQMVyAQF7rxOjuIITa8LtdzN54T38u1VEThpPmvS38Ed6?=
 =?us-ascii?Q?jDsBUWLmjG8RtKXPLLjaHk7Nn/DI+1vopanuB1sVtUHi9lSCDtkuUSQmEeTy?=
 =?us-ascii?Q?WStiND7BmJ5uLbqhedsW2EXRNcyXaOCLUtEB431jBUUbpk6KKGqWG/0zVtYo?=
 =?us-ascii?Q?fXAEfEQZXFLwKsFr+YxkgGyASqPW3HtP1wMHEPYc5YEcVN5dyptGc8M20Gwf?=
 =?us-ascii?Q?UPMxMoCv30Y/S+1e7St4Gqh1jUitmpaQW+ILj2umjbMAOTCjzRoLWNwO4Fux?=
 =?us-ascii?Q?2FbEHjifxi+Xm25EpBT2Pdun58c55ojxs0WEgagpaxERLUZSTuDjyE9epfd9?=
 =?us-ascii?Q?GS67ufQvmxiq+q5U7vbxy9ydlIP3+6xs89IcoT0nYQrjTfCdvksFIbcyNeIO?=
 =?us-ascii?Q?JPJIcwuFAgsNyzmCTFUt5ggEWmwQmsBX0xesnPjlSAw8XDXkHWgkYkxcPVDD?=
 =?us-ascii?Q?AC6DjgmfF7uhnPxI4bIaKXBJW8BpJlyOJsY8i4cCa3xIh8Qw2AkdOdFIHGdY?=
 =?us-ascii?Q?7e72/vryCx7ZVGhpKqchk+pYi8Hy7NLGLBB2iomwWiRurMON1l0pE4IdWF0q?=
 =?us-ascii?Q?O8EeRHUZswQophta3GC0Xes2v/1A5qJott4kBn/ltHMDGzKNfmUgDR4sRlcW?=
 =?us-ascii?Q?pUKO/+C3ZgvKbF2TP8GryXAhNx6tXKCBt0gqBCmH+PsuF1hyhNkiJddlt8WV?=
 =?us-ascii?Q?vUIaW27FWEdPprh8bhu44zpQa0RpMf6HIZiJl+vQ+ibLFjn+jj2a9b/1AI+P?=
 =?us-ascii?Q?+XCIH8e+/x7MLGmo4MGkjSZYhPRZXs8VR1KPMAke2NttoC+HR1QxuSIZFK1T?=
 =?us-ascii?Q?p+dU4J/2ojuvCWBe7/mWdVs4s8DRtqgY/z3h5irthsRhjDHIuJVqOBcnESjI?=
 =?us-ascii?Q?0BdhW3GT32l+RBmm1cFpCbCi8WXxGh5qQNylaRI4rTP3BiVlG/jf29V/u6AY?=
 =?us-ascii?Q?JmSWOHSe4HLjXl1GXqcwY7g7+ks+AJjd3C+N87C8UiCJdKWY+FDsRy3FTwEb?=
 =?us-ascii?Q?8i1rm/1WCrJpSDkUnpid3b8rmGDAPeSGzxWH0/dQaOxGgLZWDEMQ4b9dmKDn?=
 =?us-ascii?Q?JQY2L1ZJfDKv0SER2InJSaCV2plxP3z2lp9ISwJl/6nXqcx8IOE9dfKx91Pf?=
 =?us-ascii?Q?lW/9mMNLpjftnpSl0Fk2kstNY2lozNBE453Zh3Jo29ulrBZ/6bMJNCY35rlY?=
 =?us-ascii?Q?UWkKwUY/1s8Ul4y0RlwqwZF5untpxF3w7RYVEcFc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5e99a0-6091-45f9-924d-08da6632c07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 07:22:18.9705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3hrWGG2xPIOCBIngYbpPh29uc5NDDt/85J5HFY1G8t5nG8Pi/RiRwGc8pDWrF1CEXmBnXiF1lidRtdcoUu9uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4930
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Subject: Re: [PATCH 1/2] tty: serial: fsl_lpuart: correct the count of br=
eak
> characters
>=20
> Am 2022-07-15 04:59, schrieb Sherry Sun:
> > The LPUART can't distinguish between a break signal and a framing
> > error, so need to count the break characters if there is a framing
> > error and received data is zero instead of the parity error.
>=20
> Ah, it seems I mixed up the framing and the partiy error. Did you test th=
e
> break in the receive path, though?
>=20

Hi Michael, yes, I have tested this, with this fix patch, the sport->port.i=
count.brk is correctly now.

Best regards
Sherry

> -michael
>=20
> >
> > Fixes: 5541a9bacfe5 ("serial: fsl_lpuart: handle break and make sysrq
> > work")
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/tty/serial/fsl_lpuart.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > b/drivers/tty/serial/fsl_lpuart.c index fc7d235a1e27..b6365566a460
> > 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -990,12 +990,12 @@ static void lpuart32_rxint(struct lpuart_port
> > *sport)
> >
> >  		if (sr & (UARTSTAT_PE | UARTSTAT_OR | UARTSTAT_FE)) {
> >  			if (sr & UARTSTAT_PE) {
> > +				sport->port.icount.parity++;
> > +			} else if (sr & UARTSTAT_FE) {
> >  				if (is_break)
> >  					sport->port.icount.brk++;
> >  				else
> > -					sport->port.icount.parity++;
> > -			} else if (sr & UARTSTAT_FE) {
> > -				sport->port.icount.frame++;
> > +					sport->port.icount.frame++;
> >  			}
> >
> >  			if (sr & UARTSTAT_OR)
> > @@ -1010,12 +1010,12 @@ static void lpuart32_rxint(struct lpuart_port
> > *sport)
> >  			sr &=3D sport->port.read_status_mask;
> >
> >  			if (sr & UARTSTAT_PE) {
> > +				flg =3D TTY_PARITY;
> > +			} else if (sr & UARTSTAT_FE) {
> >  				if (is_break)
> >  					flg =3D TTY_BREAK;
> >  				else
> > -					flg =3D TTY_PARITY;
> > -			} else if (sr & UARTSTAT_FE) {
> > -				flg =3D TTY_FRAME;
> > +					flg =3D TTY_FRAME;
> >  			}
> >
> >  			if (sr & UARTSTAT_OR)
>=20
> --
> -michael
