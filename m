Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB72B5B17FB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiIHJHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiIHJHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:07:10 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150089.outbound.protection.outlook.com [40.107.15.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB024A896D;
        Thu,  8 Sep 2022 02:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HojzLlJOV/OxLdmG45l4tRC3IMfuHHGRSZInP1cg44dGb2w9h4M5Auh4MUOSVBRzkCGt6DfjnEe46Qd05Vj7KbAyfbDpqoQVOIP0MLoMayDE54KeI6LuaHqjSsJMHJb1iXrR/eb63cUYZFJZNOII71sZNQMKGH2Ro91Nvdec2cf0mXjrzO84WkgyGdHkMcfvx7vWEZJeCx4sYNOi9uUC5/5+zwsk/wyPeQvAvyZ0zPUuPfLN+JKiPkXBJz+BGLNntxa+FcvTIMIN7tRdAaXw58keOdqhc5Qp9NjhLj2eydHPUxRIjibUNO/ujzYyjNRv4/iSgLqojDzWv0Xz/Xdpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/RgyHIxaxdWcHYiaTlYIHwkgtiXs+TrEDv68GNSQ9M=;
 b=W/PqWaBJ750GS/lSF5od3eI9MDNLhSIeAKlRYLzobJeAtMw0QzLsJJbiQmIljpATjQw86ZNe9P1TrZucQNztBO0MpvYYnHL1R3ONTSw+UxUV7bWEEqVy/W02CzVhEW9/74NOcRAce0hcmaxeLj9cGQuKHi+W1rRQ7yvibj2uGDwBPU77dtQlRNroeMqfeZG8UmdOnU7e/7OOwf7UW8bkrGgIo4Afi9yAVncafG+J8Jjl6NvOLp+YfHvg4t12AYkQnxf+tC9i9ddYJH9zljKB8UpTlcZ6Ct/jESsvWju08f43YMQ6M9EPi/PabKPP4DlyqZfpuAdYKzmGnlfdt+3KTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/RgyHIxaxdWcHYiaTlYIHwkgtiXs+TrEDv68GNSQ9M=;
 b=PNn4gRh5UgvNQ866BZQyzDCb1I0dxe79ZvjGED+5+TsI9isDr0ohNE449YUJjRlh/vnXGvt1/JvnD5OyrNME6iVCB3jKwIZD5jUn2fA4oC9ETnRNbWXtYIsT0josLolXVRX1sZpVCbMdUYudS2f6rGXiOExNbkX5vc33d8Gr9wA=
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 09:07:06 +0000
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::25b6:d7f1:c25e:24d2]) by PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::25b6:d7f1:c25e:24d2%9]) with mapi id 15.20.5588.012; Thu, 8 Sep 2022
 09:07:06 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] USB host support for TQMa8MPxL + MBa8MPxL
Thread-Topic: [PATCH 0/4] USB host support for TQMa8MPxL + MBa8MPxL
Thread-Index: AQHYwsihZnSWdyGvYEiiheIFncU2x63UHe0wgADqGoCAAC6nAA==
Date:   Thu, 8 Sep 2022 09:07:06 +0000
Message-ID: <PA4PR04MB9640E5CB572980CB087BE9E389409@PA4PR04MB9640.eurprd04.prod.outlook.com>
References: <20220907144624.2810117-1-alexander.stein@ew.tq-group.com>
 <PA4PR04MB9640CB3CA93301CA1571D85789419@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <3126965.5fSG56mABF@steina-w>
