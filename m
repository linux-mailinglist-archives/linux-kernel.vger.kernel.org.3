Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713534843A9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbiADOrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:47:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40572 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiADOrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:47:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95FDB61486
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 14:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F199BC36AED;
        Tue,  4 Jan 2022 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641307651;
        bh=8oeeGDAP9rzSncCrj5L2Zqa/nZZ5MhuFbFdTeGZaRm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HNeSuzprgRcso0bEij5sKNkivKcf8wKpna86CUQ7xi30u1wvjzgIIjFPDYLS17gBA
         RCOs60EtytkjxST69TqKuVLDtBWAU+8mbcPpFXnboUXzasqrAEqBK6X/f/YcQbPQm4
         VJVM7VJgmoDD6Q77phdFTPtRinSWEdGktlixY/r6FjI7Rv1MGOX0wIL1eKqMShTU/y
         wzQd1WGOTT3TCYvuOQmwsx7M4SJsVPAio1qZqqnjfrHs9WIfNBMMnL1Gk2axHu9a4H
         7k6mKmlYNLcTM12PM9GPvyKYQQzCUhbqUImVON5tk5W731Fl1cUb3eZA46kDX2Mpq2
         /ePXb+vzUDhUQ==
Date:   Tue, 4 Jan 2022 14:47:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, Watson Chow <watson.chow@avnet.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 2/2] regulator: Add MAX20086-MAX20089 driver
Message-ID: <YdRd/m3mOwcvvJ2L@sirena.org.uk>
References: <20220102211124.18435-1-laurent.pinchart+renesas@ideasonboard.com>
 <20220102211124.18435-3-laurent.pinchart+renesas@ideasonboard.com>
 <YdRWwWmoQGQuUyLz@sirena.org.uk>
 <YdRa0GoSoX8CP694@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HN230c+fjCk4OvNj"
Content-Disposition: inline
In-Reply-To: <YdRa0GoSoX8CP694@pendragon.ideasonboard.com>
X-Cookie: The horror... the horror!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HN230c+fjCk4OvNj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 04, 2022 at 04:33:52PM +0200, Laurent Pinchart wrote:
> On Tue, Jan 04, 2022 at 02:16:33PM +0000, Mark Brown wrote:

> > > +	chip->num_outputs = num;

> > The number of regulators the device supports should be known from the
> > compatible, I'd expect a data table for this.  It should be possible to
> > read the state of regulators not described in the DT.

> Does this mean that the driver should register all regulators, even the
> ones not described in DT ? Who would read the state ?

Yes, just register everything.  Someone doing system debugging or
bringup might want to read the state, and this also goes along with the
ability to have the core pull the constraints out of the DT based on
data supplied by the driver - the general goal is to have routine
drivers simply register data tables with the core and need minimal code.

> > > +	/* Get the chip out of low-power shutdown state. */
> > > +	chip->gpio_en = devm_gpiod_get(chip->dev, "enable", GPIOD_OUT_HIGH);
> > > +	if (IS_ERR(chip->gpio_en)) {
> > > +		ret = PTR_ERR(chip->gpio_en);
> > > +		dev_err(chip->dev, "Failed to get enable GPIO: %d\n", ret);
> > > +		return ret;
> > > +	}

> > This one is more OK - it's changing the state of the outputs that's an
> > issue.  I guess this might cause the outputs to come on though if the
> > GPIO was left off by the bootloader which is awkward.  If there's
> > nothing other than the outputs going on with the chip I would be tempted
> > to map this onto the per regulator enable GPIO that the core supports,
> > the core will then be able to manage the low power state at runtime.
> > That's *probably* the least bad option we have with current interfaces.

> While fishing for code I can copy in the always unfashionable cargocult
> style, I came across max8973-regulator.c that handles the enable GPIO in
> the following way:

> 		if (ridata && (ridata->constraints.always_on ||
> 			       ridata->constraints.boot_on))
> 			gflags = GPIOD_OUT_HIGH;
> 		else
> 			gflags = GPIOD_OUT_LOW;
> 		gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
> 		gpiod = devm_gpiod_get_optional(&client->dev,
> 						"maxim,enable",
> 						gflags);

> Should I try to replicate that ? It gets more difficult with multiple
> regulators that share the same GPIO. That's why I left it as-is.

We should really factor that bit out to the core too, though at the
minute we pass in a gpio_desc so it's too late.  Doing the above is
probably best, though I wouldn't loose any sleep over it being missing.
you should definitely set the _NONEXCLUSIVE flag.  If someone specifies
an incompatible mix of settings in the machine constraints I wouldn't
worry about it too much, there's limits on what we can sort out.

--HN230c+fjCk4OvNj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHUXf4ACgkQJNaLcl1U
h9CAJAf/emvVn7bGWR/oxbvh1xYYw4nvP0c6jbImB4gyhS9G4lhnq0djJD8ruVDZ
nXUzmFEO68U/Hg6RdNsU4eKMWF9A87Nx2CXeu5vRXKUEy8cVJjom9fpQNva5JtE5
7sDsp3Kh4XmARcrg8rUPCY504JC3RL/3+IEDVzUmtBwWgVLAXJT6M5erv+FqdUqY
mHf4DDFIHWvp/EnwR4dpI7R4yRvnVxS/9x1f5oKVRietNnw0B1JoRK1r/56o2A28
/PBVlxPyZ6U827TNkDZcFbTvXzUsiY4o17kdPdt0OC+wRhb1K5fwxR3AgdJ4iAJv
itjKhq/mli20g9b+MO4xNQlfRmLj8w==
=mC/3
-----END PGP SIGNATURE-----

--HN230c+fjCk4OvNj--
