Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831134E6E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 07:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356037AbiCYGKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 02:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbiCYGKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 02:10:37 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60065.outbound.protection.outlook.com [40.107.6.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D55B22535;
        Thu, 24 Mar 2022 23:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzazx9kvJzbY+gMaqEpmjMu6Jx5ukAz1gpRhXQ9mdpQm6X5Hl4UvMwcltbpyPK4QRJoDLAqx5dtkVk7krId5xwF5/oze79aELlgSDDwt1MXK95RqO+YBW6fhaNvkL3FGJw8bQTlQa749AOzQ88uSHOHxb/xvxOpJjTk2Th20GgFupFwczUEGZIz7a4UwXCk8a7XL/NxA1+vmclbC5Eq0+m4hwD5iH9h9hLJ7xjvtI4bOK6wUL2QEcunCOYA52p4SCZSt2TTJdfeEg88i3pP5wKukc8Kb+4PvIto7bNhfjjgcYwm6T0tnHtzfiOuBVtSXmlmhVhY+rIiUcXP5OF/UDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GmBVmlnxXbOBNFl5nN86d5kTgE6dY3GteV59Zpf0OI=;
 b=hxn2VHsGHgotm9vMIWCLPtI08su2PLOaAUjEqKIZhhMZQ6aFzDJdK24LshO0yY8FyIxIx/jPNkWPiWLaLq5gSEOF+MYXI1QvDeuQhsbP3o5U1RcfOTaWPbjumFndh7XHp5ZDfTuOHAVsA2f82voWQvkVR7PzF0I8NjJrC6lMz52CDLEbNmnKWFUCiZmxF5rPsCDHVE3tf8NZuDcQhI2Egol1jSCSX/ww1eUGBKfbTsE+An5exf/Dna8txCae9PzxSBHwx4TmmrpHdExLqmG16mScwt53zF1wr9CFqlWJyt0AKBbqseN5FnT8vrU54BOLJWYrSmBvVQZ/rnZv1cI5KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GmBVmlnxXbOBNFl5nN86d5kTgE6dY3GteV59Zpf0OI=;
 b=Juj5lLewR7ZV5gJyyI0zjELtm2SFOMfkjOW/4J4GNGAqWHbOyZ7ECaEzI2dVcc19hP+ghg4x9ttZlRe+F8cg25qz6c9KasrvTeam9dfGrLOy+klj8V2z+5tGwEzG6dmjdi6veM+AIER3ZD6C+gIfyotBd6qTRHWW5614b84aDNE=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM9PR04MB8453.eurprd04.prod.outlook.com (2603:10a6:20b:410::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 06:09:01 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557%7]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 06:09:01 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: fix potential bug when using
 both of_alias_get_id and ida_simple_get
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: fix potential bug when using
 both of_alias_get_id and ida_simple_get
Thread-Index: AQHYPRZKKS2PkrWc90O+BIkrSaMZEqzPU+kQgABN6YCAAAFIEA==
Date:   Fri, 25 Mar 2022 06:09:00 +0000
Message-ID: <AS8PR04MB840402D3CBAF647B5F32706B921A9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220321112211.8895-1-sherry.sun@nxp.com>
 <AS8PR04MB84041B39303666AA30E90DD7921A9@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <Yj1bG57vfmem4EVT@kroah.com>
In-Reply-To: <Yj1bG57vfmem4EVT@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a6fcc37-8563-4eaf-9196-08da0e25f4d3
x-ms-traffictypediagnostic: AM9PR04MB8453:EE_
x-microsoft-antispam-prvs: <AM9PR04MB84538C9A2F2DE7A1B3B4FBBC921A9@AM9PR04MB8453.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HIstKojfrstNOH4LKVXBRGdEwiIIIk26Xo4eChWxDq9bJ3a/hfLpoE/0bHrieD2G5uu2CJkVSTam3uV6gYw1Alte558xA+bgFgxBlTHwiXcT1EX9VD3/5k5lj75YSWgLUMhzvHjunwwMPPg3d8+x7+t13RdOq0Uw/KkEBu/V9rTgPzgWW90ypvow6eL9YZ08gvrlv1QO7c/1ytJj/wAlaSR0KETthRqzYz3VOoizRwvY6kU16QNh7Zapj4xQnmKG7FDHPlIV91tWUHkll0AyuSOcCME5rNixIfhVQqEFcerXo2YavT/dESjG+0UD9DuzitzNpKsHkvMI6wjY0IN7hma1EOs0GnXO9OgVq+1Z4ZXLXshFGiIT0OKFkBKC+Wg2sHJtE40lwkU0RH/GQwbxKC3Y5mS000xfZhxrIC9Q5KBQfU6h7GYQTcQFPfnm4HXt+5s3VikvckUB965Hl0llDV6+zNVJagALdPXFKyKIZVHsbB14FPkuIr117z/IZx7x4oZE8tduerVmZX3rbIzgx46PlzVwpBAql2kJ5Y67nzozQ7euQGfMLeeIwTdw6+lngCFBQpSFcrdFnAS1hc04sQ5OfX9BuUdLmP77WeDVuJj07ZYPC19ykUaZUlZqy8yVjyEdMJzFrszZx+xiMLBOivxNUz2tiCkLafg6ewemqkRHc6gZGdkY3mhVKaYf2FGHk4/xbLDiCXy9I7HzwBb6cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(64756008)(66476007)(66446008)(508600001)(66946007)(8676002)(76116006)(52536014)(6916009)(54906003)(4744005)(122000001)(8936002)(316002)(44832011)(5660300002)(4326008)(38100700002)(2906002)(33656002)(86362001)(26005)(186003)(55016003)(6506007)(9686003)(7696005)(38070700005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OUczfXSaGPjDC9eBmv22hdg7Exe72tnFGaW0WJXR85QbPEFkqcQuqTKWYuHL?=
 =?us-ascii?Q?6BURQXtCgygVJRIbPNvlBr87s15opSTt+4cEa1+JSTSk67PxUaHAs0JvGExx?=
 =?us-ascii?Q?UobT/+KldOdnoCtt9vJSXrU9rCYEfk7l2tJBlEJK42F3y8eGuLeJxos7RorO?=
 =?us-ascii?Q?zQTNd8qAREnju8o+GaPLnVGwbB3RRlM5FDXVeP+fI94Fdp2M+wnAzV9PYv4e?=
 =?us-ascii?Q?rnBnskmlhG6hDKuf2towMK7cupsWRJVLUz6Rn0dcKUsrIsM3vqex6gS2zVfL?=
 =?us-ascii?Q?uiD0sDzqZnjORgaByjuZkYIezMKV3w084uKKXRM0W/zGSS7Ez301OLrTGT+3?=
 =?us-ascii?Q?TrGGErLJJ8Cld3c/JQFjOu7q++A4gxFUKCDy31j76EkKAm8njmmH7VkKwuGT?=
 =?us-ascii?Q?/OruE1kvz9mcwsYgC02qoM/tt54B0nF3M/cszzibZqj8AI3ZyLpFv6JH8CwY?=
 =?us-ascii?Q?vDGdBOoapu2eS+fwETHVz1xfb2M4kvPhTxtgLLQkRfk92BVyfyxutyoLEbY+?=
 =?us-ascii?Q?gTmv6F4FgclbSYhuBTGP4Kw/yFIFFB8Z/mnif6Vljbegb6SQZr7+zuGfFVJT?=
 =?us-ascii?Q?6gCvkqPMipJfOEIZRN9VH5ezkdnIo4qn9ssdbp7v3tU+WN3EZAuiLhE1YFLr?=
 =?us-ascii?Q?7Gmk6wob9R6f5hUOW5Dmzow9wkb/Sn78bocu8uGLdmfgP910k9oNgilMAIiC?=
 =?us-ascii?Q?HPOIQlh7tryKCpmxUE7t5sVgHRYvxHajg2NQW5wYc2VOafdRXW6U8A0BilNP?=
 =?us-ascii?Q?3bKiYh7YCj9pgcvKdPc0P60K8iTYtEbK7K6IQ1wIbt9ybYPnyhQ9b1uZwIIm?=
 =?us-ascii?Q?sCbg4fk/I4A2sVzwLpQVNcvc1tH8WIlbOr/DnU/sbEvaREHLlo7q4oTy8sa5?=
 =?us-ascii?Q?g/Bn0U2ywKpakEQXt9yonISEBYHtVcRBybQPSNTb/atf5QBH9odD8LgMVEUQ?=
 =?us-ascii?Q?n/+i4I4tDH4cJU7MN3gg2H9tlodegTLcOv5wtKLt5sF2cJD80B4Q8RtU3+Fj?=
 =?us-ascii?Q?Pb+EcPxkTR3FpASNCiO7pc/IqffAEUxNQ0Jd/Tn5ItWn7ZkN8BW1cbXH1Tj3?=
 =?us-ascii?Q?8vTy/UIhsKe0erMJ3VLyvTDDhWcmb8Xbjb9gE4ryLBMDjQRANfyJdUVi0TEF?=
 =?us-ascii?Q?tUCkrJHSQ8xHPPFXpcHu8YqqM1EsQhyjoQ1bKtYct01z0L8zp1e1T/xc3Xqb?=
 =?us-ascii?Q?tvK6ljxeqPccLEZv0egZMfxpYe6lZu5Lz8HOvxa97fnfXg9cyZAWRghT/otO?=
 =?us-ascii?Q?vGKxMvt0/WQNhdu9iw+41XI0lGJPhXdqH7EGkPSfijDGzxfRd0Fw5DSKkuUA?=
 =?us-ascii?Q?WbzP3dpEf37mDS4v4yEwT9x0TKsNvcK/fSGWZzZKAf+kZfYwzm+KjBTOaGzC?=
 =?us-ascii?Q?3Rwu7X6P2TIskraj0j6+Y0PxCa9bU+6kBiG1PD9D65FJ+O2Mp96xWT5/2uD0?=
 =?us-ascii?Q?alaIg81nNGADP3Zb9JScjKbB/m+v55PAqDHY9mQPz9sIZn8Gv8T2N60DHTNV?=
 =?us-ascii?Q?AbUI8CwGMDj1FWsNHa/iFvrqdPUbRyjbbTE0GfhRcbmOigBPpVS+hw41BApM?=
 =?us-ascii?Q?iLDVlFsaW+5ICRmCB2lSt/XYr7BrAxU4SCiOFRH0lzfWyT7V9BQLNS24vHTl?=
 =?us-ascii?Q?THPl6/JyQv90Cml1ZhmrD8i8BhfxA/s97kxde0cF2nYa3v7ZLdoXHLUFXkZz?=
 =?us-ascii?Q?TYy1m4mX/lXYS9YQZf7s5skEtrIfe7PvLozQKB7TkFgfcxyuHwFag81jYHkc?=
 =?us-ascii?Q?B40nk0PpfQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6fcc37-8563-4eaf-9196-08da0e25f4d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 06:09:00.9962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLXBjqXwTljzPzWJbi8s9zLZ0hHKwyO5az9M11bp3YuxvJTcpice9QAo+Kjd86eyC6Cu55B7FDUF6WuH5IZ9UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8453
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> Subject: Re: [PATCH] tty: serial: fsl_lpuart: fix potential bug when usin=
g both
> of_alias_get_id and ida_simple_get
>=20
> On Fri, Mar 25, 2022 at 01:27:05AM +0000, Sherry Sun wrote:
> > Gentle ping...
>=20
> It is the middle of the merge window.  I can't do anything with new
> changes until after 5.18-rc1 is out.  Please wait until then.
>=20
> In the meantime, please help out by reviewing other pending patches from
> the mailing list.

Got it, thanks for the info.

Best regards
Sherry

>=20
> thanks!
>=20
> greg k-h
