Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF95A55490F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbiFVIOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbiFVIOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:14:35 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10083.outbound.protection.outlook.com [40.107.1.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775B637BCD;
        Wed, 22 Jun 2022 01:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X411y5Z5aYqRAqA5sIFFp3TXdQM/o+OvrHObwfwgEGVOKeeSWbTa3Ig8noz+Mm8CBvlc0NWDix53A/S/Pybh6iCFxyuWGfX73Uz+y1wybLBBH/C9a3lM1yMgtvaWh38tkmoMHgTLtwOCdQhTk09t1OYURNHmS1sU5vQKj+gTKKK9Gz8toCltiABNJhcf5PydMGSwzOnK0J0leXcGQVXidvCAAn9Cb5y3higohTB2iNUjYeYITOzAtlIaxQn0OG67zsGOhJdzAOtSjEdwRk//U71B2OGPTkgctLcMl2bh9IJX/4/v+DsqFVBGrI5ybCII3TOpbxjWoHrXzQCfNtTlaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DNnyCcJvFYg51qz8AF1zFIda98HUszENlljTgUIBNs=;
 b=NlVA/5Acvu8iO3Iq8yHoiVnoLdh/yFfeb1i+wP85M4sO2smfJthRauGkOVJOM8qkyrCKAJgdQq7vUdIlSd3dGxdJUqd7eWsaHh9HaHxC3P59UI3SPh1UjcCbXW0bBDG6bsV9fA+QPVDuImgUPi/3xElD2R9Dc/WTmgOkE/aAt3jQAVhpSsjt9FtdogOxJJBAyNV+gt6QsmeoVnGAQ8ulTZhdf2vM5pvd5krV175O1Mgx8IB80CgLkuNdAsSQl8VlKH7KHt9/wilhp4LiVEEAEBoPncuB9pXE/PsUZO9Mptk67LMYKvU2ctPIQwB2v1bBEQHRe5PwLqXAB6ZiwXFciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DNnyCcJvFYg51qz8AF1zFIda98HUszENlljTgUIBNs=;
 b=j6yyqsrfkb9yffMZnz4BMpkW2IiicF1BRpa9I2Cn/eogeQdnaaK7MqufT6M7cFkXb/PdW8buH+vI5h9rCnwUsDXMWP2xQ+etr7vb+NjqWN8eLVZweB2/a4IVuZ5lukb2x+Rx8cEW3MS70CHcwMTL8NLYUXcKi/m07E3VpC7KTWI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7246.eurprd04.prod.outlook.com (2603:10a6:800:1ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 22 Jun
 2022 08:14:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 08:14:31 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "abbaraju.manojsai@amarulasolutions.com" 
        <abbaraju.manojsai@amarulasolutions.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "matteo.lisi@engicam.com" <matteo.lisi@engicam.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "t.remmet@phytec.de" <T.remmet@phytec.de>,
        "t.remmet@phytec.deh" <t.remmet@phytec.deh>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 00/14] arm64: dts: imx8mp: correct pad settings
Thread-Topic: [PATCH 00/14] arm64: dts: imx8mp: correct pad settings
Thread-Index: AQHYhf8Ork2RMCYk4EmRaOhujPGoda1bAQ8AgAARnbA=
Date:   Wed, 22 Jun 2022 08:14:30 +0000
Message-ID: <DU0PR04MB9417922C5D6CEE8560F0A60988B29@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220622061410.853301-1-peng.fan@oss.nxp.com>
 <20220622070600.gb3wep7rltwdivkk@pengutronix.de>
In-Reply-To: <20220622070600.gb3wep7rltwdivkk@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61fe4bc1-9ef5-4ab5-d454-08da54273bc3
x-ms-traffictypediagnostic: VE1PR04MB7246:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <VE1PR04MB724691A57E94A6AA4CC40CFC88B29@VE1PR04MB7246.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tKYnRRTPBCMrLvz15dGu/gq6IutUFVUpVVQh5bDm2PI8Nm+p9ZOjIeRoJzE6stz675MjUysofl33e/c2XKhb6YI1gCBBfHmpn+X1vbODpbsrSz5YjxgNUKweAgxbR4lVRhTJAtgI5XrUBH2NKULysaSKzrSm4S47Xvo39Z/73uJbLt/WPX9x3mhXuqCc48cRPhikfxv2i4g9uJfR1EYnNuSb2hpONhRWdgOlHvswMOC84Bl/fxGZSxAQM1Qt18MeAXKwyWxE3B6HEYAjGGiQRWoYOoVAuu/qwu1uWSF+KqsWJMo7XpF28BKPD68P5iH7Vwm09eAF0X+bkDYzBbNHh/PI7QdYbj0Zm5K4HrLIZYps3CfigJxZIUDJdbgdPrSfZDOL1bEsWZufX/jHrcx3c3aodBC88n0A9bIW4PjkJZAGng63Y6iilGHEwPeSxfm/U+15he8xg/SVe7T3IHF02scCM1Ap/7f1UwiEPBzBF1ect4kJyjdBYRkhr3JlAEY6KzRZZqeeu63wT9xJeQQ9HZUSewOU3tL2hGJcBSKO5/3mnk7RcYbdPWYyfs45akJ45vCItrA+JOh8b2nB19aulBKJSPSyEMbQarhbUVTTPjUFyIRQ5rFriyWT5LeD0VA7RkcoERmVHYhOMppDTNY5KpTXcl3Yu8QG5Z6kyUHCvEaHGRa++uM/xj/vlbGMS1EXATqTdLusds30GePNGUOuVLFkcjbZLcTcRIdFe9APhqp2tA13jw5jG0qrOVpJzmdzBMsdWx0kggcl7CcA5scMbsVKJyOA+1vkQQyd5w8/wvVG+S7dXuGxsFl7bw5zg9Q+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(2906002)(110136005)(54906003)(316002)(38100700002)(52536014)(7416002)(44832011)(8936002)(5660300002)(66946007)(122000001)(64756008)(38070700005)(66446008)(4326008)(66476007)(66556008)(9686003)(8676002)(6506007)(26005)(7696005)(33656002)(41300700001)(76116006)(186003)(478600001)(71200400001)(966005)(55016003)(86362001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lC4rmJMtJkTL7SXGPbqXU7nV3sM+MxeCM9dPRLuzkGSEQyfWMtBkyOzJzG?=
 =?iso-8859-1?Q?1HwI3x9ctMMOw54K/JTjNQ8FOZQ0E0vbEn0BLSL/yf6XsXJiOXVrQPGXYE?=
 =?iso-8859-1?Q?Hg7weNrT1PThiZ2lbWrkB48B+kh+BYA6nqXo70tGMKtGJoKLhnZAFvzIfz?=
 =?iso-8859-1?Q?IZDa4any32/tnM7Qzn+J77Sx81oWKPGUvQmQNyJ/CnxMusAkQ7SADE4iW0?=
 =?iso-8859-1?Q?wlkSDkoOCOhZoWYptQBLI9SWlWU1XbFzTI/eD1qcMAqFP+ilD53KK9VL2R?=
 =?iso-8859-1?Q?8REKR/jvl0GYffutP5Fx/4fx6+wfWCl+pIvtuN4w0OWc2pNO7cWhDN7BfA?=
 =?iso-8859-1?Q?wUTyzIYAS2d/w9zyXkWbBA1nwau0OMi6A0smM2yVCDLgE1smQ9wkS0R/tn?=
 =?iso-8859-1?Q?QiOiqeTIgOlIDBZ/WeKHGyh1M0cyebZRWAiI+WhzcCTU3zc1Qr4Z8BC1rt?=
 =?iso-8859-1?Q?UdnAgE/e7VqCSFlnMA/4rfbZ3rF3lOjFQS4tnBQnuBssn4+t9/KsbnIbqK?=
 =?iso-8859-1?Q?zq8CX4iOECZCCan+ygJ1SHIo4A2wuyo3U54+mG2ZT35q1e0FZ64+iPPlpy?=
 =?iso-8859-1?Q?G+SpKmoOdRFlHh0cIRxuObD3tsqJ/JgQIMd7DRtSrxPlOuVU1jLyBqEKA2?=
 =?iso-8859-1?Q?GOGhA6qTsJjRfGTWFQV4lIZKCDPoisky3cFaM/wvAAGbr7AE4u9M+pLj1X?=
 =?iso-8859-1?Q?oeWzNiMWvoNHwwkLpEr7YUgAw85NFo1pNK+bBx4+YtKBN/bVG2DQR9evUg?=
 =?iso-8859-1?Q?x2Kn+b+RyCdUnUE9hqCmZSgCatd5LPnsws9yHrX7sr+ByhmA4xWdm/82y9?=
 =?iso-8859-1?Q?3pQWRe45UNuQOcfzspIyN2TsRl+ljiMgCvCxh35W6moKS2WCJmPQ/292wk?=
 =?iso-8859-1?Q?ZdxY5yvF730BtveW0rX5EYI3t52impwT2qQwsTA25IBOXmr67pWy4QrwTs?=
 =?iso-8859-1?Q?YnLngfjXcpm1aDWz0jjLKPwkzv+PFlsS2ugvGMKvnG50eh2Gx/+UHAu3Pe?=
 =?iso-8859-1?Q?wOVF82zJ2p5Cvmwt+fOHslyL5JZPSxErk+5e0nYSOwE2l+zxvP9AteqaWR?=
 =?iso-8859-1?Q?k6kU0CE1kXcj4pvIzDQGrrXa94/ua986b5PVzo0NA7BN9Th+ByI0nYueue?=
 =?iso-8859-1?Q?IQZlwQ4WHpL345ZivEyC3jPOJ42V4Kzkbr/OBeFAyFuz74FYX/RtCmPAhI?=
 =?iso-8859-1?Q?lYjwMN5glqGTpWFsY/XPtkzB0e6e0gCarLjcC0edWfatSdquzy2iIxH/6O?=
 =?iso-8859-1?Q?ORwgCZh7p74Yb+AlIY41btBCIkAGh/uYeoMWl48ortnro3edkb+PDsU8z/?=
 =?iso-8859-1?Q?vI/ReKaDc+z0laXSUdnHsO6IVz46S4STywTwevl04xWR4Tuksw0zKDsGkq?=
 =?iso-8859-1?Q?X/JNfBjn6lOVXw94+drPYIiBkddKtWbfP2mku0z1K1wwgPS4287PVqN9Rf?=
 =?iso-8859-1?Q?TFJQlpRVrjBwN1W6/jtK692dtIIVp73nR1dhmUFhiOF4hAqhFUB15UiXa5?=
 =?iso-8859-1?Q?dla59Jfz3waytzIXxpy5fAJmlnK8dNp5EL03RlTrrZmFbOjwNOj8D/NW2S?=
 =?iso-8859-1?Q?n1oSNcmXpDA4RJjgj34Jo8R6MFZQfXi6WBnZvYgpp9MzUSPYMgkhEAZtN1?=
 =?iso-8859-1?Q?E6r8d291FA9yg6JMBAdg9UazNXQ8dyOX/7cT8Rxf8jTICP9lLrga6bgdp5?=
 =?iso-8859-1?Q?ZvjgaM3Suk3AC+gbf7raFmbc6Z7mvkQ1MblFr91u1lDfMakvaIKDrJSoR3?=
 =?iso-8859-1?Q?/DLJuvwORRSbal2QRiHRARhPyAWLjBrOdls4HxY27QjC9Gw4/a9KuJwfjv?=
 =?iso-8859-1?Q?/CwOVsByig=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fe4bc1-9ef5-4ab5-d454-08da54273bc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 08:14:30.9025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hoRNpJJO1GKlr4Tl4BA760zM+6q1RQAlIK/rRQ27YnrSH22AktRN6WmjnarlYBqXTe1cTEgVj2uMN64XtbzpTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7246
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 00/14] arm64: dts: imx8mp: correct pad settings
>=20
> Hello,
>=20
> On Wed, Jun 22, 2022 at 02:13:56PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX8MP iomux pad BIT3 and BIT0 are reserved bits. Writing 1 to the
> > reserved bit will be ignored and reading will still return 0. Although
> > function not broken with reserved bits set, we should not set reserved
> > bits.
>=20
> I wonder how you found these. Some time ago I wrote a tool for such issue=
s[1].
> Currently it only supports i.MX25, i.MX6DL and i.MX6Q, but extending it f=
or
> the other SoCs should be only some industious effort.

We have customer has question about the dts pad settings in U-Boot. Since t=
he
dts in U-Boot was synced from Linux kernel tree, and I found
the current settings in kernel dts not match with latest reference manual.

Regards,
Peng.

>=20
> Best regards
> Uwe
>=20
> [1]
> https://git.pengutronix.de/cgit/tools/dt-utils/tree/src/dtblint-imx-pinmu=
x.c
>=20
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 | https://www.pengutronix.de/
> |
