Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF8B53EA95
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241838AbiFFQZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241816AbiFFQZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:25:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EF11BD7F1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:25:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F0D860BFB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 16:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF35C385A9;
        Mon,  6 Jun 2022 16:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654532724;
        bh=6C1ftIq2+/BRnNYkuG6cpMTzXy2fGebCcPyZI8FE7QY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dT9bzhjnCTxPZn6QGKfd2z5w3YR63nDpB85aUWVor/+qPkxj7euBfWwutI92IpNJo
         jYzF4WDXCDrYD42/9X7z4ZFjcxw2x+YiyMA1neI0cankclhKPfFFVnBOxx5eYyxEcQ
         Eriz84kRzcbOKMTUlqh9i9em2Ag5YuV0nWk45McC9Vqtd96giRayypcn71FLM1u27q
         qk4a8d/ufM6q4/TpojKDoPY1q9RKYaPppcufBW3ByirZNCd/3ib3VCwl+omCNQ/88A
         m5Kc3ljj7Cpg4unwcImz2B63DKlQxhrLyj2Wz6CKsDW7ULMNGjBaviiZjrmizqphct
         XlOSo+BFiGSfg==
Date:   Mon, 6 Jun 2022 17:25:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 3/3] ASoC: wm8940: Mute also the speaker output
Message-ID: <Yp4qb5jaGYf5qnxt@sirena.org.uk>
References: <20220606154441.20848-1-lukma@denx.de>
 <20220606154441.20848-3-lukma@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vbR2GMX70upG8Py9"
Content-Disposition: inline
In-Reply-To: <20220606154441.20848-3-lukma@denx.de>
X-Cookie: Bedfellows make strange politicians.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vbR2GMX70upG8Py9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 06, 2022 at 05:44:41PM +0200, Lukasz Majewski wrote:

> Without this change the BTL speaker produces some
> "distortion" noise when test program
> (speaker-test -t waw) is ended with ctrl+c.

> As our design uses speaker outputs to drive BTL speaker,
> it was necessary to also mute the speaker via the codec
> internal WM8940_SPKVOL register with setting
> WM8940_SPKMUTE bit.

This will not interact well with both the user visible control of the
speaker volume via the Speaker Playback Volume control and the analog
bypass paths that the device has - it'll change the state of the control
without generating any events, and cut off any bypassed audio that's
mixed in.

You can probably achieve a similar effect by making the control an
_AUTODISABLE one which will allow the core to mute the control when it's
not being used in a way that's not visible to userspace.

--vbR2GMX70upG8Py9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKeKm4ACgkQJNaLcl1U
h9CkDwgAhJX7tOT+yGFzvFc73mwr1jkFi+2f+NgQ5Vz+AFyNn8C7GgMClt6+gXhI
GuqETDHalU67stNb4ke1NTVdlKM1qI5rdGl20VfY/mFCb+itbR/fE/vxwMHIQSCy
JY4dpCv2Z3yDKLSjSarJiTWV6dxaJ01tJYp3z3+i2Za9Di4v6K3j2wRayIZcczSt
sxPdAt/4AL265LDctA6PmI2VCE2wjo3l4YgfInO1bGDpH5gjnZFMdJo3cKHD/Vrs
JLRuB6A1guLo1oURYQOKLrvpMPRkKoF/XaoNlCA/Tlsd/p0l3Up8sk6zBY8Gr+f0
uNDYRwQnGcy/KqQT+B6Ytqa2i7pMqw==
=2p+e
-----END PGP SIGNATURE-----

--vbR2GMX70upG8Py9--
