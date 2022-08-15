Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92846592D67
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiHOIUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiHOIT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:19:57 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00075.outbound.protection.outlook.com [40.107.0.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC501F2EF;
        Mon, 15 Aug 2022 01:19:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTuXXRDuYxEoKL4shPH5vdjj0sdeSmcCZuVI9XvLaRj21XnMIR+BdWr1V/Zm/Oz0s5QbZqAKa9ROMC2Vdu1edADW0YktfQJVaG9XBXlHqBd6MisH4eQsw5/pzLDdT3Hu1Pxwa1RjoDHGQNcaDB9nhnD/UrOyzTu9UQL2rTO9uhGTOjwz1c/xHrXsDMsW6ywVNcwDxBLbalceMZJFI+8EqAUsNQTjeMgSMhCtgNBL5so1LpN5NsfNzJUxx1iomQc3+CQlxmEQvGcHiejv7MKXwzGxkC22V8BcMEb/BS1tUwrIWbPlXJSbUwsbfh5Dnx92pFKEv0Vu0ynFStaqN2hdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TLS5vt8H9Q081Q/sL6+yHUW93Ea8YKmrux/eOCRtps=;
 b=bmShEac0sTGE0bo2LvpGzxJgQ7JHWKo4z/KE9RBtvsj8LZuBKlH/emFAX2YZrBbBRgnCayP7aZTW0ZfarlI5YwHlfDPdvMBDJUXtyJm9Rz3HJgLoK+tXsFKvjTvJmdIAvB2ZfKNDS7FrV8u0RQ33ug/JyJUJ92es/r9F31doC18l3hNAkGJO8zRPC+BV8l1YMoXEGR7BlvGR1UB57lAYxUWmIhT8qvIkf/XXoVzzqeXVrD+h6UyuxilbaPuniEWTYcN3nuk9YkYbze62pMUq4tVzGPlqDC20rGwlsuDoOJt7tqMgm0rhHKI8/yy5cBzyn6Hb7p7MR8Is+MqXcwElQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TLS5vt8H9Q081Q/sL6+yHUW93Ea8YKmrux/eOCRtps=;
 b=Tl4z5+GZR2BNwzlQnxDXBCw+yOJl2hBklv+W15GoRNf/ZBG9mzH/jwDWrQCgR7PReeoWRP4hIg3SWnpLpG3VTFKAokTlq1Ytff5XIPVrUShBADLaQIffwukpUpo0MydCaCUeyraMVIlr9paUD+pgx8ou0/buDLQISUvYnyGotK0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8177.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 08:19:52 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 08:19:52 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH V2 2/8] clk: imx93: guard imx93_clk_of_match with
 CONFIG_OF
Thread-Topic: [PATCH V2 2/8] clk: imx93: guard imx93_clk_of_match with
 CONFIG_OF
Thread-Index: AQHYsEZuYWbH17PgG0WYVC/rOZFd7a2vnfQAgAAAYhA=
Date:   Mon, 15 Aug 2022 08:19:52 +0000
Message-ID: <DU0PR04MB941789A6D3600233D878BBCB88689@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220815013039.474970-1-peng.fan@oss.nxp.com>
 <20220815013039.474970-3-peng.fan@oss.nxp.com> <YvoAwL9qhmE03kgi@linaro.org>
