Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9ED531853
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbiEWS2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245135AbiEWS0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:26:37 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F885C369;
        Mon, 23 May 2022 11:02:03 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 827591C0B82; Mon, 23 May 2022 19:59:28 +0200 (CEST)
Date:   Mon, 23 May 2022 19:59:28 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast
 init
Message-ID: <20220523175928.GA30223@duo.ucw.cz>
References: <20220322191436.110963-1-Jason@zx2c4.com>
 <YjqVemCkZCU1pOzj@mit.edu>
 <YjqbcQbYHCOpgqGg@zx2c4.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <YjqbcQbYHCOpgqGg@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > One of the big issues with /dev/urandom writes is that *anyone*,
> > including malicious user space, can force specific bytes to be mixed
> > in. =A0That's the source of the reluctance to immediate use inputs from
> > writes into /dev/[u]random until there is a chance for it to be mixed
> > in with other entropy which is hopefully not under the control of
> > malicious userspace.
>=20
> Right, sort of. Since we now always use a cryptographic hash function,
> we can haphazardly mix whatever any user wants, without too much
> concern. The issue is whether we _credit_ those bits. Were we to credit
> those bits, a malicious unpriv'd user could credit 248 bits of known
> input, and then bruteforce 8 bits of unknown input, and repeat, and in
> that way destroy the security of the thing. So, yea, the current
> reluctance does make sense.
>=20
> > Now, I recognize that things are a bit special in early boot, and if
> > we have a malicious script running in a systemd unit script, we might
> > as well go home. =A0But something to consider is whether we want to do
> > soemthing special if the process writing to /dev/[u]random has
> > CAP_SYS_ADMIN, or some such.
>=20
> Exactly. So one way of approaching this would be to simply credit writes
> to /dev/urandom if it's CAP_SYS_ADMIN and maybe if also !crng_ready(),
> and just skip the crng_pre_init_inject() part that this current patch
> adds. I'll attach a sample patch of what this might look like at the end
> of this email.

CAP_* should not really work like that. They should control if process
can do the operation, but should not really silently change what
syscall does based on the CAP_*...

(And yes, I'm a bit late).

Best regards,
								Pavel
							=09

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYovLgAAKCRAw5/Bqldv6
8okSAJ494jYj529aStpwUSRGJyX7bstzigCfUhDnVooEyqU8fxOWunoDWU4iZoc=
=suKg
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
