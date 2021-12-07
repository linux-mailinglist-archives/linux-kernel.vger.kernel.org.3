Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05AF46BF23
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbhLGPWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:22:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42066 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbhLGPWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:22:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55D69B817F8;
        Tue,  7 Dec 2021 15:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90020C341C3;
        Tue,  7 Dec 2021 15:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638890360;
        bh=fctYRvx/RrWaE6WyeVlP0Ne2GLqV8vvgYBBwpJcigpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PHodWGuNlHOXU9Ir0tGV2WnHg+XwCu7+N3C/6Zz/mRAkn97KllBfp0lj1iB4cTFKO
         pYkhQF2wAQTK3sUJjzH/8cRalrPwItFkN9E/yVm1l5bD0TdZeepjAlz52T7AKUKay8
         b6+GiWo10J5fD7BujKTxWjJgycW1PDCTY8WewsSWGludm3sTNKtUpk14dzwmcGtCA+
         yvuEJhEedTL09RxMc7TbBFGl3vrWZjpWST59nhnJC1Vvl/jFhWvhvjWEjOZvHU2+yi
         LlPi3GZcZDpeCKsaujLL8V/dHMXaHteiT6JWhSGKl+mWSEp9ZdFee75flcnFVMH24j
         2KZbJ4Mv49kOg==
Date:   Tue, 7 Dec 2021 15:19:14 +0000
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
Message-ID: <Ya97cnuwM+MuNMg3@sirena.org.uk>
References: <1637314953-4215-1-git-send-email-quic_c_skakit@quicinc.com>
 <1637314953-4215-2-git-send-email-quic_c_skakit@quicinc.com>
 <YZ+o9sQpECZSrieN@sirena.org.uk>
 <d828f2a1-03e8-d6ee-4ab7-39bf677093b7@quicinc.com>
 <Ya5VhkggWdjYyTHL@sirena.org.uk>
 <6a44cb99-6894-c9ce-4f1e-5dee0939598c@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wBCGZT0RnMtSoNVm"
Content-Disposition: inline
In-Reply-To: <6a44cb99-6894-c9ce-4f1e-5dee0939598c@quicinc.com>
X-Cookie: Only God can make random selections.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wBCGZT0RnMtSoNVm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 07, 2021 at 08:36:11PM +0530, Satya Priya Kakitapalli (Temp) wrote:
> On 12/6/2021 11:55 PM, Mark Brown wrote:
> > On Mon, Dec 06, 2021 at 06:33:26PM +0530, Satya Priya Kakitapalli (Temp) wrote:

> > > The min-dropout value (headroom) varies with boards, that's why we have a DT
> > > property for it. We overwrite the default value in driver with actual value
> > > read from DT

> > Interesting.  How exactly does that end up happening - presumably other
> > systems are going to run into it?

> The parent supplies such as "vdd-l1-l2" are coming from other pmic
> regulators, which are shared supplies with other subsystems like BT, Display
> etc, they vary between boards as per requirements, so we cannot expect these
> to be fixed and so are the headroom values. We get the headroom values from
> PMIC systems team for every target.

I don't think you're talking about the thing the code is saying it's
describing here.  The regulator API is referring to the minimum droput
voltage that individual regulators require, that is how much higher the
input to a single regulator must be than the voltage being output by
that regulator.  We absolutely can and do expect this to be board
independent, it's a function of the design of the regulator.  Sharing
the input supply has no impact on this, the input voltage that the
regulator needs just get fed into the requiremnts on the supply voltage.

If there is a board specific constraint on the minimum voltage that a
given supply can have then that should be expressed using the normal
constraint mechanism, that's nothing to do with the headroom that the
regulators require to operate though.

--wBCGZT0RnMtSoNVm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGve3EACgkQJNaLcl1U
h9B7Agf/XDDb6c6/9M+MoaUKtk/AIlGQEMwXaYgUNvp8wPziPU9VZOJ+4IY7f0cP
qk/t0N+G8z7kZcf0Kw7y31Glxszy5oO8Sk1219v8YpRqKyD2S1BRp7SHbiZCucX+
ZUgCOHXKWHWsNDqIbBRPqOW+jGuTT7KqT48PpTz5GDw/FLye2oRXQgWEPncip+8e
JJyULFQ9WO0QmQJ+Xh1LVRT44npRp7DQAZiWAPL9AT/tsIEP0RF1te/fK0CrtGGe
FJcjz+wQAUNOFi/WRJJ+iXTwNYhkYuVJzsPEd1yf3ORPSskpf38Pik4bjKaKaxoX
fKrIyK60tucjGjTowAXkLxtGvewy5w==
=z/Nb
-----END PGP SIGNATURE-----

--wBCGZT0RnMtSoNVm--
