Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A346252DB54
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242886AbiESRas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243208AbiESRaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:30:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AA1C07
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:29:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ECC1617EF
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74195C385AA;
        Thu, 19 May 2022 17:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652981371;
        bh=pAMdh9/R3I7a/8+4GVZ2KD6esehSzWVgjc9kd7I5PqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VHrPdJdbdIZO3JP5Q3lP0hUqu40Hg2ms4yr+tw4ezT/HzL5HljDMDohamaVFnHmW3
         4aeolGM02T04HW4Op7oAM7PhXbduMT1PBnN5IuDVjWGcHtauNHdLCM4l3KkRVdEAVG
         sX7QhlFbzzS2qIIwLBM52tXJwIhMohlU+NB9p5rgaJ5au1imsNrM1Fixpwn8/l0CFF
         5/4GV4xmfc5KBq/9k1ijtY3J0ZJNMbdGgLipWdioD7yUYzdpUaO0E45Dlvb7E0KMIC
         U8cCmcTZI/FKtzZJgl8xWth3hzks0+XA+vApne++BQJcyRmDion/oWoIwrSZ0GVAuo
         kHUf7UGaEz+tA==
Date:   Thu, 19 May 2022 18:29:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] ASoC: max98090: Remove unneeded check in
 max98090_put_enab_tlv()
Message-ID: <YoZ+dmprwb5Ohto3@sirena.org.uk>
References: <1652980212-21473-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ppdkrA27TUG4wtEx"
Content-Disposition: inline
In-Reply-To: <1652980212-21473-1-git-send-email-khoroshilov@ispras.ru>
X-Cookie: Some restrictions may apply.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ppdkrA27TUG4wtEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 19, 2022 at 08:10:12PM +0300, Alexey Khoroshilov wrote:
> Variable sel is of unsigned int type, so sel < 0 is not required.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

>  	val =3D (val >> mc->shift) & mask;
> =20
> -	if (sel < 0 || sel > mc->max)
> +	if (sel > mc->max)

The check needs to be moved, not removed.  The userspace ABI allows
passing in of negative values.

--ppdkrA27TUG4wtEx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKGfnUACgkQJNaLcl1U
h9At4Qf+Klf++o6ghreVouOuu6V81GODduKtt5M/lMTy6+q3iCORLhZxKFplkCVh
6bQ88I9fwm4GRJXG6SsVKqyRG/HEAJKM2batDPlkZHi2KjX0u48WfFY67vMIzNpc
MFkOkI2L94dm2PdkcVWXKROeEWdJHRl55Oz3NZNfM9ggYd2H0P1ddwtGIe82xAQW
pwVuJWEkstrqvilKcwp2HcQzEko4tm3u6MoN8/H+TZsc7c/zEvSY3OxAv9wFnoD1
1geFeHG8YlycJcnTc0zEEGFhaRDBvoqYTWqQLevlnxJx9GPMmNI1zlm4JsPhqZiE
Z4AhXYOoxW8ySeRdopqDlftSHTrqEA==
=HHuh
-----END PGP SIGNATURE-----

--ppdkrA27TUG4wtEx--
