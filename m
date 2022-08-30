Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000A65A5BE3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiH3Gcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiH3GcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:32:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB734B14D4;
        Mon, 29 Aug 2022 23:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVd7Pbwt1gGO04mV7xaafYNZrPFE1oB0Jy2gILCIMbeso/fMDMmWDmoqm9na+9Qk4xAR9HmAZkw+wUFJygvlECctK2xaSS5uBo83yUPeBrU/LsWWmBkD8gkV9kCo7CGdrzcPzOqCBR+Qx7H5sKTIepy9pCgv3OUSpoIa/mtARVZ2uDUL3MoCnBxbAlXBXYE3WFZhmfV6/d+CgYv74GIY9fKV4pN9oJtqaZo/zI0/HdFaDRWoALtN0oyiYVXL3qDJVjTEaUltvOBvn94PLUOFoip+glaZiA1IgV3QG8ZqDt1lAt5yjVjoWJNh4C4JY6NUA7IfV2KqnQjwKoZsROmKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdihtU68v+QIY3bklQVv9lvUABOCu3SvKdc7sIgOIwE=;
 b=US4EU6NISZ2KaABJi5+2IvqseTnOCor/snYvv/hnPCFiCQOk1j/o3XLC/XoB8YHF2pbJBfe141l6Qb6mC0Yj2ckRWIenc0TIG0ze4rE1ei5vLSuoubgwVteIP6dh/R+ivWNykfgP2QshE31XZS0kmJGjc0RR1rzjGFyKOTYcwA7bFFpXMU+8Xt/O5YNtg34SVh9p6xNU563ugHVRhikoLVSL05QYfulRJieEaJz3kR8YNTmCaVhqbVNWAmvj/XALrM4jSBZDpcttG/iYI7oPTprVlunjPd8Kc6a7EajJgnFFUU5KPnheX/SbGcGadW07gQGuidgJe9xkf6ygLkhLMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdihtU68v+QIY3bklQVv9lvUABOCu3SvKdc7sIgOIwE=;
 b=n1upUArYpivPeMWFyBlDBzdqGdixhZhZbN5vA0gRvFCQZnTROIa5jiP/YS6Yg2kvXN4wVxXhfKugWHKY/7C7W40E1RhwEqiE4TUTRefcoyvQRQ9iuJ1vOdOpogJeXL/YzieiNIdf2AVt2U8x/ESi1Dsll/Kl+4vTBb/r6fQDBFk=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 30 Aug
 2022 06:32:14 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::28ea:aeb4:301e:c253]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::28ea:aeb4:301e:c253%4]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 06:32:13 +0000
From:   "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To:     Michael Walle <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH 2/2] mtd: spi-nor: Add support for flash reset
Thread-Topic: [PATCH 2/2] mtd: spi-nor: Add support for flash reset
Thread-Index: AQHYu4bSUGIrY8nYfU66nbvPu6SLyK3FpnEAgAAQlYA=
Date:   Tue, 30 Aug 2022 06:32:13 +0000
Message-ID: <BY5PR12MB425817D90687D37ABDC638EADB799@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20220829090528.21613-1-sai.krishna.potthuri@amd.com>
 <20220829090528.21613-3-sai.krishna.potthuri@amd.com>
 <be7f0b7bbb25d86ac079502babbf5f1b@walle.cc>
