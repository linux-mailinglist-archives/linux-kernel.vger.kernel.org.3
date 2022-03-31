Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C764ED891
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbiCaLg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiCaLg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:36:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004DB1CABC6;
        Thu, 31 Mar 2022 04:34:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A817AB820C4;
        Thu, 31 Mar 2022 11:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2EEC34110;
        Thu, 31 Mar 2022 11:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648726476;
        bh=I5op4/fhnQSUnYzJWaWQNlJ1H4wDb3rq0pO390uPg7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L4Mo6lbgeciXAh4IfXNOebzQf0owI1GagEsI8A35i+oVILwvxCg/9rvHr/kpgZVVx
         Tu27hq8sDCYkK5Z31kXcQQPk7MdVAijOi6/zE1PXoDYJQf6svNuRtlLSteEuPndVG5
         /lnCyj51ESDtueBzkoSoQL8nXws6VnHgqde2sYVzPkSyI+ghvrXrHvqDT3rFVORRXR
         D9UxEUMBT3mVxoqc4D3eYEARHpsKDS1N1eve9qCwVMXb4+8FYg49PyhqnlUYL9sjtn
         qwmaeh3I3FMfJrtaBfZdI61z9sQt922riRkJpD9gIZvxvoJh6ZEQPpnBJhSFQh20FG
         wDyPiEgmMmctQ==
Date:   Thu, 31 Mar 2022 12:34:29 +0100
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
Subject: Re: [RFC PATCH 2/5] HACK: ASoC: Add card->filter_controls hook
Message-ID: <YkWRxWjQSnJ9f281@sirena.org.uk>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-3-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Rn6cuR2n68nqDaPE"
Content-Disposition: inline
In-Reply-To: <20220331000449.41062-3-povik+lin@cutebit.org>
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


--Rn6cuR2n68nqDaPE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 31, 2022 at 02:04:46AM +0200, Martin Povi=C5=A1er wrote:

> Add a new ASoC card callback for filtering the kcontrols of the card's
> constituent components. This lets the card take over some of the
> controls, deciding their value instead of leaving it up to userspace.

Define "filter".  What is this trying to accomplish?  As a matter of
policy we don't put use case configuration in the kernel, the goal is to
avoid having to update the kernel when people decide to do new things
with their userspace.

> Also, and here's the HACK: part, move dapm_new_widgets call in front
> of the card's late_probe call. This way all kcontrols should have been
> created (and are safe to use) by the time late_probe is called.

This will break any card that adds new controls, you could add a second
call earlier but deleting the existing call is going to break other
users.

--Rn6cuR2n68nqDaPE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJFkcQACgkQJNaLcl1U
h9C7NQf9FwcUXaDm99g8Ruvdg/6JlPdvQmyopRmajEPaCmEEGsO1JSupvTnOYIAa
nbQ1U6aIzTeOfITplg9jm5E5sADl5BBdyr8CHlSq2wxUT+yuDvG94WQuQi0mmzTf
q+yit17En0FxVpnlQtLD/ML/xX13gs2jP8IdAO+B2IMuzfBQ4R2tnDu5Pu7wV7Nh
HEBuZiBW9upxlSQpmKgG8OUE26Jr5Vv/2EuwBBfW1GaigIVFvSE0QCQYWiO8JtA5
Q3dAd6VzuCbCgCwn6MJIG4q4bksBjrmDWykZmQEBgMQWM2C/n1/nvOWhNpyFXmEy
HvhjTsf2toT/vrZQr6tXIKtEdE+4tg==
=7ljO
-----END PGP SIGNATURE-----

--Rn6cuR2n68nqDaPE--
