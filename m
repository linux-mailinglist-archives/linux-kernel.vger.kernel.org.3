Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8009D518F44
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbiECUrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiECUrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:47:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEF433A20
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:44:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8498C612A8
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 20:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C357BC385A9;
        Tue,  3 May 2022 20:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651610658;
        bh=6bWKdbsEXPz49sGZeunIdmzckF0jfpJgBh7mhHoKyhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LgVonAnsfiXhii0zNxUkdIYYhPToiGIE89Air899S4PqzWJ1Ka+uHV99gSJaq1TSp
         WYQz5q7dzwFNQROTBWLbKXMdwC/H0dLstxEojsvQfFsZahhB2s3OGxqDpl27JdqOAu
         6GYvTjT9GASgNb07qlyS66lZn9zyTGTQhye6GQDajjysXl5wl3WHqClrET8CtN1nBR
         wA6GAR0WYSwUBNWtDsvj+iMqgYGmMAXvQx/XH1U55I+FGqQDpWhHEJbYWUwjWUtGo8
         jsRhA/GN2yAnTTXAl0RAwCTjhdsjW+hdYJefibXGSflStopXEtF3QCV11YpdDWGAaw
         Auymd2eo1yL5Q==
Date:   Tue, 3 May 2022 21:44:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Sugar Zhang <sugar.zhang@rock-chips.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: hdmi-codec: Add option for ELD bypass
Message-ID: <YnGUHcFOYrvcA2Ol@sirena.org.uk>
References: <20220430134006.v2.1.Ide2a04ad0c123cc6990a63632e6f9bb7d7f9be13@changeid>
 <20220503083852.be2aihvkd3gestdw@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OsPWNiu3lmWmo4dw"
Content-Disposition: inline
In-Reply-To: <20220503083852.be2aihvkd3gestdw@houat>
X-Cookie: Drop that pickle!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OsPWNiu3lmWmo4dw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 03, 2022 at 10:38:52AM +0200, Maxime Ripard wrote:

> I think some more documentation is needed there to describe how it's
> going to be used.
>=20
> Like, you mention that it's relevant when the EDID is not valid. But if
> the EDID is valid, is bypass still allowed or not?

I'd expect so given that it's explicitly an override and that it's not
like it's unknown for people to put nonsense in ID information.

> > +static int hdmi_codec_eld_bypass_put(struct snd_kcontrol *kcontrol,
> > +				     struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_component *component =3D snd_kcontrol_chip(kcontrol);
> > +	struct hdmi_codec_priv *hcp =3D snd_soc_component_get_drvdata(compone=
nt);
> > +
> > +	if (hcp->eld_bypass =3D=3D ucontrol->value.integer.value[0])
> > +		return 0;
> > +
> > +	hcp->eld_bypass =3D ucontrol->value.integer.value[0];
> > +
> > +	return 1;
> > +}

> If the ELD bypass is set, how does it affect the hdmi_codec_params being
> passed to the codec?

Presumably we should tell the CODEC what we're trying to play (looks
like that's what the current code does)?

> Also, what is being returned to the userspace by hdmi_eld_ctl_get once
> the bypass is enabled?

My first thought would be that we'd always read whatever is there
rather than trying to make something up, bypass just says we're not
enforcing it.

> And shouldn't we call get_eld when we remove the bypass?

Or given what I just said above should we not change any get_eld() calls
but instead only change things so that we don't look at the ELD data
when setting constraints during startup() and during channel map
operations?  In that case we wouldn't need to read again.

--OsPWNiu3lmWmo4dw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJxlBwACgkQJNaLcl1U
h9D1BAf+Ki9P/Di674dAQK1c9cYTrHMivYqtlXs4E07WqWCuoQYF9hgTVXln3dLx
frSjVN3r0eDL+/GRtV3Nr5n9aL/LU/vRxVDGKLKXxDOKxDxaiIk/S256fcFLt1sE
OZV9MGFiexyaQQhVCdOhGpxNWGPAt99ytMhWjNrlejNf1IpdVVG7raAkdYRQdyE0
THsaHeU741+6mVXb8pinIU8R3dSF01zO3xGuovHVCuL+NWFn9xuPqccrs1HCvYjE
Zhs7X9OvnWbo2ae7Pa9rz87G2KEyHYndtfElFgHA5fZ5bl4+ram85gpSdSXxf1Dl
RzLY60zVq2ppkeLBuEDt3djb2+GYMQ==
=7Z++
-----END PGP SIGNATURE-----

--OsPWNiu3lmWmo4dw--