In-Reply-To: <3126965.5fSG56mABF@steina-w>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a383a6c7-97a2-47e8-1a56-08da9179810b
x-ms-traffictypediagnostic: DB8PR04MB7020:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LUcrnDtxg7JO8gt6a81hEwVfjK/vbLQPuKmepNcFtT+HNT/r10UqwKuwLSetiVjDWoCimz2zD1azmNhHVMnSMyS5u8HT7+P9SjgeM3bzsuA29cjPzOcGf+7po/ODuD0KbtOlxzbiFTa8BbS1ReZBl7o6jVRWj9dDA8d+NQgEaUFj+cZkDEqQ3oA1dWacMkwwpWeOtKaVoc+TUVu4gQBUIGdGtwHpu8KxKxWaXVXW+lxfs1Z/a0T0VqgGbvux0mOEal8qk/wqu+7VuGhk/qliWuEJVHw/OvRuC6dUFi3BizSzAq5hRCpjYilgSr8fCpRcPnzfnLdtVD7Otf/uPNAbGjPeyoJ6Ex8EwPBrV8GLt4wDjb/2pF/auXfm9Or4A17RxmduXvIQZVzBqKvbinwAQJM/Jzs5u48rA+Sj2JmoRQD9q3QwZ0/SExO0mF/sB5dMJU6TqfqrmmeIsdiq/R0ZBtmx8ouWSKBag9zuDQLEm/5ohI0r085DfP+d11V+HuGO1xev0gAX5CCNZz5Xbv0JAz/ra6mWxTLC8W4W8qKHSYwQMnxEBssJjE7M44wnCp72Czo81GlJAQIobIkI9nB9OKjqmuhbFA3FDMqldNVtWZ+OygyU14tZ7WXEfB5O2Z6H7Yy8/HUb4twYIO/mxGVSump0wtJ29cxM/SVsoHMfBLVbEVDTpQc1cvIjrviyBQmT9GEWli8pghba/kLSJvBdy9sRZzDfu6DmD9GA7o32eg38D8Tp1JjBoE9ZsCH8NZGilZt+AGxrKulKgULUgb8v8EqWOGd6G5HFAEJWvok/CRg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9640.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(38070700005)(38100700002)(122000001)(76116006)(66476007)(66446008)(4326008)(64756008)(8676002)(66946007)(316002)(6636002)(66556008)(54906003)(110136005)(44832011)(2906002)(5660300002)(55016003)(8936002)(186003)(83380400001)(9686003)(52536014)(7696005)(478600001)(71200400001)(6506007)(7416002)(53546011)(26005)(41300700001)(86362001)(33656002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lPoMNt+4MpqtddIioU9Mi+cti1Lnl8vEQ2vkh16tQBeESUIU8424mc1/re8t?=
 =?us-ascii?Q?0fOEMU39IPiH0oz49bQOG9fMnOrPZ8M3cMdJDgRyBfQ24RlRzWusFinZ+fYy?=
 =?us-ascii?Q?UBfUwcM6w0VY/C1jSs+i/w2Y0WivNWBI3NiIgETZOTkjXuhVN+e+QD60kvtl?=
 =?us-ascii?Q?KcYC6ANg96eWZ9QD8DcEGv14uKzkaSN44UkddKxTeS5dKIgM/P/ue1ErDy/2?=
 =?us-ascii?Q?EHEwXSWQMxRlHU14GnCzfxeULB6p8G62SmJf6P0LfETsbGRFQwppFZlforau?=
 =?us-ascii?Q?RIVy67/2iasDQsCcAozRwieMi9+hWBy5pcTkKi1YkrEP2e7IzRwlZp7FgrT3?=
 =?us-ascii?Q?31kS0a832Lmuib3ERwJEr3iLAIXgHoehI2pEZVnp8OgixJroMUhUr7nwMx+I?=
 =?us-ascii?Q?KJkk0GlSXeniAiRsxJ0G3OEkRNrkIPNp2d4If0BywNS8YhVzGy4sh26I5kvI?=
 =?us-ascii?Q?CttHwOdK2zOWhBzk+JzEVqGo00rtMu057OJk1DGlATiFAvPETHL3UnL76Msi?=
 =?us-ascii?Q?Jox3mfiTNbkYLTrMfED4TQ5JWRa3UBkHFUyveuuQ/buKTgZ0C64wWcRqzxRk?=
 =?us-ascii?Q?UOL2QYBHyWn+Q6PJ4xkYuehFj2gK+WzHUfachGgwf6ufN2mcCGO9zgDO9n3w?=
 =?us-ascii?Q?yQoDnAsjjac+bl1kXYhvv15CBGyEqimoI7Z0bCYl3Eq4GfoFXe+A6bFP27j1?=
 =?us-ascii?Q?qVarINr1l0PwRczs1PJoUTNv29+EODh4XB4NlguYgyYuN4Ond2Ub37Gg1Gu2?=
 =?us-ascii?Q?GImxr3+ScjaG3WThjAOh8O3x6YRtXodENR/Ellg+qJL6R/8QbwAFBqFaBc9W?=
 =?us-ascii?Q?gHOAsE+8Rayd0IHdAf9kQtU9ZLdhuDTUrmh7yV2/GtJLKtM5vwPlA3H1XH6O?=
 =?us-ascii?Q?7RQ28lH8oCpcZfPDzAPKAT3SSl2YyPDMiL7iku18370ZUpBF5wOkNYUH6di4?=
 =?us-ascii?Q?Smwk/TYyR18vX/5/dPca+u8kUVHoiruk1yRfXfXdJry/B+4G1MLVEE2msiBs?=
 =?us-ascii?Q?SdoFEwyV3Y/r8vwQoqiTmhM7yWA7OIT+5K3+JyP+63vwl6EmDKQ29xct+5g2?=
 =?us-ascii?Q?NH5CEQ3c/wAWLQeRc3neLGCtJlvRtlwLcIOR3WIAZPAokqHWB6xj7qp0aW/2?=
 =?us-ascii?Q?dPcfu6klprL/Pyko/LvYGwOqP4tQQoXeOlrpIe9nyX14zA3Z0/yaVcwcKd9O?=
 =?us-ascii?Q?DSl9eTelS9PPlv2UXKQwG6Q/xHr8HI4nlv842/d68FNy70LRmQG9NyJxyYai?=
 =?us-ascii?Q?ESh2tSoWRzrmVpDMddMNPWyKR6jV5FGCj+eExT5+W/SwDbu9aupE63oAYzBo?=
 =?us-ascii?Q?tTxuhf37mTp6HGmXk2i3bldc2tghgTBJHJWFCboFk90i+4iqtRY7RjDcCktV?=
 =?us-ascii?Q?CLVg66HghoFgWUw9+DgMTPRgDfmxpjQZaPnwYatnmrOdLKgopFiXuXCG28ud?=
 =?us-ascii?Q?0fYHYGSiYHPztkuPOApMB0wOE02aSGRLIj4gHZjf79kdT0JIGoB7ursrX2Cu?=
 =?us-ascii?Q?Re3hvSKrrWG7ct/yGJN6SyOFIa6adhtv61zx9BPWSRJQQIiF7O7fLgk/OHpD?=
 =?us-ascii?Q?BwnvVBpyTybFVFwZuHg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9640.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a383a6c7-97a2-47e8-1a56-08da9179810b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 09:07:06.8249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W12fPpVcs3H8xE7vuAxkvb03xf+aSbzpsHfnKzyJ+Y7QVx0iGF6hW1xl+4QlyeYT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Alexander Stein <alexander.stein@ew.tq-group.com>
> Sent: Thursday, September 8, 2022 1:50 PM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; dl-linux-imx
> <linux-imx@nxp.com>; Jun Li <jun.li@nxp.com>
> Cc: linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: RE: [PATCH 0/4] USB host support for TQMa8MPxL + MBa8MPxL
>=20
> Hi,
>=20
> Am Mittwoch, 7. September 2022, 18:08:25 CEST schrieb Jun Li:
> > Hi
> >
> > > -----Original Message-----
> > > From: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > Sent: Wednesday, September 7, 2022 10:46 PM
> > > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
> > > <robh+dt@kernel.org>; Krzysztof Kozlowski
> > > <krzysztof.kozlowski+dt@linaro.org>; Shawn Guo
> > > <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> > > Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > > <festevam@gmail.com>; dl-linux-imx <linux-imx@nxp.com>; Jun Li
> > > <jun.li@nxp.com>
> > > Cc: Alexander Stein <alexander.stein@ew.tq-group.com>;
> > > linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: [PATCH 0/4] USB host support for TQMa8MPxL + MBa8MPxL
> > >
> > > Hi everybody,
> > >
> > > this is a series based on the RFC at [1] for USB host support on
> > > TQMa8MPxL
> > > + MBa8MPxL. The main difference is that USB DR support has already
> > > + been
> > > added and has been removed from this series.
> > >
> > > The DT configuration itself (patch 4) is rather straight forward,
> > > but leads
> > >
> > > to the following dmesg errors regarding superspeed ports:
> > > > [    8.549243] hub 2-1:1.0: hub_ext_port_status failed (err =3D -11=
0)
> > > > [   22.885263] usb 2-1: Failed to suspend device, error -110
> > >
> > > This hardware works fine using the downstream kernel, because for
> > > imx8mp this ITP sync feature is enabled conditionally [2] & [3].
> > > Hacking this into mainline resulted in a working superspeed setup as
> well.
> > > I also noticed that on some android kernel [4] depending in IP core
> > > version either GCTL.SOFTITPSYNC or GFLADJ.GFLADJ_REFCLK_LPM_SEL is
> > > enabled unconditionally.
> > > So I opted for the latter one using some quirk (patch 1-3).
> > >
> > > I have to admit I do not know what this is actually about, nor why
> > > my setup does not work without this change or why this fixed my
> > > problem. So maybe someone with more knowledge can say if this is the
> > > way to go or what this is about.
> >
> > This can be updated:)
> >
> > > I also added snps,dis_u3_susphy_quirk to the board level as for some
> > > reason USB Superspeed U3 does not work. Detecting the onboard hub
> > > takes much longer and once all devices are diconnected from the hub
> > > it is put into runtime suspend (U3) and new attached devices are not
> > > detected at all.
> > > Until the cause is known and fixed runtime suspend has to be disabled=
.
> >
> > For this issue you are reporting, I am not sure if this is caused by a
> > USB clock change merged on v5.19, if you use latest kernel, can you
> > try with below patches applied to see if U3 can work for you?
>=20
> Awesome, This does the trick!
> I was already running with patches [1] & [2], but was missing patch [3].
> With all of them applied, USB detects a newly attached superspeed device
> when the HUB is in runtime suspend (U3).

Yes, patch[3] needs to apply with patches [1]&[2], I am applying the
same tag to make sure the 3 patches land on the same target release
as they will go through diff maintainer's trees.

>=20
> I forgot: thanks for checking with synopsis regarding soft ITP sync featu=
re.
>=20

Welcome.

Li Jun
