Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E190957E668
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbiGVSW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiGVSW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:22:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6D452DC5;
        Fri, 22 Jul 2022 11:22:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96472622F6;
        Fri, 22 Jul 2022 18:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366F0C341C6;
        Fri, 22 Jul 2022 18:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658514144;
        bh=jbdiUACq987exJvHl+s3+P9nN0vorh+Bfj0OgaiI0dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AReaDxhZZb1Akt7qwYy0aH3YKObxOUL5KqF4Ex3UMw8dRJHu2w0NoaJDQ0Lfl2+Dc
         GE5UQVsEG8JTWj8qdKyAKcfGbt8zZPX96LQ2SUJqk1izPF5DJjkfM51fx89+oj8WVo
         lnkyWzUMtk8fgEFCIqyjk42kPibggbBGYbQMdGgHA9600JQ2/toH1/65nluXXEvY3N
         lEwG1RuGT61wwtTYnWuy7F/qXyvD7zPYHBFqyt2F4LfHWyBPE8PDJP79uCjPxE+O4z
         oqPNiZLK9S67JAUXqKwPSF8K+V7LxqROOPhrJLov/ZILkatPZHPTdDbzhUXXZppN0k
         vr7awmpWxqZ+Q==
Date:   Fri, 22 Jul 2022 19:22:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] regulator: core: Allow for a base-load per client to
 come from dts
Message-ID: <Ytrq2rVMHqedv4+3@sirena.org.uk>
References: <20220721182622.RFC.1.I8a64b707169cfd73d9309c5eaf5d43b8bc4db988@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4RMPD34dgBFK6bR+"
Content-Disposition: inline
In-Reply-To: <20220721182622.RFC.1.I8a64b707169cfd73d9309c5eaf5d43b8bc4db988@changeid>
X-Cookie: Yow!  I want my nose in lights!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4RMPD34dgBFK6bR+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 21, 2022 at 06:26:44PM -0700, Douglas Anderson wrote:

> Looking through the current users of regulator_set_load(), all but one
> or two basically follow the pattern:

> 1. Get all the regulators.
> 2. Go through each regulator and call regulator_set_load() on it with
>    some value that's sufficient to get the regulator to run in "HPM"
>    mode.
> 3. Enable / disable the regulator as needed.

Sure...  I guess these devices are just hoping that their idle currents
are near enough to zero to be safe.  Having refreshed my mind about how
all this works that's basically the assumption that Linux is making
here, that any idle currents will be low enough to be satisified by the
lowest power state of any practical regulator and we don't need to keep
track of them.

> Specifically it should be noted that many devices don't really have a
> need for the low power mode of regulators. Unfortunately the current

What exactly do you mean by "a need for the low power mode of
regulators"?

> state of the world means that all drivers are cluttered with tables of
> loads and extra cruft at init time to tell the regulator framework
> about said loads.

We're only talking about a few lines of code here, and we could make a
bulk helper to set loads if this is a serious issue.  You could even
just add some more values in the bulk struct and have it be pure data
for the drivers, regulator_bulk_get() could see a load and set it.  I
think this may actually be the bulk of what's concerning you here?

> There are lots of ways we could combine this "base load" with a load
> that the driver requests. We could:
> - Add them.
> - Take the maximum (assume that the "base" is the min).
> - Only use the "base" load if the driver didn't request one.

This feels a bit mangled, I think largely because you're using the term
"base load" to refer to something which I *think* you want to be the
peak load the device might cause when it's actively doing stuff which is
just very confusing.  If this were being specified per device I'd expect
that to be the idle rather than active current with a name like that.
That's just naming, but it does suggest that if we were to put this in
DT it should be more like the pinctrl equivalents and done as an array
of currents with matching array of names.

> I have chosen the third option here. If the driver knows better then
> it can override. Note that the driver can't override to "0". To do
> that it would just disable the regulator.

I don't like the idea of having platform constraints which we ignore,
this goes against the general safety principal of the regulator API
which is that we won't touch the device state unless given explicit
permission to do so by the platform description.  The general idea is
to ensure that we can't do anything that might damage the platform
without approval from the system integrator.

> NOTE: if we want to keep old binary dtb files working with new kernels
> then we'd still have to keep existing crufty regulator_set_load() in
> drivers, but hopefully we can stop adding new instances of this, and
> perhaps eventually people will agree to deprecate old binary dtb files
> and we can get rid of all the extra code.

To be perfectly honest I'm not sure I see any great advantage here.
It's moving the performance numbers from the driver into DT which makes
them ABI which makes them harder to update, and the peak load is going
to be vulnerable to changes due to driver changes - if we do some
performance work and manage to start driving a device harder the numbers
specified in the DT may become wrong.  In general it seems safer to not
put things into ABI if we don't have to, and a substantial proportion of
things that might use regulators are off-SoC devices which don't
generally want or need DT fragments to describe them so we end up having
to duplicate things in multiple DTs which isn't ideal.

What's big push to put this in DT rather than just make the code pattern
easier to use?  I'm not totally against it but I'm having a hard time
getting enthusiastic about it.

I think the underlying thing here (and the reason you're seeing this a
lot with Qualcomm device specifically) is that Qualcomm have a firmware
interface to specify loads and wanted to implement selection of a low
power mode when things are idle in the way that Linux does with the
get_optimum_mode() interface.  Either they actually have some systems
where they were able to select different modes when things are running
or they don't have the thing we have where they discount loads from
consumers that have removed their enable vote, either way for those
platforms what's going on currently does seem like a sensible way of
setting things up.

Other platforms don't bother, I think that's likely to be some
combination of not caring about anything finer grained than system
suspend (which especially for Android is totally fair) and modern
regulators being much more able to to dynamically adapt to load than
those the code was written for.

--4RMPD34dgBFK6bR+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLa6toACgkQJNaLcl1U
h9BFmQf/VDVtiR82Fo8H04rSNU1PyK7XtTgzpOnK4XFM0YJ878JOCKFTR/YwU0S4
Qq9s2VWCjCiJd79Fk7YW0p0q1QkGjvFU6yWCDkiC742brskSoVsK5SOy3xbZeWgN
lYIalM6WnW12zVNl02Iq5l8X6aCTjQyFrWMtOHdeTKedH4fr5EXlrytoARsq9QwG
6K5Aaf1Ys8tdO6zUkaJ7fbY9ZnsVtI4GwHC2WUYrGHHmb1suF64tci5a2IBmHYQy
HEgg1vs6FIr3D8neA3L5UL6Fo15DSxTCSfOqz4XwwLpXw6aC0HaeX6M/p2Btg2CQ
PZT/VD6Ab+MLtrPdWlgSrIz7pecoxg==
=PqLG
-----END PGP SIGNATURE-----

--4RMPD34dgBFK6bR+--
