Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD0C4D3811
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbiCIQut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239799AbiCIQdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:33:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E8A6E540
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:29:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C135619B9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011F0C340E8;
        Wed,  9 Mar 2022 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646843315;
        bh=DS+oE04kyudFCTkstsu3g7zMI59LZmfzAO6EZZPQtMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A8MCJiFHiTQWbtViiT3H1FPZssWaHXuBwm5R+INyosPJDE7Pdmj0pP5w/FCak4VwF
         OYSfBRV5tj6FUUDnHFmJ4t8tCs5h+qCnDXJHVu00d9wH4oFyqh/LyWEXGCumqC2Mml
         9VRks5GfifmeJGjVBRzlXQbLWESutw5NTVOh1h8ExebetxR9iBr6oOHy4ON1mO+vM1
         fNNPusfql4JD/p3fX9QV5A2yzd31R3i3AWaj+l1PPDBxmmkRW8JyttRppFJbirtjb0
         7Edg8SAid7J21LXqUpoRyFw5Rpj6G6T2o8G1cXqL3YhqUmRJxcUa5gHymRYJEdzKBx
         Ej/IoEqYRkNYg==
Date:   Wed, 9 Mar 2022 16:28:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Keeping <john@metanate.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: tas5805m: fix pdn polarity
Message-ID: <YijVrgZ+Ysv9J/8E@sirena.org.uk>
References: <20220309135649.195277-1-john@metanate.com>
 <YijOHNT0eqDyoviP@sirena.org.uk>
 <YijTk0/UTXpjFiRq@donbot>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cL1aqbfsnd4ieXht"
Content-Disposition: inline
In-Reply-To: <YijTk0/UTXpjFiRq@donbot>
X-Cookie: You will inherit millions of dollars.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cL1aqbfsnd4ieXht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 09, 2022 at 04:19:31PM +0000, John Keeping wrote:
> On Wed, Mar 09, 2022 at 03:56:12PM +0000, Mark Brown wrote:

> > I'm still not seeing the functional change here.  The actual state of
> > the GPIO is identical in both cases, all that's changing is the logical
> > view internally to the kernel.

> Ah, sorry, I'm considering it functional since it changes the device
> tree ABI.

> Used with the same device tree with, say, GPIO_ACTIVE_HIGH the physical
> state of the GPIO will change as a result of this patch and the device
> tree needs to be updated to use GPIO_ACTIVE_LOW.

I think the device tree binding needs to be clarified here to be
explicit about this since there's obviously some room for user confusion
here.  We can probably get away with a change at this point since it's
not hit a release but we do need to try to avoid the situation where any
other implementations use active high polarity for the bindings.

--cL1aqbfsnd4ieXht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIo1a0ACgkQJNaLcl1U
h9CyUAf9Exxd5mQWala73V08LmWHXe6yGnuDEkHamyXdTiMDrKyxL2PYq6hwaykr
PCFp/rVwWTvXeB8BkEPJ2MJzpatF+uhcZBPcK3eFTPDXY/goBWNsYzSOzC+a3ahe
PgUv4Gf92Z/RR5OFKraL/lkTVaQB975Nraih9gXu4SUBtC91cKPKuAXjSXzEWAgl
8rgrqlnZ7AK6p+GIkIfhx7IyvxIy1GoC5z5anJsZRyo9T6UlLsj2TywkM7aAPaML
5YVZg5qoP650il8F2FiCxEiZYKM/tQEu5k19NEtGgl2XUP2mYyEGKKG4TcXqoej/
9FONTmDDbDyQL3EYy+B4NIEcNzdfcA==
=bQ22
-----END PGP SIGNATURE-----

--cL1aqbfsnd4ieXht--
