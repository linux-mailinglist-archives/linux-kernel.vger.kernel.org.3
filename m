Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF7358C7EF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbiHHLyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbiHHLyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:54:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ABF1C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:54:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F87FB80E6D
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBC2C433C1;
        Mon,  8 Aug 2022 11:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659959669;
        bh=gLLzNBC05iprPlwsFTEWWLe63Y1mn8z9yVQgj/RVaB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1OVTS1K2SuOpQvoUPCB0kJJmwR1Ah+OPHp0GNrMWLJwMBwTkAlseYkzYqgSJuaKO
         5X5UbbX61IqK+KwIOEuXEpnShQz2DD6FN6So+2jnClg1qt5qIwGCmToFdBXDA8/VJy
         jdFIuXSk+Z/kYig7JtCsN2ELbzN8IrNfXeDdy1y4s2/6zcEAOVCgbuZwvQloVL96di
         6vJ2wPs8tnN4QTpJubTllf32xa451hUS/QYfHuJts2VFpZwkq1DtEf5PAbd5SgOehx
         G3YhecaIXVnyBBhqTmWH7H8DM6KBFPvIYmDxP8TDdN9yPeomtR0J41GhFCGR48HXh6
         TujpCbYWpWSTA==
Date:   Mon, 8 Aug 2022 12:54:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Niklas Carlsson <Niklas.Carlsson@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Niklas Carlsson <niklasc@axis.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: adau1761: Reset codec at probe and shutdown
Message-ID: <YvD5bqFHxB809zl3@sirena.org.uk>
References: <20220805222120.2560501-1-Niklas.Carlsson@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QSoF+Eq+pKrtRG4k"
Content-Disposition: inline
In-Reply-To: <20220805222120.2560501-1-Niklas.Carlsson@axis.com>
X-Cookie: Are we running light with overbyte?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QSoF+Eq+pKrtRG4k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 06, 2022 at 12:21:20AM +0200, Niklas Carlsson wrote:

> +	 * Steps for performing the reset:
> +	 *   1) Make sure that the cache is marked as dirty by writing all
> +	 *      default values directly to the cache.

Why?  If there's some need to mark the cache as dirty there's a function
that directly does that.  Note especially that a cache sync will
explicitly not write any default values to the hardware if it knows
about them.

> +	 *   2) Enable the core clock which is needed for writing all registers
> +	 *      except CLOCK_CONTROL.
> +	 *
> +	 *   3) Use regcache_sync() for synchronizing the dirty cache back to
> +	 *      the hardware.

We then need to disable clock control at the end (which the code does
but the comment doesn't).  It might be better to just have comments next
to the individual steps here.

I'd expect something more like

	enable clock
	for each register except CLOCK_CONTROL write the default
	disable clock

here, no faffing with the cache.  You could use two bulk writes to do
the writes of registers below and above CLOCK_CONTROL if that's the goal
in doing a cache sync.

--QSoF+Eq+pKrtRG4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLw+W4ACgkQJNaLcl1U
h9DIAgf/St4gbezlXWjOUtVNLyU45bFxcp/bmgJuUwKHbfGeX84Vnt4gJMG25HQZ
wYJq+DXne9HJbaAEY6qXv0weBS6gLauGixrohFxSF0dYCzdPRJr+BfjhCccfE8ud
YmPSS3pw/YOPqz2CW/cgnLU2a7vh/Ni3bIwae0MxA0s8HLqlBW15f9YRjFs/TRnb
aN5Ppv+E4CSWkmehMkv5IRteoxBXqwLJ/Bs8LjsjTg4wEf/nwLSgbey7+bSGmEj3
IevzZULaqlC5MmlomXpbxvIapvKasA/YThkIz688BYpafyvWFloT6nye/gMQ1tax
ktDGKoqaHCHQbRfp5ZomCpJ8QH5yUw==
=pwO8
-----END PGP SIGNATURE-----

--QSoF+Eq+pKrtRG4k--
