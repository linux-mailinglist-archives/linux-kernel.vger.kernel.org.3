Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01314843E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbiADOzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:55:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38248 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiADOzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:55:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F207B8163C;
        Tue,  4 Jan 2022 14:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2375C36AE9;
        Tue,  4 Jan 2022 14:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641308102;
        bh=f3icQ/m7CajZ+VJvBYNNkvB5JOmyPouGV9LddxkO4UQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mgjFfOacSVcbUCgTqqwDxVkPATxlRDzMedwid53NvgthlGHoqpza1bq+kE3CFtGiv
         oGVozRaF/w7Psdby7hRishvp8i8uVMOLfSaL0D9aZk64RGUgUhuz04+d98C/00erzF
         GRlHz7cMGW3o2UgHaSQJpAh8ppClWSSva0GPUPTGQNPk4un6xp6KQViruy5HcNoZnJ
         pWPh43v/RYS64Nth7z0dXeugiyeU8KJFZUwNONVHuQatzS0Q0v4QZGM5mc3MBpPejY
         UjYF2TrBVxYWScn7yRaVknceWxRlqex4COFr+1OoZUbXW4RXXt4xY5fGt0YOvpQAQB
         5KGC2G5rKEXMg==
Date:   Tue, 4 Jan 2022 14:54:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Cc:     David Collins <quic_collinsd@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, swboyd@chromium.org,
        subbaram@codeaurora.org, Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/6] dt-bindings: regulator: Add
 "regulator-min-dropout-voltage-microvolt"
Message-ID: <YdRfwL9uQQd/0etr@sirena.org.uk>
References: <1637314953-4215-1-git-send-email-quic_c_skakit@quicinc.com>
 <1637314953-4215-2-git-send-email-quic_c_skakit@quicinc.com>
 <YZ+o9sQpECZSrieN@sirena.org.uk>
 <d828f2a1-03e8-d6ee-4ab7-39bf677093b7@quicinc.com>
 <Ya5VhkggWdjYyTHL@sirena.org.uk>
 <6a44cb99-6894-c9ce-4f1e-5dee0939598c@quicinc.com>
 <Ya97cnuwM+MuNMg3@sirena.org.uk>
 <23a47965-4ea9-5f6c-7e3c-27f5bd35f5b7@quicinc.com>
 <YbPCjbnH6cXQqy6S@sirena.org.uk>
 <012a0a96-ab0e-e844-12e1-f2272bf2506d@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aPEEkehX3JTCtWCF"
Content-Disposition: inline
In-Reply-To: <012a0a96-ab0e-e844-12e1-f2272bf2506d@quicinc.com>
X-Cookie: The horror... the horror!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aPEEkehX3JTCtWCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 03, 2022 at 08:05:40PM +0530, Satya Priya Kakitapalli (Temp) wrote:
> On 12/11/2021 2:41 AM, Mark Brown wrote:

> > I'd think we should consider if it's better to support this
> > dynamically at runtime based on load information and provide options for
> > configuring the peak load information through DT instead for static
> > configurations.  That would fit in with the stuff we have for managing
> > modes on DCDCs (which isn't really deployed but is there) and the API we
> > have for allowing client drivers to indicate their load requirements at
> > runtime that fits in with that.  That'd allow us to only boost the
> > headroom when it's really needed.

> This means Dynamic headroom control feature needs to be implemented. I need
> to explore more on this and gather info from team, Could we merge the
> present driver with "static headroom" for now? I'll do a follow up series to
> implement this feature.

I'd be happy to merge something with the headroom configured statically
in the driver like we do for other devices - I guess if you set the
highest headroom that should cover it.

--aPEEkehX3JTCtWCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHUX8AACgkQJNaLcl1U
h9BhtQf+L2r2wDroNeXGylRY4U6hq0q4A+rug1b0Z/Qvervdg9gBOKGNRqXnTnRX
nqzFmlgkbrxJj8c8l/awd4GSaKks6/isvYqyXVVz8jHTHAN8oQz0vfMJdfRZUCKN
fLJLckc/HgwVgHTZU9fTT/Z5sef9yJ426HwueHyhwmZkrBuBGCQisB7gncH/5QRY
Je3U4w6teDpA7tlWo7MRY+KUIwPbOAuTY0QzUbWJL3eR4T7Cw2hp8rU7HuawkpQp
4gkf6lZoTSkLcUpp+WDg7zJw7eRXseveFTFg+1DRFRa3TpgX7bHEy4K6rZgRGbVC
k6OcTDSmHWwuKQ2mPh/J5uWpKQOTSg==
=z85G
-----END PGP SIGNATURE-----

--aPEEkehX3JTCtWCF--
