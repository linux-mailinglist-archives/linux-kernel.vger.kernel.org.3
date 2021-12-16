Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6439477329
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237561AbhLPNa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhLPNa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:30:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F2CC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 05:30:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A4B561DEF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 13:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE70C36AE5;
        Thu, 16 Dec 2021 13:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639661456;
        bh=49Z6wFi4YNUCTmFU5vkrqttrjiblP0wsp+lNNiakJQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHi+UViioPPW6PNkWMgsBFoBf/ETYKdd3BMxkIZCdufE5LSGQGS4otPLLq9NPDtwD
         +xapfBSoXDYcbsdIrzzXwcUwlrlv135Q+2ezM3ibIwKImjoa0UENpi8NC3HgjJ2/R3
         MUD/m7UzZnBZHkyiOq+bmgEiuLoIeDLcgQzNfgu6RDsgMrkkoco2FWh/Uw32UVcgEE
         nPz/Q1jF2xS84IcAWLQPIPqJ5GLMJ9wgUVEChh2Fj+QcvaNWUlXsuUoMjD2zaqmpp7
         Ptcx1QEZBYzaRR5kbdQG6PSv0RTJeIhuko+s05GOuKse/NL9UtCLJCUyI59eyUaUa0
         dczhfrGJu0cQA==
Date:   Thu, 16 Dec 2021 13:30:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc:     alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: max98357a: Add mixer control to mute/unmute speaker
Message-ID: <Ybs/i3Lg9VN0d4kg@sirena.org.uk>
References: <20211208185850.1555996-1-AjitKumar.Pandey@amd.com>
 <YbETxcwa83U8WXTO@sirena.org.uk>
 <YbEYVq+uvIcoxqko@sirena.org.uk>
 <3ec805fc-07cc-6091-551a-771dffe459d0@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v2TZdMJ+b8CyeONp"
Content-Disposition: inline
In-Reply-To: <3ec805fc-07cc-6091-551a-771dffe459d0@amd.com>
X-Cookie: No solicitors.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v2TZdMJ+b8CyeONp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 16, 2021 at 05:54:45PM +0530, Ajit Kumar Pandey wrote:

> Thanks for suggestion. We tried using SND_SOC_DAPM_PIN_SWITCH() for the
> speaker widget and it invoke dapm_event callback based on switch i.e
> max98357a_sdmode_event() but codec driver isn't enabling/disabling gpios in
> such event callback instead they are doing that in dai_ops trigger callback.
> In our platform single I2S controller instance (cpu-dai) is connected to two
> different endpoints with a single PCM device, hence we want to switch or
> enable/disable output based on Machine driver controls only.

DAPM should cope perfectly fine with this setup...

> Initially we thought to configure gpio within sdmode_event callback but
> there was some pop noise issue reported in one platform with that change
> hence reverted. Check https://patchwork.kernel.org/project/alsa-devel/patch/20200721114232.2812254-1-tzungbi@google.com/#23502085
> So we thought of exposing a mixer control to enable/disable amp from UCM
> in our platform without breaking existing functionality. Please let us
> know any other alternative way if possible.

Whatever is going on this should be managed from the driver rather than
having a direct control, especially given the issues I mentioned with
there being zero coordination between this and the management that the
driver already does.  You could have DAPM controls set a variable and
coordinate with whatever you're doing in the pcm_ops, I'm not clear what
the use case is for having the manual control TBH.

--v2TZdMJ+b8CyeONp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG7P4oACgkQJNaLcl1U
h9BGLgf/QrD75IeSRsyIplUF5g81WOZxgP3BPYqnddbQW7NMYJtmvJ4hlDTs4uHt
26td84vJTxIlDxNfXLVilgTDtt3SSP5lcFwh61S/reqVz2GLNXKkMzF1MX70O/ti
FGiNQefrG+EcB4EWMqbb/327+cC4nPDRx0Axt8FVdrxnMWL50vFHlo+U80FFGsP/
xAt3TGWjLdQO3AYLk4rF/OLoCWGg297Xk/7JLT84oo98h5VPChyVKLLDHqiqNaa2
X23TfiGxK8+Vfe4WLfVpFGSaFXkTWcCQmBGybSfZY8Y6PN0gm483m3VE+Y6R0JY6
oVBaIJ7yNcKkPTk59SEgHCzqzLQi5g==
=wPBI
-----END PGP SIGNATURE-----

--v2TZdMJ+b8CyeONp--
