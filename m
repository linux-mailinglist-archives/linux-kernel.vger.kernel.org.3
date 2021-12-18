Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C614799FC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 10:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhLRJkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 04:40:40 -0500
Received: from www.zeus03.de ([194.117.254.33]:56702 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232538AbhLRJkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 04:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=01B0qNWU0+z7ea4VytjhqQ7lyoMH
        ToAZMg780ztv3j8=; b=dOBQIh3/6v2yYD2fnPrZL0bJayC2uva12DT+dPQ1dE5/
        TGr5GRvaQ5ATLStkNXTITamq6IQ8eLTdUmH/W9GptW2nRB4JdZWYssmMqGl/TnoX
        ZRX02EEGHisurL2lFnpQh3LXmtiebffOzsvkDTA1JEyQ7oqsIlMoPirKFNeJ4Nw=
Received: (qmail 241675 invoked from network); 18 Dec 2021 10:40:37 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Dec 2021 10:40:37 +0100
X-UD-Smtp-Session: l3s3148p1@vk52cmjT+uYgAQnoAHcYABNC0nuAbl2v
Date:   Sat, 18 Dec 2021 10:40:33 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 1/1] gpio: add sloppy logic analyzer using polling
Message-ID: <Yb2skaWF7cx6PHLO@kunai>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-doc@vger.kernel.org
References: <20211123164902.35370-1-wsa+renesas@sang-engineering.com>
 <20211123164902.35370-2-wsa+renesas@sang-engineering.com>
 <YZ024q/r7Hc3TpMt@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uKScydRu35zTx0SP"
Content-Disposition: inline
In-Reply-To: <YZ024q/r7Hc3TpMt@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uKScydRu35zTx0SP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy,

> > +Result is a .sr file to be consumed with PulseView or sigrok-cli from =
the free
> > +`sigrok`_ project. It is a zip file which also contains the binary sam=
ple data
> > +which may be consumed by other software. The filename is the logic ana=
lyzer
> > +instance name plus a since-epoch timestamp.
> > +
> > +.. _sigrok: https://sigrok.org/
>=20
> Alas, yet another tool required... (Sad thoughts since recently has insta=
lled
> PicoScope software).

? For sure, another tool is required. Do you want the analyzer itself to
output pretty SVG files? :)

>=20
> >     kgdb
> >     kselftest
> >     kunit/index
>=20
> > +   gpio-sloppy-logic-analyzer
>=20
> Above looks like ordered, do we need some groups here or so?

No feedback from the doc-maintainers so far. Can easily be fixed
afterwards if needed.

