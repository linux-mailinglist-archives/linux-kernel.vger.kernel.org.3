Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B0B524AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352859AbiELKxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352837AbiELKxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:53:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FFD5DD07
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53CE4B82735
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6243FC385CB;
        Thu, 12 May 2022 10:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652352792;
        bh=LCPGdta7p+6aXKFPfhnyvHZTQKRdcvBKmz+5TOPyuVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gAd2qfIUiXBmaRgfEgtCQahrXW6XIgCGFsV21I2lVUtQGFTbzaAM09z4NYekEmOsm
         /L29phErbXupFGBYVkRPJ5dFWNctHOxu3lToissjFtRnJpksDOCFnb3+7tP9NzMo75
         rRT4Kg8v21UZTibd+gQjZVC0Dud9qQUXslFFYFnztzr0TawxejiX+773/CtPnqh2OO
         9IHNikr53Yom2cEsp59d3gepLYO3njzn1fTadKSjbVtFFwV86UMntXVvaH4LDydwJ3
         A8ZWebclliFzSI8SS0NqlGidLU1Aj8X2F7fIx7bzMs3JVx2tEK7P/DC3kM58wy+ptG
         KhirY3FY/8psA==
Date:   Thu, 12 May 2022 11:53:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linux-amarula@amarulasolutions.com, linuxfancy@googlegroups.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: max98088: add support for reg_4a_cfg_bypass reg
Message-ID: <YnznExLDOvRpXNVh@sirena.org.uk>
References: <20220512074359.446999-1-tommaso.merciai@amarulasolutions.com>
 <YnzdcubW7m+CwnvN@sirena.org.uk>
 <20220512104642.GD649073@tom-ThinkPad-T14s-Gen-2i>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CKVB2CjTPqpFtP1S"
Content-Disposition: inline
In-Reply-To: <20220512104642.GD649073@tom-ThinkPad-T14s-Gen-2i>
X-Cookie: Oh, wow!  Look at the moon!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CKVB2CjTPqpFtP1S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 12, 2022 at 12:46:42PM +0200, Tommaso Merciai wrote:
> On Thu, May 12, 2022 at 11:12:02AM +0100, Mark Brown wrote:

> > These look like they should be DAPM controls since they're controlling
> > audio routing but they're being added as regular controls.

> Sorry again. You suggest to create a new structure for these entries,
> for example:

> /* Out Bypass mixer switch */
> static const struct snd_kcontrol_new max98088_out_bypass_mixer_controls[] = {
>        SOC_DAPM_SINGLE("INA Switch", M98088_REG_4A_CFG_BYPASS, 7, 1, 0),
>        SOC_DAPM_SINGLE("MIC2 Switch", M98088_REG_4A_CFG_BYPASS, 4, 1, 0),
>        SOC_DAPM_SINGLE("REC Switch", M98088_REG_4A_CFG_BYPASS, 1, 1, 0),
>        SOC_DAPM_SINGLE("SPK Switch", M98088_REG_4A_CFG_BYPASS, 0, 1, 0),
> };

If that's how they fit into the routing for the device, yes - you'd need
to define the bypass mixer as well and set up appropraite routes.

--CKVB2CjTPqpFtP1S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ85xIACgkQJNaLcl1U
h9DvDwf/e+ofKzwgZXoBDaBr7aGL0BNyy6uJeFn8xgNBBkoMYpIVAOtd/mjeCq59
iJnxneFalVb7PAaICPVnVHiMmhM99HdY+PHzexxB/Ep0edkqvyvKzto0It8agD2i
FUw/1u/JG60D1NWq7csC/aGzWEdznAat+unlmdMUmNpG+gM+gQyJmvUbLMmD2fAS
pUo9WARMg+63ufOfpYSkKKnHcZD4NlBW/QM3yxt6PcOCDxOufmdg0YbWzFEnSgZe
5/gTDDJQ5fORpmV/qlT5kYudiGjmNuG9fZOjd2Uu3Qx8cgrYXI0jRlOIlRsI0UP/
M4V/w2MBcHZgULbvfttopdB4/Gj9hQ==
=MmmH
-----END PGP SIGNATURE-----

--CKVB2CjTPqpFtP1S--
