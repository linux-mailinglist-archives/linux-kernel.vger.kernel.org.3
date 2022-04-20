Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9713508C09
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354789AbiDTP1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351566AbiDTP0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:26:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B77A45784
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:24:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 143FDB81FC2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B52C385A1;
        Wed, 20 Apr 2022 15:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650468245;
        bh=pTegFcEzPPzXHOlhThQwB50tWAx2IuniG5QgJSoNRBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vDjy4CeioT1M/pnJcfekxFqW5ZiVgGgJ4riZPiFjYyv5YRgdNXA2FU5IwW7dEsm10
         KuO08g4r4BCEqyGP6W7+e87bzcnrszXjrjMuR+G9AAU+x2gwKyN7acwx7C+giY7iYK
         McjEEGACHuMZboB671mbAjyvYrhWbTh98YCJI9RepNSU2DO4qyAnO8m0VQQ/C/CSQz
         VUWuFYZC0KLt5+oI9olTL2IL0dLsnFSXvHuKv1cHnCMZGYXkEhesEcoOv6cFHwgruA
         Zng0osQR/cnHAQ857cuBLQ3XEggOsvi0r0GkucgosS6A1yYXgfpFeV2l2p+0FQTY6U
         PiicTLOhar3CQ==
Date:   Wed, 20 Apr 2022 16:23:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     cgel.zte@gmail.com, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] ASoC: SOF: using pm_runtime_resume_and_get to simplify
 the code
Message-ID: <YmAljQjpLCoBv+nj@sirena.org.uk>
References: <20220420030315.2575691-1-chi.minghao@zte.com.cn>
 <78c7edc3-f431-9735-238d-9aa2b45ec45e@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zeKpAx+TuuUhkCBw"
Content-Disposition: inline
In-Reply-To: <78c7edc3-f431-9735-238d-9aa2b45ec45e@linux.intel.com>
X-Cookie: Will it improve my CASH FLOW?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zeKpAx+TuuUhkCBw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 20, 2022 at 08:28:31AM -0500, Pierre-Louis Bossart wrote:
> On 4/19/22 22:03, cgel.zte@gmail.com wrote:
> > From: Minghao Chi <chi.minghao@zte.com.cn>

> > Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> > pm_runtime_put_noidle. This change is just to simplify the code, no
> > actual functional changes.

> Well, maybe that's a simplification, but we've been using the same pattern for years now.

> Is there really a clear direction to use this new function?

It seems like a much better pattern and there's been a steady stream of
conversion patches.  The whole get/idle thing is pretty much just sharp
edges.

> the overwhelming majority of drivers in sound/soc still rely on the pm_runtime_get_sync (111 v. 7).

We'll get there I'm sure.

--zeKpAx+TuuUhkCBw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJgJYwACgkQJNaLcl1U
h9ByVAf8DXE7lOFokxmahlu7hkfvPBsSrIveu11ngt9J9BUWxMgtsaM8uX7VcAEl
7si3QcSbzKxs4nTCChbLWU8ok7JZ06ArH2cKnKlDyeEC4u4nvUchV5CV3BkxrnKR
y/afCq90x9JXGnBD3UzdYDR33Myi6EQZ/mjIB3bM7Mgvf1O5ELCHruTkBdQADnTJ
gOgYg3AEGyQQCeDNJfLN4Ss8h0ofay9PGoYs9ibb0jnMP/qCfL9Z0Upo/KmfivHn
Zr9U4JasNeArdoGexSCe0Z0jyZlInbX2xqQBa03XFo6lzI2NAZzsyPSj6wprDgXR
h1QIOFvzTsQWTKbcXYd6wEIgbgI0Rw==
=qioF
-----END PGP SIGNATURE-----

--zeKpAx+TuuUhkCBw--
