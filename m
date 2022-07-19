Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F2757A0FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbiGSOPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240633AbiGSOO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:14:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20D963A5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:41:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8853EB81B29
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D8BC341C6;
        Tue, 19 Jul 2022 13:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658238113;
        bh=xpmAItw3j6z0Z2ufTVRbMBX48ahXFFpIiSsn+ji1FWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P+PXYxV8phsDATh0weLewsNGKFW3KZ7D60I3bOFXz6/kZSbG52g/zvSxbtP45uyux
         wB8euJO4lIpneglM94F3G0QeFWGl6DAh9mcOGQdToUKC842WSrXh+FEpEB7DPBk+XR
         5zqcKBchcMam2f3nQOg8ODGs/qYlxBy27HPtQwRJ+CFMI6GEWn9qduMhrgk16Idd54
         o7obPc75+fGmYHXZQotSliOdzzuKBInfoOfu9Log6HciHu1xaKwv08gAN+9PxXneGS
         ORzGnIfLGXY2aDcY4D7O5kVVL0l9vG8NzBGM/MFSsphXBQKDou1GsO6f16HSdB+B8c
         LtQRZYe7Mplxw==
Date:   Tue, 19 Jul 2022 14:41:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] regmap: support regmap_field_write() on non-readable
 fields
Message-ID: <Yta0nKlqOcimEH/Q@sirena.org.uk>
References: <20220719121446.375095-1-krzysztof.kozlowski@linaro.org>
 <20220719125401.GA92394@ediswmail.ad.cirrus.com>
 <d04ef271-9404-481c-f2fa-268ff51ee3dc@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LPCk4JivcwLEQilO"
Content-Disposition: inline
In-Reply-To: <d04ef271-9404-481c-f2fa-268ff51ee3dc@linaro.org>
X-Cookie: We have ears, earther...FOUR OF THEM!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LPCk4JivcwLEQilO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 19, 2022 at 03:13:11PM +0200, Krzysztof Kozlowski wrote:
> On 19/07/2022 14:54, Charles Keepax wrote:

> > I think this will break other valid use-cases, regmap_readable (I
> > believe) returns if the register is physically readable, however
> > it should still be possible to use update bits if the register is
> > in the cache even if it can't physically be read. So really you
> > need to fall into this path if it is readable or in the cache.

> But what type of real use case this would be trying to solve? Either
> register is readable or not. The presence of cache is just optimization
> and does not change the fact that we cannot read from register thus no
> need to go via updates.

The original reason for creating the cache code was to simulate
readability on devices that have no read support at all (think 7x9
format I2C devices) so we can have things like helpers to map bitfields
directly to subsystems (like ASoC uses extensively).  The fact that it
also improves performance when the hardware does support reads is nice
too of course.

> > Which does I guess also raise the question if your problem would
> > be better solved with caching the register?

> And how the value would appear in the cache? Since register cannot be
> read, I expect the cache to be filled on first update. First update
> would be read+write, so we are stuck again.

This is one reason we allow cache defaults to be specified (it was the
original reason, we later started using them to optimise out I/O during
resyncs).

--LPCk4JivcwLEQilO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLWtJsACgkQJNaLcl1U
h9DDUAf9HVq4iupP9DvUmmCmN7dpmEHO/ZkLplo64y5FPLt3wzjLBgqw6qSsGcqO
cPreXQqaiqB8LO7oPRG77kkNEiIMorUS6marniVKQbaBiLEnz+QJb7cQo/X+bv2f
2PXJHrc9IgZ/+YyeLxZBOFpWIQtArAbni8gaU6yLO+RJD9yUX5++WD8AQ5h1TmjG
VWI5ZTWxkh9+46UxvEHhUTabxhdPIqEW08IUwNfIfd7A1OGsIj+WdnkDaCCjEd2c
HCbYE6DWlqoHAJlyFogJKFP7wM4rvxl1UVHMLtfQVJb1dmQLRT45bk9uD5xi3I61
szLKDzpWOjpH6pGJi463c4J0mH1BEA==
=xfFA
-----END PGP SIGNATURE-----

--LPCk4JivcwLEQilO--
