Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB16B4CADDD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244739AbiCBSsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244726AbiCBSsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:48:04 -0500
X-Greylist: delayed 899 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Mar 2022 10:47:20 PST
Received: from mail.mleia.com (mleia.com [178.79.152.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565ADD5571;
        Wed,  2 Mar 2022 10:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1646245282; bh=r/KWBCXbgbUsx0MROHM9/eZLCf5PfDdjQ920as27D3k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=D2nwKwiYcjfQ8oI3lQewTctuUi8U4oh8bNo2fgLFtdJlnEEKPqbSl/4HCVSEanMn4
         3RTuUSTz/1dEi3fgmH0m2GCM16EQNrmAUzX6Vla+Dpc0F7l792PeVNRR/UvsyTUsso
         fojz0nHmJamBDGby1t7rqGhtVFt8K4DBvXpB8oJKcBu2PlmqUMFBoXUApvB4dNrzaR
         Y5v4yFqHW07zhDlJnzE1XFZX0IElyreDBbxTF6tncpceXn6DUlqp+Bp5e8TuBukRkS
         OMABrntTimVnol9CcvJIurAztzqKq5d6vXpigNoE7OfhCX0stZ2hPYVlzZwTKivbp3
         AWQCNqKfDfS+g==
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 293C039B89A;
        Wed,  2 Mar 2022 18:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1646245282; bh=r/KWBCXbgbUsx0MROHM9/eZLCf5PfDdjQ920as27D3k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=D2nwKwiYcjfQ8oI3lQewTctuUi8U4oh8bNo2fgLFtdJlnEEKPqbSl/4HCVSEanMn4
         3RTuUSTz/1dEi3fgmH0m2GCM16EQNrmAUzX6Vla+Dpc0F7l792PeVNRR/UvsyTUsso
         fojz0nHmJamBDGby1t7rqGhtVFt8K4DBvXpB8oJKcBu2PlmqUMFBoXUApvB4dNrzaR
         Y5v4yFqHW07zhDlJnzE1XFZX0IElyreDBbxTF6tncpceXn6DUlqp+Bp5e8TuBukRkS
         OMABrntTimVnol9CcvJIurAztzqKq5d6vXpigNoE7OfhCX0stZ2hPYVlzZwTKivbp3
         AWQCNqKfDfS+g==
Received: from [192.168.1.102] (88-113-46-102.elisa-laajakaista.fi [88.113.46.102])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mleia.com (Postfix) with ESMTPSA id 16A0B39B811;
        Wed,  2 Mar 2022 18:21:19 +0000 (UTC)
Subject: Re: [PATCH v3] serial: make uart_console_write->putchar()'s character
 an unsigned char
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Genoud <richard.genoud@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Paul Cercueil <paul@crapouillou.net>,
        Russell King <linux@armlinux.org.uk>,
        Vineet Gupta <vgupta@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Alexander Shiyan <shc_work@mail.ru>,
        Baruch Siach <baruch@tkos.co.il>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
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
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
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
References: <20220302072732.1916-1-jslaby@suse.cz>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <9f1f4434-56cb-e8e7-b947-6630752a74c3@mleia.com>
Date:   Wed, 2 Mar 2022 20:21:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220302072732.1916-1-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20220302_182122_201121_FC62FFD6 
X-CRM114-Status: GOOD (  26.46  )
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 9:27 AM, Jiri Slaby wrote:
> Currently, uart_console_write->putchar's second parameter (the
> character) is of type int. It makes little sense, provided uart_console_write()
> accepts the input string as "const char *s" and passes its content -- the
> characters -- to putchar(). So switch the character's type to unsigned
> char.
> 
> We don't use char as that is signed on some platforms. That would cause
> troubles for drivers which (implicitly) cast the char to u16 when
> writing to the device. Sign extension would happen in that case and the
> value written would be completely different to the provided char. DZ is
> an example of such a driver -- on MIPS, it uses u16 for dz_out in
> dz_console_putchar().
> 
> Note we do the char -> uchar conversion implicitly in
> uart_console_write(). Provided we do not change size of the data type,
> sign extension does not happen there, so the problem is void.
> 
> This makes the types consistent and unified with the rest of the uart
> layer, which uses unsigned char in most places already. One exception is
> xmit_buf, but that is going to be converted later.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Acked-by: Richard Genoud <richard.genoud@gmail.com> [atmel_serial]
> Acked-by: Florian Fainelli <f.fainelli@gmail.com> [bcm63xx_uart]
> Acked-by: Tobias Klauser <tklauser@distanz.ch> [altera_*]
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Karol Gugala <kgugala@antmicro.com>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Taichi Sugaya <sugaya.taichi@socionext.com>
> Cc: Takao Orito <orito.takao@socionext.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: "Andreas Färber" <afaerber@suse.de>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Peter Korsgaard <peter@korsgaard.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> ---

[snip]

> diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
> index 54437a087aa0..93140cac1ca1 100644
> --- a/drivers/tty/serial/lpc32xx_hs.c
> +++ b/drivers/tty/serial/lpc32xx_hs.c
> @@ -122,7 +122,7 @@ static void wait_for_xmit_ready(struct uart_port *port)
>   	}
>   }
>   
> -static void lpc32xx_hsuart_console_putchar(struct uart_port *port, int ch)
> +static void lpc32xx_hsuart_console_putchar(struct uart_port *port, unsigned char ch)
>   {
>   	wait_for_xmit_ready(port);
>   	writel((u32)ch, LPC32XX_HSUART_FIFO(port->membase));

for NXP LPC32xx HS UART:

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
