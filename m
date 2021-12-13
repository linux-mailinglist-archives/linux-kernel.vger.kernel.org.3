Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9764731E1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbhLMQfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:35:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39146 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbhLMQe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:34:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74AA4B811A5;
        Mon, 13 Dec 2021 16:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A8BC34603;
        Mon, 13 Dec 2021 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639413297;
        bh=wnOhd0uugHq1/ztVIeKV8oKWDawezTEWep8Ktuozols=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iHx90Veb6E2b1Q+kSSLbX8VMNXhEa0DEAnEw/GW5LThCYBLRa7Q2V6Vbab1p/pY+M
         nDhiVTWBs71CBj+zDFsHdOzRqez3TI1aT2s/qkV3Nzl/ym19lAN1qA9vg6n0B+w5VB
         S1Ln8hP4imkqRSiKwczKb/Gig80wHnfn/zU+TjExt6kxQmjETIcpEpT6gbv3qykYtM
         CGCSjtsdB450aT+uKty7RjCpr/O526BcnE8YazrC4JG+G8Mw1PzTt9TfNimgdG/nLE
         bGJot3ieeyL0tTN5Nokv36YggiKHbiaaa7IAJgYhrSr428y9K3AFkd/OQEFtt3nbRa
         qxqn/jUK3Eh8w==
Date:   Mon, 13 Dec 2021 16:34:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        ~okias/devicetree@lists.sr.ht, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: add missing pins
Message-ID: <Ybd2LMZ8+UqcUZTS@sirena.org.uk>
References: <20211211215120.70966-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vmxQrrQTZR4eGkiO"
Content-Disposition: inline
In-Reply-To: <20211211215120.70966-1-david@ixit.cz>
X-Cookie: No solicitors.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vmxQrrQTZR4eGkiO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 11, 2021 at 10:51:19PM +0100, David Heidelberg wrote:

> Add pins missing in documentation, but present in the hardware.

> Fixes: 0e826e867264 ("ASoC: add RT5677 CODEC driver")

Please don't just add nonsense fixes tags for the sake of it, this just
creates noise and gets in the way of people trying to use the tags to
work out if thy need fixes.  The commit you're mentioning doesn't even
contain any changes to the binding document.

> @@ -54,9 +54,21 @@ Pins on the device (for linking into audio routes):
>    * DMIC2
>    * DMIC3
>    * DMIC4
> +  * DMIC L1
> +  * DMIC L2
> +  * DMIC L3
> +  * DMIC L4
> +  * DMIC R1
> +  * DMIC R2
> +  * DMIC R3
> +  * DMIC R4

These clearly aren't pins you're adding, digital microphones use PDM
and carry a stereo pair on a single physical pin (which is what should
be and already is in the bindings).  This is adding an extra set of pins
to the binding duplicating the existing ones.

>    * LOUT1
>    * LOUT2
>    * LOUT3
> +  * PDM1L
> +  * PDM1R
> +  * PDM2L
> +  * PDM2R

I'd expect these to be just PDM1 and PDM2, assuming that that's what the
pins are called in the chip datasheet.

--vmxQrrQTZR4eGkiO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG3disACgkQJNaLcl1U
h9BZSwf+OOcBl5DrmVF88D9eLae6ah84DXOIEIStolvdAuNRSWnUdkm1RQ4G99zC
LBwG7K6/O6vcGdcGQ4JO2+r8MvFhGlQxs9cJAZOqBvUUXlZHJhS75Ki7N6Y95T4n
vOK5yRKGcBUEdTB6455YsppRqEkpNZ9XzCVzN3dLNZHvWUkGpAcRQCggDTfT6wBK
ApDK+YWsRjUCGboPu5k9COT/l2N36qSbkFoe8BVadhNBCKYMVqD1bhlgcUExqbU7
E4PkP5TOJZ7PKnIUx73lRSf7LfOrDU9sH06rvB2ER/hcwo2vwDlZxKNuMAyU9Bd0
5vu9vqUY+iaLxeDdxv66WH0IykLN4A==
=EMvB
-----END PGP SIGNATURE-----

--vmxQrrQTZR4eGkiO--
