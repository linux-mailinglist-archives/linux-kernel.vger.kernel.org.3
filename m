Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D1D4CB80D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiCCHqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiCCHqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:46:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33A515D3AD;
        Wed,  2 Mar 2022 23:45:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87F94B81FEA;
        Thu,  3 Mar 2022 07:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E574C004E1;
        Thu,  3 Mar 2022 07:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646293522;
        bh=M05nIcnpUn4WzPPLRyplVvMJBTOh9YoN2+KnItwoIfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zkwMolgG3+0fqKz+ZDMIOvb0TyBNK1wsJWJT/qrCP5PhefcN/zNiZHEqxKis5G1K5
         VGQ77zV4WCONgV3h4JRtLxuu1X13vtDg5lCQjMr7w0XrMFwk+JhYm0VzGkCJDvjn6T
         hJ8H7qorBPup/D8Os51jNWDfnd1wozqWZfUKPE/E=
Date:   Thu, 3 Mar 2022 08:45:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
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
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
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
Subject: Re: [PATCH v3] serial: make uart_console_write->putchar()'s
 character an unsigned char
Message-ID: <YiByDgvP3epfDfhX@kroah.com>
References: <20220302072732.1916-1-jslaby@suse.cz>
 <1be133eb-bfe8-b644-6aad-00a0a606aa05@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1be133eb-bfe8-b644-6aad-00a0a606aa05@suse.cz>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 07:32:59AM +0100, Jiri Slaby wrote:
> On 02. 03. 22, 8:27, Jiri Slaby wrote:
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
> > 
> > Note we do the char -> uchar conversion implicitly in
> > uart_console_write(). Provided we do not change size of the data type,
> > sign extension does not happen there, so the problem is void.
> > 
> > This makes the types consistent and unified with the rest of the uart
> > layer, which uses unsigned char in most places already. One exception is
> > xmit_buf, but that is going to be converted later.
> 
> Kbuild seems to serve me this one by one. So this patch is still incomplete:
> > drivers/tty/serial/sunplus-uart.c:526:7: error: incompatible function
> pointer types passing 'void (struct uart_port *, int)' to parameter of type
> 'void (*)(struct uart_port *, unsigned char)'

Let me just add this to my -testing branch, that will give us much
quicker kbuild responses and handle stuff like this easier and I can fix
the errors up when they are reported.

thanks,

greg k-h
