Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B154E9665
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242401AbiC1MVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242098AbiC1MVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:21:41 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715EA4CD5A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=b3vky4fbB6O2QjX9hQ0x0Dv9Gjmj
        rxV8HDWSFRt4zEY=; b=QdZEf5YzLfEUpDykBUntqHvOWwjTIsJwo0WOVWtJObVk
        AM3D2sq0HLRciczewCUUZNfRM2q8MXTHFpzaGcO7p3Uh4yuFmBWfiP/b+wh5bAp8
        6lFeCC+unjpSh5lDaaSVckMys3O3mc8ZiuCkSFbKFqSRtY7Ykj9tEhfD8YLM2Xs=
Received: (qmail 1362189 invoked from network); 28 Mar 2022 14:19:55 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Mar 2022 14:19:55 +0200
X-UD-Smtp-Session: l3s3148p1@+qZ8VEbbqt4gAQnoAEkIAFmtuepKDVA5
Date:   Mon, 28 Mar 2022 14:19:55 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 1/1] gpio: add sloppy logic analyzer using polling
Message-ID: <YkGn6/B4XHhb72YC@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <20220317085019.3987-1-wsa+renesas@sang-engineering.com>
 <20220317085019.3987-2-wsa+renesas@sang-engineering.com>
 <YjiC6Lg5k5gK/BfP@smile.fi.intel.com>
 <YkGB3AgME/OZAdoG@ninjato>
 <YkGSzCykWvPXX89O@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D9OH/w6haNYSYoiD"
Content-Disposition: inline
In-Reply-To: <YkGSzCykWvPXX89O@smile.fi.intel.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D9OH/w6haNYSYoiD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I don't like assigning 'priv' memebers twice, so I'd like to keep it as
> > is.
>=20
> But this will give better understanding of the steps the code performs, n=
o?

IMO the current version is readable :)

> (Because this function basically contains two steps at once. I assume it's
>  done this way due to absence of vrealloc(), right?)
>=20
> But we have kvrealloc(). Can it be used here?

This has a huge disadvantage: realloc() requests new memory before the
old one is discarded. If you want to make a huge buffer bigger, this can
lead to OOM. The old contents do not matter, so the old buffer can go
away in favor of the new one.

> > > Can it be wrapped by DEFINE_SHOW_ATTRIBUTE()?
> >=20
> > I don't see a way. Do you?
>=20
> Me neither. I mixed this up with (not upstreamed yet) DEFINE_STORE_ATTRIB=
UTE.

Still no cigar. That one is for rw files. Mine is writable only, so I use
e.g. no_llseek.

Probably, the above macro should be named, DEFINE_SHOWSTORE_ATTRIBUTE.
But I see this macro is stalled since late 2020 anyhow.


--D9OH/w6haNYSYoiD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJBp+cACgkQFA3kzBSg
Kbb++A//WoDLeHQ4waICSngbE4NuxB157ZbgUeHRbJ+z/uyR045HOtPEzI+1NZzD
ymvvnL32arTHLO5HcCFokR4MGck6BBpq6kbZqBx2VSHfK/sX6EPI06nfe4Q7xZig
WDGodn2w4GOvaaMl4ojuk3KAczlsEcSchLheTYdR9A04BXtoTlrfxf1Ox5kKRXta
XFCyg7ohFIFgSVommqx43j2WZ66xDnc7FsufuHic9WCsWMl58ibNyYG9ygqoRaKO
Y/ccP5F+lhvh0cgMOLzlzm6IcNN3Y1wwuv6CPZzUX977ExJ7GV/Tmv3JUL5Hh//W
zLifS9L5T6B9Pz8AKDKETKCflVMzkriKYP7xviAD9DwVvnRNFPWvPgXxCXyI/yr1
jrnwV2R7TLP50YPTaHylpb9rISeZJ0aVbmLFUEULfPTDKUY26MfPrJtmd5A2mbbi
FNfWHbDBWAbGqbcYxrUhBYNYLXa1FWGtd0dtfDZEE7ovVggLLzw2zrMSl1Y4f7Ck
0yAX+lA+lL2XFNi3TZMLDF+y9Ja7edkVCkK7KIN53F8tqgszoSKWF9p0za0iQO8c
hzKfzjCb0QfjD9wJSThSOVwKf++XRLZPaXWNxDj2buR+Kg4asLpNzOQPZW93POpU
txecCdFYbnHaaxCbWbWa1bsgHdeTBiXwBFieup0kEMR0f0RIwAA=
=sS+y
-----END PGP SIGNATURE-----

--D9OH/w6haNYSYoiD--
