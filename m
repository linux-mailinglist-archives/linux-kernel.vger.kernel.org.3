Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CA34D2F9C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbiCINBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbiCINBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:01:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB31F178683
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:00:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E9C3B8214E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F13C340E8;
        Wed,  9 Mar 2022 13:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646830849;
        bh=05mWd2rzKwbYb9xhfIrjasgLspp1675V6bzZz5xZETY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rk37yvuJ0fjqDriItDz+V3Yf3Jlw+KIqxJ9EwiPxqe517GzBdz8Y9INqZaZkFXJO0
         aTgA0gRrILYDNSpazoNlAvJglkmWVnscCAb/iWI/UQqD/Law+iqbYzFkHTDD1hCkSf
         BZeM9PdY1IdR3x344Egfv26hr/ZYmjtZSwgdaM0mXmP8FUQWLqeAE86qXDyCKIIxbx
         F0prNvHBe5TvtzSN2ISEmmJvI/fyMAIgykRmkSX4BoNGi7awMqXDcXIeSrZxj5fB4R
         l62qg4SfPGH0xyMD3qAs6B6Yr+08O1Scqi2fvUacgPeXVk/UVTH2PLQg34Vt9SwaEf
         lUK8qXsdFhZNw==
Date:   Wed, 9 Mar 2022 13:00:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Keeping <john@metanate.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tas5805m: fix pdn polarity
Message-ID: <Yiik/f+2bYbU4UL8@sirena.org.uk>
References: <20220309104104.3605112-1-john@metanate.com>
 <YiiZv7Fc8a4O1nYR@sirena.org.uk>
 <Yiie1OUCvi49f1Q7@donbot>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hjBCmlAKl+Qf/it8"
Content-Disposition: inline
In-Reply-To: <Yiie1OUCvi49f1Q7@donbot>
X-Cookie: You will inherit millions of dollars.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hjBCmlAKl+Qf/it8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2022 at 12:34:28PM +0000, John Keeping wrote:
> On Wed, Mar 09, 2022 at 12:12:47PM +0000, Mark Brown wrote:
> > On Wed, Mar 09, 2022 at 10:41:04AM +0000, John Keeping wrote:
> >=20
> > > Fixes: ec45268467f4 ("ASoC: add support for TAS5805M digital amplifie=
r")
> >=20
> > Please don't insert fixes tags unless you're actually fixing a bug,
> > stylistic improvements like this - people try to use the tag for
> > backporting bug fixes and so on so extra tags create noise for them.

> This isn't purely stylistic - it affects the interpretation of pdn-gpios
> in the device tree so that it matches all of the other bindings that use
> this property: active means PDN asserted.

So there's some functional change?  That's not at all clear from either
the patch description or the code - it's flipping both the ACTIVE mode
for the GPIO and all the values set which should result in no visible
change.  If there is a functional problem that is being fixed the
description needs to be clear as to what that is.

--hjBCmlAKl+Qf/it8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIopPwACgkQJNaLcl1U
h9Dz6Qf/Rx3O2NC+fo44hKIqYpJBFJAGAT1vhCKye5rC0cPnfrahsuAJlCCtNnD0
0lH5kzPWDHEDWwFgdqTReBykG6CR2XJeMbmppFJBDXRwleeKLkZsxC4L9b4iQlK3
B5/67vv6Ju0SECEO8XDQQGnqPYclkGA+Bw0fzUvFZtpLxQFgVgbvO5Zy3NDnPLIb
NEMZECzfJP2At7zBbYhBR/VgLRNNjfskD1A/fFb66ldkUUenIy5oQc4EhsowIuFQ
C6hrzwilfB8c2M5gAF1wHdr8I8oOkauoHazJJ2awQZypPn2xKU8JEW2tArhHpTQs
INvjPb0PRGQJls6P1GKKHKNngVgXzg==
=uZKY
-----END PGP SIGNATURE-----

--hjBCmlAKl+Qf/it8--
