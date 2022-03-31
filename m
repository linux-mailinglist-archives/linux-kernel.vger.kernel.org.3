Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A04B4ED9B0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiCaMgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbiCaMgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:36:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9334B4C413;
        Thu, 31 Mar 2022 05:34:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DE4DB8211D;
        Thu, 31 Mar 2022 12:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1CEC340EE;
        Thu, 31 Mar 2022 12:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648730068;
        bh=RsQR6UjFWzyPEHFbDeMqA0h1nKTqnLcrPhy4Z1sufr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GpbWsMyd5SCgjUxFmcZWvbXkh35ejpYCRk0oMjvUbK4aeUKC0k8GcCAU02vbXjsXz
         0bnz/E2sF7brvDyzxg+B8D15PRCQzQmj3J8+DaFS1l4mxk9Rhev8Gqq4ZvXSKgR/K0
         pdhvYEI0pGVCw44PetsD7eqms/EmkrP432hH5cuvCSJOeI/lT1VjcYoNIUPOmFqd3S
         e3y8M/n8tVTEm24rNGBfqj+KWwXcL9rcOrr9AmX+GOyn1ukO3+aY8ZFvAoe9gDMy5v
         5MkwTXUHlF00zBbvrXn7U9dlej4FZw59t6h0PbhBzdC/em55buBD3efZtVHg+MrntJ
         sQFyQrf3Q9ZxA==
Date:   Thu, 31 Mar 2022 13:34:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>
Subject: Re: [RFC PATCH 0/5] Apple Macs machine-level ASoC driver
Message-ID: <YkWfziQzprEsWL72@sirena.org.uk>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3w0XWtrOW4Hfhq/l"
Content-Disposition: inline
In-Reply-To: <20220331000449.41062-1-povik+lin@cutebit.org>
X-Cookie: Reunite Gondwondaland!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3w0XWtrOW4Hfhq/l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 31, 2022 at 02:04:44AM +0200, Martin Povi=C5=A1er wrote:

> I put together a machine-level ASoC driver for recent Apple Macs (the
> ones with ARM64 SoCs) and want to gauge opinions.

This would be a bit easier to review with a description of the hardware.

> Commit 2 adds a new ASoC card method (filter_controls) to let the card
> prevent some codec kcontrols from being visible to userspace. For example
> the TAS2770 speaker amp driver would be happy to expose TDM slot selection
> and ISENSE/VSENSE enables which is ridiculous. I am all ears on how to
> make the patch acceptable to upstream.

The broad issue here is that what you consider ridiculous someone else
might have some bright ideas for configuring dynamically - if things are
being exposed for dynamic configuration it's probably because someone
wanted them, if the control is genuinely useless then it should just be
removed.  Rather than getting in the way of people's policy arguments
about how to set things we expose them to userspace and let userspace
worry about it, usually with the help of UCM files.  The general
userspace model is that people interact with their sound server more
than the hardware card.  This is also helpful for people developing use
cases, it means they're not having to get the kernel rebuilt to tune
things.

The TDM swap thing you're mentioning looks like it's a left/right
selection which people do use sometimes as a way of doing mono mixes and
reorientation.  The ISENSE/VSENSE is less obvious, though it's possible
there's issues with not having enough slots on a heavily used TDM bus or
sometimes disabling the speaker protection processing for whatever
reason.

--3w0XWtrOW4Hfhq/l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJFn80ACgkQJNaLcl1U
h9AgOggAhaQ6MuCNl7L/md1tarO7n6iReHCzBcOCtSc6T8vIiDTatsSdqb4mHmkZ
jeeF4LCTvo+tb01vzCqHVStd4Pz5dMRv+3F8lI6ODG3g16Tv+E1CKQeIGkVM6VJN
IwzoRsgTtDkz0h0Qi/6t0P4hSu/sobPGHwV8KYBGi4RjuuNl62tQzyUJOYmYah18
Xaz6IbrYmtSc8zgq8tytUxG1j3HRO1icmWWM9jkpqMtGD+CESPbAJV2yWZUTywtl
VjJf6JjiiXmMrAZLY0PlRZON2ePlsyARsJFPy9TDrhaErq2rSLhPI+FMaL6dssH2
YOHlHOpxBEp1DEl5HsKaxiDhyA2x4A==
=BnTH
-----END PGP SIGNATURE-----

--3w0XWtrOW4Hfhq/l--
