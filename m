Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315825578D5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiFWLja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiFWLj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:39:28 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DDF49F86;
        Thu, 23 Jun 2022 04:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVQIZ3i2AZLIL3KXo0hCaJsWGSe22SluUtMasn7qLuVSvZYyIWMA8epUnevd7CDOcgdUd9bywmpBlbacjCjGkIgCweZfdUjpos4QKN6RtZDZsuUE80WN6EoXee+6obj6krGrPAwTdSHJII/wQuq9QcpwciQZaLfypv71yLbsOUE77bze2yPDoI287/mwVyAf94573OrP6p5VGC31L48i2gnaPzmT+yRG+KvJND/GeUE5hVvhrLjl2dKv3L9M6zYG08s+rIF1XtMlsDpqLgqzTaWnzsj3qJsUmepITGmSJRW83Mho7FcDq54MqXz2MixpJr+feiun/wfzrNIkbf4PYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUNnliS7YqlPMvnvfIR7Q0HEtez/4ApJe8vkawTI638=;
 b=lD5+5jH4F0+8Uo6zMDtk6paH/PuZ57MgZQIP6N4Mm4NDUwTr7aSN3aBV5IFkYc5gZFfWTlYlZr0URNEjvO1PYqIRlRvrohcNWdz4GKxb4A5pJNoHsNyQqYjJAg6mjRWuIxImI+4lnr3Bmci8ieLmt3YUetrfem+FnBtGInhHQjWOHMRwSkxZZ9hZhPxmu3PBRhfF/iKdywbMyLawB7IaC3QFUqXBTKopS0Rv9meUZ2f16qjhi/iff9+SvIJd58X+dEKKWWyeM2Gn0dP8jZiQzOmJRjbPjGLZGblM8qNm1J6qr6tii+mv2g2qdK4QfwXU0hAaMiiu9/QTgdG9NfqLkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUNnliS7YqlPMvnvfIR7Q0HEtez/4ApJe8vkawTI638=;
 b=v+x9USVtK3hOvHsEajM7dIQB3M6MbsxY28SWHpxJb9aZe4lN5kbzm+e9EG+BLtdkY/ocBH10Qr/WT0fM7njVUFDigOAZtOjYONcgGwAvWKs2/5AQXjFvCmy3hWHkB9l4BCLLoDv8q+TAFYx8gCBHa+Uazuc48ITmXqf9BmVTfSY=
