Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110F758C58F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242376AbiHHJab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242399AbiHHJa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:30:26 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2098.outbound.protection.outlook.com [40.107.255.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D501022;
        Mon,  8 Aug 2022 02:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8mN+axK/Jq3OUHFrh6gZoQHvrVhEb1mXuM9b2bMJb8cH0zT5GQAXJagQx3PAX35Cxe6RAl7L3gfw6CTDFenFYwJ9Mnvtz/Gv2RckJ1YO+gOPC1DFPYxR/v1xcyGQcq64j8Iw928DDs0dr8PBzJ1paBJKdf/aSNXd64g7E0DDJh/RiiDqMhtUNrVpvXOL3gM2CCVbllIi8MSxOVQgERu2AhHe/swj8M6+hcE9W/dykbK2iJadBt8XiSYvx3havKbOTiGpKMAYUMC5VBgZcFWvPTiPj9XJSf+p8mWi758YOoNr/FUtj+CY1kayF/jmHJX2gWNMMskheUWI/p2qL/0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75TZEkwwdF2hJuE+7KIkBZJdju0oeB58yLeca2rIn6I=;
 b=jbm0OM5fLm7DzBuViF3Vchb/W2oke++mvkCUTeMG0o6DQbiUmR4uCWBz/gQXI7q5Qa46e0O1q1sNu6RPVn/M9vb+PpGJ64Fjfz2guo3dmzSq2D5cIPxfAfq49FwAzY4fgOFw079tdop+BiJjO4A/Q21CZucqS7Gx+o6Hs2T4+pev0XVMQigclaKxQoJ0J/SQ4v9+3WgyIGz5nSFtQMmnONq2Bboo34XkOUQJJmd+wZOHrvMukx0cTNm4NDPxOFK3/37PF8TC6ajPDwHZd4JkgZBWYhuDL0vYbkssgFZTvaH2podcmADWPjOeBkGDYngSDJ9wRiSGO0hTQFoVf2QVmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75TZEkwwdF2hJuE+7KIkBZJdju0oeB58yLeca2rIn6I=;
 b=2gJ4MT/k9XwlQYPcy8HONyfmBd3Ta9tutiqs7qS4ex95gqDUqWAfUozmLzqLkAsqhdirxkVlM6+mkuoQ6xfNtpcgYQUi7RxU7BQV88Q5hVL1d/VFKlHwx2zp8jypyvO0tlyCF1wuyZjPvBYNJs6JW87EqKEjoHDwVfkN/GCtUuhodRDWVxEMxBD1YbuIidOijdtSAv/MrM0KheosX4iFeqCo+UoIJfxlOEKMthsAXL9CxhulFg4e/ISoucG/BQhXnPXXPBZ6I5mSX+BgU00lPwFzHtCx8bw7Teq0q54Zd8xe0G+g8rVE5VScFCuMN9pC/klzft1oneLc/IfX5sk8KQ==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK0PR06MB2547.apcprd06.prod.outlook.com (2603:1096:203:6e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Mon, 8 Aug
 2022 09:30:16 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::b8c1:eb0c:b3f3:57bf]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::b8c1:eb0c:b3f3:57bf%5]) with mapi id 15.20.5504.017; Mon, 8 Aug 2022
 09:30:15 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     liulongfang <liulongfang@huawei.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Dhananjay Phadke <dhphadke@microsoft.com>,
        Johnny Huang <johnny_huang@aspeedtech.com>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v8 1/5] crypto: aspeed: Add HACE hash driver
Thread-Topic: [PATCH v8 1/5] crypto: aspeed: Add HACE hash driver
Thread-Index: AQHYoOO/FCxUF/WBPkOhfzWPTKR/E62kYikAgABsQIA=
Date:   Mon, 8 Aug 2022 09:30:15 +0000
Message-ID: <HK0PR06MB32026709F521B1D2F6A1B95C80639@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220726113448.2964968-1-neal_liu@aspeedtech.com>
 <20220726113448.2964968-2-neal_liu@aspeedtech.com>
 <5ca081b1-9a96-5b58-7a27-75c94af119d2@huawei.com>
