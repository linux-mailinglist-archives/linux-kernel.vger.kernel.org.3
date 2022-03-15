Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95424D989E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239877AbiCOKXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346885AbiCOKWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:22:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E795506CA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:21:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nU4J7-0000Us-KI; Tue, 15 Mar 2022 11:21:37 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-97f1-7654-c271-bcb4.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:97f1:7654:c271:bcb4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 65C964BA0A;
        Tue, 15 Mar 2022 10:21:35 +0000 (UTC)
Date:   Tue, 15 Mar 2022 11:21:35 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Max Staudt <max@enpas.org>
Cc:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v3] can, tty: elmcan CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220315102135.evgt4es7yb23sabb@pengutronix.de>
References: <20220307214303.1822590-1-max@enpas.org>
 <CAMZ6RqJZObevKPc29jW+m6i0eAgestTbw8KCPXxSGHzSXK7cRg@mail.gmail.com>
 <20220309135414.34f77251.max@enpas.org>
 <CAMZ6RqJJ-PO=WeFeuXk4iC9GHLXz_ZMWtsVCm6sGVGbmeE5U1Q@mail.gmail.com>
 <20220312222142.21591629.max@enpas.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ljfp3hdtlvkt5bva"
Content-Disposition: inline
In-Reply-To: <20220312222142.21591629.max@enpas.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ljfp3hdtlvkt5bva
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.03.2022 22:21:42, Max Staudt wrote:
> @Vincent - two more things have remained, and I hope it's okay once I
> explain them:
>=20
> 1. _memstrcmp() - memcmp() vs. str(n)cmp()
>=20
> The _memstrcmp() function does not compare strings, it compares raw
> buffers. I am just using C strings for the fixed buffers to compare
> against, as that allows for shorter and easier to read code. The NUL
> byte at the end of those strings goes unused.
>=20
> Also, I have not looked at the assembly produced, since the semantics
> are different: str(n)cmp() needs to look for NUL bytes in the buffer(s),
> which is unnecessary here. As a bonus, NUL will never even occur
> because my code filters those bytes out upon reception from the UART
> (it's a documented quirk of the ELM327).
>=20
> Finally, even if I were to use strcmp(), the code would still look just
> as ugly. Except the machine would also look for NUL bytes, and the next
> human to read the code would wonder why I'm comparing strings and not
> buffers.
>=20
> Hence memcmp(), to help the code self-document and the compiler
> optimise - I hope that's okay.

Looking at the code:

> +/* Compare a buffer to a fixed string */
> +static inline int _memstrcmp(const u8 *mem, const char *str)
> +{
> +     return memcmp(mem, str, strlen(str));

The _memstrcmp is sometimes directly used. Where's the check that mem is
valid for strlen(len)? Better only use _len_memstrcmp().

> +}
> +
> +/* Compare buffer to string length, then compare buffer to fixed string.
> + * This ensures two things:
> + *  - It flags cases where the fixed string is only the start of the
> + *    buffer, rather than exactly all of it.
> + *  - It avoids byte comparisons in case the length doesn't match.
> + */
> +static inline int _len_memstrcmp(const u8 *mem, size_t mem_len, const ch=
ar *str)

make it a bool.

> +{
> + 	size_t str_len =3D strlen(str);
> +
> +	return (mem_len !=3D str_len) || memcmp(mem, str, str_len);
> +}

Can you rename _len_memstrcmp into something like elm327_match() or so?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ljfp3hdtlvkt5bva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIwaKwACgkQrX5LkNig
011f3QgAtpKD3azoXiCk8tqsByeX0+JujrYl+eg2jXCOuE3dpOEYGnnewW+Elq7H
aoXZ/mTc5iLcoF7FSTz5OH8joUS4bTk65wxRHVAKXmAA9kyDHQzeg/intLsyKX5f
mgKJszUXl3JGcZtmUDDTK40/IbFCpAeuFHhTFKLinPdg29wuk0iGyUCQVWb/m6L5
ts5AKaNqfGk2dxPZ+cKWDsJXhRBr7B4BjmS9kr03ddGPtPUDSFM5cHEP8ZjaspYc
jFQb4lf4H/SNYpuq9VEVXubQkcqNkio+zp3iyWuZ1NOxqLWRv1rBBvE/QAaLtxVQ
8HGNMMnJyWtJKZE91Byr9o6ZLX0Sng==
=llkR
-----END PGP SIGNATURE-----

--ljfp3hdtlvkt5bva--
