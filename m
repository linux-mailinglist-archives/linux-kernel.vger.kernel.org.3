Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F41E53FE78
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243478AbiFGMN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237980AbiFGMNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:13:21 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052C4C4E92
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:13:18 -0700 (PDT)
Received: from ktm (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id CA4A280084;
        Tue,  7 Jun 2022 14:13:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1654603997;
        bh=6DJxzdyYxhsOo1jI8F27Eb9b6EKACn77Zrya8L9TOmA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KWQWerxr1yx7PzbFPPloUFtsWEYF01qdnfYVwlTzT+c4cZGi4O8cuaS3CgsntTLux
         Jz7dzJ7WTqYd/cdlSghVJfQmgOK6kpNkXNjSEhuN/jWJkZQ3F3DlYxzFZTfkbygBwO
         y6OOiyAq8U0dtYROUB2j69ZZs1ABN5PbavwBseej0k4TUla56BFjxL4nzU0pns0WYb
         tSHYOSWHyLtl4SlLqNWYOyYFaQNwu0qCHQuMt2QlgXXWKpU7Zzih3MHfc/k7SNz0bb
         HcH51p92JBukwDEUbMkKHbx2RgKaYt+Ew6dQyV44U9JmWU9w3cxWXJ5BRI6vQs3cuV
         pjLLYZt5Omfmg==
Date:   Tue, 7 Jun 2022 14:13:09 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 2/3] ASoC: wm8940: Rewrite code to set proper clocks
Message-ID: <20220607141309.11ec7503@ktm>
In-Reply-To: <Yp4o2bQammYjv7Kt@sirena.org.uk>
References: <20220606154441.20848-1-lukma@denx.de>
        <20220606154441.20848-2-lukma@denx.de>
        <Yp4o2bQammYjv7Kt@sirena.org.uk>
Organization: denx.de
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/4rEM/pPsB1C0Pm5xN.cpDX4"; protocol="application/pgp-signature"
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4rEM/pPsB1C0Pm5xN.cpDX4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

> On Mon, Jun 06, 2022 at 05:44:40PM +0200, Lukasz Majewski wrote:
> > Without this change, the wm8940 driver is not working when
> > set_sysclk callback (wm8940_set_dai_sysclk) is called with
> > freqency not listed in the switch clause. =20
>=20
> > This change adjusts this driver to allow non-standard frequency
> > set (just after the boot) being adjusted afterwards by the sound
> > system core code. =20
>=20
> I don't entirely follow the above - in what way might the core adjust
> the clocking, and why would we want to allow the use of invalid
> clocks? Surely that just makes error checking worse.

Hmm, it is a bit complicated.

When I enabed wm8940 support in mainline - the first call to
wm8940_set_dai_sysclk (the set_sysclk callback) required mclk =3D 11997070
frequency.

With the current code [1] the initialization of the codec returns
-EINVAL and the codec is not supported in the system:

asoc-simple-card: probe of sound failed with error -22



The approach used in this patch set to fix the above issue is based on
one already present in-tree for wm8974 codec.

>=20
> > Code in this commit is based on previous change done for wm8974
> > (SHA1: 51b2bb3f2568e6d9d81a001d38b8d70c2ba4af99). =20
>=20
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet
> access.=20

Ok, I will add some more verbose description. The aforementioned SHA1
is referring to commit already in-tree, so you would find it easily
even without the Internet.

> I do frequently catch up on my mail on flights or while
> otherwise travelling so this is even more pressing for me than just
> being about making things a bit easier to read.

+1

Links:

[1] -
https://elixir.bootlin.com/linux/v5.18.1/source/sound/soc/codecs/wm8940.c#L=
614

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/4rEM/pPsB1C0Pm5xN.cpDX4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmKfQNUACgkQAR8vZIA0
zr1yzQf+Ic5TypvIaPlaHw6Z1F/d/Q7prs+hM7NHROk2GxS5YsLfcbPTz8xF5F8m
6cIN/fgyjQkffpo/XFtPVCTVi+56qF28xuRVKoVzNp6cLdhyWgqz7nu0B35qJwIB
f6/u5qPS9OusTU4+S7QQ7W8b9vTtJMbl7TdpIu6p22Jht7f/3HFqLVL7Yk2SMN/+
5G6LVkxys6/bUWWJ5TjpfD7wAjkZ/61RQosk9oo6U57KtFaoYKJJtgUAzkKxkjBG
1+FVtTjCjn0imqwv4IU3ASU6ddedU6nrjyogBzl+yJls8drS3jH0TxnyfvCAUL41
2joIwXo5tiu8OPgIBctgJmSARrZ4jg==
=S3jh
-----END PGP SIGNATURE-----

--Sig_/4rEM/pPsB1C0Pm5xN.cpDX4--
