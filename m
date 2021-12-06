Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3231A46A3F7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346897AbhLFS2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:28:54 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58528 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhLFS2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:28:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3291BCE1760;
        Mon,  6 Dec 2021 18:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D796FC341C2;
        Mon,  6 Dec 2021 18:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638815116;
        bh=8hgFqVDYqzqEOgGOxfFzJHvOC45GyBzsr6kNeWt9iz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f/eBltJXoHicFKqe0ZEc8lbxaMDeyYtqqyGYikXOeCgIZ0Z+C8Wrs8t6hnphD985Y
         RT6cPbqxnXMrHRAs+IfEcf4jscZ+HRW0+kHHnqyve5q42KdUHoZY1C1iVwtSaevMCS
         d0RKqJet9x4VPHLqbyne83vwP1ucXL1PIuVj3zzKMQ8OOPVbXc6sCzK9WnpN/rgqM9
         N2VKaj52QdNAmVvmLZFS3PoPTonTJMsGDdnagiLkL25iLkcxUouCRGP/2NOxNDYZ7M
         CtOEqE1iqJKaicNYmfU/+e5e0MyD4Xk2bnpIjw6wiZcHJ0f8wR7KopEZLUVXBWvqHZ
         NdddEoaS5fKPA==
Date:   Mon, 6 Dec 2021 18:25:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, swboyd@chromium.org,
        collinsd@codeaurora.org, subbaram@codeaurora.org,
        Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/6] dt-bindings: regulator: Add
 "regulator-min-dropout-voltage-microvolt"
Message-ID: <Ya5VhkggWdjYyTHL@sirena.org.uk>
References: <1637314953-4215-1-git-send-email-quic_c_skakit@quicinc.com>
 <1637314953-4215-2-git-send-email-quic_c_skakit@quicinc.com>
 <YZ+o9sQpECZSrieN@sirena.org.uk>
 <d828f2a1-03e8-d6ee-4ab7-39bf677093b7@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QXyE3CVvg7TRqRac"
Content-Disposition: inline
In-Reply-To: <d828f2a1-03e8-d6ee-4ab7-39bf677093b7@quicinc.com>
X-Cookie: You will soon forget this.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QXyE3CVvg7TRqRac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 06, 2021 at 06:33:26PM +0530, Satya Priya Kakitapalli (Temp) wrote:
> On 11/25/2021 8:47 PM, Mark Brown wrote:

> > Usually this is a fixed property of the regulator rather than something
> > that varies per board - why have a DT property?

> The min-dropout value (headroom) varies with boards, that's why we have a DT
> property for it. We overwrite the default value in driver with actual value
> read from DT

Interesting.  How exactly does that end up happening - presumably other
systems are going to run into it?

If you do have board designs which somehow managed to introduce
additional dropouts (seems pretty concerning TBH) then I think the best
way to handle that is to add a generic property for it and have that
either added on to or override the requirements of the regulator itself
which should continue to be defined in the driver.  That way only boards
with issues need to do anything which will avoid bugs with the property
being omitted in what should be the common case.

--QXyE3CVvg7TRqRac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGuVYYACgkQJNaLcl1U
h9C3WQf+K77xrkRiIBmIBf/V2boYm9+lY/DGgIZHn5D9szW12BeI8WtJy/UvUoQ4
DXiAYZlHtTtYQ3aWxTvsOlkAcd3TDMzrAH2sOlwmOUc4zdjr+2cXXxyLt6VtNIpq
cISFU5qK9dpEgufmbMsZG+rDd5lQn4pwIy93Kj0yaANprvAyRGtTUH4K7SqFxIR7
PK9L2IwRIcI8yQZlb2GTetLhJ6zmSl81QSFSHHOYUGPCBgERJQR1tD1xKkmh/TAf
zTt9t9r27QfwuOHnlApBE3foPBWBNE4Xvx8UIXvth7sB4tePKP4ei+W2m19AaiDk
UQJo2djCLIZXswbGQk+9Mn1xGicstQ==
=+APw
-----END PGP SIGNATURE-----

--QXyE3CVvg7TRqRac--
