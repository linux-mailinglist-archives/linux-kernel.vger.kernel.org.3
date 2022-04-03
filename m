Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1447B4F0A5E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359063AbiDCOwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 10:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244926AbiDCOwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 10:52:02 -0400
X-Greylist: delayed 339 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 03 Apr 2022 07:50:06 PDT
Received: from glittertind.blackshift.org (glittertind.blackshift.org [IPv6:2a01:4f8:1c1c:29e9::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D5E396B6;
        Sun,  3 Apr 2022 07:50:06 -0700 (PDT)
Received: from bjornoya.blackshift.org (unknown [IPv6:2a03:f580:87bc:d400:dea6:32ff:feb1:177a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "bjornoya.blackshift.org", Issuer "R3" (verified OK))
        by glittertind.blackshift.org (Postfix) with ESMTPS id ED0AE4E1439;
        Sun,  3 Apr 2022 14:44:25 +0000 (UTC)
Received: from pengutronix.de (2a03-f580-87bc-d400-2568-5610-be2e-0839.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:2568:5610:be2e:839])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3A11B5932E;
        Sun,  3 Apr 2022 14:44:25 +0000 (UTC)
Date:   Sun, 3 Apr 2022 16:44:24 +0200
From:   Marc Kleine-Budde <mkl@blackshift.org>
To:     linux-sh@vger.kernel.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: make iounmap() a static inline again
Message-ID: <20220403144424.f5akrad75xtkncgz@pengutronix.de>
References: <20220105085746.1116726-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y5qda4tomsttcgy4"
Content-Disposition: inline
In-Reply-To: <20220105085746.1116726-1-mkl@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y5qda4tomsttcgy4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.01.2022 09:57:47, Marc Kleine-Budde wrote:
> The patch
>=20
> | 98c90e5ea34e sh: remove __iounmap
>=20
> removed the __iounmap macro for the NOMMU case, but also converted the
> static inline no-op iounmap() to a macro, resulting in lots of unused
> variable warnings.
>=20
> This patch coverts the macro into a static inline function, similar to
> previous patches in the sh arch:
>=20
> | 4580ba4ad2e6 sh: Convert iounmap() macros to inline functions
> | 733f0025f0fb sh: prevent warnings when using iounmap

The problem still exists in linus/master, can someone take this patch?

regards,
Marc

> Fixes: 98c90e5ea34e ("sh: remove __iounmap")
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  arch/sh/include/asm/io.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
> index cf9a3ec32406..4960b8ff1ad4 100644
> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -271,7 +271,9 @@ static inline void __iomem *ioremap_prot(phys_addr_t =
offset, unsigned long size,
>  #endif /* CONFIG_HAVE_IOREMAP_PROT */
> =20
>  #else /* CONFIG_MMU */
> -#define iounmap(addr)		do { } while (0)
> +static inline void iounmap(void __iomem *addr)
> +{
> +}
>  #define ioremap(offset, size)	((void __iomem *)(unsigned long)(offset))
>  #endif /* CONFIG_MMU */
> =20
> --=20
> 2.34.1

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--y5qda4tomsttcgy4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJJssQACgkQrX5LkNig
011irQf9HZnQq5ATktTlhzEDcsWEtrTO/zuIuVRQjCjJkoXxx/AXnmr1Bxdhpqpl
XrJRgk8pqsrkK1RBHLJNKS19NU6ujciVKnOSbJ1hQkQhiXC9CLZI8O0X+PkyrbbZ
de5pUts2RqImI3s+ejZVCAeGnmaEmp0VAKYmehxbAhwGnRmdxkpYa6Yi/iC3Mhxs
p0eM6hdbm2wYbMI/jTLUAkZ+vTmK3uG7vHg7Z2m3HWMwQ2024GGiSS97LDKblpEa
hfCUQ5gfM9Y4BG1S/QOYkB5bl43ZUkLUOk7Gn2Yqvwz4vGugzZ0js53B9YtI+ZKl
4M/1OI/zd2SHm+ONDwjy4uHfbuj7pQ==
=O1BU
-----END PGP SIGNATURE-----

--y5qda4tomsttcgy4--
