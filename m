Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D385C50E0DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiDYM6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbiDYM6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:58:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A029713E0F;
        Mon, 25 Apr 2022 05:55:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0CE9CCE1119;
        Mon, 25 Apr 2022 12:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9287CC385A7;
        Mon, 25 Apr 2022 12:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650891331;
        bh=HkfcpCc1eqbiLwGyeTmgQdMI4j+rgg6rvsaSC4eQ5IA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HnRk+psz8v1zx0VWCDqtiKUsIUhuHir+2OLLtUzHdXMQoKT1OTp29AKJtqiTBc9RH
         Wxhj7GhbEkaD7JrhP6P8L70oos0BwM5CaxhCrTvJ6NOsBnDJ5byl7PgoxBHcuyQ3iy
         AWOgIjAPo0glLjQdDJtt2oGa57B/TAs4nXFAdORYVulc2Dqnu+I51ADvdDHjDymhI5
         WHauj0zBcdDceGsp6AWPEf4882AImysACZIP29oRLvVFvl+b/KWPkblFV3pofeGm7N
         3U0QYOsC2GMUQLBr7ywyW3RuCV6QkpBPtY8oHP2rO53dQOqY9ZlkDawIusF89P3BEX
         UmJwJ+mBCirGw==
Date:   Mon, 25 Apr 2022 13:55:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik@cutebit.org>
Cc:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>
Subject: Re: [RFC PATCH 3/5] HACK: ASoC: Tolerate N-cpus-to-M-codecs links
Message-ID: <YmaaPa8A03rWV7HE@sirena.org.uk>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-4-povik+lin@cutebit.org>
 <YkrkbBNYULLgeS5w@sirena.org.uk>
 <904EB8A1-5561-4555-8030-B85703E24F2E@cutebit.org>
 <YmaTHTKWAfM7FCcY@sirena.org.uk>
 <9F8BCBA8-5EE3-4F87-9518-91CB7AB4E077@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O7wLMv3y86gLGqlc"
Content-Disposition: inline
In-Reply-To: <9F8BCBA8-5EE3-4F87-9518-91CB7AB4E077@cutebit.org>
X-Cookie: An apple a day makes 365 apples a year.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O7wLMv3y86gLGqlc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2022 at 02:34:33PM +0200, Martin Povi=C5=A1er wrote:
> > On 25. 4. 2022, at 14:25, Mark Brown <broonie@kernel.org> wrote:

> > If you register two separate DAIs (well, links) with the API without
> > doing anything else the API will just expose them to userspace as two
> > separate things with no indication that they're related.

> Sure, but what I am addressing here is a single DAI link with multiple
> CPU DAIs, invoked in DT like this:

> 	dai-link@0 {
> 		link-name =3D "Speakers";
> 		mclk-fs =3D <256>;
>=20
> 		cpu {
> 			sound-dai =3D <&mca 0>, <&mca 1>;
> 		};
> 		codec {
> 			sound-dai =3D <&speaker_left_woof1>,
> 				<&speaker_right_woof1>,
> 				<&speaker_left_tweet>,
> 				<&speaker_right_tweet>,
> 				<&speaker_left_woof2>,
> 				<&speaker_right_woof2>;
> 		};
> 	};

You could parse this into two separate links for the benefit of the
framewokr if you're using a custom machine driver (which I suspect you
probably have to).

> >> What about this interim solution: In case of N-to-M links we put in
> >> the most restrictive condition for checking capture/playback stream
> >> validity: we check all of the CPU DAIs. Whatever ends up being the
> >> proper solution later can only be less restrictive than this.

> > That's not the issue here?

> Well to me it looks like it is. Because if I invoke the DAI link like
> I quoted above, and the platform driver supports it, the playback/capture
> stream validity check is the only place it breaks down. Notwithstanding
> this may be the wrong API as you wrote.

I am surprised that doesn't otherwise explode TBH - at the very least
I'd expect it to show two PCMs to userspace which if I'm understanding
your description correctly isn't really what's going on.

--O7wLMv3y86gLGqlc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJmmjwACgkQJNaLcl1U
h9ARDQf/Vj3omBxQfzF9VW1hJ6eknKjHUHK3xR8JtMc6NNBVbLKwOHLwte5cwTT6
Fyi8T+yuuIC8qEXbIR0UYYTPHK3oBqj+tqL+BCqbjJM47ZzpwOIJuBcdn6fU/QpC
umLT2bIQOsVpkGmlvn9UH+U/dESOzPv8PjiSruIXiRGYam0j8H/jh8hiTQi6n6BZ
yRy+GgjLdF9Ws9aB//xps5zY7RvauQ5CmnOYz0++56JITDTrWV1xXdZNEs7PXmCe
UN4KxiMDwLX0nfce0k8S7Gyb8yE8PaZ5AQ66QCBKY7c1tI/qliUdrEhWieaCzt9/
K78aAw2cGspFrQODHj8LAnpKCacFiQ==
=QJEI
-----END PGP SIGNATURE-----

--O7wLMv3y86gLGqlc--
