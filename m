Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02095812E4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbiGZMMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbiGZMMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:12:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433C22B1AD;
        Tue, 26 Jul 2022 05:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EC69B8128D;
        Tue, 26 Jul 2022 12:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA59C341C0;
        Tue, 26 Jul 2022 12:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658837553;
        bh=eUo8C7N2SsgGwW0xNUNPXRjnpsdB6fbEPGxKqx9Hqsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HrQqa7usqGL/GFMz3lbqv38vuaOVkxCNd8Rr5bj9BzPNMvxghKfEi+jGKV1FZfSmH
         LIApKCUUmT6Y4rFwo4JBhRB2HdOBsV2I737AyLyuVjgsbks2rb/lmttRvPT8Jiv6F5
         wir0LXQFNlcIpahLc5Q6qVyE3ffG14+I1CpwI/xJ+SEfC0hN2vOCbgodFDvgC0rXqJ
         d5oZxKpaqgk8jMnLI6CWkzPnLiTlrY4aNgFIJo+E4LaAAf8V9e1yYqMLC577ZgCkBN
         AG09zIngdTm/ASHEi3usEm/6BWJs+sAxXaJje0K4OhPFcgtgQGfryNqlW4vt8XDAbH
         u1iEd31QW5QUQ==
Date:   Tue, 26 Jul 2022 13:12:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] regulator: core: Allow for a base-load per client to
 come from dts
Message-ID: <Yt/aLGJqIRxam1G9@sirena.org.uk>
References: <20220721182622.RFC.1.I8a64b707169cfd73d9309c5eaf5d43b8bc4db988@changeid>
 <Ytrq2rVMHqedv4+3@sirena.org.uk>
 <CAD=FV=U-qZQwRdLA8AVwYdcuj_PQEULTnhm3osFybaFmtvjmHg@mail.gmail.com>
 <YtxHwUe4W7+u3Lk3@sirena.org.uk>
 <CAD=FV=VhPHFB1T_+r1mmtP=r73ggmcWvwPqw3E-_foVTvtTkyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TGLVgNG1pqmleHM5"
Content-Disposition: inline
In-Reply-To: <CAD=FV=VhPHFB1T_+r1mmtP=r73ggmcWvwPqw3E-_foVTvtTkyw@mail.gmail.com>
X-Cookie: So this is it.  We're going to die.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TGLVgNG1pqmleHM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 25, 2022 at 05:31:34PM -0700, Doug Anderson wrote:
> On Sat, Jul 23, 2022 at 12:11 PM Mark Brown <broonie@kernel.org> wrote:

> I guess the answer is that if it's a micro-optimization then we should
> be ripping more of this code out. ;-) That would go contrary to
> Dmitry's request that all regulators have a load set on them...

I've not seen this request.

> > To the extent this is needed it does smell a bit like "these
> > regulators should default to setting their load to 0 when
> > disabled" or something more along those lines TBH, some of your
> > previous comments suggested that the per device loads being
> > specified in a lot of the driver are just random values intended
> > to trigger a specific behaviour in the regulator but forced to be
> > done in terms of a load due to the firmware inteface that's
> > available on these platforms having an interface in those terms.

> It's actually _not_ the firmware interface as far as I can tell, at
> least for newer Qualcomm chips (those using RPMH). The firmware
> interface seems to be for modes. See, for instance,
> rpmh_regulator_vrm_set_load() which translates loads into modes before
> passing to the firmware. Ironically, my memory tells me that Qualcomm
> actually said that this turned out to be a problem in the past for
> them, though, since some rails went to both the main apps processor
> (AP) and the modem processor. Each could independently decide that low
> power mode was fine but the total of both usages could bump you into
> needing high power mode...

Oh, that's just completely broken.  The set_load() support should be
removed and the drivers should be implementing get_optimum_mode(), it's
actually got an open coded version of it in there already.  That'll only
have snuck past due to being hidden behind a layer of abstraction that
shouldn't be there.

> consumers") but is still instructive of Qualcomm's thinking. Taking a
> sampling of the loads in the tables in the DSI driver / phy, I see:
> * Many specify 100 uA.
> * Some seem to pick based on throwing a dart at a dartboard. 16 uA, 2
> uA, 4 uA, 32 uA, etc.

The load for a PHY is going to be immaterial when you're driving a
panel.

> If we happen to be using an LDO that changes over at 30 mA, though,
> these ones _could_ use LDO. I guess this is where the whole
> "specifying in uA" makes sense? If you've got a regulator that changes
> at 30mA and only one ~20mA consumer is active then it can stay in LPM.
> When two ~20mA consumers are active then it needs to switch to HPM?
> Having lots of consumers on a given rail is really common w/ Qulaocmm
> setups. On trogdor, rail "L4A" is all of these:

We specify in uA and uV partly to ensure we never run into the bottom
limit of resolution and partly because for loads uA is a very relevant
number, as you've noticed it's where things tend to transition into
their lowest power modes and it's also commonly a relevant unit for the
draw from devices in idle modes.  Something like an audio CODEC doing
jack detection will probably be able to get into a low power mode for
example.

> I guess the above doesn't really give us a lot of good answers. :(

All the load setting that doesn't get passed to the firmware in the
regulator drivers should be removed and replaced with get_optimum_mode()
operations, this has no impact on the client drivers and removes some
open coding from the regulator drivers.  Load management in client
drivers that doesn't go below say 100uA is probably noise but it's also
fairly harmless.

> Perhaps the low hanging fruit is to just accept that the current API
> of setting the load is here to stay, even if it does seem mostly
> pointless in many cases. I can submit a patch that adds the load to
> the "bulk" API and at least it would clean up a bunch of stuff even if
> it doesn't fundamentally overhaul the system...

Adding loads to the bulk API would also be useful.

--TGLVgNG1pqmleHM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLf2iwACgkQJNaLcl1U
h9DxSAf+LyrWONzhha2QylN/IYuT7xfNRe9hbsT9qcvzoEOQR8UuUGTODKyF1afZ
IsmqzM2dC+FhP8v/SxOUpuXEF454qGZBVo3lU5n08oTfc9YXF3phf8dp97h822rt
OIGlQIVatahkTuB5SfA2KJTwxte5/cHD+s/H4Eo7RVzoXvPjb7h1DuuWwBoUG2bt
pGqLtiRwTDSejifL6L5IF56EOZw2VlX9Tuiv31nisESEs9u02iDdG4NAAWEikuvz
zS/WiiU1Zo7+LCG1JzyWSrcTbvNfxZOtD5bGPsHfYfKTG7rX0ghAiApDTLgRh53/
TfgHgQUnhTyLElQIAViKcOGFWaQNZA==
=AHFI
-----END PGP SIGNATURE-----

--TGLVgNG1pqmleHM5--
