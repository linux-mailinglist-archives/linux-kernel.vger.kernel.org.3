Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B2E4663F3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358069AbhLBMwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347388AbhLBMwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:52:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D432C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 04:49:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2CE04CE220F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 12:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F72C00446;
        Thu,  2 Dec 2021 12:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638449350;
        bh=OYZ5slALRb6YEEz0iSMCUsRQKUEEfwmgzxSeCbV3Ly0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OgwbO/pKpgHLYNo6JCXBabVCaL8HmrhG88Ot8MQyNV8YzXpPJOo1tImriUg7mTDvi
         zlFGrCcr+7NAE5MLXYYjBRCnly3hujJUDaF1GSH/uAy7D1mGal2GaB33D62hQ72a67
         XMrH4DrmhyA0CZolOBI8pvCMEr3Fi25NLupT4qk61E+nizj0Yrg6Q3Eelu70tKXwy+
         VVe4MoxPIsBo3D2pHKcDdGKpOk3RnmNQtWHfORvBrm3aXByUgQcqUGCERi1x4V6hRx
         7bbI6U9N0V+VkxsTDlzVV4mHyPIosds2XGABPs3FpgCj7DQqJAc9XOZVq3IgZyRQWX
         kyQp2w7iKDdww==
Date:   Thu, 2 Dec 2021 12:49:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: cs42l42: Implement system suspend
Message-ID: <YajAwvruDCzaR5wS@sirena.org.uk>
References: <20211201153648.17259-1-rf@opensource.cirrus.com>
 <YaejghraYE6lD7FD@sirena.org.uk>
 <87930df9-6220-807e-a655-1c7d7ec020ab@opensource.cirrus.com>
 <YafyWnVA1J1rgCf1@sirena.org.uk>
 <20211202095333.GK18506@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nCM9gNUjdUpogTrV"
Content-Disposition: inline
In-Reply-To: <20211202095333.GK18506@ediswmail.ad.cirrus.com>
X-Cookie: Put no trust in cryptic comments.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nCM9gNUjdUpogTrV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 02, 2021 at 09:53:33AM +0000, Charles Keepax wrote:
> On Wed, Dec 01, 2021 at 10:08:26PM +0000, Mark Brown wrote:

> > ...that's based on the assumption that this is all about the magic write
> > sequences you're using for shutdown potentially conflicting with default
> > values you've got in the cache?  If it's not those then the assumption
> > is that either the device was reset in which case it has reset values or
> > the device was not reset and held it's previous value, in which case the
> > cache sync is redundant.

> This isn't quite accurate though, as whilst the device was
> suspended the user may have touched ALSA controls which will have

> updated the state of the cache. Thus the cache requires a sync
> regardless of if the hardware turned off.

Right, an actual description of an actual issue.  Though how would they
have touched the ALSA controls during system suspend?  Userspace should
halted before we start suspending devices so there shouldn't be anything
new coming in from the application layer while the device is in cache
only mode.  The sound card as a whole should've been suspended first so
nothing should be coming in from there either.

> I suspect we do need to have a think about the write sequences,
> but there is also a more general issue here. The sequence looks
> like this:

> 1) Device enters cache only mode.
> 2) User writes an ALSA control causing a register to return to
> its default value.
> 3) Device exits cache only and does a cache sync.

This is a thing that happens for runtime suspend but for runtime suspend
we have good tracking of if the device lost power so we shouldn't just
be marking the cache as dirty unconditionally.  For system suspend there
shouldn't be a need to worry about userspace changing anything, and
anything coming in from the rest of the kernel should be very limited.

In any case this isn't something that should be hacked around in an
individual driver, like I say whatever the driver is trying to do needs
to be written in a clear and obvious fashion.

--nCM9gNUjdUpogTrV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGowMEACgkQJNaLcl1U
h9DBhQf/TTyORcnTZkHZB+p/0txthGanm/yQPncXofYRB8q3HBkAVmWZIrmPk7Wf
836TS2fc6cXWOdXCOg91On1weoFiimW3Tf+mr4uac6H3PT3seXnv/7T69kpYN735
EIVcqQdJDRrKFHw9wWUDIzq5i2Si31QiUNuud+L7HizkMsbUlZrjoeP9bREuJaYu
FgDOn2mddi4TE+Qib//o9cFik48P0vFZ7STVNoRad1PDsbnIJUhp0m7aNA3nUSNf
cVphB6f6cWKxhh6CS8TK/faraauQ69jv/yo00BWqmVxnJF/jU2D7o4fj5HqgGETS
aQzn3pUOWBxtCdzpd/7f0wd7fOXmFQ==
=Y5jC
-----END PGP SIGNATURE-----

--nCM9gNUjdUpogTrV--