In-Reply-To: <YvoAwL9qhmE03kgi@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 213da0e2-8f69-4c6f-1257-08da7e96eda7
x-ms-traffictypediagnostic: AM9PR04MB8177:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x9oxoYQcPO7eOWgyTxhQEnnqfsOFxe+yQQTbBjiNX//hEn4GIZXgl7Ba29ipROaOe457C3z3wL/MhzESJ8+0R81peCCSFbiduCXGbo5Xp61WlvcE2lm1wDgLALtmgOvDFlkQO4gJxFt0ly+PfDwkQgLdQd4MExTOlWo9Isd1sAUemsbBEK/a20kbm0rB6Wikcd2DLwiQZc/3COnNnfF//KSzgiTHd3LCvl2qwou38LWlVLh/Eh7RRY055z8ZVa0SsauHHCaWKgZaiUpO6RIqMev7FtHRk3jTClc6wjxjTPZIs2B8tXxcaR7594RW7z+kaCP0D/t4fyVLRCY5VBjjV09XfV8+C+kgzBFH4NTj/L80LeA73n6FGGWvnGOulhBCnIzMU+rlBhKi4w2M9qnnOSq4x3hmcJtMB8ItqwChsfRdI8iXZ99Hx5mqwob23q9lbEIk7uTvp2uO8Gy/UXVMm3lUm3RpvFUdUtLUOzYQFMfSwKQ5/3lmw5L7rb4g6HmTvN//FjH5+Y7QPeDeyqD0faElcDvL6QUmPX9+pysF3un80xo1F+gQKe/OsthmYp5KK9Xf0hfYt2AvTrD5aP4oFy8FT78b+7/4uSgrjhUxmarh+TI3Wu4ETvxJAG0pdqXFs+4g2fw5p8EPrAy25aXDVOyhlhUa4OualmKpd5rV9I6pCRBwG02yzPyLq3KWLsrTQQ6yWMB/23cilr0Oqt5YGYWS4uISXKGhICjgzvDo+2ihLrzEV3/7MWea/NpTjpzpVGZTxPWZm1jZlnL2Cotx+YUIWKE3smd9WT6Qyt6M5Lr9f4PLK1OobzkPQAn2moKX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(186003)(33656002)(26005)(38100700002)(122000001)(86362001)(9686003)(53546011)(6506007)(38070700005)(83380400001)(7416002)(110136005)(8936002)(41300700001)(478600001)(54906003)(71200400001)(66446008)(66946007)(5660300002)(316002)(66556008)(2906002)(76116006)(44832011)(64756008)(8676002)(55016003)(52536014)(66476007)(4326008)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6IM3LFxF6gEUxQsmf63FqRSgz2QCyF4Lz0kDLDr2tT4yWMzzvBQuHFCD55a4?=
 =?us-ascii?Q?CDZS2SOzzR+ribO9O1TTymF/mIjZOvr8aBs6qSpUPy3pFeg7x5vz8P7lOmnU?=
 =?us-ascii?Q?USGJOj8ej7Y3R9z2F0ZtGnDGbbdTAJ2sKNZ2ix2rzflmWH4Fdelqv/iXibHg?=
 =?us-ascii?Q?UXHejBEX4Rj6Zukl6BvJCiQ3tA92zZ5mGQTS9Nw4UQnzv3w0d6DZscUxfnSw?=
 =?us-ascii?Q?QNBiWjkjYDzmbnC4PWgN9JO0pBzuR16sfUdhmrluvIJl8TGHbmQEUXUEKp67?=
 =?us-ascii?Q?pJ2MM086HnP4IlnX9kIs3iJ1Nl9crvVWtRWNkqRc9sHvR5/iPFJW3qA6aFRT?=
 =?us-ascii?Q?fO854sHc3z0hprWlwTfo5Gs1QL8Uuog62olz/gaAV3UDq435BXUamlK2E4Eg?=
 =?us-ascii?Q?Ke7bY2EXAd6yE1OViD1Fynftf03obvVnWTfHJpxkJDrXtaI6iUdBk/yOxWrb?=
 =?us-ascii?Q?Ky1/21+LkJ9Toybpy6Da+68hkj7+nmlijg32Qawkr4W/WKvINTy+Hx9C704p?=
 =?us-ascii?Q?win3SjUGQFxN0j7/9ZRzYa4gLNbV6t98I39yGPw5zCqokR6kRTxPXyfLvJ3D?=
 =?us-ascii?Q?YXNI6kevO6dMnZPGNej8K4MuwNrNB4l4BQFd4DDyc3ZKiwrNXzbJ7+PO4i+q?=
 =?us-ascii?Q?IaWXRl57YwfA511qTq1QlqYqiqT5Hhp8OkfwNj+YdO+577H9QpBbHjFgXnjK?=
 =?us-ascii?Q?GAEtqJHrF+GYjKQ9q1cccp/N+8QdwCuc+WhMd59vUZ13QXbMTw0/2wg7PaVd?=
 =?us-ascii?Q?XPVxugbk0N+3Sgq25ebumkhKqajxnTKU2JcsmnChgFvmAGlAMy6aUlzAWlWA?=
 =?us-ascii?Q?YgLVcmoFhHv4nWVc8GKJJiUFk93pjk/g7h8qItpnwHDgSZf7ZDYewLjG86B/?=
 =?us-ascii?Q?/afcTfFFu1MeYhtaANwNLXoo1//YOOa1NXLVMWLoJ8YX9D55jyw0OykOsYBq?=
 =?us-ascii?Q?txeoj6eemYkiW/562/D1QnpONmv5R7RUDNIPCH04jZQV4MtUJVQWYjYiLpE+?=
 =?us-ascii?Q?mabZ8j845evQhZ/O/xH8NTdgS8lj+t7bLioIU/eMGoFpnDVYAukvQXPgG8Bq?=
 =?us-ascii?Q?ey7X80goChHwJPlsU67dWuP7ETWV81c4FpQN2WYSI6YGzJmwRZBKWzuw52DQ?=
 =?us-ascii?Q?RXwzhhDNSVfhmj13T2ZPEpNl5WGekLVXA6lZvDZco/HlSS+dIC43mD4r6Rwz?=
 =?us-ascii?Q?J0wi58QNV2bnl2QYloAoggPK3ni8QUq5JM5VA9Y4FBQnAcCU541MNA/GIo2i?=
 =?us-ascii?Q?KgLaE5oIZAOtGlLhSV5485bJhPNrVFePsigsFGaxqNX8usNHNYZJYkCEzldM?=
 =?us-ascii?Q?8j4ZTtFWcAL/XGZDo87b5oqn4TmIcCf3gyZBIhUb7FMV23bekyarkZCWDabv?=
 =?us-ascii?Q?k9Wq0+Z/2K+SJts5cq+rhDy57BaeJepErCIv/c/phKpKuFos8ZdIoY/uZ+aV?=
 =?us-ascii?Q?xa2jU9LK/lYyvp7uBnujwIxwQ0SYjobHFlqJF+DOwqsI14bCeODzvc7hhNUx?=
 =?us-ascii?Q?aqEcLS23lg2utnrlrMjP2RNM82B9IB9LJU2WU4v7CK7osGNZ16cC+j40Kwi6?=
 =?us-ascii?Q?bG2I7nF9g8H2vN1YEJo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213da0e2-8f69-4c6f-1257-08da7e96eda7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 08:19:52.3221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nBFVawp5/M9bSFIPIAwNLFgGar47zNi22k/H+wLZ3TnghCQWEtaru7PDJGkZfn2wILLl53VAlnsil2MmjpKUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8177
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2 2/8] clk: imx93: guard imx93_clk_of_match with
> CONFIG_OF
>=20
> On 22-08-15 09:30:33, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > There is build warning when CONFIG_OF is not selected.
> > >> drivers/clk/imx/clk-imx93.c:324:34: warning: 'imx93_clk_of_match'
> > >> defined but not used [-Wunused-const-variable=3D]
> >      324 | static const struct of_device_id imx93_clk_of_match[] =3D {
> >          |                                  ^~~~~~~~~~~~~~~~~~
> >
> > Use CONFIG_OF to guard imx93_clk_of_match to avoid build warning.
> >
> > Fixes: 24defbe194b6 ("clk: imx: add i.MX93 clk")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx93.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> > index f5c9fa40491c..5099048b7916 100644
> > --- a/drivers/clk/imx/clk-imx93.c
> > +++ b/drivers/clk/imx/clk-imx93.c
> > @@ -321,11 +321,13 @@ static int imx93_clocks_probe(struct
> platform_device *pdev)
> >  	return ret;
> >  }
> >
> > +#ifdef CONFIG_OF
>=20
> Hmm, I'm not sure if we should do this or rather should we make this driv=
er
> depend somehow on CONFIG_OF in Kconfig.
>=20
> Looking at the other i.MX clock drivers, it would seem we need this for a=
ll
> them too.

No. It is i.MX93 use of_match_ptr, I could drop it as i.MX8M.

Thanks,
Peng.

>=20
> I fairly OK with this, but maybe Stephen suggests something different.
>=20
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
>=20
> >  static const struct of_device_id imx93_clk_of_match[] =3D {
> >  	{ .compatible =3D "fsl,imx93-ccm" },
> >  	{ /* Sentinel */ },
> >  };
> >  MODULE_DEVICE_TABLE(of, imx93_clk_of_match);
> > +#endif
> >
> >  static struct platform_driver imx93_clk_driver =3D {
> >  	.probe =3D imx93_clocks_probe,
> > --
> > 2.37.1
> >
