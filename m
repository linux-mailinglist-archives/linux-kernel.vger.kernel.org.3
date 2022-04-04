Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C1F4F14C8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344547AbiDDMaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344642AbiDDMab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:30:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ADBBF5F;
        Mon,  4 Apr 2022 05:28:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0DD461049;
        Mon,  4 Apr 2022 12:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93E8C2BBE4;
        Mon,  4 Apr 2022 12:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649075314;
        bh=xs4c6MXzpV8ng4CjtZYCgJS2RsuPKpKdPUzYO+hnHgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7GBgI2GTxELAK0/ohe2a9WUz5f54xUcos+VlcjM4byBQtlHumr57JKG4pYLFXlFj
         /pmwE/Ln1e5SZNaS75jo3WCh9JJQCxn2TBxUMdzXWZeYvcTaMPyRo/zl7Lz2Lmpuut
         Ibck0ncRDCkwQvi91v8hNZAexCpRD/gu5y4fC8OQR9koOvZTIzK+em0qFgO32tMylI
         JzUuqLZoyO9Oza2r5JQOOvUc2+bB9gZ1ZCgBEc8D7mj7xur9iu0eleS0p5glEEKHO/
         M+kMMzFKaAWePT6DtzsgqM1PC0zE+Af9AEd5/U3OqjWZcNhth1oWC8/h1GFtHcktEH
         ScotCNfry7Xag==
Date:   Mon, 4 Apr 2022 13:28:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>
Subject: Re: [RFC PATCH 3/5] HACK: ASoC: Tolerate N-cpus-to-M-codecs links
Message-ID: <YkrkbBNYULLgeS5w@sirena.org.uk>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-4-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f/2nG60b2Y2bNyVh"
Content-Disposition: inline
In-Reply-To: <20220331000449.41062-4-povik+lin@cutebit.org>
X-Cookie: Did I say I was a sardine?  Or a bus???
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f/2nG60b2Y2bNyVh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 31, 2022 at 02:04:47AM +0200, Martin Povi=C5=A1er wrote:

> +#if 0
>  				dev_err(rtd->card->dev,
>  					"N cpus to M codecs link is not supported yet\n");
>  				return -EINVAL;
> +#endif
> +				cpu_dai =3D asoc_rtd_to_cpu(rtd, 0);

We need to figure out an interface for describing which CODEC/CPU
combinations are connected to each other.  I'm not seeing a great way to
do that right now, probably some side data table is going to be needed,
or perhaps the CPU DAI drivers can be persuaded to only have one DAI
actually register and claim to support more channels?  I'm not sure how
a configuraiton like this is going to work at userspace level if the
multiple CPU DAIs end up being visible...

--f/2nG60b2Y2bNyVh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJK5GsACgkQJNaLcl1U
h9Dh0gf/Q1fqGCEc/wB1XRysOW+Zr5es3K9uEZqWeoFmgY3PJHzaoQyoY8BDO6Ve
RDsWRNXnUAuatmcX1NOrm141Q5vVthZt2Y3q60kJOAtBjRg1eLsw0uILEy5Q7cb1
lj7GMjVex4PXcDIJHOb52ZeUhEx1HCpwPCW3Gtx7yU2vmpmpM/vPnugND7wgXoL0
nuD3L00ieLVGfeaBi5ZBYBBvMqO6a8Vc8D4q2zgV+1NVnexzLy8nSWqZCmyKa5SF
bf1jHHMuHJUNF6xeTjSLqzeoRH4q0TEzMMJhF4K4ACM693Dy1HBOXRPKNU33u6/8
7REwlCduNI1JEBSwNjzHv4gMWLxfNQ==
=QGn3
-----END PGP SIGNATURE-----

--f/2nG60b2Y2bNyVh--
