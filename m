Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0085AADEA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 13:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiIBL5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 07:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiIBL5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 07:57:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5040BB5320;
        Fri,  2 Sep 2022 04:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662119857; x=1693655857;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KlswOCY6KEHfUH91nws9fplHn4EYXJNK11klaoPcq7k=;
  b=lXTp/usxycbb3rYdj+ydM9+7g7hnT3pWMvk9UGI4fD2Om5NkhcS2FrQj
   ljea9Szou3Q55JFa3zm0e53y3WvTC9ucDhLuws6Eyi7hQrkT+aAhtyVLC
   KIWwqkTZoWnrwJqxmmhSarj/jr7tsObvjWSL2dOgV2taf1WBLTr3VBB3P
   FSVH8vmycbHe5nFurrs53CHY1yX/Jm7To8ED/4LfRtqfY2RnnB/BYJIhW
   MdmauuY7/Est7I10hY41AgOZhAjjS+XKl1eisMdh6OA0cAvZEYke7vnwC
   NwhC7z+90aMAexsgAIUioTMizLSL3w7bh3ORPS2MOb7Xf5bLqYzb7U1BZ
   w==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="172125010"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2022 04:57:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 2 Sep 2022 04:57:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 2 Sep 2022 04:57:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnP7nrIpEW+wL+H/OTvTSEz1qsbLVrfGNR+Y84vCQqxaqjrqiKdZolIEsuicVkOQykauW7AS2l+GE4aJS2f3jND6+N+am1uPWcZYcCPMG1XghS8KQdC6tUn5ZcHZ2OTkAtnILixRrkkcfMHrvFvOrP5iCWbRx5Lbueycaw+WmtlgTEj3vfOjCK7x6ity1mojZQOomO/xtfZNazjfTQbwUcxPVEG9jHx9NvqAUT3WvqSVZR5nncPVv5TImXrec4NQychOsalpQ1onioGf1bGnBd6N7ba/9MtmkspuJidmMrXBHo+XEjEXPCgSVnozKf6jmQE7TnBmTvo44v/cS6AwRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNNSftqNKPMRjlLXE0DQmx1PTrwla3VhKoHeqa0anA8=;
 b=ioWWxOgBzhJ8Cf9P8PHt2dJyEplCgeenHswhpXtP3/zv9CdWmyxsDEG/KZ4xe9SZWxDHdWX2LBQja5F8kxbWXrtfCUfju/mGYXuVVlRoR/zR3N4W4t7mjP5YetLnHwn9bEQRaUf9Vmo6MXb/tN4IV2VA2AwJHw3DYZGAg/8IJZ0Pn9TdufcWeFOfKb7vDfEQivoQX1xyVZQrfyJJMZGNqAyyRS8s6eSpDUmsAXgAf1iuGxJMhetno9sz64/dBZ2OfX7lg/HBiB4Kyiekgih08VdGAS0LKE8fOcdDTMs/I1iW6zTffYWti6cFPt8fKKl2+MzQpp5Dv8cka0dS11kLvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNNSftqNKPMRjlLXE0DQmx1PTrwla3VhKoHeqa0anA8=;
 b=DuAQdYF4VEIGTaRT0wbsgRPrnJUPfXOqb8F0vImyBQFSiMT9KeCQa4zfV9mK76KfayBS3J7k1o7LTtVgnc2JGZZbLt3qqwGgmblqJy2cXtXBuPIv6JoVS6A9OcR/5N/M9InGIXhzYdfYKpjRJ0wuACtSV+9h9VtJhpwYXIOWveY=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by MN2PR11MB4711.namprd11.prod.outlook.com (2603:10b6:208:24e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Fri, 2 Sep
 2022 11:57:25 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5588.014; Fri, 2 Sep 2022
 11:57:25 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <ilpo.jarvinen@linux.intel.com>
CC:     <andy.shevchenko@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <johan@kernel.org>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <macro@orcam.me.uk>,
        <geert+renesas@glider.be>, <jk@ozlabs.org>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v1 tty-next 1/2] 8250: microchip: pci1xxxx: Add driver for
 the quad-uart function in the multi-function endpoint of pci1xxxx device.
