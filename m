Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2CD5A9523
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiIAKyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbiIAKyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:54:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D01130A12
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:54:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEF81B825B2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B80C433C1;
        Thu,  1 Sep 2022 10:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662029670;
        bh=3yd6ra6HeRbyp75OC+9QeS3r0P/aVZwXcQT0DOYQW/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gO27tA/NvMCyftcMv/ycmh1rfMdMU/8TJIGvcF0k+tZn2xzciubBUbXGtEyrp3SkR
         VWhoaMVDsJn+MQLy/RRNf2C5BE+tUHuu1GoL8YiBb9zZ3TPjGUbad3Vco5tB6waqt9
         SOsR6TIzA5Or6YRva3rcjbTMsm9WVSZLh8rbGcbpStlDGXKFHJDPUMGRX79eberaRg
         mhj9m+kBC1OsPU4AkfhEuH8dtoUGPgePG3mCLiW9o9ayfX0pn8/R21/drjRJFd95jU
         6pdL6vhvsP+3ZGGxchD3dVHj5mETS9waNIE+Sam694W61mMOs0OiVcBlxbJJiXKiNj
         V4GiPQ+PRFirA==
Date:   Thu, 1 Sep 2022 11:54:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Steve <steve.lee.analog@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        krzk@kernel.org, ryans.lee@analog.com
Subject: Re: [PATCH] ASoC: max98390: Remove unnecessary amp on/off conrtol
Message-ID: <YxCPYbPsEyZmuHOI@sirena.org.uk>
References: <20220826023504.6183-1-steve.lee.analog@gmail.com>
 <Yw+OCnOgYUOWdIEx@sirena.org.uk>
 <CA+Fz0PZStYOZhNpRQCCVKxaDmPPq_PwvWrxfWbq=sBNKrZzzNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Cck+RFJ0eKZVFr+e"
Content-Disposition: inline
In-Reply-To: <CA+Fz0PZStYOZhNpRQCCVKxaDmPPq_PwvWrxfWbq=sBNKrZzzNg@mail.gmail.com>
X-Cookie: This bag is recyclable.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Cck+RFJ0eKZVFr+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 01, 2022 at 02:57:19PM +0900, Lee Steve wrote:
> On Thu, Sep 1, 2022 at 1:36 AM Mark Brown <broonie@kernel.org> wrote:

> > I can't see anything which ensures that this is the case?  Should there
> > be a check which returns an error if the output is not enabled, or
> > should the function check the current state and preserve it at the end?
> > I can see that this would fix problems with it being disabled when
> > callibrating.

>  As your comment, this can fix amp being disabled when calibrating.
> And this also fix the case that music play right after calibration.
> Actually, calibration process should start mute playback before
> trigger this function.
> AMP disable/enable control in calibration function can break sync with
> userspace enable/disable control.

Right, so that sounds like there should be something which checks the
current state and doesn't start callibration unless the device is in a
sensible state.

--Cck+RFJ0eKZVFr+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMQj2AACgkQJNaLcl1U
h9DP7wf9GATVAcXHSK80KY9ZOA+wsUyGyhrWjapV4h1Cs8h62KfnYLN+9v64Qkfj
j1pfKF+FSvEmfd7UglMjhIxPLvpY6nkBrprGFxGonBKJkPN/B6eQXpHJropn0hgU
zSgyVWNexi/JQCdRZlzGKq2eZasgSUr30XbmTo+IS0+ZOVjnYpbOu6bQgWw7Xcpb
CiwCyQympPrbatTJjcksnqpxIILphXddI854GV+6JDro0Ff+sVwh/Wy9KlpmJTmO
zQ3UeW/1ikooxqlk1nuAXmUQbwF71zaF4MBXfwih1ZOiuRCRUqHOSatHwXQDyfjY
iXLCGJBx6yVVMbRp0emPUWNdN3Vu/A==
=O3of
-----END PGP SIGNATURE-----

--Cck+RFJ0eKZVFr+e--
