Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6199759B308
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 12:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiHUKBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 06:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiHUKBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 06:01:50 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60051.outbound.protection.outlook.com [40.107.6.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243DF2497F;
        Sun, 21 Aug 2022 03:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtKTSlSIrnAK+OU3cchin/ModAbVrc3ih1ihgGM7FrcjVCKiPgiOwKYD5j3dJN0uxuYzUOFK6U/OS4iXmx8qdsr/OmbnLOZHAwVuwisCflBt+BkXAvHNyNCOM6iuXhtQrxtmrfkZiGK417TgeAgTAHNHrAP+fYDW4swLj0DrZzOZXA+jRE0cflxFc3Me+XMzZ6BZdd+5dcko68EYNqgaeAq83WOK90UbzO6L13KSRCciy8JBFzMO+edp1XiGrsyn+nM20s60GGlFaxRUwdcHRDwojw1Q4SVtxUtzP26v3qXp7oMWkfeuFXxDPhFqIKiXxQIikzaFTgvj5ZVSoMKJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYxzao1Cdv3CToDxvT4SAP7fQGYSpZUefTZIARM0He4=;
 b=YXGzSuOw7pNgL2+fqBRY6RJgSYU5/uDwcQVgx7DbDv3BMhwB4etnGe8aIHVxrdZeuAoYT1m+pfIjI4eipA/tEhbwzVbz3HL/dc2PBU7UU0dUKp+Qtk2qC5PVoEHuVC6HGvxei2D3qR+aWaDklBbRbJUXequEbB/Z7PqwJdPdLnpDGDtzQHLPuV9O1mrBoA31linzeqfpxopDkp5Sw6YNjBB1+RhYKKCEOqIsIEGoJMgClX41S34sVqI4VXoGY2PKtkE7EN4bfEZAPtjuA20qSiA7C9zGDCNZZaIaeP6vVthwFUbq3pdmYnHZ0OtCFhjT6TyKah12ciTNBfnFWf5RFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYxzao1Cdv3CToDxvT4SAP7fQGYSpZUefTZIARM0He4=;
 b=XIARzTLU1Va1UGMy1JKH8FI51kuLJvuwLo7+JCJd5qLlthcV3YnMbNsrL5BX+fq/OtMKjM0p7lqgL52FTjiCOFsLaHaMPHvMwi3XAtKmr/Zo+jYwqUjviU003s5TlUqCsxRA8AiCC9xvJ7PC5KmCjYmk4CLz8kxpJVkXd08oT+U=
Received: from DB9PR04MB8411.eurprd04.prod.outlook.com (2603:10a6:10:24c::9)
 by AS8PR04MB7622.eurprd04.prod.outlook.com (2603:10a6:20b:23f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Sun, 21 Aug
 2022 10:01:46 +0000
Received: from DB9PR04MB8411.eurprd04.prod.outlook.com
 ([fe80::582a:9810:a2d2:94f4]) by DB9PR04MB8411.eurprd04.prod.outlook.com
 ([fe80::582a:9810:a2d2:94f4%5]) with mapi id 15.20.5546.021; Sun, 21 Aug 2022
 10:01:45 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] tty: serial: lpuart: disable flow control while
 waiting for the transmit engine to complete
Thread-Topic: [PATCH V2] tty: serial: lpuart: disable flow control while
 waiting for the transmit engine to complete
Thread-Index: AQHYp9Cq1lLe0+gYXUeTxqVAptUi5625IyEAgAAViNA=
Date:   Sun, 21 Aug 2022 10:01:45 +0000
Message-ID: <DB9PR04MB84110E4B09CC05573584724F926E9@DB9PR04MB8411.eurprd04.prod.outlook.com>
References: <20220804070420.32186-1-sherry.sun@nxp.com>
 <YwHvAsOmMaa6rmm0@kroah.com>
In-Reply-To: <YwHvAsOmMaa6rmm0@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df758f3c-a6c0-46ef-aa80-08da835c2813
x-ms-traffictypediagnostic: AS8PR04MB7622:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ypej0Z0bILKhTfyBSEwy/t/07lDceaF7AZ/pqfTUvT2Zk7pKGUM/gG9ZdMMiYy3Sd+KG0SOfa3Yi2Yv8pUesn9xC8FRVRig89XNTB53656yhWfe5dZeOZUHOYPeLzHibhYj4R+vp/ZXfQjP4Sawv15d4zVoJetjJhqIEQChatan08vNVp0WXkuo1BPJXCnqvSWuhnQpqya+BQb0cPYy08InFGNxXgqBCJxYOSUySMJbxnxQEBtBKzbNFE7nnXY1SqcfEtddPXTliHB+nbKOvo7lUzBPn97SYzQHmI40D3E7/yGve+/KTyl+u/qbfU1UIBkhf21qaPyBNUZ2j/ZzKWbbMlnS8Xz9hyWCRHR6FTRYg7iRnUCuUojhUGVjZQIK1vpSdGbWjthx2VYCkAkraCQb49xyyDc2F3jUB87u3VNzSIKcmeTvMEpMrkJlUqlo8/VE4AgGZNYfYqY9n9tNWMpOVBZfIIZ6d+i+RYVYd2l1DhfbSZdzBuBMu35+LhXtMJgViAVUl9aWE22tZfjd7CXXUeG2iVployE+2sSQ+8qYYAF6KWipYySwhWniDkXyJRDalp9MJi+vTci7/YlR9pKC9eNMq1M7nj3L8dojkdwocKOixKUZQDcJ+tzIvTulyAo41cW6HpIgZmxbc8pBetYujmPfUTpX5aTEc3+toX745Ee+YXdvs458O7sowV4VcaFZ+qDi74QcZz8wvujJSKSEQDeGSkl/z0Bb+zXAbPhsvZChOl0DnbMzHRy/E1S0aeNArUKDW00y1b069fwdsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8411.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(66556008)(186003)(83380400001)(38070700005)(86362001)(122000001)(38100700002)(66946007)(76116006)(5660300002)(64756008)(8676002)(4326008)(6916009)(316002)(54906003)(2906002)(52536014)(55016003)(44832011)(8936002)(41300700001)(66476007)(478600001)(26005)(6506007)(7696005)(9686003)(66446008)(33656002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+LSOoSKtfBwohcp36JSOwdC6TFjCqOtQ/N+ufsHQ0V/jZMk5xbIXuyUx1wGp?=
 =?us-ascii?Q?wW5O4rYAyvWgNpWrNau5hqr9pCXdjl6yP7PIlpWujhUzAOsp9+DTaRb5v4zp?=
 =?us-ascii?Q?6oUe0YbP2D6eD2l30GhEmdVaDx4q/zzkMHchbv03GbmvQBqrL2XEt2jzFxT1?=
 =?us-ascii?Q?UI1zG9uAtHWMHAvluesYzPZbE4FjfTHbFcKNQdSTuQXT6opIyyH1AQ39Dlgs?=
 =?us-ascii?Q?732/TyaIK5cYw9nP4xQwRoeA+DYOb9XvsDlrSbuFX1zBn6UK1k838QLKJ9Xf?=
 =?us-ascii?Q?RwEPIEajME7uQNlQEUgtN8kZt3XU2FGM1w6bwnkWCXSBoGBI0VwYIFaYYPWs?=
 =?us-ascii?Q?c7oCyc8CXIEh0xImp6vCxj2y0nM2fVAdpDqnAl7evNqD98abmsvTwpIq51NM?=
 =?us-ascii?Q?2KVYsRf2waleQDn6ds+LfCYOfJLARwNghtzoPHwfX6nvCWoYTbwZ2zWQEWR/?=
 =?us-ascii?Q?Jy2YyrsLSiIHlup/gSRplewtIvTK7EpaO8D7pZs4ArxrHjIm5/pBsxt4/99B?=
 =?us-ascii?Q?xYQgj3QGRRAeuUKQsV0cPOACYgo2wkeDNOiGoo4MdocCQlm+NlzxoohCOH2U?=
 =?us-ascii?Q?jDZtgFf8PfSxeeuaRCKvwHQAiQXV2TtICL6mK1v50c1CU5SUedx0qqfee4wl?=
 =?us-ascii?Q?7It/t9DEJPrz3VewhwPrJiq9nbfqkzIZp3bb6PgT2vnpNK3fURg0xoUaLjGM?=
 =?us-ascii?Q?iq41USpuKfXG/Ty9HfempvkD8MlHh9tYFRGGvAxIBLPiwmvzHkOF3Rk1GOYQ?=
 =?us-ascii?Q?f3ltBcITk7iiY725XVTtHVaGvwXe37jEB8f8EplM0INnWjoUt/J6igug2hi5?=
 =?us-ascii?Q?qnH45N5oFWTFQ9cLuYf3Tr/C1y6uax+rSvADUBa4EaXHL5GOdhLeA8iH8Qlg?=
 =?us-ascii?Q?S7wEq2S4U5CiqnTXd7cf87d/CAKtTf6PtKZYTTepjQPgYSdGR47R2Lx1wjTF?=
 =?us-ascii?Q?IzeABZ1U9wpvHm+CZorOkte9PRlZk4DfbLddFXhIYrg4mzoHECDsmheN0nTZ?=
 =?us-ascii?Q?mlZ7/Ltmwf4eEGYMFoXPPnnX3dQy78MKzzL13xT+GQI9YHUR43G+8GhoPi37?=
 =?us-ascii?Q?2D/bLl5L0Yx74i7StpvskARvZ551gRYXGK1zKIcLT6Br3ZMYkTc3u1rLtS+4?=
 =?us-ascii?Q?9DX8o70E0uGYFAZcVE46Jx8+o5Yk2KrMqKwnJrrymrdY211ew1Fhg8+LBw/y?=
 =?us-ascii?Q?tnpOWoKDGuhX49eyEa+amIhEX26u59YnEaTdL0JnCCCQMJRom9jB0aR5f0Sm?=
 =?us-ascii?Q?3dSWU391pD4at/HoPf5m11ZZ65IIWre3wKBSmKKhwnkIt0gMGZhwbS48zWcU?=
 =?us-ascii?Q?jZK0QCBZY2aezwZqHpjYLPg1GVQSyWbR2niKEPEwT6DFK01VVPc6/2uL+XgY?=
 =?us-ascii?Q?siSbFkZWJ89BQkqkdqHtsA2phjVU80mnTpYIbsembpRNrMLnF58adEs7RH7/?=
 =?us-ascii?Q?gWzBeJ6GSeGkoGHPZOQxOcRY6l8c99B1uukKwpI0LjW/wORWigZslhk3Et8a?=
 =?us-ascii?Q?fztH90KkUkt70XdRPDQwko3nvURX31YBZokRGsxEavkKe1jl+uuOeubrij/o?=
 =?us-ascii?Q?vqW+DI1VWiwWS4WpYQ2mj26ngaaNMTUb8sur7h/3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8411.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df758f3c-a6c0-46ef-aa80-08da835c2813
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2022 10:01:45.8327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qlbDbsyq8SG39e39Z/GTW+tLTRiQ2zTnsnq6r1PmvBNVwriI+KF6s6/YFR7rZfLTVpqQz0vgZLxhQiiBh21C0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7622
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Aug 04, 2022 at 03:04:20PM +0800, Sherry Sun wrote:
> > When the user initializes the uart port, and waits for the transmit
> > engine to complete in lpuart32_set_termios(), if the UART TX fifo has
> > dirty data and the UARTMODIR enable the flow control, the TX fifo may
> > never be empty. So here we should disable the flow control first to
> > make sure the transmit engin can complete.
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> > Changes in V2:
> > 1. Rephrase the commit log as suggested by Jiri.
> > ---
> >  drivers/tty/serial/fsl_lpuart.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > b/drivers/tty/serial/fsl_lpuart.c index fc7d235a1e27..f0fccd2ff7ac
> > 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -2172,6 +2172,7 @@ lpuart32_set_termios(struct uart_port *port,
> struct ktermios *termios,
> >  	uart_update_timeout(port, termios->c_cflag, baud);
> >
> >  	/* wait transmit engin complete */
> > +	lpuart32_write(&sport->port, 0, UARTMODIR);
> >  	lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
> >
> >  	/* disable transmit and receive */
> > --
> > 2.17.1
>=20
> What commit id does this fix?  Should it be backported to older stable ke=
rnels?

This issue existed when the lpuart32_set_termios() was introduced. So the F=
ixes tag should be:
Fixes: 380c966c093e ("tty: serial: fsl_lpuart: add 32-bit register interfac=
e support"), and I believe it can be backported to the older stable kernels=
.

Should I send a V2 patch to add the Fixes tag?

Best regards
Sherry

>=20
> thanks,
>=20
> greg k-h
