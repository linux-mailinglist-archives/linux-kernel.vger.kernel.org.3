Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57DA59D0AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbiHWFrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236517AbiHWFrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:47:00 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF5E5E679;
        Mon, 22 Aug 2022 22:46:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5WbnNIfuN3gWZJrNNpPJupZsoUhQjTB3NSX6dV63O32utb4s6AuEoTumbzNf+LYrUjCSJveJgKhfeJ8hChYz7EmgYByUeYWgzTxw7qp0PplQVl+up/PoYoji9LgswV7QnB2LSRO0dHKh9mBOXBTjiVs36aFCI5phvVulgFqQD3dMvawAmqK3boF3YXat1dX9Vlzl7pmSztM0WVvqyETdx0j85PNU7eG/BRqUnMP4NDth7pYPErKggRnb3zUKbUJ5FLkpsajoeILRnYxFncQFcVP+wHGvgNKM6rwnikV0VJOM/dc8EEc3PLiBbYajI2b7gJnt7w6i3D8aiBOhdGWTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ztri7lyfCHkiNVg75MMgrsgUmo3kderCBa9IalzLCNE=;
 b=DwLsuaEDfW0lErejJn6kvfhXZITI0WmI785BpjGkstPj1f8kElgudB7QCcyO28KeEPHR3o8fGgUmjy134PD0SHfozpeNE8+v8JLVyH3TbVSntX35ujKhQf4qAz7bgj0XkU4YZIUeSHdU5LczrsRu9aAJnLZYKdK4HXUT8+NJZWFtSNIkWuWY+emjqiCLPhzoN7o0av+mGnVezUYxy4IqQspI7s32i02YwbRk7Qz4wIeAfgBzWESdporwjWfHS9S04KE0C7P9aGiqwwSQcOsLRQG/bP5Zc0kR9lIGsRj8JOGDPLNBO+/KiOzw5kHXKJOTvQ3o+XJ7qr2ALPpWwRcKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ztri7lyfCHkiNVg75MMgrsgUmo3kderCBa9IalzLCNE=;
 b=K1b5ooBYpsvAe2BHWr5167D1KKsQFCDT/YfVW3J/Rym/tS/xqeGNel4qdOD8zmcJqZBnmeDy9/dr+M+4eEBFD8pjj3VZpGLZLTuAu0IORbLaz/UQAA4zvhGAep0Cs2kJe+4bknB9ymhmORJZfBYBfZD+xgl50Hdng8xTvc7Jh+Y=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by VI1PR0401MB2416.eurprd04.prod.outlook.com (2603:10a6:800:24::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 05:46:55 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 05:46:55 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/7] watchdog: imx7ulp_wdt: Check CMD32EN in wdog init
Thread-Topic: [PATCH 3/7] watchdog: imx7ulp_wdt: Check CMD32EN in wdog init
Thread-Index: AQHYsSoEUmG9imf9Jk+Y+4ZhQkTfqa26/kWAgAEE3pA=
Date:   Tue, 23 Aug 2022 05:46:55 +0000
Message-ID: <AM6PR04MB6053DBC927D643877A2A979AE2709@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20220816043643.26569-1-alice.guo@oss.nxp.com>
 <20220816043643.26569-4-alice.guo@oss.nxp.com>
 <20220822140557.GB4087281@roeck-us.net>