Thread-Topic: [PATCH v1 tty-next 1/2] 8250: microchip: pci1xxxx: Add driver
 for the quad-uart function in the multi-function endpoint of pci1xxxx device.
Thread-Index: AQHYvKpRU4W9kTjyqEqLC8EMyu3nVa3Ki2PAgAAMcgCAAWi3gA==
Date:   Fri, 2 Sep 2022 11:57:24 +0000
Message-ID: <BN8PR11MB3668FA6A2247710ED7DEF16EE97A9@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20220830180054.1998296-1-kumaravel.thiagarajan@microchip.com>
 <20220830180054.1998296-2-kumaravel.thiagarajan@microchip.com>
 <CAHp75VfraADCTmZATWTSsYtC5uk5bc=WDVVm0jtUVO90xdFd9g@mail.gmail.com>
 <BN8PR11MB3668BAC07D493EE02AEAEB14E97B9@BN8PR11MB3668.namprd11.prod.outlook.com>
 <63f48d1-f716-5040-c8d1-486087bd1c5e@linux.intel.com>
In-Reply-To: <63f48d1-f716-5040-c8d1-486087bd1c5e@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f331f5d4-7a8a-4941-5c39-08da8cda4d1c
x-ms-traffictypediagnostic: MN2PR11MB4711:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Lrof20yif2uZdC9Sulh0PKu+jwLmiq2ag2oNtfFxN0nPljfdJiKnwDMrsEE7MSU9ZvKvaN8BhPDcd3wP/WLzp0dx17OjNufHSg2b/fVB2hORiRPqbmLQEYiq1LRcc6lSaYFb/2RSsxrZhj1k5GVtStrl4sAFEAnJQncPnLM4gPS0ukVvP0fj041INXn1/+WajEs6CxnNFDTVy1OoAS5zM5+ALHiGB0mQjuOs1LHcrKZ00gbVBP/A+hiwGECy51HQY9M+gXa4c1GUzq4K8zeuW4MiAwPFPkc8E/9AMClEr5LUu0xQqSV1gBNy1X+A0EMhEOUO0Rf6yMvU5UTusarpxm8tKa/SdNr5T0fQ2GSMEx7RyuQseltwsQNuDIHSlO6PHXnHwJYVy8ZYX0emjqkfW4QerhmXTt3S1zjZ8YtY6vHtC2gOk1YlulAhObPvu16gToM5eCup4df2JckYOyEawyTda2XpAAgAVzP25h8g9mPO6Z99e+/kGupf5lcN7aqEUdVQYPdVvWc4+3SO44777m9U8hUIlhaqJBahHf07TPUl5WXsxIB0WQIpVtx3OwBa/aAE+nutzBG15fnMZe1TFNrMRfyxWlF0YVnaO8XF92gedvJQlD4z6CUyCy0eNH1P5eUdh+4yAx43v47juAmbl5dWOzUSRu9ol3qKbsj2CdD8p3bAw/SwhDGrqmtrgy8HDWE8LrTlBiNo6fgYUuE6EuiwDD/xNXGrbyaxSOdkruDw1stRGWGemnreylzvbBtLzF/+hnFJ21HsAW+DoG/RNhYT4cJJwYDIDmr1y98zwa31lSytyXWgN2uIFmbCZirGINEIcRY7AzSqux+U0sXzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(366004)(136003)(39860400002)(478600001)(66476007)(107886003)(41300700001)(6506007)(71200400001)(26005)(54906003)(9686003)(53546011)(55016003)(2906002)(66446008)(7696005)(38070700005)(86362001)(6916009)(316002)(33656002)(40140700001)(64756008)(122000001)(38100700002)(186003)(66556008)(66946007)(8936002)(7416002)(5660300002)(4326008)(76116006)(52536014)(8676002)(83380400001)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pwmB11ZCVJgD7J5hFEepFeXzsHcs6zJTnY9EVcAc7I5f+kMakl2Jyi9B/D?=
 =?iso-8859-1?Q?rRKK8Y1L89zaS1o1XFz5lcWLljxXdgSLRV16RSE8pUu21kOag6WauQk0cF?=
 =?iso-8859-1?Q?OtNuYYQmbVISIXrE0Z5FTUTfv9B6w8HbR45LFDsbQL3nMJG+pRnSM9ecNq?=
 =?iso-8859-1?Q?VRG448IpW4dJ7FUNrcKTwHJZA+LNUcOlYGJcrdYAa8WtrMQTCOQ5fXpVrs?=
 =?iso-8859-1?Q?pOwD/P0wmBE0s6BDKIJn8O9vVLI9444fZL+Wkf+Z+6YCzCxYiGEZJJcg4C?=
 =?iso-8859-1?Q?m/gyFS+60dU4xIiwC1V7c3UJyE6EGjx7U+Q8Q6LEeEmqQC6JvT0Z0ODoHe?=
 =?iso-8859-1?Q?EoOWZ6e09kDFeYZZx9R+bUXYhGq/hrHoOMz9aeRmTVAMuIiMSp6NVwVaRA?=
 =?iso-8859-1?Q?BYWgEnf5UuOeq6/3bH7HJyNh6szRtItuiHE2JuppQaZzf4OBUlY1xBY/Zc?=
 =?iso-8859-1?Q?/4CKMPQYIWmj7oPbi2ynbcYOHxsKfEI3SjebfL8MPFJd4KQm835Q+vAYE+?=
 =?iso-8859-1?Q?MBDW89V1Kp92wxdtTrsPJx53BLQ0IDLIle2NspXzYVvQlMHs8yqHLI+kka?=
 =?iso-8859-1?Q?loJiwgt5bz4eItt6IS4+aeUyzgslj4E7jb9uuzmmHAGWLa36ueaNrMpLcB?=
 =?iso-8859-1?Q?5CjUX1KtHIITZmwadGM1k8K0/QnZcsTXxkSzra6wbBLatfewfnZqxaIYO1?=
 =?iso-8859-1?Q?Azd5F3b9E0bQ58MBJ9RpUHBI1mO1/YIy1y3+NoZ+6v+IrRJ+yqXyf39Lew?=
 =?iso-8859-1?Q?JwA1wK2uNfgE6NEHzmEQ/cH0ndIqG9PL8mnx+k9hgvkW3L4vEQH+Cn4Bdt?=
 =?iso-8859-1?Q?psocqu9KhUpBym3yrIQaQJsSxFdMtMTrA2I0s7mbLZj3/5AIbDj9eBHZxh?=
 =?iso-8859-1?Q?GYvQdn3xcDsYs+r9hgVQgHZw2APJElDt4ClBI5yLraKw66he1/IvqjJG/i?=
 =?iso-8859-1?Q?yFAD3nnirFmDYDATP84jmuBEVzSWCw3CaihLdCiVk8YJmXDP44KQVNAUs1?=
 =?iso-8859-1?Q?HqUC+BmuajiKf94Pbo1vpouddt4PsLAxB2J4+5tziWZJDDTuFx0dhQSkV7?=
 =?iso-8859-1?Q?Md2sR+C97id5r5bHJ08qFNJp6lqt8D6R8luxT++jwj1CWEVuaHT7sIUE7f?=
 =?iso-8859-1?Q?wGD7J5wwgT0uoyBjuIysgBwaT1TloUcf8tAMRRSX8L6vM6Lzr1/G9nIWKu?=
 =?iso-8859-1?Q?YNhZloJ+r0/mYzBAQdNcl1kdlOyX5YtiiqEv7n1XlLngmXOWyOabxzyolP?=
 =?iso-8859-1?Q?uOfy67QlW6RyNJCz4FU3/eTW4fruydoAvdVIy/fTiF6Bj5mdatnLpX+ZGz?=
 =?iso-8859-1?Q?XpNZ2Ti2YAgwEyc7tNLut4/xpNRfMEJfu9vxkjDaERMnjGiuQW09qHFgbf?=
 =?iso-8859-1?Q?EA0QmPb44XLnBL+oUiYRgZkn+g8L54gR/xdudBg/0tbfD1+nP7aLfHpOGw?=
 =?iso-8859-1?Q?O+Qsa9Z0tnXYHVPtvQCPskg/lZ29wYpcqsEOKmzVlUJ43y19rv3984iGrX?=
 =?iso-8859-1?Q?L+bXm9ckyITovlqIFtPHLYTENke+8V9S+gape+3uam5iWarBJn1eGTviNZ?=
 =?iso-8859-1?Q?G9EEeVgqk+mTwInDEen5hrqKqegv0DF0nZhrNSsKXqn7dN6araX6RDxYNK?=
 =?iso-8859-1?Q?KPoMb9RBY5PhsNY/yKBQwQIsYm1z2aORHeS0ggctcgfeeOQIedaRYOYraH?=
 =?iso-8859-1?Q?SF/70/M/MWHsRYUISSo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f331f5d4-7a8a-4941-5c39-08da8cda4d1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 11:57:25.0184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a2uV9/h7qaA2PKcm8AQ2ayR2J1K+SlF6oR8g4rU0CenPmZv6BTqrTSrAhOyjOv+YqlSkYMfK19VwarAWge5XWk4/w261JcA6MogG7jaewJobLpR5lRABjw4G88YOVzgv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4711
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Thursday, September 1, 2022 7:12 PM
> To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
> Cc: andy.shevchenko@gmail.com; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@kernel.org>; u.kleine=
-
> koenig@pengutronix.de; johan@kernel.org; wander@redhat.com;
> etremblay@distech-controls.com; macro@orcam.me.uk;
> geert+renesas@glider.be; jk@ozlabs.org; phil.edworthy@renesas.com;
> Lukas Wunner <lukas@wunner.de>; LKML <linux-kernel@vger.kernel.org>;
> linux-serial <linux-serial@vger.kernel.org>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>
> Subject: RE: [PATCH v1 tty-next 1/2] 8250: microchip: pci1xxxx: Add drive=
r for
> the quad-uart function in the multi-function endpoint of pci1xxxx device.
>=20
>=20
> On Thu, 1 Sep 2022, Kumaravel.Thiagarajan@microchip.com wrote:
>=20
> > > > +       const unsigned int standard_baud_list[] =3D {50, 75, 110, 1=
34, 150,
> 300,
> > > > +                                               600, 1200, 1800, 20=
00, 2400, 3600,
> > > > +                                               4800, 7200, 9600, 1=
9200, 38400, 57600,
> > > > +                                               115200, 125000, 136=
400, 150000, 166700,
> > > > +                                               187500, 214300, 250=
000, 300000, 375000,
> > > > +                                               500000, 750000,
> > > > + 1000000, 1500000};
> > >
> > > Why?!
> >
> > The standard baud rates are handled within serial8250_do_set_termios
> > which is invoked from within mchp_pci1xxxx_set_termios in first place.
> > Hence if it matches with any of the standard baudrates, it can return
> > immediately.
>=20
> Care to explain why the baudrates in your table don't match those in
> tty_baudrate.c? ...It makes no sense to me that you call these "standard
> baud rates".
The baudrates in my table are from our legacy UART IP and these baudrates c=
an be
generated by the hardware by updating UART_DLL & UART_DLM alone as done by =
the
serial8250_do_set_termios.
I noticed that some of the baud rates in tty_baudrate.c arenot listed in th=
is table
but will still be handled by the mchp_pci1xxxx_set_termios.
I can rename standard_baud_list to simply baud_list. Please let me know.

Thank You.

Regards,
Kumaravel
