Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B758258EB98
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiHJL5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHJL5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:57:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C947B82F85
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:56:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 658166131B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 11:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2D1C433D6;
        Wed, 10 Aug 2022 11:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660132618;
        bh=Q+3zp31hm5us8Ragge3GmJnAbYvcTWom+L06uIt81xQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CFSziIEZLnm/D4Tz79y/kG179fXxpyvPav5hm9gB6eWoKJKdJdLLTYv/w0+4BFYNy
         hHYXwir5DsgYL3iC1GiYC2lqXJYhpII6MB7P/Z63tjrjff7NjL0ZHkiWu72H/blkDL
         WJX7Wr6sB1wqGW9hPuXd97MzDSBVMF8YT5pwCfCZUBu02d7L5VkuDngOxATZhNBXzv
         TM033L5y0ii7BzCcOLeL/5WQxDgbETvAWBDpmoN1R4B4mOvzINr5qLa9htLR6vUV85
         apIR40tm1f/7UEOXMnZSsbkZmwNHcA1eBLYc1oAD+ow70T1ipP0LITBpneIcgJ/aHV
         nWIAf0ZrUtsHg==
Date:   Wed, 10 Aug 2022 12:56:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     matti.vaittinen@fi.rohmeurope.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/7] regulator: Add devm helpers for get and enable
Message-ID: <YvOdBv0edrE3wKsO@sirena.org.uk>
References: <cover.1660127865.git.mazziesaccount@gmail.com>
 <b6058e052b842a19c8bb639798d8692cd0e7589f.1660127865.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VEGw3rzY/Fe5v0a/"
Content-Disposition: inline
In-Reply-To: <b6058e052b842a19c8bb639798d8692cd0e7589f.1660127865.git.mazziesaccount@gmail.com>
X-Cookie: First pull up, then pull down.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VEGw3rzY/Fe5v0a/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 10, 2022 at 02:29:55PM +0300, Matti Vaittinen wrote:
> A few regulator consumer drivers seem to be just getting a regulator,
> enabling it and registering a devm-action to disable the regulator at
> the driver detach and then forget about it.
>=20
> We can simplify this a bit by adding a devm-helper for this pattern.
> Add devm_regulator_get_enable() and devm_regulator_get_enable_optional()

I'm really not keen on the idea of a devm managed enable, it's too prone
to bugs when someone gets round to implementing runtime PM.

--VEGw3rzY/Fe5v0a/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLznQUACgkQJNaLcl1U
h9AIzAf/X+NMPhyskNdOzwuTnf5JL6aMQ/zaJRQZrPj3HWbXUBsD0zo97kgordwT
xkKmtSRvixezeA+CvEOIQcJTc4myiLxOqbNWgpIw2D6bDv5ZzFD18c2GB7MsOf7Z
VKmzH4HK130qf5qvo5FrxC5EIRebiP7q4V49x8wqqVkLxhQdQLJlKZ7ZW5mNS3oE
jwIoux8+lnmNOOEiQQ+GlC7YhhxDcsh/5JcVE/5b+qMnKW12a3coAmiq+hEHoI9/
A78vuODzf9JCgfiSC/4d/ZKIDs+pQsCsMSXRKjisGY2pN9AE6va2pRQeCLprtHqv
FqlouA068TRQb0FlIu7vPYJ4YAuETg==
=7Hrc
-----END PGP SIGNATURE-----

--VEGw3rzY/Fe5v0a/--
