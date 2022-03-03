Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990154CBAD7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiCCJ4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiCCJ4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:56:10 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A300615DB2E;
        Thu,  3 Mar 2022 01:55:19 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 6680E92009C; Thu,  3 Mar 2022 10:55:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 62A4E92009B;
        Thu,  3 Mar 2022 09:55:17 +0000 (GMT)
Date:   Thu, 3 Mar 2022 09:55:17 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     David Laight <David.Laight@ACULAB.COM>,
        =?UTF-8?Q?'Uwe_Kleine-K=C3=B6nig'?= 
        <u.kleine-koenig@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Baruch Siach <baruch@tkos.co.il>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
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
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Vineet Gupta <vgupta@kernel.org>,
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
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v3] serial: make uart_console_write->putchar()'s character
 an unsigned char
In-Reply-To: <84ad3854-28b9-e450-f0a2-f1448f32f137@suse.cz>
Message-ID: <alpine.DEB.2.21.2203030738170.56670@angie.orcam.me.uk>
References: <20220302072732.1916-1-jslaby@suse.cz> <20220302175242.ejiaf36vszr4xvou@pengutronix.de> <5c7045c1910143e08ced432d938b5825@AcuMS.aculab.com> <84ad3854-28b9-e450-f0a2-f1448f32f137@suse.cz>
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

> > The real problem is that using char (or short) for a function parameter
> > or result is very likely to require the compile add code to mask
> > the value to 8 (or 16) bits.
> > 
> > Remember that almost every time you do anything with a signed or unsigned
> > char/short variable the compiler has to use the integer promotion rules
> > to convert the value to int.
> > 
> > You'll almost certainly get better code if the value is left in an
> > int (or unsigned int) variable until the low 8 bits get written to
> > a buffer (or hardware register).
> 
> So should we use int/uint instead of more appropriate shorter types everywhere
> now? The answer is: definitely not. The assembly on x86 looks good (it uses
> movz, no ands), RISC architectures have to do what they chose to.

 We do have an issue, because we still have this:

void uart_console_write(struct uart_port *port, const char *s,
			unsigned int count,
			void (*putchar)(struct uart_port *, int))

and then:

		putchar(port, *s);

there.  Consequently on targets where plain `char' type is signed the 
value retrieved from `*s' has to be truncated in the call to `putchar'.  
And indeed it happens with the MIPS target:

803ae47c:	82050000 	lb	a1,0(s0)
803ae480:	26100001 	addiu	s0,s0,1
803ae484:	02402025 	move	a0,s2
803ae488:	0220f809 	jalr	s1
803ae48c:	30a500ff 	andi	a1,a1,0xff

vs current code:

803ae47c:	82050000 	lb	a1,0(s0)
803ae480:	26100001 	addiu	s0,s0,1
803ae484:	0220f809 	jalr	s1
803ae488:	02402025 	move	a0,s2

(NB the last instruction shown after the call instruction, JALR, is in the 
delay slot that is executed before the PC gets updated).  Now arguably the 
compiler might notice that and use an unsigned LBU load instruction rather 
than the signed LB load instruction, which would make the ANDI instruction 
redundant, but still I think we ought to avoid gratuitous type signedness 
changes.

 So I'd recommend changing `s' here to `const unsigned char *' or, as I 
previously suggested, maybe to `const u8 *' even.

  Maciej
