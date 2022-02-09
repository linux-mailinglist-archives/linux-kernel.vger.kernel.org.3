Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF7D4AF7C4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbiBIRFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237954AbiBIREn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:04:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96B9C05CB8F;
        Wed,  9 Feb 2022 09:04:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D3EEB82335;
        Wed,  9 Feb 2022 17:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66F2C340E7;
        Wed,  9 Feb 2022 17:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644426281;
        bh=GIkXNhz8oaOhqayCMzeE+28iutBSWhbxVronQYj/VYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tCWo92E4pLzlhQ6+xw81c43ydmZ9VGDk3KYy0l4f2x1rEnxiTOQzHtHSL+gD+hvLI
         BKB3Qzk9TbUSCIqXbCCYTAJFyc08OjHniWuHlobEremDJC+/3FwW8T5XkQZMkAOe2/
         V8WUILhcW5eiiA6CdwH+0PU3Wc/ZeIda9OuWbhGPba4AvOEaHInI5pdoQcoUoS998B
         0Rph2FYKB8xILFyT5bQj/mZjh2GQusPzZGUwzSi/zsCAi9DTnEMdTEuvgoCmqknQUG
         GEvvO0zYlqV6OpihOcQg1nJ60m0M6tjoUELV2TPXqmjQbbvhYOoe/5CnhD1z5kl7eb
         Mo+tITmGebotw==
Date:   Wed, 9 Feb 2022 17:04:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     lhjeff911@gmail.com, nathan@kernel.org, ndesaulniers@google.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] spi: initialize ret variable
Message-ID: <YgP0JOilWpKU4704@sirena.org.uk>
References: <20220209163029.2299009-1-trix@redhat.com>
 <YgPs8U85ZFbDWYlx@sirena.org.uk>
 <61a545d5-224d-86fb-2fe3-406c3ffd78fb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LDdwV0VGGqx5cXxo"
Content-Disposition: inline
In-Reply-To: <61a545d5-224d-86fb-2fe3-406c3ffd78fb@redhat.com>
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


--LDdwV0VGGqx5cXxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 09, 2022 at 08:44:21AM -0800, Tom Rix wrote:
> On 2/9/22 8:33 AM, Mark Brown wrote:
> > On Wed, Feb 09, 2022 at 08:30:29AM -0800, trix@redhat.com wrote:

> > > Clang build fails with
> > > spi-sunplus-sp7021.c:405:2: error: variable 'ret' is used
> > >    uninitialized whenever switch default is taken
> > >          default:
> > >          ^~~~~~~

> > > Restore initializing ret.

> > Are you sure this is a good fix and that the compiler hasn't instead
> > identifed that we should be returning an error in the default case?

> If setting mode to idle is not really a valid state, then default should
> return an error.

Yes, that's what I'm asking.

> The old behavior returned 0 and I am treating this as a regression.

The goal here isn't just to shut up warnings, it's to fix any problems
that they identify.  Unconditionally initialising return values is a
common way of fixing warnings while leaving real problems in place.

--LDdwV0VGGqx5cXxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmID9CMACgkQJNaLcl1U
h9D1pAf/SvFPCFoqJZgZ/loB28nIiwS4C9v290MFima/UTb7p3sdg9OudfxI543q
Ht6y3f4vnCe3+BPqM4JSfeetuuDBcbHihhhMUUe8gucz9vsMV70O5uTcQneTHA8a
KcNRt2ZpE/TUwZSr8SvyzQ/I8FKpyDSoW796eknGdXue1YpKDKO03RrbKXRcy983
H1DhiG7lppE3D2eh1R0xRsf5tVIzryeruIbbQzZSxi/fGvo6XxUcJ2CRrN7ib2cl
6uoFbFkHxJo3o385Exv6TwDyFmhrLYjGYDCxV0iUfYTwlEZpBupv7+sHqd+KBbLo
LkQ/wHpMaWHZfmN5sQ4wieDHJHBplQ==
=+R4u
-----END PGP SIGNATURE-----

--LDdwV0VGGqx5cXxo--
