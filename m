Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8514D3C75
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbiCIV4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 16:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiCIV4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:56:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B6511D794
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:55:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74C0BB823D3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AD0C340E8;
        Wed,  9 Mar 2022 21:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646862945;
        bh=MuDIshP39Br99xho8WFrKVoD0zrBHzj1OZGvd8WCq9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t1gCQRJLMDxzIzqz/1u7k+UazThQSU2vrcVVD4ZhPd8Jvw/GhrfDLZ6EYdvclBJ8H
         qPs7wlOzq6zI+Ij63Gk+4cAGZLMqazSoAN5/3ETpIVvR7tb3D1MFGCDq68MkNtxUXh
         qsaaSvb+VYx7NoGAlkVo/4Clmo3Fp8FUky4K7k4MNeejazgnB3kr7PY7PTGdnCN/In
         0w3dSONuUduyeUk6ZeJplwHGT9rp1b6Y0EMWpV9/GHs4c7WKMw36GEq8X1WIhFwCSQ
         +zUSmq0nhIN4KO60oZmDqMU/ShLHuRnD3od++zDSFBy7MMPcKWX3EMqPTqO55EMW//
         51sKL0IEJWsgQ==
Date:   Wed, 9 Mar 2022 21:55:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Keeping <john@metanate.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: tas5805m: fix pdn polarity
Message-ID: <YikiXAseSiODXfrD@sirena.org.uk>
References: <20220309135649.195277-1-john@metanate.com>
 <YijOHNT0eqDyoviP@sirena.org.uk>
 <YijTk0/UTXpjFiRq@donbot>
 <YijVrgZ+Ysv9J/8E@sirena.org.uk>
 <YikLB4+xHVxjFTSL@donbot>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZKks2OsGuCQev9Ka"
Content-Disposition: inline
In-Reply-To: <YikLB4+xHVxjFTSL@donbot>
X-Cookie: You will inherit millions of dollars.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZKks2OsGuCQev9Ka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 09, 2022 at 08:16:07PM +0000, John Keeping wrote:
> On Wed, Mar 09, 2022 at 04:28:30PM +0000, Mark Brown wrote:

> > I think the device tree binding needs to be clarified here to be
> > explicit about this since there's obviously some room for user confusion
> > here.  We can probably get away with a change at this point since it's
> > not hit a release but we do need to try to avoid the situation where any
> > other implementations use active high polarity for the bindings.

> Taking a quick survey of the other devices that have a pdn-gpios
> property:

> - tvp5150 is correct with the driver setting 0 to make the device active

> - tas571x also sets 0 to make the device active

> - ak4375 uses the opposite sense setting PDN = 1 to make the device
>   active; this has no in-tree users and was merged as part of v5.17-rc1
>   so it's not in a released kernel yet

Sure, I still think it would be good to update the binding document to
clarify things as part of your patch - the binding currently just has it
as the "pdn" pin not the /pdn pin or anything.

--ZKks2OsGuCQev9Ka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIpIlsACgkQJNaLcl1U
h9Asbwf/RncZY+eDETa9auGKTG01BmxAnoDpzRDq7suQvQyj54crfKeGyObcPJP+
6piYIybg415u2HwVlAiwLjbpXG8wAXlIP961i4Ut3cGrVUTPouNnQ1o7Bnmr75nF
7ptyqAn/omiQQXboNqNV1sfbY6iJAp/aLhp8B1YW2wN3gsV9H7rlxxv8iQL25yhY
aorj75FwexEimCL2krC986NcgkLKzD06VvocOTwFU2j4WuMUptL1SEDFCQs/nA/q
3ZuYat93gmViagMoc0Xy+PRy15irGVeXdgSW2NfFdc7HC63JN0LaYQUNgqRbu1Xx
BT1WMKFDaYfePaBxptW/t6h0bpm4Vg==
=xjx3
-----END PGP SIGNATURE-----

--ZKks2OsGuCQev9Ka--