In-Reply-To: <5ca081b1-9a96-5b58-7a27-75c94af119d2@huawei.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 410f65d8-d478-4772-bfff-08da79209a19
x-ms-traffictypediagnostic: HK0PR06MB2547:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bh7H+DrwzDeIxL9KYYQMNgDcknYcSZIQQaKRxNYyL1Sge4C9JsUtJSt0gE081kqIMRKD/y5TluGIhqgKgcj/u78kf/1x7Nub1MCAJjytaA5hx6zuahPfpIs0BunguuuVCWaZSJVbSvZJ7GvyZagIoOZYCdQP4OHVzjUK3KdwsbP6bVc+2QLvE8s0XoUtvQaVJ59hV5BXuF67ndwoI1/rkm+U+ocWDRpNP4xmcVlYSLLIA6nJz9lfo7Mj+pihDKPNttX4yH+YP6UopX2ZZn+XrmuXENWuIcY42Qy+j8jB1Ev+25JaNvxNJ0DHiKjrt4o/8NZ8iTz75VDKSemtWON5d3kaNbKftXMqVOoq9FK6hp4jeEA/AJXu0xIbF8demDEmCCPip/CrTIuHihSKgAvwYnm3nYINOcS9bqe52/jx+BV4Q1ov6o4FqHlG6pUDjaUlRlDLQJRIZqIcto/pEecwDzx3ycL+DyLoiNLNwHO5a5bImSRGTO0lTxyG5dgZs9VvBEyFIa2QPCf19vF4+8YZ5MJdjaGa7Rjm9ZAnR6BnAA/iiP/EiNlWvy3FRGlspt7m1B+fPtCSQhEyH0SAgu5/zuyBw3R9M2TAYVMXuIackmG2yD+NgaSysKFauul8Rv7GcxqoTLYihFiHWWhbDXqJoQDIRU0v7B/HJSq5ZilII8pfzYT8IOONS6Y5iMEuKTmnlCIJlOUQ0Sd+nmiuJAVIJl5ZC5m8WhOZjrxczjc68wByG3lWuv/zJpbIBESSxUwuWTSlpfUqFKWSfr2oksVuRlKjPFnJabzqjRd0qchsBnb0e/EpS8Yj9MxJ/KSnEIBg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(136003)(396003)(346002)(39850400004)(66946007)(76116006)(66556008)(5660300002)(64756008)(66476007)(66446008)(8676002)(4326008)(6636002)(316002)(54906003)(110136005)(86362001)(55016003)(52536014)(7416002)(8936002)(30864003)(33656002)(2906002)(122000001)(83380400001)(921005)(186003)(38070700005)(38100700002)(41300700001)(71200400001)(478600001)(26005)(7696005)(9686003)(6506007)(53546011)(107886003)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l8fcwy5vE0v4oolmAW9mxOO5EQGwuDCgVngHWqrxWNWLr+yZ9wNGx2tV9M+p?=
 =?us-ascii?Q?Zqr5/rzmDHooItLuBT1sZy03vRXmW0/gMN+l2BzgmM+hfzqBwBFKis13TRnw?=
 =?us-ascii?Q?Y3tmopGCINT1h5r+0FG0g85XWi0+hiC1SxUnxwOeKFfhPOfE+SQJci2hlFqb?=
 =?us-ascii?Q?YZLLumEtZkYD/cd/ljy462+oHEW8SrRnBtzYzaYx+tlqa5LjiwiNZofqctJ1?=
 =?us-ascii?Q?f+lMaiiBdnqGx/l1E+YmL+bImysyGnmYMdA1+HIhx/gUAwWqUfvxtnS5Yj8j?=
 =?us-ascii?Q?Q4AbTN4WLM1dQsaxiVCyq3idPJ/R6ODYFBXAECwiEB65D9ds9jk8PjO1MpFG?=
 =?us-ascii?Q?syqjtH7NK75TZkNr8gEGENypLtJo7391yTcjlsJ6JQvjj3rTklwuQj3yiyNT?=
 =?us-ascii?Q?K6dp1a/8aLtqg8J0Jp5G4rDkeb3X7BOKGCZbcKjB/Mud2EGr0BqN9KzjmQrb?=
 =?us-ascii?Q?OxO0Od86z6fFPK8dHLsZ+nFQ9nrPXAe/hkS7i0OHFFgwWrLNAUYl8g9hSqzh?=
 =?us-ascii?Q?VydvxPvLwcfnJ6xyRxGMBeQOVhIz14J/Wmb3i1pxoTelxGKhx8RKuNSmn5nk?=
 =?us-ascii?Q?1VrRzcj2oVo8LUepnfx1pKIWp5NGiQ/xOToHT4WQnQmHd/NF8jXJlb8eWw+x?=
 =?us-ascii?Q?wHacCn2xaNfxXeo7X5cRQ6lAUhmxQlyBAJvVKOsD9eMSXe4GWv/6v4XK543B?=
 =?us-ascii?Q?E5nAjfP4aYMrbjUYCV71NJQ0OuKgo7x0DDnNPCf4Gkv+3Dne/RqOzxjXGIRY?=
 =?us-ascii?Q?Oc3b1lK4cDxL/Lj0sTODaU98aU8OB4EjzQeR88TAtm15KuA25R92Hv78BszB?=
 =?us-ascii?Q?yaOxN2/ZI+fV8E+K2uX4HH8vTeYj2FqX9DHlDPdI33k//kxP9FuvyKBC4gEV?=
 =?us-ascii?Q?gpqgArpkonZ1altpyV07u8QB6Um+E4yDocr+Wph4tgExRCJEXaevuKSB+A7k?=
 =?us-ascii?Q?TY6EIcreb0N6DFARyGmosyXN/Kc7rGS9xBBJCBZfd2PVqAXFjD6aEoMRGf6l?=
 =?us-ascii?Q?Fb+Z7ShUiUo8wbYEHgjSyv7QRQ5X41NwUTcIfZDUEqAI5FSR+grntiI8kXan?=
 =?us-ascii?Q?YP2aE0t716RKvZ8CSOwHFxWtff8Q4wcqaQVoQUAqHqHv+fkb4UeLNzRuN/kA?=
 =?us-ascii?Q?4bbS6MLswYnWI5RU+NYvLejQNLV3jY80dUhW6A7IBlMWcUEwLharTlUai4qT?=
 =?us-ascii?Q?g/npYgnsZ4WQMP3QzOqsDBal9mutqyx/sLdArr/4Sw8NubbfXO3jsb8G+ECy?=
 =?us-ascii?Q?Gt+ou4tW4O4bDr3xCxUhp2J6NGvNzy9BayNmQVWJwm1BBzdh1xObAbAaWIoF?=
 =?us-ascii?Q?Zck45TrCjHLnGg4bwegWebjfRxZeUcDr8PnPGJuayRaFVQKbZ9Jnfdx6y91C?=
 =?us-ascii?Q?HMj7KDhsYkCu/AZsukpAIEKl4UyCCUVegGpS3iHb6Q3wV5CthA6yl85dXR78?=
 =?us-ascii?Q?xfEwM1pYmKs7gpM5nF7xufpfAkSa4PM7RFThoOjhLUQXKAExUh3DrWXIr1Db?=
 =?us-ascii?Q?W82+kqLYbjdDACg2T+RrOHGG7NxXJC0EGO/jQPxy4fy4INnzXL3dpA0YGvtL?=
 =?us-ascii?Q?BCp0TcCEEvqQt17LrnQUcNQaFsDCp+hijBszpv7m?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410f65d8-d478-4772-bfff-08da79209a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 09:30:15.7483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8jbqlTqnLm7FTP2i4aABIBTr2D7pZibGV+cE/lu52437JNPnniI6pxMLn4E9Eza54g31sxMmH9D/PF3kFLx6Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2547
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: liulongfang <liulongfang@huawei.com>
> Sent: Monday, August 8, 2022 10:53 AM
> To: Neal Liu <neal_liu@aspeedtech.com>; Corentin Labbe
> <clabbe.montjoie@gmail.com>; Christophe JAILLET
> <christophe.jaillet@wanadoo.fr>; Randy Dunlap <rdunlap@infradead.org>;
> Herbert Xu <herbert@gondor.apana.org.au>; David S . Miller
> <davem@davemloft.net>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.=
au>;
> Andrew Jeffery <andrew@aj.id.au>; Dhananjay Phadke
> <dhphadke@microsoft.com>; Johnny Huang
> <johnny_huang@aspeedtech.com>
> Cc: linux-aspeed@lists.ozlabs.org; linux-crypto@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH v8 1/5] crypto: aspeed: Add HACE hash driver
>=20
>=20
> On 2022/7/26 19:34, Neal Liu wrote:
> > Hash and Crypto Engine (HACE) is designed to accelerate the
> > throughput of hash data digest, encryption, and decryption.
> >
> > Basically, HACE can be divided into two independently engines
> > - Hash Engine and Crypto Engine. This patch aims to add HACE
> > hash engine driver for hash accelerator.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> > ---
> >  MAINTAINERS                              |    7 +
> >  drivers/crypto/Kconfig                   |    1 +
> >  drivers/crypto/Makefile                  |    1 +
> >  drivers/crypto/aspeed/Kconfig            |   32 +
> >  drivers/crypto/aspeed/Makefile           |    6 +
> >  drivers/crypto/aspeed/aspeed-hace-hash.c | 1389
> ++++++++++++++++++++++
> >  drivers/crypto/aspeed/aspeed-hace.c      |  213 ++++
> >  drivers/crypto/aspeed/aspeed-hace.h      |  186 +++
> >  8 files changed, 1835 insertions(+)
> >  create mode 100644 drivers/crypto/aspeed/Kconfig
> >  create mode 100644 drivers/crypto/aspeed/Makefile
> >  create mode 100644 drivers/crypto/aspeed/aspeed-hace-hash.c
> >  create mode 100644 drivers/crypto/aspeed/aspeed-hace.c
> >  create mode 100644 drivers/crypto/aspeed/aspeed-hace.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f55aea311af5..23a0215b7e42 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3140,6 +3140,13 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/media/aspeed-video.txt
> >  F:	drivers/media/platform/aspeed/
> >
> > +ASPEED CRYPTO DRIVER
> > +M:	Neal Liu <neal_liu@aspeedtech.com>
> > +L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> > +S:	Maintained
> > +F:
> 	Documentation/devicetree/bindings/crypto/aspeed,ast2500-hace.yaml
> > +F:	drivers/crypto/aspeed/
> > +
> >  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
> >  M:	Corentin Chary <corentin.chary@gmail.com>
> >  L:	acpi4asus-user@lists.sourceforge.net
> > diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> > index ee99c02c84e8..b9f5ee126881 100644
> > --- a/drivers/crypto/Kconfig
> > +++ b/drivers/crypto/Kconfig
> > @@ -933,5 +933,6 @@ config CRYPTO_DEV_SA2UL
> >  	  acceleration for cryptographic algorithms on these devices.
> >
> >  source "drivers/crypto/keembay/Kconfig"
> > +source "drivers/crypto/aspeed/Kconfig"
> >
> >  endif # CRYPTO_HW
> > diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
> > index f81703a86b98..116de173a66c 100644
> > --- a/drivers/crypto/Makefile
> > +++ b/drivers/crypto/Makefile
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_CRYPTO_DEV_ALLWINNER) +=3D allwinner/
> > +obj-$(CONFIG_CRYPTO_DEV_ASPEED) +=3D aspeed/
> >  obj-$(CONFIG_CRYPTO_DEV_ATMEL_AES) +=3D atmel-aes.o
> >  obj-$(CONFIG_CRYPTO_DEV_ATMEL_SHA) +=3D atmel-sha.o
> >  obj-$(CONFIG_CRYPTO_DEV_ATMEL_TDES) +=3D atmel-tdes.o
> > diff --git a/drivers/crypto/aspeed/Kconfig b/drivers/crypto/aspeed/Kcon=
fig
> > new file mode 100644
> > index 000000000000..059e627efef8
> > --- /dev/null
> > +++ b/drivers/crypto/aspeed/Kconfig
> > @@ -0,0 +1,32 @@
> > +config CRYPTO_DEV_ASPEED
> > +	tristate "Support for Aspeed cryptographic engine driver"
> > +	depends on ARCH_ASPEED
> > +	help
> > +	  Hash and Crypto Engine (HACE) is designed to accelerate the
> > +	  throughput of hash data digest, encryption and decryption.
> > +
> > +	  Select y here to have support for the cryptographic driver
> > +	  available on Aspeed SoC.
> > +
> > +config CRYPTO_DEV_ASPEED_HACE_HASH
> > +	bool "Enable Aspeed Hash & Crypto Engine (HACE) hash"
> > +	depends on CRYPTO_DEV_ASPEED
> > +	select CRYPTO_ENGINE
> > +	select CRYPTO_SHA1
> > +	select CRYPTO_SHA256
> > +	select CRYPTO_SHA512
> > +	select CRYPTO_HMAC
> > +	help
> > +	  Select here to enable Aspeed Hash & Crypto Engine (HACE)
> > +	  hash driver.
> > +	  Supports multiple message digest standards, including
> > +	  SHA-1, SHA-224, SHA-256, SHA-384, SHA-512, and so on.
> > +
> > +config CRYPTO_DEV_ASPEED_HACE_HASH_DEBUG
> > +	bool "Enable HACE hash debug messages"
> > +	depends on CRYPTO_DEV_ASPEED_HACE_HASH
> > +	help
> > +	  Print HACE hash debugging messages if you use this option
> > +	  to ask for those messages.
> > +	  Avoid enabling this option for production build to
> > +	  minimize driver timing.
> > diff --git a/drivers/crypto/aspeed/Makefile
> b/drivers/crypto/aspeed/Makefile
> > new file mode 100644
> > index 000000000000..8bc8d4fed5a9
> > --- /dev/null
> > +++ b/drivers/crypto/aspeed/Makefile
> > @@ -0,0 +1,6 @@
> > +obj-$(CONFIG_CRYPTO_DEV_ASPEED) +=3D aspeed_crypto.o
> > +aspeed_crypto-objs :=3D aspeed-hace.o \
> > +		      $(hace-hash-y)
> > +
> > +obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) +=3D aspeed-hace-hash.o
> > +hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) :=3D
> aspeed-hace-hash.o
> > diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c
> b/drivers/crypto/aspeed/aspeed-hace-hash.c
> > new file mode 100644
> > index 000000000000..63a8ad694996
> > --- /dev/null
> > +++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
> > @@ -0,0 +1,1389 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2021 Aspeed Technology Inc.
> > + */
> > +
> > +#include "aspeed-hace.h"
> > +
> > +#ifdef CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH_DEBUG
> > +#define AHASH_DBG(h, fmt, ...)	\
> > +	dev_info((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
> > +#else
> > +#define AHASH_DBG(h, fmt, ...)	\
> > +	dev_dbg((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
> > +#endif
> > +
> > +/* Initialization Vectors for SHA-family */
> > +static const __be32 sha1_iv[8] =3D {
> > +	cpu_to_be32(SHA1_H0), cpu_to_be32(SHA1_H1),
> > +	cpu_to_be32(SHA1_H2), cpu_to_be32(SHA1_H3),
> > +	cpu_to_be32(SHA1_H4), 0, 0, 0
> > +};
> > +
> > +static const __be32 sha224_iv[8] =3D {
> > +	cpu_to_be32(SHA224_H0), cpu_to_be32(SHA224_H1),
> > +	cpu_to_be32(SHA224_H2), cpu_to_be32(SHA224_H3),
> > +	cpu_to_be32(SHA224_H4), cpu_to_be32(SHA224_H5),
> > +	cpu_to_be32(SHA224_H6), cpu_to_be32(SHA224_H7),
> > +};
> > +
> > +static const __be32 sha256_iv[8] =3D {
> > +	cpu_to_be32(SHA256_H0), cpu_to_be32(SHA256_H1),
> > +	cpu_to_be32(SHA256_H2), cpu_to_be32(SHA256_H3),
> > +	cpu_to_be32(SHA256_H4), cpu_to_be32(SHA256_H5),
> > +	cpu_to_be32(SHA256_H6), cpu_to_be32(SHA256_H7),
> > +};
> > +
> > +static const __be64 sha384_iv[8] =3D {
> > +	cpu_to_be64(SHA384_H0), cpu_to_be64(SHA384_H1),
> > +	cpu_to_be64(SHA384_H2), cpu_to_be64(SHA384_H3),
> > +	cpu_to_be64(SHA384_H4), cpu_to_be64(SHA384_H5),
> > +	cpu_to_be64(SHA384_H6), cpu_to_be64(SHA384_H7)
> > +};
> > +
> > +static const __be64 sha512_iv[8] =3D {
> > +	cpu_to_be64(SHA512_H0), cpu_to_be64(SHA512_H1),
> > +	cpu_to_be64(SHA512_H2), cpu_to_be64(SHA512_H3),
> > +	cpu_to_be64(SHA512_H4), cpu_to_be64(SHA512_H5),
> > +	cpu_to_be64(SHA512_H6), cpu_to_be64(SHA512_H7)
> > +};
> > +
> > +static const __be32 sha512_224_iv[16] =3D {
> > +	cpu_to_be32(0xC8373D8CUL), cpu_to_be32(0xA24D5419UL),
> > +	cpu_to_be32(0x6699E173UL), cpu_to_be32(0xD6D4DC89UL),
> > +	cpu_to_be32(0xAEB7FA1DUL), cpu_to_be32(0x829CFF32UL),
> > +	cpu_to_be32(0x14D59D67UL), cpu_to_be32(0xCF9F2F58UL),
> > +	cpu_to_be32(0x692B6D0FUL), cpu_to_be32(0xA84DD47BUL),
> > +	cpu_to_be32(0x736FE377UL), cpu_to_be32(0x4289C404UL),
> > +	cpu_to_be32(0xA8859D3FUL), cpu_to_be32(0xC8361D6AUL),
> > +	cpu_to_be32(0xADE61211UL), cpu_to_be32(0xA192D691UL)
> > +};
> > +
> > +static const __be32 sha512_256_iv[16] =3D {
> > +	cpu_to_be32(0x94213122UL), cpu_to_be32(0x2CF72BFCUL),
> > +	cpu_to_be32(0xA35F559FUL), cpu_to_be32(0xC2644CC8UL),
> > +	cpu_to_be32(0x6BB89323UL), cpu_to_be32(0x51B1536FUL),
> > +	cpu_to_be32(0x19773896UL), cpu_to_be32(0xBDEA4059UL),
> > +	cpu_to_be32(0xE23E2896UL), cpu_to_be32(0xE3FF8EA8UL),
> > +	cpu_to_be32(0x251E5EBEUL), cpu_to_be32(0x92398653UL),
> > +	cpu_to_be32(0xFC99012BUL), cpu_to_be32(0xAAB8852CUL),
> > +	cpu_to_be32(0xDC2DB70EUL), cpu_to_be32(0xA22CC581UL)
> > +};
> > +
> > +/* The purpose of this padding is to ensure that the padded message is=
 a
> > + * multiple of 512 bits (SHA1/SHA224/SHA256) or 1024 bits
> (SHA384/SHA512).
> > + * The bit "1" is appended at the end of the message followed by
> > + * "padlen-1" zero bits. Then a 64 bits block (SHA1/SHA224/SHA256) or
> > + * 128 bits block (SHA384/SHA512) equals to the message length in bits
> > + * is appended.
> > + *
> > + * For SHA1/SHA224/SHA256, padlen is calculated as followed:
> > + *  - if message length < 56 bytes then padlen =3D 56 - message length
> > + *  - else padlen =3D 64 + 56 - message length
> > + *
> > + * For SHA384/SHA512, padlen is calculated as followed:
> > + *  - if message length < 112 bytes then padlen =3D 112 - message leng=
th
> > + *  - else padlen =3D 128 + 112 - message length
> > + */
> > +static void aspeed_ahash_fill_padding(struct aspeed_hace_dev *hace_dev=
,
> > +				      struct aspeed_sham_reqctx *rctx)
> > +{
> > +	unsigned int index, padlen;
> > +	__be64 bits[2];
> > +
> > +	AHASH_DBG(hace_dev, "rctx flags:0x%x\n", (u32)rctx->flags);
> > +
> > +	switch (rctx->flags & SHA_FLAGS_MASK) {
> > +	case SHA_FLAGS_SHA1:
> > +	case SHA_FLAGS_SHA224:
> > +	case SHA_FLAGS_SHA256:
> > +		bits[0] =3D cpu_to_be64(rctx->digcnt[0] << 3);
> > +		index =3D rctx->bufcnt & 0x3f;
> > +		padlen =3D (index < 56) ? (56 - index) : ((64 + 56) - index);
> > +		*(rctx->buffer + rctx->bufcnt) =3D 0x80;
> > +		memset(rctx->buffer + rctx->bufcnt + 1, 0, padlen - 1);
> > +		memcpy(rctx->buffer + rctx->bufcnt + padlen, bits, 8);
> > +		rctx->bufcnt +=3D padlen + 8;
> > +		break;
> > +	default:
> > +		bits[1] =3D cpu_to_be64(rctx->digcnt[0] << 3);
> > +		bits[0] =3D cpu_to_be64(rctx->digcnt[1] << 3 |
> > +				      rctx->digcnt[0] >> 61);
> > +		index =3D rctx->bufcnt & 0x7f;
> > +		padlen =3D (index < 112) ? (112 - index) : ((128 + 112) - index);
> > +		*(rctx->buffer + rctx->bufcnt) =3D 0x80;
> > +		memset(rctx->buffer + rctx->bufcnt + 1, 0, padlen - 1);
> > +		memcpy(rctx->buffer + rctx->bufcnt + padlen, bits, 16);
> > +		rctx->bufcnt +=3D padlen + 16;
> > +		break;
> > +	}
> > +}
> > +
> > +/*
> > + * Prepare DMA buffer before hardware engine
> > + * processing.
> > + */
> > +static int aspeed_ahash_dma_prepare(struct aspeed_hace_dev *hace_dev)
> > +{
> > +	struct aspeed_engine_hash *hash_engine =3D &hace_dev->hash_engine;
> > +	struct ahash_request *req =3D hash_engine->req;
> > +	struct aspeed_sham_reqctx *rctx =3D ahash_request_ctx(req);
> > +	int length, remain;
> > +
> > +	length =3D rctx->total + rctx->bufcnt;
> > +	remain =3D length % rctx->block_size;
> > +
> > +	AHASH_DBG(hace_dev, "length:0x%x, remain:0x%x\n", length, remain);
> > +
> > +	if (rctx->bufcnt)
> > +		memcpy(hash_engine->ahash_src_addr, rctx->buffer, rctx->bufcnt);
> > +
> > +	if (rctx->total + rctx->bufcnt < ASPEED_CRYPTO_SRC_DMA_BUF_LEN) {
> > +		scatterwalk_map_and_copy(hash_engine->ahash_src_addr +
> > +					 rctx->bufcnt, rctx->src_sg,
> > +					 rctx->offset, rctx->total - remain, 0);
> > +		rctx->offset +=3D rctx->total - remain;
> > +
> > +	} else {
> > +		dev_warn(hace_dev->dev, "Hash data length is too large\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	scatterwalk_map_and_copy(rctx->buffer, rctx->src_sg,
> > +				 rctx->offset, remain, 0);
> > +
> > +	rctx->bufcnt =3D remain;
> > +	rctx->digest_dma_addr =3D dma_map_single(hace_dev->dev, rctx->digest,
> > +					       SHA512_DIGEST_SIZE,
> > +					       DMA_BIDIRECTIONAL);
> > +	if (dma_mapping_error(hace_dev->dev, rctx->digest_dma_addr)) {
> > +		dev_warn(hace_dev->dev, "dma_map() rctx digest error\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	hash_engine->src_length =3D length - remain;
> > +	hash_engine->src_dma =3D hash_engine->ahash_src_dma_addr;
> > +	hash_engine->digest_dma =3D rctx->digest_dma_addr;
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Prepare DMA buffer as SG list buffer before
> > + * hardware engine processing.
> > + */
> > +static int aspeed_ahash_dma_prepare_sg(struct aspeed_hace_dev
> *hace_dev)
> > +{
> > +	struct aspeed_engine_hash *hash_engine =3D &hace_dev->hash_engine;
> > +	struct ahash_request *req =3D hash_engine->req;
> > +	struct aspeed_sham_reqctx *rctx =3D ahash_request_ctx(req);
> > +	struct aspeed_sg_list *src_list;
> > +	struct scatterlist *s;
> > +	int length, remain, sg_len, i;
> > +	int rc =3D 0;
> > +
> > +	remain =3D (rctx->total + rctx->bufcnt) % rctx->block_size;
> > +	length =3D rctx->total + rctx->bufcnt - remain;
> > +
> > +	AHASH_DBG(hace_dev, "%s:0x%x, %s:0x%x, %s:0x%x, %s:0x%x\n",
> > +		  "rctx total", rctx->total, "bufcnt", rctx->bufcnt,
> > +		  "length", length, "remain", remain);
> > +
> > +	sg_len =3D dma_map_sg(hace_dev->dev, rctx->src_sg, rctx->src_nents,
> > +			    DMA_TO_DEVICE);
> > +	if (!sg_len) {
> > +		dev_warn(hace_dev->dev, "dma_map_sg() src error\n");
> > +		rc =3D -ENOMEM;
> > +		goto end;
> > +	}
> > +
> > +	src_list =3D (struct aspeed_sg_list *)hash_engine->ahash_src_addr;
> > +	rctx->digest_dma_addr =3D dma_map_single(hace_dev->dev, rctx->digest,
> > +					       SHA512_DIGEST_SIZE,
> > +					       DMA_BIDIRECTIONAL);
> > +	if (dma_mapping_error(hace_dev->dev, rctx->digest_dma_addr)) {
> > +		dev_warn(hace_dev->dev, "dma_map() rctx digest error\n");
> > +		rc =3D -ENOMEM;
> > +		goto free_src_sg;
> > +	}
> > +
> > +	if (rctx->bufcnt !=3D 0) {
> > +		rctx->buffer_dma_addr =3D dma_map_single(hace_dev->dev,
> > +						       rctx->buffer,
> > +						       rctx->block_size * 2,
> > +						       DMA_TO_DEVICE);
> > +		if (dma_mapping_error(hace_dev->dev, rctx->buffer_dma_addr)) {
> > +			dev_warn(hace_dev->dev, "dma_map() rctx buffer error\n");
> > +			rc =3D -ENOMEM;
> > +			goto free_rctx_digest;
> > +		}
> > +
> > +		src_list[0].phy_addr =3D rctx->buffer_dma_addr;
> > +		src_list[0].len =3D rctx->bufcnt;
> > +		length -=3D src_list[0].len;
> > +
> > +		/* Last sg list */
> > +		if (length =3D=3D 0)
> > +			src_list[0].len |=3D HASH_SG_LAST_LIST;
> > +
> > +		src_list[0].phy_addr =3D cpu_to_le32(src_list[0].phy_addr);
> > +		src_list[0].len =3D cpu_to_le32(src_list[0].len);
> > +		src_list++;
> > +	}
> > +
> > +	if (length !=3D 0) {
> > +		for_each_sg(rctx->src_sg, s, sg_len, i) {
> > +			src_list[i].phy_addr =3D sg_dma_address(s);
> > +
> > +			if (length > sg_dma_len(s)) {
> > +				src_list[i].len =3D sg_dma_len(s);
> > +				length -=3D sg_dma_len(s);
> > +
> > +			} else {
> > +				/* Last sg list */
> > +				src_list[i].len =3D length;
> > +				src_list[i].len |=3D HASH_SG_LAST_LIST;
> > +				length =3D 0;
> > +			}
> > +
> > +			src_list[i].phy_addr =3D cpu_to_le32(src_list[i].phy_addr);
> > +			src_list[i].len =3D cpu_to_le32(src_list[i].len);
> > +		}
> > +	}
> > +
> > +	if (length !=3D 0) {
> > +		rc =3D -EINVAL;
> > +		goto free_rctx_buffer;
> > +	}
> > +
> > +	rctx->offset =3D rctx->total - remain;
> > +	hash_engine->src_length =3D rctx->total + rctx->bufcnt - remain;
> > +	hash_engine->src_dma =3D hash_engine->ahash_src_dma_addr;
> > +	hash_engine->digest_dma =3D rctx->digest_dma_addr;
> > +
> > +	goto end;
> Exiting via "goto xx" is not recommended in normal code logic (this requi=
res
> two jumps),
> exiting via "return 0" is more efficient.
> This code method has many times in your entire driver, it is recommended =
to
> modify it.

If not exiting via "goto xx", how to release related resources without any =
problem?
Is there any proper way to do this?

> > +
> > +free_rctx_buffer:
> > +	if (rctx->bufcnt !=3D 0)
> > +		dma_unmap_single(hace_dev->dev, rctx->buffer_dma_addr,
> > +				 rctx->block_size * 2, DMA_TO_DEVICE);
> > +free_rctx_digest:
> > +	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
> > +			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
> > +free_src_sg:
> > +	dma_unmap_sg(hace_dev->dev, rctx->src_sg, rctx->src_nents,
> > +		     DMA_TO_DEVICE);
> > +end:
> > +	return rc;
> > +}
> > +
> > +static int aspeed_ahash_complete(struct aspeed_hace_dev *hace_dev)
> > +{
> > +	struct aspeed_engine_hash *hash_engine =3D &hace_dev->hash_engine;
> > +	struct ahash_request *req =3D hash_engine->req;
> > +
> > +	AHASH_DBG(hace_dev, "\n");
> > +
> > +	hash_engine->flags &=3D ~CRYPTO_FLAGS_BUSY;
> > +
> > +	crypto_finalize_hash_request(hace_dev->crypt_engine_hash, req, 0);
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Copy digest to the corresponding request result.
> > + * This function will be called at final() stage.
> > + */
> > +static int aspeed_ahash_transfer(struct aspeed_hace_dev *hace_dev)
> > +{
> > +	struct aspeed_engine_hash *hash_engine =3D &hace_dev->hash_engine;
> > +	struct ahash_request *req =3D hash_engine->req;
> > +	struct aspeed_sham_reqctx *rctx =3D ahash_request_ctx(req);
> > +
> > +	AHASH_DBG(hace_dev, "\n");
> > +
> > +	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
> > +			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
> > +
> > +	dma_unmap_single(hace_dev->dev, rctx->buffer_dma_addr,
> > +			 rctx->block_size * 2, DMA_TO_DEVICE);
> > +
> > +	memcpy(req->result, rctx->digest, rctx->digsize);
> > +
> > +	return aspeed_ahash_complete(hace_dev);
> > +}
> > +
> > +/*
> > + * Trigger hardware engines to do the math.
> > + */
> > +static int aspeed_hace_ahash_trigger(struct aspeed_hace_dev *hace_dev,
> > +				     aspeed_hace_fn_t resume)
> > +{
> > +	struct aspeed_engine_hash *hash_engine =3D &hace_dev->hash_engine;
> > +	struct ahash_request *req =3D hash_engine->req;
> > +	struct aspeed_sham_reqctx *rctx =3D ahash_request_ctx(req);
> > +
> > +	AHASH_DBG(hace_dev, "src_dma:0x%x, digest_dma:0x%x,
> length:0x%x\n",
> > +		  hash_engine->src_dma, hash_engine->digest_dma,
> > +		  hash_engine->src_length);
> > +
> > +	rctx->cmd |=3D HASH_CMD_INT_ENABLE;
> > +	hash_engine->resume =3D resume;
> > +
> > +	ast_hace_write(hace_dev, hash_engine->src_dma,
> ASPEED_HACE_HASH_SRC);
> > +	ast_hace_write(hace_dev, hash_engine->digest_dma,
> > +		       ASPEED_HACE_HASH_DIGEST_BUFF);
> > +	ast_hace_write(hace_dev, hash_engine->digest_dma,
> > +		       ASPEED_HACE_HASH_KEY_BUFF);
> > +	ast_hace_write(hace_dev, hash_engine->src_length,
> > +		       ASPEED_HACE_HASH_DATA_LEN);
> > +
> > +	/* Memory barrier to ensure all data setup before engine starts */
> > +	mb();
> > +
> > +	ast_hace_write(hace_dev, rctx->cmd, ASPEED_HACE_HASH_CMD);
> A hardware service sending requires 5 hardware commands to complete.
> In a multi-concurrency scenario, how to ensure the order of commands?
> (If two processes send hardware task at the same time,
> How to ensure that the hardware recognizes which task the current
> command belongs to?)

Linux crypto engine would guarantee that only one request at each time to b=
e dequeued from engine queue to process.
And there has lock mechanism inside Linux crypto engine to prevent the scen=
ario you mentioned.
So only 1 aspeed_hace_ahash_trigger() hardware service would go through at =
a time.

[...]
