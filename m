Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5BA4FE1AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354945AbiDLNJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355075AbiDLNBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:01:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB3110FE0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:39:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 652D1B81B5D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2E3C385A5;
        Tue, 12 Apr 2022 12:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649767152;
        bh=r2ozEyixlXEDZat/EBQhfhK+ZomNGZGTkYgMhu0q//o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tICf7t/usfMJ3yYnlwiUXvo2DF7Ir2NQvHctzBOGx9VT1QWTJTGwyd0vh20t+G1R3
         PQUzUs8wtg/wGOk40U9mv5kBJTmOzy+MkaoZaEikB7WIO1//gpBd2COJ6mUC1oMzHc
         8WJ1jI+wZyA89GRepoT6oLrif0LehgCcGgIi0LCXehaLse62X4lQayHTo+TYHtwI31
         kQaAumEWDrmUoiIkfYoP9yno2R+lFVCoYwD03P+GpyR0xcaw4g3Fseh+SSA7tgldFt
         TrcNtJXSNPvCTilN2+i27EToYjuOlH8GLVbyHSZVxard92WHC/mszVRl7dHSES+HkD
         kW8765DMjFVRQ==
Date:   Tue, 12 Apr 2022 13:39:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com
Subject: Re: [PATCH] ASoC: wm8524: remove rate constraint for FE-BE case
Message-ID: <YlVy6tAPMw+MHq/f@sirena.org.uk>
References: <1649754826-2651-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LwWF2GkpX7AfLGu/"
Content-Disposition: inline
In-Reply-To: <1649754826-2651-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Approved for veterans.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LwWF2GkpX7AfLGu/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 12, 2022 at 05:13:46PM +0800, Shengjiu Wang wrote:
> The constraint is propagate to Front End Bitstream
> for Front End and Back End share same snd_soc_pcm_runtime.

> The constraint is not needed for Back End Bitstream
> when there is be_hw_params_fixup() defined.

> -	snd_pcm_hw_constraint_list(substream->runtime, 0,
> -				   SNDRV_PCM_HW_PARAM_RATE,
> -				   &wm8524->rate_constraint);
> +	if (!rtd->dai_link->be_hw_params_fixup)
> +		snd_pcm_hw_constraint_list(substream->runtime, 0,
> +					   SNDRV_PCM_HW_PARAM_RATE,
> +					   &wm8524->rate_constraint);

This applies in general to constraints set by the CODEC, it's not
something that should be fixed at the driver level.  Peering into the
runtime to see if DPCM is doing anything isn't a great solution here,
nor is having to open code it into the driver.  I already had it in the
back of my head to generalise the set constraints based on sysclk
pattern into the core, that might be productive here.

--LwWF2GkpX7AfLGu/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJVcukACgkQJNaLcl1U
h9DK0gf8CiRXWJm7/sW3H5tgx0lkpjF5i+wEkbvG0c1jAoEOwr5nKr3568cS0R4L
4E8czDxBzq2KOgznS7d8uoIylxzFppv/nJaWh6E+qCuOwhIOPmvQnPa7Vce5M4JW
hZa82ypUj3Nn3ZfCYh4L0Re3I4pS2OT6meuXBroHso0+hUmjVtWLpU64+yHlH2YI
C49SoR3GdWwcWHcccdmkAlojQuhqn2Y/OCNww0ptvxiw/rRoRnYyxKmKUd6O9bRw
pIaIxQAn9263ywhW4uhTfLnB1uXQd0XiXGKllIIb45ifASOIm6nUDBdnvembqVxc
V7QB5yNHTY07UQ8vpynHiAGfqS+pYQ==
=Sl43
-----END PGP SIGNATURE-----

--LwWF2GkpX7AfLGu/--
