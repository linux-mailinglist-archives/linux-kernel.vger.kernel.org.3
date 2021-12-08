Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF73B46DCEA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbhLHUZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240171AbhLHUZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:25:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FE4C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:21:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38BC2B82283
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 20:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB580C341C7;
        Wed,  8 Dec 2021 20:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638994891;
        bh=rhq3YBDa2lcjLnARAv5KYohBVlKxOxXrI6n5L4BuWHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mPOCHW/ZnG3IarnyKwRIqvK8yh5fNAWRbivMHC9iyOtjx+Pzv+WW7E7LLYi6WqqFc
         ++UwE+uT7IV8X45wp/bIHedO6FOYCZPpGgUV05/Bt2BtiMnwGVhDJIKPMJR6mHAgJ0
         9ohzeo4vT6pOKYMOKhPHugrxZXCTAOUpkxAaHbgxyUs1K/8sasqrdBhC04yBUS/WEK
         tq+JuyxdvYRVYwuUjhF2Wpbox67dtUl+ZPvu5+D0mqLq0Rqspfdxdn/Q/C+LPodgTD
         ewVOSQIglgSDdny1wU8LhL/wiV+Scu1qh7Mwbpj2gfbYLh6bR1AFyTBtwye6u/6Zn/
         xImvXv/cP3bKw==
Date:   Wed, 8 Dec 2021 20:21:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc:     alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: max98357a: Add mixer control to mute/unmute speaker
Message-ID: <YbETxcwa83U8WXTO@sirena.org.uk>
References: <20211208185850.1555996-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nru0qQ3jsfsVj9cp"
Content-Disposition: inline
In-Reply-To: <20211208185850.1555996-1-AjitKumar.Pandey@amd.com>
X-Cookie: Alex Haley was adopted!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nru0qQ3jsfsVj9cp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 09, 2021 at 12:28:49AM +0530, Ajit Kumar Pandey wrote:

> +static int speaker_mute_put(struct snd_kcontrol *kcontrol,
> +			    struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	struct max98357a_priv *max98357a = snd_soc_component_get_drvdata(component);
> +	int mode = ucontrol->value.enumerated.item[0];
> +
> +	max98357a->sdmode_switch = mode;
> +	gpiod_set_value_cansleep(max98357a->sdmode, mode);
> +	dev_dbg(component->dev, "set sdmode to %d", mode);

This looks like it should just be a DAPM widget - it's just a generic
GPIO control, there's no connection with the CODEC that I can see so it
definitely shouldn't be in the CODEC driver.  Often trivial stuff like
this is done in the machine driver, though the simple-amplifier driver
is probably a good fit here.

--Nru0qQ3jsfsVj9cp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGxE8UACgkQJNaLcl1U
h9Bjfgf+Idtlzi+zebn2o/I5PxidR71VIpfcfx3wi84zBF17C35koKEMCxLD+lYg
ggmn+Av7y0UxKOlJH2dMbGjHppbIGObSXXfwZz4DW/EvkIB3txbM0P+g+3kZlC5H
Bb9UvdzotaSXfV5KdKA5s0Uv1ZPaCzBLbCJ5gHNR7l9avwKF1eNjHNjBUZnGd807
LnirgNeMo0WCM1XcgOWQIUcY8HvD7Z1Vf1UudXFhiRMOXZN5UpDbFImqxcTe666r
QL4+jcqKchLQ+7fgoizslapoNoGz6qPRV4P2usgG5DNh9fMaVO8cF0/skeG8ukq9
MhlVPlul0sAjPKYgPoteGWAJOku/2w==
=Ysd+
-----END PGP SIGNATURE-----

--Nru0qQ3jsfsVj9cp--
