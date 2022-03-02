Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E5F4CB355
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiCBX6g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Mar 2022 18:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiCBX6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 18:58:34 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7DD0659D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 15:57:49 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-214-E8EQuzy4Px6_ZuHM3Sq0SA-1; Wed, 02 Mar 2022 23:57:46 +0000
X-MC-Unique: E8EQuzy4Px6_ZuHM3Sq0SA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Wed, 2 Mar 2022 23:57:44 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Wed, 2 Mar 2022 23:57:44 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?iso-8859-1?Q?=27Uwe_Kleine-K=F6nig=27?= 
        <u.kleine-koenig@pengutronix.de>, Jiri Slaby <jslaby@suse.cz>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Baruch Siach <baruch@tkos.co.il>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "Paul Mackerras" <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Michal Simek" <michal.simek@xilinx.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Alexander Shiyan" <shc_work@mail.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabio Estevam <festevam@gmail.com>,
        "Russell King" <linux@armlinux.org.uk>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Andy Gross <agross@kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Takao Orito <orito.takao@socionext.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: RE: [PATCH v3] serial: make uart_console_write->putchar()'s character
 an unsigned char
Thread-Topic: [PATCH v3] serial: make uart_console_write->putchar()'s
 character an unsigned char
Thread-Index: AQHYLl5tVpWrjMz0S0GPyaCV/1nc9aysw9yA
Date:   Wed, 2 Mar 2022 23:57:44 +0000
Message-ID: <5c7045c1910143e08ced432d938b5825@AcuMS.aculab.com>
References: <20220302072732.1916-1-jslaby@suse.cz>
 <20220302175242.ejiaf36vszr4xvou@pengutronix.de>
In-Reply-To: <20220302175242.ejiaf36vszr4xvou@pengutronix.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König
> Sent: 02 March 2022 17:53
> 
> On Wed, Mar 02, 2022 at 08:27:32AM +0100, Jiri Slaby wrote:
> > Currently, uart_console_write->putchar's second parameter (the
> > character) is of type int. It makes little sense, provided uart_console_write()
> > accepts the input string as "const char *s" and passes its content -- the
> > characters -- to putchar(). So switch the character's type to unsigned
> > char.
> >
> > We don't use char as that is signed on some platforms. That would cause
> > troubles for drivers which (implicitly) cast the char to u16 when
> > writing to the device. Sign extension would happen in that case and the
> > value written would be completely different to the provided char. DZ is
> > an example of such a driver -- on MIPS, it uses u16 for dz_out in
> > dz_console_putchar().
> 
> I always thought this was bigger than 8bit for hardware that supports
> wider characters. But if that's the case that's completely unsupported,
> there isn't even CS9.

The real problem is that using char (or short) for a function parameter
or result is very likely to require the compile add code to mask
the value to 8 (or 16) bits.

Remember that almost every time you do anything with a signed or unsigned
char/short variable the compiler has to use the integer promotion rules
to convert the value to int.

You'll almost certainly get better code if the value is left in an
int (or unsigned int) variable until the low 8 bits get written to
a buffer (or hardware register).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

