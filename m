Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEE050E03D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbiDYMa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242139AbiDYMaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:30:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0E1B7EE;
        Mon, 25 Apr 2022 05:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12115B81607;
        Mon, 25 Apr 2022 12:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF4DC385A4;
        Mon, 25 Apr 2022 12:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650889507;
        bh=6GrE4NWT57K7czTKp7ru4wzIZWD6o9ArIieCTvXxaTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gz1V7yk8c6K7MiFjBSSxV6qtIy6DDMy+HAPCGj9Ixxl8JOX44rM2EQF8KscugLMyJ
         BD2rViz7o/zR649dKviwIwUSg1U+hg84qvs0L4abD3hHR+AFZtZzipCD1+oKeIRTdi
         h6L8q97SxDCW0Hj7Jrpj0CswJcXt+9DBtQ0mtDZllWjmgrsH669j5+GzW8F6Q4q7N4
         nyeHoDGjle1jNO3OLOTdHYEym9AWzvJy/Ohsi6Hw8mB/0aTRmGaRT9LPK3ZJJrI3Mx
         6dDyVYCUd+gC8tggiYxlH4q3GkRg42btwhdC3j524PNnSUv8aftrrZjDZKsIsim8Hv
         zIw/NsAm+2mVQ==
Date:   Mon, 25 Apr 2022 13:25:01 +0100
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
Message-ID: <YmaTHTKWAfM7FCcY@sirena.org.uk>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-4-povik+lin@cutebit.org>
 <YkrkbBNYULLgeS5w@sirena.org.uk>
 <904EB8A1-5561-4555-8030-B85703E24F2E@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b1F3yj0YVHTi5nws"
Content-Disposition: inline
In-Reply-To: <904EB8A1-5561-4555-8030-B85703E24F2E@cutebit.org>
X-Cookie: An apple a day makes 365 apples a year.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b1F3yj0YVHTi5nws
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2022 at 04:06:06PM +0200, Martin Povi=C5=A1er wrote:
> > On 4. 4. 2022, at 14:28, Mark Brown <broonie@kernel.org> wrote:

> > We need to figure out an interface for describing which CODEC/CPU
> > combinations are connected to each other.  I'm not seeing a great way to
> > do that right now, probably some side data table is going to be needed,
> > or perhaps the CPU DAI drivers can be persuaded to only have one DAI
> > actually register and claim to support more channels?  I'm not sure how
> > a configuraiton like this is going to work at userspace level if the
> > multiple CPU DAIs end up being visible...

> To understand the issue better: How could the multiple CPU DAIs be
> visible from userspace?

If you register two separate DAIs (well, links) with the API without
doing anything else the API will just expose them to userspace as two
separate things with no indication that they're related.

> What about this interim solution: In case of N-to-M links we put in
> the most restrictive condition for checking capture/playback stream
> validity: we check all of the CPU DAIs. Whatever ends up being the
> proper solution later can only be less restrictive than this.

That's not the issue here? =20

> As a reminder what happens on the Macs: the platform driver drives
> all the CPU-side I2S ports that belong to the link with the same data,
> so the particular CPU/CODEC wiring doesn=E2=80=99t matter.

Oh, that's not something I was aware of.  In that case this is the wrong
API - you should be using DPCM to map one front end onto multiple back
ends (Kirkwood does something similar IIRC, there will be other examples
but that's probably the simplest).  The back ends probably don't really
need to know that they're on the same physical bus (if indeed they are).

--b1F3yj0YVHTi5nws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJmkx0ACgkQJNaLcl1U
h9AXZQf/TTU2DnW1ZuWYtCiYoQytNm53DGhJatv03n1CX5CEQnTpF2SqtDQXWV7P
FFaj07c+6IYGLOqLmA6TrABjGUoF5YgAmHBesHfS7uLK1pT/dz3c2wB8Dz3agqh5
qSh562UKa7k6eXV17jANpgVJSBoWf/XjQTc031lOcsV1SPT6Z+if6WTBuXu+JGRt
IBk9JY4WLK+c2eQUXKeaV2sPISK9CQObtHXr8CVBlgYuUIGnNTUarF19Vdoyq+2y
QUsZDshFnfBtx/ArsyDMfgX9wO84Ids6rjPSe4pQ0WdRp+TsUiUk1useAx87UMd1
JkINblZc68f3bqMDmN1HJoVYVFHa1g==
=9iG+
-----END PGP SIGNATURE-----

--b1F3yj0YVHTi5nws--
