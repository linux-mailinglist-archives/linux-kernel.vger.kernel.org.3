Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF4254C64A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348840AbiFOKdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348767AbiFOKdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:33:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4086713FAA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:33:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0E41B81D44
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4D6C3411C;
        Wed, 15 Jun 2022 10:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655289209;
        bh=1J5FIdCXMTdaAREzoK9hwYKt1T9ZVL6B+SZnop3VnVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I+w70pC8ZPbD1S9qVrTDD7WcD736w3zQdRkBEPv95DCFnodoajia8Xr41uPX+V0+9
         So0HZEsWVReh4bJirWgS9hKoVNkkBE4p9nQ/rQMJhQow7i0YoxF/Lv6Ie6GDrJMTG/
         RF/T7zxQT6/P0fKIhYGTtltc3XNkG5FPOvh1/sMJABLfsI1Ymp+QMc1r1xxCiMtRKn
         XKiNTulrj1supnwV+t+VJ9/X36BcRCyJtS4fF/qdlwq7APXtrXCrwiI7Mb7ERdDq7c
         CCsL01YTqaJarU1wU94lgizcQqMVgg3w+Tm9WnGyCVgzdfAShAUWcUmYFNtcUfE2vq
         v3jQU9qY2uppA==
Date:   Wed, 15 Jun 2022 11:33:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v1] ASoC: rockchip: i2s: switch BCLK to GPIO
Message-ID: <Yqm1cTfq1AA/mAV5@sirena.org.uk>
References: <20220615045643.3137287-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4CmsN/CfvM2oLYC0"
Content-Disposition: inline
In-Reply-To: <20220615045643.3137287-1-judyhsiao@chromium.org>
X-Cookie: byob, v:
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4CmsN/CfvM2oLYC0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 15, 2022 at 04:56:43AM +0000, Judy Hsiao wrote:

>  	i2s->bclk_ratio = 64;
> +	i2s->pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (IS_ERR(i2s->pinctrl))
> +		dev_err(&pdev->dev, "failed to find i2s pinctrl\n");
> +
> +	i2s->bclk_on = pinctrl_lookup_state(i2s->pinctrl,
> +				   "bclk_on");
> +	if (IS_ERR_OR_NULL(i2s->bclk_on))
> +		dev_err(&pdev->dev, "failed to find i2s default state\n");
> +	else
> +		dev_dbg(&pdev->dev, "find i2s bclk state\n");
> +
> +	i2s->bclk_off = pinctrl_lookup_state(i2s->pinctrl,
> +				  "bclk_off");
> +	if (IS_ERR_OR_NULL(i2s->bclk_off))
> +		dev_err(&pdev->dev, "failed to find i2s gpio state\n");
> +	else
> +		dev_dbg(&pdev->dev, "find i2s bclk_off state\n");

This should really validate that it's got both on and off states before
we start using these, especially if we only have off, since we might end
up being able to do one side of the switch but not the other which won't
work.  I'm also wondering if it's better to just use audio active/idle
states rather than saying purely something for the BCLK - effectively
that's what this is doing and it feels like it might be cleaner and more
future proof for people to disable all the audio pins rather than just
BCLK and then switch them together.

--4CmsN/CfvM2oLYC0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKptXEACgkQJNaLcl1U
h9DonQf/TZGhSlKwJZPQlFmypY1sEE1OjAFYsmr7k+A+owQ3xj2wv9RAPQrb2s5W
No05azxh5PaZe5ZbGA64pH7iDbDcGuffc2QxlnJZgA0vg+02kuZd3lSdcsXcaiDj
oq6oFh0qPN19Fftie3BNVhQ6NLIclG3fszY0eLn+O2VfSIPSb5BrwQJuEKUth1yR
GFAGoVg3kpU+7Vk3apesZhhqrvNLy8MtQ65h2Rn73tGJxPhsrWcqnLQ7dsg+seVO
U4go/CaOBnSS8Cm8zFoxdG9o6xGyPgabb6+uWVAR8ssRkvv4FqCWSl1IBxrSRDpC
XhYLgerh8VFllC0Rgb+v2CW81EFB5w==
=uIhh
-----END PGP SIGNATURE-----

--4CmsN/CfvM2oLYC0--
