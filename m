Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F108F5A9A24
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiIAOWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbiIAOVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:21:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A3B67460;
        Thu,  1 Sep 2022 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662042112; x=1693578112;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=55O110ktM0OF1xw5SXgL8ikWasHTW6BPL0647fVjOS4=;
  b=GgAeScrartAU4Pr4LJaU0URl538pOJI8A+Eaya/nvvsq/2fDT3oIg+bp
   n/871I/Nvopg/EkyQWjDwJU7Ws+V6E39rDFhL4dWksMvENWxMcSVI8LTB
   /zdal56uSybdoCBAQQTIsGPcnl0q61X4vbKFl7BGhp6hCPOTJMhzTkUE3
   C6pzpdFxba5JZunBSnsRBqyxcI1yGpWEQVrSSJA2XM+WA15yxpb5UP64Z
   WhFbPkyahVQ2m5yllVnqPU+2KCgrDP4qPkd2Y8/uIGgMaQN4Q3YtLG2CR
   Dg4ZfZiCfqAlnoBeAABuGRk/hGfQDLGXP9tR7Aq2/8OK4j9DowOhfRNaP
   A==;
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="178648815"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2022 07:21:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Sep 2022 07:21:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 1 Sep 2022 07:21:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VB2uKaAPqQXzJH0hcYm1cK+Sf+kEmhRA4dRMFHM5y/1sEJa7rLviQ27t7P5Cou2eNnisbgNKR4VTlSyKuNsPXl8I0EFDrSTgg6MxuWJ12H4OCCbz+XE5aqZHpAKEX8+gW+aIw/99+d+e5amOYNvOZTa/nZVpwZt8DWgi3c4vXyHY4Teq0tW9WNw4RxgHZ1Y7z+Ldsgyuq4R0AZlqRy6Yf8CPoBpQJNZtOy5OT6+M65Bi6h6ltrl4dljKeV/a6DIhjkcyMEI9w29gVQJQU6Iu/La29YxsCZKwLlJiaF0K9whgIltR6l0AfQgbfd7gIAV6rwvA7nfiBETZ7YF1W8yKHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbBv+MlcqT822lahvBG7J7vB5/dlFQPl+KOefe9rQV4=;
 b=BjW5scTdbUPl3HcE8DXMPlztiUllEXvExJe6oUnwMnciFrwnL2Q0QY8p7emncwWT9Ha7l03NzXEqV1NuAo8IGnwRBcXpcGpsLppIFkAfck55T578lI6+P/7Lvua2Analc7tIYfMCgflnqZvl5oG6XrPzklPVbwYVOIt2t41Ds1cA6KTx7H/WPYNL1U9o1YObYkcAj5n54DJT9Do19r1Smx9vECZcPM15FJZ+4oLAVatZHwkD+0h3ewangTgOYAsGEyDaf9UU7uF6S7If6nLcppppBPHHjaluAdV6bM1OuhSwj517moAZUgvKhWKkmpqUna26EQWc6/PIViJkdMD6Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbBv+MlcqT822lahvBG7J7vB5/dlFQPl+KOefe9rQV4=;
 b=QK4wWBRHByppbZsXZHhPAovY6N8a0UhESAVmYhyKDxF6u5PjcNxuN+Wa2daHvk/DTFkZVC8U3gQyUXEnP8EshBcK1Zdf54TKbAx+0qEdHLEN0K5c6ARdAQLqYJhQnQ2uoI+JBRuOwhRyww4Letlize0t8j2RPM7aRg7JqQYqbrE=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by DS7PR11MB6016.namprd11.prod.outlook.com (2603:10b6:8:75::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Thu, 1 Sep
 2022 14:21:40 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::8846:b62b:5a61:746f]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::8846:b62b:5a61:746f%7]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 14:21:40 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <ilpo.jarvinen@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <andy.shevchenko@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <johan@kernel.org>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <macro@orcam.me.uk>,
        <geert+renesas@glider.be>, <jk@ozlabs.org>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v1 tty-next 1/2] 8250: microchip: pci1xxxx: Add driver for
 the quad-uart function in the  multi-function endpoint of pci1xxxx device.
Thread-Topic: [PATCH v1 tty-next 1/2] 8250: microchip: pci1xxxx: Add driver
 for the quad-uart function in the  multi-function endpoint of pci1xxxx
 device.
Thread-Index: AQHYvJqGn7FIbwN0S0+3fVOYd0JRcq3IwtkAgAHeQjA=
Date:   Thu, 1 Sep 2022 14:21:40 +0000
Message-ID: <BN8PR11MB36688F6207CA992C93F8B384E97B9@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20220830180054.1998296-1-kumaravel.thiagarajan@microchip.com>
 <20220830180054.1998296-2-kumaravel.thiagarajan@microchip.com>
 <bea049b-69d-a097-ddeb-737cdd485e@linux.intel.com>
