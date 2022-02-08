Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2714ADA7F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376709AbiBHN4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiBHN42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:56:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9005DC03FECE;
        Tue,  8 Feb 2022 05:56:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1072860E01;
        Tue,  8 Feb 2022 13:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90FDC004E1;
        Tue,  8 Feb 2022 13:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644328585;
        bh=uYqm7NoE0eOtcFY0LElDUcco5XcuEwJ5BgQCnLygmso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EBV0xUI5mN1yHV6C3Ugw9IgqEGN7K++6mXfU8BRyZYTLxycyahmK3QIGt0eWITo0c
         i39ixqmUg8uP7pbsdYDaoOgedPjhs4o45RM5dPyNGSJgev+Gp3HZ5TZnyJEdFSrSc9
         ZhacqrjwKo1MwYYhtAQnobTg4NILtuThtl1ZUxWDQg8vhe2ygGDXeMazAR2OppX5iP
         42y0eCGk9yaOTETMnztHucm1kAmu96SQfR1TMQpp243tHluuUVYWnBPdjHfnezVPiB
         NSBGPP1tvYkVtnAssrwJSgcHe0jE7Y7yW20Z5Xr4n5Stft4GkJ81/dWILx5fbcM/9q
         2IdFjQjsx1IKg==
Date:   Tue, 8 Feb 2022 13:56:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v2] regmap-irq: Use regmap_irq_update_bits instead of
 regmap_write
Message-ID: <YgJ2hG2vwUclA/zF@sirena.org.uk>
References: <20220119142953.1804-1-quic_pkumpatl@quicinc.com>
 <CGME20220208122955eucas1p2d4e32f51224242e9ebd0bce58b9c04ca@eucas1p2.samsung.com>
 <39f1b598-58ca-1e3d-3065-8dd692ee7c9f@samsung.com>
 <20220208133957.GC112838@ediswmail.ad.cirrus.com>
 <20220208135036.GD112838@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SM0t/lOK8BmL30Jc"
Content-Disposition: inline
In-Reply-To: <20220208135036.GD112838@ediswmail.ad.cirrus.com>
X-Cookie: This is your fortune.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SM0t/lOK8BmL30Jc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 08, 2022 at 01:50:36PM +0000, Charles Keepax wrote:

> Apologies for the multiple emails, yeah looking at this I think
> need some more information on how the hardware that patch was
> addressing works. I don't quite understand what was wrong with
> the old code even in the inverted case, the old code wrote a 1 to
> every bit except the interrupt being cleared which gets a 0. This
> feels like how I would have thought a write 0 to clear IRQ would
> work, you don't want to clear any other bits so you write 1 to
> them.

> The update_bits is really problematic as even in the write 0 to
> clear case, if a new interrupt asserts between the regmap_read
> and regmap_write that make up the update_bits, you will clear that
> new interrupt without ever noticing it.

My understanding was that they'd mixed interrupt handling in as a
bitfield in another register.

--SM0t/lOK8BmL30Jc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmICdoMACgkQJNaLcl1U
h9Biowf/We1cO8n8VT5ycGn7rnfrxsvBwTyjNR+FOsglkDblgPUrR/dQM0M4OKhV
kig/tc66n0ZF9GVi9ccsU7gX7k3iDKPaV5LH4kZvzpfApFcg2Qn1EIKWR+CkODId
XmEHkD3aIFcrEaG2v65R4gSOv9twxYSJdaUl9s7ZDmq6nB/RbKewxQsbhbzA9F4n
OyzjhEhegiSyjsNP80Kxh9ZUajYwnyp4Hx4JgJxOuJB4kSICPcbkZOjvbynHd8p6
WG2gNTsB9/W3uBIg3jOdbSI8CDxyA9YYkE+N4392Px0BGRe6xvwaGxR2OJweyuu3
c0mNQqzJJ7T4tQUNIDx1Hf6r8OraRA==
=23Gb
-----END PGP SIGNATURE-----

--SM0t/lOK8BmL30Jc--
