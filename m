Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CEA49FB0C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241406AbiA1Nsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiA1Nsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:48:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980EBC061714;
        Fri, 28 Jan 2022 05:48:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61ED3B825A8;
        Fri, 28 Jan 2022 13:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FB9C340E0;
        Fri, 28 Jan 2022 13:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643377729;
        bh=9sYtw3ou3lxpIW87228egdqTk/22E+Frt1X3mgjYsKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvvTuGOKNZD1wmNC3hWhWYNLQgllvxLkQQeomJ0AtiVzEf9hZrd+gtSiPl16EcNQI
         6lcyz7VDpfXU9o47agF2TTBPeCZHR7DKsW2qMOZHZER7v/X4lY0OdHyQ1pV8NOjB64
         wAMtg1Ivw5Nl86cFY9NhUckO05ARwD5muNA3ylrxCoRt4fBeiajN95Q9YsbuN0VX9V
         HIOGLSEAgiNmdZJe8uw5iFlvHs8MzgG6GaxmmJXPQhSdx4CLCqEmrCy9EGzyqYzlzL
         5LWw9wvlxzlGbqM352nm5yeOacH14MBs6ORpaX8bOejAMX0xhlCBusTYLbrBHw+Ryo
         PI/T0JnHOAofA==
Date:   Fri, 28 Jan 2022 13:48:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: ops: fix signedness bug in snd_soc_put_volsw()
Message-ID: <YfP0PGbyFVDOevIH@sirena.org.uk>
References: <20220128112007.GA24806@kili>
 <YfPknO6si9CpotgS@sirena.org.uk>
 <20220128133147.GL1978@kadam>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8ra+G6TvYIugz+90"
Content-Disposition: inline
In-Reply-To: <20220128133147.GL1978@kadam>
X-Cookie: Torque is cheap.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8ra+G6TvYIugz+90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 28, 2022 at 04:31:47PM +0300, Dan Carpenter wrote:
> On Fri, Jan 28, 2022 at 12:42:04PM +0000, Mark Brown wrote:

> > This means that the helpers won't support controls that use the top bit
> > of a 32 bit register.

> Fine, I can delete the checks for negative instead (I'm surprised you
> haven't already received a dozen bot emails about this).

No, we need the checks for negatives since userspace supplies a signed
value.  The check needs to be done on the value in the input structure
before we pull it out for mangling.  I probably got bot emails but
frankly these days almost all of them are some combination of barely
legible and misdirected and there's plenty of people who like to fix
these things if they're real.

> I haven't been able to figure out where mc->min/max are set.  In

They're the big tables of static assignments via macros in the drivers.=20

> snd_soc_get_xr_sx() it checks whether "mc->min" is negative.

> 	if (min < 0 && val > max)
> 		val |=3D ~mask;

> Is that a bug?  If mc->min is negative the math gets tricky.

No, it *is* valid if weird to have negative values for some controls.

--8ra+G6TvYIugz+90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHz9DsACgkQJNaLcl1U
h9AWswf/Uivc5XoK7qn+bLn7KmCk9wj+9FesEqzeNZefSTZKf0+7q789y4ZJNr0M
T4pWgRgBuKoOtQsDSl5z00yLDloQ7SZ2fVptrLMSEjLds6fy6x6euDhmCt7Va2GY
jlIQp0ZOipUAFUfmH8i53eqd9J40mELJ1E0Iy8ZnC4MSuClouzPNSgk+BqIU4DzV
haVR2JnDiYTKKeOcNrsEGOGTuVkm68JANwjsrsx2ZhgdrBhURwB2CMDWb9RhNLXD
m3zs76Rw62peY/wsVr/6PiPqxbDB2D99yleLU2KR4hoHQGk4dCJOBTf/IQT4Zd6l
majtHP4B8506iCwaMqZ7BHJ4A2CR6Q==
=qRg9
-----END PGP SIGNATURE-----

--8ra+G6TvYIugz+90--