> > +	mutex_lock(&priv->lock);
>=20
> > +	if (priv->blob_dent) {
>=20
> Redundant (i.e. duplicate).

Nope, it can be NULL if allocating memory all goes wrong.

> > +gpio_err:
>=20
> A bit confusing name. What about
>=20
> enable_irq_and_free_data:

Yes, fixed in v6.

> > +	char *meta =3D NULL;
> > +	unsigned int i, meta_len =3D 0;
> > +	int ret;
>=20
> Perhaps
>=20
> 	unsigned int i, meta_len =3D 0;
> 	char *meta =3D NULL;
> 	int ret;

I'd like to keep the pointers grouped together.

> > +	if (ret >=3D 0 && ret !=3D priv->descs->ndescs)
>=20
> > +		ret =3D -ENODATA;
>=20
> Don't remember if we already discussed this error code, but data is there,
> it's not correct. EBADSLT? EBADR? ECHRNG?

In your V1 review, you suggested -ENODATA. I will pick yet another one,
but it really matters zero in practice.

> > +		meta_len +=3D snprintf(meta + meta_len, add_len, "probe%02u=3D%s\n",
> > +				     i + 1, gpio_names[i]);
>=20
> Do we really need the 'probe%02u=3D' part? It's redundant since it may be=
 derived
> from the line number of the output (and it always in [1..ndescs+1]).

It makes creating the .sr-file a lot easier. If you feel strong about
it, then you can later remove it and also update the script, I'd say.

> > +	dev_info(dev, "initialized");
>=20
> Is it useful?

For the third time, yes!

> > +	cat <<EOF
>=20
> 	cat << EOF
>=20
> is slightly easier to read.

I'll fix it.

> > +	[ -d $cpusetdir ] || mkdir $cpusetdir
>=20
> `mkdir -p` and drop needless test.

It is not the same. I prefer to bail out if e.g. '/dev/' does not exist
rather than silently create it.

> > +	val=3D$((0x$oldmask & ~(1 << isol_cpu)))
> > +	newmask=3D$(printf "%x" $val)
>=20
> Can be on one line (in a single expression).

Ok.

> `> /dev/null 2>&1` is idiomatic. And I think there is actually a subtle
> difference between two.

What is the difference? Does it matter here?

> > +			[ "$chan" !=3D "$elem" ] && [ "$chan" -le $max_chans ] || fail "Tri=
gger syntax error: $elem"
>=20
> No need to execute `test` twice:
>=20
> 			[ "$chan" !=3D "$elem" -a "$chan" -le $max_chans ] || fail "Trigger sy=
ntax error: $elem"

I read that '-a' and '-o' are deprecated. Dunno where but looking again
I found this: https://stackoverflow.com/questions/20449680/boolean-operator=
s-a-o-in-bash

>=20
> > +			bit=3D$((1 << (chan - 1)))
> > +			mask=3D$((mask | bit))
> > +			case $mode in
> > +				[hH]) val1=3D$((val1 | bit)); val2=3D$((val2 | bit));;
> > +				[fF]) val1=3D$((val1 | bit));;
> > +				[rR]) val2=3D$((val2 | bit));;
> > +			esac
> > +		done
>=20
> > +		trigger_bindat=3D"$trigger_bindat$(printf '\\%o\\%o' $mask $val1)"
> > +		[ $val1 -ne $val2 ] && trigger_bindat=3D"$trigger_bindat$(printf '\\=
%o\\%o' $mask $val2)"
>=20
> `printf` with arguments may be split to a separate helper function.

I think this is a micro-optimization, but feel free to change it later.

> > +	taskset "$1" echo 1 > "$lasysfsdir"/capture || fail "Capture error! C=
heck kernel log"
>=20
> Shouldn't this function setup signal TRAPs?

To do what?

> $@ is better, actually one should never use $*.

What difference does it make when expanding into a string?

> Wondering, shouldn't be a simple validator before start that we have comm=
ands
> present, such as zip?

This is what the variable 'neededcmds' is for...

Kind regards,

   Wolfram


--uKScydRu35zTx0SP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmG9rI0ACgkQFA3kzBSg
KbY3vQ//XZgYs/+nFBed+r2i0GulvWh1/qdmjU5SyG26r2hYQTcOda/Boetjon7L
GwZFrw3tR8EfDDJnCrBGs7pFHMjBdIAL0u31T8lnf9hBasuPKNx2PFgAJIWmAArH
xZBw8Xb0NSVMkvkkWsfmLms9DAR/3BHw6vyKcLNFU+hDXySbH5yS22VVYiB7tbwD
zt+parVny/S+rFBv5CneuDktzKmqrMNWTu/JsrgpqTQAf0Wp0M06aykV35m06OUr
M3zP04iJAuTPO4r9KjIOpSliT3bSiMi+XQRbR/Ym56JhRrZ8xcEuAHGXNGLgrmls
IKUYxy1BhDQmsGpEVVMbVTN+XSbz+a1hRhxBTt4X0BObBoPylQ6BvJ+XUJ0nFENm
da8TsgFpHXQKMTRzVnS8/74Yrg7AI+MkwcAr8wziBITb0zmxkkicQwHfYMt51Yf1
SxvhoEVJ/scss4RkiD46itzK+xKNCe7a3klHeNkSamBoTuAlT8XgoxiTxrOVSn8D
Iu4jnbIuGd4zTJYLvpLLyhGlKxACcvPS7EwBDhDgTISY81CdK/z3OlGH5X3nCq/j
ZU/6wn2TFopn+NEFWhpK4n/0t7WiGC0aEmWm+3lc+oL4MZ1/zxM/4W7bXdSoaWVZ
SEpobFHJ7VojvRxfm4jO5Q8UVzitrIWRVyz8MuTKZo8/aH+Rs/M=
=PKTE
-----END PGP SIGNATURE-----

--uKScydRu35zTx0SP--
