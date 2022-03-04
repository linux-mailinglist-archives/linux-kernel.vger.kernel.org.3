Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9B24CD400
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239700AbiCDMHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbiCDMHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:07:12 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB7E61B309F;
        Fri,  4 Mar 2022 04:06:24 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 4950592009C; Fri,  4 Mar 2022 13:06:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 4313A92009B;
        Fri,  4 Mar 2022 12:06:22 +0000 (GMT)
Date:   Fri, 4 Mar 2022 12:06:22 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Genoud <richard.genoud@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Tobias Klauser <tklauser@distanz.ch>,
        Russell King <linux@armlinux.org.uk>,
        Vineet Gupta <vgupta@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Alexander Shiyan <shc_work@mail.ru>,
        Baruch Siach <baruch@tkos.co.il>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Korsgaard <peter@korsgaard.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v4] serial: make uart_console_write->putchar()'s character
 an unsigned char
In-Reply-To: <20220303080831.21783-1-jslaby@suse.cz>
Message-ID: <alpine.DEB.2.21.2203041155090.47558@angie.orcam.me.uk>
References: <20220303080831.21783-1-jslaby@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022, Jiri Slaby wrote:

> Currently, uart_console_write->putchar's second parameter (the
> character) is of type int. It makes little sense, provided uart_console_write()
> accepts the input string as "const char *s" and passes its content -- the
> characters -- to putchar(). So switch the character's type to unsigned
> char.

 For:

>  drivers/tty/serial/dz.c                    | 2 +-

DECstation DZ serial driver version 1.04
ttyS0 at MMIO 0x1c000000 (irq = 4, base_baud = 0) is a DZ
ttyS1 at MMIO 0x1c000000 (irq = 4, base_baud = 0) is a DZ
ttyS2 at MMIO 0x1c000000 (irq = 4, base_baud = 0) is a DZ
ttyS3 at MMIO 0x1c000000 (irq = 4, base_baud = 0) is a DZ

(I guess I ought to make it report "base_baud = 9600" though there is no 
programmable clock divider there and instead there is simply a 15-way rate 
selector for standard baud rates of up to 9600bps in addition to external 
clocking chosen with the 16th setting), and:

>  drivers/tty/serial/sb1250-duart.c          | 2 +-

duart0 at MMIO 0x10060100 (irq = 8, base_baud = 5000000) is a SB1250 DUART
duart1 at MMIO 0x10060200 (irq = 9, base_baud = 5000000) is a SB1250 DUART

(this does require some TLC though as there's a "refcount_t: saturated; 
leaking memory." warning issued in driver's initialisation) and:

>  drivers/tty/serial/zs.c                    | 2 +-

DECstation Z85C30 serial driver version 0.10
ttyS0 at MMIO 0x1f900008 (irq = 14, base_baud = 460800) is a Z85C30 SCC
ttyS1 at MMIO 0x1f900000 (irq = 14, base_baud = 460800) is a Z85C30 SCC
ttyS2 at MMIO 0x1f980008 (irq = 15, base_baud = 460800) is a Z85C30 SCC
ttyS3 at MMIO 0x1f980000 (irq = 15, base_baud = 460800) is a Z85C30 SCC

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>
Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>

 However please consider my notes in the branch of discussion with David 
too WRT (not) changing the signedness.

 Myself I'll look into GCC and see why it doen't fold the truncation into
the load operation.  Maybe just a MIPS backend issue, such as a missing 
RTL pattern the lack of which prevents combine from doing its job here.  
Any fix will have to wait a couple of months for upstreaming though as the 
compiler is currently at a stage where regression fixes are accepted only 
for the upcoming GCC 12 release, so no general development is allowed on 
trunk.

 Thank you for working on this!

  Maciej
