Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A122951D121
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389383AbiEFGVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbiEFGU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:20:59 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2138.outbound.protection.outlook.com [40.107.113.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B009B5C360;
        Thu,  5 May 2022 23:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXigJqjdFE2p4D6gjvPPa8wxpHWDr3huBzcnkrSMzwQw0Z8+XUj75Ey+0fEsYw8djuGgGQ0t4hOdv0l2SVev8Rb64kwH5PxBWQg8e2JYmh2YVieQY4W4anBayRYLTKfIBoicm3Z+CzGKGOBf/2lidONex9PQGI2KaX4UXbvDLPTD/xorUNLHHDyqs2yjO+UEuJYX8RV5cK/6BP/2w/WRg3KySTwDZ0w+Edi6BecXoKsi8CSGw382IuganMdoVnpf8pVXF8dCfNYSSk1ouHj8835d3Eqe2ZbA1+SVJT4pxCNsNt3MVAXPG0u7eEwwfC7hBTt4AMc9Evu0YS6doy/RSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozYVviVEs227MbVzJvrk52aosAul6P/qluzbuyExtI4=;
 b=VNNxJKioN2rlkPcnqKl7EDkeqNfY8nGZbYT3M80ZGWuj4rCE6iAPjAxI5Yy3XEfodU0WOwkRczNxztEC7pebVw9r1Qh8/NzLsOZZujJk4LChJBCmDYcKZwe5gVTEY6mLsuSRLPGsOg1Dqge6GwyWt9liJXbDNlv2rWt0NuxUd4ma+XDS5T9JLRhm5u2QsHcJKk/SwCE1KQ/MegnEB055MTUx3Hj0hyIM0iP6ll5wAug5zzi6jbZmazmc037x8HPNWVTtNfi0Zm91mLkNtnHYRRE9vSfEjRQKvINX1n8HfpkxIApcC7PE2LMwUEFLQcy5HruSy8QI2WgW9dVAls353w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozYVviVEs227MbVzJvrk52aosAul6P/qluzbuyExtI4=;
 b=US8ylm6QuMUuBNJCj44GUQ6PWxTMoJIHzSZiCO60W2CkkUoKIEM3TW4RLL6Gf6E7o5aDKWGaxwD/gHLxn2naWx3XHPUgc133ZhP1OLHBn5LMoMX6ExswZzFzYvTLPQC0oY4pMy0c2TKKZXSeyL5HMahd4coszSNRPrky2gI/QGg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY2PR01MB2713.jpnprd01.prod.outlook.com (2603:1096:404:77::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Fri, 6 May
 2022 06:17:13 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%7]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 06:17:11 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [RFC PATCH 2/4] clk: renesas: rzg2l-cpg: Add support to stack the
 resets instead of indexing
Thread-Topic: [RFC PATCH 2/4] clk: renesas: rzg2l-cpg: Add support to stack
 the resets instead of indexing
Thread-Index: AQHYYLbVZusSN6uyHkGFU4WhZ5VwLK0QryBggACwqUA=
Date:   Fri, 6 May 2022 06:17:11 +0000
Message-ID: <OS0PR01MB5922F57B34C8E515D520630C86C59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220505193143.31826-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220505193143.31826-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB592225B5A5E1BA7D250C466786C29@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592225B5A5E1BA7D250C466786C29@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04746585-3170-4671-bf28-08da2f280eb1
x-ms-traffictypediagnostic: TY2PR01MB2713:EE_
x-microsoft-antispam-prvs: <TY2PR01MB2713C2C6D297F74FE662FB1786C59@TY2PR01MB2713.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 85Sg/qKvsLIsHS4xtcWmcOw7qRoMZlVvGS46aQwgWpV5YU2swNLdj2Ab8BENA0SgvPSEIsCTmJNumVcGUDH5yL9QNmEtIUCgdAnOKDU7lOxk3mGp3ZVZlx9pDnQH62ISDmkS+q0RKr4YewI4EunOEp6AKbOqI2C27gF1mw6zXtRqyeN/VPwmUcjUGZVNaGL2lC3JeAexhni+/r+vTvs5n8eVokjkksQnHAA8i6MnGU1Wd0e1e3iLukrk2meu8VG0A5bRiGYar5z4RmIGsfMwOGJb/uGwbxyQhMc3tPWSk91+7mOhXLZPA2pTIMvGxHI1Qjy76B9ukZxrf0xPIVRAtGR087ipwX9oeYnd9DOuGf2vWO7zI2k/Io9hCeekZg7rpMeV9ixCZwOYm0EM/EosYxmtqsHclwtqji2SgGTde97IUrxtMLmFA1QPfTh1TJijfRtXO0kV4ErSLG4fKHoTLS0h3uyexXdmdI/JQBD/Y2EZDKJ0wR9sL0g4+J2hFYoocV3axyUt6kIz8GyhdLmqQ4sgU8w20C9/0ytN2HpyCh+RH6lEPw3aCA+/hRsz/0h5XOnM23AnTKQam035JdgRdP63ajbUKuKmQenJ0BFKCTloKDqYuljg2gPyzzhi6vIAv6e/9CywYUAxTP2+SN77xWJoeAJCTE3caghzN4MpzqnkHLKSaijMMItJFMtGZ6/9pkjcJWLImRkMta0TDVq6fg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(71200400001)(55016003)(508600001)(2906002)(186003)(52536014)(107886003)(54906003)(33656002)(86362001)(110136005)(83380400001)(9686003)(7416002)(122000001)(76116006)(5660300002)(6506007)(8676002)(7696005)(4326008)(26005)(38070700005)(38100700002)(64756008)(8936002)(66946007)(66556008)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?biy2g+9IPlDFp6EXFpi140o4dAMELiHwlXaG0cPpLt7UYM9OB6sdtc79oRJB?=
 =?us-ascii?Q?iuWEECj6+JeElWET5A9waQyGXmfeJEZpFKOuI1507uenBtbk2xdsyQHIjO1u?=
 =?us-ascii?Q?NR3e/TJlQWHfhnSESK9FM2AMLF+sb+R/y2Dof8Se68y43Lk1a4SmhF/vls5O?=
 =?us-ascii?Q?dmqAcIQ6M7pTx4FJB0O9at6Mz0U+lU4tNSLprtD/+pTb46LVTtvi0SposnpX?=
 =?us-ascii?Q?kSHdlmH2qatted7t53+Cswz0Hafh8jUJMYRwFluwFS6fXBySpjl2aHAw/z0U?=
 =?us-ascii?Q?R3HcjtpCSUXvIpzD+lzgmAtTgfYU2lQrl+2f1xA76ji8OjsyQwm6oU29tTx6?=
 =?us-ascii?Q?Er4n62ZlT6DKTjDZAGJiSblcBLVP78SOS5GUziOzjWNiEszY4Mx6rGaqMYn9?=
 =?us-ascii?Q?/AcqRyLmZQpUkDdrheQ5+aBVuNHPxFsc0ex274BnZ/0yIu5QZLTDhvptqvtB?=
 =?us-ascii?Q?OjCaW8mKMfym0XZTMzRtG+MsveRyiYB9rQtK5K0gf1aHOMKVv1XFH05ytag1?=
 =?us-ascii?Q?xrmCdr2nKlpvyLfE2e/M6/rVUnZ8zatqqV1D6HbAcpDVZSfMN3pvI5Vov77M?=
 =?us-ascii?Q?hLxPyciNxMoT7KsV3/v7GZRbpBvNw7eCAf77Rw2TdNxfMIMOnNOlwVs6rUK+?=
 =?us-ascii?Q?cnI6arztcrvRAad4dwwG6SUcwWUdMAAPN+ESn/pV1ehkXIlMZOBYmkHs0TQX?=
 =?us-ascii?Q?pmwscXCoNVsUfB0xh6pfRWC8IuxiOMqE9eFxwskow1PiV/w+8zNcY0qwf5Y3?=
 =?us-ascii?Q?iqcSG83Cw9YPek3ZuW4iXx5mq290LwwtXX4jLmD7FI6tX7KRT7HUX709WChG?=
 =?us-ascii?Q?1Ks9vTFhKvLMGJFGcy2+p5SfVpX07vTkO9eMQ34f1ovdpGWS1IacWa51xPkO?=
 =?us-ascii?Q?bxIXegaicMxfVcahtXMcI/BcAG5CNWONYzHsu7x8OyJ7qLA/iHEoZydGVDdQ?=
 =?us-ascii?Q?xXlMcY1FW5IZCJEkJbU2OOz5UEpGybcopYoHCzhEPAFPXXCkMxerUNVa3oue?=
 =?us-ascii?Q?es9nyWtjNPssJt7R74sDmuvaXCChKSE3Imd4Xc2Je8n42r02d/88lia+nweL?=
 =?us-ascii?Q?KVczFP7khP+xzL5FBanKxboe4RIjkYdvNU4cZIp+tEmIC17n2FKRUPHuzY92?=
 =?us-ascii?Q?YWT67OLaxMct4050Vb0d5HwroG8M/GS3cSZneg6q9UGf3PdVki6pg4PAwnQZ?=
 =?us-ascii?Q?DLXogkaHImlUAfloF8zdwDJLPHPmXH2QMMxrJ5QhO0qjrIgH0xv/1maIRuSW?=
 =?us-ascii?Q?8d9+bImciHmMaWIkIxd//OafJhz4SrgZ58UBeREUiGp7+61wMBnp4kkOm80v?=
 =?us-ascii?Q?JGN3VsBqgYqSOcu+h0JeRj3S1r7We5MJ4Hom3zLGGttLMieMOQ5l3pX6D5w6?=
 =?us-ascii?Q?UIlNmFErwmoUZ6iCjgFyYMnVCERhy6ucKLyU3vXQp6zxm/VSA0uIjhoocFzH?=
 =?us-ascii?Q?lBdbM9GlE6Z/bxYdMXwDixRKPJqGhTDnMY191YYzsw+hJ+gfH5qjCUJIV7MZ?=
 =?us-ascii?Q?gzgp67RiT1o9IHjMOrjHjCPiPuFLgEBjsRXnt9hCohOKMVMknI1qVme5BOnq?=
 =?us-ascii?Q?MGGLRhjEw7g0yWNW3m7wq4e0zA1LVloulSfJO9nl0c/njuoOXswlwRYsqTk6?=
 =?us-ascii?Q?bwFnOgv3k29gwRtTQny964AXpymh9ajOG2NZB75jE795IBgGpSyieR0UAhTi?=
 =?us-ascii?Q?YTsdA5z+YLv7CwOyxuWaOwh+lU2fiY62ZBqGDWFGNAclfBK4C6aXLGNFdGaX?=
 =?us-ascii?Q?wEHOv7qSVNmlmSRcg73a4rgzv+EiUpM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04746585-3170-4671-bf28-08da2f280eb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 06:17:11.7604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TKHh4RsClmW0lE0PGSApafyUWDvEibX3BdVFZIjWo05ssUSjTrph/58j8ULddhmK3TlYEYJmxuscet/6k8jMTptXHPKujs/MHGc2MRkRvg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2713
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: RE: [RFC PATCH 2/4] clk: renesas: rzg2l-cpg: Add support to stac=
k
> the resets instead of indexing
>=20
> Hi Lad Prabhakar,
>=20
> Thanks for the patch.
>=20
> > Subject: [RFC PATCH 2/4] clk: renesas: rzg2l-cpg: Add support to stack
> > the resets instead of indexing
> >
> > Instead of indexing the resets, stack them and instead create an id
> > member in struct rzg2l_reset to store the index. With this approach
> > for every id we will have to loop through the resets array to match the
> id.
> >
> > This in preparation to add support for Renesas RZ/Five CPG in
> > r9a07g043- cpg.c file where the resets array will be split up into
> > three i.e. common and two SoC specific.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/clk/renesas/rzg2l-cpg.c | 76
> > ++++++++++++++++++++++++++------- drivers/clk/renesas/rzg2l-cpg.h |  4
> > +-
> >  2 files changed, 63 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/clk/renesas/rzg2l-cpg.c
> > b/drivers/clk/renesas/rzg2l- cpg.c index 1ce35f65682b..94fe307ec4c5
> > 100644
> > --- a/drivers/clk/renesas/rzg2l-cpg.c
> > +++ b/drivers/clk/renesas/rzg2l-cpg.c
> > @@ -681,14 +681,37 @@ rzg2l_cpg_register_mod_clk(const struct
> > rzg2l_mod_clk *mod,
> >
> >  #define rcdev_to_priv(x)	container_of(x, struct rzg2l_cpg_priv,
> > rcdev)
> >
> > +static const struct rzg2l_reset
> > +*rzg2l_get_reset_ptr(struct rzg2l_cpg_priv *priv,
> > +		     unsigned long id)
> > +
> > +{
> > +	const struct rzg2l_cpg_info *info =3D priv->info;
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < priv->num_resets; i++) {
> > +		if (info->resets[i].id =3D=3D id)
> > +			return &info->resets[i];
> > +	}
>=20
> Is it not possible to use shared reset like RZ/G2L and RZ/V2L?, which has
> optimal memory and performance wise we can avoid bigger loop.
>=20
> Like adding Last index of RZ/Five as last reset index and Handle RZ/G2UL
> specific as invalid reset index in xlate??

Or add a invalidate_resets() callback to info structure and in probe, call =
this
Callback,if present to invalidate the resets which are not specific to this=
 SoC.


>=20
>=20
> > +
> > +	return NULL;
> > +}
> > +
> >  static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
> >  			   unsigned long id)
> >  {
> >  	struct rzg2l_cpg_priv *priv =3D rcdev_to_priv(rcdev);
> > -	const struct rzg2l_cpg_info *info =3D priv->info;
> > -	unsigned int reg =3D info->resets[id].off;
> > -	u32 dis =3D BIT(info->resets[id].bit);
> > -	u32 we =3D dis << 16;
> > +	const struct rzg2l_reset *reset;
> > +	unsigned int reg;
> > +	u32 dis, we;
> > +
> > +	reset =3D rzg2l_get_reset_ptr(priv, id);
> > +	if (!reset)
> > +		return -EINVAL;
> > +
> > +	reg =3D reset->off;
> > +	dis =3D BIT(reset->bit);
> > +	we =3D dis << 16;
> >
> >  	dev_dbg(rcdev->dev, "reset id:%ld offset:0x%x\n", id,
> > CLK_RST_R(reg));
> >
> > @@ -708,9 +731,16 @@ static int rzg2l_cpg_assert(struct
> > reset_controller_dev *rcdev,
> >  			    unsigned long id)
> >  {
> >  	struct rzg2l_cpg_priv *priv =3D rcdev_to_priv(rcdev);
> > -	const struct rzg2l_cpg_info *info =3D priv->info;
> > -	unsigned int reg =3D info->resets[id].off;
> > -	u32 value =3D BIT(info->resets[id].bit) << 16;
> > +	const struct rzg2l_reset *reset;
> > +	unsigned int reg;
> > +	u32 value;
> > +
> > +	reset =3D rzg2l_get_reset_ptr(priv, id);
> > +	if (!reset)
> > +		return -EINVAL;
> > +
> > +	reg =3D reset->off;
> > +	value =3D BIT(reset->bit) << 16;
> >
> >  	dev_dbg(rcdev->dev, "assert id:%ld offset:0x%x\n", id,
> > CLK_RST_R(reg));
> >
> > @@ -722,11 +752,17 @@ static int rzg2l_cpg_deassert(struct
> > reset_controller_dev *rcdev,
> >  			      unsigned long id)
> >  {
> >  	struct rzg2l_cpg_priv *priv =3D rcdev_to_priv(rcdev);
> > -	const struct rzg2l_cpg_info *info =3D priv->info;
> > -	unsigned int reg =3D info->resets[id].off;
> > -	u32 dis =3D BIT(info->resets[id].bit);
> > -	u32 value =3D (dis << 16) | dis;
> > +	const struct rzg2l_reset *reset;
> > +	unsigned int reg;
> > +	u32 dis, value;
> > +
> > +	reset =3D rzg2l_get_reset_ptr(priv, id);
> > +	if (!reset)
> > +		return -EINVAL;
> >
> > +	reg =3D reset->off;
> > +	dis =3D BIT(reset->bit);
> > +	value =3D (dis << 16) | dis;
> >  	dev_dbg(rcdev->dev, "deassert id:%ld offset:0x%x\n", id,
> >  		CLK_RST_R(reg));
> >
> > @@ -738,9 +774,16 @@ static int rzg2l_cpg_status(struct
> > reset_controller_dev *rcdev,
> >  			    unsigned long id)
> >  {
> >  	struct rzg2l_cpg_priv *priv =3D rcdev_to_priv(rcdev);
> > -	const struct rzg2l_cpg_info *info =3D priv->info;
> > -	unsigned int reg =3D info->resets[id].off;
> > -	u32 bitmask =3D BIT(info->resets[id].bit);
> > +	const struct rzg2l_reset *reset;
> > +	unsigned int reg;
> > +	u32 bitmask;
> > +
> > +	reset =3D rzg2l_get_reset_ptr(priv, id);
> > +	if (!reset)
> > +		return -EINVAL;
> > +
> > +	reg =3D reset->off;
> > +	bitmask =3D BIT(reset->bit);
> >
> >  	return !(readl(priv->base + CLK_MRST_R(reg)) & bitmask);  } @@ -
> > 756,10 +799,11 @@ static int rzg2l_cpg_reset_xlate(struct
> > reset_controller_dev *rcdev,
> >  				 const struct of_phandle_args *reset_spec)  {
> >  	struct rzg2l_cpg_priv *priv =3D rcdev_to_priv(rcdev);
> > -	const struct rzg2l_cpg_info *info =3D priv->info;
> >  	unsigned int id =3D reset_spec->args[0];
> > +	const struct rzg2l_reset *reset;
> >
> > -	if (id >=3D rcdev->nr_resets || !info->resets[id].off) {
> > +	reset =3D rzg2l_get_reset_ptr(priv, id);
> > +	if (!reset) {
> >  		dev_err(rcdev->dev, "Invalid reset index %u\n", id);
> >  		return -EINVAL;
> >  	}
> > diff --git a/drivers/clk/renesas/rzg2l-cpg.h
> > b/drivers/clk/renesas/rzg2l- cpg.h index 92c88f42ca7f..a99f2ba7868f
> > 100644
> > --- a/drivers/clk/renesas/rzg2l-cpg.h
> > +++ b/drivers/clk/renesas/rzg2l-cpg.h
> > @@ -152,12 +152,14 @@ struct rzg2l_mod_clk {
> >   * @bit: reset bit
> >   */
> >  struct rzg2l_reset {
> > +	unsigned int id;
>=20
> Now you are adding 4 bytes to each reset entry in the LUT.
>=20
> Cheers,
> Biju
>=20
> >  	u16 off;
> >  	u8 bit;
> >  };
>=20
> >
> >  #define DEF_RST(_id, _off, _bit)	\
> > -	[_id] =3D { \
> > +	{ \
> > +		.id =3D (_id), \
> >  		.off =3D (_off), \
> >  		.bit =3D (_bit) \
> >  	}
> > --
> > 2.25.1

