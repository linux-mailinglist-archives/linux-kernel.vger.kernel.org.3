Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA64F4CAC8F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244293AbiCBRyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244196AbiCBRyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:54:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E804D264
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:53:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nPT9l-0004SU-CE; Wed, 02 Mar 2022 18:52:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nPT9Y-002Fw7-7a; Wed, 02 Mar 2022 18:52:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nPT9W-006XrV-PN; Wed, 02 Mar 2022 18:52:42 +0100
Date:   Wed, 2 Mar 2022 18:52:42 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Baruch Siach <baruch@tkos.co.il>, linux-kernel@vger.kernel.org,
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
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v3] serial: make uart_console_write->putchar()'s
 character an unsigned char
Message-ID: <20220302175242.ejiaf36vszr4xvou@pengutronix.de>
References: <20220302072732.1916-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hskdw542yop5hfv5"
Content-Disposition: inline
In-Reply-To: <20220302072732.1916-1-jslaby@suse.cz>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hskdw542yop5hfv5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2022 at 08:27:32AM +0100, Jiri Slaby wrote:
> Currently, uart_console_write->putchar's second parameter (the
> character) is of type int. It makes little sense, provided uart_console_w=
rite()
> accepts the input string as "const char *s" and passes its content -- the
> characters -- to putchar(). So switch the character's type to unsigned
> char.
>=20
> We don't use char as that is signed on some platforms. That would cause
> troubles for drivers which (implicitly) cast the char to u16 when
> writing to the device. Sign extension would happen in that case and the
> value written would be completely different to the provided char. DZ is
> an example of such a driver -- on MIPS, it uses u16 for dz_out in
> dz_console_putchar().

I always thought this was bigger than 8bit for hardware that supports
wider characters. But if that's the case that's completely unsupported,
there isn't even CS9.

So

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hskdw542yop5hfv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIfrucACgkQwfwUeK3K
7AmopggAnOhPU9WpzjgGeCrJ82M89QE1zHwxLHny10qpp8CNWjSIBp6GIrgxrTA1
HotBRcS0/boZO+3hvLzTwpU3rQ9Pedgt6hUKfsl5ckcqVrlg0Yp5WZ6+cZEa0NcE
Y+gkX3jAowpBb3cdrkxyF8REPsUn57S+/tb8H4x7aroUey13AYKjxjEGZMlaWpms
pNyr/cXJpZhJIp4XvFc7lTydslM8QwH/Y0emW7gR7DLFBUw02MNnw7slIKTHgpjl
T49NU/ufUTp8FVadiQ8gwzABZLDPgE0+TDxnHEXGqxQtzsN6b76mqNYYOhXtWGM6
hVjAWQ1lu6zv4vddIa4UgbrfSLWPxQ==
=MAV/
-----END PGP SIGNATURE-----

--hskdw542yop5hfv5--
