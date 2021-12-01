Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2BF4652C8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350831AbhLAQfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:35:32 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52860 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbhLAQfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:35:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 35EE5CE1F9C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 16:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C12C53FAD;
        Wed,  1 Dec 2021 16:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638376327;
        bh=DjtGtk4qiMPnsgkCOR3f2tpkpDFCrQvM5yhYi67G6xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QKfsiixyYi/EuxmoFb6eDZr0MwFg31wREGE6AfVtG+tmpaFqog0DIx8tZW81ZVRE0
         76k2dfr+Kn2ifp9Lzopf9EanId7AMOfnbM1MQkoVJo+ALJFwIzcRU07y1RA4IApWqQ
         ViekO0OEfcRKCYe9oDkzumoYr4n+TIcpuEIPKDgO+5p8HR010XkXq1RfaSSvGSlT5X
         FEnBBPrZmaSUFJPY/SwDG9pgRtygz83buiSJUpKN/JwjmidBCQvBq/5notc8wBRK6c
         Aqa7V2rkEg+olXdhgmpa+J3kxGFUIN4ra5vldsoAqP53zlrdCa1eVocl1t64VG03gc
         ZfDHsjCI/NzyA==
Date:   Wed, 1 Dec 2021 16:32:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: cs42l42: Implement system suspend
Message-ID: <YaejghraYE6lD7FD@sirena.org.uk>
References: <20211201153648.17259-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RkDed11whgknlEPT"
Content-Disposition: inline
In-Reply-To: <20211201153648.17259-1-rf@opensource.cirrus.com>
X-Cookie: All true wisdom is found on T-shirts.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RkDed11whgknlEPT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 01, 2021 at 03:36:48PM +0000, Richard Fitzgerald wrote:
> Add system suspend functions to handle clean power-down on suspend and
> restoring state on resume.
>=20
> The jack state could change during suspend. Plug->unplug and unplug->plug
> are straightforward because this looks no different from any other plug
> state change. However, the jack could be unplugged and a different type

This fiddling about with the jack detect feels like it should be at
least one separate change, possibly multiple changes - the reporting of
button states feels like it should be a good cleanup/fix separately for
example.

> of jack plugged, and on resume the plug state would not have changed.
> Some code changes are needed to the jack handling so that on resume a
> plugged state will be re-evaluated instead of filtered out. In this case

It would be helpful to elaborate on what these code changes might be.

> +	/*
> +	 * PWR_CTL2 must be volatile so it can be used as a canary bit to
> +	 * detect a reset during system suspend.
> +	 */
> +	case CS42L42_PWR_CTL2:

This feels a bit hackish - is the cost of doing the cache sync really so
expensive that it's worth the effort of trying to skip it?

> +	if (cs42l42->suspended) {
> +		mutex_unlock(&cs42l42->irq_lock);
> +		return IRQ_NONE;
> +	}

Given that you're using disable_irq() to force the interrupt off (which
is a bit rude but often the best one can do) how might we be getting an
interrupt while suspended?  This seems to indicate an error condition.

>  			case CS42L42_PLUG_OMTP:
>  				snd_soc_jack_report(cs42l42->jack, SND_JACK_HEADSET,
> -						    SND_JACK_HEADSET);
> +						    SND_JACK_HEADSET |
> +						    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
> +						    SND_JACK_BTN_2 | SND_JACK_BTN_3);
>  				break;
>  			case CS42L42_PLUG_HEADPHONE:
>  				snd_soc_jack_report(cs42l42->jack, SND_JACK_HEADPHONE,
> -						    SND_JACK_HEADPHONE);
> +						    SND_JACK_HEADSET |
> +						    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
> +						    SND_JACK_BTN_2 | SND_JACK_BTN_3);

This unconditionally clears the button status - will something notice if
the buttons are pressed?

> +	} else {
> +		/*
> +		 * Only call regcache_mark_dirty() if cs42l42 reset, so
> +		 * regcache_sync() writes all non-default cached values.
> +		 * If it didn't reset we don't want to filter out syncing
> +		 * dirty cache entries that have default value.
> +		 * DISCHARGE_FILT=3D=3D1 after suspend. If the cs42l42 reset
> +		 * it will now be 0.
> +		 */

Something needs to tell regmap that the cache is dirty otherwise it
won't sync anything, including the non-default register values?  There's
currently an assumption coded in there that the cache is dirty because
the device was reset and everything has default values.

--RkDed11whgknlEPT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGno4IACgkQJNaLcl1U
h9DJ6Qf/YafozpTqOUoPhMpfJCM+TFh3s5pwYjW/9Owy6eXZR6F9a2b0z9CRQrG2
YoAmhZw/rXZ/2IvlvhVM8rl+Fy/uvQAbZECjWPmOjuiDcPPdbMHflKjs0frsTKz6
97yD2Q7nkyofOIsQtc0V+1XA4ndeUH1Z1Ky4J7bgaODtrgSVLQ6lyMHNIqq7AbX+
hMquuSUSTqJW6lhvIit2NHFEdY1AKlagS7wMw+Re9qGkzAGtdQc3AOXvwZybgrz/
p4B2sHnJ+sCI1jmgm5p/mDPmShrwx5W0Fl623KDMqLvRtPc725Kg97IFJ9skjjBf
mwxwhYHq8RvnKZpkmuqm3wXkhzjO2g==
=I0x7
-----END PGP SIGNATURE-----

--RkDed11whgknlEPT--
