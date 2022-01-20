Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B02494618
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 04:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358332AbiATDZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 22:25:43 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:35739 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358325AbiATDZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 22:25:42 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JfSZX2MRSz4y3h;
        Thu, 20 Jan 2022 14:25:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642649141;
        bh=BSJaYZtaWNqvMmQ161KljdzjK3UMjtU9hJ54yKVDuaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gt5J4iAV9LgfRW72OSXoK+e0sTaCnzaQblxmzPE9rmuF8hv+KCsf/pGqYBfssmWbo
         kKSU8jEBZCFF5exfr6WM57KcKqVJ+K9PT0uxGTL7EJ5VqxpB44rrJ68tU9DNEHw9WD
         Mvdj4fXwAUUNaaTe5+j83539YAactYtdbjlJke6izKefJjmaEnoa7YbGCMlsLQ38qi
         SvsqoT/jST0EAgS4J1EPV1AVuNzwSYbHLX1lG8+XrX7qK/qUkxXxMikCQDFeAZkRik
         mGQfZFFTu5QOpwsgrIZ6GyTApc08JoGixoVqiPm5jE0NjZCbWfF2LeGVCCGRPYqv1v
         zFw49fPEHfGkQ==
Date:   Thu, 20 Jan 2022 14:25:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joey Gouly <joey.gouly@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the pinctrl tree
Message-ID: <20220120142539.6d1fac12@canb.auug.org.au>
In-Reply-To: <20211028080331.6d199082@sal.lan>
References: <20211027220118.71a229ab@canb.auug.org.au>
        <874k92bu4q.wl-maz@kernel.org>
        <20211028080331.6d199082@sal.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/k0TcC6Wp9bi=4NpQQykgMOj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k0TcC6Wp9bi=4NpQQykgMOj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 28 Oct 2021 08:03:31 +0100 Mauro Carvalho Chehab <mchehab@kernel.or=
g> wrote:
>
> Em Wed, 27 Oct 2021 12:10:45 +0100
> Marc Zyngier <maz@kernel.org> escreveu:
>=20
> > On Wed, 27 Oct 2021 12:01:18 +0100, Stephen Rothwell <sfr@canb.auug.org=
.au> wrote: =20
> > >=20
> > > After merging the pinctrl tree, today's linux-next build (htmldocs)
> > > produced this warning:
> > >=20
> > > include/linux/gpio/driver.h:284: warning: Function parameter or membe=
r 'parent_handler_data_array' not described in 'gpio_irq_chip'
> > >=20
> > > Introduced by commit
> > >=20
> > >   cfe6807d82e9 ("gpio: Allow per-parent interrupt data")
> > >=20
> > > But may actually be a problem with the tool :-(   =20
> >=20
> > I guess the tool doesn't like having two fields that are part of a
> > union documented together... Happy to tweak it if someone tells me how
> > this should be written. =20
>=20
> Yes, that's the case. See, when you do:
>=20
> 	/**
> 	 * @parent_handler_data:
> 	 * @parent_handler_data_array:
> 	 *
> 	 * Data associated, and passed to, the handler for the parent
> 	 * interrupt. Can either be a single pointer if @per_parent_data
> 	 * is false, or an array of @num_parents pointers otherwise.  If
> 	 * @per_parent_data is true, @parent_handler_data_array cannot be
> 	 * NULL.
> 	 */
> 	union {
> 		void *parent_handler_data;
> 		void **parent_handler_data_array;
> 	};
>=20
> The tool will understand it as an undocumented "parent_handler_data" and
> a documented "parent_handler_data_array".
>=20
> It has to do that, as otherwise it won't get cases where people just adds=
 a
> @foo: as a template but actually forgets to fill it.
>=20
> The solution would be to add a description for both, e. g. something
> similar to:
>=20
> 	/**
> 	 * @parent_handler_data:
> 	 *
> 	 * If @per_parent_data is false, contains a single pointer=20
> 	 * with the data associated, and passed to, the handler for the=20
> 	 * parent interrupt.
> 	 *
> 	 * @parent_handler_data_array:
> 	 *
> 	 * If @per_parent_data is true, it should contain an array of=20
> 	 * @num_parents pointers with the data associated, and passed to,
> 	 * the handler for the parent interrupt. Cannot be NULL.
> 	 */

I am still getting this warning.

--=20
Cheers,
Stephen Rothwell

--Sig_/k0TcC6Wp9bi=4NpQQykgMOj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHo1jMACgkQAVBC80lX
0GwOngf/QdrATg8xG8CNo0+qRiR+8Sr2oTKU/tmpN/tF+grDOhv9EnHLKTa4UnBy
ZWrZCuslIRIaP5MlMOYj2CIBNp8T0jQzLt3hrKTvFP3z12yvJLYF859RDCDT7ggV
sga4gy+YMF18ksHbFTy5ikmN+mW40RIolbFsmsJ9Wr+8DYqS2LVlBNkN2aWL/JbO
hTX1m3e8f8379shn8vYaNYDE786Bt7n1d8Be5xOqmlTP4s8swOd6ywjcJE9IBjw0
3vLqAGXgDkTb3TZ7zroiptu1VpjjxAWF4wOnJjC0SW6OAtJLwDOtanWMCuTaDjMN
Zeim4r5l8p5+ZwtrvgL+wy5y3HdfJQ==
=ucEL
-----END PGP SIGNATURE-----

--Sig_/k0TcC6Wp9bi=4NpQQykgMOj--
