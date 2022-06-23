Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0475575BE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiFWInu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiFWIns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:43:48 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2129.outbound.protection.outlook.com [40.107.117.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA9849248;
        Thu, 23 Jun 2022 01:43:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij+kLv4cws0tTSot6rMqUBsDyCwqKRWQYLXzfx6TPTEqhszn/9hgGy0A2vzAABzDS9g69lVJPV4mW5TQiVwJabFLJXz9ZQxl3kmhxYaUFdvUiah3+iW2A53Ve0D/RDZzK41GBTuhtbRnOCxna/2m0sTQJFM7J3Rg09qekpqYH5q0ne9wk5ln/pf6iheABdPXpP2MOMmxV5PVBZHO36IbTTBDiKThEVGM/0QdQW6uLzQV06VUYCxMF8KpHmotOfVI65UzoVmpG2ya3tyoWGf+Q+oMaICDmhbUjdWdxQ5Fkntug4juUz3BrLmUf30XBK0vP2kbgffv53KpyU4lfyD1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bp3TtknIpV1i+dbqkp/zDwaZqR6rsoEhLmrrWFKRrqQ=;
 b=DCBtGIsfkXh+VDszy3HnogVESX0Yw9GVoIDCxaDYsJOSnh+QVxuxCQ/OWiThnX5pSrRmIzebyPxBkxzZi0cYHpFcaT1xIVyye7/eloXte3Lx7SS4Cq/4NzNIIDM4Dov6UoHDAttuKWq2exdf2/f4m7H8+ZKToYTHiowd5PM1ODKzSjaQ+3fak5dFHThPQ5giCGTIJ1BxnwhcPrOdvNgnk70tqcI4hPkHjQTTOe4ZKUWli4V9UT55yYelA1yy4xiWCbccEow2fMaY5pOdO0Bgqnb47t32PDHumYFj4Prc+1O3868D6i7gX+O3Hp14JlH+cE5RfL2e5RSOBZ+G9bbNSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bp3TtknIpV1i+dbqkp/zDwaZqR6rsoEhLmrrWFKRrqQ=;
 b=y594P8jMxGnRWTZjxpsIG34ZI6wod1ChGPoWKqPpHTLH4nXgfw8rkluS2KeyM/htF0F+YXATMKPPRl0JD3BMhsdpxHQJuij2KhT2r0Up9Z9gW2cAjd/oxNvQuRG6G1fwXuXnFUxqByl2Bor1xfSoZDOYFk22sKzEvxnSRbpnUCx9hNIFpQ7X5Bem8lKTpyJrGKQlhS09bBbkZ2TFiCJ2oJWZmZDYbIN7tBToZGmRjzUy08rJQxCvEpZ9P7k0Hflot9+2M5XBtkFBkJ8T/PXFfC/7Ixj/lf1EQEBFu7vMz99IzH9aoN7/14hAJ0XyNiUT88o9LfEgkgsTjoHJwy7Hkg==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by PS2PR06MB3463.apcprd06.prod.outlook.com (2603:1096:300:6d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 23 Jun
 2022 08:43:38 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 08:43:38 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Roger Quadros <roger.quadros@nokia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH RESEND] usb: gadget: f_mass_storage: Make CD-ROM emulation
 works with Windows OS
Thread-Topic: [PATCH RESEND] usb: gadget: f_mass_storage: Make CD-ROM
 emulation works with Windows OS
Thread-Index: AQHYhq3rzhxyDFo2ik6AmHo1KwAqPK1cnxSAgAAIQYA=
Date:   Thu, 23 Jun 2022 08:43:38 +0000
Message-ID: <HK0PR06MB320212127FAB0CF3459C683180B59@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220623030405.1922980-1-neal_liu@aspeedtech.com>
 <YrQby7M/ndikPeLW@kroah.com>
In-Reply-To: <YrQby7M/ndikPeLW@kroah.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12d7d238-3a03-4a8d-80e3-08da54f47795
x-ms-traffictypediagnostic: PS2PR06MB3463:EE_
x-microsoft-antispam-prvs: <PS2PR06MB34630B186B2E8714E3DD306C80B59@PS2PR06MB3463.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6OQPuCJDwcJY6Nqe3WbdKg/uEK4OGlE3bam8HzVTlECiSaAL5v5kcqohvW43T27oqHQ1NZZ1j+E1LB/K+ccDBvirvmjktCQjI+XpG4TQxHTxgQbkhrztUISm0SmsOFqf3zSDlZv0ShKOu2QFirnxvRvBpJ1tgx42L03rFRJ1TWAB71qtnTE5k+2RSfLPablDqx+mOmwZesLb5EQfhZZo5q36aO54Lz8a1ytX4SMivyEplilIvrLnoKWEVF3KbOIukjQrLH+BmlqNoHDgcqb6XnY323iS4uOYTY2gJzym/5YKdALe9XuuFid0i6rxH8L2jd6QR6XdgaII0dLXNFtW1MK2Oo+Rn0iGGAasQ+YbHXOeRI9tdPuhB6Uv3/rrNNpr+Ic0HlL1J1vpLaJgYApnK1ikvAjaauN2ZaZ9wAEOUKlBX3GKxsw0BPaqxtU1x/fbRhO87Hr0RlSLzO/aFxFP/9mxFjerUALGfAr8MszSXZur5LcUFb8ccRp/Nem+uBWMXaIAi5g5pmfO+26o5hoeulFK2CLR6wQjrcvL3NdIuFgMLYh252ufCFkt5G8itFkjwd+xpiYvB3GY5a+jlSzpO8Uyn2mbfN7YYGm2fDbdfLXQLev6qfS9vNV9OfUD2dLp2OOKgkLb5pyHh0Hghv929x2hRe1irwo4rsStYY6sawNRf9+0Io0Uw7miNMn0WKPzF3EeF3xnZh9SfprVyZ0AsiSuIX+nOD8z8uGo8bnMuWDjUgLoK2J9+HLzhr8UGATet5GS4YY4xQVyRTp4mLybWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(396003)(39840400004)(366004)(76116006)(38070700005)(66446008)(71200400001)(122000001)(316002)(66946007)(64756008)(4326008)(186003)(66476007)(86362001)(8676002)(478600001)(6916009)(52536014)(8936002)(66556008)(54906003)(38100700002)(5660300002)(9686003)(7696005)(33656002)(107886003)(55016003)(6506007)(2906002)(7416002)(26005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?815J6vcfx7tDYiQF+l/f6vJv4sRXRut5Xj/GgKVrpLR5aBZDVVd2lumcq7RH?=
 =?us-ascii?Q?0P0iT0Ya4YqQGlQFqxRxWQBFpIxtt43VoyNbt5PmdABGVIV1cabyvBratzGv?=
 =?us-ascii?Q?sUh+USD3ZFZa6huTuMYt9eOEAy1ECa1T2LwPjQX9JxSedFHq/XvuhrONd7Oy?=
 =?us-ascii?Q?98C1JsD52D9sFk6xOTfSmKZAk6otY5uFqvTHPTAJlsq40edwuxdjGTjZNWt1?=
 =?us-ascii?Q?s3D7qeBKYfb42L9t4NF/WP1BfUMTb6VcLr2UnIhpQmn8fAIx1zOty9Sla+jd?=
 =?us-ascii?Q?Zii/LvVU4gbLomAQ/Dvc7KOxwerLBufhGrDbIv3ajb0vdRg4GaGfWqo6Cen7?=
 =?us-ascii?Q?zofp7p5BYITibcCwI/hUlZg/7Se51BZyn1YQ40rarvwhthsYzgMkOt1G7Ccd?=
 =?us-ascii?Q?R1A499EZuuB6vj0KTxBDmD7I9xYjIkinuRSe9LC97Ad/svjNFwXeb/F05xqI?=
 =?us-ascii?Q?iDO/AVMoPvpqgCb9oV+CzpkaXgabil0EWrMyZ1/wDXp4Gz4tCtu66Ybg2ba0?=
 =?us-ascii?Q?Duf8K2GePXHitOjjNAXAQx8Kx9MH7qReR3mmI/Hp4Viaq8clI8ZpKstV8+ND?=
 =?us-ascii?Q?dkQuKQ/OW7nkOFNwuLEEbNRz4nsiGQkC7Aylmu4ns71m/EkZgyIxii0HJ6aY?=
 =?us-ascii?Q?7Ij/AXitq2gmxDkffVIAWGLH3soTJm1SJPspFNOvI3r104QO2u4tICtRzsSO?=
 =?us-ascii?Q?IWvpOtHh0vs89xcfkthzpJbuRcsWUewbbD2n8Znd62AxN2fXRkEJJ6E/dPwr?=
 =?us-ascii?Q?4QNg/igz+sAy22DoEXidlCK4y+3MI+k5gM6hlp0qQvPgcEHKtFk6Tw1fToXT?=
 =?us-ascii?Q?uYxKf6oXt4LZ2UqRUCHL0VE6Vgqe3k8T/QZ2P1eiD9quyYUkHBU4cddkNA1M?=
 =?us-ascii?Q?yhjX5qnsAEwP/o/dFcjDpZY3oKPOeleFh6xpjWnJBmo/ufGTq4x7xi7s97hn?=
 =?us-ascii?Q?kDEldzeRIjdaNK6MpU6CcxilkCy1Hv2hcbIXokhTNPgDMzZ8rGLudI0MnkdO?=
 =?us-ascii?Q?VRMssFdFvSHIPBHun6NnUiEzn+HT9bhnuF1jxFvqmUYhVw2wC74EXIJ82qIb?=
 =?us-ascii?Q?aQoVArj6dhpKUnAhS6YNmBMXlhD33KLpNLJw/CNLRi6K8VRQr0ocYWg2DxjJ?=
 =?us-ascii?Q?EjmCshtMj3pohg1NBRLKXAhUVvdiAxgCJdUkeJc1jfHaWHBjOcRhF7Ku6Fie?=
 =?us-ascii?Q?DtgbCGgiuFpceJzxg01UXwcQT9qAaCfPO5ZDvneIdVgp/7rqTmPz0ReQ2g/9?=
 =?us-ascii?Q?JigLS+WlUTBb2kw0s8YW/ejlJS6078Z34+s6/Z6t3lfUVucqSJehX4t2GVi3?=
 =?us-ascii?Q?F6mNr6XHUqzveqEqnmGepNHRWVRpLsjBNK1Mv02Oo23WBNRls5Y9AfuI1qb+?=
 =?us-ascii?Q?pr0/KzhEji5Dfxttk4P9hdjsbiyW1RP3nSpM+6Dg0bHYUk4+IRhKCbcnY/tj?=
 =?us-ascii?Q?wtuc4vdfFB7/WUy5gaxeWPxbSlFKLDHiooJp//La0/cNeqNr/daUyAzWwc0E?=
 =?us-ascii?Q?wWM/20eL2yxTctRmarcm8FhiULuKeOjz38jlQdhC6zI/UVhP/qTh7NmFTIpk?=
 =?us-ascii?Q?PKEVl0M1HnOLYQzO7bh6ExD18h4LL/msDICfOs7F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d7d238-3a03-4a8d-80e3-08da54f47795
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 08:43:38.1073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wC7nAhbSo+NeJe/d3D8nwvUK7jhExopfcBq0VqTSQFlApw8OQs24EDzqCVYKTiIVzX+h+ntNRcsvWl6TW/PNVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3463
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jun 23, 2022 at 11:04:05AM +0800, Neal Liu wrote:
> > Add read TOC with format 2 to support CD-ROM emulation with Windows
> > OS.
> > This patch is tested on Windows OS Server 2019.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > ---

Reason for resend: mail recipient is broken. Resend it correctly.
---
> >  drivers/usb/gadget/function/f_mass_storage.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/gadget/function/f_mass_storage.c
> > b/drivers/usb/gadget/function/f_mass_storage.c
> > index 3a77bca0ebe1..3c2a5f1e8b66 100644
> > --- a/drivers/usb/gadget/function/f_mass_storage.c
> > +++ b/drivers/usb/gadget/function/f_mass_storage.c
> > @@ -1209,6 +1209,7 @@ static int do_read_toc(struct fsg_common
> > *common, struct fsg_buffhd *bh)
> >
> >  	switch (format) {
> >  	case 0:
> > +	case 1:
> >  		/* Formatted TOC */
> >  		len =3D 4 + 2*8;		/* 4 byte header + 2 descriptors */
> >  		memset(buf, 0, len);
> > --
> > 2.25.1
> >
>=20
> Why was this a "RESEND"?  Always put the reason why below the --- line
> so we know what is going on...
>=20
Add reason above, thanks.

