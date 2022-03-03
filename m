Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A744CBD03
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiCCLpg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Mar 2022 06:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiCCLpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:45:33 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74B45340D9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:44:47 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-4-XQRo4zE6MZqO9sHS00ouew-1; Thu, 03 Mar 2022 11:44:44 +0000
X-MC-Unique: XQRo4zE6MZqO9sHS00ouew-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 3 Mar 2022 11:44:42 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 3 Mar 2022 11:44:42 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Maciej W. Rozycki'" <macro@orcam.me.uk>,
        Paul Cercueil <paul@crapouillou.net>
CC:     Jiri Slaby <jslaby@suse.cz>,
        =?iso-8859-1?Q?=27Uwe_Kleine-K=F6nig=27?= 
        <u.kleine-koenig@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Baruch Siach <baruch@tkos.co.il>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Michal Simek <michal.simek@xilinx.com>,
        "Karol Gugala" <kgugala@antmicro.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "Peter Korsgaard" <peter@korsgaard.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
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
        Palmer Dabbelt <palmer@dabbelt.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Kevin Hilman" <khilman@baylibre.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        "Shawn Guo" <shawnguo@kernel.org>,
        =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Subject: RE: [PATCH v3] serial: make uart_console_write->putchar()'s character
 an unsigned char
Thread-Topic: [PATCH v3] serial: make uart_console_write->putchar()'s
 character an unsigned char
Thread-Index: AQHYLl5tVpWrjMz0S0GPyaCV/1nc9aysw9yAgADDqR+AAACPoA==
Date:   Thu, 3 Mar 2022 11:44:42 +0000
Message-ID: <9fa84690ed244eba89f1efe4e6670f80@AcuMS.aculab.com>
References: <20220302072732.1916-1-jslaby@suse.cz>
 <20220302175242.ejiaf36vszr4xvou@pengutronix.de>
 <5c7045c1910143e08ced432d938b5825@AcuMS.aculab.com>
 <84ad3854-28b9-e450-f0a2-f1448f32f137@suse.cz>
 <alpine.DEB.2.21.2203030738170.56670@angie.orcam.me.uk>
 <BIZ58R.9EXA9J3HVHS13@crapouillou.net>
 <alpine.DEB.2.21.2203031102570.50870@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2203031102570.50870@angie.orcam.me.uk>
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

From: Maciej W. Rozycki
> Sent: 03 March 2022 11:31
..
>  It does, but, oh dear, it's a "solution" to a problem we have created in
> the first place.  Why do we ever want to have signed characters in the TTY
> layer, and then to vary between platforms?  It's asking for portability
> issues.

C 'char' is signed because the pdp/11 byte load sign extended.

I guess some ABI use unsigned char to avoid issues with all
the functions that take/return an int parameter that is
either a 'char' cast to 'unsigned char' or EOF.

EOF is usually (-1) - but doesn't have to be.
But it needs to be different from any value obtained
by casting a 'char' to 'unsigned char'.
(But that may only need to be all characters, not all values of 'char'.)

Then you get the requirement that:
	sizeof (int) >= sizeof (short) >= sizeof (char)
which means that it is perfectly valid for all 3 to be the same size [1].
In that case 'unsigned char' promotes to 'unsigned int'
which probably breaks some code.
It also makes defining EOF troublesome!

[1] The C compiler for a DSP had this 'feature'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

