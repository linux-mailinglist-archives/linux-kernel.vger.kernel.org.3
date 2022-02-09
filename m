Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D614AF316
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiBINlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbiBINkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:40:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77251C0612BE;
        Wed,  9 Feb 2022 05:40:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3091FB8218F;
        Wed,  9 Feb 2022 13:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C501CC340E7;
        Wed,  9 Feb 2022 13:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644414047;
        bh=3izH2xKMbzlKuZeeR09BaMHcKFQb6mTIbAisYxILrNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R5+GVZWsVS9K0c9rUczxq0H362X5W5j8dQKXyXllUP06ewaw/T63iFv11NE1/Q/Zd
         lb77NZtgyWGedP9LIi9ErA1+AmTQB/WR28r/BhqlZb+J8bVWnadImO5xDRCbbEGZHi
         T4RqJx0zHJbcN13jCpOEm7J/3uLOGc999tcG2I/lX0AdJsRXcyHObkyE9WFoPTp+Cf
         jULqoIf1MAatF5u5Im3aKROzNjZg8hkcM8EJsub1HFGg7Wauq7Paih0VzsBPLgtOAV
         NWax5WDMhVA9imjNbwVbdfMVaf81mgha0PNLIXwaLBkJq+68hxKF4uIk3k+dzMtFCf
         6CDEb0i4AUapA==
Date:   Wed, 9 Feb 2022 13:40:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yun Zhou <yun.zhou@windriver.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ying.xue@windriver.com
Subject: Re: [PATCH] spi: disable chipselect after complete transfer
Message-ID: <YgPEWyEj7lbQJgAn@sirena.org.uk>
References: <20220209100042.22941-1-yun.zhou@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5jCZZYA68rLFpXRe"
Content-Disposition: inline
In-Reply-To: <20220209100042.22941-1-yun.zhou@windriver.com>
X-Cookie: Disc space -- the final frontier!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5jCZZYA68rLFpXRe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 09, 2022 at 06:00:42PM +0800, Yun Zhou wrote:
> If there are 2 slaves or more on a spi bus, e.g. A and B, we processed a
> transfer to A, the CS will be selected for A whose 'last_cs_enable' will
> be recorded to true at the same time. Then we processed a transfer to B,
> the CS will be switched to B. And then if we transmit data to A again, it
> will not enable CS back to A because 'last_cs_enable' is true.
> In addition, if CS is not disabled, Some controllers in automatic
> transmission state will receive unpredictable data, such as Cadence SPI
> controller.

This sounds like you've got an issue with mixing devices with and
without CS_HIGH - that is probably broken but...

>  out:
> -	if (ret != 0 || !keep_cs)
> -		spi_set_cs(msg->spi, false, false);
> +	spi_set_cs(msg->spi, false, false);

...this will obviously break cs_change support, clearly that's not OK.
The last_cs_high should be moved to the device.

--5jCZZYA68rLFpXRe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIDxFsACgkQJNaLcl1U
h9AC5gf/QnfdqF4bxfMlcz/+CEL3cJsquOhbXqelLfIGLo7xhpl5E2fYklnxH7oI
JskQEzXWCEHUndus0bQ4Cpz4NCoP/u2jseFdUcp8pw4dtqEHU4xEAN6lE36rKX/X
gHhnGO17RjkH4ob4dG7wKBbBflSmSTEwVkgHZ4yfj3x58l2GYBnltI8OTZsOP1c7
fnoPeV3otEr7hJ4TuB/u8JuAk2lja359T4zFNk/mcz2tFK/hqdu7Y7Bses89sRn8
Lia7l+LJhlHtDCbwBYEY6JEP8evFE9LPqwP51g38qlzFp4FDyc7vp2nEa7dmSpad
5xAH7YF2ykqoH/VyKtnhl4F0PuxSYA==
=9k4w
-----END PGP SIGNATURE-----

--5jCZZYA68rLFpXRe--
