Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3934EE468
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242000AbiCaXBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiCaXBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:01:40 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9DAB25E2;
        Thu, 31 Mar 2022 15:59:51 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B6FED92009C; Fri,  1 Apr 2022 00:59:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id A807E92009B;
        Thu, 31 Mar 2022 23:59:49 +0100 (BST)
Date:   Thu, 31 Mar 2022 23:59:49 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     David Laight <David.Laight@ACULAB.COM>
cc:     Jiri Slaby <jslaby@suse.cz>,
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
Subject: RE: [PATCH v3] serial: make uart_console_write->putchar()'s character
 an unsigned char
In-Reply-To: <20f24492d4944de4986245c59e5be71f@AcuMS.aculab.com>
Message-ID: <alpine.DEB.2.21.2203101334250.47558@angie.orcam.me.uk>
References: <20220302072732.1916-1-jslaby@suse.cz> <20220302175242.ejiaf36vszr4xvou@pengutronix.de> <5c7045c1910143e08ced432d938b5825@AcuMS.aculab.com> <84ad3854-28b9-e450-f0a2-f1448f32f137@suse.cz> <alpine.DEB.2.21.2203030738170.56670@angie.orcam.me.uk>
 <20f24492d4944de4986245c59e5be71f@AcuMS.aculab.com>
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

On Thu, 3 Mar 2022, David Laight wrote:

> > And indeed it happens with the MIPS target:
> > 
> > 803ae47c:	82050000 	lb	a1,0(s0)
> > 803ae480:	26100001 	addiu	s0,s0,1
> > 803ae484:	02402025 	move	a0,s2
> > 803ae488:	0220f809 	jalr	s1
> > 803ae48c:	30a500ff 	andi	a1,a1,0xff
> > 
> > vs current code:
> > 
> > 803ae47c:	82050000 	lb	a1,0(s0)
> > 803ae480:	26100001 	addiu	s0,s0,1
> > 803ae484:	0220f809 	jalr	s1
> > 803ae488:	02402025 	move	a0,s2
> > 
> > (NB the last instruction shown after the call instruction, JALR, is in the
> > delay slot that is executed before the PC gets updated).  Now arguably the
> > compiler might notice that and use an unsigned LBU load instruction rather
> > than the signed LB load instruction, which would make the ANDI instruction
> > redundant, but still I think we ought to avoid gratuitous type signedness
> > changes.
> > 
> >  So I'd recommend changing `s' here to `const unsigned char *' or, as I
> > previously suggested, maybe to `const u8 *' even.
> 
> Or just not worry that the 'char' value (either [128..127] or [0..255])
> is held in a 'signed int' variable.
> That basically happens every time it is loaded into a register anyway.

 That might be true with a hypothetical 8-bit ABI on top of a higher-width 
machine architecture.  It does happen with the 32-bit MIPS ABI (o32) and a 
64-bit architecture, which is why LW (load word signed) is a universal 
32-bit and 64-bit instruction while the LWU (load word unsigned) operation 
is restricted to 64-bit code.

 In this case however a signed `char' value ([-128..127]) is sign-extended 
while an unsigned `char' value ([0..255]) is zero-extended, even though 
both are carried in a 'signed int' variable from the architecture's point 
of view.

 Anyway I have looked into it some more and the immediate cause for LBU 
not to be used here is the:

		if (*s == '\n')
			putchar(port, '\r');

conditional.  If this part is removed, then LBU does get used for the:

		putchar(port, *s);

part and no ANDI is produced.

 The reason for that is that the compiler decides to reuse the load used 
to evaluate (*s == '\n') (which is done using the plain `char' data type) 
for the following `putchar(port, *s)' call if the expression used as the 
condition turns out to be false and therefore the value of `*s' has to be 
subsequently zero-extended:

      b4:	00e08825 	move	s1,a3
      b8:	2413000a 	li	s3,10
      bc:	82050000 	lb	a1,0(s0)
      c0:	00000000 	nop
      c4:	14b30005 	bne	a1,s3,dc <uart_console_write+0x54>
      c8:	00000000 	nop
      cc:	2405000d 	li	a1,13
      d0:	0220f809 	jalr	s1
      d4:	02402025 	move	a0,s2
      d8:	82050000 	lb	a1,0(s0)
      dc:	26100001 	addiu	s0,s0,1
      e0:	02402025 	move	a0,s2
      e4:	0220f809 	jalr	s1
      e8:	30a500ff 	andi	a1,a1,0xff

(the load at bc is reused for the `putchar' call at e4 unless it's `\n', 
or otherwise the character is reloaded at d8).

 By using a temporary `unsigned char' variable and massaging the source 
code suitably GCC can be persuaded to use LBU instead, but the obfuscation 
of the source code and the resulting machine code produced seem not worth 
the effort IMO, so let's keep it simple.

 JFTR,

  Maciej
