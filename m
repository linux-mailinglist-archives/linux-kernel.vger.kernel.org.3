Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F071A57F122
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 21:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiGWTXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 15:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiGWTXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 15:23:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE47F15721;
        Sat, 23 Jul 2022 12:23:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A24CEB80D30;
        Sat, 23 Jul 2022 19:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9BCC341C7;
        Sat, 23 Jul 2022 19:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658604187;
        bh=akajAUG1QC/XKyQpsuifzMWjlfcK/HopTgtr+xNmlZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Af6Z8/xGb8u65JNORPb435b/4lNHaNKVO7S24xEsFsUyyo9q+0wE3CAgcZFpbBUtB
         1UjeuQ+7YeD71zp8R3JJmCY+l4szIJUCm0bVp5TjX3iLpkf13ohbbYj8ESRE57THv8
         GVCmtX/1K92I8r2J50h36h9g5SKxqlJkWE7XZC/HOyVkzp42yPma/NpCufyy6fLC9l
         KDmHzkTXWBx3KiD67JSz36IvB55L1HqnuDAgiBnZgVcb+om4l3ZQxTPJZdf69hGrAw
         SFkwuJ64vfmu4E57TQxge/uYIDm4X0LTaQOtY1qgv5kbDAXPGTo3YvEp8d/Q2AJqek
         qaGJe4sgUVdiQ==
Date:   Sat, 23 Jul 2022 20:23:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] regulator: core: Allow for a base-load per client to
 come from dts
Message-ID: <YtxKl/GRKGZJwNN/@sirena.org.uk>
References: <20220721182622.RFC.1.I8a64b707169cfd73d9309c5eaf5d43b8bc4db988@changeid>
 <Ytrq2rVMHqedv4+3@sirena.org.uk>
 <CAD=FV=U-qZQwRdLA8AVwYdcuj_PQEULTnhm3osFybaFmtvjmHg@mail.gmail.com>
 <YtxHwUe4W7+u3Lk3@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6mXHQkzeOVkfm08V"
Content-Disposition: inline
In-Reply-To: <YtxHwUe4W7+u3Lk3@sirena.org.uk>
X-Cookie: Necessity is a mother.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6mXHQkzeOVkfm08V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 23, 2022 at 08:11:01PM +0100, Mark Brown wrote:

> The more I think about this the more I think that what's
> practically going on here fits better with the mode interface
> than the load one, normally I'd not like doing a run around the
> abstractions the underlying thing is offering but it really does
> seem like someone has to bite the bullet and do that runaround
> and it's probably going to be less work all round at the
> regulator level.

Actually thinking about it even more for most cases it may even
just be that we need to add some number to the load request while
the regulator is powered on, the existing system-load property
would probably do the trick here if putting things in DT.
Depending on if the firmware counts loads from things that voted
off or not the driver might need to do an update on the load when
enabling and disabling.  That is less of an end run around the
abstraction, though it does cause issues for the system-load's
intended use so perhaps a separate property might be safer.

--6mXHQkzeOVkfm08V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLcSpYACgkQJNaLcl1U
h9CpwQf9HmNPRo3NQ/JbDdeqQ/4n6RntC+qmeA+2T+RZUxCVJl0DPdFSrrpyEXbj
dlUkbzGRSrMxjlge+9K9dvglDwtoMGm/jREidvqvfGCC+X/6Bff8GRpwMPPHLCVC
WV/r5xz2Np7uwgBRh+BKNVCzLHbkSM58ei++hbRimsblzV62V5UKpOW8hp4Hmu+/
4SFG2vc8sZC5mCay8N1mtm2Ymm2J8TXdnMqqtxkjPxooaxwpE2bYMxOZJA3T/u/U
vXOJCoGBoANGaydosb4yLiFm+79OVeKn5BgcZEzTBksXV+r/eSr1/hq24dP8+bbi
NqVyNT+O5Syg8lpiD1P//c21appptw==
=QfC+
-----END PGP SIGNATURE-----

--6mXHQkzeOVkfm08V--