In-Reply-To: <20220822140557.GB4087281@roeck-us.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c74bf113-3ab2-4273-0a3b-08da84cae349
x-ms-traffictypediagnostic: VI1PR0401MB2416:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rWi3lPzpAFUq1W0dvBnr1uAi76gcLDihCf5YMC689gTSIfmyMw2QAXVYuGhWxm1IpDph8eWVQFmlOmwiQZTwf2+yvknhdfIxHiDd5R1xFaFaUzx6cE2h8uFMZaL+GoS2seLvuVB2FxH+BMr4w6j7scLXr85WrUhURFh0AKuhm7t/f3FomFqALNd9A/Jd/dLjsbhJ/1IyHg0ZCqJZBqa8wNvWAPe8SLCcDAn0YhZqNUMYf6mlfHzyL8XlsHjXBLocrjw5hxHr3cd/+JQZX6qWSOf2udq1RWLZ8Ywb8yPCe5NqTeA/jcC74+UO1BfrB0rmTM++frN4h1sTh0SbJW1cV1FNVC5WRoNHCV3cVFe46/N7luAAxPRvlzawd+R/BW3spJuBli48dx+AcZg1LbWdJukVet5qmnyzs54OWvmEqOVFJkibedvStjH+rXjoK2Za82s11KXNEHCxIcmgErkbmgrZqIxN5pmeQKdkTKHIocGmooQtEnNVeVuQyh2i8GH+a8y0vfMW2lQnvu/R0t54zqVH/leWtGTdlg3R18wFSUR+Qv3/nj+SKVGiafRLBewfU3SclQFPdyTWXSMvwBkaEe0q2GPCbPBns23dAyJuYlrlakA/L/KFJxaKAzmPXC1uPAII2/j84jyT9gbilCblfYvyxnFrlVK1XSsaylmOojk5rd6s+ePJcHBlzl1o5Ietlp4tIPxVjZScrvs3ccZG3u9ydJd2gvW2/poBnGDP1fL9y41Gz0b0MrHTMs+0V9/gs18lAsR0movvG2J79ee63g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(66946007)(66556008)(66476007)(76116006)(71200400001)(316002)(66446008)(4326008)(8676002)(6916009)(41300700001)(5660300002)(478600001)(9686003)(54906003)(64756008)(2906002)(53546011)(6506007)(7696005)(186003)(83380400001)(26005)(55016003)(86362001)(33656002)(38070700005)(52536014)(122000001)(8936002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wlURb+DdZr5Lm++cB42pWSNz+UqNYPSd+X7l5k+gtPS57rmvmy+QmjGN0Giu?=
 =?us-ascii?Q?cyEMgRS5xaRJCNfXnS8KttsA+t/hAry6Vl5LXLELCxv6mKq8RmUmfr/yYbGY?=
 =?us-ascii?Q?OzWQ+AfqWp/n3ETymZtVCQQ7p+gXLfEWopOTH2lZF7eX+ek4FKDLZNWG6O+a?=
 =?us-ascii?Q?Af3Q2CoNj1IZm7t+ukI7xAgxzqCvc3TUbRrhLL62WbBwB6Km9TA5LFP9lGsg?=
 =?us-ascii?Q?Qb8C7kOdW+Nnpet0rOCU7+F0j5iTPQvr+sXJAcxucFEFOB9T91HPkJ2rDlL2?=
 =?us-ascii?Q?Ru78kQgnNGYD3WkhOfK/rp8fJf+lhyC7FGuCj1sRxPSsRWBGYrTTWS8CnOST?=
 =?us-ascii?Q?/fSyYexaYna0c66iq2g/IlG7auEjJ5CH43//dUm1S5ZLQXVSLl7sJxaaDiVX?=
 =?us-ascii?Q?3OnuYVidEb56zeLHA+ZeWoIYvXlRPtPi7Ugq9G9nxV3u1Cpf+lnwXOfsZfzO?=
 =?us-ascii?Q?qRm1DGpkfHfPdvFBR5fxHKM8eQsYP4WqkAjHB751aOqemEw84sN+7pA9NjHe?=
 =?us-ascii?Q?RsOjwKF5scSKQxCy24z81pxYFapAkdYhUcIgE38pNs1d/zgJNS7d2R+yxIOI?=
 =?us-ascii?Q?wzZrhGssF3HYdgFs1HlaizOcDTBYf8R9a0pZzAO0/T4EpZhrgho31n0FMjvw?=
 =?us-ascii?Q?kkJDWW/38mJ0JdiTM4lHDRgsuOQ7TAmyr11du2wBXbf4JCm40x6KncQC+VoT?=
 =?us-ascii?Q?MzoTU5JtoEFNCFi5wUy6yTggoqEyAgQHnAo7uzcG3I8NDSwgv3+wasAGwwK6?=
 =?us-ascii?Q?Q6yR6tEho3zXv8ZVUL5sRCeE2q6cLGvdG0sy4hobDAgFsnbMOwVnVKfK4Qnp?=
 =?us-ascii?Q?o8Vz9tRs2T+7AyYoat+NHBAT5F56lr2+polBBIXuwlkvk5m1yr/lY7HfpIen?=
 =?us-ascii?Q?WRSi5V7Kj9mYLxPfk7eV5IHJmqQ2tUB1yo3ts2wMCkd5FYeXd92oC/jUXyZc?=
 =?us-ascii?Q?fbjRkzIh4IxlmFIrjR8PcCFy8gX6qsZEyT9GCTtmSsLkLBy+1l8VWKasvWGV?=
 =?us-ascii?Q?ICkDrvol0bVEO8l1JbF2kTpS23yde+BcbHnh0ke5BwAXRloXHzlvrdIq+35f?=
 =?us-ascii?Q?HDVqD5yARG1FVuJX2gt5EYDrjqOfVD6PxNj2oVqRVq3Pxq3A1RSb5SSWZXyQ?=
 =?us-ascii?Q?EPItYMiyrFhqVXLh4UompCZUQDfJiWcJ2KeFuNREHkp5TbTjl932TJSUdoI2?=
 =?us-ascii?Q?k1C7e+BN00LYOqxRoRRvi/LXIrEGKXZh1bxf9MFrSs6k4f+FlbREEjUr80VJ?=
 =?us-ascii?Q?4wwYXi5Jv4lS1OH7Ql3F2U3PUUqAWUoDmwSHD23mR/6dxZvk8p28BWHewq/k?=
 =?us-ascii?Q?ZQRQrlOkXZ/1OvBoC0CTnULEU/arN7ykKrM5wf0vNiiW1EnAsaj0O/lm78cF?=
 =?us-ascii?Q?jUTGh9A0L3BIR2AOBx8DbcOnkGBIW5Jbqdu5dRsy12srZOQ5YV5/1SYGrzgI?=
 =?us-ascii?Q?Ai0qH3P/LXTDTDcqbl3yOmGdrcEVx9BsLDzNCPrKnG34Y+HVPi+k2UBJQZIr?=
 =?us-ascii?Q?vJVHTiOBAz1kjl2B5YOGSt1mnX9TqMETqJXvjcDx20qMSPk9+hrVRjPYmfca?=
 =?us-ascii?Q?KPvzhts9dnAroMeBLprGFz6np4JM7upMQUanS7gg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74bf113-3ab2-4273-0a3b-08da84cae349
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 05:46:55.7352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B04b3yaUYEkLcY7EL32SptTBsbZsaLK0bXJyQllMvokrFyV5jzjirgyP9PzMOaUwFBgr0T3pWyu5hpTqStkxhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2416
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Monday, August 22, 2022 10:06 PM
> To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> Cc: wim@linux-watchdog.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; festevam@gmail.com; kernel@pengutronix.de;
> dl-linux-imx <linux-imx@nxp.com>; linux-watchdog@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 3/7] watchdog: imx7ulp_wdt: Check CMD32EN in wdog
> init
>=20
> On Tue, Aug 16, 2022 at 12:36:39PM +0800, Alice Guo (OSS) wrote:
> > From: Ye Li <ye.li@nxp.com>
> >
> > When bootloader has enabled the CMD32EN bit, switch to use 32bits
> > unlock command to unlock the CS register. Using 32bits command will
> > help on avoiding 16 bus cycle window violation for two 16 bits
> > commands.
> >
> > Signed-off-by: Ye Li <ye.li@nxp.com>
> > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> > Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> > ---
> >  drivers/watchdog/imx7ulp_wdt.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/watchdog/imx7ulp_wdt.c
> > b/drivers/watchdog/imx7ulp_wdt.c index b8ac0cb04d2f..a0f6b8cea78f
> > 100644
> > --- a/drivers/watchdog/imx7ulp_wdt.c
> > +++ b/drivers/watchdog/imx7ulp_wdt.c
> > @@ -180,11 +180,16 @@ static int imx7ulp_wdt_init(void __iomem *base,
> > unsigned int timeout)
> >
> >  	local_irq_disable();
> >
> > -	mb();
> > -	/* unlock the wdog for reconfiguration */
> > -	writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
> > -	writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
> > -	mb();
> > +	val =3D readl(base + WDOG_CS);
> > +	if (val & WDOG_CS_CMD32EN) {
> > +		writel(UNLOCK, base + WDOG_CNT);
> > +	} else {
> > +		mb();
> > +		/* unlock the wdog for reconfiguration */
> > +		writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
> > +		writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
> > +		mb();
>=20
> Now this is intermixing writel() with writel_relaxed(), making the code a=
ll but
> impossible to understand.
>=20
> Guenter

Hi Guenter,

Intermixing writel() with writel_relaxed() is unavoidable here. Because the=
re cannot be a memory barrier between writing UNLOCK_SEQ0 and writing UNLOC=
K_SEQ1. This may be determined by hardware design.

Best Regards,
Alice Guo
=20
> > +	}
> >
> >  	ret =3D imx7ulp_wdt_wait(base, WDOG_CS_ULK);
> >  	if (ret)
> > --
> > 2.17.1
> >