In-Reply-To: <bea049b-69d-a097-ddeb-737cdd485e@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 879b5233-a14f-4cd6-59d9-08da8c2549a8
x-ms-traffictypediagnostic: DS7PR11MB6016:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MMGYLsfvL+0Dz4vjU6hIbhAuTbFf0tyL1ccn8tg6rZW0l5QZxErahA+2EQ4cTQzSnAY7J+51X1yB+WH0PBrJz6sQ0vDGGn7WiJcVNIUvYa3OvQxq0H2tgO195U2zUuWBQ03wNoUdKP+NJkRZ2oEEmIKNMPXN87M13I9YAJi7Fo06dyERch9GMxEPYHyv4JXogLQB5lYY2YWS4APqaViDlv5IwJB0WMjalrdCUkvCNWpC2nfPDjRLDZjR+ISsl1SzUC8I4JsL6WXTr/SMeNhzCJQrS+2JKfKk9OuRR0wDojUsrc0iY50hHWRtRQ77ViXAB5GaZt2IfVp8XcHv/3XjibitWeBrh3TrTxDLGItC7bXn6ODz7ikItchBfqgp4oZgRVMZZ1rjvLfqIh5NbFFTi82Fn2ZbtlbDFi88L3ts05xyb9knJky6KRycn0cjeqF0a/ZQ2OYdcP2Ysm6oBXtSBkMeJ8dzqoFZuVol6CdhuCTa+F5xHIrQz/BmzZi2nmDvIlNrZA5+I/iuvPxVX2PAPXsnlltA9cZr5FhvmTZFD9aLgK9yoyxs9l+3f71h1btUCAuKMLIad6x+VD15pjBl/TzUhj+uoDTtWZjyseUW9QPAf8Mmi/TgGJbcTESGyodrZ1TPxkAl8IBLLBCyxebd9pA8FYTvLsIa2BGU0yYNEPVaw6sen57Grko1zFW7M+ySBmqbfNMysfNhDSdbeRIyV5nXvTnZNQxFrMS0LoyEqKym7PZLu6SObEe2RFD+liGCEsuh27xqsh6E9SiOqNNx2vT6BFeXhcHUYMM9pXxauS4Xytbr/WRyw438mmW4JgRZkWEAY2IELUHR8bY6L14CbFae0oHyeeUeSDdnomFU0zE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(136003)(39860400002)(376002)(396003)(107886003)(2906002)(38100700002)(6506007)(53546011)(26005)(40140700001)(122000001)(55016003)(7696005)(33656002)(66574015)(186003)(83380400001)(6916009)(66556008)(66446008)(5660300002)(4326008)(76116006)(316002)(71200400001)(8676002)(64756008)(66476007)(54906003)(66946007)(38070700005)(52536014)(41300700001)(7416002)(8936002)(9686003)(86362001)(478600001)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TsujYPmtJ77BnM8st1DQX5TYMW8TmaXbcqQQO2jcbneRKl6P7jt8joVfHJ?=
 =?iso-8859-1?Q?4e9C6jaL3qYTtKgK/6T2CsEzGmnIPiM9c27b2n9nF8ww1CVoUHD5fSxq2R?=
 =?iso-8859-1?Q?mPHjLQF5AaO/wZXIxz5+Gt/noqHXXa4luXGm3JYx4+Y0ynCwmvThUVb7R7?=
 =?iso-8859-1?Q?cX22X33Zr/ZGzVWaATJCXTaHC6Kxlobosm4VU03AX+V+UG/5VWoQ3XCTVI?=
 =?iso-8859-1?Q?IVRtNMxbXlVAF/dOGNrKUXvDzNJohNTp5i/rE/VLNdFCFE94+4c6ulBv++?=
 =?iso-8859-1?Q?Yga3Gt/nHAhVdKKJIha46g85S27MlhjhyNLdyB7UkkzjiAdA+xFEoGt9ZD?=
 =?iso-8859-1?Q?sYuiB1l5DyZnHjxgbcCZaNlogQgqXT93zoSJk7Vc1bt5CNwce5Q9Oj8F46?=
 =?iso-8859-1?Q?JMcpQVtXcCTzPP0Qia6bTwnpY+JPTHCbG4umhDtwVQOoavAMv9Gacp8iRI?=
 =?iso-8859-1?Q?btkl6VyAgrOwl7RDATL2JiVHZToBIO0iyTVbiHf+h7uagyQoCQ3EAn9y1e?=
 =?iso-8859-1?Q?QlrB0wrUu0aVPaH34F9Ov2uspJzdydd5MULPDJupByxL48hzWWfu4CDtGO?=
 =?iso-8859-1?Q?uCTiDZqeS3WrSfcVriBPby4SPeRmgE+UPEfaBJK3HlpQ5Jm+RtK9W5F5+p?=
 =?iso-8859-1?Q?E3XsAfXlocxmOnnuwEeqxg9gI2sgqFrSpAeKxbLWtUnWgCXnXDFYjp/5pO?=
 =?iso-8859-1?Q?tVfu/ev2/kRgPdbzgZFkmUAeGqxa66cdLqt4CBTas37JKmo92sWhdlECe/?=
 =?iso-8859-1?Q?sEf4q3TneSXwPn0V/EEuRm0BUCdwXcxf8ao4NMtJk4M7B4tIGuosTAczs0?=
 =?iso-8859-1?Q?KMFesc4lh67YiuRrOurjBnA4m1iQY4IdXO3Y73R1y2i2Y+SpSTQM8WIdpI?=
 =?iso-8859-1?Q?bS9kicvj1m+rMFII+rwN9B0fsqz99622fZTRaX7d/Vv5KB6nJcDbcVe4ho?=
 =?iso-8859-1?Q?18uPd9HRNK1OuMc1pHD7kb8d+MWaq/wJsjL4L1VIMdcvSes9BjbMPfqDE5?=
 =?iso-8859-1?Q?9oCo24NjZ184uFEVwWJrWcwjeEwgcq8mheA/xWQaD/LW5v+ov1/Zaac0DK?=
 =?iso-8859-1?Q?SJIv1UzvnwoixrN9b1HR3mmzwcNIp2zmWJG/r33LPSRxnTXqq11/+xuMv3?=
 =?iso-8859-1?Q?owVAysZj9m0XhbBP6pXAaHZnoEYHF8a2lF8HsnYFreuWQnqCu1ToqiCYDc?=
 =?iso-8859-1?Q?WSZggkIcqHlBF3X9X5+aZlAazZQMQFGGnroiFCopccY5RIhbIXy4FSFUad?=
 =?iso-8859-1?Q?Li8hoJN0MiS1r5yjsiPEnOWSpQaTm22CB3F8VPYlZMZ8p4SzmBpM6R/Z7G?=
 =?iso-8859-1?Q?R7VI7f20GKgCvy2ldiXUhPv4dwAoa6gVv8NbmpEYWYi7Wl+buvKS5flcje?=
 =?iso-8859-1?Q?Ig6g7f1aUl5hb4nN4czrjhzC8rc+txHX+WgIV3QmbbEdoVmMEXCxr++XA5?=
 =?iso-8859-1?Q?b259c/P1VE5ZcwLFTYYrMLS3CYQaL0IlYqN/7+TiDP5PAzLsVFemME09Oe?=
 =?iso-8859-1?Q?rUdztw1oTN4MB3jEh8eqNfgQgkek8kzdvPPyq8fVPYM7OJXZZ+YbVMy1iZ?=
 =?iso-8859-1?Q?7lL/tZwu0biIXHnKKcr9fPDGVlEqheazgVcJdOmVeOGwMG0/yJ5qGYpoo/?=
 =?iso-8859-1?Q?W+7RrzLTmWPCC0snUip05ZIsiyD0fcXVdMSqZNVs/+Fk1RXst7KlnYu24K?=
 =?iso-8859-1?Q?BoPnGr/woLqe5yjOjHQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879b5233-a14f-4cd6-59d9-08da8c2549a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 14:21:40.3169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ugj/W6bsCoNgum8+5/YP5REWgCmwXZR+nQIOckvPiIbd4qBLEtXfT9ouSKRYdypwOWVWxXd/DYdnjmdafhIbTo5yiGfGCDln3k8Tw4L24HC1JCNgvb2PisZowJHD/ryL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6016
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
> Sent: Wednesday, August 31, 2022 3:13 PM
> To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jiri Slaby
> <jirislaby@kernel.org>; andy.shevchenko@gmail.com; u.kleine-
> koenig@pengutronix.de; johan@kernel.org; wander@redhat.com;
> etremblay@distech-controls.com; macro@orcam.me.uk;
> geert+renesas@glider.be; jk@ozlabs.org; phil.edworthy@renesas.com;
> Lukas Wunner <lukas@wunner.de>; LKML <linux-kernel@vger.kernel.org>;
> linux-serial <linux-serial@vger.kernel.org>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>
> Subject: Re: [PATCH v1 tty-next 1/2] 8250: microchip: pci1xxxx: Add drive=
r for
> the quad-uart function in the multi-function endpoint of pci1xxxx device.
>=20
>=20
> On Tue, 30 Aug 2022, Kumaravel Thiagarajan wrote:
>=20
> > pci1xxxx is a PCIe switch with a multi-function endpoint on one of its
> > downstream ports. Quad-uart is one of the functions in the
> > multi-function endpoint. This driver loads for the quad-uart and
> > enumerates single or multiple instances of uart based on the PCIe
> > subsystem device ID.
> >
> > Signed-off-by: Kumaravel Thiagarajan
> > <kumaravel.thiagarajan@microchip.com>
> > ---
>=20
> > +static int mchp_pci1xxxx_rs485_config(struct uart_port *port,
> > +                                   struct ktermios *termios,
> > +                                   struct serial_rs485 *rs485) {
> > +     u8 data =3D 0;
> > +
> > +     memset(rs485->padding, 0, sizeof(rs485->padding));
> > +     rs485->flags &=3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND;
> > +
> > +     if (rs485->flags & SER_RS485_ENABLED) {
> > +             data =3D ADCL_CFG_EN | ADCL_CFG_PIN_SEL;
> > +             if (!(rs485->flags & SER_RS485_RTS_ON_SEND)) {
> > +                     data |=3D ADCL_CFG_POL_SEL;
> > +                     rs485->flags |=3D  SER_RS485_RTS_AFTER_SEND;
> > +             }
> > +     }
> > +
> > +     rs485->delay_rts_after_send =3D 0;
> > +     rs485->delay_rts_before_send =3D 0;
> > +     writeb(data, (port->membase + ADCL_CFG_REG));
> > +     port->rs485 =3D *rs485;
>=20
> Most of this will be handled for by the core so don't duplicate it in the=
 driver.
Ok. I will review and modify this if as required.

>=20
> These days, you also need to provide rs485_supported.
Ok. I will modify this.

>=20
> > +     return 0;
> > +}
> > +
> > +static void mchp_pci1xxxx_set_termios(struct uart_port *port,
> > +                                   struct ktermios *termios,
> > +                                   struct ktermios *old) {
> > +     const unsigned int standard_baud_list[] =3D {50, 75, 110, 134, 15=
0, 300,
> > +                                             600, 1200, 1800, 2000, 24=
00, 3600,
> > +                                             4800, 7200, 9600, 19200, =
38400, 57600,
> > +                                             115200, 125000, 136400, 1=
50000, 166700,
> > +                                             187500, 214300, 250000, 3=
00000, 375000,
> > +                                             500000, 750000, 1000000, =
1500000};
> > +     unsigned int baud =3D tty_termios_baud_rate(termios);
> > +     unsigned int baud_clock;
> > +     unsigned int quot;
> > +     unsigned int frac;
> > +     unsigned int i;
> > +
> > +     baud =3D tty_termios_baud_rate(termios);
>=20
> Either this or the one at the declaration is redundant.
Yes. It is a mistake. I will modify.

>=20
> > +     serial8250_do_set_termios(port, termios, NULL);
> > +
> > +     if (baud =3D=3D 38400 && (port->flags & UPF_SPD_MASK) =3D=3D
> UPF_SPD_CUST) {
> > +             writel((port->custom_divisor & 0x3FFFFFFF),
> > +                    (port->membase + CLK_DIVISOR_REG));
> > +     } else {
> > +             for (i =3D 0; i < ARRAY_SIZE(standard_baud_list); i++) {
> > +                     if (baud =3D=3D standard_baud_list[i])
> > +                             return;
>=20
> Did you mean to break here instead?
No. The standard baud rates are handled within serial8250_do_set_termios wh=
ich is invoked from
within mchp_pci1xxxx_set_termios in first place. Hence, if it matches with =
any of the standard baudrates,
it can return immediately.=20

>=20
> > +             }
> > +             tty_termios_encode_baud_rate(termios, baud, baud);
> > +
> > +             baud =3D uart_get_baud_rate(port, termios, old,
> > +                                       50, 1500000);
> > +             baud_clock =3D readb(port->membase + CLK_SEL_REG);
> > +
> > +             if ((baud_clock & CLK_SEL_MASK) =3D=3D CLK_SEL_500MHZ) {
> > +                     quot =3D 500000000 / (16 * baud);
> > +                     writel(quot, (port->membase + CLK_DIVISOR_REG));
> > +             } else if ((baud_clock & CLK_SEL_MASK) =3D=3D CLK_SEL_166=
MHZ) {
> > +                     quot =3D (166667 * 1000) / (16 * baud);
> > +                     writel(quot, (port->membase + CLK_DIVISOR_REG));
> > +             } else {
> > +                     quot =3D ((1000000000) / (baud * UART_BIT_SAMPLE_=
CNT));
> > +                     frac =3D (((1000000000 - (quot * baud *
> > +                             UART_BIT_SAMPLE_CNT)) / UART_BIT_SAMPLE_C=
NT)
> > +                             * 255) / baud;
> > +                     writel(frac | (quot << 8),
> > +                            (port->membase + CLK_DIVISOR_REG));
> > +             }
>=20
> Please check ->[gs]et_divisor() out.
Ok. I will review and get back to you.

Thank You.

Regards,
Kumaravel