Received: from DM6PR12MB2809.namprd12.prod.outlook.com (2603:10b6:5:4a::16) by
 BN8PR12MB3378.namprd12.prod.outlook.com (2603:10b6:408:61::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Thu, 23 Jun 2022 11:39:19 +0000
Received: from DM6PR12MB2809.namprd12.prod.outlook.com
 ([fe80::b5ef:72fd:aa49:cecb]) by DM6PR12MB2809.namprd12.prod.outlook.com
 ([fe80::b5ef:72fd:aa49:cecb%7]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 11:39:19 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Mark Brown <broonie@kernel.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
CC:     "p.yadav@ti.com" <p.yadav@ti.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "git@xilinx.com" <git@xilinx.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
        "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [RFC PATCH 1/2] spi: Add multiple CS support for a single SPI
 device
Thread-Topic: [RFC PATCH 1/2] spi: Add multiple CS support for a single SPI
 device
Thread-Index: AQHYeZhXApErq+32kkmuJFVVfXogSAG7F8aMAeAoVR+snXQgIA==
Date:   Thu, 23 Jun 2022 11:39:19 +0000
Message-ID: <DM6PR12MB2809F6C7D80B60556218D627DCB59@DM6PR12MB2809.namprd12.prod.outlook.com>
References: <20220606112607.20800-1-amit.kumar-mahapatra@xilinx.com>
 <20220606112607.20800-2-amit.kumar-mahapatra@xilinx.com>
 <YqHfccvhy7e5Bc6m@sirena.org.uk>
In-Reply-To: <YqHfccvhy7e5Bc6m@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0efe1f23-bf76-4236-cdb6-08da550d02c3
x-ms-traffictypediagnostic: BN8PR12MB3378:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <BN8PR12MB33785453B5658EE8F4A91519DCB59@BN8PR12MB3378.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F/mURbY1psBKcGrntzlWlAqNoi1uUBU3109/103PuOJf7uRoxaJ4Ceux3ghsmADRuBEAkg5MZINUaJ4uLMg5Stu7R6MtxQyxs9pQqUcSvBxPi4HNl9PEK6zLPuUNfhklUlQ9LU/4a/rUACiCcnPQ+ENNs/whRVkQlX+RqlWYrT5tC4GOJDdEo5umcPvba1t1987sh9ZtI1nqDFGwg4PksezQDVTRN+MonHHy+ArjKWkX9EpawvcaBqwKMMmepd14YNtsx7AB3+/tkstj3rjqKocK0qrAQ7Ix3r3Yt30PxbDvXUofIUfANWO8Q4FSqnEESu9pt53ivh1jmqpBTgJi+9F0Tmkgo6ZWQVFzcaEc8Y2q6zZYflNu6p+AxpxTgwZmOsW5rPEOh3WOT80BuBBrq9GoDQlNT98hvaGRE/nhCMWUmWwaruMeKPdy4ONeElZFvBH5QyqQ3xGLoyiQDpBiYP09ACFfHT9ObQn7LimmtHpklegS3K73sE5XElHQf2WSWTSCITh7Wbyt0ayFQEO7P36v00oSIKwzCb95V9UEh4JzywP8nTEcaKEteqzGN+91bsPZuAFY5sfBSldXJ1BkRJ3aWhKrRt9zREd1xTnMFT7tXa4QqHjfKKpxYnVSV+ai2smvoj4LCT9F+vnEK1SxVSLLpQ/ii7AyvfvhNOLAmfJTGDpyejbuGo4dIR5H8YFTaVFa2hbUNbtKCkpQ6HFadTzSaBsQtg+b9de5di0gf+AHXpfFnL7Pm8t4jgMzt6GN6pMKl5c6TLthaFja3EWhj7jKAtIewF5i8//NGPJjW/T7HrDeSwziDb5lSoYXPdtFEOcFXqU9Snh6vE5se6wuLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2809.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(6506007)(53546011)(55016003)(83380400001)(7696005)(966005)(110136005)(33656002)(26005)(5660300002)(9686003)(52536014)(186003)(8936002)(2906002)(54906003)(66476007)(66556008)(38070700005)(66446008)(41300700001)(71200400001)(4326008)(66946007)(64756008)(7416002)(76116006)(86362001)(478600001)(8676002)(38100700002)(122000001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gM3wYFEuszP3A5srbQhhTyv1XwYgGGF85/pBUevBt6peX3UqyI6L6EEvM9P6?=
 =?us-ascii?Q?IWmuc73aFCrdshpSgzocNgOHaKGBU6pWDSWjUvEObKQ6Nd0blZl2WrqNR5Bn?=
 =?us-ascii?Q?0Fq4sIi1zTY6fPIx+zMBTq4ICCBpc1eaCU3c2rLl/b176kevYKtp4eEtvDQP?=
 =?us-ascii?Q?hKWJOcOb7Q5Al9WYd5D3PfVEvjjzo0kMNkhE67PHGtTVmLBDUBQ6z6g3y9zQ?=
 =?us-ascii?Q?KPGcq1PI+ULINhkKqeG/xUAygcexlFnzzgSMIp1vhikZybcvsSPRjgC6P99w?=
 =?us-ascii?Q?RhIVv++aeE1NtbevcHjvj1l9WDWrgCCkGI+Vber+zWq5AeS+MqIUckmAZ9Hp?=
 =?us-ascii?Q?8hFtHxvIipitsEgfKulRA+ecmyGEf9Ol57A0ktQj8E/mVqcQpUecL77Hi4ns?=
 =?us-ascii?Q?rjn0iV6il2kA6kVD3ptboYkA0WtYEiyATOx7mLx711HA4XxstODK/KTV4gjS?=
 =?us-ascii?Q?Kh/arqlDWZyL36G1+BfnoqOh5VgSgI7IkbPhmCz4d1OoTaMZ5ph920PDgzfe?=
 =?us-ascii?Q?+j6LJKKE3i9ip3DTArZOnsgimYgTLFBQAuPTO/WLz+ANbjmez926juC57tgJ?=
 =?us-ascii?Q?DdhwaNTB0DAzwlLyuukqcFyfPCG4/YcHSxVFg8/ci0IwiGvTINga2L97gypa?=
 =?us-ascii?Q?RRBGDBdR+Qw6SHtoFoNZSkM/8ATjuUIyVzgBju0VD36EEQNRtaWNrBVdFF0n?=
 =?us-ascii?Q?tNgzj9K/YMv9LxrNrOqG0DRyZrD7v87zg8QT7x21YYvhPSU9aWwfA7VtglIm?=
 =?us-ascii?Q?td65Vc3QlEWJDN6OUXT0fsnRJoQgs4p7QxSCo1CR9bOc+3wpdZX09wkcw+EJ?=
 =?us-ascii?Q?WHpkgDQnFQJJUV55C77IJ03xInqZ5/jRyU1XZXWRdMwuRiNDrUIUxZ8i1HkR?=
 =?us-ascii?Q?Wf0oqN2OtTeLmoinvQX6zdQMYASaqriBOZpJM72MCY54SoIKmEUEyRv/wqvs?=
 =?us-ascii?Q?Ey3YG26FcZGSMyH2634BER3Ol6dXAQDSs2hFLsCwlKohJvGBAMb337iL+S6F?=
 =?us-ascii?Q?O8IWr4v8Y488882kFdz1/EaJZONODXHQUcfOXJ7qDqAaVf0Mgmj7m95FxCuZ?=
 =?us-ascii?Q?IZwGs6f/zYVwqglLnu1tM39BF9Ixexnh+PoAjhZAmVjR1z6p/qKHpcNsWd+o?=
 =?us-ascii?Q?EOJnXFyu8S5Q9Xoa9lfdceDdKfSQhgsThkotO+USC8Isx3htmdPIM0EWYVV0?=
 =?us-ascii?Q?1Zti73uGd+aHvDyTJ+gYBAwA/MVqn8KAoKZSeb5Jq1cBGQWCP864rGJq9v9T?=
 =?us-ascii?Q?9j1rMM3wtnPL4BgjZ1UA35WZVGQydqPiQ5uhn9fWgKb7C8v1osxn4YLWTRMb?=
 =?us-ascii?Q?RgBcP3U7aSoHkslG/pL8yh59XoP/Pq/V8D0Pnr9SiWJy013nKyhtUOH7t4xJ?=
 =?us-ascii?Q?cu6A8zY1vXI/4NUoBmotAGurBmaLE0WF5dLk6SSyttnvRmaKSzwvqMvlvamS?=
 =?us-ascii?Q?JsZZ4V18IODXBL0k8p6cuxxTQZmArR5RtN1L5jl0eJDh24x1/Moof94OP8g1?=
 =?us-ascii?Q?fLv2h1oS9QfO+6awGEb4oeYRQ8VKxtpPxu6LLl2fSGSbs7xcwlWLn0bfsM4p?=
 =?us-ascii?Q?uRGJdc4uDDM2i9IKAbzPil5PcK1gY30o/HlkckiTFWafIxQz8yRg1JH5Rsc9?=
 =?us-ascii?Q?oqBZFzLQW4aBBfUVKN6VxhIf9ZBqbgiMdAvDhcJ+hBURgsn9oVHLZTzyAs9F?=
 =?us-ascii?Q?3A0TG+05udY80QhF3zyW8fH8A39OHJmBl2GcBDJfX/600ZI48i21iBYln4Fu?=
 =?us-ascii?Q?GU9gNuCMVQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2809.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efe1f23-bf76-4236-cdb6-08da550d02c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 11:39:19.5200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+TLIwu8844ExsglBU0OfO0xCw67upHagK9qYOZBCJ4iBjzQoZnsGeKr0GHJDcetfPlmjjAMcTKfjReHyHMagw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3378
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

> -----Original Message-----
> From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On
> Behalf Of Mark Brown
> Sent: Thursday, June 9, 2022 5:24 PM
> To: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
> Cc: p.yadav@ti.com; miquel.raynal@bootlin.com; richard@nod.at;
> vigneshr@ti.com; git@xilinx.com; michal.simek@xilinx.com; linux-
> spi@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; michael@walle.cc; linux-mtd@lists.infradead.org
> Subject: Re: [RFC PATCH 1/2] spi: Add multiple CS support for a single SP=
I
> device
>=20
> On Mon, Jun 06, 2022 at 04:56:06PM +0530, Amit Kumar Mahapatra wrote:
>=20
> > ---
> >  drivers/spi/spi-zynqmp-gqspi.c | 30 ++++++++++++++++++++++++++----
> >  drivers/spi/spi.c              | 10 +++++++---
> >  include/linux/spi/spi.h        | 10 +++++++++-
> >  3 files changed, 42 insertions(+), 8 deletions(-)
>=20
> Please split the core and driver support into separate patches, they are
> separate things.

Ok, I will split the patches.
>=20
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -2082,6 +2082,8 @@ static int of_spi_parse_dt(struct spi_controller
> > *ctlr, struct spi_device *spi,  {
> >  	u32 value;
> >  	int rc;
> > +	u32 cs[SPI_CS_CNT_MAX];
> > +	u8 idx;
> >
> >  	/* Mode (clock phase/polarity/etc.) */
> >  	if (of_property_read_bool(nc, "spi-cpha"))
>=20
> This is changing the DT binding but doesn't have any updates to the bindi=
ng
> document.  The binding code also doesn't validate that we don't have too
> many chip selects.

The following updates are done in the binding documents for adding multiple
CS support:
In jedec,spi-nor.yaml file " maxItems " of the "reg" DT property has been=20
updated to accommodate two CS per SPI device. =20
https://github.com/torvalds/linux/blob/de5c208d533a46a074eb46ea17f672cc005a=
7269/Documentation/devicetree/bindings/mtd/jedec%2Cspi-nor.yaml#L49

An example of a flash node with two CS has been added in spi-controller.yam=
l
https://github.com/torvalds/linux/blob/de5c208d533a46a074eb46ea17f672cc005a=
7269/Documentation/devicetree/bindings/spi/spi-controller.yaml#L141
>=20
> > +	/* Bit mask of the chipselect(s) that the driver
> > +	 * need to use form the chipselect array.
> > +	 */
> > +	u8			cs_index_mask : 2;
>=20
> Why make this a bitfield?

https://github.com/torvalds/linux/blob/de5c208d533a46a074eb46ea17f672cc005a=
7269/Documentation/devicetree/bindings/mtd/jedec%2Cspi-nor.yaml#L49

As per the DT bindings we are supporting max 2 chip selects per SPI device
that is the reason I had taken it as an bitfield of 2. But now I think that=
 in=20
future when the number of chip selects per device would increase i.e.,=20
more than 2, then we have to again increase the bitfield allocation for=20
accommodating the increase in the number of chip selects per SPI device,=20
So I think it's better to drop the bitfield for now and use cs_index_mask=20
as an u8
>=20
> I'm also not seeing anything here that checks that the driver supports
> multiple chip selects - it seems like something that's going to cause iss=
ues
> and we should probably have something to handle that situation.

In my approach the chip select member (chip_select) of the spi_device struc=
ture=20
is changed to an array (chip_select[2]). This array is used to store the CS=
 values=20
coming from the "reg" DT property.=20
In case of multiple chip selects  spi->chip_slect[0] will hold CS0 value &=
=20
spi->chip_select[1] wil hold CS1 value.
In case of single chip select the spi->chip_select[0] will hold the chip se=
lect value.

As per the current implementation all the drivers fetch their chip select v=
alue form
spi->chip_select, but now the driver code needs to be modified to fetch the=
 value
from spi->chip_select[0] instead and by this approach we do not need to che=
ck if the=20
driver supports single or multiple CS.

Hope I addressed all your concerns and please let us know what you think.

Regards,
Amit
