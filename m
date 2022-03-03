Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081A84CBDCF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiCCM2u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Mar 2022 07:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiCCM2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:28:47 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96B1344F7;
        Thu,  3 Mar 2022 04:28:01 -0800 (PST)
Date:   Thu, 03 Mar 2022 12:27:37 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: RE: [PATCH v3] serial: make uart_console_write->putchar()'s character
 an unsigned char
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "'Maciej W. Rozycki'" <macro@orcam.me.uk>,
        Jiri Slaby <jslaby@suse.cz>,
        'Uwe =?iso-8859-1?q?Kleine-K=F6nig=27?= 
        <u.kleine-koenig@pengutronix.de>, gregkh@linuxfoundation.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Baruch Siach <baruch@tkos.co.il>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <michal.simek@xilinx.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabio Estevam <festevam@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Andy Gross <agross@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
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
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Andreas =?iso-8859-1?q?F=E4rber?= <afaerber@suse.de>
Message-Id: <1A568R.RVXRB53P9YYQ1@crapouillou.net>
In-Reply-To: <9fa84690ed244eba89f1efe4e6670f80@AcuMS.aculab.com>
References: <20220302072732.1916-1-jslaby@suse.cz>
        <20220302175242.ejiaf36vszr4xvou@pengutronix.de>
        <5c7045c1910143e08ced432d938b5825@AcuMS.aculab.com>
        <84ad3854-28b9-e450-f0a2-f1448f32f137@suse.cz>
        <alpine.DEB.2.21.2203030738170.56670@angie.orcam.me.uk>
        <BIZ58R.9EXA9J3HVHS13@crapouillou.net>
        <alpine.DEB.2.21.2203031102570.50870@angie.orcam.me.uk>
        <9fa84690ed244eba89f1efe4e6670f80@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Le jeu., mars 3 2022 at 11:44:42 +0000, David Laight 
<David.Laight@ACULAB.COM> a écrit :
> From: Maciej W. Rozycki
>>  Sent: 03 March 2022 11:31
> ..
>>   It does, but, oh dear, it's a "solution" to a problem we have 
>> created in
>>  the first place.  Why do we ever want to have signed characters in 
>> the TTY
>>  layer, and then to vary between platforms?  It's asking for 
>> portability
>>  issues.
> 
> C 'char' is signed because the pdp/11 byte load sign extended.

That's incorrect. The C standard does say that "the implementation 
shall define char to have the same range, representation, and behavior 
as either signed char or unsigned char".

C 'char' is signed on x86 (and MIPS and Sparc etc.). It is unsigned on 
ARM, PowerPC and Risc-V among others.

> I guess some ABI use unsigned char to avoid issues with all
> the functions that take/return an int parameter that is
> either a 'char' cast to 'unsigned char' or EOF.
> 
> EOF is usually (-1) - but doesn't have to be.
> But it needs to be different from any value obtained
> by casting a 'char' to 'unsigned char'.
> (But that may only need to be all characters, not all values of 
> 'char'.)

Is the putchar() callback ever going to be called with EOF? I don't 
think so.

> Then you get the requirement that:
> 	sizeof (int) >= sizeof (short) >= sizeof (char)
> which means that it is perfectly valid for all 3 to be the same size 
> [1].
> In that case 'unsigned char' promotes to 'unsigned int'
> which probably breaks some code.

We're talking about Linux here. Ints are 32-bit.

Cheers,
-Paul


