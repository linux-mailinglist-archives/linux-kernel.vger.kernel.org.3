Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DA1564B07
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 03:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiGDBB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 21:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGDBBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:01:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60101.outbound.protection.outlook.com [40.107.6.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B77725F6;
        Sun,  3 Jul 2022 18:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alzOV0S9hEFulSnojMZhVRP6LetwVEvkq+qVTMPp3v7jV2uBFFG9Aljk8Qt0b6YV9NyM3Cf/15cWFOWdCu0aNpSughpAPbUSTKUrISnUw8Ql6lhmUJVDUEiZYS1wRgePGQS/B92+/xG10UjIh+B5fqO+7m8jBXOQ3CoTH2Szp8eSV1SBJGZJ/LHZm2+2c9g+J+0lQ4/G35e/Re0ITONbYY6MBj6OuXzhexfYXFMMoLa7+r79+zMDketmFp5B2iJHlD/utlhShDkBlxrne2535PSlyh0TVutB7tkCr3F94Xh9y40K/bHsc7O29/lfeEBjk4ItuhCcjLJBKqFAM6jjqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Di8Kn6U+DtqNErmPQudU8+iiOw7bvHOfeLNdxPqUSw=;
 b=i9nCAmy+nCNRIchlNgNvpxecSWQoJepR4jprKRovp4Qr3gVgoJ3aV4WtvqRTz/hlRSs0f7zmy6YeuTl4jti1EPr2lK4huFL7ChbXORYQKzrr2du0Hzibq1bHSifaTBzyji7LCiVanJpbEmMrruUeSYJ8Nz6Ho8LlbR2gqjHtP0+VBR0UUuq8C1tdUK19HRt/bxG0tZpmwmdHgsThc6WDJ7ftGpa90kjDc5kDAH9XtWRDshue/CiqRZKvAa+6B6ygaghfYQ/15Lom/57xqLyLkuplNpi0Vd6LAEvQF2RNGBiEscRr6jq84yKYFgjExB+TJCheA+MuCCyVcjK9ujOfpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass action=none
 header.from=leica-geosystems.com.cn; dkim=pass
 header.d=leica-geosystems.com.cn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Di8Kn6U+DtqNErmPQudU8+iiOw7bvHOfeLNdxPqUSw=;
 b=cBr0azyr4zYjTLosdqSAErpcYxp6lmwptjLwLSL2HhKFpyH0fK1+UtVH+ls3uBv0O9kPe3tRUpxAJ1iX80NgX8jqptAXa+Syc9+YlqLqpZoEXKg1IAkIadCR2cqcuaCfBh7BD+xVwvzYflVif4yBiDbU/2sccFWOyvyAohyIc18=
Received: from AM9PR06MB7844.eurprd06.prod.outlook.com (2603:10a6:20b:3aa::24)
 by VE1PR06MB7038.eurprd06.prod.outlook.com (2603:10a6:800:1a7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 01:01:46 +0000
Received: from AM9PR06MB7844.eurprd06.prod.outlook.com
 ([fe80::7ce1:9e8b:a4f8:11ca]) by AM9PR06MB7844.eurprd06.prod.outlook.com
 ([fe80::7ce1:9e8b:a4f8:11ca%9]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 01:01:46 +0000
From:   LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "tomas.melin@vaisala.com" <tomas.melin@vaisala.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        GEO-CHHER-bsp-development 
        <bsp-development.geo@leica-geosystems.com>
Subject: RE: [PATCH V1 1/1] iio: accel: sca3300: Extend the trigger buffer
 from 16 to 32 bytes
Thread-Topic: [PATCH V1 1/1] iio: accel: sca3300: Extend the trigger buffer
 from 16 to 32 bytes
Thread-Index: AQHYjPKNuiUUBllm20O/wlqzm/hoCa1pujMAgAOuCXA=
Date:   Mon, 4 Jul 2022 01:01:46 +0000
Message-ID: <AM9PR06MB78447C75482FA9179A601BFDD7BE9@AM9PR06MB7844.eurprd06.prod.outlook.com>
References: <20220701023030.2527019-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220701023030.2527019-2-Qing-wu.Li@leica-geosystems.com.cn>
 <20220701174602.68b20753@jic23-huawei>
In-Reply-To: <20220701174602.68b20753@jic23-huawei>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com.cn;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44f681a0-6c5b-4fec-4b92-08da5d58c487
x-ms-traffictypediagnostic: VE1PR06MB7038:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MYpfPF2fYN8Af0WG9rV3mVzsv81WnBh1+XFGCzec8a+fOYx1jJrw0Crq3WJWkF9tuavhMgUAvrWTKmqQkX0lis+rW0R+Bjkb4/B6ZyZm3D7RYy8gR0p2/1rm463pkDHWAL665CF+ICJaV3/PuUcFOc6xC2aTJf8M7u0h3/G2lL5vE3paExKMr1NyCu4q4Jdn/nLD7MSfqwrgsOC6/vtXI0IGHPdmO8kxc5hc2IAqiskkZC0dsK2m67WEYmMu/FXZpxQ31UZCswAvJ+BjnYG5t22KYq8oqiPR0PaU1As2Yb1XperlaSuNMHyQMqSuzdekPnaZkO+VxSqZO6rRwDjsyi7uBGafFca9bS2u9sPdZKF8dVSLZ21RI48TEuCaNnaX6ztOqMaZkFOi0xeiRlB3Poo6dFmEyICdgxbNGHjfFtBDKpfqwyWG9N44TNQ6AmmwZ3nVszveWOgL3Cp2I4ch10/LurESEf/DCr2AoE12FbcM82u0FfWNIKicgkRUxbOOxfSfyoJ89Ay1m0TGp4k3ezUrQTziKCWM7u1iof/c75HqGKKrRGO+mtnQalYr5TMmoEtoLtNX/OfIcl0t80RI+uIKN+UqWLMSERWajxxtb4nxJeXPwmWyCgkCYOUyk7/p3UbDh+r013jKK87O75i+PPFNLy/E03WCSoL/Wcaam+bfcQg1uh6IyrS/jittuYrajX+cvjGxO8SiHUb9OJoSx0S6Vkaep3f7jtEC04wZZ6/iOCiO59WHkQ0KfuaHEBjzjcLCBiiLO+2YKUYiT+QQ5OUiatobw5C+Hf0CTnyz5Wc2QD4KpizPRIYAgrhc1OBx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7844.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(55016003)(83380400001)(2906002)(86362001)(64756008)(66556008)(76116006)(45080400002)(54906003)(38100700002)(4326008)(66476007)(66946007)(478600001)(66446008)(122000001)(186003)(316002)(6916009)(7696005)(5660300002)(33656002)(38070700005)(966005)(6506007)(41300700001)(8676002)(52536014)(26005)(8936002)(9686003)(53546011)(71200400001)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?apUc6KYy60Za0GSBT7gTPYvz7OEOUnbJ3uZXs4guFexzLElA4Klfh8hn8Nb3?=
 =?us-ascii?Q?ZCGljkqetKOZRp1EeagtNAEVmcPfI/fQz6FwCrn79MEADKRpjdZQpbB/AT5+?=
 =?us-ascii?Q?ZwAGT59ckXRXKizxEkV5nCGADq0L01DsVE8UDWkfkfGeYCtgbWadmtyzSQPz?=
 =?us-ascii?Q?QEY6hjbPBRpFMTTQC5qObrecy0zCskWl3pOb1vw8GSMT9LVbJKJHnm+b+Xib?=
 =?us-ascii?Q?9vPm3r5eu7Xx+mHM99shHUXQg0Y1Iuz2VX5SLrmsVWSIQri08zMVz9sl8jGN?=
 =?us-ascii?Q?1RIWtBmXJo5GmmUNBye2Mff53Nqd000GUvRUpbgAtlZcCml+4VC3DvXEmGX5?=
 =?us-ascii?Q?tBrvLEtQu2FA6kMoNhyQUfhzEtdMuJKtdlrKxw+bSuqxa9X0l1CF1MKl52of?=
 =?us-ascii?Q?7s/HlT0rPqwJ33iFLz3CICg4MSsxkCQy/3MtJ5bDMFW9Ottuk78tFaIZ34ED?=
 =?us-ascii?Q?zc8KReKOqHDuJrODqfaXqgEx/SF2zyOjvu7DNhNzi502GWxwOvzYQ38Qtf5P?=
 =?us-ascii?Q?3rdHWmJn79znL1ea1P5g2WxP3zLAR3/13s7lmi6vwumC4kr4pZ7+78t8Ijyt?=
 =?us-ascii?Q?99f4yDjGeB4YHyKWPrC9Tc5za8VtaUCezEZDZdjh7LUHKDp6t7/yxYKqoPnO?=
 =?us-ascii?Q?A2hT4pPmxwN9Bhjr23lWLA1rt0rDbAtNL1VS84m8DX2TQuqiyPCkP7y64UKW?=
 =?us-ascii?Q?EoPYNDpEQ8D09MjA5TnR7ZEP+7vesolAYo/E32Kt/ZthIYK9Ood33HbbUsfJ?=
 =?us-ascii?Q?idU/UZorBiZRTlepiixYLQMIhNwtI2xg5G73r7Hg3yHLgpHuiGJs/lGU/CNh?=
 =?us-ascii?Q?xhlS6Y8HP0Tv3na5BEtymYmSgGiQQziFD39HxltJ0/ZSpD0xyOZfky/LlILc?=
 =?us-ascii?Q?sNsyQQQB7iRQrT+6nXCajcHcpzdgDlVvzqf4d7so4wLPgWraeIUai8jUFZ+1?=
 =?us-ascii?Q?ZazL+dCtGLO930rHPvm6PqHT6OU6cpGdehshRuGaMakZzPK1oJhOh1X+FvE8?=
 =?us-ascii?Q?Oo1CZaFQTqBushpOC2AFj/Ce2zXo+RuoawKqmF90upLbLfcyp6QFM5OhIJH/?=
 =?us-ascii?Q?5AFBNQVjH7//GII1DZCidD7PQ238Bgh+ehDGcLCWFV8oEezpxvHVYOYULyd1?=
 =?us-ascii?Q?FfDSmzJAEK1v2qPlqxjxk9MSz8xnE7K89sROtuLp8Ts6A9MHkjXqwjWyQUce?=
 =?us-ascii?Q?phokKKt4bydxMhrHyTPdO169+YyNK5ffOOPMoLdgYZzOuAF/m/C37NbWeO8S?=
 =?us-ascii?Q?bZlL8lAeR8VSK5q4FEbix+u1sAiIFuJPEBGCHrZNVwcWQk+K64J6T4UgM8rT?=
 =?us-ascii?Q?BLwh1rdn0r9JTDd+NFuGPOV+dz9SNyNdYx+/gGOuWzFDVNhW+KIfO6LXun4v?=
 =?us-ascii?Q?3th+0MtER1luq7FM9WSUwXLGHvqZDgQHF/vtmccX4G1/Z+z8qRRV1y7QrQlE?=
 =?us-ascii?Q?OmXQ+cZ790dNyLxW3ihIYX/uj4cIxLPImhXeOL0voZWMwZAd8cyt1nNbcvXh?=
 =?us-ascii?Q?fKNBObAQuEzBnXUF/b3dGRSQ4jW5ujF1RJQJkOIc7RJbTeo2UyqruYjlpA8p?=
 =?us-ascii?Q?Oa0jBJ9IfxqEFwC/uoh4UDGrPFyNfE+yO7pdtqrXLbKA6679FAgazd4xS0Zq?=
 =?us-ascii?Q?uQF/856/SW15/o0JFWXflug=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7844.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f681a0-6c5b-4fec-4b92-08da5d58c487
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 01:01:46.1428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8AISLDMmJ0WIczr+d+emIksBvx6kyMYSwwaVe6TrfW4i/1qQkpLP9QSQSSmwasu1wZ7w8PciZUkMmk0p7OJlFsrb88pw86UzIcdgSgsZrVSOfjsce2wXQWC1W+4R8fpK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB7038
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
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, July 2, 2022 12:46 AM
> To: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> Cc: lars@metafoo.de; tomas.melin@vaisala.com; nuno.sa@analog.com;
> linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
> Subject: Re: [PATCH V1 1/1] iio: accel: sca3300: Extend the trigger buffe=
r from
> 16 to 32 bytes
>=20
> [Some people who received this message don't often get email from
> jic23@kernel.org. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> This email is not from Hexagon's Office 365 instance. Please be careful w=
hile
> clicking links, opening attachments, or replying to this email.
>=20
>=20
> On Fri,  1 Jul 2022 02:30:30 +0000
> LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:
>=20
> > After added inclination angle channels, the trigger buffer size is
> > insufficient. Extend the buffer size from 16 to 32 bytes, and change
> > the trigger buffer from the struct to a u8 array to adapt the sensor
> > with/without inclination angles output.
> > New trigger buffer data:
> >   - SCA3300: 3 accel channels, temp, and timestamp.
> >   - SCL3300: 3 accel channels, temp, 3 incli channels, and timestamp.
> > Readjustment the scan index to make it consistent with the buffer data.
> >
> > Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
>=20
> Hi.
>=20
> Looks good. A trivial suggestion inline to make the code a little more 's=
elf
> documenting'.  It's a minor change so if you are happy with the suggestio=
n I
> can tweak that whilst applying.
>=20
> Thanks,
>=20
> Jonathan
>=20

Yes, sure, absolutely agree, Thank you!

LI Qingwu

> > ---
> >  drivers/iio/accel/sca3300.c | 29 ++++++++++++++++++-----------
> >  1 file changed, 18 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> > index 3c4827bfef53..820dfb635bf1 100644
> > --- a/drivers/iio/accel/sca3300.c
> > +++ b/drivers/iio/accel/sca3300.c
> > @@ -47,12 +47,20 @@
> >  #define SCL3300_REG_ANG_CTRL 0x0C
> >  #define SCL3300_ANG_ENABLE   0x1F
> >
> > +/*
> > + * Buffer size max case:
> > + * Three accel channels, two bytes per channel.
> > + * Temperature channel, two bytes.
> > + * Three incli channels, two bytes per channel.
> > + * Timestamp channel, eight bytes.
> > + */
> > +#define SCA3300_MAX_BUFFER_SIZE (ALIGN(2 * 7, sizeof(s64)) +
> > +sizeof(s64))
>=20
> Instead of the 2 use sizeof(s16)
>  Also now you don't have timestamp in your enum sca3000_scan_indexes you
> could add a 'tail' element to the enum such as SCA3000_SCAN_MAX then use
> that instead of the 7 here.  Hopefully that would make this more self
> documenting.


>=20
> > +
> >  enum sca3300_scan_indexes {
> >       SCA3300_ACC_X =3D 0,
> >       SCA3300_ACC_Y,
> >       SCA3300_ACC_Z,
> >       SCA3300_TEMP,
> > -     SCA3300_TIMESTAMP,
> >       SCA3300_INCLI_X,
> >       SCA3300_INCLI_Y,
> >       SCA3300_INCLI_Z,
> > @@ -140,10 +148,10 @@ static const struct iio_chan_spec scl3300_channel=
s[]
> =3D {
> >       SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
> >       SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
> >       SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
> > -     IIO_CHAN_SOFT_TIMESTAMP(4),
> >       SCA3300_INCLI_CHANNEL(SCA3300_INCLI_X, 0x09, X),
> >       SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Y, 0x0A, Y),
> >       SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Z, 0x0B, Z),
> > +     IIO_CHAN_SOFT_TIMESTAMP(7),
> >  };
> >
> >  static const unsigned long sca3300_scan_masks[] =3D { @@ -184,7 +192,9
> > @@ struct sca3300_chip_info {
> >   * @spi: SPI device structure
> >   * @lock: Data buffer lock
> >   * @chip: Sensor chip specific information
> > - * @scan: Triggered buffer. Four channel 16-bit data + 64-bit
> > timestamp
> > + * @buffer: Triggered buffer:
> > + *          -SCA3300: 4 channel 16-bit data + 64-bit timestamp
> > + *          -SCL3300: 7 channel 16-bit data + 64-bit timestamp
> >   * @txbuf: Transmit buffer
> >   * @rxbuf: Receive buffer
> >   */
> > @@ -192,10 +202,7 @@ struct sca3300_data {
> >       struct spi_device *spi;
> >       struct mutex lock;
> >       const struct sca3300_chip_info *chip;
> > -     struct {
> > -             s16 channels[4];
> > -             s64 ts __aligned(sizeof(s64));
> > -     } scan;
> > +     u8 buffer[SCA3300_MAX_BUFFER_SIZE] __aligned(sizeof(s64));
> >       u8 txbuf[4] __aligned(IIO_DMA_MINALIGN);
> >       u8 rxbuf[4];
> >  };
> > @@ -484,21 +491,21 @@ static irqreturn_t sca3300_trigger_handler(int ir=
q,
> void *p)
> >       struct iio_dev *indio_dev =3D pf->indio_dev;
> >       struct sca3300_data *data =3D iio_priv(indio_dev);
> >       int bit, ret, val, i =3D 0;
> > +     s16 *channels =3D (s16 *)data->buffer;
> >
> >       for_each_set_bit(bit, indio_dev->active_scan_mask,
> >                        indio_dev->masklength) {
> > -             ret =3D sca3300_read_reg(data,
> sca3300_channels[bit].address,
> > -                                    &val);
> > +             ret =3D sca3300_read_reg(data,
> > + indio_dev->channels[bit].address, &val);
> >               if (ret) {
> >                       dev_err_ratelimited(&data->spi->dev,
> >                               "failed to read register, error: %d\n",
> ret);
> >                       /* handled, but bailing out due to errors */
> >                       goto out;
> >               }
> > -             data->scan.channels[i++] =3D val;
> > +             channels[i++] =3D val;
> >       }
> >
> > -     iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> > +     iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> >
> iio_get_time_ns(indio_dev));
> >  out:
> >       iio_trigger_notify_done(indio_dev->trig);

