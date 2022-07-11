Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B6456D54A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiGKHG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiGKHGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:06:39 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50085.outbound.protection.outlook.com [40.107.5.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B6B1A82B;
        Mon, 11 Jul 2022 00:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmfHDJu7r+HIr/mEVVnvJ+JLq6FOoRu6ufEXx7l8lb4KfN8vPhaXfzV0aZyLg79xnY3qj+BBSsDlQIyztaZhQpQIzkIQPhtZguH6xNgsjTTnN0WSKc81tVCZGj+0I5WRgGeyTPuMf6WNiBT/weHFB/AG0A8SKYS0a6vG2HG8Eo5koS1UwUIZHZUpCv/vOhkmIEOhm9an+3PEZa2ubf6L37dKmv75yT+/HUaQrkCR7wGKOsM3H48CyV6e+jtf65xHddbAMYVzcwtdH04+F+0j95jAMy6C8lUThEJztrsxoCuDgFri88yrthdwnhsMGsYEyWDEENJblQ71habHGRHsww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJQ1uhsZRWRm38RoWyo5kQQnO7wav4vcTBiZjVr+FJ8=;
 b=Qyni+KCUh8iHKZYpd0Ye2GxNWH9la5bTTVsOGjZAk9fNB/bAG+Yv+alYz9UyZdM2ibhI4Bwp2b1oB7y36EbxKiZbqSt3tqxYDI+a6n49KZzJ6GV0KvY38ij/qzt6H5ceIGn1LG8UdKoV7TBuDAsFsHfTwB4uP4r3ItNKdvUVjAfAcz2bXnpME3u+LJEIYjS0h4nvjtwBQQDOOL9IiHkfV3+qRFjXW/e8fDq05ZkVNlQHWbDzlORjt0qUWA91tZWsIBrlEUVqLxbw7gKrESP4GqKMd9yqMlp+YgaaMl+eSu/mRF8i3SqeeughHD/vSe3qL8SCUbX9WskIIKCS87H1PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJQ1uhsZRWRm38RoWyo5kQQnO7wav4vcTBiZjVr+FJ8=;
 b=Rupqy0lKlPly6GkNh6tW1c+jiysgd6UoZP4hsKUJCAgk1qTsibwscWfRvfOnnIpZfiLC22qGoW5ZY9n9rHPj7eEpFoc5USkcQF9NJpfoRe/Z8SY6zrmAtm/4gGtjzQ9n9c+OJRjT6eYvVWfNC/brnntQol/7tCOeLznfoS3Vuio=
Received: from DB9PR04MB8412.eurprd04.prod.outlook.com (2603:10a6:10:24d::9)
 by DB3PR0402MB3785.eurprd04.prod.outlook.com (2603:10a6:8:f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 07:06:35 +0000
Received: from DB9PR04MB8412.eurprd04.prod.outlook.com
 ([fe80::1c1b:6695:20d7:fd10]) by DB9PR04MB8412.eurprd04.prod.outlook.com
 ([fe80::1c1b:6695:20d7:fd10%6]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 07:06:35 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Stefan Agner <stefan@agner.ch>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] MAINTAINERS: Update freescale pin controllers maintainer
Thread-Topic: [PATCH] MAINTAINERS: Update freescale pin controllers maintainer
Thread-Index: AQHYkrKgOsXMp01W1USV9rkV5D7Muq10Z+GAgARb4AA=
Date:   Mon, 11 Jul 2022 07:06:34 +0000
Message-ID: <DB9PR04MB8412A2D2D536E2F3B47B080687879@DB9PR04MB8412.eurprd04.prod.outlook.com>
References: <20220708100952.1998673-1-ping.bai@nxp.com>
 <082e1f7cb783479edb34e2b3321eded7@agner.ch>
In-Reply-To: <082e1f7cb783479edb34e2b3321eded7@agner.ch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcd81bfa-b854-4d16-3b03-08da630be478
x-ms-traffictypediagnostic: DB3PR0402MB3785:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KeZEOvfPUH3kdq5yz91oqglG0SFyVyH4WHOM08RUg9pc0/JWTzK8APTairnmeZOLDYREg5M5cQRJXd1t10B3/x58BF6rfnBeevFfiHyPcrtFa3V6L4J2P4V61a5ZeLoHwcFmniDfyGC4IStaZ4vXrXclQ1pjvk18I2wGByQtAQy+CUQNvQEYvuiqpOpw3tQKJZW87RqdAAxK8CoDwIL/+0rj4n5zDLiD2Fjf2QBQpt2nvNixYk1jtWDajSrTaT0v0p+MxEKvnBeNw2doH+6qNh8udv4oAkQ86eD4lnwzAQW3d6nQ31Fjy1GKGstrHyc1qixkajLN0aqf3Dy34xtTakNbgdYDvTo7ABI8qc0oOIdo8AOx7tbJ+tumCjFQyy498o1cauhTSOaHY95LQhnhC9tqHK8Z1Javn+1uKansOP5hpOIanRlk6EkXX9hvosb9pGtMAqlDEDTVI7ltcDDrcwYmijVjSXki/sK/CE4u3K2RXvxRO8k178+14hsZKJd1V1RjJKXSJckeoF7mnQ2MLYozJC6Zz7J/SC+6mYdDzzFlE50aPT6YbFCfH6hy2V8MeKxv5fHro4dAimIzTcpJns82NlW2bmnpxqeNwiPkDot+rwQSnrgjzy+gFf2isU0z1uc94UvyIUUzghF8hKhe5qXr2b47J39Uz8Sz/KN39z36yzbnqM668UmKsehZSBKAHwOvEVpiJ81zKoCsPpSRUk10CF7132lmnLH7myO0FODqttBQq1ri6fcplSUNaRLdZRHc6UImE7gzhfgCCGNa8b4hfyK4iC+2odpS+bH1IRM2fHZJyD546OOXfucqrKxZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8412.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(15650500001)(2906002)(38070700005)(122000001)(33656002)(478600001)(186003)(4744005)(55016003)(83380400001)(76116006)(86362001)(316002)(52536014)(5660300002)(66446008)(66476007)(6916009)(66946007)(54906003)(64756008)(66556008)(4326008)(8676002)(8936002)(53546011)(71200400001)(6506007)(38100700002)(9686003)(41300700001)(7696005)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KF3Klj9qQBXiI+Pu5OxrV/u2dvbDYh2JSA9c2UBdYnp+4RbV/iwgKOnyVdZW?=
 =?us-ascii?Q?B5uB0xtPY9S15irGnXvldl9Xo+lWMom52ewP5kS/rEVHDlfjp0qJ7Qx2JlRi?=
 =?us-ascii?Q?oLX3FWW8NH0Kqerjip6RlMi42AeOQ7uGxbw2rbqTQnHI7SBc+dITujdH66l/?=
 =?us-ascii?Q?0VovdlypouewI8j7bye/JsyAS6/05Jot5qkdvfhzRJ9lMFHCtkhsQTUKhzjl?=
 =?us-ascii?Q?L9qhbV5ewJctw4PhxOcdgsHnxn2pLTLOJlAEVqo7/fXx25UiaNiwBLCyLvQI?=
 =?us-ascii?Q?zMxc92NqaJpLj19iXrLHpzHYvvsCacHMPlnBFJmR4+GxsQBYl4Tr4WzRAogi?=
 =?us-ascii?Q?QBYIIrozA9WETFrOz+/rVmrb0GR5bSD/HI4a2Nw6Hy1xcHVd5jeTLW+CqgTz?=
 =?us-ascii?Q?/3oaAJKuqJeXhoS1t7JPd/4Feio/uxhGcspStqjoxCEzjrTUC4Ouz6my8mGk?=
 =?us-ascii?Q?sogVL2lKl6r05hi4yjhKFUjdMlh9kDbFxYmCuECoz40WaydsBUvN1xamcZPo?=
 =?us-ascii?Q?kF/MeyW1lHkeFO/XE/kwWi4LQM3UuDZGSDhPR7rz6N22HxfWGDNKsFxzUgOE?=
 =?us-ascii?Q?aBatZJDX1dxcdHjd/RKcBK4fYzJSKNYCbscDLqkd0UtV1GOfI3JZ67osYNxZ?=
 =?us-ascii?Q?xi3HcLxrCLaosQmXBcuz767EVnXnPJ0HbhDcC7caGDLzkqjaM9GWR910yV80?=
 =?us-ascii?Q?2k2Q5ij8z/EzeNyiRyxVpRe6rQ3H1jjADkuffUeb8MK8yUAKxlECs3bbE3b+?=
 =?us-ascii?Q?JEAq6o0z6kPK52s+Jv0Pfb+sC3O34T2uF/cwoMxurgSsiYBnXPX7PGWX4YFo?=
 =?us-ascii?Q?PUINKolO+jMTxN5vUQ/DvDAq8IAxpdzmw34KzWIUsHIgXpmcyJ4hOcS2uPei?=
 =?us-ascii?Q?WLaQIv0V2zIi6BS978RbtGqvHTagneYBrArZaiohgqzXuO9EDVkJzx2y3znZ?=
 =?us-ascii?Q?WPTcjkQVjsf+kHU9xQhUicx7FR0oeGXQTE66yn3l2q8HZL7T5q2niOTsx01C?=
 =?us-ascii?Q?bKdKkvOwHwOK+kxJUS4doGbhtV4xBke9sMbUyqCGJU6BWpHYC1IbFW9/LTKa?=
 =?us-ascii?Q?NaKrt/i2lirxf2HZHhEsKBuFySwKVcszQ0RBfNdZV6hTwTDpSTk4Afg4nxqG?=
 =?us-ascii?Q?5L7m0YRn4NYG6Da5uVH6dVERO8F6LtaU4MrZEM+qsvvzL0ifv8KROn+miveM?=
 =?us-ascii?Q?c+SU5/LivmrUJP6s7Wj7JZ4ULes5DscY7kczH0Q/4X8WXi5qpqpAUKOcNHia?=
 =?us-ascii?Q?tEpzwDlqsUy8Q0kdFWXI2wJyy+QfcVhcwzlJtWYGIsw0J/+tX36FeYWEAXpH?=
 =?us-ascii?Q?z4mFKdsX5BvcUcjhpYMSChk1qDIcecMzTspUtNNaN9rTUeW/rd+ByJXTfOJ4?=
 =?us-ascii?Q?Z0bIEoOafZTPT41MV2+iiEbxI6Y1EWwJ1JrWPGOc2Y+kDsAy127HnULKiRta?=
 =?us-ascii?Q?I0HjEsJhkdGfMl3QTQVTB4F2Rj/Qn+HxkKUHSNLp29h852qKezgCYgr4/6Ae?=
 =?us-ascii?Q?Nca/NvJtQhKqLP8kM3upUxqiLTzsjs0bYByRXFIsVbmupKoDeUuRplMzMPbn?=
 =?us-ascii?Q?emdtJT9xrvx8NdKJRWw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8412.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd81bfa-b854-4d16-3b03-08da630be478
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 07:06:35.5065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: atKzevdX2Z/b/a1Q/HSEayNF2DPDhCnyNmelSkDB68XdNR2BYduHZzjfZn5WUA91Na06znqQMQ8xeA9hhD/fMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3785
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] MAINTAINERS: Update freescale pin controllers
> maintainer
>=20
> On 2022-07-08 12:09, Jacky Bai wrote:
> > Add myself as co-maintainer of freescale pin controllers driver.
>=20
> Acked-by: Stefan Agner <stefan@agner.ch>
>=20
> While at it, can you remove myself from the list of maintainers? I don't =
work
> with NXP hardware lately.
>=20

Thx for review, I will handle this in V2.

Jacky
> --
> Stefan
>=20
> >
> > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > d6d879cb0afd..fbed6cc287b7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15557,6 +15557,7 @@ M:	Dong Aisheng
> <aisheng.dong@nxp.com>
> >  M:	Fabio Estevam <festevam@gmail.com>
> >  M:	Shawn Guo <shawnguo@kernel.org>
> >  M:	Stefan Agner <stefan@agner.ch>
> > +M:	Jacky Bai <ping.bai@nxp.com>
> >  R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> >  L:	linux-gpio@vger.kernel.org
> >  S:	Maintained