In-Reply-To: <be7f0b7bbb25d86ac079502babbf5f1b@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f92a9372-ab85-4b05-b1a9-08da8a516041
x-ms-traffictypediagnostic: DM6PR12MB4484:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gxz5ePyRUa6ZX8Qhfhahn55H+6rOEkXUK6sbwY+WIiH1dJddKu3j0ynwut6ZXA0ABgm3GM+zojZq8UEIBjEb12TIcMcevTj/Xs7EY97Q2GciiVY5yMIQMswrbywhDLO4h5jUUmqDAdm8QNCGnRoeY9eHzRrxokE16xO5OCIhc9jnKe+dJ65X88cbCrM+iLjA3+I1guPQmPg/Je37X7Avykk2Z9V6PMvuSYajDNqXNk27ZrIMLyYQV6PmaSftfSrOIjehL2dq2GNo/bIzuh6JcJYdxUOVWs2/roz0VLuhlKNkwxzbcta/H4L10yeuJowx0LK47fb2OlrJmgEcg62osMZAvtt2Q+yH6NMK4bCIRTqqpHNptxjGI61fSwESI1Rge8cvWiX4mkVP4RRKRxvIC4RZQJIytjqe7PiXH0tAm7pryeGm91DiXUEhrk0fV45LWdM2PY9y4ReqpZyqC4LVO3b4TFDYPtnKfgS3lXuyGUOrJmjdTJqGTjyXhz20sRlJHXN8ZAJlKJigowfagxoznJsNXRlFyjlSeq+s29N4u0bzj6rep3M341CxcLrIkQw04UdI3DIkc76OTRA9ABUl6Nn6ZCo9kDu1FjX8qntlrnktFNSXJYKW2J+Ydha0y9A8aGjBRJSMtKhA4ZF52rj2q2EVeBF3HOLRT2uplpzFOX+hwU52nsqj8FbugG7bK+ZU/BC7YKHRuZ2qMysIracAxiK9lbNPIDYBxg3p37FRpUEyi5jAAKgl/Xxvw8gtA9YBj5lcKSqbOJNSxYiZ9s9C4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(38100700002)(122000001)(186003)(2906002)(26005)(53546011)(7696005)(6506007)(86362001)(9686003)(83380400001)(55016003)(33656002)(38070700005)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(478600001)(8676002)(4326008)(71200400001)(6916009)(54906003)(8936002)(52536014)(41300700001)(5660300002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9LzC+hR43/+rUJlRxCy5I0LUDDoCnCRdUECst+sRt8EnBQMC8d+XSxWDtOhZ?=
 =?us-ascii?Q?C50Ltdnrgz4Zt2FlfuNIzSpVipKsnHDI2MwtT5ev7CgFEPcDYWz2Zm3DecLI?=
 =?us-ascii?Q?kh/MvV8ZiQLZztjaGf9QC2D+z2vdQO5bwqUvnFPDeVsAPp8frEi8KgqXXri5?=
 =?us-ascii?Q?4BwIFzejo/vCj0KJzHVjBvmEddtYm10m03ZJesFyfV7ojnP4qathj3TVEIHB?=
 =?us-ascii?Q?4A8TBApE24+bLb0bxqMqzAUp+sAbIEEzvG4B51/Ef5AnIjfwoy4MF0RvtsV1?=
 =?us-ascii?Q?L+BfI3aH6BVo77kdjYXAXc9HRiIt8gs+3KAamCZf90YuPdSzKxdsqWXNSbTP?=
 =?us-ascii?Q?cEVtk7zGEHZy3FJnQiO4f9/Gm005ZzV6veH+e3VCwjUnelP9Iwfk7CpGBC2P?=
 =?us-ascii?Q?WOAWP5qiEqiENK0n/BFmGB0Hix1igSDQWlI9LFnHqBijtj7+sH4RrK4IGkVZ?=
 =?us-ascii?Q?nvQjoJ00iiasthL9gLvbDZy+8lD1xjhOlDunR+BLajTF7czWkhRkclsKepx7?=
 =?us-ascii?Q?OZII1q17fISKtxE3+uFIGKULALYEpOfqmyTfAmdOzlcMJX3kw3pUDp1Xj0Jn?=
 =?us-ascii?Q?+0SkAKxo0u5xQ6ghX7Yz4FsTx4qMr0J7CILEIPJPsszu6gYYwJaBP+iziG6P?=
 =?us-ascii?Q?8uc5OiDGVr692RYPUSq0W+nSYtK9pLQlSvCk8Xg2ZErayBdZ6gpUQkICofcb?=
 =?us-ascii?Q?2YgtMt5yFXbT8/zKHKC7gzZdn/S37sVqPkTCJyIbMWPUwAjT4xWntklzbjf9?=
 =?us-ascii?Q?3A8dxl51ILTaSrnsJCbRP3Z0OXND+N1+BjLU1+dXhBwynkva+C750oghL9JP?=
 =?us-ascii?Q?4Ybwb/eKcniXgpRYGZFinIW1JQa0dZ/v1/mcGE4uq08jmHWkn8z0EJAIDtO+?=
 =?us-ascii?Q?p5m3g+zttgB2fwItKAKbf1FX53+i56U8jtl3Pi2gs6ImxvciVcX7jhh54EGa?=
 =?us-ascii?Q?G0nG8pH1ovKq3XTDaGjtCRzGtB8o0oQfhvr7N1UKw/CODqvGTASgeQmf/JEQ?=
 =?us-ascii?Q?Xq7aZwqwHsaGwyrNKa4ucqAKv9QEnz76IOQkk6IsIqgIOZ+/CWfQZMawlX13?=
 =?us-ascii?Q?5v66JaR7YGKkegYk70XXLLJB5MEwzFYgHz0UmaFUhmrXmH5SFL3Mz20oy7UR?=
 =?us-ascii?Q?WWJc7LdsNNaOlPAl/NU0Xj7juUVkNLLiqA9S/YIJ2z7FflWLiCe2A2xZ0M1w?=
 =?us-ascii?Q?NR6agxJrKPWRi3SmuPJSB1OH2xFE6GIjd5dnpzdakbWTUvEaGKJw2fDFP57t?=
 =?us-ascii?Q?PqaQ/AbB8m91oRfyZYMWOF1Qf9lPjIktQAjuUp9rYuCWGfpH0Ejfhj2kpZuq?=
 =?us-ascii?Q?h5xm99biL+laGRBYlTZVn163JsW7fJgH4lV7gKVFUL8L7tuLGua8OIw8WM+L?=
 =?us-ascii?Q?Sfi7G1QNjkGkhmEcxjQJ7ZfX3TRPX47XFbUxw5vcuXmmedUD1fKz9m5fTT40?=
 =?us-ascii?Q?2opn9XQ38y1cg+FPQTjtW/IMoNQN1zKCbhe1XDYxtJftnQD/8/i8GkURacPX?=
 =?us-ascii?Q?nqE323OTlSN/dZZKUoFvevRY5HQkWMTRpjICNvqGSXu8UDwq0gXM9PVlp4Dl?=
 =?us-ascii?Q?Dr1K8VpGV8EmXyhD9jA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92a9372-ab85-4b05-b1a9-08da8a516041
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 06:32:13.7936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9U4k3KKn5WTCcjCktaidGU1ZnJaeAbMlGBdnohHARkCssl6OhXCjjQXIkqsazSXMyNA3bzS52B61sSNAYMzAnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> -----Original Message-----
> From: Michael Walle <michael@walle.cc>
> Sent: Monday, August 29, 2022 3:35 PM
> To: Potthuri, Sai Krishna <sai.krishna.potthuri@amd.com>
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>; Pratyush Yadav
> <pratyush@kernel.org>; Miquel Raynal <miquel.raynal@bootlin.com>;
> Richard Weinberger <richard@nod.at>; Vignesh Raghavendra
> <vigneshr@ti.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; devicetree@vger.kernel.org; linux-
> mtd@lists.infradead.org; linux-kernel@vger.kernel.org;
> saikrishna12468@gmail.com; git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH 2/2] mtd: spi-nor: Add support for flash reset
>=20
> Hi,
>=20
> Am 2022-08-29 11:05, schrieb Sai Krishna Potthuri:
> > Add support for spi-nor flash reset via GPIO controller by reading the
> > reset-gpio property. If there is a valid GPIO specifier then reset will
> > be performed by asserting and deasserting the GPIO using gpiod APIs
> > otherwise it will not perform any operation.
> >
> > Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> > ---
> >  drivers/mtd/spi-nor/core.c | 50
> +++++++++++++++++++++++++++++++++++---
> >  1 file changed, 46 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index f2c64006f8d7..d4703ff69ad0 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -2401,12 +2401,8 @@ static void spi_nor_no_sfdp_init_params(struct
> > spi_nor *nor)
> >   */
> >  static void spi_nor_init_flags(struct spi_nor *nor)
> >  {
> > -	struct device_node *np =3D spi_nor_get_flash_node(nor);
> >  	const u16 flags =3D nor->info->flags;
> >
> > -	if (of_property_read_bool(np, "broken-flash-reset"))
> > -		nor->flags |=3D SNOR_F_BROKEN_RESET;
> > -
> >  	if (flags & SPI_NOR_SWP_IS_VOLATILE)
> >  		nor->flags |=3D SNOR_F_SWP_IS_VOLATILE;
> >
> > @@ -2933,9 +2929,47 @@ static void spi_nor_set_mtd_info(struct spi_nor
> > *nor)
> >  	mtd->_put_device =3D spi_nor_put_device;
> >  }
> >
> > +static int spi_nor_hw_reset(struct spi_nor *nor)
> > +{
> > +	struct gpio_desc *reset;
> > +	int ret;
> > +
> > +	reset =3D devm_gpiod_get_optional(nor->dev, "reset", GPIOD_ASIS);
>=20
> devm_gpiod_get_optional(nor->dev, "reset", GPIOD_OUT_HIGH);
>=20
> > +	if (IS_ERR_OR_NULL(reset))
> > +		return PTR_ERR_OR_ZERO(reset);
> > +
> > +	/* Set the direction as output and enable the output */
> > +	ret =3D gpiod_direction_output(reset, 1);
>=20
> Not necessary then.
Agree, I will fix in v2.
>=20
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * Experimental Minimum Chip select high to Reset delay value
> > +	 * based on the flash device spec.
> > +	 */
>=20
> Which flash device spec?
I referred some of the qspi, ospi flash vendors datasheets like Micron,
Macronix, ISSI, gigadevice, spansion.
>=20
> > +	usleep_range(1, 5);
> > +	gpiod_set_value(reset, 0);
>=20
> Mh, is your logic inverted here? If I read the code correctly,
> you should use a value of 1 to take the device into reset. The
> device tree should then have a flag "active low", which will
Reset Sequence which I implemented here is high(1)->low(0)->high(1).
By doing this sequence (active low), flash device is getting reset, this se=
quence
is tested using Octal SPI flash device.

> invert the value here. Also please use the cansleep() variant.
Ok, I will use gpiod_set_value_cansleep() in v2.
>=20
> > +	/*
> > +	 * Experimental Minimum Reset pulse width value based on the
> > +	 * flash device spec.
> > +	 */
> > +	usleep_range(10, 15);
> > +	gpiod_set_value(reset, 1);
> > +
> > +	/*
> > +	 * Experimental Minimum Reset recovery delay value based on the
> > +	 * flash device spec.
> > +	 */
> > +	usleep_range(35, 40);
> > +
> > +	return 0;
> > +}
> > +
> >  int spi_nor_scan(struct spi_nor *nor, const char *name,
> >  		 const struct spi_nor_hwcaps *hwcaps)
> >  {
> > +	struct device_node *np =3D spi_nor_get_flash_node(nor);
> >  	const struct flash_info *info;
> >  	struct device *dev =3D nor->dev;
> >  	struct mtd_info *mtd =3D &nor->mtd;
> > @@ -2965,6 +2999,14 @@ int spi_nor_scan(struct spi_nor *nor, const char
> > *name,
> >  	if (!nor->bouncebuf)
> >  		return -ENOMEM;
> >
> > +	if (of_property_read_bool(np, "broken-flash-reset")) {
> > +		nor->flags |=3D SNOR_F_BROKEN_RESET;
> > +	} else {
> > +		ret =3D spi_nor_hw_reset(nor);
> > +		if (ret)
> > +			return ret;
> > +	}
>=20
> This should be done unconditionally, no? Even if the reset
> pin is broken, we know we have one (otherwise the device
> tree would be broken) and we can do a reset in any case.
Agree, we can do it unconditionally without checking for reset
pin broken. If we have reset specifier in the device tree, then we
can do the reset.
I will update in v2.

>=20
> Also, which tree are you using? That was moved into
> spi_nor_init_flags() some time ago. Please rebase to latest
> spi-next.
Yes, reset pin broken property moved to spi_nor_init_flags().
I moved this from spi_nor_init_flags() to spi_nor_scan() (which is part of =
this
patch) to decide on the flash reset part.
With the above agreement (reset not to depend on reset broken pin), I will
Revert this change.

Regards
Sai Krishna
>=20
> -michael
>=20
> > +
> >  	info =3D spi_nor_get_flash_info(nor, name);
> >  	if (IS_ERR(info))
> >  		return PTR_ERR(info);
